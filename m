Return-Path: <linux-pm+bounces-24161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A39DA65060
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 14:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 793097A2174
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 13:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A90523C8C8;
	Mon, 17 Mar 2025 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="OZHvBVTe"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011049.outbound.protection.outlook.com [40.107.74.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091538F5E;
	Mon, 17 Mar 2025 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742217033; cv=fail; b=nvcVw272Guc2pN9osVjRjhJMxaXK2LYLgVe+hrENn6Rm5gnMm7tcZ9owOTL71VUJbkqFE7NR5qXWNgEd5h/uYP25xllnBs+94BTQI38yptJyy5KSVLHzzpi/as4Fp8FNKiEz3Otq8Sr9nTwszILQJyApEPMMI/kVhh32Fmc/w2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742217033; c=relaxed/simple;
	bh=jfKNrjS15eSeAulnrAC/YzTKu73FYpvv9obgvP7F48g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BismSDmmKNpnIvRIjlrFG6aXxlXp/gQHnxahfHF8g8uYBADQUjIV6bXItL6fanU13ErvEyA+w/kZMV+Ph/JNjffs4AfVXHpGY5DwcQy8gk2s17WZ8S4YIzRD7D0yquCU5f1EYpDaQh1WNqMC8sPaya40/r5B/gMXC5Rm85pJ8kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=OZHvBVTe; arc=fail smtp.client-ip=40.107.74.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGLWnz7H2KEO5J11WoGfW9orbWD5JwoKuIcSYasyOevh1+A/DYg0d4TKZZAc8SfY3mTZ3SYXQDeck1jHRyfsRSIzBcyOspCpcqpgBT8xPcPT+6uZ2lzsQcNXq+J3Lwn/VIXf4xUC6crXQILC/GVfkeaTk2RatIGBpTLa5eJ1pgA/vBj1i3SE/iJbQkI7N12el1NsOCp1X0+yFxVfWy0vpfdHqvY/F6V2pfOlndtUamv4bd1KXnjhXv12+FoWNo+oP1Qwu7pYznUmFLiq405lO0dFqzdcp0IM+AYWo64wdktt8rnxbeM7s1CxqsZdVoN10oqfTh/gc/mYGzmj1sAFyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfKNrjS15eSeAulnrAC/YzTKu73FYpvv9obgvP7F48g=;
 b=bo4rO3wKlbBuiSurgBEwWVMPouu6OcGmLfi1RoqotyWWjKgnlKAvXlNiV0bd3FO8rltDfXpdkwl06ax9L0aEywjuRDIGXmSEw3gZdn0oGpcvdQ7WWANoHDfLHDqCQ4Kr26FJSg5NTV0x4KBFXpyhLuSVET3jYQzNsG2/uS/agFN4MA5n/VFO4kMcXxfH8LTeJ2plhqgNz6BruXXts01HhlLw8xs42ivyfa0WwA+agmrLpUlFMV2RxAeK8JF+/MtMmAtoyen4CoP5SYhiZzQQh9x/8PP9IXIRScmtDDGEda3/0qmwCgLlheiHrpdKH1LkmU8QCijdk+1+TwCmr1fo0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfKNrjS15eSeAulnrAC/YzTKu73FYpvv9obgvP7F48g=;
 b=OZHvBVTeQ+wN93QwCP9PIoKRQk1dey2PHdYZc/hsKY2q2rFzDav5ZS2EAJMf3QdJAIAuHxdKcXvYt79BCojQtUXjYsHEnZhIDNn2KTq78KcMS3JTjEqA9gDqDDazlyH/pUkYR0cxC7p75DaVYnJ5N0zScRb/vSU3LN9gUt5tme4=
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com (2603:1096:604:13::17)
 by TYWPR01MB8870.jpnprd01.prod.outlook.com (2603:1096:400:16b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 13:10:26 +0000
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b]) by OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b%2]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 13:10:26 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"magnus.damm@gmail.com" <magnus.damm@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "john.madieu@gmail.com"
	<john.madieu@gmail.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"sboyd@kernel.org" <sboyd@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>
