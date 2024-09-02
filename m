Return-Path: <linux-pm+bounces-13319-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A37F9680FF
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 09:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B80A1C21F66
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 07:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8DF176FD2;
	Mon,  2 Sep 2024 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="UHuTEmrx"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010017.outbound.protection.outlook.com [52.101.229.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66693C00;
	Mon,  2 Sep 2024 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725263657; cv=fail; b=Z0coUzCU3AwbJTSWVkcYxVUTm7AHLQCuNgyKI5rlXtuCx7RUwCYK1zhdlOG/VRO91moyoLGd/CWFu1NhorESYgba3TOKkXXL3HimXR5j58zBpPbAXjGbLXEqVRKMfN2a6lHAzCljf6f1uyJOPR53zfIoSw5t4GFJyDp9RqakrGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725263657; c=relaxed/simple;
	bh=V7zKAseahiwC5XSZB+kVh8DIDGUDMabcburxif6c/VE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GcjhKKjx5RTN/WV+oMGbHTp6zRR02lMC/DPC4vgaF2hCZzEbT4BjpftO6ry61I6anxppOm1zgLMZl66FNowSyxhLtJVf9q18u8Vu8pgLhFPD7bUFRUoYHZrFT1G++RKx2cK3/ET9rSIRzfLEv2e2ZzmCCKXerqwp/EHZuw1ZhNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=UHuTEmrx; arc=fail smtp.client-ip=52.101.229.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fp46+oc4rcjbg/dP06zUPxh4ff7AI8FvvN6QtLDIEf3/VIm5SrCFZk6AnZl5t1l6W1QW4c5Ay37zHO8xyN/eJhzv5k6EFecG08zLX61JU1mrW6JGM7siNDm0Iw2aCT3nG4oVIGxB7X7MlWjnMrOj+Plgur+fSdnoXi6aPe/JNT7gr2JiRQ4+ZEMn3CpFQk/29M+8vGPajEYSi/oHg0NyZdvMwGvh+m0gQB5m7ht9mB498tyn3T+uhBIa/AM10VZmKb7iXyAYJFAa+IgSAqJj6TckX61UHPCKWGnArFVm/lDlD6Npgwr+4b441XKJNCy0Enapu/fmRD9eS4sl+coJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7zKAseahiwC5XSZB+kVh8DIDGUDMabcburxif6c/VE=;
 b=wWbgqgM7qJovNHts7Gi428zZJ+WfcLzdD7XYVu9BGooi3hpneNt76APfkkYFSyGBAYCXLXUJaLaN83WS1h6PmKTkOVBfWJNR7NOp5Rxdf6WVYn6lCVcScAq0wL3/gwXaOlsS7XWeJ/8c1tgtEyoYdo4rPQKMR9TO1lR7eGZzBwAWk04TjXxeJxj4fmlNFlVSOHs3Hvg4fBg8l+hl0frAigeqVgPTNUbm37jhtOp5o3W23PXK9SXFgu3rQiLmPmGr6p5SSpz56AIOwjEkf5CkXY7fGLCNFgj86M2/Eps0lywCMpTME4FuxZSlqXRmoVxNOiLGGhdZuFjED0ahmkGJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7zKAseahiwC5XSZB+kVh8DIDGUDMabcburxif6c/VE=;
 b=UHuTEmrxqLxzdmC2vWxBl2Ui1pk/IMovc2pLLiSTDD9LT3aybcVDAerswcMSdGo+WW8psMr7aZQAxLl14HWLoryV87fURhTB2dpkwukFjrio9Hmc0CWZN+fUlyJGDNH65lLtw2m8n0DuoTo6mswoh26ygDMttWtKXZWWwsRv8Eg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB10110.jpnprd01.prod.outlook.com (2603:1096:400:1d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 07:54:09 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 07:54:09 +0000
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
Thread-Index: AQHa9KfrLpE8CCuWg0uaPyaAgZR3ArI+ZjUAgAEcCoCAAVgqEIADVdkw
Date: Mon, 2 Sep 2024 07:54:09 +0000
Message-ID:
 <TY3PR01MB113467275C519B729FCAB1ACB86922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFrS4Dhd7DZa2zz=oPro1TiTJFix0awzzzp8Qatm-8Z2Ug@mail.gmail.com>
 <99bef301-9f6c-4797-b47e-c83e56dfbda9@tuxon.dev>
 <TY3PR01MB1134652F9587CFA0ADE851CA486902@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB1134652F9587CFA0ADE851CA486902@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB10110:EE_
x-ms-office365-filtering-correlation-id: 75b2b442-2da9-43cf-8329-08dccb246d9d
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QkdOcVBUd3UzeGRsZzZjaUpucEM3UjQ3NWo5cUhSTlU3NUdJK1NlMHJTRmFM?=
 =?utf-8?B?RlNTaXVTLzEwMjZkVUE5VC83U0c5YzhodVduSVNDeVZ4OGtyYmlTYVdWbHBS?=
 =?utf-8?B?VWhaM2wvSm1jOU92Z1Y1QmxvTVQ2ZXdzT2VOdldYNkJvOTNTdkxHaFNqZFNW?=
 =?utf-8?B?YlNPU0VxRlRUTGhmR3dUUVZYQ2t6djRDTnlYMEc2NkFtbVNZWjl4Vk9WOXFT?=
 =?utf-8?B?c3AxZjBxQ1RnM29MOGk3ZS9sSjJBODlLSHBUdk1MMEtkaE1KRFRWN3lFbWpV?=
 =?utf-8?B?ditkQW5aU041UkllYVdBbjFiWGtaY3JGdFR2dG1PWmlzR2YxQlBXaldZcUNm?=
 =?utf-8?B?bHMrOGF2c2R2ZVladWFXdS92QnVURVVZTWJCUkoxaGptcjVRWmg2ZWM4TkJW?=
 =?utf-8?B?OUhTUXVsVmFxc2pBOTNxTmRvVi90T09kMDBPQTZDaE1tMlpmWFp1VkFkYVFX?=
 =?utf-8?B?Ly9aRWd3NmN0Nk9FUlhNVmFrZVEzNHdaTUVzRWhqek93WSsxbGpRUDVQb2xt?=
 =?utf-8?B?SUQ5WGgxYWQvcFJIWGlJUmovVFkvOTZ1RUlYMW02ZndvL3M1RWFDRFM1UFIx?=
 =?utf-8?B?WnZoUUhqT0JSUXdDZC9wYWdMTWYyN0I3eVIyU2tsdVdyMDU1OUd2YzBYTldw?=
 =?utf-8?B?UjkzNXNoSncvWk9GSEd1M3JTMXNwVis0WHlBTTRsUGFrK0Q1MittbkdWcXll?=
 =?utf-8?B?T3NJV2s4TTBGRWw0dzZVU1lkeEE0VUlvbERVa1RUSW1ZUGUyb0xtUE52K0Yv?=
 =?utf-8?B?RVRKM00zaWlFU0hMS0ozaUtYVmlLbzRER0NUcm1YRGlDaDlRL0lycGNsbmJs?=
 =?utf-8?B?QS9hZHVHcWQwMVhGMWlWeFY1RUVZRmZ2WVRrbXRydDhXWW1hRFA4WEU4UnRj?=
 =?utf-8?B?aWViL3BBMDBNM1UwT1ZDSHYreVNFblJ2Z3hBMUQ1eFJ6WDVGWEtJRkdYNVc1?=
 =?utf-8?B?a211K3BFNWw0ZThSRGhRVWdoaUhwVkt6bWNMVXBHVkFoQ0NvRlR3QjhUWFFi?=
 =?utf-8?B?OUNuakJiZ2VMdFJBRlhaNXd4eDZ5TWU5R3Joelp5d3FjVm5PQjZWM1Z0Ny9J?=
 =?utf-8?B?SHMvUmxDRkplYlUvWlVjLzZRRzMvTFUxNUNsYUNYV3FUUGgyZkgyc2h0STZn?=
 =?utf-8?B?WGZKWGRCMHhFbjFTbWJCcXVGZ3dxVG9GRzE1S3NDVTNnNVJiSS9CQjBHblU1?=
 =?utf-8?B?Q3RReWt5a0pHdHQ3Z3djd25Db3dQMVI5b3o3RUdXdTJDK1FnckN1Q21mTjNM?=
 =?utf-8?B?bnAzMmJvaWV0R3ZYN3hLeVVRdmlreE5qU0xVQVRlTE5MclZlOXZ1T3ZnQStK?=
 =?utf-8?B?dzVyMUM3MmpqaXoyTVI4cGpPZnVLMkI2RmNPdkpJbG9UeFR5dXJvNzhIMzBv?=
 =?utf-8?B?Qm9EMmRoUnB0eTJLZUxad25zZG1WL3B2R3RzWnBndGx5THlCMmE2TFNKV1M3?=
 =?utf-8?B?T3M0YzE5dTlENHdSSFlOUHpXWTB2MHRnWlVrdUQ5MU9SMS8yMDFLZlY0RnJv?=
 =?utf-8?B?WEVnZm0zelZUbXpDaFBpd1d6ZHp3bmFremo4SVZyckxFZ0IyZlM2SE9sUjRP?=
 =?utf-8?B?bGI5RllHTlk2NGE5cTZEWE9yTWlFVFhlb2V1UEY0WFN6MkdFY3VuaUZldE91?=
 =?utf-8?B?L2g0NjFYTVRHajQ4aGdMRkM0YUJZZXo5bGlGSDY5ckMxLzlETFBtUWJjVVlM?=
 =?utf-8?B?K2NxOGE5WHA3b3VjaDJ5UEI1TkttODE5N291L3VZNVI4cjVKaStYbjNEZm16?=
 =?utf-8?B?TkNkWE1rK08vNVYzOGQ0M0RDbVowOWZ2UWxPb3luVm1DMkcwRkNOSzRBRDhP?=
 =?utf-8?B?aVlndjVkL3FGSzNqUHR1aStXb1FXTVVRalFpSTlxbnpmcllneWJuL281cDhY?=
 =?utf-8?B?NlFnZ0lMcWJIdmxQWFlRYnpFb2RIZEpHaEVkRzdUVGFSaEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHFoUCtsdVZGbVdoQ1VvWXdkdW5Qbk5rWTVCdmdNYWNWWHM3ZWZaTU5qRXB0?=
 =?utf-8?B?RVJDQkFia2NHL1lleU1MRWk1YlVlT0dTQ3hLdTEwdnpDcmZqdExvTktrQlFo?=
 =?utf-8?B?UTMyaGZ0c256TTFNaFhSc3liWXZkSzZKRm5yUThHRTd3MGJ5b28zQ2ROQTA5?=
 =?utf-8?B?NWwwMDBlcjBDeDNHTUFNSzNZVFMzbkRYdTBPMjJLTHE0SGgxcmdrallUY1BU?=
 =?utf-8?B?RW5SRXcxL2FLM0dwS2hoenVidVBVaFdKOGtMWVhSeUpYUU1LSmZMb1FlL09X?=
 =?utf-8?B?ZlhveElvTXZWMGJIeFpaZ3BobFdQYkp6Ykl4RDlBT0QyZGVoREpvcDJFT1A1?=
 =?utf-8?B?RVdtekFuL3l2Q1VJTFk0VGFaTHlLUnF0eVNKTzliakxXRWVscUdFV1pITEJO?=
 =?utf-8?B?UmtxUVV0dkd5VDVlaG5EbXNJUG0xcW1qMzVzdWxiTWtyMTdhTkhteThVbUxO?=
 =?utf-8?B?K3hyKzFWTUU1MnJEZCtxNzk1OXVHUEZRQ0tzWXZOcFZnYmtlMW45WkU4UGxq?=
 =?utf-8?B?VDJGN0RxdXBkYWdzYTRCdzNlUUtCdHdZbVREWk1aKzZBc1hTUENjdjJwV0Q5?=
 =?utf-8?B?aUI1WEJLUG5mTkRwZGlFSkt4WWd5djErQS9BUTNCVzFYL29GWGFUY0lrL2pZ?=
 =?utf-8?B?MnBrRzJ1c0JBbjNmemp6WUdzWXI2VUVmb0ZXanFaNGYzamNyNzkrczVPemRm?=
 =?utf-8?B?UGxZT2pmRDJMY1hwb28velAvRjFjV1FQdFRMVkJQR1YwSldxbkgrL3ArRkpZ?=
 =?utf-8?B?UnY1VHRHV2wrZUZ0YmZtR0U3bUxNckVXRk9SR0tISEEwZnZYODYxYjY2M1FK?=
 =?utf-8?B?cHE0dVRJLzk5TWRPZ1BBdmZVTHl3RnVRbTBQdVZQR1dXMVVCRU1yQjE2SHBi?=
 =?utf-8?B?YU1vUFVUb1Nzb21za0VFT2Vtbkwvc0NOVU04emw3eVlzcUcrdnVQYnpWRkpC?=
 =?utf-8?B?cS9PWldwbmZ0amNmRWFzU25rM29tMVN0bmZTbUJGYzVDeUYxb2FKekFMY2ds?=
 =?utf-8?B?YTVaSlZyMld6dndaOHVIV3VsU091Z3puL3FjY1dITUZRSXlJVUFmSFBGZUN2?=
 =?utf-8?B?K3lKYmsvYmRydGFTQXR1Z05Fc1ZJalArcFkxUFgvSzloVFA5WGM3QktmSU44?=
 =?utf-8?B?Nk45Umo2V003STZHTnFoM1FHNUwxa0lUTnh6R0wyNTQ1WEl1SW9YSnh3S21D?=
 =?utf-8?B?MTZHVEI0ZEcxeFgxbnRndEYrbDgvWFA0OVRHREZDVkZvNXlpMUoxZm94R3JD?=
 =?utf-8?B?RlcwemdvY25NaHY1dGFpMHpzTVRCTG1HTnYwRmR0ZVBjbWc3U3o2L3FCQ0J1?=
 =?utf-8?B?S2VRaHFjdXFudDRZQTY0WUhGUUo1K05IaUx1TE9kcnc1UmJXa0JzTi9Qa0Ew?=
 =?utf-8?B?SzlCeUhDUzBVN2cwdXhOTkM5a2h3K2FtNFg3ei8xK3RhbGpEZGJlR1JXQ1Rs?=
 =?utf-8?B?dUtBZ216S29CNWdsdERkRFBIaHZlMVp3M3V5cWdmZysyMkUyMEV6a25sbWlI?=
 =?utf-8?B?YWs0SXN1cklMUEYxT1grYlllTk0xSjRrVUh6eE5ONkVwT1puL1FZaWtONG9y?=
 =?utf-8?B?UUpSVGFOSHQyYk4rSE5xMHIyOEZ3R2tPUDJrT204eDV2dTgxa01qWUlTZHZL?=
 =?utf-8?B?Q1JmQnp3bUlUOHlLSks2MGVmVlpCYXU3dk9mNDB3bGdaWWQyWmV0Qk15akZH?=
 =?utf-8?B?WDl6Y3ZXSzNkcGdqSEVIWGhjRjIxUk01MnNiSFgvQTdPWHdZbkpwekhYMGdi?=
 =?utf-8?B?VHd5TGNYd25maG00UUR6MWpoVFovUUhOOVJKb0U5eFVjZEgrMm5ZTVNOSERR?=
 =?utf-8?B?MThaS1RhNkYwdlhWYXI5MFViRy8vTFZxKytVZXovcTNkRlJLakQwWjA0QkJp?=
 =?utf-8?B?ZGs5bEMrS0cveVpQTkNzN015SkMxWjZJdUp1b3NlYlZmakhjdVNsa2JNVmZ5?=
 =?utf-8?B?QVk0ZzhtcEczck5NS2RZR2RyRFRoWUw1UnVISkIrWU93ZUd0dzMwaEdwZnN0?=
 =?utf-8?B?RHlYalBoeVFDSldpd1ZmNzdvbHBVazA2Y1BLaGhNbnB2Mlo1ZXFOaFUzVDZ3?=
 =?utf-8?B?a0t3a1JpNUZMTms5b21pRmZWMnJkMk4xZHFsZk5VTHRoK28rby9nOVM5OXNU?=
 =?utf-8?B?UC9DaE1Lc2dSYk9YNC80TWhqRGJYRXpvR2dNcGpzaW84RE9aazAwZ2o4MU1t?=
 =?utf-8?B?MWc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b2b442-2da9-43cf-8329-08dccb246d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 07:54:09.7835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xY77QcpNnolaEE8uPHIh4VtOQXDLfCT7KXMUuibYV2daIxcHFXLSWoNVE9IRMHKWmiUoGZNSHJB/ITIHR3rQZ1SJSv2UUyKj2/qnG3NzGik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10110

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCaWp1
IERhcw0KPiBTZW50OiBTYXR1cmRheSwgQXVndXN0IDMxLCAyMDI0IDY6MTQgQU0NCj4gU3ViamVj
dDogUkU6IFtQQVRDSCAwMC8xNl0gQWRkIGluaXRpYWwgVVNCIHN1cHBvcnQgZm9yIHRoZSBSZW5l
c2FzIFJaL0czUyBTb0MNCj4gDQo+IEhpIENsYXVkaXUsDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogY2xhdWRpdSBiZXpuZWEgPGNsYXVkaXUuYmV6bmVhQHR1
eG9uLmRldj4NCj4gPiBTZW50OiBGcmlkYXksIEF1Z3VzdCAzMCwgMjAyNCA5OjIzIEFNDQo+ID4g
U3ViamVjdDogUmU6IFtQQVRDSCAwMC8xNl0gQWRkIGluaXRpYWwgVVNCIHN1cHBvcnQgZm9yIHRo
ZSBSZW5lc2FzDQo+ID4gUlovRzNTIFNvQw0KPiA+DQo+ID4gSGksIFVsZiwNCj4gPg0KPiA+IE9u
IDI5LjA4LjIwMjQgMTg6MjYsIFVsZiBIYW5zc29uIHdyb3RlOg0KPiA+ID4gT24gVGh1LCAyMiBB
dWcgMjAyNCBhdCAxNzoyOCwgQ2xhdWRpdSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2PiB3cm90
ZToNCj4gPiA+Pg0KPiA+ID4+IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYS51
akBicC5yZW5lc2FzLmNvbT4NCj4gPiA+Pg0KPiA+ID4+IEhpLA0KPiA+ID4+DQo+ID4gPj4gU2Vy
aWVzIGFkZHMgaW5pdGlhbCBVU0Igc3VwcG9ydCBmb3IgdGhlIFJlbmVzYXMgUlovRzNTIFNvQy4N
Cj4gPiA+Pg0KPiA+ID4+IFNlcmllcyBpcyBzcGxpdCBhcyBmb2xsb3dzOg0KPiA+ID4+DQo+ID4g
Pj4gLSBwYXRjaCAwMS8xNiAgICAgICAgICAgLSBhZGQgY2xvY2sgcmVzZXQgYW5kIHBvd2VyIGRv
bWFpbiBzdXBwb3J0IGZvciBVU0INCj4gPiA+PiAtIHBhdGNoIDAyLTA0LzE2ICAgICAgICAtIGFk
ZCByZXNldCBjb250cm9sIHN1cHBvcnQgZm9yIGEgVVNCIHNpZ25hbA0KPiA+ID4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdGhhdCBuZWVkIHRvIGJlIGNvbnRyb2xsZWQgYmVmb3JlL2FmdGVy
DQo+ID4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICB0aGUgcG93ZXIgdG8gVVNCIGFyZWEg
aXMgdHVybmVkIG9uL29mZi4NCj4gPiA+Pg0KPiA+ID4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgUGhpbGlwcCwgVWxmLCBHZWVydCwgYWxsLA0KPiA+ID4+DQo+ID4gPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICBJIGRldGFpbGVkIG15IGFwcHJvYWNoIGZvciB0aGlzIGluIHBhdGNoDQo+
ID4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAwNC8xNiwgcGxlYXNlIGhhdmUgYSBsb29r
IGFuZCBsZXQgbWUga25vdw0KPiA+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgeW91ciBp
bnB1dC4NCj4gPiA+DQo+ID4gPiBJIGhhdmUgbG9va2VkIGJyaWVmbHkuIFlvdXIgc3VnZ2VzdGVk
IGFwcHJvYWNoIG1heSB3b3JrLCBidXQgSSBoYXZlDQo+ID4gPiBhIGZldyB0aG91Z2h0cywgc2Vl
IGJlbG93Lg0KPiA+ID4NCj4gPiA+IElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIGl0IGlzIHRo
ZSBjb25zdW1lciBkcml2ZXIgZm9yIHRoZSBkZXZpY2UNCj4gPiA+IHRoYXQgaXMgYXR0YWNoZWQg
dG8gdGhlIFVTQiBwb3dlciBkb21haW4gdGhhdCBiZWNvbWVzIHJlc3BvbnNpYmxlDQo+ID4gPiBm
b3IgYXNzZXJ0aW5nL2RlLWFzc2VydGluZyB0aGlzIG5ldyBzaWduYWwuIFJpZ2h0Pw0KPiA+DQo+
ID4gUmlnaHQhDQo+ID4NCj4gPiA+DQo+ID4gPiBJbiB0aGlzIHJlZ2FyZCwgcGxlYXNlIG5vdGUg
dGhhdCB0aGUgY29uc3VtZXIgZHJpdmVyIGRvZXNuJ3QgcmVhbGx5DQo+ID4gPiBrbm93IHdoZW4g
dGhlIHBvd2VyIGRvbWFpbiByZWFsbHkgZ2V0cyBwb3dlcmVkLW9uL29mZi4gQ2FsbGluZw0KPiA+
ID4gcG1fcnVudGltZV9nZXR8cHV0KigpIGlzIGRlYWxpbmcgd2l0aCB0aGUgcmVmZXJlbmNlIGNv
dW50aW5nLiBGb3INCj4gPiA+IGV4YW1wbGUsIGEgY2FsbCB0byBwbV9ydW50aW1lX2dldCooKSBq
dXN0IG1ha2VzIHN1cmUgdGhhdCB0aGUgUE0NCj4gPiA+IGRvbWFpbiBnZXRzLW9yLXJlbWFpbnMg
cG93ZXJlZC1vbi4gQ291bGQgdGhpcyBiZSBhIHByb2JsZW0gZnJvbSB0aGUNCj4gPiA+IHJlc2V0
LXNpZ25hbCBwb2ludCBvZiB2aWV3Pw0KPiA+DQo+ID4gSXQgc2hvdWxkIGJlIHNhZmUuIEZyb20g
dGhlIEhXIG1hbnVhbCBJIHVuZGVyc3RhbmQgdGhlIGhhcmR3YXJlIGJsb2NrIGlzIHNvbWV0aGlu
ZyBsaWtlIHRoZQ0KPiBmb2xsb3dpbmc6DQo+ID4NCj4gPg0KPiA+ICAgICAgICAgICAgICAgICAg
IFVTQiBhcmVhDQo+ID4gICAgICAgICAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+ID4g
ICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gICAgICAgICAgfCBQSFkg
LS0tPlVTQiBjb250cm9sbGVyICB8DQo+ID4gU1lTQyAtLT4gfCAgXiAgICAgICAgICAgICAgICAg
ICAgICB8DQo+ID4gICAgICAgICAgfCAgfCAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gICAg
ICAgICAgfCBQSFkgcmVzZXQgICAgICAgICAgICAgICB8DQo+ID4gICAgICAgICAgKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0rDQo+IA0KPiBIb3cgVVNCIFBXUlJEWSBzaWduYWwgaXMgY29ubmVj
dGVkIHRvIFVTQj8NCj4gDQo+IFVTQiBibG9jayBjb25zaXN0cyBvZiBQSFkgY29udHJvbCwgUEhZ
LCBVU0IgSE9TVCBhbmQgVVNCIE9URyBDb250cm9sbGVyIElQcy4NCj4gDQo+IElzIGl0IGNvbm5l
Y3RlZCB0byB0b3AgbGV2ZWwgYmxvY2sgb3IgY29ubmVjdGVkIHRvIGVhY2ggSVAncyBmb3IgdHVy
bmluZyBvZmYgdGhlIFVTQiByZWdpb24gcG93ZXI/DQo+IA0KPiA/IE9yIEp1c3QgUEhZIChIVyBt
YW51YWwgbWVudGlvbnMgZm9yIEFXTywgdGhlIFVTQiBQV1JSRFkgc2lnbmFsLT5VU0IgUEhZIFBX
UlJEWSBzaWduYWwgY29udHJvbCk/DQoNCkFzIHBlciB0aGUgdXBkYXRlIGZyb20gSFcgdGVhbSwN
Cg0KIlNZU19VU0JfUFdSUkRZIGFuZCBTWVNfUENJRV9SU1RfUlNNX0IgYXJlIHVzZWQgd2hlbiB0
cmFuc2l0aW9uIGZyb20gQUxMX09OIHRvIEFXTyAob3IgZnJvbSBBV08gdG8gQUxMX09OKS4NCg0K
UmVmZXIgdG8gc3RlcCA4LDkgaW4gVGFibGUgNDEuMTAgRXhhbXBsZSBUcmFuc2l0aW9uIEZsb3cg
T3V0bGluZSBmcm9tIEFMTF9PTiBNb2RlIHRvIEFXTyBNb2RlLg0KUmVmZXIgdG8gc3RlcCA5LDEw
IGluIFRhYmxlIDQxLjExIEV4YW1wbGUgVHJhbnNpdGlvbiBGbG93IE91dGxpbmUgZnJvbSBBV08g
TW9kZSB0byBBTExfT04gTW9kZS4NCg0KV2hlbiB0dXJuaW5nIG9mZiBVU0IgUEhZIGFuZCBQQ0ll
IFBIWSwgaWYgdGhleSBhcmUgbm90IGNvbnRyb2xsZWQsIFBIWSBtYXkgYnJlYWsuIg0KDQpEbyB5
b3UgaGF2ZSBhbnkgcGxhbiB0byBjb250cm9sIHRoaXMgcG93ZXIgdHJhbnNpdGlvbnMoQUxMX09O
IHRvIEFXTyBhbmQgdmljZSB2ZXJzYSkgaW4gbGludXg/IA0KDQpDaGVlcnMsDQpCaWp1DQogDQo=

