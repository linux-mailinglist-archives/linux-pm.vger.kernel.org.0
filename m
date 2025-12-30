Return-Path: <linux-pm+bounces-40036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B62CE93D3
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 10:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9CE93002B92
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 09:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891E229D277;
	Tue, 30 Dec 2025 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com.cn header.i=@leica-geosystems.com.cn header.b="XEgrAwoG"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060F4272E7C;
	Tue, 30 Dec 2025 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767087636; cv=fail; b=A8KI79+llOZuK3oQsuHaOYu5SmE+qHgdB/TQtlmluaK9AQq5aCtbHuEKnBwgPaVeBqnZa0AK1SVfRwYGF24HYz/z6c0ieudqnFYPcRo/JE1MpRoR8ZN/PKogvO7ShYooBrWMilcOkbxHOyEgql+3Pdp1k5h1QYhu+z3J820dKxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767087636; c=relaxed/simple;
	bh=m7sGP5EZDU4qBKh1ROf5xx0xdDZRlGOJmgZjEvykbXU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SNBmdB9EJBiGxlN62XRcYClDxGAo9LoBXYjUK9A/uIZO0OxyE9m9oKpHL6lHOfsswova7lbcsUi8EztJbr2CzhWcU76LOF4pllAFN5oHQhoBk1VbpbZl2VTZjYdS4IyO4AX91Tzo5GElMJj2Xehg7FLk+f35lPhxWP/NmrpZ+lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com.cn; spf=fail smtp.mailfrom=leica-geosystems.com.cn; dkim=pass (1024-bit key) header.d=leica-geosystems.com.cn header.i=@leica-geosystems.com.cn header.b=XEgrAwoG; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com.cn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awqd3SAG65G2NPgZWc7nWdo7TW8GhHFgqHUNBv0pFIztBBZX7D4h1Y3FW7D3PWjGSZ6sgMBVC7wTXj3i39z+ZfdcBAFP6MZv5+ARTPIUAX2lm6PBTtfZRGiJNRtysKxZf4rOZQDQKF7Dkqw1qQMRvCbrju6Nl7MoUAweTwXLJBCImryYyrLfi4zCtOM98q2NGbY8yIWB5ekyAATR+ugKsC9KtLwPNZBe28tefOkoEyW0bTQyyZ/vuepV/cxEWNu9lsbuWoqAn6dFFVX+5S11NUv9IYkanAmwb/Nm3/q1OPj267FRjFbpt9wcy9g2oCAqdmrc20Uw78XPsCKNMA6LdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7sGP5EZDU4qBKh1ROf5xx0xdDZRlGOJmgZjEvykbXU=;
 b=bzIl5EYsRGDQqITSKvldkm1H65miUZSJDR4TD+7v8vFmtHCNfskuOzeDv0GSyn4dvD2J0vzeLo37MqsJ+Bik3nbdz3XppNu79iDHZVEi0hIxT77KfxKKSlBxwfqVmxUxR/E2Xd6LNK4wLqYdQO0EyN927VKjzPsGB7tqbrFnbbem3acBCgIPhCr5RD+qM1SjX7jaGgyd5i3N7d3vWWNdHM+C/XmtGpmVimVVQjjUcNIeUhCo+IsdHFzRKUNn5lDW8RtVyZtYrRTJPcB0zXxZcrf7ajnB+4nANmzUDcCAag4gdfSXM8cInCQ9mPD34QbeaF9Ac/ZjlA6Tv5EDozUMjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass action=none
 header.from=leica-geosystems.com.cn; dkim=pass
 header.d=leica-geosystems.com.cn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7sGP5EZDU4qBKh1ROf5xx0xdDZRlGOJmgZjEvykbXU=;
 b=XEgrAwoG+KQJr1GbRgGOnzVl1MVtSA4tTp4aNRzOe3E9d/eDexuGFXT8rjjj7to7jR/zjp5mar3BtkACYMHT1x0fcQTGyQM+zhYQRwTeNI33C74rjHjf9OjFNqlfCEr2J60RSwhwLyZHjlsuTQCf9PPx+DSlvtifsMqb1OAhlNU=
