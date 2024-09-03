Return-Path: <linux-pm+bounces-13383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7363596951A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 09:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037ED1F23F9D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 07:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5446F1DAC6D;
	Tue,  3 Sep 2024 07:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="O91aNOBa"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010051.outbound.protection.outlook.com [52.101.229.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5C11DAC67;
	Tue,  3 Sep 2024 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347896; cv=fail; b=lJRmOUWXq79goYBwkZMd1uIIHjq/Z15lvhU1RzOhbe245stqwZjnxKSPEiRXfQr1UBcYz/rm3jaGlZ6fpoaf5nEchpAtJ9yfH7zsLk28q4ZyFm0FJgnsA6TvKhZqiPjbqH/URuIYDE2UKcxA4hjic+GW652/e3yLiRVj+jH2RlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347896; c=relaxed/simple;
	bh=vPX2/0eNT/wo1ZF1F1pFjrV3W90VLS2RU05/Evwp4Bk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KzvIlix1GSIlKlpVi5CdzkBVXqAPbHCXUJo7G0TCNh52CC4lcSAHCQ+Is6bzKPqV9Liw293NlvhmqmhpGnbd3XL45ZwWziNk9VXkatB4agc8AVOYmJWoJgcSlCp2FR0XpPAOLngKvlf2D5rNeMPLZaWorE4Jtlqa8Fqjrqu7dko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=O91aNOBa; arc=fail smtp.client-ip=52.101.229.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syD0PmtFOSsyYp4aI6zKqBDUiOFMvkCPu3FkU1zmuwBN5LdnRQY6R4VsM6VdqETCUdcLSHirmnHbV9xCooXW7sOWjOZB2BuT2nT2YL2MaHnoeIVQNYLqEHg7lznI3td4I4xQt2V6q7uyOnsevLPiqkKSoU7FYKB5AwpYXKXAgm5OOq5zA5GTgnH3yOmlQ9IPUPvgGI8FK9o+CuGkTJgv/OJp6IUoxWfKaJiY99oU++SYAyRHGTmvk46SszjcQ5WTVrAMV+R5tmTGgD3Dm/oyVOliVjVVWSfA4iCORijuzJyQqfBWG2n8dJLKO/9eCJWNtZvdFTp8YnucGXZXAUrm+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPX2/0eNT/wo1ZF1F1pFjrV3W90VLS2RU05/Evwp4Bk=;
 b=Q8r/dOIv6E9AE0s+ERlYMEPNu1eJKxSCCkLbgU6GS4pCd+tVtjCpcw20MZzwV0dCWZJcg+Kjaq5aU55sQuKPsxMNh9IPyGrVOLq924sVIEi2kTlOSswTm5yeLEIMKlekJXXXoP7uY5/fRZu8p+K1+F5ne8VGFDu8zjSCrs+5d/BqZWyJiU8yX1AmVFmKmbZpcJ9n8DceTL0xvCelDaomJlPksj54P/YD3Gh/w9bWHKrc+uBh0ZfBhUeDqnB9K2+HjrN9bP23dEgMy6vaGdesVeEFRNW7NEBjNM9yUbLIXufQh5g94bdGzdc+tM+j3wI1XqtTdJ5PRdZeEWRYj9AN3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPX2/0eNT/wo1ZF1F1pFjrV3W90VLS2RU05/Evwp4Bk=;
 b=O91aNOBakQgBUnE79tHwDa0Z3lWxVUAybv8DtgvbNh3+QBDi0RRZ8fZHINbkG6V42uQiGRV9xl30VJKNJ+7j63+ZkYfqlmwuQ0rdC2APGSvqI7TaRhP/5pfkek4KcNcH4OTP1+BjwPe7aHGAk3THHOcfXFWF59kQtcWfDQMmSTQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB12167.jpnprd01.prod.outlook.com (2603:1096:604:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Tue, 3 Sep
 2024 07:18:07 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 07:18:07 +0000
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
 AQHa9KfrLpE8CCuWg0uaPyaAgZR3ArI+ZjUAgAEcCoCAAVgqEIADVdkwgAAP5ACAAACycIAABtQAgAAAhkCAABeagIAAAFcwgAFU0LA=
Date: Tue, 3 Sep 2024 07:18:07 +0000
Message-ID:
 <TY3PR01MB1134648BF51F1B52BFE34DD6D86932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
In-Reply-To:
 <TY3PR01MB11346A4814F83FE296A1DED8886922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB12167:EE_
x-ms-office365-filtering-correlation-id: b6be4c32-6a5b-4dc0-93a9-08dccbe88f0d
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K0RxZzh5OWVBOVhjTzhFR285R043Y1lvdzlnVjcwdmNCRmNsbG5zQ01rWHVW?=
 =?utf-8?B?di9zMklkOStNUmIwQWwxVmtpVW1BS1I4eWVyRlhJWktYY0l3c1UzS2FiU3p3?=
 =?utf-8?B?Q1FLMjJPVzdHa0JkSWcxVCtycVFVbWtIU2ZsMzJoZm1ZdUMxd2NlVEg2bnFU?=
 =?utf-8?B?Yk8zSzRzRERsR0dNVTJGeXVqZWVGWmNzVllRazdRTktkTHhlSDgwdGdnaGdi?=
 =?utf-8?B?dnQ1RTRQTkw5bW5meG1PWFdzTm1wU05TMnJteXo2SWh5c3JnSFlJWUVEVzRG?=
 =?utf-8?B?QXJabklVcVpXZDVnVjROekdsYXk5Rm1QcHRwYVFXZ1JMam9XSHYyN0tQM2Vy?=
 =?utf-8?B?V1Q0dUcrZ1JpNnloYlVWeXhWV25TMEtxL2k4OGhHeWxBYm9lN3hzRXdPeVpT?=
 =?utf-8?B?cHphQnFrc1hqZzJMM2FKbnk0d3gzbFJkTk1SQTVGb1hXQUcxVlREQ0NuWkdG?=
 =?utf-8?B?dUtZL3J4OUFoMmwyTXQrTWtkaUx6NHlNRG5NdUZ2WHp1TGoyOTB5b3dET0dG?=
 =?utf-8?B?bnJDMzJYa0VXUjNuQ0NPS2l5d3FrZXZhOGZja2dXOHFHNXhPWElXTzdXL0FJ?=
 =?utf-8?B?ZkZRcFBabXR5VG5LaDMyQU1jcmFWajJEOWpjUmFROTkra3hIUmJPMHZ2T1Zy?=
 =?utf-8?B?ODdHS0VEaUkrMHFia2tSUmNVVFlGNDE5WTJyWDYyR1dsTmtMMkRmNG5TSXF4?=
 =?utf-8?B?Z1JjVUlMa1BLb2JkTkJVUzd5cXRybnlabjFCOXZzdXFCY1JDSWdaSU5rUm1H?=
 =?utf-8?B?TC9PL1hUckt4SlNPS3FiYlZ6emRVelh4ZXV3Wmp5dEVEc3F2TnRmWUkyUDlP?=
 =?utf-8?B?OFgybEwwSmZIT0crSXAraUVKQzU4SmNZMGNkWHIxR09wcmU4MERoektmR0Zr?=
 =?utf-8?B?NGpzKzNobkIzUXJUb3hsVGhFb1cwdGVMeXp3YTVyT3hReDlFWGw5ZFpWM0Jp?=
 =?utf-8?B?clh3Q0ZPR1J4MnhwVzg3TjVTRHd0MHhYK3BOSnEwUGRxd0l1dWI3WkwxRGU4?=
 =?utf-8?B?NVA1RHMvaHpwaXV5S2pxNnVoSU9FUEdvS1R5NUh2Y295R3IzL2hxUnFnZUdy?=
 =?utf-8?B?ZGVVQmxLMk5yS0VwZEVFQ3gwMDJYSlpJYlNlQmNBd0I0VWJ6WnpRWG9XTUxI?=
 =?utf-8?B?aFRHVitPVTNyUjFLeU5PL0RYR0IyMlFxa0x6dWdzeG9LQWpyQW1idWZlTFlM?=
 =?utf-8?B?SWdiRW5iZGN4aGNyU3ZoNlV2cHN4VjJ5enV0V0Jqbmc4bG5XdEFGQzZ6U0l2?=
 =?utf-8?B?QWZjYkUrZFJpTXRnaFVOZVEwL2MrbWxwcHNEYjBaTDFGZHNvbUF6NzVhVCtk?=
 =?utf-8?B?VXUyb3hMZXFGVzNmKzVjMnlpS0gzL0daM1l6dTFMMmFMZGFVSnhtbUdkOXJB?=
 =?utf-8?B?dzYrRFZzQXdQREo2d05DTVRMR1RsUVFGT1I1c2cxM2lCMXhVbVlyaWZKakYv?=
 =?utf-8?B?OGNaTDExLzV6aVVFSno2ZTN2NW8yRFNHdkxldDZNT3pJRENQQWxSUVNFTHFz?=
 =?utf-8?B?OGRUMG1qanJqa0YxYXhBenNGQWJuTzBVKzN2S1lYTzlZb2FDd1pnZ0M5T2ZJ?=
 =?utf-8?B?cW1mdGhFT0ZPVlVjVThmM3BUbjVyTGpMOTJpSEtnL3dmaWF2enFYblRNaGFL?=
 =?utf-8?B?SWlCbnJjS1JhOGdNbDN4UFNzcWtGK00vd2QrRUJFSEdWZk9RMnNlUzYrejFP?=
 =?utf-8?B?QlRBYkZCRDlRQm12bHdlRHJ4anMzSkFYTDZFOE9KS0xMd1BaL1YxVUNvMi84?=
 =?utf-8?B?TlV6TFlNSUNma0Q4UlM3TjVTa0dCY29aK2VXM05xaWZMMUFmdVVtaEM1N2Jx?=
 =?utf-8?B?QzNKYzJ5V2tiUU5CZVFLTjQvN0pEU3JNbmRNU0NnTVNXWXRxL1lpQmtNcGd1?=
 =?utf-8?B?QXVCalNSNXJhUXRDdmhzV1ZMRnM5VVhmYlJXUzhNWGFrTnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXhPb25JaG9KRHlUTHowWUtvcmdkZ3oyNTRaRldjNWJ3WXYvazlBWm9IK3dB?=
 =?utf-8?B?bXRGNUtFbHhzTThZMGREVEZ5ZFhLclo3T1FwcHFmd3F3OWYyYWd0ZlBhNWJY?=
 =?utf-8?B?YXduRVI1UVY5VDFONUNsd1BJK1FGOHdPQ1RJUVJES3hza2lKNS9vY1UzUitE?=
 =?utf-8?B?ekgvOWhCQ0czSndPa3BIUlpvU2JXai9XbTBXL2V4NWlNK3ZKcFV2SHY2ZmxT?=
 =?utf-8?B?V0EyRVpYcGs4RmdSQnJ4Um03MDBMRHN0U3RENXUwZjdPMDUwb01sQkt2RGRX?=
 =?utf-8?B?NFlDaUc2OWFhYnZxQ3BGRHhvQ09ZOUhxb3Z0ZENTV3FUYktpQUh4dTNCL2o1?=
 =?utf-8?B?M2gvNzQwZ2R6TnRldmlxdGthUDBPalROVi8vL0ZtYzN0Si9UTmtZU29RMzVV?=
 =?utf-8?B?eEM2YStWczQ4S0RsU3E3cU9zWGltL2lvbCtVcjNVanpPOVUwVFZHeElvbUNK?=
 =?utf-8?B?SFJ2U1ZzUzRJRlE1L0tSZFpPUjA4VGIxYW4vNGxWdHAxSUQ2SlgrVjZHTHds?=
 =?utf-8?B?cEZmOGU3Z1pLVWErNXgyV21paTE1WnRVZFNoditPMU52K2pQRzk3bjF2UkhO?=
 =?utf-8?B?VFMxMjhYaHlSZytSbktndWZFZEE2LzlZVllMREh6ZHA0dUQzWUUweHE2Y0pN?=
 =?utf-8?B?cm9LQjNrNEFneE56clk5Zk55WjNXKzZwRGxiT1NsNnFpOWZScXJxbEwwc3Fa?=
 =?utf-8?B?dW1QaC9aMUN1SjlMTHJLZFZwQUxKS3RuU0hhTXg2VFYwMGZYNm1xM3ZUOVBh?=
 =?utf-8?B?aEFCaHdobHhRWGZ0RXVFdjJITy9aQ3QvbWE0b2NkRHB1dXp2VndmZGdDclpU?=
 =?utf-8?B?aWdtU1AvWC9RVThGOS91aVpxM1dzcFlmdjBnV0toMWhJQmFSdWxCMGlTSXRq?=
 =?utf-8?B?RmE5Q0JCZjllSm1EUlBYMmNHaUlYWkw3a0xVOWFnanBUN2J6VDZSTUtWV3pl?=
 =?utf-8?B?dW5zaG91dHRiRnZrWU9UVUdjbUZvRStKekIwQWROQVk4aVlLVGw3eW8zSlVI?=
 =?utf-8?B?TXBGbnBLL21SZk5NOEwvcG5IQ0pWc2RZWHpyVnFBNVBNN1pOYmRvdVliaFhx?=
 =?utf-8?B?c3VTRkQxMmdKb0NIdWJiZCtNS3Q3QWQ5b045RHlTaVczczlMZ0VxSFJPNXZx?=
 =?utf-8?B?QXBvVjhFUjY0cDIwVTA2dUtTWUp0UXZocFBJdXNJR2VaMWNZOTRzQlhjNUdG?=
 =?utf-8?B?RnFHc1lDRU9BZFBFdDZNUjI5Wk1KdE1qZ21FQ1hQdGR4UVVBUlZhOVphcUxl?=
 =?utf-8?B?RkdyK2M5R0hlbytQMHp4UWU2b3ovek5KQjVoM3BvbU1pcUNLbzFveXNNcEta?=
 =?utf-8?B?bDBSNExjR05LR1ZNYmRRVTd2My9LRFNrcmlkeFFIOGpjb0RPYmcvM0lFazZ6?=
 =?utf-8?B?T0dnUDFXTnhkTExWdWsza2ZNS1ZzODVNRXpRdkd1YlhEK2NJb0xQbS9sWGJN?=
 =?utf-8?B?U1ZSbkxwYXdTVkhZVlRWWGRXSExJaEVBc0RZQ1VnL3YxQWJTR1F4dG94SW5Q?=
 =?utf-8?B?dnFvWk1OWGVkQjRtQzkvZ0c3NkVlYkdOcUFDOWlXbE9uWC9Gb2xZM0EzUlc0?=
 =?utf-8?B?bURwYSsvVG43b2dPWXU4WTZ3Z3pwYTNTSVFIampPNTJ3Wk8raWFKcWtmNnM3?=
 =?utf-8?B?Vi9LNUd3dWEyZWo4YWtIdm1BSXRYWFlZNjQ2YlI3clJvZlFhZHg2bEJGT0p0?=
 =?utf-8?B?TmVKV0RrWW9QanlqVkZBbUlLVkdsNXNjOTNoWlk5OW4ydk9qZVlzS2o2RXVE?=
 =?utf-8?B?WEVrT0M4UUR1VXRmb2owKzBTakdFZ0R6d21LZ3BEZjA0NVhSR3JVd1RDQWxx?=
 =?utf-8?B?Sm44U04wSityWWJCSUVwVitpRjQyT25SdEthdlQxb2FoRDBZdW80OHJKdWZX?=
 =?utf-8?B?ZkhJbS9aWDgwYXI5MXRuWGY5UVNYemprTVhyQW1xZ0FOQ2FUbjFNOHdmaWdh?=
 =?utf-8?B?M3ZVcmJRaFpOZjFKSjh6aEI2TjIyejVmRk5aZDRlS3RaRmdVSTUvRm5WeGNX?=
 =?utf-8?B?SmJDYVgrYzcrMFp0akxBaFFYRElpcmo3N0ovQ09uMmFWcjRCNlZnZStuWGRB?=
 =?utf-8?B?RFhDQmxLM3gwZnFaeFhRZE8ycWRvNG5qWHZNOC9aeTI4VFZIaDBBck1GZGlG?=
 =?utf-8?B?NTRZdTNxQ2dHQ09IVCtrTGtKcmxzbFE0ZEZ3UjRLS1c1Y2N6ODJaK3Q3S1BS?=
 =?utf-8?B?c3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b6be4c32-6a5b-4dc0-93a9-08dccbe88f0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 07:18:07.2351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3x2Ysx7OfXXDvtroEvg/S1IRoomN0Pfomehy5s8pw5Kk7CbuZCMzjm3HAq0W5FTD7vyqAwERaMFOtDY3oRhZqPw4UCezPrbwxe0T4eE6AC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12167

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCaWp1
IERhcw0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAyLCAyMDI0IDExOjQ4IEFNDQo+IFN1Ympl
Y3Q6IFJFOiBbUEFUQ0ggMDAvMTZdIEFkZCBpbml0aWFsIFVTQiBzdXBwb3J0IGZvciB0aGUgUmVu
ZXNhcyBSWi9HM1MgU29DDQo+IA0KPiBIaSBDbGF1ZGl1LA0KPiANCj4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IGNsYXVkaXUgYmV6bmVhIDxjbGF1ZGl1LmJlem5lYUB0
dXhvbi5kZXY+DQo+ID4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMiwgMjAyNCAxMTo0MSBBTQ0K
PiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDAvMTZdIEFkZCBpbml0aWFsIFVTQiBzdXBwb3J0IGZv
ciB0aGUgUmVuZXNhcw0KPiA+IFJaL0czUyBTb0MNCj4gPg0KPiA+DQo+ID4NCj4gPiBPbiAwMi4w
OS4yMDI0IDEyOjE4LCBCaWp1IERhcyB3cm90ZToNCj4gPiA+Pj4+PiBEbyB5b3UgaGF2ZSBhbnkg
cGxhbiB0byBjb250cm9sIHRoaXMgcG93ZXIgdHJhbnNpdGlvbnMoQUxMX09OIHRvIEFXTyBhbmQg
dmljZSB2ZXJzYSkgaW4gbGludXg/DQo+ID4gPj4+PiBBcyB5b3Uga25vdywgdGhlIFJaL0czUyBV
U0IgUE0gY29kZSBpcyBhbHJlYWR5IHByZXBhcmVkLiBUaGlzIGlzDQo+ID4gPj4+PiBhbHNvIGNv
bmZpZ3VyaW5nIHRoZXNlIHNpZ25hbHMgd2hlbiBnb2luZyB0byBzdXNwZW5kL2V4aXRpbmcgZnJv
bSByZXN1bWUuDQo+ID4gPj4+PiBXL28gY29uZmlndXJpbmcgcHJvcGVybHkgdGhlc2Ugc2lnbmFs
cyB0aGUgVVNCIGlzIG5vdCB3b3JraW5nIGFmdGVyIGEgc3VzcGVuZC9yZXN1bWUgY3ljbGUuDQo+
ID4gPj4+IE9uZSBvcHRpb24gaXMgdG8gaGFuZGxlIFNZU0MgVVNCIFBXUlJEWSBzaWduYWwgaW4g
VEYtQSwgaWYgeW91DQo+ID4gPj4+IHBsYW4gdG8gaGFuZGxlIHN5c3RlbSB0cmFuc2l0aW9ucw0K
PiA+ID4+IHRoZXJlPz8NCj4gPiA+Pg0KPiA+ID4+IEFzIEkgbWVudGlvbmVkLCB0aGUgc2V0dGlu
Z3MgaW4gdGhlc2UgcmVnaXN0ZXJzIG1heSBiZSBjaGFuZ2VkIGJ5DQo+ID4gPj4gaW50ZXJtZWRp
YXJ5IGJvb3RpbmcNCj4gPiBhcHBsaWNhdGlvbnMuDQo+ID4gPj4gRGVwZW5kaW5nIG9uIHRoYXQs
IExpbnV4IG5lZWQgdG8gY29udHJvbCBpdCBhbHNvIG9uIHByb2JlIGZvciBVU0INCj4gPiA+PiB0
byB3b3JrIChpdCBzaG91bGQgYmUgdGhlIHNhbWUgd2l0aCBQQ0llLCB0aGVzZSBzaWduYWxzIHNl
ZW1zIHNpbWlsYXIgZnJvbSBIVyBtYW51YWwNCj4gZGVzY3JpcHRpb24pLg0KPiA+ID4gWW91IG1l
YW4gc3lzdGVtIHRyYW5zaXRpb24gc2V0dGluZ3Mgd2lsbCBiZSBvdmVycmlkZSBieSBVLWJvb3Qs
IHNvIExpbnV4IG5lZWRzIHRvIHJlc3RvcmUgaXQNCj4gYmFjaz8/DQo+ID4NCj4gPiBJdCB3YXMg
dGFsa2luZyBhYm91dCBib290aW5nLi4uDQo+IA0KPiBJIGFtIGFsc28gcmVmZXJyaW5nIHRvIGJv
b3QuIEJvb3Qgc3RhcnRzIHdpdGggVEYtQSBhbmQgaXQgaGFzIGEgc3lzdGVtIHN0YXRlLg0KPiAN
Cj4gPg0KPiA+IFlvdSBwcm9wb3NlZCB0byBoYW5kbGUgU1lTQyBzaWduYWxzIGZyb20gVEYtQSBp
biBhIGRpc2N1c3Npb24gYWJvdXQgc3lzdGVtIHBvd2VyIHRyYW5zaXRpb25zOg0KPiA+DQo+ID4g
Ik9uZSBvcHRpb24gaXMgdG8gaGFuZGxlIFNZU0MgVVNCIFBXUlJEWSBzaWduYWwgaW4gVEYtQSwg
IGlmIHlvdSBwbGFuIHRvIGhhbmRsZSBzeXN0ZW0gdHJhbnNpdGlvbnMiDQo+ID4NCj4gPiAoSSB3
YXMgZ3Vlc3NpbmcgdGhlICJzeXN0ZW0gdHJhbnNpdGlvbiIgc3RhdGVtZW50IHRoZXJlIHJlZmVy
cyB0bw0KPiA+IHBvd2VyIHN0YXRlcyB0cmFuc2l0aW9ucywgQUxMX09OIDwtPg0KPiA+IEFXTy9W
QkFUKQ0KPiANCj4gVGhhdCBpcyBjb3JyZWN0Lg0KPiANCj4gPg0KPiA+IGFuZCBJIGdhdmUgdGhl
IGJvb3RpbmcgcHJvY2VzcyBhcyBhIGNvdW50ZXIgZXhhbXBsZTogaWYgd2UgaGFuZGxlIGl0DQo+
ID4gaW4gVEYtQSBpdCBtYXkgbm90IGJlIGVub3VnaCBhcyB0aGVzZSBzaWduYWxzIG1pZ2h0IGJl
IGNoYW5nZWQgYnkgaW50ZXJtZWRpYXJ5IGJvb3RpbmcgYXBwbGljYXRpb25zDQo+IChlLmcuLCBV
LUJvb3QpLg0KPiANCj4gV2h5IHNob3VsZCBVLWJvb3Qgb3ZlcnJpZGUsIHN5c3RlbSBzdGF0ZSBz
aWduYWxzIHN1Y2ggYXMgVVNCIFBXUlJFQURZPyBDYW4geW91IHBsZWFzZSBnaXZlIGFuIGV4YW1w
bGUuDQo+IA0KPiA+DQo+ID4gVG8gY29uY2x1ZGUsIHRoZXJlIGFyZSAzIHNjZW5hcmlvcyBJIHNl
ZSB3aGVyZSB0aGVzZSBzaWduYWxzIG5lZWQgdG8NCj4gPiBiZQ0KPiA+IGhhbmRsZWQ6DQo+ID4g
MS8gYm9vdGluZw0KPiA+IDIvIHN1c3BlbmQgdG8gUkFNDQo+ID4gMy8gZHJpdmVyIHVuYmluZC9i
aW5kDQo+IA0KPiAtLT4gSXQgc2hvdWxkIGJlIE9LIGFzIGxpbnV4IGlzIG5vdCBoYW5kbGluZyBV
U0IgUFdSUkVBRFkgc2lnbmFsLg0KPiANCj4gPg0KPiA+IEluIGNhc2Ugb2YgYm9vdGluZzogaWYg
d2UgaGF2ZSBURi1BIHRvIHNldCBzaWduYWxzIHRoZXJlIG1pZ2h0IGJlDQo+ID4gaW50ZXJtZWRp
YXJ5IGJvb3RpbmcgYXBwbGljYXRpb25zIChlLmcuIFUtQm9vdCkgdGhhdCBzZXQgdGhlc2Ugc2ln
bmFscw0KPiA+IGFsc28uIElmIGl0IGxlYXZlcyBpdCBpbiBpbXByb3BlciBzdGF0ZSBhbmQgTGlu
dXggd2FudHMgdG8gdXNlIFVTQiB0aGVuIHRoZSBVU0Igd2lsbCBub3Qgd29yayAoaWYNCj4gTGlu
dXggZG9lc24ndCBoYW5kbGUgaXQpLg0KPiANCj4gVGhhdCBpcyB0aGUgcHJvYmxlbSBvZiBVLWJv
b3QuIFUtYm9vdCBzaG91bGQgbm90IG92ZXJyaWRlIHN5c3RlbSBzdGF0ZSBzaWduYWxzIHN1Y2gg
YXMgVVNCIFBXUlJFQURZLg0KPiANCj4gPg0KPiA+IEluIGNhc2Ugb2Ygc3VzcGVuZCB0byBSQU06
IGFzIFRGLUEgaXMgdGhlIG9ubHkgYXBwbGljYXRpb24gaW4gdGhlDQo+ID4gc3VzcGVuZCB0byBS
QU0gY2hhaW4sIGl0IHNob3VsZCB3b3JrIGhhbmRsaW5nIGl0IGluIFRGLUEuDQo+IA0KPiBUaGF0
IGlzIGNvcnJlY3QsIFRGLUEgc2hvdWxkIGhhbmRsZSBiYXNlZCBvbiBzeXN0ZW0gc3RhdGUuDQo+
IA0KPiA+DQo+ID4gSW4gY2FzZSBvZiB1bmJpbmQvYmluZDogY3VycmVudGx5IHdlIGRvbid0IGtu
b3cgaWYgdGhlc2Ugc2lnbmFscw0KPiA+IGludHJvZHVjZXMgYW55IGtpbmQgb2YgcG93ZXIgc2F2
aW5nIHNvIGFzc2VydGluZy9kZS1hc3NlcnRpbmcgdGhlbSBpbiBMaW51eCBtYXkgYmUgdXNlZnVs
IGZyb20gdGhpcw0KPiBwZXJzcGVjdGl2ZSwgaWYgYW55Lg0KPiANCj4gVGhlc2UgYXJlIHN5c3Rl
bSBzaWduYWxzLCBhY2NvcmRpbmcgdG8gbWUgc2hvdWxkIG5vdCBiZSB1c2VkIGluIHVuYmluZC9i
aW5kLg0KPiANCj4gSSBtYXkgYmUgd3JvbmcuDQoNCkp1c3QgdG8gYWRkIHRoZSBiZWxvdyBhcmUg
dGhlIDQgc3lzdGVtIHN0YXRlcyAocG93ZXIgbW9kZSkgZm9yIHRoaXMgTFNJLg0KDQpJZiBJIHVu
ZGVyc3RhbmQgY29ycmVjdGx5LCB3ZSBuZWVkIHRvIGNvbmZpZ3VyZSBVU0IgUFdSUkRZIHNpZ25h
bA0Kb25seSB3aGVuIHRoZXJlIGlzIGEgdHJhbnNpdGlvbiBmcm9tIEFMTF9PTiB0byBBV08gbW9k
ZSBhbmQgdmljZSB2ZXJzYS4NCmFzIHlvdSBzZWUgb24gQVdPIG1vZGUgb25seSBDTS0zMyBpcyBh
Y3RpdmUuDQoNCuKAoiBBTExfT0ZGIG1vZGU6IEFsbCBDUFVzIGFuZCBwZXJpcGhlcmFsIG1vZHVs
ZXMgY2FuIG5vdCBiZSB3b3JrZWQuDQrigKIgQUxMX09OIG1vZGU6IEFsbCBDUFVzIGFuZCBwZXJp
cGhlcmFsIG1vZHVsZXMgY2FuIGJlIHdvcmtlZC4NCuKAoiBBV08gbW9kZTogQ29ydGV4LU0zMyBh
bmQgcGVyaXBoZXJhbCBtb2R1bGVzIGluIFBEX1ZDQyBhbmQgUERfVkJBVFQgZG9tYWluIGNhbiBi
ZSB3b3JrZWQuDQrigKIgVkJBVFQgbW9kZTogT25seSBSVEMsIHRhbXBlciBkZXRlY3Rpb24gYW5k
IGJhY2t1cCByZWdpc3RlcnMgY2FuIGJlIHdvcmtlZC4NCg0KU3lzdGVtIG1hbmFnZXIgd2hpY2gg
aXMgY29udHJvbGxpbmcgYm90aCBDQS01NSBhbmQgQ00tMzMsIHdpbGwgc2V0IFVTQiBQV1JSRFkg
c2lnbmFsDQpiYXNlZCBvbiBzeXN0ZW0gc3RhdGUuDQoNClNpbmNlIHdlIGRvbid0IGhhdmUgc3lz
dGVtIG1hbmFnZXIgZm9yIGNvbnRyb2xsaW5nIGJvdGggQ0EtNTUgYW5kIENNLTMzDQpQcm9iYWJs
eSBmcm9tIENBLTU1IHBlcnNwZWN0aXZlLCBURi1BIHNob3VsZCBiZSBzdWZmaWNpZW50Lg0KDQpE
dXJpbmcgYm9vdCBjbHIgVVNCIFBXUiBSRUFEWSBzaWduYWwgaW4gVEYtQS4NClNUUiBjYXNlLCBz
dXNwZW5kIHNldCBVU0IgUFdSIFJFQURZIHNpZ25hbCBpbiBURi1BLg0KU1RSIGNhc2UsIHJlc3Vt
ZSBjbHIgVVNCIFBXUiBSRUFEWSBzaWduYWwgaW4gVEYtQS4NCg0KSSBhbSBub3QgZXhwZXJ0IGlu
IHRoaXMgYXJlYS4gSSBtYXkgYmUgd3JvbmcuDQoNCk1heWJlIHdlIG5lZWQgdG8gZ2V0IGFuIG9w
aW5pb24gZnJvbSBQb3dlciBleHBlcnRzIGluIExpbnV4Lg0KDQpDaGVlcnMsDQpCaWp1DQo=

