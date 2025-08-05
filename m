Return-Path: <linux-pm+bounces-31963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3C2B1B38A
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 14:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B68C1801D5
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 12:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE97E272E60;
	Tue,  5 Aug 2025 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="jywoq4fV"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011011.outbound.protection.outlook.com [40.107.74.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E006926CE30;
	Tue,  5 Aug 2025 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397504; cv=fail; b=ojzdWLpwHySzOP7+BA7zRfAHo2xosXUA7W97AYtwDkEjYbiYuXhN5YW5VLoaGihQZp+gPeJnAbCIZ1Y81UaHrANRT5laJA22JcWXmnyOIY8OS+G50eT2/bfbYXj8yOJgH4awmKiCpBaEZCiw7MiQnGfBSZBH6tM0vGxOtAg63C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397504; c=relaxed/simple;
	bh=uEuFCok4ENZZduuwYS9smpppti75vOkdXdO+N5aFJCk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JaJATtTy6j0aUeuxXHNCGP2dC3TDX/jtFYbkohJLSa4ZxtbGNjMhUeH0K6uYTFxIIk0xbQkM2p15iRSWSijzpzo9R4Q8zGyi2OFdlces4ZFMh678uVBwNwO/VWye54RqTbuyJmsq5Le4lhQQxYuwyjKMeKEGre1NmK4VPGQv7bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=jywoq4fV; arc=fail smtp.client-ip=40.107.74.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rn1ma5MOG7a+c2EEa9052YFX/HLkKcr/+CsGVDBgDD6slrNRS73OYnhNFhP+7AVUU5DUbH36WktpIwRIaT5M47k2QbNPcN479Pm72k8ZI6tue4kxrZGnyf+tmAMhGGYyMfhMTa+aN7HF7Sj0YOJomN9Qj92+j1SAmxE2Q5wbotZkkipt6WCtvGtcxDy/Bqp35lpEdlB4Gx6Rku2CANnVm2qMCT2GBmJRdLfja1mll3HjXdyj0yDrT//TZ3op3jOvPnyYFuiuXxol3PmYsTfNO1kW/YtvABvXBu/mP9wkhk7KIa5bqncEaMie1MjYJ5s7VjZeuWnslRTxMHWBVGc41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEuFCok4ENZZduuwYS9smpppti75vOkdXdO+N5aFJCk=;
 b=QyzwL6DXFRMd9pdjX0kPvkYsN3ZvBjpuoqZoYP7XiBK7m3B4G0cR3zxUUy4WJHWEftO4Vn4wI3Ws/UJ0XpjtvZhv45uug1d0kveQnf5HPH4Zl+L6tlWLEqiVbatLn3BryrFXdd9RNe0ip1wnFzNxMZWQjFxITnuzdPE4/YvuVxIWFVQaSFK/kLREUIHtmYLLlqEWgZ2ONzpE0Mbv9iabdZXJYp+Xn+qy66s4YDNjmG06mejpZte+q64/bfBDw3ClSzMcLCizWm41xvZLtcQhaazmQy55NFrJ7Z5abwTf83R2Urk7eCEvjxMYsvK0fP5TNttYxl5nCmd9QoPSTIKHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEuFCok4ENZZduuwYS9smpppti75vOkdXdO+N5aFJCk=;
 b=jywoq4fVelIz23I+TY9jHLzUnqqifjkmvyK1/RfUPcLTuhvPajAy+qPw0NRmOKmZHfqBn9B/dFKKeJArErU/H7UAbm1eT1LOfMJxOHwKEEmlx2qhsMUNmYBs8LLamgc4+7aW+/kXE9RlUqyBPUNyF3Fx5TYFvGldJijfOTdp2k8=
Received: from OSCPR01MB14647.jpnprd01.prod.outlook.com (2603:1096:604:3a0::6)
 by TY3PR01MB10319.jpnprd01.prod.outlook.com (2603:1096:400:1aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 12:38:18 +0000
Received: from OSCPR01MB14647.jpnprd01.prod.outlook.com
 ([fe80::40e:e798:1aea:ca82]) by OSCPR01MB14647.jpnprd01.prod.outlook.com
 ([fe80::40e:e798:1aea:ca82%6]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 12:38:13 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: geert <geert@linux-m68k.org>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, Biju Das
	<biju.das.jz@bp.renesas.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "john.madieu@gmail.com"
	<john.madieu@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, magnus.damm <magnus.damm@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	"niklas.soderlund+renesas@ragnatech.se"
	<niklas.soderlund+renesas@ragnatech.se>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH v6 1/5] soc: renesas: rz-sysc: Add syscon/regmap support
Thread-Topic: [PATCH v6 1/5] soc: renesas: rz-sysc: Add syscon/regmap support
Thread-Index: AQHby0aa6hzZ+ZABqUanEOL+SC+94LRSqxiAgAGpnhA=
Date: Tue, 5 Aug 2025 12:38:13 +0000
Message-ID:
 <OSCPR01MB14647AC1598F8D20657366260FF22A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
References: <20250522182252.1593159-1-john.madieu.xa@bp.renesas.com>
 <20250522182252.1593159-2-john.madieu.xa@bp.renesas.com>
 <CAMuHMdVyf3Xtpw=LWHrnD2CVQX4xYm=FBHvY_dx9OesHDz5zNg@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVyf3Xtpw=LWHrnD2CVQX4xYm=FBHvY_dx9OesHDz5zNg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14647:EE_|TY3PR01MB10319:EE_
x-ms-office365-filtering-correlation-id: 7c4e5f7d-1026-4891-24c5-08ddd41cf1a1
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L1J0a1pSeG02Rmd6ejl2d2RmTERXSW10OHo4eTZKRXRDTm96cC9CZDZpNFVN?=
 =?utf-8?B?U2ZWKzZWSWVJNG5KTjFmV2ZkVEhvd2Qzejh1L3ZjZDRkYlJhOWFUZTBJZnBk?=
 =?utf-8?B?ajdCTVR3eGFCdjlGZlRLcXJLdUx5cDBvSzROVVlDdlVBNGFEOEFFa1Q1NHdM?=
 =?utf-8?B?K09QaEtmZ053SS9hLzNRT28yRlRNVmRCM0kvK0ZiSnJYRjNLMXhUWkcwRGlP?=
 =?utf-8?B?WGtLakZrbEdIdWV5bWtGalduTm9wLy9hQmxtNlgxV2ZvRmhWRWoyOE43L0Rk?=
 =?utf-8?B?Z2J1ZEdndmsvMnltZ0thcnJPM1RxYnhqYW5pU2EvZ2dnT3lKSTZoTmR5eTZG?=
 =?utf-8?B?eWx0ZlJ1c2ZxdWNMa24wM2VMeEtERXhQbzYrOWVXc1o4ci9YTzFMc2NzdnBQ?=
 =?utf-8?B?Nnh3OGxvekhVcGE0d2xmUnpoUGRXSVUzdFU2RnhvRWdKYVJvc24vTlpteDd3?=
 =?utf-8?B?NG5hZWxoZU92Vzk5b2g0NkJBN1dHczFSeXBzMElTa3Vra0RCdVhvbERSQnli?=
 =?utf-8?B?OTZZeGdYb043bU5LWVZGS2dDd0RPdG1nT1FWTCtlWVBlSFpLMUlaYmlLMHhG?=
 =?utf-8?B?RU03YWJBWElZQTBYOUs2cUdFWkFWZS9JWm5kQ0ZBWE8vNjJ1SElZVmNIcmt3?=
 =?utf-8?B?OVlzVDN2UzcwdjRPOXFIUGhkanlZZkdzYjhQYlI4RFpoNC9ocytKQWtxSVNC?=
 =?utf-8?B?K3JvNm92c0prTjNxMEIySTBJd0V3SXVIb0wyb01PSW5xNHROcTFoNVM2N1VM?=
 =?utf-8?B?QlhjczVVSlRqV0JyYnoxeWFDRGJLTjdwYUN4SWpsa1Bkd1dCcGFPNnM5eWgw?=
 =?utf-8?B?ZHRaNGlIL2hDUjFPd3M0S3FPUi92NTJHN0pQdWdzN1YxQ1JCYVllUjVPMWVM?=
 =?utf-8?B?RUkrRG9meE5QVFFBTU0rK2M3LzFjNzlCMi9TWHhoRkxBUldab083WkY4S25L?=
 =?utf-8?B?VHlxc2xtSERYK2M2YWRmMHBRSFNMbWRiNzB1eWJsRWVJaGhabUJnS0p4Vjls?=
 =?utf-8?B?N2srRjE3UTZ1enBtZFhsNTV0VHNyRHhOVUh5bXBtbWQrWDNaT3Awek4zUHpp?=
 =?utf-8?B?N21aSnhNVS9aWkgzOTJtU1VQNXdzSWRVWjRXcHIvcnRuazNmdnRTdi9kVVls?=
 =?utf-8?B?VUZTVFRFaXJYbVZTU0VTZGE4WWZlWG9QeCtMK01PTWh3VU9RbTVocWhjTi9U?=
 =?utf-8?B?MmlocVlEd2VpdXVEVHEyWFZQTTJLRUtDZEZ3blZZS25UN1lzV1JZdk8weXB4?=
 =?utf-8?B?WW5UTUpFYkJ5bTdKRGJ5RjdZaCtEaDBuaVNTdUdlS0FJU2U2UVNyYjhFT0Jx?=
 =?utf-8?B?aFRFSEt0M2taNUdQZFE1Q0pkSEEvUHArN0hGMkJlby9GWG5hY3FCcXlqQWFD?=
 =?utf-8?B?VWNnM0J4VllKaW1DVG01M09IVGV1bzYxSVB5ckpXVTJwTDdvZEtIWTYwczZi?=
 =?utf-8?B?SUtMcnNrVDN0citWLzBJblY3RGJMU25idXhHVFJwSTlmdjREeHlWWVZZVEZK?=
 =?utf-8?B?RmhwU0IxWTl2aHRMcHRhS09FM2FHcFRtS3R1TVY1VWNYR2IxOTBET0E0RURz?=
 =?utf-8?B?aVE2MDZOZTZ1ZGEzazJnUUphZkN5QnJHRVVwVGR6TDZtNUFVY1ZJTXhCeVl4?=
 =?utf-8?B?SW1hYWliUkVGME5ka3hSZTErYWVad09MZ21TOC9JVnNFalZFdkdzWGFFaHpm?=
 =?utf-8?B?S3Bydm9uODRwRENPaFQ1ZHVFNHB0UVQwVnVBWFRlRDVNbUJmY0NHNUpacjFp?=
 =?utf-8?B?MmhPd1IrZWxTcjcydWRYVGVleWhsc3VLVjNWV1BsYktjTEZzT2hvNHVlUE10?=
 =?utf-8?B?Ukswb21zTUlhekZCa0xtMU13ampBLy9jMXZLMVltK0x3VERlOGxjTk55MVd4?=
 =?utf-8?B?SmxMQjlyY3ZBSlRjUVJLZHJ6TVZOdzBFTnNHU0Q4ZDQyNnpSR1BESWlaWnh6?=
 =?utf-8?B?c2ZUS1I0S3ZtNXF6OE5wbVVreXFsUzFtRTJQWnJ6N1k3R0ZTWkJOSXYzWlRJ?=
 =?utf-8?Q?GKH8gKsLEktOpUeOi4N4ElqyFLUYjA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14647.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVZyTGRXaXhvTTlzekVtWGZPRlVxTmFYZ3pvaXpJTnNUa1JHNlUxZWIwZk1x?=
 =?utf-8?B?dDFqK0VDTm5GcFpzTkdISU8yMGRhekFkY1hvM0RGZEFSU3NkOHE0RmowcUxI?=
 =?utf-8?B?SnJySWxVTVdMK2dVc0FDYWxHUXZXUW1TZzlpc0lySUIrZmM3SDVsUGpUZjM4?=
 =?utf-8?B?WHlLVndpYmZheERxSnZGMm8zZ0J1TDYvZ1VHTG1aaXVSa1hpWFJsajdzZWVV?=
 =?utf-8?B?dnJxMDZ4a20vTFVRQUNYQzIrdmQ2Lytla0JLZmpHVXBBd0dkWjRVYitzcDY4?=
 =?utf-8?B?eDBzZFVza2J2dHUzbVc1TDZ2S015cWRGdk1WV29nOFE4cGZXMjBQelMwcW5q?=
 =?utf-8?B?WHlVU2lyY09kaUxZQ3NWazBsY2preit5Nk8wWEtWY3krdkdqejNrelhZUGZ0?=
 =?utf-8?B?ZUdTOWljRjNObHExb3U3WUlHZVdPU1cxWmZZVlowTU9rYVc2bzA3dWE5dy9u?=
 =?utf-8?B?dkY5b0NOY0szSmRWSXRqZmxGSDZEVUhFRFVGQTdzS29ZOFFxbHIvandWZjVs?=
 =?utf-8?B?KzFtK2ZwdExycXJEc25hamxUdEo0TS9DbnFSNWhuVHgyeVNOVlpvZVVHbUV6?=
 =?utf-8?B?VU5lWlRHckFycEYvelFhbHJmbUxFOUtrYXNJNzlFbVZ6RUlYYVVnd0w5TzFJ?=
 =?utf-8?B?ZjlBc0pZOThuL3NtVy8reGZGWTF6Zk15RHRuWXZvNlQ4QlR1QmgwL1dTR0wz?=
 =?utf-8?B?QjMrb25JK0c4b1dtRmdwdnMwR3RpRjFwMXRmd2JsVTRyemN2dGp2eFZjMlpk?=
 =?utf-8?B?aGNia2dpc2gxM1Fjems3NmRRbWNKb0dWZ05Jc3EraS9YWDJ4THdhTHBNZWpJ?=
 =?utf-8?B?bDZFTnpKM1lFY1J4WXBjS09TcnhGczd6Q05HRjBlM1JXd1lBVGNaWlltMjBk?=
 =?utf-8?B?VzRMbHBlNkFMdXVuaXQxQmxySHgwekcyeWV5QzQ1OWdjZTdkRVljRng0am5m?=
 =?utf-8?B?azhaSHFPM1hKYlYwaUQ2ZldHelpNb2U1VklyaVZySWQ3NUVaMTVlNVc4UTNE?=
 =?utf-8?B?THQrWmpSVFM4bWo0SExnaUFqcVlCVk1COURxVS9VNnNLTWoxd0JLc0xwZkR5?=
 =?utf-8?B?MkE5ZllLRHNhS2VzOXZ2dHhkL2dDR3RjMkQrb002Y1FDMitDeUVpK2pJSG5T?=
 =?utf-8?B?cC9kcDZPdzc5b2VLSFowWHhXbGwzbVpqelFuV3E1a2dQWVZIVkRDSkEvamFx?=
 =?utf-8?B?cGYrQXJ0djgwdGkwdmVtdjFzbGM1VEROSzJuRDBBR0QxWDlscVQrS1lKQzZE?=
 =?utf-8?B?S1FRcVVURFVnN2x6QTFwaFRhVGdHcUxZUFhNd3IvbVRrR3A5SEt4WlZpR0sr?=
 =?utf-8?B?dGkzd3QxVURzWFE4V3RwWWJFT3pxSzA1ckdLbVp5d28yK3JmZHFvZDBVUUFm?=
 =?utf-8?B?KytxWkFSK0VqMTdsV1FPeWFXcEc4RnZZRTcrVElrOGpqNUNiM2l4Y2pRL20v?=
 =?utf-8?B?UFRsZWU0dHZaTGh2QjhlOGd0ckQ5SE00Z2NvT2ZyeTZmZFRLaDhXK2NJeGRh?=
 =?utf-8?B?T1g5YjVreGdhSlpvUWFDSWtYSDQwUzNZeFVjWTRKWTB3V3pKODJlQXZNSmpo?=
 =?utf-8?B?TkdwMW1xdS91amVDTzcrNmE1dGJvOXZ5RWhPS2VaZEo1RTVPSERBRnhTWkU5?=
 =?utf-8?B?ZUNnU2JKQjZ6OUgvK1E5OTZQbllpOHNDQXhpQXV2YTdub3BsdDJlMTJRb24r?=
 =?utf-8?B?TjhTaDZXNVpkRVc5eFFMenNaNXRLblYxdklwMmlZSUJCcENpanI2V3FDRlRv?=
 =?utf-8?B?RlNyZzZuM3dzZGlycmVneFZnbGp2bnozL1dNNTFCRDFQVHZoUE9rYTBmRUtx?=
 =?utf-8?B?T3FCWElzbm1mcFRTT1QyeUh5MHZzMERrQnM5SVErRURaRTZUc2Y4djU0c3l2?=
 =?utf-8?B?UWFQdUg2Ui9VUXdIUmdvQ0xqaERLZ3liQzQwVnBrWDBqdW5CeEs0dnNYY0pu?=
 =?utf-8?B?Y1o3bXN2dEhQODVUME9lNStsRHdTSkZla0pJZVcxZTVJaDFzbG5JNXRLSmJD?=
 =?utf-8?B?RDlFVkxNQkMxMlRnbVZBMzNoakRWS1RmWXpwT0QrS0VhY0dDd1FNdFBLQ1NM?=
 =?utf-8?B?SzI0WHMrTVV1ekVqTHBZMjRkUGlxVTJBdkZLRCtMb3RUa2hRVzRhb1lsWEpZ?=
 =?utf-8?B?c3d1bWs1Sk4wdElCMng5bEhxUmI2ZlFKbVFoUDlaREFrVUtlTDBlRm1EMTJK?=
 =?utf-8?B?dXc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14647.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4e5f7d-1026-4891-24c5-08ddd41cf1a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 12:38:13.4204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ouQILDrsmlcmHmcAni2WOhonWWdCRmtckHMfNJNpGc1x46ld7FbJ1Y51MSGbzwQe3nhnyLmL6EjNBITMSloGnU96r0e09Phh+X95504K2Wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10319

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXchDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhr
Lm9yZz4NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgNCwgMjAyNSAxMToxOSBBTQ0KPiBUbzogSm9o
biBNYWRpZXUgPGpvaG4ubWFkaWV1LnhhQGJwLnJlbmVzYXMuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY2IDEvNV0gc29jOiByZW5lc2FzOiByei1zeXNjOiBBZGQgc3lzY29uL3JlZ21hcA0K
PiBzdXBwb3J0DQo+IA0KPiBIaSBKb2huLA0KPiANCj4gT24gVGh1LCAyMiBNYXkgMjAyNSBhdCAy
MDoyMywgSm9obiBNYWRpZXUgPGpvaG4ubWFkaWV1LnhhQGJwLnJlbmVzYXMuY29tPg0KPiB3cm90
ZToNCj4gPiBUaGUgUlovRzNFIHN5c3RlbSBjb250cm9sbGVyIGhhcyB2YXJpb3VzIHJlZ2lzdGVy
cyB0aGF0IGNvbnRyb2wgb3INCj4gPiByZXBvcnQgc29tZSBwcm9wZXJ0aWVzIHNwZWNpZmljIHRv
IGluZGl2aWR1YWwgSVBzLiBUaGUgcmVnbWFwIGlzDQo+ID4gcmVnaXN0ZXJlZCBhcyBhIHN5c2Nv
biBkZXZpY2UgdG8gYWxsb3cgdGhlc2UgSVAgZHJpdmVycyB0byBhY2Nlc3MgdGhlDQo+ID4gcmVn
aXN0ZXJzIHRocm91Z2ggdGhlIHJlZ21hcCBBUEkuDQo+ID4NCj4gPiBBcyBvdGhlciBSWiBTb0Nz
IG1pZ2h0IGhhdmUgY3VzdG9tIHJlYWQvd3JpdGUgY2FsbGJhY2tzIG9yDQo+ID4gbWF4LW9mZnNl
dHMsIGFkZCByZWdpc3RlciBhIGN1c3RvbSByZWdtYXAgY29uZmlndXJhdGlvbi4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBicC5yZW5lc2FzLmNv
bT4NCj4gPiBbY2xhdWRpdS5iZXpuZWE6DQo+ID4gIC0gcy9yemczZV9zeXNjX3JlZ21hcC9yenYy
aF9zeXNjX3JlZ21hcCBpbiBSWi9WMkggc3lzYw0KPiA+ICAgIGZpbGUNCj4gPiAgLSBkbyBub3Qg
Y2hlY2sgdGhlIG1hdGNoLT5kYXRhIHZhbGlkaXR5IGluIHJ6X3N5c2NfcHJvYmUoKSBhcyBpdCBp
cw0KPiA+ICAgIGFsd2F5cyB2YWxpZA0KPiA+ICAtIHJlZ2lzdGVyIHRoZSByZWdtYXAgaWYgZGF0
YS0+cmVnbWFwX2NmZyBpcyB2YWxpZF0NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5l
YSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHlv
dXIgcGF0Y2ghDQo+IA0KPiBBcyB5b3UgcHJvYmFibHkgbm90aWNlZCwgSSBhbSBub3QgYSBiaWcg
ZmFuIG9mIHN5c2Nvbiwgc28gSSB0cnkgdG8gYXZvaWQNCj4gZ2V0dGluZyBpbnZvbHZlZCB3aXRo
IHN5c2NvbiBwYXRjaGVzIGFzIG11Y2ggYXMgcG9zc2libGUuDQo+IEJ1dCB0aGlzIHBhdGNoIGhh
cyBhcHBlYXJlZCBpbiBtdWx0aXBsZSBzZXJpZXMsIHNvIEkgYW0gYWZyYWlkIEkgY2Fubm90DQo+
IGF2b2lkIGl0IGFueW1vcmUgOy0pDQo+IA0KPiA+IC0tLSBhL2RyaXZlcnMvc29jL3JlbmVzYXMv
cjlhMDhnMDQ1LXN5c2MuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL3JlbmVzYXMvcjlhMDhnMDQ1
LXN5c2MuYw0KPiA+IEBAIC0xOCw2ICsxOCwxNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJ6X3N5
c2Nfc29jX2lkX2luaXRfZGF0YQ0KPiByemczc19zeXNjX3NvY19pZF9pbml0X2RhdGEgX19pbml0
Yw0KPiA+ICAgICAgICAgLnNwZWNpZmljX2lkX21hc2sgPSBHRU5NQVNLKDI3LCAwKSwgIH07DQo+
ID4NCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCByZWdtYXBfY29uZmlnIHJ6ZzNzX3N5c2NfcmVn
bWFwIF9faW5pdGNvbnN0ID0gew0KPiA+ICsgICAgICAgLm5hbWUgPSAicnpnM3Nfc3lzY19yZWdz
IiwNCj4gPiArICAgICAgIC5yZWdfYml0cyA9IDMyLA0KPiA+ICsgICAgICAgLnJlZ19zdHJpZGUg
PSA0LA0KPiA+ICsgICAgICAgLnZhbF9iaXRzID0gMzIsDQo+ID4gKyAgICAgICAuZmFzdF9pbyA9
IHRydWUsDQo+ID4gKyAgICAgICAubWF4X3JlZ2lzdGVyID0gMHhlMjAsDQo+ID4gK307DQo+IA0K
PiBTdHJ1Y3QgcmVnbWFwX2NvbmZpZyBpcyBhIHJhdGhlciBsYXJnZSBzdHJ1Y3R1cmUsIGFuZCB0
aGUgb25seSBTb0Mtc3BlY2lmaWMNCj4gbWVtYmVycyBhcmUgdGhlIC5uYW1lICh3aGljaCBkb2Vz
bid0IHJlYWxseSBtYXR0ZXIpIGFuZCAubWF4X3JlZ2lzdGVyDQo+IG1lbWJlcnMuICBIZW5jZSBw
bGVhc2UgbW92ZSAubWF4X3JlZ2lzdGVyIGJhY2sgdG8gc3RydWN0IHJ6X3N5c2NfaW5pdF9kYXRh
DQo+IChsaWtlIGluIHY1KSwgYW5kIGFsbG9jYXRlIHN0cnVjdCByZWdtYXBfY29uZmlnIGR5bmFt
aWNhbGx5IChieSBlbWJlZGRpbmcNCj4gaXQgaW50byBzdHJ1Y3Qgcnpfc3lzYykuDQo+IA0KPiA+
ICsNCj4gPiAgY29uc3Qgc3RydWN0IHJ6X3N5c2NfaW5pdF9kYXRhIHJ6ZzNzX3N5c2NfaW5pdF9k
YXRhIF9faW5pdGNvbnN0ID0gew0KPiA+ICAgICAgICAgLnNvY19pZF9pbml0X2RhdGEgPSAmcnpn
M3Nfc3lzY19zb2NfaWRfaW5pdF9kYXRhLA0KPiA+ICsgICAgICAgLnJlZ21hcF9jZmcgPSAmcnpn
M3Nfc3lzY19yZWdtYXAsDQo+ID4gIH07DQo+IA0KPiA+IC0tLSBhL2RyaXZlcnMvc29jL3JlbmVz
YXMvcnotc3lzYy5jDQo+ID4gKysrIGIvZHJpdmVycy9zb2MvcmVuZXNhcy9yei1zeXNjLmMNCj4g
PiBAQCAtMTE3LDcgKzEyNCwxNSBAQCBzdGF0aWMgaW50IHJ6X3N5c2NfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9F
UlIoc3lzYy0+YmFzZSk7DQo+ID4NCj4gPiAgICAgICAgIHN5c2MtPmRldiA9IGRldjsNCj4gPiAt
ICAgICAgIHJldHVybiByel9zeXNjX3NvY19pbml0KHN5c2MsIG1hdGNoKTsNCj4gPiArICAgICAg
IHJldCA9IHJ6X3N5c2Nfc29jX2luaXQoc3lzYywgbWF0Y2gpOw0KPiA+ICsgICAgICAgaWYgKHJl
dCB8fCAhZGF0YS0+cmVnbWFwX2NmZykNCj4gDQo+IGRhdGEtPnJlZ21hcF9jZmcgc2hvdWxkIG5l
dmVyIGJlIE5VTEwgKGJ1dCB0aGlzIGRvZXNuJ3QgbWF0dGVyIGFueW1vcmUsDQo+IGluIHRoZSBj
b250ZXh0IG9mIG15IHJlcXVlc3QgYWJvdmUpLg0KPiANCj4gPiArICAgICAgICAgICAgICAgcmV0
dXJuIHJldDsNCj4gPiArDQo+ID4gKyAgICAgICByZWdtYXAgPSBkZXZtX3JlZ21hcF9pbml0X21t
aW8oZGV2LCBzeXNjLT5iYXNlLCBkYXRhLQ0KPiA+cmVnbWFwX2NmZyk7DQo+ID4gKyAgICAgICBp
ZiAoSVNfRVJSKHJlZ21hcCkpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKHJl
Z21hcCk7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIG9mX3N5c2Nvbl9yZWdpc3Rlcl9yZWdt
YXAoZGV2LT5vZl9ub2RlLCByZWdtYXApOw0KPiA+ICB9DQo+IA0KPiBUaGUgcmVzdCBMR1RNLg0K
DQpXaWxsIG1ha2UgdGhlIGNoYW5nZXMgYXMgcGVyIHRoZSB2NS4gVGhhbmtzIQ0KDQo+IA0KPiBH
cntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+
IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJl
eW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LQ0KPiBtNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwg
Y29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNr
ZXIuDQo+IEJ1dCB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInBy
b2dyYW1tZXIiIG9yIHNvbWV0aGluZw0KPiBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg0KUmVnYXJkcywNCkpvaG4NCg==

