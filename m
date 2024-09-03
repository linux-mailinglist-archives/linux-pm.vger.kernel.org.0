Return-Path: <linux-pm+bounces-13404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60582969A38
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 12:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189DB28486C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 10:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B985B1B983E;
	Tue,  3 Sep 2024 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="dV+kXHSA"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011064.outbound.protection.outlook.com [52.101.125.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5731A0BEC;
	Tue,  3 Sep 2024 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359515; cv=fail; b=gRVCMZWVv9+eXVl5Xo0Wx2ObSPrNfXGwXKdJau2AkV0Rg+3SU0LsTMOyXVt4ahwlGUbmsMObMSH3ouFcMVwetjNVmW1JigHZhbedjjhyvo+WKoTy0viuKH1FU7Cta0g+bGbxiD12A+24H4EnK/P/lM3eAH9iJmPSPQGfb03IzMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359515; c=relaxed/simple;
	bh=d+qKk37rQp06PgTm+/pH1YMc/B42zjDPmCvKNvl4cjw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dvBYpvn0wZHLZubNH5VO6CCo+eR4UgPiKxQli6ENxV4ZSIJ7Y8fLA4UyaTH9lAstIWg96unah1fTT5jlVfAoW9bgMXk2mfGWeMbjCCeu9ifJ+BfKVoAO+WAqTQo0nfV7GBbDyGF8xclMBG8fSRNtw2s1pAvURaLEfANmBmaXkyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=dV+kXHSA; arc=fail smtp.client-ip=52.101.125.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKMZNnICJEUOsybMucPrlnEtuukIyt6i0vEjfMHRx1afMzbGLorAY975uo5lad6lgQ5TXMJ8a6+42tLd68HxNoPim+0B4Cco8vf3jH4U9qo0LFGRiHj09lkJnvGG8UHtk8Z/xFcTa01NGoRneJiDk2sq395FZYDqxl5p8423KS3I1sAwMCWtsij1+JRV4td5ev0McITsKY0mnxHpQbpAdeYsbNB/FA17mLUnILOFTr/TYPrh/8Fxzk0d1tDDXl9RoEkudP5E3wigLiVEgpAu7GbcZweCJfmVXYxBS5yy2m043saIUmg4A7u6yxYjP8ToiRINwtmM8xwTe2skl+4fkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+qKk37rQp06PgTm+/pH1YMc/B42zjDPmCvKNvl4cjw=;
 b=aKxt0RRgts0xwRHh3/t1mxNBeM0gUdFbofJy19IEyM8N3DTdMDmvgE9QjkqcJ/rrRD9ziWPE+LBd/btrz1uPoQP4ZheKmSF7/AS7zOV5vcthoGqlY7T1SBBssJtT7CL/6zqk/sxgj+4ChHKPcSc4t0oOut8DLvu4C+KVm4AEUEWPmQYdYxqvn1ybIkRPXiET1taPlDoWiuZZvLh9+jbMDV8M6I1qht6539VHdNFfA5b5DZfleygpgwkH8okfAszFbuIWd8IMGdaP3f1nE8ewXAjrHOYXkREO+A1Mv0FYMcOcepXiCXKfNlvsjtYv5faqlQr2Ydg97nB6AVG2x03V4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+qKk37rQp06PgTm+/pH1YMc/B42zjDPmCvKNvl4cjw=;
 b=dV+kXHSAEvrDpyNLGcr+L/x9hJkcMOOHV5KL4QKBFKGHhtVqQ7oN8i1V5AqJhia2Te2+F5Iirr/Wop9bHyfke455gKt0kcQv75yzb5l2OE+blrbuCK6nuhiHNGKfH8yCRGJcMGfhA9zrOPybTI5qvGCdLevKDiyJ6lHo9tNBOFs=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by OS3PR01MB6533.jpnprd01.prod.outlook.com (2603:1096:604:100::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 10:31:48 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479%7]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 10:31:48 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: "vkoul@kernel.org" <vkoul@kernel.org>, "kishon@kernel.org"
	<kishon@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "magnus.damm@gmail.com"
	<magnus.damm@gmail.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, Yoshihiro
 Shimoda <yoshihiro.shimoda.uh@renesas.com>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
Thread-Topic: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
Thread-Index:
 AQHa9KfrLpE8CCuWg0uaPyaAgZR3ArI+ZjUAgAEcCoCAAVgqEIADVdkwgAAP5ACAAACycIAABtQAgAAAhkCAABeagIAAAFcwgAFU0LCAADjlgIAAAKQQ
Date: Tue, 3 Sep 2024 10:31:47 +0000
Message-ID:
 <TYCPR01MB11332EF1A8D064C491D8F261286932@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFrS4Dhd7DZa2zz=oPro1TiTJFix0awzzzp8Qatm-8Z2Ug@mail.gmail.com>
 <99bef301-9f6c-4797-b47e-c83e56dfbda9@tuxon.dev>
 <TY3PR01MB1134652F9587CFA0ADE851CA486902@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB113467275C519B729FCAB1ACB86922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5556d176-cca7-492c-ba21-48256d5d6338@tuxon.dev>
 <TY3PR01MB113464D53083F4C8A5DBBA36586922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <590a4fb2-24b2-432b-92db-534c5a52ed0b@tuxon.dev>
 <TY3PR01MB11346505565B81AD2894E035586922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <35dc7414-f5bd-4ed4-bfa1-f723f4f0078c@tuxon.dev>
 <TY3PR01MB11346A4814F83FE296A1DED8886922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB1134648BF51F1B52BFE34DD6D86932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <fbfa9179-2f52-429f-8b69-f7f4064e796b@tuxon.dev>
In-Reply-To: <fbfa9179-2f52-429f-8b69-f7f4064e796b@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|OS3PR01MB6533:EE_
x-ms-office365-filtering-correlation-id: d21cf789-105d-4232-745b-08dccc039d86
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NmIwQUNIcFhMRGZzaFNkdFFkbncyUElIWGRFYzhZQU9rT0NlYkNxYWplSVFN?=
 =?utf-8?B?cjlVeWdCUW9mYWJYQlNiWmJoMkpKM21lT09OMk8xc3MxbVlYS0hFL0hSZXJL?=
 =?utf-8?B?bnlnRWxXNWErQTZ3c0lMa09VSzFSNXA4ZC9vSVhGOTJKdkxnOTJ5Y25XNGNn?=
 =?utf-8?B?QUVGaUsvOGZGU1RKcnI4U3BJVnNEVnl3cW15TU5sa05Qc2lnVUZJWENaWFNF?=
 =?utf-8?B?ZTdpVU9WRDFFQVFmZjNMOFRiSW51SHlKWnRBRm54ekJtTGJmUmtmMmNSTS9I?=
 =?utf-8?B?eW1jd2Zvb052dzRaZnVuUTdIZjVmQjZobzB1NndjejVJeHVQaExHNWZYNncw?=
 =?utf-8?B?NnB1QlNibit3STMrcW1WYlZlR1R3cW5nbW9xako2azR1OWRNcXBOcmRMWjJl?=
 =?utf-8?B?RmpvZFRkeDl1SWE4Tkw2dkVPNExiRTNtNng2U2czalRJU3pWS2NKSEVab2kw?=
 =?utf-8?B?YkFicjlvTld0TXJLeFV0cUQ2d1pDQ0l3RkZaaTM1aVFMdVQ1WEpudlkwNmFI?=
 =?utf-8?B?LzNWUXg0YVpDWkNuNkdWVU83Y1FsVEVJdjUyUHNpZWVyZW56MmF6bk5iRmhl?=
 =?utf-8?B?VVFmbmdDbm1CNmxnTHdNY1pSOHdhRkJwN3JWWG1jSzZpZU1JR1dZSkpiaWNz?=
 =?utf-8?B?MjZXSHFab1lVcGdqK3o5UUg1VmtSMU1VZTRsWElmbElQQ3JjZmtYZVBFa2xu?=
 =?utf-8?B?M1FCUnptOC91TWp6NEwzK1hnd1NTNnY3WDJTVFpnUlhDaDRNNUthdFFNcWVm?=
 =?utf-8?B?U1Q1d2JXL0g2VWkyVG5wZGZMSmg4OG93QjBwaE93SWpxVTAxZW1xN3dOU0ZK?=
 =?utf-8?B?K01nSlFNVlFpWEdkNWVrR3JZNDhqd0VhUnRISWxpWUI3M2Q0WXIzMUQ3ckZO?=
 =?utf-8?B?RUtmbEFDVGoyZ3BYcXQzY0Rmc0VoM3pOSFRWK3d1dk51QmI4VGdqVVRBU3Zi?=
 =?utf-8?B?V0NDZlNsS0ZWaFZXQUdZbjQyK0Z3M29QakRueDRyVzdLM2NqSGFvbDBvYkd4?=
 =?utf-8?B?YkdQQm5JZHdIUEo2ODcrYjR3dUhUdit5UWhLRFVwa1NkQy9FckxmUC8veEo5?=
 =?utf-8?B?NFJLZVZaTlJLdnp3QUUza0ZJRVY1OG4ya2U0L21BTXAzMmJ0YjJtMVliTGdu?=
 =?utf-8?B?aHoyLzdaUzRBck1iVVcvTXl6NG5YTStObTd6TnBXbnRmWnZMQUQ4Y0srWktv?=
 =?utf-8?B?U2h3ZWVMNnF2TEl1bmV4MWlFckNHRlQvYXNXTlcxL0g2Y09CTG9BNlRqNHBN?=
 =?utf-8?B?Mi9pVGc4WjRWNDNOMFltZWNETlBacGJvWTY4cjQ2UGpLaytROGFVZDE5d3Rm?=
 =?utf-8?B?YjBXeGszei9Md1ZUWjdidDlMNHpqZnJNZ0NrWGt5Zmt5U242T2JhNmtQSDc2?=
 =?utf-8?B?SGVaMGxld1lDeG1XalcxQnFXOSsvNlc2MmthR09xSlBQaWg4WlhEWHM0aG9v?=
 =?utf-8?B?ejk4eFhEa1Y0VFZJVm83UFhtOElXc0c1aUNUSkhXMUc2UTlFYTVzYVFwc3pl?=
 =?utf-8?B?VHJDTFByNjlxTklLWWVubkFxSW44bk4rZ0pySWpXT20xQ2lkWkhLQllQbmg5?=
 =?utf-8?B?YVpwQStyTkczQk1WZ3piRHZFSkVyQnQ2RzBSUE4xLzhuSkFtWnl5NTlqU1hp?=
 =?utf-8?B?bzA5M0d3ckxaaGpmdy9GTGtRNUJXemJOZnE4Z1g2ZWZPN0I5OEZhMVpjQmxL?=
 =?utf-8?B?RXIydEptSVBSUThxV09yRUxwdkQ2UnZpZ0V1cWplQnpEdXYyMCtoY0wraXRk?=
 =?utf-8?B?UVc5VXBMemcxVFlFU1ZRREpxTHNVTU9TN3FreVR5dWJVN3ovU2VGM1ZseVVs?=
 =?utf-8?B?Nzd6a3BLcU1HUm1GZ0pmN2M3d1lkT3J6WTVtbTh5a2Z2RG1sRWtCdFQxV3Ux?=
 =?utf-8?B?eDM0dXdueno0RkFHT1VQOW9JU0pKM1RyMjdFNmU2YURaT2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z0g4cU5uZ1NkbUQ3bVlzUFl6Qjl5ZldaeWZxWjZ4UWZ2dUtvelhVMm5hV2N4?=
 =?utf-8?B?SlptWDRZeFY1NklFaTlaam5xL2tEMGwwdXpIbEVPY09NR0dKV3hXbGt6WUo4?=
 =?utf-8?B?aVVTeWdnbnlIMEVaTmYwQkNhTzE0M05jS2t6eVQzcW1tTEE4M24wM1Q2UEdY?=
 =?utf-8?B?bmlUakNUZFpyczBhQzVnb2xnMXVHNW9XekpKKy84Z3cyc2xLVm1jUzNPM1kv?=
 =?utf-8?B?WGd6by9mTFZVdUp1K1Ard1BDNFBXNGsrSis0SFJXWVpRTGFSdTF4S3pHUSti?=
 =?utf-8?B?czNyVEMzVytMbGJLbXdRRTR5Qmw3ZkF2UUlmQzcwYjNNT2RlZktpK3NCdG9H?=
 =?utf-8?B?b1hleU1QWndiQ1lnYVdXM0VPTVcrL3M0YzdRa1RQdExjUGZPaitEcWViWk5a?=
 =?utf-8?B?S3pNZk9Ha2NwLytvL3N2QTI0bXZRRUFkV1lTenBZWEN3QXBXSURjZ1pJbVpC?=
 =?utf-8?B?N2x5Z0xtZktHOVJmYVI1SzRCLzBGSERlMHdMRTJmcDVLVlpmR2h4d29LelFR?=
 =?utf-8?B?ajdDMzhuNnBsL2lxcTlFTUtuRFVhMGVuTFFIQ203Qmc0R1J4aWtVRmpaeTdV?=
 =?utf-8?B?ZVFrRFo2UEE4U05QMHE0cVVTVE9ZNkhKbW9UR2tLbGhzQm9DaWlaK0pJZjlJ?=
 =?utf-8?B?UWw1UTRybWorWW9KTTcwSTlQeXY0dE5ZMm8wbExpYk01U2tieXhuT0g0SDhN?=
 =?utf-8?B?L0d5K0hmeHREaEZ4eW8vT0U5WnBSWVhxcWZia0pMS0cvakNNbEJDY0g1L2hO?=
 =?utf-8?B?MllDUDVWOTVLMGpoM1lDMFBESkxBbmdjN2RIR3NCaVhqalBYd085NUdLMWd1?=
 =?utf-8?B?TER3N0JYNEdWU1NLRVFqaDI3bnhHMmdXQy9xL1ZYWUc0YTlxK21GTHZ1VXRj?=
 =?utf-8?B?RkIvTDdGSlJFSEhpUUtURGc1bnhFTnNmTEpWQ0FVejYrbEZBWlRzRk5lTXBI?=
 =?utf-8?B?V1QvNVpTenhjckgrVVpSLzFSb0lJNzNYTDI4VlZTM21MVFQxdk4wVEtudS9p?=
 =?utf-8?B?UnhsOUVBVjlOYUREcXd0RTd3QityNER2RzRDNzRad1R0RGlQMk0xL2FFK2ww?=
 =?utf-8?B?K2hsa1hGRnBPSEdhelEreGtrOWkxU3NtYjRiUEo4aG95VXQwSVZwK0hUZmFZ?=
 =?utf-8?B?NThxaWczTVJTWk9FeklaRmczaUdaZE9kM1NUWE9vNUd1bzRqRXpQV3lPVDYw?=
 =?utf-8?B?cy93aUtkQ28rcUZkNXdabDNwV0tGajJqazNCYmowUGI2djdXWEJscjdadlJY?=
 =?utf-8?B?WDNoeWozOEhaOU9OL1M4MUpnNXNpY1VlZW1xK014WmVPSDVYc1ZIYjZzdmRM?=
 =?utf-8?B?aDlOeWp2bVhPcDVVbStFQTIycUx1UmVmQTVoYlc4VVNpbWVrRVZaYnhBUm9j?=
 =?utf-8?B?OE82VWJ6b2wwb0VzOTVlNXNwa3cxclRhSnlBSWdKNDNSZGE4ZlhOSjljMmsv?=
 =?utf-8?B?bjhCZFdybkJUNEhUMmxHVjFuZG5MamtLRUZUTy83ZGhHaWhMZVA1YndpeFZP?=
 =?utf-8?B?SDVCSkxOZk00TEhvQW9hMFE1QlBCUXZVRC9WbWh1SDR1bVJCNTZsYUIvQnlM?=
 =?utf-8?B?TmFoN1dlcXpiQUhaQlVCMWIwZm5IdkFXQWtvK3E3NUc5UWlVTE9LSTlVSnpN?=
 =?utf-8?B?Z2NKbnJOWmNQdEhxUFJhekFGTmpqUmJ2clpsZkUzWERYWXRJSEx3a2NYakZ6?=
 =?utf-8?B?RFpyc0paVXo2a0lqbmk0ckhSL1oyS3JqOXliRFBWdUdsVHlndEJyNEJtNGxD?=
 =?utf-8?B?cG51OVl4aHlZalZhZ2pTWEh6TzJkbU9ORXZQeExKbmQ5L2Q2NlprZ2JIT1hX?=
 =?utf-8?B?ZzAzZFhxdVhKdmdkMk1xOVZFckhzbit1TER3SFJRWm85Ty9ERVFzaVpaMmtO?=
 =?utf-8?B?ajFENkE5UHprZWZCM0VUYkMvMDJBYWFrVGFjV2E5NXNKZG1HOXlnK0U4aVJr?=
 =?utf-8?B?KzQwWk9HWTJTLzNTaWwxU0xZb3Q4NVZabk9mTlRRUmFVVzZvNmk4WVZQc2Vj?=
 =?utf-8?B?dVpYMVdkZkhsR1R1TUh1b2k0T3RENlVaUCtnUG0zUkIxbFg2RkNYRyt5WXBx?=
 =?utf-8?B?OGN0YktycjdoMzZndlZTQ0Y3cVdpTE1mVjdMcEJXUTk1WkhvWU8vZFJ2aXVq?=
 =?utf-8?B?N0pWbjhuOFVySFRJTUgrbTRIdGFudnpYWDJDQmFsNGJIUkVOc2xaenUzTmRM?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d21cf789-105d-4232-745b-08dccc039d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 10:31:47.9407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YnX1JJ3cjwa7y5yfB7wMZ1F/8TZt6YarXrbliEws2/8HF24lymO50i+E9UsBvpAXctdx8spORNxbAYg33TOABkwUZh69KmO0VjAq/LoeoyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6533

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjbGF1
ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBUdWVzZGF5LCBT
ZXB0ZW1iZXIgMywgMjAyNCAxMToyNSBBTQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAwLzE2XSBB
ZGQgaW5pdGlhbCBVU0Igc3VwcG9ydCBmb3IgdGhlIFJlbmVzYXMgUlovRzNTIFNvQw0KPiANCj4g
DQo+IA0KPiBPbiAwMy4wOS4yMDI0IDEwOjE4LCBCaWp1IERhcyB3cm90ZToNCj4gPiBIaSBDbGF1
ZGl1LA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEJp
anUgRGFzDQo+ID4+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDIsIDIwMjQgMTE6NDggQU0NCj4g
Pj4gU3ViamVjdDogUkU6IFtQQVRDSCAwMC8xNl0gQWRkIGluaXRpYWwgVVNCIHN1cHBvcnQgZm9y
IHRoZSBSZW5lc2FzDQo+ID4+IFJaL0czUyBTb0MNCj4gPj4NCj4gPj4gSGkgQ2xhdWRpdSwNCj4g
Pj4NCj4gPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+PiBGcm9tOiBjbGF1ZGl1
IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiA+Pj4gU2VudDogTW9uZGF5LCBT
ZXB0ZW1iZXIgMiwgMjAyNCAxMTo0MSBBTQ0KPiA+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMC8x
Nl0gQWRkIGluaXRpYWwgVVNCIHN1cHBvcnQgZm9yIHRoZSBSZW5lc2FzDQo+ID4+PiBSWi9HM1Mg
U29DDQo+ID4+Pg0KPiA+Pj4NCj4gPj4+DQo+ID4+PiBPbiAwMi4wOS4yMDI0IDEyOjE4LCBCaWp1
IERhcyB3cm90ZToNCj4gPj4+Pj4+Pj4gRG8geW91IGhhdmUgYW55IHBsYW4gdG8gY29udHJvbCB0
aGlzIHBvd2VyIHRyYW5zaXRpb25zKEFMTF9PTiB0byBBV08gYW5kIHZpY2UgdmVyc2EpIGluDQo+
IGxpbnV4Pw0KPiA+Pj4+Pj4+IEFzIHlvdSBrbm93LCB0aGUgUlovRzNTIFVTQiBQTSBjb2RlIGlz
IGFscmVhZHkgcHJlcGFyZWQuIFRoaXMgaXMNCj4gPj4+Pj4+PiBhbHNvIGNvbmZpZ3VyaW5nIHRo
ZXNlIHNpZ25hbHMgd2hlbiBnb2luZyB0byBzdXNwZW5kL2V4aXRpbmcgZnJvbSByZXN1bWUuDQo+
ID4+Pj4+Pj4gVy9vIGNvbmZpZ3VyaW5nIHByb3Blcmx5IHRoZXNlIHNpZ25hbHMgdGhlIFVTQiBp
cyBub3Qgd29ya2luZyBhZnRlciBhIHN1c3BlbmQvcmVzdW1lIGN5Y2xlLg0KPiA+Pj4+Pj4gT25l
IG9wdGlvbiBpcyB0byBoYW5kbGUgU1lTQyBVU0IgUFdSUkRZIHNpZ25hbCBpbiBURi1BLCBpZiB5
b3UNCj4gPj4+Pj4+IHBsYW4gdG8gaGFuZGxlIHN5c3RlbSB0cmFuc2l0aW9ucw0KPiA+Pj4+PiB0
aGVyZT8/DQo+ID4+Pj4+DQo+ID4+Pj4+IEFzIEkgbWVudGlvbmVkLCB0aGUgc2V0dGluZ3MgaW4g
dGhlc2UgcmVnaXN0ZXJzIG1heSBiZSBjaGFuZ2VkIGJ5DQo+ID4+Pj4+IGludGVybWVkaWFyeSBi
b290aW5nDQo+ID4+PiBhcHBsaWNhdGlvbnMuDQo+ID4+Pj4+IERlcGVuZGluZyBvbiB0aGF0LCBM
aW51eCBuZWVkIHRvIGNvbnRyb2wgaXQgYWxzbyBvbiBwcm9iZSBmb3IgVVNCDQo+ID4+Pj4+IHRv
IHdvcmsgKGl0IHNob3VsZCBiZSB0aGUgc2FtZSB3aXRoIFBDSWUsIHRoZXNlIHNpZ25hbHMgc2Vl
bXMNCj4gPj4+Pj4gc2ltaWxhciBmcm9tIEhXIG1hbnVhbA0KPiA+PiBkZXNjcmlwdGlvbikuDQo+
ID4+Pj4gWW91IG1lYW4gc3lzdGVtIHRyYW5zaXRpb24gc2V0dGluZ3Mgd2lsbCBiZSBvdmVycmlk
ZSBieSBVLWJvb3QsIHNvDQo+ID4+Pj4gTGludXggbmVlZHMgdG8gcmVzdG9yZSBpdA0KPiA+PiBi
YWNrPz8NCj4gPj4+DQo+ID4+PiBJdCB3YXMgdGFsa2luZyBhYm91dCBib290aW5nLi4uDQo+ID4+
DQo+ID4+IEkgYW0gYWxzbyByZWZlcnJpbmcgdG8gYm9vdC4gQm9vdCBzdGFydHMgd2l0aCBURi1B
IGFuZCBpdCBoYXMgYSBzeXN0ZW0gc3RhdGUuDQo+ID4+DQo+ID4+Pg0KPiA+Pj4gWW91IHByb3Bv
c2VkIHRvIGhhbmRsZSBTWVNDIHNpZ25hbHMgZnJvbSBURi1BIGluIGEgZGlzY3Vzc2lvbiBhYm91
dCBzeXN0ZW0gcG93ZXIgdHJhbnNpdGlvbnM6DQo+ID4+Pg0KPiA+Pj4gIk9uZSBvcHRpb24gaXMg
dG8gaGFuZGxlIFNZU0MgVVNCIFBXUlJEWSBzaWduYWwgaW4gVEYtQSwgIGlmIHlvdSBwbGFuIHRv
IGhhbmRsZSBzeXN0ZW0NCj4gdHJhbnNpdGlvbnMiDQo+ID4+Pg0KPiA+Pj4gKEkgd2FzIGd1ZXNz
aW5nIHRoZSAic3lzdGVtIHRyYW5zaXRpb24iIHN0YXRlbWVudCB0aGVyZSByZWZlcnMgdG8NCj4g
Pj4+IHBvd2VyIHN0YXRlcyB0cmFuc2l0aW9ucywgQUxMX09OIDwtPg0KPiA+Pj4gQVdPL1ZCQVQp
DQo+ID4+DQo+ID4+IFRoYXQgaXMgY29ycmVjdC4NCj4gPj4NCj4gPj4+DQo+ID4+PiBhbmQgSSBn
YXZlIHRoZSBib290aW5nIHByb2Nlc3MgYXMgYSBjb3VudGVyIGV4YW1wbGU6IGlmIHdlIGhhbmRs
ZSBpdA0KPiA+Pj4gaW4gVEYtQSBpdCBtYXkgbm90IGJlIGVub3VnaCBhcyB0aGVzZSBzaWduYWxz
IG1pZ2h0IGJlIGNoYW5nZWQgYnkNCj4gPj4+IGludGVybWVkaWFyeSBib290aW5nIGFwcGxpY2F0
aW9ucw0KPiA+PiAoZS5nLiwgVS1Cb290KS4NCj4gPj4NCj4gPj4gV2h5IHNob3VsZCBVLWJvb3Qg
b3ZlcnJpZGUsIHN5c3RlbSBzdGF0ZSBzaWduYWxzIHN1Y2ggYXMgVVNCIFBXUlJFQURZPyBDYW4g
eW91IHBsZWFzZSBnaXZlIGFuDQo+IGV4YW1wbGUuDQo+ID4+DQo+ID4+Pg0KPiA+Pj4gVG8gY29u
Y2x1ZGUsIHRoZXJlIGFyZSAzIHNjZW5hcmlvcyBJIHNlZSB3aGVyZSB0aGVzZSBzaWduYWxzIG5l
ZWQgdG8NCj4gPj4+IGJlDQo+ID4+PiBoYW5kbGVkOg0KPiA+Pj4gMS8gYm9vdGluZw0KPiA+Pj4g
Mi8gc3VzcGVuZCB0byBSQU0NCj4gPj4+IDMvIGRyaXZlciB1bmJpbmQvYmluZA0KPiA+Pg0KPiA+
PiAtLT4gSXQgc2hvdWxkIGJlIE9LIGFzIGxpbnV4IGlzIG5vdCBoYW5kbGluZyBVU0IgUFdSUkVB
RFkgc2lnbmFsLg0KPiA+Pg0KPiA+Pj4NCj4gPj4+IEluIGNhc2Ugb2YgYm9vdGluZzogaWYgd2Ug
aGF2ZSBURi1BIHRvIHNldCBzaWduYWxzIHRoZXJlIG1pZ2h0IGJlDQo+ID4+PiBpbnRlcm1lZGlh
cnkgYm9vdGluZyBhcHBsaWNhdGlvbnMgKGUuZy4gVS1Cb290KSB0aGF0IHNldCB0aGVzZQ0KPiA+
Pj4gc2lnbmFscyBhbHNvLiBJZiBpdCBsZWF2ZXMgaXQgaW4gaW1wcm9wZXIgc3RhdGUgYW5kIExp
bnV4IHdhbnRzIHRvDQo+ID4+PiB1c2UgVVNCIHRoZW4gdGhlIFVTQiB3aWxsIG5vdCB3b3JrIChp
Zg0KPiA+PiBMaW51eCBkb2Vzbid0IGhhbmRsZSBpdCkuDQo+ID4+DQo+ID4+IFRoYXQgaXMgdGhl
IHByb2JsZW0gb2YgVS1ib290LiBVLWJvb3Qgc2hvdWxkIG5vdCBvdmVycmlkZSBzeXN0ZW0gc3Rh
dGUgc2lnbmFscyBzdWNoIGFzIFVTQg0KPiBQV1JSRUFEWS4NCj4gPj4NCj4gPj4+DQo+ID4+PiBJ
biBjYXNlIG9mIHN1c3BlbmQgdG8gUkFNOiBhcyBURi1BIGlzIHRoZSBvbmx5IGFwcGxpY2F0aW9u
IGluIHRoZQ0KPiA+Pj4gc3VzcGVuZCB0byBSQU0gY2hhaW4sIGl0IHNob3VsZCB3b3JrIGhhbmRs
aW5nIGl0IGluIFRGLUEuDQo+ID4+DQo+ID4+IFRoYXQgaXMgY29ycmVjdCwgVEYtQSBzaG91bGQg
aGFuZGxlIGJhc2VkIG9uIHN5c3RlbSBzdGF0ZS4NCj4gPj4NCj4gPj4+DQo+ID4+PiBJbiBjYXNl
IG9mIHVuYmluZC9iaW5kOiBjdXJyZW50bHkgd2UgZG9uJ3Qga25vdyBpZiB0aGVzZSBzaWduYWxz
DQo+ID4+PiBpbnRyb2R1Y2VzIGFueSBraW5kIG9mIHBvd2VyIHNhdmluZyBzbyBhc3NlcnRpbmcv
ZGUtYXNzZXJ0aW5nIHRoZW0NCj4gPj4+IGluIExpbnV4IG1heSBiZSB1c2VmdWwgZnJvbSB0aGlz
DQo+ID4+IHBlcnNwZWN0aXZlLCBpZiBhbnkuDQo+ID4+DQo+ID4+IFRoZXNlIGFyZSBzeXN0ZW0g
c2lnbmFscywgYWNjb3JkaW5nIHRvIG1lIHNob3VsZCBub3QgYmUgdXNlZCBpbiB1bmJpbmQvYmlu
ZC4NCj4gPj4NCj4gPj4gSSBtYXkgYmUgd3JvbmcuDQo+ID4NCj4gPiBKdXN0IHRvIGFkZCB0aGUg
YmVsb3cgYXJlIHRoZSA0IHN5c3RlbSBzdGF0ZXMgKHBvd2VyIG1vZGUpIGZvciB0aGlzIExTSS4N
Cj4gPg0KPiA+IElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIHdlIG5lZWQgdG8gY29uZmlndXJl
IFVTQiBQV1JSRFkgc2lnbmFsIG9ubHkNCj4gPiB3aGVuIHRoZXJlIGlzIGEgdHJhbnNpdGlvbiBm
cm9tIEFMTF9PTiB0byBBV08gbW9kZSBhbmQgdmljZSB2ZXJzYS4NCj4gPiBhcyB5b3Ugc2VlIG9u
IEFXTyBtb2RlIG9ubHkgQ00tMzMgaXMgYWN0aXZlLg0KPiA+DQo+ID4g4oCiIEFMTF9PRkYgbW9k
ZTogQWxsIENQVXMgYW5kIHBlcmlwaGVyYWwgbW9kdWxlcyBjYW4gbm90IGJlIHdvcmtlZC4NCj4g
PiDigKIgQUxMX09OIG1vZGU6IEFsbCBDUFVzIGFuZCBwZXJpcGhlcmFsIG1vZHVsZXMgY2FuIGJl
IHdvcmtlZC4NCj4gPiDigKIgQVdPIG1vZGU6IENvcnRleC1NMzMgYW5kIHBlcmlwaGVyYWwgbW9k
dWxlcyBpbiBQRF9WQ0MgYW5kIFBEX1ZCQVRUIGRvbWFpbiBjYW4gYmUgd29ya2VkLg0KPiA+IOKA
oiBWQkFUVCBtb2RlOiBPbmx5IFJUQywgdGFtcGVyIGRldGVjdGlvbiBhbmQgYmFja3VwIHJlZ2lz
dGVycyBjYW4gYmUgd29ya2VkLg0KPiA+DQo+ID4gU3lzdGVtIG1hbmFnZXIgd2hpY2ggaXMgY29u
dHJvbGxpbmcgYm90aCBDQS01NSBhbmQgQ00tMzMsIHdpbGwgc2V0IFVTQg0KPiA+IFBXUlJEWSBz
aWduYWwgYmFzZWQgb24gc3lzdGVtIHN0YXRlLg0KPiA+DQo+ID4gU2luY2Ugd2UgZG9uJ3QgaGF2
ZSBzeXN0ZW0gbWFuYWdlciBmb3IgY29udHJvbGxpbmcgYm90aCBDQS01NSBhbmQNCj4gPiBDTS0z
MyBQcm9iYWJseSBmcm9tIENBLTU1IHBlcnNwZWN0aXZlLCBURi1BIHNob3VsZCBiZSBzdWZmaWNp
ZW50Lg0KPiA+DQo+ID4gRHVyaW5nIGJvb3QgY2xyIFVTQiBQV1IgUkVBRFkgc2lnbmFsIGluIFRG
LUEuDQo+ID4gU1RSIGNhc2UsIHN1c3BlbmQgc2V0IFVTQiBQV1IgUkVBRFkgc2lnbmFsIGluIFRG
LUEuDQo+ID4gU1RSIGNhc2UsIHJlc3VtZSBjbHIgVVNCIFBXUiBSRUFEWSBzaWduYWwgaW4gVEYt
QS4NCj4gDQo+IEFzIEkgc2FpZCBwcmV2aW91c2x5LCBpdCBjYW4gYmUgZG9uZSBpbiBkaWZmZXJl
bnQgd2F5cy4gTXkgcG9pbnQgd2FzIHRvIGxldCBMaW51eCBzZXQgd2hhdCBpdCBuZWVkcw0KPiBm
b3IgYWxsIGl0J3MgZGV2aWNlcyB0byB3b3JrLiBJIHRoaW5rIHRoZSB3YXkgdG8gZ28gZm9yd2Fy
ZCBpcyBhIG1haW50YWluZXIgZGVjaXNpb24uDQoNCg0KSSBhZ3JlZSwgdGhlcmUgY2FuIGJlIG4g
bnVtYmVyIG9mIHNvbHV0aW9uIGZvciBhIHByb2JsZW0uDQoNClNpbmNlIHlvdSBtb2RlbGxlZCBz
eXN0ZW0gc3RhdGUgc2lnbmFsIChVU0IgUFdSUkRZKSBhcyByZXNldCBjb250cm9sIHNpZ25hbCwg
aXQgaXMgcmVzZXQvRFQgbWFpbnRhaW5lcidzIGRlY2lzaW9uDQp0byBzYXkgdGhlIGZpbmFsIHdv
cmQgd2hldGhlciB0aGlzIHNpZ25hbCBmaXRzIGluIHJlc2V0IHN5c3RlbSBmcmFtZXdvcmsgb3Ig
bm90Pw0KDQpDaGVlcnMsDQpiaWp1DQo=

