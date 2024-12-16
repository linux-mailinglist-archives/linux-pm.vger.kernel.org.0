Return-Path: <linux-pm+bounces-19275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEC29F2A3A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 07:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4C4165904
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 06:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31751C8FD7;
	Mon, 16 Dec 2024 06:39:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020118.outbound.protection.outlook.com [52.101.227.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1283EF9D6;
	Mon, 16 Dec 2024 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734331155; cv=fail; b=gp/thjSpDLXSTzOgTUrkdrpTdGoj2wHSgTVf/dt2m7tFUToPmMTjL9dri5xOyWf+b25z4ukIGR5nS+lhf2bqyd6PhfYMMXOtRaY8VXsB8hXo8FPaDNOdpNXFYhI7nOoNW9sFr/rYMLHbT/bh3hmIwDcvwBHRFkhQqcTlNPaNok4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734331155; c=relaxed/simple;
	bh=P4bt627JBMM7ijrVmEd3EwsS6W5kWtfe8+Cv0VzCkoc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k00aPa4B+XW5tzZjphMvIf57YlDZvEqmRiVdaLJ0OFx4KyQ2iffTJVi74yjQa9hdoF8/cBVPh9bPPoOREPyGTMoPmwZy8XBt2p72f/9znoxBWck/PnoWbDQmMac/ShI3hcpgkUztJjWL5N3zFj2zBVtZrdMg9JyYdu0zvcU0Dtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.227.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCtSsKcTGLmN9XjYPn/TiB48IaDN7Qhw7GPIF50vYlqKhAZ8NT2kLObGh7WUaKonvxolFS1nJ7VVRd7QqZWWEeedDMip3sDQoBrff+QuYwk0L/t7PLU/Uc3cfL2g/Jx7nAXW9sE4QZY7ImEZWHu6uOyKJL2l9OgNalWBfODvHX/39C+vUhxqndgWFlimoU+wzeR5GlcgDFE6CSa0Vdg0If0lBS4RcxKoUtbF1/KC6WkFYQNfLK5XbdwXhOeTxkgnYf7xFnfq4nNevW5/FBi/dMeamSUytcMifHHr2tDcqbhsEBJe6eH7w5T6+L4daQ7xvVa8TpjBQe83cB24wneb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4bt627JBMM7ijrVmEd3EwsS6W5kWtfe8+Cv0VzCkoc=;
 b=nGEMy+pY5KpuryvWBeLvRk8emWNpX4SIuX7bzIxWF8YpFb4iCtPqEmdcUozHOva4YTWKu7q9qG89s56VbspIleSfhoRldWEEW4NtEx92ztRxj7zqUMarER19YJNm0ACnpsz0CQyxL40Ely0FW5XasHKiYi3TKTATNqqR1kC9gA3f5lDQdI9ExEK6tJA/u9N5p/FOVE9xP2yDg7BUcEOCjbMeNbmj1atOUePwxS9pT8zoyS4cfPjLrcXfWo3nuwNbpF/Iraay7SibcSJjNspTOS1NmEo4155vmpXQ2Eo7Kge/dUVy0CFnD0xhGh6NGLl6Pwoj8GwSPrA3ee9wPsq98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by MA0P287MB0090.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 06:39:08 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 06:39:08 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: "sre@kernel.org" <sre@kernel.org>
CC: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 0/2] power: supply: Add STC3117 Fuel Gauge
Thread-Topic: [PATCH v10 0/2] power: supply: Add STC3117 Fuel Gauge
Thread-Index: AQHbT4QR2jycajrJzEamSgzjleUNwbLoaoGS
Date: Mon, 16 Dec 2024 06:39:08 +0000
Message-ID:
 <PN2PPFF679F9759C05092AB7310AE0835C4F23B2@PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM>
