Return-Path: <linux-pm+bounces-31765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C89B18432
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 16:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224F25873DD
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F06E26CE2B;
	Fri,  1 Aug 2025 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oAuhhbPW"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF5926CE3A
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059817; cv=fail; b=SOdB3CpeVzYIkLVk78twW+Eo1kNZ7FShAvvCGMBMjbnBMpyelZL1/w6rFDQxyne6V4I4m34/HAqHpBTccoNSoORwFQPKwT8qva9pAQ8v2/93dnAJnYzvifzAygJcJLlotdNuE17JW2CY+hKhTRb413z2XloCllJy2CWXR2Y3c8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059817; c=relaxed/simple;
	bh=Q+kDHhCAKLTCXyUkC96YuzS5Sqhe3YX5Pwc5dwcOIZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JWmv8pNPZEBomEhivMqi5Sqw71hWvas75ws8VH8m23Nrh7tUJZsJVBBsG7Xft2wl1KCPbsroOaDV/yG6JeKluTOHVW1RFGMzLgAay9k8YtLkdKnHqqhK9tQ25vmG4hipbrqUEJVCke717WyEy6ThzOclLibLn30TaXmxd2AANM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oAuhhbPW; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwpUi3yFRh9HTzv/p/InAJE11MFLnhsIGyV0NdzGTecEgF88jTyvt0lso0kJQ+8U5ZVUbCvmfBw5QbZcr+23DyQ0VaocD9WKhQxv+fbRL4ZqNFWWkmzM5GwZui2GeKLaflxFUM/xd9go3F6fOFxrGCXoeNKDw9NJ7VWmQPk2ykJFLFv9LubaOBCaOUFA5mNqRgJOCms5A1JbpgQax9KgcONCY9T5UdJL1JVkVQ5vxGlQDfL+GPVbf6835sxOx9E8mXJfKOQ+pxRepRJx759gavZ0zr+Z1Ij+WvRT4QDi0wweOCZE37rIGPZcKcr2LMHUH+9r2mtCRwzU05BVJaue0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwyVZclnz66S/FUufMMfmAXpPDGFNczrVpNe8PrbwHE=;
 b=mss3imIKYy2MPUlCpi4vQJlKVOtIQat0WgmDdAc0yNUy1t0Q4Z7MnHj/sSCPhkowqzBL0hFq8qrffzQxB9YbupW8wCrcbeg9qJbjuPTcgbYxBSNnWc7sD8famgAnCzVBmOssxK/SXh/LTg8nrbNs2O4xFMcBNrqtoReN96OCkqSla4CgrOwlRGi6DDOSC7FsvNoN02b6CDBNE6xp1sHOZL/MIzq3uXWyG1kJK/4CSGFHIQ0eFu1cd42FE5WvQGYrieyTWVyUBm8bB0hjXXxtUGPUUfwSqHGP22WLORzl7XrXvQlkcnloGOTxxyGYKOmOZ1w9bd6s7JyfVZDeHcXr5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwyVZclnz66S/FUufMMfmAXpPDGFNczrVpNe8PrbwHE=;
 b=oAuhhbPWu/HlB/ZzSmMKDxdY9/nfv0yd+CS2KpcyhyThrfe2re+AUglZHxQZyaYmqDK8hbO89tAp+8vW758LNCYPsR/vmY19gLqystJnBVJI/WTPzQCAnO6UE2YAq9Ji3SCdy1+momMAM8Gvfv1p5Jw8x0mBm01pci+V87KvbQJygn10m6jk0VDxUmAPhQW+B6WvrfjKwp7Q/1e01zHbYx4yi99l96iA0cBpl+NH3eT8sKx0gkwGVH0Rjtde/0EsNrY5TQcXlJYCk5OFvE6u3meNeT3485rzFKKw8nseTbLu8PgdkET3n+xB0u8YIQMZIN3wfU1LlmovpzdfnvWbrg==
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by DBBPR04MB7978.eurprd04.prod.outlook.com (2603:10a6:10:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 14:50:12 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 14:50:12 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "krzk@kernel.org" <krzk@kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"rui.zhang@intel.com" <rui.zhang@intel.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>
Subject: RE: [PATCH v2 1/4] dt-bindings: thermal: qoriq: Update compatible
 string for imx93
Thread-Topic: [PATCH v2 1/4] dt-bindings: thermal: qoriq: Update compatible
 string for imx93
Thread-Index: AQHcAruCK9AVRi8T/0uCABEvdDU5/7RN18oAgAAJimA=
Date: Fri, 1 Aug 2025 14:50:12 +0000
Message-ID:
 <AS8PR04MB8642B73F48F7D0DFAEC9E57B8726A@AS8PR04MB8642.eurprd04.prod.outlook.com>
References: <20250801081119.1999298-1-ping.bai@nxp.com>
 <aIzL1L6zLuhy11pT@lizhi-Precision-Tower-5810>
In-Reply-To: <aIzL1L6zLuhy11pT@lizhi-Precision-Tower-5810>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|DBBPR04MB7978:EE_
x-ms-office365-filtering-correlation-id: dff24aca-0ab7-41f0-afe0-08ddd10ab7da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qJX/++ws8lArKGOme+biKXxJ6IlTZhJ17jrVEnlS4Z6wuP378+D9cj4xkXdZ?=
 =?us-ascii?Q?GG7N5hdcHLVdc+A9+xXlG+2oW4oJRs2vCBSjy0Is5UmjK6KEi3Q9CrSRhp4v?=
 =?us-ascii?Q?1xfVXOesOZADGjBy9e6d/qCBbsBwK+jzplEUL5+H57VlIR0xUbNIOx+z3hzu?=
 =?us-ascii?Q?5W0bFK2+jRpf0YRqVlKz8FdjRADLVOYMou1u0LwxJm9E1y5w6+7vc8pTDAFX?=
 =?us-ascii?Q?Hsbj1XWIRtoPY9L/Jswndoiu1m2ItjKjzsfqwDxEY90dCgJ9SwXHZGliBSvq?=
 =?us-ascii?Q?sf4oFzv9EfQUD/2pPgjt1/hrb7WxjoAowK2H1qOEa3el7RxCOOKKsSTd1ihS?=
 =?us-ascii?Q?d303/WHzX8jDS8Q/CsnCCdskkqaMwjSDqoGMJ/VayYG1Bet2OUOywWMmxdQf?=
 =?us-ascii?Q?zD5kH/E0k2uLPxrB32xwyvprvD5AQTH95XYBqau2Hobb+9Pb9ATQu6xcMI1U?=
 =?us-ascii?Q?2qdIG8RFPJ6s1i4FCrBgLelHLS1E+7hbvOJXOslwfjcfnUHi9D+hrlh1cyQd?=
 =?us-ascii?Q?ljJ+Mh7er9Sub02zk6kyfZNXlChsMB9c3v+/cR5wILxp/oXrZk/unyJO5jC0?=
 =?us-ascii?Q?6W+IWKRrt5atjsaZlXN1vuaVv94+MDr6eG8Wy40RbgYcVfOThiR26mjSEbvj?=
 =?us-ascii?Q?nR+TQXTElrmmX+weZJSfC9Nq/DBTYdQsGoRygzmCBP3g26kAFGVn8PKWyo4l?=
 =?us-ascii?Q?3dvn8+CgnNlXXYgudTlYfPHBgb4dW2O+mfN9IikOm8OihFdG4OrQ9RAaDZd+?=
 =?us-ascii?Q?pOk3fH8XN7CpfR+t7ialCTvcXbQRGvSYAUB/0b1yZrwmJ6ZkH7G7ypNaBkcv?=
 =?us-ascii?Q?XwlWrK9hdAWK9y0pHiiA3pEu96fe5yPNGNOxEnDJnQZ2iiANW5ToIQ0wRFVY?=
 =?us-ascii?Q?V5Nyc9Fx95tOvgVCtmD+TrFT3jvLf/qbSIIKJlVx2ez2CMiajVHw8Y+2stlX?=
 =?us-ascii?Q?bSszjJ+z5AgpDQ3DMb5V2phUvzzME7tKC1ecAPFoEGGtwfHJCW/Lwt5MxuDN?=
 =?us-ascii?Q?qxu0eWqeu/K8spnNbACGSFz9NJ/C6AXVdAT9hfCCkZ9+igEdgMcEIdf74Uat?=
 =?us-ascii?Q?HPPknhuI0z4wSXjnwyuwUhj9t11gVjENJ1xOWi6OYuNOhQeMwejggRVZ8RoT?=
 =?us-ascii?Q?Q7kaJwyz3GlMCwik/ICVsfRZiTJSDQqSWbrsQvhH+LQ1439xEqzJ4AOC24wp?=
 =?us-ascii?Q?+aO+q7spyvmsHUl9KiyY+X6jWEuU7AcgK4oqRgir6V8ko7xcrxujIj3rqKzJ?=
 =?us-ascii?Q?ZYiq1FWD6dTS5ReVksWwkYnrWfldzz4ss3xL8RJUcUgZeEuHFVTqAAKYXP5L?=
 =?us-ascii?Q?dnQwIlh3bnCOI6uiHnFbtDrsL59OKbFthiQIpAL+H/hQy5L+ZQmu/HTzFvl9?=
 =?us-ascii?Q?ehJU6NHVipJrrH9QSnXOmF4EEsgq4ATzajFC5YT/0y9wKvCPZmaWGQaGSWbR?=
 =?us-ascii?Q?4CcmRO73lkCN3nZnbpVQSQDczms/ABGf3dplZOHqPx4SRoqzdfky4A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2gtJxKAWlUSrvN2SQiR2woKXZQag1VLQSFfW3ZrZRjYrn3T4ZR9Um3F2UmVD?=
 =?us-ascii?Q?xwE9mOoxe2nWHR38DPL2y7ndq4dSvqS6mt+u+re36H8QUlAygJ77wP//X8DY?=
 =?us-ascii?Q?d+BxCIoJA6H+8QQLACWCmHuQtJ7xDWmC6M+FPlLNnljNw8rKYC2AXXadbmM5?=
 =?us-ascii?Q?fo5f2PKcTE1DPcg/y3HFQ+s4rk0UhaYELEwiFyk6fTC7ZcDJNEHyFiLOocYV?=
 =?us-ascii?Q?+g8KDiEYUTdM5iWgHSzQAHmViH/ufhX3HWCaqUbhGXclzqqKQ7RokzSlR7RI?=
 =?us-ascii?Q?bFX3aMwYET0OFkjI3u6uqf6/Q8tg5cvDHlIHHazC9ybaSPpA8rcY/Mw9pDVH?=
 =?us-ascii?Q?bv4B1Fl9PYhd/gDbPQlBvsUUwbH1vaMbz+sfzWPPJ/vKdakas6pJIjfmGYok?=
 =?us-ascii?Q?G0J+LnOLuxlNkKI8paP97h4wQ+aMIjwQV6ZWb6eHQd/HQQMGGQgfhThLy/+j?=
 =?us-ascii?Q?Xu3xY1PTQMDCWU09bI8BmyBZUpKFnceh2ZI0VobZbU5D8fabw2TVTekPaG0y?=
 =?us-ascii?Q?7sItp7VQNl8pGaszUVpcTS9/FQyl8ddA3wRBn2dviMKi9M3d/UqosNIMp032?=
 =?us-ascii?Q?R0EqHhWdBOccVgVNKZw/ueM42RBmKN5AjpLaJOguHgWQ3rsZMr7KRtZH4zZF?=
 =?us-ascii?Q?pJFqQHBZMweEE7um1lHiECOEiYk6b4PdwkzumLF1HOpW0DJsoKQcH/PnD8tV?=
 =?us-ascii?Q?hSyJanNEmaf23RtZ+LBLCumKNDHmPyJFBvpzfZyD0JDWaylh07sjf42ugwxN?=
 =?us-ascii?Q?IXjuy47jihQx6NVjRu9jQpIzTXQ6SVv4gKDh17v1x71yLhIjAF1NQkoDqYyi?=
 =?us-ascii?Q?kWOVYN9mxZRGoxaFOYJZoiBRnxk7GgdiQ7ZLk33wuXOAk3B7Yma9K76LNJ1x?=
 =?us-ascii?Q?eMSv/lT6uDKsPdM5iAzcrSzenT8tL5PcSNjs/D3g3OZPYrqtvqEnh+cKwYvE?=
 =?us-ascii?Q?oycH9Af8IykSBq9ED1oeq+LywBtdFTloa3bFskVYfD/4OyxTF7qB524kGh3W?=
 =?us-ascii?Q?HJFy0VUipgqZM6x2y/Ifx2ob6wdcF+l5LjKnWMJ4UGLrLYN29Y8xbJoW2PK8?=
 =?us-ascii?Q?a/a7e916tLcrajq4LwnohAbx7n49UktnVbGHcX9Kp7Wz4OrymUMRJh9qk1Vi?=
 =?us-ascii?Q?nt3E2ktDPnS9+uuYc6zvLdyq4twkz2j6o5W5u/WcC6UYgFyjQA2keAJHNttG?=
 =?us-ascii?Q?KWThewaYT7DA2QODOSO/gZw5njJYFUfzgoRPuiKI15NndIXkCsRigaw5MckT?=
 =?us-ascii?Q?T5heaEKcnOAsqFt/1UMLRK8CE+B9Z7B2aaQ72f/GJ/kFkimD2ENWlxFlOuOw?=
 =?us-ascii?Q?7pqewUzcHm/0xt8Xoph5SU6VcERuVhvEyJ2J9UltmgH5vSttcqPBAgTb2jx3?=
 =?us-ascii?Q?CQ1Yl5ik9Oba3WCn8dM5777Wu3DKmuDNIdXi32TlhSKDp4WFBp7G+fw5bZmo?=
 =?us-ascii?Q?3JygU7ZcAtelcfjw7XpOEyosGS1xPl5C1VmY9Qaxs9oWdUctxGyoy3PGXGMZ?=
 =?us-ascii?Q?3WfTIFDgRGixtT+WPVM+ISGUKRINWbki+r4BSuAEUauyuOogoDxx3rNOWE09?=
 =?us-ascii?Q?IXZGcLu1owiVKfZWK6U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff24aca-0ab7-41f0-afe0-08ddd10ab7da
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 14:50:12.0895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iX6RlEQjaYLHKoM8ef6bpv8+1Bos/At9NJlLe6DL3e0n9rHpFPSu5l4+hpCuYA/I/nUTiexMfBgOrahVvAzn0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7978

> Subject: Re: [PATCH v2 1/4] dt-bindings: thermal: qoriq: Update compatibl=
e
> string for imx93
>=20
> On Fri, Aug 01, 2025 at 04:11:16PM +0800, Jacky Bai wrote:
> > The TMU used on i.MX93 has some slight differences and bugs compared
> > with the one used on QorIQ platforam even the basic function is the
> > same. Add
> > i.MX93 specific compatible string and keep the fallback ability.
> >
> > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> > ---
> >  - v2 changes:
> >   - keep the enum
> >   - refine the commit log to use i.MX93 and QorIQ name
> > ---
> >  .../devicetree/bindings/thermal/qoriq-thermal.yaml     | 10
> +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> > b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> > index aa756dae512a..6d8766c6a58d 100644
> > --- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> > @@ -22,9 +22,13 @@ properties:
> >              Value           Device
> >              ----------      -----
> >              0x01900102      T1040
> > -    enum:
> > -      - fsl,qoriq-tmu
> > -      - fsl,imx8mq-tmu
> > +    oneOf:
> > +      - enum:
> > +          - fsl,qoriq-tmu
> > +          - fsl,imx8mq-tmu
> > +      - items:
> > +          - const: fsl,imx93-tmu
> > +          - const: fsl,qoriq-tmu
>=20
> look like previous fsl,imx93-tmu have not define, which new compatible st=
ring,
> and you also add it in driver, needn't fail back to fsl,qoriq-tmu
>=20

Make sense, if no one has different opinions, will drop the fallback compat=
ible
in next version.

BR
> enum
>   - fsl,imx8mq-tmu
>   - fsl,imx93-tmu
>   - fsl,qoriq-tmu
>=20
> Frank
>=20
> >
> >    reg:
> >      maxItems: 1
> > --
> > 2.34.1
> >

