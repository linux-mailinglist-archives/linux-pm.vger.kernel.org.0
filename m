Return-Path: <linux-pm+bounces-21151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE21A23360
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 18:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5621188894C
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 17:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405C31E9B29;
	Thu, 30 Jan 2025 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="mu6/Io3z"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010024.outbound.protection.outlook.com [52.101.229.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74E8145B14;
	Thu, 30 Jan 2025 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738259251; cv=fail; b=sprVaP2Qr9gARlqwbHyDcI40piGt0mxkgm3e5zxdAnL52ewOzYtsZsoX5fuVQxdSuhyUZRpNNz/GsFVyzGhNpUXl0OfoiTVcbcYEHCq96AFjTAVQd85BG9wziw4aO0sqShS4O96nRSovvXeYa6ZqY7IMwAHvFl2dgm3XvCTE9eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738259251; c=relaxed/simple;
	bh=DBKZg1nfSS8ROTkPEHj738uvJUZdn9I4EKsJ3LZvpR8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XN3kzNKATBxfYqxOB8BHkrtrTtVHoIDQhyqGKkBaM3aIZRHQfqUe+kiYQrEO1viQheSi0y1FKB1SFARQf6jtzyE7KzmuxSH1r4f5PYO6TOOyTA3VDAYO8tHZFPKEpHWHPbLZoLJRLwLWGBhk9ZvJTK/LSwdBXos8ZNK+bl5kefM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=mu6/Io3z; arc=fail smtp.client-ip=52.101.229.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrb32KzrTHoML/FaOe/pGc3xleQ202UeylfJ51xrxstvRTo91l7WZQM7ZuKEFEXxCmt7txujedNTXqleSb6b5/lDal79oOu+paXYfj6f9RKFRKJxEZBook5vAnfdd8TSYeZzNXO910AeEA1GTf6AncjR5YCpRYvDb06yCJABkJXEtmSb07hcWgwftgxJUMNoQ8PA7LxdCP6rsalpPoLsX/wYPpDYvoDZxqZYF3YjTE/u6e3YEnUxFTxiVq/rfMMbe+bmwrndWq99pEqFY6lENTHqgB5acgmhPRLH8xwiKszZ37WoC+UUgbmxiIqjZR2iyd3ySwogqyR25Ji88TdwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBKZg1nfSS8ROTkPEHj738uvJUZdn9I4EKsJ3LZvpR8=;
 b=fCcYC1MABl3bgAh1sASUKVmdh9NO5kbn9OVEYPEKiKet9z1VDo4LmWNQpPm6muhKQoSZZczgeUd4NTKFIfT9u62li4AkSm2029NdndeTxTBQnAsJlia7tKzhYe89iTTKxtq/UYiNpJDGMGP8MOHB3MseEdpo+lI+ztmHaM9wBUu0MGG33vpIEJsITjNqMXnkkyI9EAnUpzuuI2puH52iEKzGSS1hDtVzbihEVwmmRJQaYpfIwJObcKKK5dsavSAU93hZUggjMxCfd5IfVnbSE8joyOPlT7uVU9SCuQtMiqQ1KdYJ74spfu8tLNZY66ES2ThT3KUe8Jarak9O9AJk5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBKZg1nfSS8ROTkPEHj738uvJUZdn9I4EKsJ3LZvpR8=;
 b=mu6/Io3zgaZekmspHabfWMxy7xX7ZXG3iPpUKakuZG2xCER9fZO93oX+SnjLYxYAajXwNsOD1YalAinnt5qXn6bRgkdFv9pfZh80uHPjJ4t2kKWWLhQo+1A1+XqUy9VsjBc2QU6EVnK7jfHyTvZbsgJrDbKE/8Vf1Qk6Y0MJOmk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB7069.jpnprd01.prod.outlook.com (2603:1096:400:db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 17:47:20 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%2]) with mapi id 15.20.8398.014; Thu, 30 Jan 2025
 17:47:20 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>
