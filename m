Return-Path: <linux-pm+bounces-24758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69869A7A39A
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 15:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24751174FD4
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 13:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076B324E01F;
	Thu,  3 Apr 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="wN2Pt4wV"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011036.outbound.protection.outlook.com [40.107.74.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D599A24E015;
	Thu,  3 Apr 2025 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743686584; cv=fail; b=o8MoAIOOqQOf9MfSjY4KPDJbLE8pUx+ac3HYXslywGrn6Y1hrBNedmMk8fdBUwbOONLEGJ2Ug0nCE/DJig4BovOXMEMRBD5VHZGwcQRFDkFvmjTmWGN6xz7E1IywYYdhewtPG4Ab85cJNhU7+cxhUz8Z5L+mMBPcBNITuXht/5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743686584; c=relaxed/simple;
	bh=9gVye8RzEGuTJRg8m98bp7inBy7OmPU91596SkW9Dlo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=foppiWKDaJl+NEFpr5o7VjXWhwy4pPje4Uaoa8SDu41J+fCdLTT5yuXdpwdeVK6x28LO15L+ju4mHZI5Sixd2qQzY9nxn9J0w44fSYdM1nPYlJFa/EEEtNvgToRaEvYv2p1J7viv9UlWBkWvgr1NvmsGLTsLqtYI8kdHG9B6JSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=wN2Pt4wV; arc=fail smtp.client-ip=40.107.74.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VumwKO5FHU1WDfFb8ZsBC4T3pa1KCGdrvWorAbE4500/rOspsZUoqfKmvFGVb3FOmoQXnM/bXfHyLyOlWTvGAA+jGn1i3pFNqXDu73yZ8hrTwVDQbbo1g6LXHGvKssqle/DJA+tU8qMUYzt54+U1CX2xelW8PPaJ6oma7KjclIG+7LBLzgV8c1i3VOYnj105XZOMP+JUlgq4YbMOlr7HNy0sRYmxiZ2XQxeS6mSHauyVCrij8/nsMoh2KyCNeKCvBZlsOpR1qgDJkLrRok+Q08yg+XCyOm1ammMsGPxYazllTtqu7HEBQiu5IxoY5RV0F0lEN3cqBcC3jyFfuhlVuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gVye8RzEGuTJRg8m98bp7inBy7OmPU91596SkW9Dlo=;
 b=Jk3ODjTTa+ZTtQoeUcb+L1xRQAr1tzTuhxsViICq58y10lBJ+60uC/1/eS2r8QMRrmRfWS3D+DOYatGTXpfiP935wqCCQQ8MKPj17z2zE0R/kUCJ2kq3X0uiWbb+unh5jH5AHyOdZgnvZ7W59aziajTJLTR3FiJVXs9B/OZ2RGYKNQn702dVxzgPQW+xkDlDfB4ihNeRbTwO89maZn3zgVPfjCwtlRKPSG9csLZlmbkCg9yySZ4Moe+S1GB3qZ5ZlLrtrqLofgSQAWaV/NgVSIvp06soOxvOI7R45/svXTfFwpBWZC8z2RPSSLFd7DK0gGkyDrXzE3a53Fe80rDkaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gVye8RzEGuTJRg8m98bp7inBy7OmPU91596SkW9Dlo=;
 b=wN2Pt4wVLdpuGDv16+VXiFB8oir71vljE7BB2/fQ6rB0HhNaDD/WUZNfd/FJszMKYadPKR07fSn5jy5JWnNk1ISk6TjAcF9NEi8W8JqUwys7pZ7KniEuao5f078O2NSsRip1BS1YtJ/A3y10bizK41kXmJBPPt00yypaM5R4WCM=
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com (2603:1096:604:13::17)
 by OS3PR01MB9976.jpnprd01.prod.outlook.com (2603:1096:604:1e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Thu, 3 Apr
 2025 13:22:53 +0000
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b]) by OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b%2]) with mapi id 15.20.8583.038; Thu, 3 Apr 2025
 13:22:51 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC: "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"john.madieu@gmail.com" <john.madieu@gmail.com>, "rui.zhang@intel.com"
	<rui.zhang@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "sboyd@kernel.org" <sboyd@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>
