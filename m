Return-Path: <linux-pm+bounces-18305-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2983D9DF50E
	for <lists+linux-pm@lfdr.de>; Sun,  1 Dec 2024 10:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 462EFB212FF
	for <lists+linux-pm@lfdr.de>; Sun,  1 Dec 2024 09:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C297081C;
	Sun,  1 Dec 2024 09:07:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020130.outbound.protection.outlook.com [52.101.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1112CA8;
	Sun,  1 Dec 2024 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733044027; cv=fail; b=s2EizSigR7Xgr45dqCOCmUHLvQPX/xE3MilI6LCniG9cbGwW/2URavMPgvfRFtYeEQ+ISxS17BYJ9FwieyL+C4TkSVlcgxYzVg5hJNmB1f3C7fZB94FIiPN6zc7N50Ayv8OuZdAt3ogAao57rTz+1fMSa/rZS2gHbIpJ3Or+uSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733044027; c=relaxed/simple;
	bh=vfZCGoiEG215qjA/aM/38YRRSfjTMKBYeXgLycu8VFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MxxFPoZZ4teo6/dXajJ6Inm8WUc69ZRL7PfkPGWY1pAbWvYun2hFOOSrZq2yOC4kYc41+m3TdbM6jAQU5Tc2crF0YAw3jSWCXoxmkPdnpti3WCefTOsv6FpdmVZXjcDDUpRWT9mQPEaEx/Ee5iRXfQwxlUAAsJWKfUkjWASfSPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=none smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=siliconsignals.io
Received: from MA0P287MB0329.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b2::12)
 by MA0P287MB0201.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Sun, 1 Dec
 2024 07:34:42 +0000
Received: from PN0P287MB0727.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:10a::12)
 by MA0P287MB0329.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Sat, 30 Nov
 2024 21:37:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDWO6ztyNEHSEzG9e8STbN5Zj0S1hOQWuT03JXZmib3RJkCOUIlW6o3pckUjXdqeMMArW3OZeWAj1JCC8YGDWGkEQHSXlIRhB6d9fIC6G/h5k0aa11VX0ePC3F//0WcJKII3PrDALCOI/Tdjy4+T6xnaPhhDgDQHB9hv6PK9c6G47GraRw3jE10g8FnR02yH1Z00FpLhxYwjaL/QTy4q7pI4EcoJH/HhQeGAXxhTFgA7AoiElY+Z3YFZupYUfGpqmSmG7ZKwn9PHy9DLHErh4wYf2BrDg/UlFSAY/uW0vZe3mpu0yDo0dqMIPiRzLjIcoW/itMa9E20M+hPaaHbQNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfZCGoiEG215qjA/aM/38YRRSfjTMKBYeXgLycu8VFg=;
 b=LsMsscrLL5Y+bB7FB2vJjCI3OUXT53XxvFpG2necUP2e0exBQ+x9RdjTCwYk5m0Jwcb3ZcJMrlocAe5Pjf2UfHBsJ4muA0R4Ral5g+Gi8rG8ejv3KIS5WB//eoGXqnwpTPZEcUiIkPNfhN67cya1ZraYZIyWem0Glagao9Q/opqQeo7ZegtGOJebsIb8fzQ69QCQR9eUGhPhw70XT+9ijcUTxfADW7u5/RTjfEuw/u63sS1NscDj3aihk6vxV3R7njTjOfNSmdNJUHGQ+89psJEb1eXZn6832/Y6/x+M4f9Yzw8f89lQFAAiGlcIs/ge98LmlLwsF0EFlfWXxeBqwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fc::7) by
 PN0P287MB0727.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:10a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.16; Sat, 30 Nov 2024 10:27:36 +0000
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2]) by MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2%7]) with mapi id 15.20.8207.014; Sat, 30 Nov 2024
 10:27:36 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "sre@kernel.org"
	<sre@kernel.org>
CC: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>, Rob Herring
	<robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/2] power: supply: Add STC3117 Fuel Gauge
Thread-Topic: [PATCH v6 0/2] power: supply: Add STC3117 Fuel Gauge
Thread-Index: AQHbQwyp0ObhFowZTEG8GOyU0oVtpLLPnJVC
Date: Sat, 30 Nov 2024 10:27:36 +0000
Message-ID:
 <MA0P287MB1178F3C2E8A8797EF26EC71BF22B2@MA0P287MB1178.INDP287.PROD.OUTLOOK.COM>
References: <20241130094531.14885-1-bhavin.sharma@siliconsignals.io>
In-Reply-To: <20241130094531.14885-1-bhavin.sharma@siliconsignals.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic:
	MA0P287MB1178:EE_|PN0P287MB0727:EE_|MA0P287MB0329:EE_|MA0P287MB0201:EE_