References: <20241216062920.7228-1-bhavin.sharma@siliconsignals.io>
In-Reply-To: <20241216062920.7228-1-bhavin.sharma@siliconsignals.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN2PPFF679F9759:EE_|MA0P287MB0090:EE_
x-ms-office365-filtering-correlation-id: adaa2f7c-802a-4804-0529-08dd1d9c5838
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?O5MxlQJVhetFBG+Y/mR4KmgJ3/AorE7ccX+5oEXAPpMOZEyxNmt230oUh8?=
 =?iso-8859-1?Q?LMC9TmIcKRI5PvBw4PkeE1VUGGoNPJIfvmvGBACa5kzlD11bY+hHeAASED?=
 =?iso-8859-1?Q?iMis3OLyT/byvsVJo31A9iMNxVpKKaelFO6J7hyfb99ChkPz6AX4BmZ7oe?=
 =?iso-8859-1?Q?hxZfShFBrOoe2+ZO9FAD1WDOVZR/+tzTBgA2Pdlbn6UCBFpqlziSM7BcLa?=
 =?iso-8859-1?Q?tAIwZiN3Gnlif4tpVHIenBZ/M2B98y3IilEEch2UL5G/PwhWbqbyivkMPB?=
 =?iso-8859-1?Q?qOFokWP0OVmb1lKUHkWAjDeuq3e+w4maKcWGs/aROZSV+LKOUWqWRRrmd1?=
 =?iso-8859-1?Q?uGeWGCWb6cx/MQ57hQpTtnvrS3ERuHcfL0NmxB4gzLlTkyk39IfKxzzRY6?=
 =?iso-8859-1?Q?VcKpQSGb/F9rYlLSCjZFzhylICFis/WUfULKwHN8n70Jw/ko5TMbh83OeA?=
 =?iso-8859-1?Q?aOLsRtdBt0uiRbM2l2AZ8jFq/yAXlO9Nxlkxvmj/klqoaWil8jmA+dTrBL?=
 =?iso-8859-1?Q?Cb/X4BYSI7c4WtcZzQg+Oyqs9hDHPAFkqAD60uTBwwURqN4madAZWVx9fc?=
 =?iso-8859-1?Q?omwsAY4ehG+l81YflvG4dwItsDA8JwgQOLwcoHh8K+dEidZKN9/apryBhG?=
 =?iso-8859-1?Q?IXQozCpQ/tArPjAUAe0w9lt14NgKTsOvBXyTDdtgmGC/DmWqzrFpVYWODa?=
 =?iso-8859-1?Q?mKyPifrR8NOTf1ZRZzmOYvEmJD5cbL6aT/90gevOH4HU4TWWZrm+OacV+b?=
 =?iso-8859-1?Q?GVH4+5C82jZq8grvek+5OQs0jpOMCD7brWeHAw7dQGQLrIE1PWnEgomndS?=
 =?iso-8859-1?Q?MF+jnR2+koxC2pzp2lG5QmJd+kzTN5RneL+2+4SJJ66fOFVfMU7q6NjwXp?=
 =?iso-8859-1?Q?QFt4Vot6dlvqCEbaVIMmc7zBcONkTCFcTLWdYt97c6NkrR/ecObMxJuxdF?=
 =?iso-8859-1?Q?O71eD8TmYeyOZ0K3Sv3yAZ1F6o3XqxRFsDHu8ufDAur0XYEeppoKyVHK5h?=
 =?iso-8859-1?Q?mw59fgOGE7ZNvDo1o/KV4/JvX2w1+B6vdNosVByz1nIpiAnhlffo6zwCV1?=
 =?iso-8859-1?Q?Vgpfw2dxtfv42xmP/uhcPu60BfmDFmjB78Q79OUTeCk46LNO/PirUNCqhj?=
 =?iso-8859-1?Q?/zyt2jQ/v1c2ecSO3XiwfjsntryEapvU/xwT9IK7+ecBawDQWhbfeocLdF?=
 =?iso-8859-1?Q?64+Ox6WDs08ux5pWqN8GvoRYXTR4PQS29QBhsz9WH277A9ngKncteAXRP+?=
 =?iso-8859-1?Q?vxQKh7DJiCXcAcPTQIMZR1muv+zWVdq9XhcyM44RHGEZd/YfqGK9hfp5tD?=
 =?iso-8859-1?Q?aSagor9i6n2hxPHi510j18FJyyrhMbf3PaZLfQnOaxeRv9UH9yQwA3qX3m?=
 =?iso-8859-1?Q?bRi8BJKG0/SCt+WWWEKF4DZxyqnJZRymTcal+5UY730PGJu2XUmjD/kGni?=
 =?iso-8859-1?Q?iip0nR8mb7RY9I4pVD2w35egaocIw2TLraJUfwiiaqfy74idSv+DFZ7C9B?=
 =?iso-8859-1?Q?viuLg+ux2A+Z2ofjsgGmSm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?TfBmJ475vKnXbmcPMlz2qjTuN2DwYh6TvQ5aevV6oNZ+aAgKSoYr2PCiFk?=
 =?iso-8859-1?Q?h9+ZFkpfrnpNrxPkk2RPZ4GpxgOaUUQqn4u5meMUkMLHkpmMWbAz5owvwb?=
 =?iso-8859-1?Q?zZUZb20cHhvNM+lNaxuaFNL2yqV8pfgiQ1Duj7xs1oAAs5fZaiBGI00mVc?=
 =?iso-8859-1?Q?SOPowqS41V7n5v5bm3ybNuTLlAB1U3k0ySGg/YOiaU79QZ1Lw9qqmDjCwS?=
 =?iso-8859-1?Q?L1QB+ITBmuqdC6yllGsMstQ/CD9EuoAIsGlisAAYTNlAbBGgYG7tFCGHYE?=
 =?iso-8859-1?Q?23D3dn6EaP0/JXadXA1cPLOKVgRMCqu7tp0C93/u67Hvw7s3WoItt9Rr3o?=
 =?iso-8859-1?Q?9aZ+5T1g4cEYa6MQBK/T22mKYTgbxOgOgSYaT6z2/idO27hZ64xl3msxos?=
 =?iso-8859-1?Q?8vSbcbQn37oHqkwHNbgdnxQRrbNYYobZsIbcBjbb8pCKG8PFYxkGyfaULW?=
 =?iso-8859-1?Q?oh8Z3qtyVqLACcwcSggjkB4vtW4LAN4zHek7Tt2rVJq6aA6uVmWZGNbOaO?=
 =?iso-8859-1?Q?KIKpFHtZfcq0YGUiznnNnRKmPXAWLQKWHi/JNmltmL3XUEvXDF9ngYZXk4?=
 =?iso-8859-1?Q?zBLd+kuLHpObwoPIO1nf7Soh84eJnKOnUYxtYmeECnVgtRzkToRks1B8mx?=
 =?iso-8859-1?Q?CIvVs5JkZPRk0Pfj2KeiLhexL0wIVNqqUZmO26jYpmRKZC1c1Xa47LKicK?=
 =?iso-8859-1?Q?/633eHx3rIUzjk9x8YxDEd4MTWA2FMGfpYbvn98CLIti6wdKc2+NYbzzDS?=
 =?iso-8859-1?Q?Jj+kHJvVBoBye41tdbKInoOg+oIiQVwr20CpsIocgn7k0a0Aqf5kLoATMn?=
 =?iso-8859-1?Q?21sV59gFZohUB/Ek4k4/LZ4oEbxqCIRJ0YRTcSxKLAa8KtfptkbSFg9LMV?=
 =?iso-8859-1?Q?Z3MY+sGQDHzZcq+1PvYoBuxeAo1s6yD/sR2zM/dxKpbTAVxE22IOtd3BIh?=
 =?iso-8859-1?Q?UYgGLFdYdS6qHSVFU4jh+4Iqdk7STduCnreuS7F2Bves80WfgcowOymJmE?=
 =?iso-8859-1?Q?DzFQU23BWgCz6G6FOCYMmYDpWz6+scX+L/3sSCcuO9Z3+ryPb+q9eK5eG4?=
 =?iso-8859-1?Q?eKSkLSk8pmPjTVt1arF+nxVFzt01w9OlKDR3/7tCueFfPL6aqG7XjuJ8Pf?=
 =?iso-8859-1?Q?XL+0gxV8BvG8XHpOjwb3XXbgK81+c4y2WkSTCSOMoLgbVN9pYjpyJFuoJJ?=
 =?iso-8859-1?Q?Ob0QR3Z90OArxcwflt/t63KKmn70o82l5BUoU4fXAV0xkbhDf1qgzEDYP9?=
 =?iso-8859-1?Q?9UvkKTjLSvt+Ez1rNxCchF5nNWl7LjeuZkC4rPSBH9JX3jhXSqIFXC0mHn?=
 =?iso-8859-1?Q?ntCuM6bAk/ojSuaAO2kNjqnNquoXZUw/SthrGE/z0mQD3rgZjkfYKTN4Ft?=
 =?iso-8859-1?Q?9q9BuYRhKY517cMAxerF2QQyvE/+PBz3Ss1ftpPRth1MLlWTP6zzo7BEZd?=
 =?iso-8859-1?Q?2Yzr0oc3Uk5F2POt0/d7kO+9rd9bTL9Ujhg/OgYOhjobiVuIywQOuB32WM?=
 =?iso-8859-1?Q?MXs3Dm77jkDWBGyKQTgGJCXKes8DIq4pEeqgjkfSiEgMqkcFXrurZ+lQs7?=
 =?iso-8859-1?Q?cgXHqp67SOopABJS4qLNL09coQWkVcYVazXG3lRUEGHzpWsuCUgyjJzZ7S?=
 =?iso-8859-1?Q?WiuCWrtbmSPZ0RtqCwo2yuAGF/ERIW/O8H3dNLJ2YCtaS9T/dmtohW3w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: adaa2f7c-802a-4804-0529-08dd1d9c5838
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 06:39:08.8127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I30uzPguUfFJWD0NWpmJsoKNYhPiDz2xVwYvL48aGTPly19CJLdwjTKNBuSv9ed3R5O7uSJvJ3ATz/YkRqDAF8kTWmiBPOUakjaruPSv5Ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0090

Hi Sebastian,=0A=
=0A=
By mistake I have sent the v9 patch as v10, so kindly ignore this series. =
=0A=
I will be sending the updated patch series as v11.=0A=
=0A=
I apologize for the inconvenience.=0A=
=0A=
Best regards,=0A=
Bhavin=