Received: from GV2PR06MB10809.eurprd06.prod.outlook.com
 (2603:10a6:150:2fa::21) by PAXPR06MB8508.eurprd06.prod.outlook.com
 (2603:10a6:102:2b6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 09:40:29 +0000
Received: from GV2PR06MB10809.eurprd06.prod.outlook.com
 ([fe80::f29e:9a49:43b4:80fb]) by GV2PR06MB10809.eurprd06.prod.outlook.com
 ([fe80::f29e:9a49:43b4:80fb%6]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 09:40:29 +0000
From: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To: Krzysztof Kozlowski <krzk@kernel.org>, "sre@kernel.org" <sre@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
Subject: RE: [PATCH V1 2/3] dt-bindings: power: sbs-battery: add polling
 interval property
Thread-Topic: [PATCH V1 2/3] dt-bindings: power: sbs-battery: add polling
 interval property
Thread-Index: AQHceKEMCnPg0huO8Eyf8LHjCnZylrU4VlOAgAAIeaCAADJmAIABXc4A
Date: Tue, 30 Dec 2025 09:40:29 +0000
Message-ID:
 <GV2PR06MB108091652BE6C23A6F9A7127CD7BCA@GV2PR06MB10809.eurprd06.prod.outlook.com>
References: <20251229085636.4082852-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20251229085636.4082852-2-Qing-wu.Li@leica-geosystems.com.cn>
 <63f1fd11-6628-4a83-b376-1e4efad6fd63@kernel.org>
 <GV2PR06MB108094811EF351CEA446A1ACBD7BFA@GV2PR06MB10809.eurprd06.prod.outlook.com>
 <4daabe4d-bebc-4072-b7c6-0c46ee087040@kernel.org>
In-Reply-To: <4daabe4d-bebc-4072-b7c6-0c46ee087040@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com.cn;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR06MB10809:EE_|PAXPR06MB8508:EE_
x-ms-office365-filtering-correlation-id: 40630df8-e3ea-4b87-bc73-08de478777f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3VTdTV6N2g5TFFTNEJjY3R3akdRSTJNbUF1bmZSV1k3VStmcHhvd0ZlMkt2?=
 =?utf-8?B?YnNCVHlQOHNwZUZiZWVqT2d2RkFXUUJvQ1IwUDk1ZlFPeTV6UUp5cWRSTjhV?=
 =?utf-8?B?eGJaSHMwOW1xb1R2Z3JvWVAyZDY1MWNrMnZXT2FGb2dLcXN4SGxFVi9EVkNx?=
 =?utf-8?B?WTJBSGFMMDJtbmc2QnhFS3NkdmNkZDRRUHdCU2Frb2V1aEtPYkxoRGFVYmpy?=
 =?utf-8?B?UGVWRUlSdms5ek5uYVM3dWo0c1c4MENEVGxzUmZFcHR0T2t4TlBYZERIc1Uy?=
 =?utf-8?B?cnRpMjY3VXl0WkxZdG5rZk15eDRIVmZZVUFZVStZZnY0MjY2bjAvbHZZUXZJ?=
 =?utf-8?B?dncwQU11NXB5cGJtNGFzeDRDYXhkUGFPZENqSXY1TVVIelkyc1owTjlBZysy?=
 =?utf-8?B?YWxMQVRzR2F2TytEY0hKdU1qNlRLRXNBZVk5REIzUWRXaCtEUG13ZDVOSjRw?=
 =?utf-8?B?ZlVvQmVObjB1T1lMVWltbklxV2ZrZ1FmZ1owSTVucEFMZm11ajZhRWRrSW5v?=
 =?utf-8?B?S3d1VnF3eDBkcUxZcWUyR3BJbEpwYmUxSWRZWDdUYmFKZ3YxUzl2bVBtbWNN?=
 =?utf-8?B?S0VBVDN6b2ZqaHI3UElvUDhWcmJjRjBpZUFjb25Ecm9WQnl4Znd4eEdwZllB?=
 =?utf-8?B?T2o2T0RzNHVrbFFkcDFDQXBVY2RvTlBaRkZna09OdXZERThVaERCM2Z1RG4r?=
 =?utf-8?B?MnNacSsxWkVHeVd1c3hyZWhZcG5hQlV2Qy9lNFNvbzlBL2ZzR0RGcDU5d0xq?=
 =?utf-8?B?RkRkdXU1VWR2MWlBQUdIM1ZTbGd4SEovM1dhRWFqUVU5cFU1ckhvQWdBTFVx?=
 =?utf-8?B?dDhKM0dZZFhDdlI3RTR5QTFJSUJUZVU0eDMzRUZseFc5aCtFbUlxUXlzVEJR?=
 =?utf-8?B?Q1FFTXhRUVpQVnJkWEppS2ROMjhRRHJIZVEyM3EwcVhXbXhma1J4YURWM3FY?=
 =?utf-8?B?Qzl5R2lYMEl6L0Q1Qy9YVW4xOXdaY054UzI1cnMvUnhKTTJYb0hoOVBrcFo2?=
 =?utf-8?B?Z0lrOExtakFwejRBSlBQQzloWThVU2d0Wi92c0xZeVZQVXl1UTliY3NXUm1L?=
 =?utf-8?B?eTVJMEk5ZW5MUWxmTy9keDVTWFhjSjhEMU5zcC9FdHFCbHlsaXRzcFdiOHdk?=
 =?utf-8?B?TytBV2tEZHZoa1ZKT2tsS25UY1RyWEoyczVDYWMwNlNIQmEyRktvOXlmdStw?=
 =?utf-8?B?K29UcmVydTMxRVJYZmtBTVlCdExxWGZVZ1BJYjkyZWZwUElET1VrWm5lWlE3?=
 =?utf-8?B?bGl5VEl1L1BPdXJqeFB3UVB2bjFCLzlVRlhHWnhhdUdnVjd2UFdld2hlc0xk?=
 =?utf-8?B?bkphbmJuMXBFSS94eHpTR2ZQcWlwT21pcHhBb2paM3JUT0h1OUZmSmZkdXFr?=
 =?utf-8?B?Wnk3OXM0cmQ1V1o5UWhaMURmV2E0M0FCZUtGWUlCZXY0a1pHT1hRY2xtZE03?=
 =?utf-8?B?Q1FPbXROSjZ4T1dra3hSdlR2T1FibnZKMjJUTTdFYTB3TjJDcGRCY0RxVzBG?=
 =?utf-8?B?K1hzRnI0SlZNK016REUwVitFUDNOQm90amx4TzhpaGNaanZ0ZTlRcGZRS2Ji?=
 =?utf-8?B?ZEhrWHFVWGpxYUZ1Z3liYm10N3hEMU9aTFZkYjlBdGlhYmRXQzRNd20yaDB2?=
 =?utf-8?B?WWViVVc1RzYzUkY0cEhPYWpLYWtpY3l4ZE92dnlKeXlLS0U5ZkVZK2lXWGtL?=
 =?utf-8?B?bGkrQVJFdzhhQzhQMWl6djVHTUgzeTl3MmtVRUFRdkpnbnJObzlCc2dlczRK?=
 =?utf-8?B?ZWVtREg4S0N5b2NQVXhvb0J0azdmblVFbHphUFltSkhJZjNFTE9xNWQvQ0Rp?=
 =?utf-8?B?TzFyclBocWE1MmVNQ0R0Z25lNDkxSnJvV3lpWTJJNVkwdzMxL3FoWjl0MFdM?=
 =?utf-8?B?Mng1aVBDMnE2M1p4aTNEWHBWajhLdTUxREpKNFBPMHdMWEk2RjlDbktzVlh1?=
 =?utf-8?B?bjVjeE1oVERVQTJrUzh4ZGJWaFhIbk9La1ZSYm8zMEJCc3BZdTIwODk5QmdG?=
 =?utf-8?B?TlZxeGZiQ095ODdpL091TWhuQ2RSeUNHRDdpVlBIdEd4L01vUUV1ZzR0N3pJ?=
 =?utf-8?Q?MgmwWD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR06MB10809.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWtxYmdYcUFWZ0FGVUIxbFZiMnNpZUJHbjdwQ1gzakJWTVZvc0g5NUZSVUxj?=
 =?utf-8?B?Rzd3OXl3T081Y1E4d2Nmc0pkSjcyelgwWEp1Y2hhVHFEWFJYMjI1UEo2VkR2?=
 =?utf-8?B?K1dzRG1ISWd4ejlYckUwbzE0TGZwMDliQkc2cTIyU0tuU1M2OURNcmdxYTJr?=
 =?utf-8?B?THZPSU1CYjZHS21NNU1Zd2dhVG5WV2w5MDV6VFBPaE9ldDBMaURyTFowSURz?=
 =?utf-8?B?YkFjMTByS0VTWTBCR0U2bUo5ZWd6VFV3bUplVHBMRWpmOE5rSU1KV0xLYytB?=
 =?utf-8?B?a3orMmtxcC9FUFQxd2Nab0FsZ1YzOGorUjUrM2JIRENrZEZzUm9QWDljMzRY?=
 =?utf-8?B?ZmlCRnAreVRqODlTeENxekZIYWFUOWYwenE5U2paR0g2MjZMb2lRNHhMNGhR?=
 =?utf-8?B?bjR2bUlVdTg0djZ5UlJoWkRCd0tFQ1BXTmRCY0tYQTV1Syt1Z3JDdE40OWNL?=
 =?utf-8?B?bkNjWjBPdUVjbFNmQW14Vmd0MGFWZ1F3RWhVWHJFUnpEZ0ZUdTFQcElJaG5O?=
 =?utf-8?B?Y2pKckM5SXN6NHFqcDJzMC9PbXphVkpQNmFSMXJaWDBlT2tPWkM5VXBVS2Qw?=
 =?utf-8?B?WmNoVDZWZ21QZTQ1UnRNdVBlWWJycWVhUE1OQzJ6VmJ3R21uYXc4Vml3QXQy?=
 =?utf-8?B?S2wxZVRuT1Y1YzZwc0NSNGczTG4vdy93a3JoN21Cd2lEZGd6Y01UVy96WWxQ?=
 =?utf-8?B?cHV5V0hBb2s3a1lHMC9CK2xSbEQ2QkJ2Nm8xRzhVZVRrRFdUUk1SNk12M0NG?=
 =?utf-8?B?NXNpMkVsLzBvTTVFUHo2TFNPeGpmN0JUTXVxUURjSXcwaFFteUJ0TnJIakdX?=
 =?utf-8?B?Z1cvVU9nWGFlWE9RbEV6bTZncjNWV251cGhONUV5SVFBOE5CbEpFMW1Gb0RC?=
 =?utf-8?B?Qml0TEFhSTBiRlNCb0xkQm9jamVXZFp0dkV2VjBUNFFTbDg4b1V2dGFxREt3?=
 =?utf-8?B?OTZkaXlZRkdKc2huQ053OVRSMEVya2ZCUXgwUThmTzNLRTJ5UFRhRC8rN0FU?=
 =?utf-8?B?cnVJbnpURWdBMHY0UGg5L3FTQ1BHZDdlQVFUdEZoVWFnVEQwRGo0V3dOUDhL?=
 =?utf-8?B?QWM0QUo0Wkc0QnBSbEQyUGw2UlhYTVlnSnJLRlJaR0pwKzlHUGdaRG51Mnly?=
 =?utf-8?B?am5EbkxFenBHOTlZUGVsNDRQdjQrdHo5UjNvaCtpcWoyVHQwQ3VrYS9CczFX?=
 =?utf-8?B?Qm8wVmwxdzBVbzdqNlBpQmxwWHhtTElFNlQ1TlRxeEJmZndvSGFIclVDL2Zs?=
 =?utf-8?B?K2JRdHNQRGpQK2x1OVRpcXVERjZFdEQ5aEVoYksySnBWaVBvYmVob3NWbFk2?=
 =?utf-8?B?bGx2U3U5MnV2QWx2MERQRW5oZDgyZ2RBSC9FNVlmeEV5cWt1K0RLa3MvVmoy?=
 =?utf-8?B?QWF4TGdwS21jcml2Z1BsVWlzTGlHMmVKQm1FTFA2ZXFCTUNuTjh6UHI5Ky9t?=
 =?utf-8?B?RlRSVVpmYXlTVnQ1aHNoTHp0SVdSVDdSSWhjT2ZXeFZmZEx5TDVnQVVacDFu?=
 =?utf-8?B?ZXFIdThSRS9rOVVuUFhZbVQ0NUhRTkY5VmZybDhPaGprYjZ3RWErM05BR2Ri?=
 =?utf-8?B?aUwwcU45SjZKblI1VjU1eUZieGR3LzlnUnNzVTFPd1NnalJPKzRwSWcvWkth?=
 =?utf-8?B?aUZLZlRGNFFTWEhZcUEzYjlMcFptbmRzRGRtMVFwYWV4Uzlua2VaOTgyTUxp?=
 =?utf-8?B?bllBSWJlblBJUTAxeEM4UW5PaU9PTXhkNnEzVGlWL2ljSTg0QWF0aUs1alJq?=
 =?utf-8?B?NlhkbEh6ZGtFNEZPUDQzVDI1ME43dGYzb3ZxVEttTmNpM0YvTmsvc082Ym5Z?=
 =?utf-8?B?QTNiTnVVMXdqb0VEeVkzV2M2SEtoZzk0RXZpTFRjTVg0K1RzRDFZWWk0Rkdm?=
 =?utf-8?B?SUpKTmE1akwyVjExdWJUWFB1SE1zWUtibmt0YzVnSzBSVHVDWEZadC82dS9l?=
 =?utf-8?B?YUdtd1Rkakc0MTFvUWppNnl3YnZZaDN6dmVBRm9qejdMMkwrQWRqQlQ1bTVC?=
 =?utf-8?B?RnAzb3FObjgzanVpSVRQczJGdlpOVVVxcHhUZVpEclRUOTJXSFh2LzNSenZT?=
 =?utf-8?B?cFlFK3lLSkZvUkxzdmtiaWFpYk5VK2ZKYUxYY3U5ZGtUam1xaytvZFdVaUR3?=
 =?utf-8?B?Y1ZGOUYvS3pMeXUwZ1pHQUZETVppZHdzTVAzYlV6Y0JrYjZtNjArMExGNlRP?=
 =?utf-8?B?SG9mOVptdG5jVktCeU10c0V5QjNlczVueGR4dGpNbVhkQk5tSElPMTlWNHF1?=
 =?utf-8?B?eGE1L0dJRWlIcVNZRFVXTHNQWmlDMm8veEVrc2U4d3BiZEVNTTNHaDlWbU1i?=
 =?utf-8?B?dTh1a3FBNnVhY2wwYmZ3N0Q3M3BMdU51SnJWREhsUGttTEdFR0JSUXozUGNX?=
 =?utf-8?Q?c/qOO5MNq/LXNNoI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR06MB10809.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40630df8-e3ea-4b87-bc73-08de478777f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 09:40:29.2097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /T8netqvQbhUuD1uAi+DzeVe96CuHxhbtNgjRIDUbqZp480CL0QC1TY3cD/9s4H2b8qZ20AvEj8VpzuY+zpX3hnSN0eJHXJFQboOdlruW564C18VUUkPyfm/1VVYJ4FE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB8508

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDI5LCAyMDI1
IDg6NDcgUE0NCj4gVG86IExJIFFpbmd3dSA8UWluZy13dS5MaUBsZWljYS1nZW9zeXN0ZW1zLmNv
bS5jbj47IHNyZUBrZXJuZWwub3JnOw0KPiByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVs
Lm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBDYzogR0VPLUNISEVSLWJzcC1kZXZlbG9wbWVudA0KPiA8YnNwLWRldmVsb3BtZW50Lmdl
b0BsZWljYS1nZW9zeXN0ZW1zLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMSAyLzNdIGR0
LWJpbmRpbmdzOiBwb3dlcjogc2JzLWJhdHRlcnk6IGFkZCBwb2xsaW5nIGludGVydmFsDQo+IHBy
b3BlcnR5DQo+IA0KPiBUaGlzIGVtYWlsIGlzIG5vdCBmcm9tIEhleGFnb27igJlzIE9mZmljZSAz
NjUgaW5zdGFuY2UuIFBsZWFzZSBiZSBjYXJlZnVsIHdoaWxlDQo+IGNsaWNraW5nIGxpbmtzLCBv
cGVuaW5nIGF0dGFjaG1lbnRzLCBvciByZXBseWluZyB0byB0aGlzIGVtYWlsLg0KPiANCj4gDQo+
IE9uIDI5LzEyLzIwMjUgMTA6NTAsIExJIFFpbmd3dSB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kg
PGtyemtAa2VybmVsLm9yZz4NCj4gPj4gU2VudDogTW9uZGF5LCBEZWNlbWJlciAyOSwgMjAyNSA1
OjE2IFBNDQo+ID4+IFRvOiBMSSBRaW5nd3UgPFFpbmctd3UuTGlAbGVpY2EtZ2Vvc3lzdGVtcy5j
b20uY24+OyBzcmVAa2VybmVsLm9yZzsNCj4gPj4gcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0QGtl
cm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+ID4+IGxpbnV4LXBtQHZnZXIua2VybmVs
Lm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gPj4gQ2M6IEdFTy1DSEhFUi1ic3AtZGV2ZWxvcG1lbnQNCj4gPj4gPGJz
cC1kZXZlbG9wbWVudC5nZW9AbGVpY2EtZ2Vvc3lzdGVtcy5jb20+DQo+ID4+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggVjEgMi8zXSBkdC1iaW5kaW5nczogcG93ZXI6IHNicy1iYXR0ZXJ5OiBhZGQNCj4g
Pj4gcG9sbGluZyBpbnRlcnZhbCBwcm9wZXJ0eQ0KPiA+Pg0KPiA+PiBUaGlzIGVtYWlsIGlzIG5v
dCBmcm9tIEhleGFnb27igJlzIE9mZmljZSAzNjUgaW5zdGFuY2UuIFBsZWFzZSBiZQ0KPiA+PiBj
YXJlZnVsIHdoaWxlIGNsaWNraW5nIGxpbmtzLCBvcGVuaW5nIGF0dGFjaG1lbnRzLCBvciByZXBs
eWluZyB0byB0aGlzIGVtYWlsLg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAyOS8xMi8yMDI1IDA5OjU2
LCBMSSBRaW5nd3Ugd3JvdGU6DQo+ID4+PiBBZGQgdGhlIG9wdGlvbmFsIHNicyxtb25pdG9yaW5n
LWludGVydmFsLW1zIHByb3BlcnR5IGZvcg0KPiA+Pj4gU0JTLWNvbXBsaWFudCBiYXR0ZXJpZXMg
dG8gY29uZmlndXJlIGEgcGVyaW9kaWMgcG9sbGluZyBpbnRlcnZhbCBvbg0KPiA+Pj4gc3lzdGVt
cyB3aXRob3V0IGludGVycnVwdCBzdXBwb3J0LiBUaGUgZHJpdmVyIHBlcmlvZGljYWxseSBjaGVj
a3MNCj4gPj4+IHRoZSBiYXR0ZXJ5IHN0YXR1cyBhbmQgbm90aWZpZXMgdXNlcnNwYWNlIG9mIGNo
YW5nZXMgd2hlbiB0aGlzDQo+ID4+PiBwcm9wZXJ0eSBpcyBzZXQsIGFuZCBpZ25vcmVzIGl0IHdo
ZW4gYSBHUElPIGludGVycnVwdCBpcyBhdmFpbGFibGUuDQo+ID4+Pg0KPiA+Pj4gVGhlIHByb3Bl
cnR5IGRlZmF1bHRzIHRvIDAgdG8gcHJlc2VydmUgZXhpc3RpbmcgYmVoYXZpb3VyLg0KPiA+Pj4N
Cj4gPj4+IFNpZ25lZC1vZmYtYnk6IExJIFFpbmd3dSA8UWluZy13dS5MaUBsZWljYS1nZW9zeXN0
ZW1zLmNvbS5jbj4NCj4gPj4+IC0tLQ0KPiA+Pj4gIC4uLi9iaW5kaW5ncy9wb3dlci9zdXBwbHkv
c2JzLHNicy1iYXR0ZXJ5LnlhbWwgICAgICAgICAgIHwgOQ0KPiArKysrKysrKysNCj4gPj4+ICAx
IGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdA0K
PiA+Pj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvc3VwcGx5L3Ni
cyxzYnMtYmF0dGVyeS55YW0NCj4gPj4+IGwNCj4gPj4+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3Bvd2VyL3N1cHBseS9zYnMsc2JzLWJhdHRlcnkueWFtDQo+ID4+PiBsIGlu
ZGV4IDkwYjlkM2Q4ODJhNC4uZmJkZDVkZDVkZGE4IDEwMDY0NA0KPiA+Pj4gLS0tDQo+ID4+PiBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9zdXBwbHkvc2JzLHNicy1i
YXR0ZXJ5LnlhbQ0KPiA+Pj4gbA0KPiA+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3Bvd2VyL3N1cHBseS9zYnMsc2JzLWJhdHRlcnkNCj4gPj4+ICsrKyAueQ0KPiA+
Pj4gKysrIGFtbA0KPiA+Pj4gQEAgLTU5LDYgKzU5LDE1IEBAIHByb3BlcnRpZXM6DQo+ID4+PiAg
ICAgICAgbWFzdGVyIGltcGxlbWVudGF0aW9uLg0KPiA+Pj4gICAgICB0eXBlOiBib29sZWFuDQo+
ID4+Pg0KPiA+Pj4gKyAgc2JzLG1vbml0b3JpbmctaW50ZXJ2YWwtbXM6DQo+ID4+PiArICAgIGRl
c2NyaXB0aW9uOg0KPiA+Pj4gKyAgICAgIFBvbGxpbmcgaW50ZXJ2YWwgaW4gbWlsbGlzZWNvbmRz
IGZvciBiYXR0ZXJ5IHN0YXR1cyBtb25pdG9yaW5nIG9uDQo+ID4+PiArICAgICAgc3lzdGVtcyB3
aXRob3V0IGludGVycnVwdCBzdXBwb3J0LiBUaGUgZHJpdmVyIHBlcmlvZGljYWxseSBjaGVja3MN
Cj4gPj4+ICsgICAgICB0aGUgYmF0dGVyeSBzdGF0dXMgYW5kIG5vdGlmaWVzIHVzZXJzcGFjZSBv
ZiBjaGFuZ2VzLiBJZ25vcmVkIHdoZW4NCj4gPj4+ICsgICAgICBHUElPIGludGVycnVwdCBpcyBh
dmFpbGFibGUuDQo+ID4+DQo+ID4+DQo+ID4+IFlvdSBkZXNjcmliZWQgdGhlIGRlc2lyZWQgTGlu
dXggZmVhdHVyZSBvciBiZWhhdmlvciwgbm90IHRoZSBhY3R1YWwgaGFyZHdhcmUuDQo+ID4+IFRo
ZSBiaW5kaW5ncyBhcmUgYWJvdXQgdGhlIGxhdHRlciwgc28gaW5zdGVhZCB5b3UgbmVlZCB0byBy
ZXBocmFzZQ0KPiA+PiB0aGUgcHJvcGVydHkgYW5kIGl0cyBkZXNjcmlwdGlvbiB0byBtYXRjaCBh
Y3R1YWwgaGFyZHdhcmUNCj4gPj4gY2FwYWJpbGl0aWVzL2ZlYXR1cmVzL2NvbmZpZ3VyYXRpb24g
ZXRjLg0KPiA+Pg0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgcXVpY2sgZmVlZGJhY2shDQo+ID4g
SG93IGFib3V0IHRoaXM/DQo+ID4NCj4gPiAgIHNicyxtb25pdG9yaW5nLWludGVydmFsLW1zOg0K
PiA+ICAgICBkZXNjcmlwdGlvbjoNCj4gPiAgICAgICBQb2xsaW5nIGludGVydmFsIGluIG1pbGxp
c2Vjb25kcyBmb3IgYmF0dGVyeSBzdGF0dXMgbW9uaXRvcmluZy4NCj4gPiAgICAgICBJbnRlbmRl
ZCBmb3IgaGFyZHdhcmUgZGVzaWducyB3aGVyZSB0aGUgYmF0dGVyeSdzIGludGVycnVwdCBzaWdu
YWwNCj4gPiAgICAgICBpcyBub3QgY29ubmVjdGVkLCBuZWNlc3NpdGF0aW5nIHBlcmlvZGljIHN0
YXR1cyBjaGVja3MgdG8gZGV0ZWN0DQo+ID4gICAgICAgY2hhbmdlcy4NCj4gDQo+IA0KPiBOb3Ro
aW5nIGNoYW5nZWQuIEl0J3MgZXhhY3RseSB0aGUgc2FtZS4NCj4gDQo+IEV4cGxhaW4gbWUgaG93
ICJwb2xsaW5nIGludGVydmFsIiBieSBMaW51eCBkcml2ZXIgaXMgYSBoYXJkd2FyZSB2YWx1ZT8N
Cj4gV2hhdCB3YXMgbm90IGNsZWFyIGluIG15IGZlZWRiYWNrPw0KPiANCg0KVGhhbmsgeW91IGZv
ciB0aGUgZmVlZGJhY2suIEkgYXBvbG9naXplLCBidXQgSSBhbSBzdGlsbCBub3QgY2xlYXIgb24N
CnRoZSBjb3JyZWN0IGFwcHJvYWNoLg0KDQpJIHVuZGVyc3RhbmQgdGhhdCAicG9sbGluZyBpbnRl
cnZhbCIgaXMgc29mdHdhcmUgcG9saWN5IGFuZCBzaG91bGQgbm90DQpiZSBpbiBkZXZpY2UgdHJl
ZS4gSG93ZXZlciwgSSBhbSB1bnN1cmUgd2hldGhlcjoNCg0KMS4gSSBzaG91bGQgcmVwaHJhc2Ug
dGhlIHByb3BlcnR5IHRvIGRlc2NyaWJlIHRoZSBoYXJkd2FyZSBmYWN0IChlLmcuLA0KICAgImJh
dHRlcnkgYWxlcnQgc2lnbmFsIGlzIG5vdCB3aXJlZCIpLCBvcg0KMi4gSSBzaG91bGQgcmVtb3Zl
IHRoaXMgZnJvbSBkZXZpY2UgdHJlZSBlbnRpcmVseSBhbmQgdXNlIGEgbW9kdWxlDQogICBwYXJh
bWV0ZXIgaW5zdGVhZC4NCg0KUGxlYXNlIGNsYXJpZnkgd2hpY2ggZGlyZWN0aW9uIGlzIGFjY2Vw
dGFibGU/DQoNCkJlc3QgcmVnYXJkcywNClFpbmd3dQ0KDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6
eXN6dG9mDQo=