Subject: RE: [PATCH v5 1/5] soc: renesas: rz-sysc: add syscon/regmap support
Thread-Topic: [PATCH v5 1/5] soc: renesas: rz-sysc: add syscon/regmap support
Thread-Index: AQHbocDOdKVSAMtBFUO6x2CfxEhaz7ORmmUAgABYydA=
Date: Thu, 3 Apr 2025 13:22:51 +0000
Message-ID:
 <OSBPR01MB27759C8297B461427714BBB3FFAE2@OSBPR01MB2775.jpnprd01.prod.outlook.com>
References: <20250330214945.185725-1-john.madieu.xa@bp.renesas.com>
 <20250330214945.185725-2-john.madieu.xa@bp.renesas.com>
 <8412725b-8d62-44a1-8929-7de7de8dfdbf@tuxon.dev>
In-Reply-To: <8412725b-8d62-44a1-8929-7de7de8dfdbf@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB2775:EE_|OS3PR01MB9976:EE_
x-ms-office365-filtering-correlation-id: 97f32991-8fc5-435c-98e9-08dd72b2a270
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YzBRdXhqMFdkYTdIWTNBc1Jyc2tOTmhleERsZ3haaXpsNC9Za3k2dDIzeWNP?=
 =?utf-8?B?YkVKbnBLYTFVemd5Vlg0cG9MU1dtUVZVU2hISk9xak9tT0syczc0MHhMRCtC?=
 =?utf-8?B?Y0dxeTNLWlM0ZlNlbTA5cFpPRkhvUXdkT1V1NE0wS2Z0ZmxmZmREbWhIZzBw?=
 =?utf-8?B?QzZIVVcvdFFUNENjNFAvbENXV0ZyOGFwQ3ZPN2J3anZlZStOYnhtMmFSbUs1?=
 =?utf-8?B?MjBmbVl2Z3o4WklTWEpMUEIzWmtsUGRoa0dYdzNHbjBvTDdSUDVKYXhxUTBS?=
 =?utf-8?B?ODh0eGIrczJGR2I1MEpGQWZBL1JMMXVQTVM0aXVQVUd5ejJHWWNUckU0dWdi?=
 =?utf-8?B?SVZuQnZ5UXUwOEtjQXR2UE5vZHM5RkNIUEVhQjc2OWtoM3BZRkpjdHhnakdq?=
 =?utf-8?B?aWRNZW9RUHFYNXVRYms5Y2xOVjZtTWx0RW5ONFBNOWMvVzRRVGc3WXQ1cWs5?=
 =?utf-8?B?M2xBa1dua2k1QTNuSmJwek5XOVVJRVFsWUtEVHA3TmU0czVMajdkY1NPOUpZ?=
 =?utf-8?B?SmhZamVnc2lDT0NGdE51aDh5R2oyUkNscmpCaVk0eWlxSVNPekNzV0U4azJ5?=
 =?utf-8?B?bmZycm1ET2ZLV3dUMTZZaE5KNmxaSDhhSzRZODFldVN1REF6ZzY4dnVLSkI2?=
 =?utf-8?B?WGdNbTdxVFlTN04xam1aUnV3N2k3dkF6UzR2RmZLd3lOS2ZNZDZldmxRUk5a?=
 =?utf-8?B?ZlVDRFIyR083bExxaUFUREhWRG1zYTdPSUpHRDEvS0Rxc3YzaGcrRDNwbzV6?=
 =?utf-8?B?Ky9WOWpmbDM1eVcvOXhnMFp3UThwS2R2ckp0a0lBMThlWnNoMVFpcUR4RVZq?=
 =?utf-8?B?MVF1eFdEZ08waThPVnZPeGdvK2pPSSt5SXMvTkNjczQyMjVmaUZOdFBLbCtM?=
 =?utf-8?B?YlNRaEFPOUpPVDZHaTVpaVdVOUxsYjdUSEN0VElxdDRRSGlENHNUaVlUemti?=
 =?utf-8?B?WWhRVVdCUnhKVG1CdTF1eGc0SldqU0UvcVlVRUNZTm9HQzRKUVBta1JUb3Ur?=
 =?utf-8?B?RDlrWkZUOCtBcWFUUWRNcDVQZ3BuM3FxZVorOGE0Y3FkR3R6R25jRCtqeHFi?=
 =?utf-8?B?WWN3ZGEwSmZoZWw4MUZzTEkyZkN1WjlTWlV1aDNvNmVSa0xmQzJ6bGcxdC95?=
 =?utf-8?B?ZnRpaUI1S2R2L012a05LZ1JMcUs3K1dZc1NoSDJraU1RZEtjYzIvd253eUsy?=
 =?utf-8?B?d2tEUGJHSncxdTMzZzUwTG1tcTZ6RHFwZU9CYzE3S2RVaWxYNytadUJUSUNM?=
 =?utf-8?B?S3o5Z3FpNUNENVVPVlh5YmhSSmVQY21ENy9rTDNGZUlGQjEzRnpKUTZ4S0tQ?=
 =?utf-8?B?QmVydEZMeVJyZE1KYTErMlcycitHRldDclpiejcwZUp3cWMvWU1PVUhoYVdl?=
 =?utf-8?B?NDFyeVVncWR2ZmtpZkNwdGg5K056V1RDNVNHeGxuUDJyc3F2SUFtMHNMWW52?=
 =?utf-8?B?RkhWdVoyeFJPaDljSURaSDNFZkx6QWwydGV2WG54a3VLUHBMdTZXV3IwRnFS?=
 =?utf-8?B?cjhlTVRvV1UzbWc5WTR4V0R1M211QW16NXFvTWdPUzlxalhBaHdsR2txaFR3?=
 =?utf-8?B?S0htb0VOMGtKWnhkczQ2bTlRMkFXWmY4R3Bzbjk5aXdFT0VZeWdMT2lwWCt6?=
 =?utf-8?B?amtvcVZtSzlQemo2RXRSSjIvZGUybFdGREJCZHJZUVNGTUNZL29lQTZya1U3?=
 =?utf-8?B?Sy9ZOVd1S21FeW1wbE5LN1h0Mk04QzNPYVk0c3UvalZvbHJobzZQQUR2YmYx?=
 =?utf-8?B?eFNRVnZxRXNGUU1Xei9VWUxEcW5oSU4rblpybEFBeU80NVduN1BkUmhNMGxW?=
 =?utf-8?B?bjBQWDliRWk0K2JCOFgyNEhaSVExdW9Ba1NTUnU1ZDg1ejdpeEhyUmhEalNE?=
 =?utf-8?B?YXlma1F3U2NjRlcyc3VFYWJCeFhGUFlJQXlYZjAwdC9aVGlDR05tOFRHRDRj?=
 =?utf-8?Q?6t77ROEMRYFuJTW5BWQZov2o6OT9iS32?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHFjcXB4Q2wyWmY5UzdGeU5MM1FsS21GQ2thZG9QaUVMemhIR1lReStUT21V?=
 =?utf-8?B?czlhMXppbDc5bi8xUlM3cnlUUStwclVXdWF4SEtYMmdYaVJCYytvRko2NU1H?=
 =?utf-8?B?alpSV0gxMDAzWVdvVytTdS9OWTArTFU5TFIxNCtuUDh0Qmg0VzRocENvRzVx?=
 =?utf-8?B?TjUwd2xsa2lHdHBFZzdUMjBBUUJHZHdrdXhybUIrZjdEOHNUd1FmU0doaUlG?=
 =?utf-8?B?d0xWamJIMEo4Nm1RSDdwWlNjV1ZRNWlLdXlJMzNkaE5RZkRQWUdWck4wTDE1?=
 =?utf-8?B?d05wWUcwajV1dnJSZFJYdTZ3UUY2RFdKT3M5ajMxNHJUeXJ5Qm1GUXN2Qjc3?=
 =?utf-8?B?MFRnZGtoc2FablJxNWxwOHk4cUtsUlBZd1c5ZldtMFdFQkNLblJrMUovZHRT?=
 =?utf-8?B?ZlUwblJzVWRybnBrMEplb2UvdUhiWEJBYW52TFB2cGJuLzNhbENCL1FPaGRE?=
 =?utf-8?B?NWhTb3pIM1RpT2grdkU5eGVXWEFYdzI0aFRMd1RYRWk3WFcxMkJPWWRQQTJT?=
 =?utf-8?B?cnN6RGdzSmhVZDlnWlM1alJyTzJ5bDBRS3N6cFBIQzN0WkcxWlBIeU4xTFNw?=
 =?utf-8?B?bGZFeHlOUGp2aHZDR1NkN0w1WGpJMEhyck5VTkM2NmVQTkdOdkgvT3V0S3lU?=
 =?utf-8?B?VksyS1BsR1NtZEhXQlRadDRTUXRpaUFKbERVRlgyd3liVHBDZlppNXhjY2Zv?=
 =?utf-8?B?RUZ6N0lCUUZLYW5nZ1p0U0o5NXBrSmR6QVhOaXR2bjlMNld2NkY1YU5GNVhv?=
 =?utf-8?B?QXNtU1VpSTVObnBoTTA2dTZqTTBwTXZadC9sTUtwRmVSbGpXc0ZXbFpMN0NV?=
 =?utf-8?B?ZVZsR0NPeTdBTjJReThVVDY4dzBrNHJ6RjAyNUFaNDN3ZWdNcjZuTW1ldHE2?=
 =?utf-8?B?RDYrN2xOVXlqNEZZY1NidjBQVHN3amZFODYzNkt4L1JoQWlQUnNSaVdMaVRy?=
 =?utf-8?B?Nk9Ca3ZvNkhmZmIrTGs4NmwyM2NaY2ZtMC92K3FGcVZUT0kzbXVVNTVhRW15?=
 =?utf-8?B?TnJYU3J2cU5zbnBZcUx6ZEZNSUpxU3pXVnFuKzlON2JmZGVVZWx2dEpBclNk?=
 =?utf-8?B?dDh6SFdueVZCUVVvbUZJWWg4ZUJ2OG1JSXdiZjhTeXF5RndNN1Zja1NiRVRV?=
 =?utf-8?B?S29kcGtQNFVHZ09HcCszMmpRWlBsZ0J2WDFrZkg1Z0pDK3FRSThLeDNiOXRY?=
 =?utf-8?B?MTZRUlZzbEJvTllnRTR5VWVzdTd0UlJmdk5sUE9Fc1pnWFZHSnlxV1FKWnJ0?=
 =?utf-8?B?TDF6MnUwdVQvbjdMUXNIY096RE9seGQvOXV2UWlPRzNOblpjbGZwVi9BOHE2?=
 =?utf-8?B?dWY3bHJ0MWxNSTR5K1Bic2txdE4xOWZ0NkhpOVZXUjRsN212NkkrY3dRY3ZK?=
 =?utf-8?B?SlNWSFhtQ3lWR1dXdHl0b0JldEVobStoZ2lEOVkvL0o2alFSN051b2pCMndI?=
 =?utf-8?B?eDgrNEVYL1l1VzFJblM1NWtJRk85NzMvUWZRdTJJbGFnc0t5d0NUUkJrVDkr?=
 =?utf-8?B?cFJPdHMyb1VYVnZWaEhxcGhSMUV5dnhOZE5jSVFjb3lJbmFwRVB3OS9lTnhI?=
 =?utf-8?B?bVZEeVNKdzdyOXM4YWsvSElZeGtjZXN4S0hIc1g5eno5VklybEZHTWljOThn?=
 =?utf-8?B?dDJwMTZ0RkNFV3pVenZFcUNZMmM4RURLbHNxMGhrWW9qV0xmNDhwSVZUbjYx?=
 =?utf-8?B?NElZUnppZG1uQ0IxZC9MbW5lRVBKeXp0QTBPRkR6ZDYyZGtkcmVoVnVZZURN?=
 =?utf-8?B?eGpLL1Nlb2tHRTc5ZWl5ZjZpOGs5bDNVMlVXOXh0bEcxU2tNRW4rSzZ5Q1RG?=
 =?utf-8?B?eUQxdFNJazQ0K2RuY3FxT3BIQ0NnTEc0VjlWR1dSQUk1OGtPTldGUHBNZU5a?=
 =?utf-8?B?NmRESE1DMGNVSXV2dGwwVVFSYXJxcVJZaHAvRWVqWFFRMTBITGczZTdDalI5?=
 =?utf-8?B?djlPZ0F4ajBITEo3MGlVZU5FNzkvQi9QRDdzeW9Da21DNkd2K0RxaUtzSEgz?=
 =?utf-8?B?YVgweUwwRFVtcW5ZUkVHSFI1Nk95Kys5ZW82Y1ZZRW9VVDN0bjY2dXNXWkkx?=
 =?utf-8?B?QW44eFQvdEluRU9id0dOb2s5VmRIZTJDeHJFUXFBbTRTQlNIY21OYUZxMlhK?=
 =?utf-8?B?azAxNmZleWVZWWNVTlhXYU5tcTNsMkkvdm9HYVZiZUtwRUthdklrb0N3dVpP?=
 =?utf-8?B?QXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f32991-8fc5-435c-98e9-08dd72b2a270
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 13:22:51.1343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NB8s7p+z0mz+QH48arZDdCvkdjWvHoGO4i8UiXtaOqRkaplDs8Ko0bd9u9CU1bVWIv34df35DdtKLjHHwLP4vX2J383dcUV1W9cfXrI0qQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9976