CC: "rafael@kernel.org" <rafael@kernel.org>, "rui.zhang@intel.com"
	<rui.zhang@intel.com>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "magnus.damm@gmail.com"
	<magnus.damm@gmail.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 2/6] thermal: of: Export non-devres helper to
 register/unregister thermal zone
Thread-Topic: [PATCH 2/6] thermal: of: Export non-devres helper to
 register/unregister thermal zone
Thread-Index: AQHbcnKoO9zjk0UpA0OhU3WRTzMdGLMvCAmAgAAQfICAAAW5sIAAdpCAgAACwhA=
Date: Thu, 30 Jan 2025 17:47:20 +0000
Message-ID:
 <TY3PR01MB1134683B8AA347AD624E4F17486E92@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250103163805.1775705-1-claudiu.beznea.uj@bp.renesas.com>
 <20250103163805.1775705-3-claudiu.beznea.uj@bp.renesas.com>
 <Z5pkUNNvsWPjRQvy@mai.linaro.org>
 <65a16c3f-456e-40ec-91b0-afb57269ed46@tuxon.dev>
 <Z5tPR_tv7vWDkUI7@mai.linaro.org>
 <TY3PR01MB11346E087A4DFCC5BDCCB10B486E92@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <867eb310-11a7-48bd-b2fa-35e001875498@linaro.org>