Subject: RE: [PATCH v3 6/6] arm64: defconfig: Enable RZ/G3E thermal
Thread-Topic: [PATCH v3 6/6] arm64: defconfig: Enable RZ/G3E thermal
Thread-Index: AQHblYIVSDfEEIBQHUewX0DdQ4ozEbN3EyWAgAAYZdCAACRCAIAAAFmg
Date: Mon, 17 Mar 2025 13:10:26 +0000
Message-ID:
 <OSBPR01MB27755EC6EFB0B5FE87469C82FFDF2@OSBPR01MB2775.jpnprd01.prod.outlook.com>
References: <20250315081225.92118-1-john.madieu.xa@bp.renesas.com>
 <20250315081225.92118-7-john.madieu.xa@bp.renesas.com>
 <20250317-bipedal-inchworm-of-poetry-b60fc9@krzk-bin>
 <OSBPR01MB2775B7252468BCE234BFF7D5FFDF2@OSBPR01MB2775.jpnprd01.prod.outlook.com>
 <CAMuHMdXxWCG-9tE7MsO3i+VXSjj6cZvH50fnQA=xvNfcQw842g@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXxWCG-9tE7MsO3i+VXSjj6cZvH50fnQA=xvNfcQw842g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB2775:EE_|TYWPR01MB8870:EE_