SGkgQ2xhdWRpdSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQHR1
eG9uLmRldj4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDMsIDIwMjUgMTA6MDQgQU0NCj4gVG86
IEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBicC5yZW5lc2FzLmNvbT47IGdlZXJ0K3JlbmVz
YXNAZ2xpZGVyLmJlOw0KPiBjb25vcitkdEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7
IHJvYmhAa2VybmVsLm9yZzsNCj4gcmFmYWVsQGtlcm5lbC5vcmc7IGRhbmllbC5sZXpjYW5vQGxp
bmFyby5vcmcNCj4gQ2M6IG1hZ251cy5kYW1tQGdtYWlsLmNvbTsgZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGpvaG4ubWFkaWV1QGdtYWlsLmNvbTsgcnVpLnpoYW5nQGludGVsLmNvbTsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtcmVuZXNhcy1zb2NAdmdlci5r
ZXJuZWwub3JnOyBzYm95ZEBrZXJuZWwub3JnOyBCaWp1IERhcw0KPiA8YmlqdS5kYXMuanpAYnAu
cmVuZXNhcy5jb20+OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGx1a2Fzei5sdWJhQGFy
bS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxLzVdIHNvYzogcmVuZXNhczogcnotc3lz
YzogYWRkIHN5c2Nvbi9yZWdtYXANCj4gc3VwcG9ydA0KPiANCj4gSGksIEpvaG4sDQo+IA0KPiBP
biAzMS4wMy4yMDI1IDAwOjQ5LCBKb2huIE1hZGlldSB3cm90ZToNCj4gPiBUaGUgUlovRzNFIHN5
c3RlbSBjb250cm9sbGVyIGhhcyB2YXJpb3VzIHJlZ2lzdGVycyB0aGF0IGNvbnRyb2wgb3INCj4g
PiByZXBvcnQgc29tZSBwcm9wZXJ0aWVzIHNwZWNpZmljIHRvIGluZGl2aWR1YWwgSVBzLiBUaGUg
cmVnbWFwIGlzDQo+ID4gcmVnaXN0ZXJlZCBhcyBhIHN5c2NvbiBkZXZpY2UgdG8gYWxsb3cgdGhl
c2UgSVAgZHJpdmVycyB0byBhY2Nlc3MgdGhlDQo+ID4gcmVnaXN0ZXJzIHRocm91Z2ggdGhlIHJl
Z21hcCBBUEkuDQo+ID4NCj4gPiBBcyBvdGhlciBSWiBTb0NzIG1pZ2h0IGhhdmUgY3VzdG9tIHJl
YWQvd3JpdGUgY2FsbGJhY2tzIG9yDQo+ID4gbWF4LW9mZnNldHMsIGxldCdzIHJlZ2lzdGVyIGEg
Y3VzdG9tIHJlZ21hcCBjb25maWd1cmF0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm9o
biBNYWRpZXUgPGpvaG4ubWFkaWV1LnhhQGJwLnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+IHYx
IC0+IHYyOiBubyBjaGFuZ2VzDQo+ID4gdjIgLT4gdjM6IG5vIGNoYW5nZXMNCj4gPiB2MyAtPiB2
NDogbm8gY2hhbmdlcw0KPiA+IHY0IC0+IHY1OiBubyBjaGFuZ2VzDQo+ID4NCj4gPiBOb3RlIGZv
ciBNYWludGFpbmVyczogVGhlcmUgaXMgYSBmYWxzZSBwb3NpdGl2ZSB3YXJuaW5nIHJlcG9ydGVk
IGJ5DQo+ID4gY2hlY2twYXRjaC5wbCBvbiB0aGlzIHBhdGNoIHBhdGNoIHN0YXRpbmcgdGhhdCB0
aGUgcmVnbWFwX2NvbmZpZw0KPiA+IHN0cnVjdCBzaG91bGQgYmUgY29uc3QsIGRlc3BpdGUgdGhl
IGZhY3QgaXQncyB1cGRhdGVkIGluIHByb2JlKCkuDQo+ID4NCj4gPiAgZHJpdmVycy9zb2MvcmVu
ZXNhcy9LY29uZmlnICAgICAgICAgfCAgMSArDQo+ID4gIGRyaXZlcnMvc29jL3JlbmVzYXMvcjlh
MDlnMDQ3LXN5cy5jIHwgIDEgKw0KPiA+ICBkcml2ZXJzL3NvYy9yZW5lc2FzL3J6LXN5c2MuYyAg
ICAgICB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gIGRyaXZlcnMvc29j
L3JlbmVzYXMvcnotc3lzYy5oICAgICAgIHwgIDIgKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAz
MyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zb2MvcmVuZXNhcy9LY29uZmlnIGIvZHJpdmVycy9zb2MvcmVuZXNhcy9LY29uZmlnDQo+
ID4gaW5kZXggNDk2NDhjZjI4YmQyLi4zZmZkM2E0Y2ExOGQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9zb2MvcmVuZXNhcy9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9zb2MvcmVuZXNhcy9L
Y29uZmlnDQo+ID4gQEAgLTM4OCw2ICszODgsNyBAQCBjb25maWcgUlNUX1JDQVINCj4gPg0KPiA+
ICBjb25maWcgU1lTQ19SWg0KPiA+ICAJYm9vbCAiU3lzdGVtIGNvbnRyb2xsZXIgZm9yIFJaIFNv
Q3MiIGlmIENPTVBJTEVfVEVTVA0KPiA+ICsJc2VsZWN0IE1GRF9TWVNDT04NCj4gPg0KPiA+ICBj
b25maWcgU1lTQ19SOUEwOEcwNDUNCj4gPiAgCWJvb2wgIlJlbmVzYXMgUlovRzNTIFN5c3RlbSBj
b250cm9sbGVyIHN1cHBvcnQiIGlmIENPTVBJTEVfVEVTVCBkaWZmDQo+ID4gLS1naXQgYS9kcml2
ZXJzL3NvYy9yZW5lc2FzL3I5YTA5ZzA0Ny1zeXMuYw0KPiA+IGIvZHJpdmVycy9zb2MvcmVuZXNh
cy9yOWEwOWcwNDctc3lzLmMNCj4gPiBpbmRleCBjZDJlYjc3ODJjZmUuLjViMDEwYTUxOWZhYiAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9yZW5lc2FzL3I5YTA5ZzA0Ny1zeXMuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvc29jL3JlbmVzYXMvcjlhMDlnMDQ3LXN5cy5jDQo+ID4gQEAgLTY0LDQg
KzY0LDUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCByel9zeXNjX3NvY19pZF9pbml0X2RhdGENCj4g
PiByemczZV9zeXNfc29jX2lkX2luaXRfZGF0YSBfX2luaXRjbw0KPiA+DQo+ID4gIGNvbnN0IHN0
cnVjdCByel9zeXNjX2luaXRfZGF0YSByemczZV9zeXNfaW5pdF9kYXRhID0gew0KPiA+ICAJLnNv
Y19pZF9pbml0X2RhdGEgPSAmcnpnM2Vfc3lzX3NvY19pZF9pbml0X2RhdGEsDQo+ID4gKwkubWF4
X3JlZ2lzdGVyX29mZnNldCA9IDB4MTcwYywNCj4gPiAgfTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zb2MvcmVuZXNhcy9yei1zeXNjLmMNCj4gPiBiL2RyaXZlcnMvc29jL3JlbmVzYXMvcnot
c3lzYy5jIGluZGV4IDFjOThkYTM3YjdkMS4uYmNiYzIzZGE5NTRiDQo+ID4gMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9zb2MvcmVuZXNhcy9yei1zeXNjLmMNCj4gPiArKysgYi9kcml2ZXJzL3Nv
Yy9yZW5lc2FzL3J6LXN5c2MuYw0KPiA+IEBAIC02LDggKzYsMTAgQEANCj4gPiAgICovDQo+ID4N
Cj4gPiAgI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9tZmQvc3lz
Y29uLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgv
cGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCj4gPiAg
I2luY2x1ZGUgPGxpbnV4L3N5c19zb2MuaD4NCj4gPg0KPiA+ICAjaW5jbHVkZSAicnotc3lzYy5o
Ig0KPiA+IEBAIC04MSw2ICs4MywxNCBAQCBzdGF0aWMgaW50IHJ6X3N5c2Nfc29jX2luaXQoc3Ry
dWN0IHJ6X3N5c2MgKnN5c2MsDQo+IGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKm1hdA0KPiA+
ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgc3RydWN0IHJlZ21hcF9jb25m
aWcgcnpfc3lzY19yZWdtYXAgPSB7DQo+ID4gKwkubmFtZSA9ICJyel9zeXNjX3JlZ3MiLA0KPiA+
ICsJLnJlZ19iaXRzID0gMzIsDQo+ID4gKwkucmVnX3N0cmlkZSA9IDQsDQo+ID4gKwkudmFsX2Jp
dHMgPSAzMiwNCj4gPiArCS5mYXN0X2lvID0gdHJ1ZSwNCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHJ6X3N5c2NfbWF0Y2hbXSA9IHsgICNpZmRl
Zg0KPiA+IENPTkZJR19TWVNDX1I5QTA4RzA0NQ0KPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJyZW5l
c2FzLHI5YTA4ZzA0NS1zeXNjIiwgLmRhdGEgPQ0KPiA+ICZyemczc19zeXNjX2luaXRfZGF0YSB9
LCBAQCAtOTcsMTQgKzEwNywyMSBAQCBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLA0KPiA+IHJ6X3N5
c2NfbWF0Y2gpOw0KPiA+DQo+ID4gIHN0YXRpYyBpbnQgcnpfc3lzY19wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KSAgew0KPiA+ICsJY29uc3Qgc3RydWN0IHJ6X3N5c2NfaW5pdF9k
YXRhICpkYXRhOw0KPiA+ICAJY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqbWF0Y2g7DQo+ID4g
IAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICsJc3RydWN0IHJlZ21hcCAq
cmVnbWFwOw0KPiA+ICAJc3RydWN0IHJ6X3N5c2MgKnN5c2M7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+
DQo+ID4gIAltYXRjaCA9IG9mX21hdGNoX25vZGUocnpfc3lzY19tYXRjaCwgZGV2LT5vZl9ub2Rl
KTsNCj4gPiAgCWlmICghbWF0Y2gpDQo+ID4gIAkJcmV0dXJuIC1FTk9ERVY7DQo+ID4NCj4gPiAr
CWRhdGEgPSBtYXRjaC0+ZGF0YTsNCj4gPiArCWlmICghZGF0YSkNCj4gPiArCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gPiArDQo+ID4gIAlzeXNjID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpzeXNj
KSwgR0ZQX0tFUk5FTCk7DQo+ID4gIAlpZiAoIXN5c2MpDQo+ID4gIAkJcmV0dXJuIC1FTk9NRU07
DQo+ID4gQEAgLTExNCw3ICsxMzEsMTggQEAgc3RhdGljIGludCByel9zeXNjX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ID4gIAkJcmV0dXJuIFBUUl9FUlIoc3lzYy0+
YmFzZSk7DQo+ID4NCj4gPiAgCXN5c2MtPmRldiA9IGRldjsNCj4gPiAtCXJldHVybiByel9zeXNj
X3NvY19pbml0KHN5c2MsIG1hdGNoKTsNCj4gPiArCXJldCA9IHJ6X3N5c2Nfc29jX2luaXQoc3lz
YywgbWF0Y2gpOw0KPiANCj4gVGhlIHJldHVybiB2YWx1ZSBvZiByel9zeXNjX3NvY19pbml0KCkg
aXMgbG9zdCBpbiBjYXNlDQo+IGRhdGEtPm1heF9yZWdpc3Rlcl9vZmZzZXQgIT0gMC4gSXMgdGhl
cmUgYSByZWFzb24gZm9yIHRoaXM/DQoNClRoZXJlIGlzIG5vIHJlYXNvbiBmb3IgdGhpcy4gV2ls
bCBmaXggaXQgZm9yIHY2Lg0KDQo+IA0KPiA+ICsNCj4gPiArCWlmIChkYXRhLT5tYXhfcmVnaXN0
ZXJfb2Zmc2V0KSB7DQo+ID4gKwkJcnpfc3lzY19yZWdtYXAubWF4X3JlZ2lzdGVyID0gZGF0YS0+
bWF4X3JlZ2lzdGVyX29mZnNldDsNCj4gPiArCQlyZWdtYXAgPSBkZXZtX3JlZ21hcF9pbml0X21t
aW8oZGV2LCBzeXNjLT5iYXNlLA0KPiAmcnpfc3lzY19yZWdtYXApOw0KPiA+ICsJCWlmIChJU19F
UlIocmVnbWFwKSkNCj4gPiArCQkJcmV0dXJuIFBUUl9FUlIocmVnbWFwKTsNCj4gPiArDQo+ID4g
KwkJcmV0ID0gb2Zfc3lzY29uX3JlZ2lzdGVyX3JlZ21hcChkZXYtPm9mX25vZGUsIHJlZ21hcCk7
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0
YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHJ6X3N5c2NfZHJpdmVyID0geyBkaWZmIC0tZ2l0
DQo+ID4gYS9kcml2ZXJzL3NvYy9yZW5lc2FzL3J6LXN5c2MuaCBiL2RyaXZlcnMvc29jL3JlbmVz
YXMvcnotc3lzYy5oIGluZGV4DQo+ID4gYWE4Mzk0OGM1MTE3Li4zN2EzYmIyYzg3ZjggMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvcmVuZXNhcy9yei1zeXNjLmgNCj4gPiArKysgYi9kcml2
ZXJzL3NvYy9yZW5lc2FzL3J6LXN5c2MuaA0KPiA+IEBAIC0zNCw5ICszNCwxMSBAQCBzdHJ1Y3Qg
cnpfc3lzY19zb2NfaWRfaW5pdF9kYXRhIHsNCj4gPiAgLyoqDQo+ID4gICAqIHN0cnVjdCByel9z
eXNjX2luaXRfZGF0YSAtIFJaIFNZU0MgaW5pdGlhbGl6YXRpb24gZGF0YQ0KPiA+ICAgKiBAc29j
X2lkX2luaXRfZGF0YTogUlogU1lTQyBTb0MgSUQgaW5pdGlhbGl6YXRpb24gZGF0YQ0KPiA+ICsg
KiBAbWF4X3JlZ2lzdGVyX29mZnNldDogTWF4aW11bSBTWVNDIHJlZ2lzdGVyIG9mZnNldCB0byBi
ZSB1c2VkIGJ5DQo+ID4gKyB0aGUgcmVnbWFwIGNvbmZpZw0KPiA+ICAgKi8NCj4gPiAgc3RydWN0
IHJ6X3N5c2NfaW5pdF9kYXRhIHsNCj4gPiAgCWNvbnN0IHN0cnVjdCByel9zeXNjX3NvY19pZF9p
bml0X2RhdGEgKnNvY19pZF9pbml0X2RhdGE7DQo+ID4gKwl1MzIgbWF4X3JlZ2lzdGVyX29mZnNl
dDsNCj4gPiAgfTsNCj4gPg0KPiA+ICBleHRlcm4gY29uc3Qgc3RydWN0IHJ6X3N5c2NfaW5pdF9k
YXRhIHJ6ZzNlX3N5c19pbml0X2RhdGE7DQoNClJlZ2FyZHMsDQpKb2huDQoNCg==