In-Reply-To: <867eb310-11a7-48bd-b2fa-35e001875498@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB7069:EE_
x-ms-office365-filtering-correlation-id: a9609013-f7c4-4121-47b5-08dd41562557
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YWxRQmJSdmNNZGtGd3dwemozQVNhSzV6VzhuaEZmckJXdWZUQkJhd3NJWC9j?=
 =?utf-8?B?bWVPU3Q4eTUvbGFYT0RkbDk5L1BFd0NIS0QxY3N1UzBDUFNTRlJaQThUWXpL?=
 =?utf-8?B?NlV4VDEwSDQrOWVzeG1TdVhDNXVCbnplQkM4TmsyeUhWQmVwRUpPb1F6OWxt?=
 =?utf-8?B?eEFFVVZJN29RdDNKNm1ocVBLS0FMOWZTNkdiM0krVWxEL29wSFc4UVZBTTd6?=
 =?utf-8?B?ekt1TktVNGxHaXRhdU5NUW04aU9Dd0I1cSs2M215UXhTckFlTUc1UHhrd2ND?=
 =?utf-8?B?RFU2V1NsZzBrbjdRSDQzN2phV0FNN0JLSjQ3dUUzUTZOWFhNV3NGbytHZFlS?=
 =?utf-8?B?SEhaQ0xuWFhGY3BQamVRMFd3ZFdvMm83TFFVYjM5V256bGwrSnZZTmNsNWdO?=
 =?utf-8?B?eGVhWFcyc2M4c1c3eG05L0dkWXZzNWM0eWNBdmhOMHl2bnh0a3ZSWVpDVzVN?=
 =?utf-8?B?RUFyRll0S1ZUNUtHN3M1STNNTXRuR2lXekZKazRvYUNYMGxtU25SS2JRNUIv?=
 =?utf-8?B?VDBtZ1pwYkg2ZWhpd0RBZzJibVQweVljdnlxWGF6WEpUemFkL0piMkFFc3hn?=
 =?utf-8?B?N2V1WFFDd2g1Q3FUU0k0YjZlamlTa0hKNkN6Q2dYaVltcUxmRnRLZEtaeHND?=
 =?utf-8?B?SWs2eWFCS3RhcnFQaFpVT0pCaDZoOWJrYm1VUEMzWVlFamVhelV4TjR0WDIx?=
 =?utf-8?B?d3JiSjNJc1h1MUE5a0pvYUFYcW1leFVpbkZuSU9XdDJTN3RleGF1ckMxNDhP?=
 =?utf-8?B?d01tcU1lSHRETEZqY3ZaMjVBUW1pK0JneG5BeG1BNFZDem9CL0dhdXZSVktF?=
 =?utf-8?B?TDZuKzVWSHFibDVJS3dBOHAxOGg2MHZvbjRUZ3NoeWNvNlNVSWEzOXhDQjdt?=
 =?utf-8?B?dXBWMG8xcVlkeVVnK3NHV0FRNDJlaXN2Q29WelhqeFRrSEpDMjIzT2lhTE1o?=
 =?utf-8?B?T0g1eHcxWWJDcGJOVFJ0Zzc4b3RLTEFTc3kwMllNYXFkdWJMWXdIWVRSQjlY?=
 =?utf-8?B?TngvazRtMGNhRDM4SHR5a0RkSVBRc05CUk9uNnhuWWJvaXFzNkYzaUVaTjg4?=
 =?utf-8?B?V0ZBc2c3SVh3TmFMa2JudDNobVFsTkk2ZitqVm5PZkNYNmhZR05hMVBqcnZS?=
 =?utf-8?B?cTlOV3FaMTJENi9lUVc4SUhnNk50N2U5ckRxR3ZVN25sVTJjWkFzWVIvN3BK?=
 =?utf-8?B?MHlOT2FiWkhJZ2U5cS81QnIwODN2SHBQelI4d3BjZVJmcnJTRk44RWthdWtF?=
 =?utf-8?B?NmJRemlodnFaTHdaQS9RVFBsTlY3WDlLRDBYbUhiNXdZQUZvS2owV3ovdHJD?=
 =?utf-8?B?alI3aUFTckZjN3JDSENYVVR3Z09TcUxBcStReUE3UHYrTWRObTFHcXIxY0Rh?=
 =?utf-8?B?Yy9iclp0dmt5NXF5TjRqelh5S2dMTXAwV0JZQ3htWWFHMEdJWHJtaHM1bGdq?=
 =?utf-8?B?SGdqcllUbzlHWVdlU1hEK25JZGRGNWNsSGhmd0lDVytyRlY0UDZLdzlUS1VN?=
 =?utf-8?B?ZjkxWFI4YmdETHRERFlBNjE2YlVMb01qYnQ5OEdmZ1BnTVowTHZDMVpweW5W?=
 =?utf-8?B?bERtdXVWVGhNYUk0RGo2OWdFZHI0ams5QzVSYXdIRklySU54emJZaFZUSFlT?=
 =?utf-8?B?Rm9ENFMwcUZHVlJjQ3hCem05QUNaSGovUmdRMlhYbG9vdTdySlBKemQ2eTNL?=
 =?utf-8?B?R0t5UWpMbnlOTDY2TStIUm5KVDZ3ODR6MUVMU05GYVl6eHZuMitHdXg4RkI1?=
 =?utf-8?B?Wk5nNFYyZGlteWJhVVppM3JJUXAwV0g1Q294K1c3L3hvUGdScXhRRjNIRTRs?=
 =?utf-8?B?Z0JlTW9NT1dHNjlzRlg1UW8yRjA5WmYyTzdSdnBuSzllNkZwM3ZyVXVTbzU4?=
 =?utf-8?B?WWZ5ZVA3d2tGYnM3ZkhMa29XQ3hwb1RIMkYxdjhpcmFNN3FhcXR4M3hsZEk3?=
 =?utf-8?Q?1/LmdKgrXxHzNxKcFIoKg8vA8KnPoxek?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RUVXbXlZTGNqM3R0V3ZqSlZEbWtxRUZ0YTN6cVY4Zkw1ZUdiQXJ4eFltN01F?=
 =?utf-8?B?Q0hjaEd2UmY4b1Btc2xpOEllWmZNTDRNUEJSajQ2SDJ1K0hmeFFBNjFLOFNh?=
 =?utf-8?B?YnJrRC90SnUvVWZ3VjB4WGo3dGJvMGFhQnlUMzJQSnpiWkovQVNuVmRkNkFN?=
 =?utf-8?B?N2dDTC9ES0g0bDdCRVhZbGxyRllqTDkza0J3WlBreEJwV0ZxZC9xa2E1d3dZ?=
 =?utf-8?B?bzBqNDd1YzYzWnVUS1Z1OE1KMi9reWJ5SEJhRVYvSENtR2JRc1JuSGMwUnF3?=
 =?utf-8?B?bmppNGpaNWM4bTIxUkVtckcwUXEzcnFkZnF1ZUlpWnBZYTdUTEEzMzlwcmtE?=
 =?utf-8?B?Mzc4RkpOQWtvQlpGZFNNQndhKys0dkNsT05POUFrb0lLbk4vREd6RVZQYTkz?=
 =?utf-8?B?QW5NVUlJV2tkeExBODJiTVZNWm9kc1pzU3BMcDZWay9YZFlsaFNUWmxEL3hU?=
 =?utf-8?B?WGJjVVJvLzBhRExiTlZ5RXd0NCtCU3pVZEpOYUJQR3NCQ01jblFZdGJ5RkN1?=
 =?utf-8?B?RUwwdkZxOXVwTzJjQXprSGhVcWlia25pcFlldjdsS2RKYjZtY3d4ZmNkbldN?=
 =?utf-8?B?dFpoN3MvOW1abG9QY3ROZVlQMlVVdWRDaHNkMllndlpodmQzaVZSYjdCa1hN?=
 =?utf-8?B?Z0duWVY4NEgwMFpUSTM2RHFXdHNZOWVlT25qMEI5c256cFp1bUE5NTNtOHVp?=
 =?utf-8?B?WlRyNzRLU0JZOTlDSlcvZHB1azJSNUJkMmRlcHNQbUhuRmU1TWdNb25JbU1P?=
 =?utf-8?B?SVIzOGEyK1FGWkJGbUxIckRaNW9nMTQzZzdWR2xWSE9FU0JGZld6djhadnB5?=
 =?utf-8?B?K3dSa1dFUUFhYWJtL0xMa2hieWkzUzFxOEZYN3AyeXpqN08xNmZCZks2Tkdi?=
 =?utf-8?B?Wm42WEhrQ3pUVnVPZ3Nsb2w1Q3pCNnRoNXhwYVR0cW5oN3Fhd3Z2M0cvVVNO?=
 =?utf-8?B?M1Q5MDBndWZKL1lRSnpZRVlONG1Mam4yUER4ZEx2RG1laTgvZDE4bExnVTdZ?=
 =?utf-8?B?SXJCYS82L1ZFbVJhV2cwUFdiejNuYVVsWEEyRTVRQTkxS2htbXdNWnozbFIw?=
 =?utf-8?B?TXlNNnpaUHdUcDVaU0lLMWRVTU9PdmFMdEVNeEUvNTlKeFkxNllITGNTcXlp?=
 =?utf-8?B?aFl5a2I4QllyNWgrN3o4ZmFscHM3aDF6dzZsZ2xqN0RlVmhZcUh6cjNmNDVj?=
 =?utf-8?B?U3pSL3A5UlNtUlBHajVqTXRYTnNWcm96QUxmNURxTWxTZ1NTMlBZVTdRL1pJ?=
 =?utf-8?B?dHpsTWVCVm1LdVk3bkdFL0hEUGFMMWtWb0VZcG1vdzF2TUNSYmFpUGF4MlNL?=
 =?utf-8?B?VUJhMXBYVnNDR2I3TWw2dnpHNFhMYnl3Wndvd1lKQ1lDaFN2MDYzNXpobXB5?=
 =?utf-8?B?NndtejlMUmgrcXpFUjN2UHd6eWVJbnZTT3piSEordmd4YXk0Rk8xNHFKZHAw?=
 =?utf-8?B?UDNFZlBCeHlKMWdqYjR4NWFOZ2RMRUxLODhtZFFJTWtXN2V6MzNuMlNQZ0hX?=
 =?utf-8?B?eXIraFd3Y1JQamNmU3BlS2JMMFAxaFpJUDh3c1BMN3BhZmhyeDhvMldUMkFi?=
 =?utf-8?B?UHA2WG9PaXRpVHpQOStRekw3QTFOc0ZMbGE2M0taQ2tZVm9kTkZISEpBOUs5?=
 =?utf-8?B?cFZzNlNnNjZqNHlaWXdXa2tKWWJWS21lOXIvMU1DVkF5a1Jvbk53ZEdQejhB?=
 =?utf-8?B?ejdMWHVPemJxeEN2Rzl4TG0xY2d5T1hvaldUeHpZQ3NQdExpSXp0WmFQYzEv?=
 =?utf-8?B?RVhiamtmajcvU1VLTzhkVENZS0h4SXR6QTBhSFpWZ1lhZlp0OTJGMHlhZ2F6?=
 =?utf-8?B?RTNzenBhcG5WcFI1SGxscVFidm5ydlJIUjhnVVJhRU9wVVpPL0FFY1hJS2tt?=
 =?utf-8?B?MEtZRWJkWi9YNnpjdkpZMU00NDJzZlAvRU90Q3BYUW04SHl4b1hGWkxlMy9T?=
 =?utf-8?B?TXhqVUhkSC9yU0ZCb1MyS09LTElva05EY2pseTRuMXZRUThuUHNObmIwR1FW?=
 =?utf-8?B?L20wd2lCU0NNZkpPSFh2RlBqT3RqOWFWcGpaaHVWTFI0SVJrdzk2V1V3K2l2?=
 =?utf-8?B?WVRONXJQZ01mLzQwcVg5U0JIVEhkMk1zQ1phdlZ2MEVRZlRoSXVGTWdSMHdD?=
 =?utf-8?B?U0d5MlJrdkc2UHZLV1ROWHNzUzRoTlA5QXYyc2daL0xiblRDMm8rVGNCQThE?=
 =?utf-8?B?Y3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a9609013-f7c4-4121-47b5-08dd41562557
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 17:47:20.5856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZ9AhabXcZKIKYzoKGWKhZs6bNnPKUea0sx9WMkVLlWWunqJzprpgycClprHp1CrlxiHZKDiyhrmENmIfCG9JELVbSwjxHOaqVWFX1Ktdhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7069