x-ms-office365-filtering-correlation-id: 7df76867-a502-4589-38d1-08dd11299bce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?o9LWD78xxrPbvIiin3rjJmjlPvhvLJan3StVCE6m9o6IpAFobEuPq+0bIw?=
 =?iso-8859-1?Q?JizBQfxJ9zU27d9oDR2PW8UU39WgS+tzeIcFUE5zP2q2EdNRj06Z2wxFlK?=
 =?iso-8859-1?Q?3fSf2mKnvC3avHOctwOi+kLppZwQ589WaUMBeVM4TBx+YynHRkX0UDLkUn?=
 =?iso-8859-1?Q?aneq/cB2Tzi5A8WGYc9b7MIwkeDK1M0QlrsjmXf8rvrhu2Zh+bgMhJdiBX?=
 =?iso-8859-1?Q?ZB5f4xcZmsGTVuB/u3+rIfVbeURwIt/UeFeqgMXY0ku4K81JWn/sovkx8x?=
 =?iso-8859-1?Q?eyn3PCQNlg4RLqRh4Yd1JMYdIf2v2ScBbyPQAohdpiCiCQORKGP0A99bVF?=
 =?iso-8859-1?Q?8m5zB3usncmOarys6hweNhC4Dd5GahIf8IJVPLu8oyzOkPrgfCHiUKg1ha?=
 =?iso-8859-1?Q?X3xa92lfYrBuV2G3xgXM8s04V4h8GyK4li0cT2arTIsuzE0k/vq6sgW6MF?=
 =?iso-8859-1?Q?dDSkDQuoIGseclF9mk9d8x62DHZDoysqljWg8hgwr8No5+8LPPTyfo4EyT?=
 =?iso-8859-1?Q?ZghkhH2gS8rJjCIPvftM3HWoIGb0jGhTq/4wqhpsL3Ubcye3XFzyo5rJ7S?=
 =?iso-8859-1?Q?dr66uAujbGjhSPu0eCb7PDPPfT0KZaX4YxeVOXDrMueLaSj5byIEO74DAK?=
 =?iso-8859-1?Q?qZuYp1tiV5RzCjubkqEgChLLvN8kg7i3Gq730nEZVSjDwVNZTumC1fJCqZ?=
 =?iso-8859-1?Q?0eT2oUW5XIPIyenUQL9M5D0rgz7vsAorVHVeieQXbHXe+qvRhalEWOyMFs?=
 =?iso-8859-1?Q?H9lQ6pAxjQcFDlFgkQxKwDR9QYRndspqykwULkcbB5qOO0S2Uq6D9V4kZu?=
 =?iso-8859-1?Q?AcWzx7eKZ1C24NYNvyMChSZDO/xAPUc3yGaF7sC3ZGOqpYIxipYNnLarm0?=
 =?iso-8859-1?Q?IzuQ5i2RBOhy2tNh4m7XKYIb4bTFFAaZmzcHtHJHUJx7jJmN9RsX2y+6/L?=
 =?iso-8859-1?Q?qCyfc/ttqZgVrOr4l0r+CxjfDs+ZRjVJtN/fAmFU1JbXy+cfhSA+hHbMk3?=
 =?iso-8859-1?Q?eAH5Otv1aUwJi2QQEFGMDYIUSqx7Wq1YjK593u6AGT22csNRFJVV4HmW6v?=
 =?iso-8859-1?Q?V6zU3p4JpPKbw0iT2s7/2318ABqJ1D48WsU4AthGyrcL+PkITmi565Nz0d?=
 =?iso-8859-1?Q?fwDqZlUPCRpvqQGknGRZ4WZhEQUpvJKgozpBFZl/AwRN7BmplH5lK4B0hp?=
 =?iso-8859-1?Q?AK9662YNCjaRHFbLsHTvXY7Ww1rc3auq8oal0nhiaBo8m2kfP9ahKVuXBF?=
 =?iso-8859-1?Q?8iR40lgW6AWmhb74owY+EzvgdoRaJfOcOTx0iUEHeIUCxslk4AJrgFr3XO?=
 =?iso-8859-1?Q?DP35ZDk40k1ZtCWRhEYermzQBfMti1CU4O1ORArWd3WqUx1zCKmI+L6F3U?=
 =?iso-8859-1?Q?PDkaI05rTy7mOwTomCFawCHVsAhZSpGbcTVoVkUuNMOtlhhL2HovFIEdb+?=
 =?iso-8859-1?Q?v/T1wOP/vhWr0Fi2CMKesKkhFkW0B7b1670MLA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB1178.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CUQdfL9ysdp92yTHBtwUmN5gfoMX/mARYH1fTZmbNQ1Y4cUt7d1vsWLz0+?=
 =?iso-8859-1?Q?Gjzh0mI+3XiSRsmAoGFr5XetZbyJ2B4g6CBleA20dHrTncvqxQWeqA6dwi?=
 =?iso-8859-1?Q?ubaGLYCfzMMM1aMeBOZujGQfduUrXqOoAIS7cHo74Y/YOuFkiT+zDtP9Gb?=
 =?iso-8859-1?Q?h/aOHSr2vvWKPqKDUZMQrDr0vEyDwBaFMOJwNgwiLmuhU0FQYLgV8GnDsr?=
 =?iso-8859-1?Q?o/uJonpUNC+HqdXeojNkGGfbujdsA/xfsCODqluY9t9xeldFNKhGAsYvu0?=
 =?iso-8859-1?Q?rXilPn+DhdtQNg1ZxnYEQDH+zhlaFapko4BknooYGzGBEMttiniPYJiYLT?=
 =?iso-8859-1?Q?0FwGCNoo+d+082uB8nN+MzhPk5bZwhLlSE77iWJooIgJSgASXfbsCQdiY/?=
 =?iso-8859-1?Q?KRrOA3bP0/xxGf2w6F5smNMR8ScHwQcdwLSz2X3KP9BSfUgxS/17IXZ7PA?=
 =?iso-8859-1?Q?x6dRQTENANAIrs0Oo1xiExSVUeCEGh9WyBBxBlAXd++hoYz02IY1LKNhqB?=
 =?iso-8859-1?Q?/fL9quV+Q+Qzgj8Agd+QnchjVDPNMuYHVxLLvSjPOyH5SJ4heHlO1a+ebw?=
 =?iso-8859-1?Q?9wcStOCSsy91RyGEZ7rawsvTCWmWyYdR7mpPEd+XyHj8479jIiWQq6tGln?=
 =?iso-8859-1?Q?ZIJ6wE74LldC5KFqkTeqBP+Y11MmSpyjV5ohKrqeSPKs8kq5uXQGxCiHzS?=
 =?iso-8859-1?Q?2teoKnCrLDJij5WOb3VbhqhAvZD+usiaLj77uWTxkEyhHWYGCW7CGkyYvy?=
 =?iso-8859-1?Q?NJMte8XlL0nONmCjaYmgfGNkBp3ZcvCqFmboY4osNmHTsQzCt3c/9HOlIl?=
 =?iso-8859-1?Q?jExCOFoROAJAOgV9lL5ANsTbNafrYzqHzq+jdPTfj4cXNTFgo3Mp+2ov38?=
 =?iso-8859-1?Q?cBoemt7YVf9zRFnIsf7eLDAUcj29ASPU26LtLYft2yZWisn3cidoeDiXRu?=
 =?iso-8859-1?Q?cYYeqrbP0OORg61jx+gk11cuv38Ihpp3HbdxgCXoJaLXxTMxyazBB243p/?=
 =?iso-8859-1?Q?70RHVrrNFpcvxIDJrTxIgyzvCQRzf0ogTVzxEe+JRPzH+Kf7DV0vcnYaOh?=
 =?iso-8859-1?Q?lqE34Ujb4BIBopJKPDG1AMHQu741vjJpKT0WgMK8iWHQdhTjayf63W8o1N?=
 =?iso-8859-1?Q?l6Z44dGzhoakScbLceMwcRsNngJnePiwLg00HeSNyVtyYpVE8iz9TT4px5?=
 =?iso-8859-1?Q?YLJf8STqq+NHisEZKCvnFhQgKvwAmHPmNJVPnBYPMGkjaRatzge08l9XzH?=
 =?iso-8859-1?Q?Z+5vaLaCr6ssf8I5INHZgTP48dOPdiGWJr3x+oDOcpwwayAYLTJrUzrw/A?=
 =?iso-8859-1?Q?lLsg+EdCjDCX3yVa9mGXuKijhVJyVbFA3SamB8mrNHbbYUhhY3QKGrJPxy?=
 =?iso-8859-1?Q?VUK2981RE1cHCeU2+lmw9Lv8QdBtlQh/JjAOS04DTVjx7ou2N0x8UvAfvo?=
 =?iso-8859-1?Q?pSFbYCJGLi+DXqfzh0U0TyvjpqkelUEpVTLXjRzdUhs7daL516gZ1f2x2B?=
 =?iso-8859-1?Q?bL2dq053N1Le+QnYnyQEAVL+OGwIiJyMuVS5oUjUacbrJ+snN3JFY3FIyF?=
 =?iso-8859-1?Q?WJdSEwOLPZwdPPyxVDkYtRbC5SXFQwEuc310NJoEZ4b0CUaOX2Vo87ru1y?=
 =?iso-8859-1?Q?EjhR8xVnrsG9gY8eGZ1J+tRuUZzjQ22c9oRwpXYi2v7nIfuyCQnEg5Pw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df76867-a502-4589-38d1-08dd11299bce
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2024 10:27:36.1277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SVUm1FO4kwBOXayAXIJq8SXMlKb5Z1/L10oQJ5h232GpQ+Gek/SFFWLKqaelk7ypTlTfP+LV2OOiG0stX4/sn4AxPqdY/JpUH0chaXBlb1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0727
X-OriginatorOrg: siliconsignals.io

Hi everyone,=0A=
=0A=
This patch series has not appeared in mailing=A0list. Could you kindly conf=
irm if there=0A=
are any issues or delays in its submission?=0A=
=0A=
Best Regards,=0A=
Bhavin=