x-ms-office365-filtering-correlation-id: 4cfe362f-1c76-48d3-6f72-08dd655515b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3dRZk8zREVocFBKclU0OXBjSFUxUXpDdytsTFYvM0E4REFKZmpQWXlHb2d5?=
 =?utf-8?B?d0oyMTdoRE00d1F2S1RFeXlsVURDTzUvcm96OXRBZTA3Q3VjWStRSXlod25L?=
 =?utf-8?B?b3drQTMvRzZSUU9wcjdGVTFlUFdKc1h0VFc5RlBEK2lIUCtlYlJPbVNzUU8y?=
 =?utf-8?B?Rm5aOHR2VTJQeXY4YXdydTNmZGVkRlhucTVJa1JpRTlWQWNOMDQ4eWZrKzh1?=
 =?utf-8?B?eUYyZU5IZURBYUdWWVlEN2tSZERGUUVNa0pVZUNnMmUxdGtmWmRta3NNYThO?=
 =?utf-8?B?WW1qdThBYTc3VkFtSXBOazZkWlJmNDNUSWpoR3FaSUd1bXpxT3JOTEduYmIy?=
 =?utf-8?B?aVZxWE9SQkxmTlJWSDZsZGV0Q2RHK2tBVjRZRmNwMmNkWmpvamNzOGo0UTd5?=
 =?utf-8?B?SVVGLzV3cVNSV240eHdHVGE3TGU3UmFqRnU5aU1iaEtIOGVxcEl2dTBiSHQv?=
 =?utf-8?B?TGZBUDIzVXMwcGRYSy9LbWJpL0V0N2FFZDZucm9MNnhRV21mSFdDWGRQMEd0?=
 =?utf-8?B?NXVUZzN5M0MvN2RJMnppdmFLU3FqUy9BeDV2WmJOUk9ZOHJkcVlHUndWUzl4?=
 =?utf-8?B?TUwyaW5LYjhjemRscENFdnJUN3dHTElFbjNVUXRFWVNGMVgrRG15T2Jkd1Nj?=
 =?utf-8?B?K3ZqVzhxd3B4R3MzLzBrNjg5Rm8vQXJZUU54TWQ2Z2EvR0tmUUMzaXJReVpZ?=
 =?utf-8?B?SXdnNUdlQzBaaFFRcTRndmxTRk4yTm45RG93WW04MzZ0NDVXZDg0elpPcVZO?=
 =?utf-8?B?Nk5wQzBGL2VxMWIzNnpDbmcxbUN0V2orMXM5eHdsK2d6RERlenZNd01KYWcy?=
 =?utf-8?B?REc0dGt3NUdOYVFOc2RqVWZDbWNNOHZpQVlHcDhCL3pVT255Q2VSdHluTElp?=
 =?utf-8?B?YTlPQmoySVorejVaMUVwWThjQ1lXanBhNFRQK20zUjVXdFgyVCs0NkZGNWxi?=
 =?utf-8?B?ZFJvMVpxc2VjbW01N2J2K0RWTWRicDNhdkw4bHBDOUhrdDhNd1REeUEwQXRL?=
 =?utf-8?B?SWVoZDg2Vjc5ZEcwRXIwS3NRSHRTdzdoYlE0Z0VpZVpGRmpaUk5BMXM3ZnhQ?=
 =?utf-8?B?STFCUWRQWVVoeTBIbTN6bnVqOWFNcHdiOERmd3puM3RhSXlmdmp4M2NpbzNP?=
 =?utf-8?B?eEpseC85K2JUU2h4SHp2VEpRd1ltbWhVVWpMSkt2UU1FUkJxQWRudTA1QVg4?=
 =?utf-8?B?VUJpRFdIclYwZTV5Umh2Vk15VlphSjFsNE1PR0EzNmFKUHZhQlVPMVoxVGhD?=
 =?utf-8?B?c3JlZW1Pd09tVktLWUk5eVVXQngySzNiNkJTSGlkUW5oeG5oMkxnZHk2WW4v?=
 =?utf-8?B?R1A4ckZXTUtTSnFLcTBtTHVLdDJpOE1OWjlIdk5mQVc0OXBHNEx4U3JnaGQ0?=
 =?utf-8?B?WDVzMm9NSWFmTEVEUytXeDJCRTdJbmNHVHpaK2RiekVDelhCcGdZcE9OeVJE?=
 =?utf-8?B?cjV6S25XQUo1ekl6Smo3ZG1UZG5sOVRwL1grb0huU1hpdkVPMUdBM1l4dEE2?=
 =?utf-8?B?cjVodjFrTnE4dnVIMkI3cjVOWSs3ZGdJclAwQmNzYlB2T2p0aVlMUmhlTE51?=
 =?utf-8?B?SWtqZm45U25TT3lBQTNncXRWNGFoUW1zQllOeUU5Z1lJOE5VUVJDL2ZyenF6?=
 =?utf-8?B?R2p2VmRzMDYvZmhnT3pLWFNzb3JZdEJ0TmF1TytGb1dNMXlmV1krcnpTYStn?=
 =?utf-8?B?NnpBaDJrbTBISzFnWEtwNUZyK2FPdWhUdURtNVowZVU1MGJ5M2Jqa2ZzeU55?=
 =?utf-8?B?RG91ZmpQWVVXNmRmV3VQSi9GMGgvT29WcE9PdDJkYWRTTUM4b05MUUJ0dTBU?=
 =?utf-8?B?d1RqcFF2eGtyYnBLZW82S2ljQXJ5TmdFbXhxRFhMUTYzaEQ2N2ZuUG42ODF0?=
 =?utf-8?B?dGIyZDVTNllKTFlRekszMmRoVXVLcldyWDRac3pOWW9nNXZFdXZtLzlacU16?=
 =?utf-8?Q?THQect+Bgz3rYLBfgbFokiaBLT+rsjtQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WnNQUHZEM3gyMVU5K0FubDJiSG5zU0d4WkRTTVY3eXlVNGp2Ti96YTdmc2xI?=
 =?utf-8?B?WUVUaHY5VmFHRlliS1JFaUxYUTRDeXA3T2R4c0xDYkl5emY2c0ZyVFVoYldH?=
 =?utf-8?B?ZVNTN2dscWlUbXRDR0VkcXdaeUpGYkJMQm5CTmRaYmhvOVJWNnN5WjFqU1lP?=
 =?utf-8?B?Wk0vQ3kxOUFkd2o0VHpPWG9GQUpFVHkrdnFjMm1YMWIyQzA2Q1pDQVV4VmpC?=
 =?utf-8?B?NkJDZllYakRVTFYvMWM0d1BPOWZjbWwxVGJPdHB4bEppZG1SN25hVGt6U016?=
 =?utf-8?B?UVIxa3I0UEdkSWpOWDA1U0NUVVZJbUxhbGErRnFEc1BSa2EzeUxHcEdxWlly?=
 =?utf-8?B?cmIxK0szb1hmeEhnMHkvWk5ieDBjcXhJY0RjSDJrSm9DSTFZdVZ5dkh0TGVQ?=
 =?utf-8?B?bS91SVRUZ05oNHk2dUM2MWRHSG40VnZxT2tiNit2aFpIYnpxOVdJdU11YzFi?=
 =?utf-8?B?L0dQS2tFWG1kSWxZclNoRTNHTkgwOHpFbGN0RXVKZ3RaUlVpaHIxUGc3dUNJ?=
 =?utf-8?B?Q1NLN2hMQWYrQkJjbVE1cStHZFYzOGVBZ1JNSmZkWEtyaDRYNVhMcGg2RHdY?=
 =?utf-8?B?bWQ0bTdnQ21LN3pvanFMRXNSNEpOZDNXMkFzQlNlNjNrU01zWDBzbmJMU2Fi?=
 =?utf-8?B?Y0FvNGRtdnZHM2FLbUZxc21UUW40NTl6eXZFcU5lVUpPbHh4WTk0bVFWSkJa?=
 =?utf-8?B?VVcxMkZIZjZGNG5UbGRrOVU4OTN6SUdJQ3VPS200WUljem1NWCt4VlAxMW9l?=
 =?utf-8?B?ZG9xTGQ1YmJ4UnRpMVpuemtFNG5JRUZQbUV1bjBIK3BndzFKZkRlakFUMEta?=
 =?utf-8?B?NThTRnA4Q0JLUHNMM04ySDFXdWNPV1JndjlaNVlLTllJNVNFZy9rcEorbEN2?=
 =?utf-8?B?OGYvUGUzNzZvTkVwcWpzUTNSWEtVYTl2Syt4c0VXMkVqemx6bHJJdCtNdi9Y?=
 =?utf-8?B?Yithak1lYW9tSTM3TWZPVFlqWGVTSEtZaDd5UTM5ZnRyZFlZSW15K1dCYWpE?=
 =?utf-8?B?d1ZZVXlsekIveXZxdkJROXd5Wk5iZGhNVFd0UHo1M2J6VXJTaUl2eUQwM2Vs?=
 =?utf-8?B?V1Arc3NqSHdmTzRBempiRXZEdkhKcjhzN1d0ZlNUZWZGNC9ubnROQURjMFhu?=
 =?utf-8?B?aUpyMTlYQ1E4NWJvQU9ORTdFL2xXNjVwUjdEbWNLY0dtcTArYmIxWEoxVlRi?=
 =?utf-8?B?ek5aOHUwNUVRNGJEMXowdVFUN0IzYjN2YnNIK3oyd2JDTlVnaW54RHpyNnNt?=
 =?utf-8?B?czZtZWdxQmx0TTNtQjduMVpFcE5SOXNzUlB1bWRhbTJaZEtLUStQZ1dISlYz?=
 =?utf-8?B?ZXR0Sm9wcWZvOWIyWHRZdUs4SzViL2NTVTJGOWxQVWpJVlN4YzM4Sy80bnpC?=
 =?utf-8?B?Tk5TQzVrT3lLQmFndUhJeGp4RlgzTCs0WmhqYWQveTdnMWYwSWoxTmwxY05a?=
 =?utf-8?B?T25YRTlDWGNrS2hUbGxQYnl2dG83V1VlN2hYRkllUUJYT01OT2tweEtiaW5R?=
 =?utf-8?B?MFlkZjBtUTR2YzZoWkNVaFgrbnRqT2hUT1BSUHVpbExOUEdxOXVWRDV2cWcw?=
 =?utf-8?B?WkdtRUk2RFBBckoyU0VRUHdyMkR1YmxxR08vbDFXVmVQbXVYTGFFSnR5bmhF?=
 =?utf-8?B?MWVtdDQ0ZFhDZHhJbFZNeVh4MDV2bkE4VHhIdFJnWVdja0FodU5mWmVYOTRX?=
 =?utf-8?B?V3RBWU1GZmw0ZWpqd1UxVTNYWC9JdUZvN212TVlmbWMrRmovV1NGZ0lhSnZP?=
 =?utf-8?B?NSsvTUtHWDlLMVVzeVVWUTZCc3pJQlNxREVUNndxdEg3eEpYZlpyZ3grd0hj?=
 =?utf-8?B?WEpOYVAwU2Z3SVlwU2xqaXZJQUYwVjFqUnpVUmpzVXFVSXVUVFNHN2ttWlZj?=
 =?utf-8?B?N2N6d0JJZzA4WHkyMGY3SmIzTGxmNk1sUG5zMGx1eXU1U1BWMUx4UGdMK1Q3?=
 =?utf-8?B?dXR4YTFqdHc2cHFhbjVnd2tUekVWWklhY0F1clhoRTZyNnNjSHkwVXBybXpS?=
 =?utf-8?B?VGErczd6NU9pNkRtTzdQTEtpbzdQL1ozdGx1S25pRkZrTVZPS3pkK1YxWU9Z?=
 =?utf-8?B?bWczL1VMSWh5OTFFS3N2QmlETTJSMk5XczVyQWJjNUh0a1NteFBmamRtMWQw?=
 =?utf-8?B?UHJvaUZLWSt6VzFPMzBVMjFEQ1VIRHFVeWpBSEs1cGNOcW9JZDI1UGRaSEJN?=
 =?utf-8?B?bEE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfe362f-1c76-48d3-6f72-08dd655515b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 13:10:26.6722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fySO2AX3/1cs4D4fF3L6LqocSschWbontHGBnvOnZ/qoAfBp+PBAmsYFQuxv9aOps7V36/4MOq8oocqaPFnBuTbyFm2Ib8cKRfp1w1cM5hY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8870

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogTW9uZGF5LCBNYXJj
aCAxNywgMjAyNSAyOjA3IFBNDQo+IFRvOiBKb2huIE1hZGlldSA8am9obi5tYWRpZXUueGFAYnAu
cmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNi82XSBhcm02NDogZGVmY29u
ZmlnOiBFbmFibGUgUlovRzNFIHRoZXJtYWwNCj4gDQo+IEhpIEpvaG4sDQo+IA0KPiANCj4gSSB0
aGluayBLcnp5c3p0b2YgaXMgY29tcGxhaW5pbmcgYWJvdXQgIlJaL0czRSBTb0MiIGluIHRoZSBw
YXRjaA0KPiBkZXNjcmlwdGlvbiwgbm90IGFib3V0IHRoZSBuYW1lIG9mIHRoZSBjb25maWcgc3lt
Ym9sICh3aGljaCBpcyBmaXhlZCkuDQo+IEluIGFkZGl0aW9uLCBoZSBhc2tzIGZvciBtZW50aW9u
aW5nIHRoZSBib2FyZCB0aGlzIHdpbGwgYmUgdXNlZCBvbi4NCj4gDQo+IEUuZy46DQo+IA0KPiAg
ICAgRW5hYmxlIHRoZSBSZW5lc2FzIFJaL0czRSB0aGVybWFsIGRyaXZlciwgYXMgdXNlZCBvbiB0
aGUgUmVuZXNhcw0KPiAgICAgUlovRzNFIFNNQVJDIEVWSyBib2FyZC4NCg0KVGhhbmtzIGZvciBj
bGFyaWZ5aW5nLg0KDQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCg0KUmVnYXJkcywNCkpvaG4N
Cg==