SGkgRGFuaWVsIExlemNhbm8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDMw
IEphbnVhcnkgMjAyNSAxNzozMg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvNl0gdGhlcm1hbDog
b2Y6IEV4cG9ydCBub24tZGV2cmVzIGhlbHBlciB0byByZWdpc3Rlci91bnJlZ2lzdGVyIHRoZXJt
YWwgem9uZQ0KPiANCj4gT24gMzAvMDEvMjAyNSAxMTozMywgQmlqdSBEYXMgd3JvdGU6DQo+ID4g
SGkgRGFuaWVsIExlemNhbm8sDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gDQo+IFsgLi4uIF0NCj4gDQo+ID4+Pj4gSSd2ZSBiZWVuIHRocm91Z2ggdGhlIGRyaXZlciBi
ZWZvcmUgcmVzcG9uZGluZyB0byB0aGlzIGNoYW5nZS4gV2hhdA0KPiA+Pj4+IGlzIHRoZSBiZW5l
Zml0IG9mIHBvd2VyaW5nIGRvd24gLyB1cCAob3IgY2xvY2sgb2ZmIC8gb24pIHRoZQ0KPiA+Pj4+
IHRoZXJtYWwgc2Vuc29yIHdoZW4gcmVhZGluZyB0aGUgdGVtcGVyYXR1cmUgPw0KPiA+Pj4+DQo+
ID4+Pj4gSSBjYW4gdW5kZXJzdGFuZCBmb3IgZGlzYWJsZSAvIGVuYWJsZSBidXQgSSBkb24ndCBn
ZXQgZm9yIHRoZQ0KPiA+Pj4+IGNsYXNzaWMgdXNhZ2Ugd2hlcmUgYSBnb3Zlcm5vciB3aWxsIGJl
IHJlYWRpbmcgdGhlIHRlbXBlcmF0dXJlIHJlZ3VsYXJseS4NCj4gPj4+DQo+ID4+PiBJIHRyaWVk
IHRvIGJlIGFzIHBvd2VyIHNhdmluZyBhcyBwb3NzaWJsZSBib3RoIGF0IHJ1bnRpbWUgYW5kIGFm
dGVyDQo+ID4+PiB0aGUgSVAgaXMgbm90IHVzZWQgYW55bW9yZSBhcyB0aGUgSFcgbWFudWFsIGRv
ZXNuJ3QgbWVudGlvbmVkDQo+ID4+PiBhbnl0aGluZyBhYm91dCBhY2N1cmFjeSBvciBpbXBsaWNh
dGlvbnMgb2YgZGlzYWJsaW5nIHRoZSBJUCBjbG9jayBhdCBydW50aW1lLg0KPiA+Pj4gV2UgdXNl
IHNpbWlsYXIgYXBwcm9hY2ggKG9mIGRpc2FibGluZyBjbG9ja3MgYXQgcnVudGltZSkgZm9yIG90
aGVyDQo+ID4+PiBJUHMgaW4gdGhlIFJaL0czUyBTb0MgYXMgd2VsbC4NCj4gPj4+DQo+ID4+Pj4N
Cj4gPj4+PiBXb3VsZCB0aGUgSVAgbmVlZCBzb21lIGN5Y2xlcyB0byBjYXB0dXJlIHRoZSB0ZW1w
ZXJhdHVyZSBhY2N1cmF0ZWx5DQo+ID4+Pj4gYWZ0ZXIgdGhlIGNsb2NrIGlzIGVuYWJsZWQgPw0K
PiA+Pj4NCj4gPj4+IFRoZXJlIGlzIG5vdGhpbmcgYWJvdXQgdGhpcyBtZW50aW9uZWQgYWJvdXQg
dGhpcyBpbiB0aGUgSFcgbWFudWFsIG9mDQo+ID4+PiB0aGUgUlovRzNTIFNvQy4gVGhlIG9ubHkg
cG9pbnRzIG1lbnRpb25lZCBhcmUgYXMgZGVzY3JpYmVkIGluIHRoZSBkcml2ZXIgY29kZToNCj4g
Pj4+IC0gd2FpdCBhdCBsZWFzdCAzdXMgYWZ0ZXIgZWFjaCBJSU8gY2hhbm5lbCByZWFkDQo+ID4+
PiAtIHdhaXQgYXQgbGVhc3QgMzB1cyBhZnRlciBlbmFibGluZyB0aGUgc2Vuc29yDQo+ID4+PiAt
IHdhaXQgYXQgbGVhc3QgNTB1cyBhZnRlciBzZXR0aW5nIE9FIGJpdCBpbiBUU1VfU00NCj4gPj4+
DQo+ID4+PiBGb3IgdGhpcyBJIGNob3NlIHRvIGhhdmUgaXQgaW1wbGVtZW50ZWQgYXMgcHJvcG9z
ZWQuDQo+ID4+DQo+ID4+IElNTywgZGlzYWJsaW5nL2VuYWJsaW5nIHRoZSBjbG9jayBiZXR3ZWVu
IHR3byByZWFkcyB0aHJvdWdoIHRoZSBwbQ0KPiA+PiBydW50aW1lIG1heSBub3QgYmUgYSBnb29k
IHRoaW5nLCBlc3BlY2lhbGx5IGlmIHRoZSBzeXN0ZW0gZW50ZXJzIGEgdGhlcm1hbCBzaXR1YXRp
b24gd2hlcmUgaXQgaGFzDQo+IHRvIG1pdGlnYXRlLg0KPiA+DQo+ID4gSnVzdCBhIHF1ZXN0aW9u
LCBZb3UgbWVhbiB0byBhdm9pZCBkZXZpY2UgZGVzdHJ1Y3Rpb24gZHVlIHRvIGhpZ2gNCj4gPiB0
ZW1wZXJhdHVyZT8/IEFzc3VtaW5nIGRpc2FibGluZyB0aGUgY2xrIGhhcHBlbnMgd2hlbiB0aGUg
dGVtcCByZWFjaGVzDQo+ID4gdGhlIGJvdW5kYXJ5IGFuZCByZS1lbmFibGluZyBvZiB0aGUgY2xr
IGFmdGVyIGEgdGltZSh3aGljaCBpbnZvbHZlcyBtb25pdG9yaW5nIHRoZSBDTEsgT04gYml0IGFm
dGVyDQo+IGVuYWJsaW5nIGl0LCBvciBhIHJ1biB0aW1lIGVuYWJsZSBmYWlsdXJlIGhhcHBlbnMp
LCB3aGVyZSBpdCBleGNlZWRzIHRoZSB0aHJlc2hvbGQ/Pw0KPiANCj4gDQo+IFdlbGwsIEkgaGF2
ZSBzb21lIGNvbW1lbnRzIHdpdGggdGhlIGRldmljZSB0cmVlIHRoZXJtYWwgY29uZmlndXJhdGlv
biB3aGljaCBtYXkgYW5zd2VyIHlvdXIgcXVlc3Rpb24NCj4gYnV0IEknbGwgd2FpdCBmb3IgQ2xh
dWRpdSB0byBjaGVjayB0aGUgdGVtcGVyYXR1cmUgcmVhZCBjb21wYXJpc29uIHdpdGhvdXQgcm91
bmRpbmcgdG8gMC41wrBDDQo+IA0KPiBXaGF0IEkgbWVhbnQgaXMgaWYgdGhlIHRlbXBlcmF0dXJl
IHJlYWQgaXMgaW5hY2N1cmF0ZSwgdGhlIG1pdGlnYXRpb24gd2lsbCBiZSBpbmFjY3VyYXRlIHRv
by4gSXQgbWF5DQo+IG5vdCByZWFjaCB0aGUgY3JpdGljYWwgdGVtcGVyYXR1cmUgYnV0IGl0IGlz
IHBvc3NpYmxlIHRoZSBwZXJmb3JtYW5jZSBjb3VsZCBiZSBpbXBhY3RlZCBuZWdhdGl2ZWx5DQo+
IHVuZGVyIHRoZXJtYWwgc3RyZXNzLg0KDQpUaGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbi4gDQoN
CkkgdGhvdWdodCB5b3UgbWVhbnQgIiBkaXNhYmxpbmcvZW5hYmxpbmcgdGhlIGNsb2NrIGJldHdl
ZW4gdHdvIHJlYWRzIHRocm91Z2ggdGhlIHBtDQpydW50aW1lIG1heSBub3QgYmUgYSBnb29kIHRo
aW5nIiB1bmRlciBzdHJlc3MvaG90IGNvbmRpdGlvbiwgdGVtcGVyYXR1cmUgcmFpc2VzLCBhbmQN
CmluIHRob3NlIGNvcm5lciBjYXNlcyBpZiBydW50aW1lIFBNIGZhaWxzLCB0aGVuIHdlIGNhbm5v
dCByZWFkIHRlbXBlcmF0dXJlIGFuZA0Kd2UgY2Fubm90IHRha2UgYW55IGNvcnJlY3RpdmUgYWN0
aW9uLg0KDQpDaGVlcnMsDQpCaWp1DQoNCg0KDQogDQo=

