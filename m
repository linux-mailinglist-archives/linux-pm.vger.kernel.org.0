Return-Path: <linux-pm+bounces-13272-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49870966F59
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 07:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9CC81F23552
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 05:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AB913B285;
	Sat, 31 Aug 2024 05:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="PDojM8N8"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010037.outbound.protection.outlook.com [52.101.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70C91D12E8;
	Sat, 31 Aug 2024 05:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725081236; cv=fail; b=Nv8jMJLYNyg4Lig/a0SZn+1F0cIusPR760jZIJ+IKwemDL5tzv+C4KhbSOab6iu0VYOvwdxX/cDrpRl9lgWsWWR4IV1MKoTLMusP5y+Uvi1fxdWen3DoygED+DRXrh36WvpJ7CNCL3w518FACu1rs1T6WNwxiHp7qF1ocnlOv6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725081236; c=relaxed/simple;
	bh=R5AIjk5NF+2Lk+wTugrXLvm7rfnYCz4Og0ydGMtueeM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JHG0mYnCEZc3pQuYMYXAE1SgPpjwfnl+jwhbtFrQ2gR1dFU4/Ag+SoChFRkiX7eUQPrNmXvdofoFiboBAM3Muc4yLXJk0xBzuiiJh0rbPV2hTooNHQ9PIOShyyPuVdJBufyH3iMDjjrD3LobZPieI6p4RBYE0Pooj1li9UE05To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=PDojM8N8; arc=fail smtp.client-ip=52.101.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqXEx558x8P5koDIjRvmqcs1d3g7CF9F+TAXIPDuSO5W0ZPXSCzYtkCXlQ4esZY+a2jmY4cXprEZf7xqL4CqDUsZYtLXSBvgdFZVzXGBaITfmjXxMZy133POQqse3Bp7+cSynUJFgrJGC7ctxG9i3LNIspoPR33M7VNQj+YHFm05NbeQbVl5w7M36l/9zMiQESbniDJKyzxh+70ISCJp90aQdSZPonsYDznKFrOTX8R306O+nH1NU8LC9fn0/b6nVsLGgAgS+NvYRXs3E9VMlfH48845ZT2FMRaxswmDEeZiWrh/p0VQJsFMHAw25GJeGRAV/ok2o8RW9U0NHsvPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5AIjk5NF+2Lk+wTugrXLvm7rfnYCz4Og0ydGMtueeM=;
 b=pCeWyDtxz5LiG8ZKtecFh+14KlEsDj8hBGwbbM/x0sAc9LS7Qi/Zws7SZ2QNSVAcRX8KOgYcbYULmGLfT32XmqmY/Vo6eSh/s6Ca5mVKUhhgigV2Qs9Kd+HppQhhiUWniqpvfqnw4mM8aCUfasjUpDlkR073Gc9+LpCQ0vvntdh+nxOAAVgN0SZUHoOQ9NPkPEBcUjPxeB47GW9a8ui8OUgp7F9l5R5ypxebesoqWOREwaqEL1iH1D4DWoeiHGC28699y6h5Dvy4h3igBKaASMV8P7aaVdpQK7Kv1MYyep/NxaWsMoJDLuGw0gfHMBMtaGvJXopY6LwhCh/V8inf+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5AIjk5NF+2Lk+wTugrXLvm7rfnYCz4Og0ydGMtueeM=;
 b=PDojM8N855mqlKncbaFWMAbFWRT1+iBy6fBGbwsJBN9+cBKnEiXt/ofF8bxH1niaDAFl4vLMFAmGAtAWQ3swZloC7F+GaSu3kdLD+0jsgWnkb7MxBD+vSOl49YGKNhzzaaNIqHQ9d7BTzjWYgogsJlPs8mY5axGwW2JXSH/6shw=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB6674.jpnprd01.prod.outlook.com (2603:1096:604:10c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.21; Sat, 31 Aug
 2024 05:13:46 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7918.020; Sat, 31 Aug 2024
 05:13:39 +0000
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
Thread-Index: AQHa9KfrLpE8CCuWg0uaPyaAgZR3ArI+ZjUAgAEcCoCAAVgqEA==
Date: Sat, 31 Aug 2024 05:13:38 +0000
Message-ID:
 <TY3PR01MB1134652F9587CFA0ADE851CA486902@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFrS4Dhd7DZa2zz=oPro1TiTJFix0awzzzp8Qatm-8Z2Ug@mail.gmail.com>
 <99bef301-9f6c-4797-b47e-c83e56dfbda9@tuxon.dev>
In-Reply-To: <99bef301-9f6c-4797-b47e-c83e56dfbda9@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB6674:EE_
x-ms-office365-filtering-correlation-id: 3928cf53-0d7c-4972-d837-08dcc97bac69
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UGFyOWIydkd3aU9HR3d0SWlLdUE5M1VuSU9paFJSZEtOdmY1TE42S0cvTUR3?=
 =?utf-8?B?ZisxT3J0U08wRzIvS216M0txTksvbWRwNVdicWd5WkV3LzFzd1VRY3Vic2lL?=
 =?utf-8?B?UE9rLy96cWFINjd2RzlBTUY3Wkl4ZXpucHJpMDc2c1VEbldEM3hmKzk2Mjdq?=
 =?utf-8?B?NDc3SHg4N0VWZHBYWC9LZ1VZalFNU2VNSFNHalFYelM0ak5pei9DM29vSVJP?=
 =?utf-8?B?T1hFSGJpeHI5bzhodlRiK0lTbWlSUGN1Y25EelYrbXZ5OGhveHUvZlkwcHJp?=
 =?utf-8?B?aS80ZnFpREdwTzRhTVpRSWp1MEU4QjU4UWlEYXdydm12K2k0cTMzTjExRzl1?=
 =?utf-8?B?WkVaU09YQzlWNUovKzRvVnRIdUJ3TW8wTjBUT291TzZnM1ZFU1ZQTzZTL0or?=
 =?utf-8?B?RXFXVzRFM3RvRG1aTTBvTVBnT0g3azY1T2NXNmJ2cWRCZmVxcm12d2RDbGMx?=
 =?utf-8?B?Zk5PS3BZcE1pWlplN0liSUFpZDNOc3M0R0g2TGx6ZUFHZlBuZ2Vpa0J5dGxi?=
 =?utf-8?B?a21ST3d6K1k2SG9HaHpaaVQ2QXBETk1XaTBxY0Q0SitUczUzZ2xsbGRoVmNQ?=
 =?utf-8?B?Qy9oZk5UcXhYcWVMSWNRK3ZtWFdndUY0YzQ0dEpxdm84Z3VVbVlReTV2eDYr?=
 =?utf-8?B?ZXlQcHhoVHBOSFJ1bW1pTWFPL3R0N0dIZzFCZWxxbi9ERC9FcktlZzFwYk1k?=
 =?utf-8?B?cUVRVWxjMTFmRGRydmxaUVdUKzYxSi9SNEdCaURlNVZVcXhic1R5L2wzdE5N?=
 =?utf-8?B?L2V3OFpUaEZtUmh0UldHVE5IK3Mwbit5QjlEeVNNVi9kS21JWEt6dEl5VFZP?=
 =?utf-8?B?cUtYYWZucW1SaHFlUzZZMlN2R1hSdXUySTZiNGJIK0NaeEhFdldTVlJWWmh2?=
 =?utf-8?B?LzREWno2Y0xlSzJaUWJlalM0Yk04cVZTRkdTUXAxM0M3bXM3TWhxMWpNVVQr?=
 =?utf-8?B?YzdmQlJhR01Ma3h6Qlp3TGxlQU9yQkxKZzZ6b1VBV3dhMTlsUGVDVlpDT25u?=
 =?utf-8?B?MkFDdWQrYVpKRlZ3NVhKU3l4VklqUnlQR0pubmF3YldxZHVUMDBRakwyMXpQ?=
 =?utf-8?B?bjFPeC9UY1Q4eXI3OS9EaW53dCtBa01Zdlk5LzFzN0RCSDlKU1JNNFdoWU9I?=
 =?utf-8?B?TTV3ZE5XZC9TenpKVjlMQ0dJd0YzS3hWMW5HOThoYmFncDBLR3FzWkp1NWJT?=
 =?utf-8?B?aHgrdGtNUUg5c21Sd2NDMXNCRVBzazhxeXRuS1crbkFyREdTSFNCbWRhVDFa?=
 =?utf-8?B?bFBNZjM2VUNZN1NVckE1ekQ3TnZBdzQvNGxMSkl2OFBlNS85Y2N5QkhoZHNo?=
 =?utf-8?B?cE43aWdKWWpYeXBwbXVldFRzUXNVaG8xSitWU2FKb05LT1lwdE5xcG15VFVM?=
 =?utf-8?B?VEVDUW5rYisxZlA3OUxvMDVWUmxJbnoxUU1ZUmRqVTdWNTV2SVdPUVp0OHRK?=
 =?utf-8?B?dmtGQTJwTzY2VGJpQzdGZjRVdFdrVnR6RWNSK1gwTnNURHVPdnJ5VVlRZFZR?=
 =?utf-8?B?WEorSkNGR3hBc09wSkNaNU9wcXJsWGo0VjNXN1FpczJDa0Z0Sm44akJOOHBm?=
 =?utf-8?B?U08vb0k5Z2tFMGc5L3RQa0pPQS83aGVsUm1ENVZtRnhMbGVsS0Z2N0dOd2py?=
 =?utf-8?B?WjRmNTRVdlFxdjdmM2dDL0ZjV3BUT0VhMXpORlA3ZFhFeGJtMUJQQVVsbkV6?=
 =?utf-8?B?UXRWY3ZXS0hacC9xR2NrK255NWR0MXB2Z0o3T1BIUXFrbGR2SlYzbWkvLytZ?=
 =?utf-8?B?WGwxZDVQSHRTUFYzazljdHNINU9uci84K0xLNkljNUErczRjVER1bUF1RWNL?=
 =?utf-8?B?VGFSV3FFVTE5cWpGT1FZcnp0WHBSOVAydU9kMy91d2h5RDJWeUE4ZS82ank2?=
 =?utf-8?B?alVkWkYzSWN6d2JORklLaGhWOFhieHZqc1g1Z2xKdFY0aUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2FVL05ycWEvS2FhRUJqa1o2TkNjcG5FRVU4Z1B0ZTJOL29lUUlPT3Z6NkFv?=
 =?utf-8?B?VDRaZjEwWExob0Voa2t0QnFJMzBYNTUrcnl6N0t6L0hEWkpjWjloa1JiYzZq?=
 =?utf-8?B?U0ZBYWdET3VPL2h6SjZCSDZ6VHAvTnFCeG5oTW5pSU0rYTBMSTlzY1RwZzNm?=
 =?utf-8?B?RkkvdGdRVWFPMmgzdEcveG5vWit6elA2b0cxNkRQVzlkRDZKUHVMMlE1T3FB?=
 =?utf-8?B?OGVCMzhzSElRTVRSZU1NREVha3g1eUtBZEtzT2FoU0FYR2FoaFZmNy9zRFIx?=
 =?utf-8?B?TWhLS0VZcGxlNWRzdEtKaWNVdlVMRmx3d1VnMEJzNHkydkVJZUE5bG5DM1RN?=
 =?utf-8?B?RkRjTU5SVFQ0RlBVR2VvblhhOHlZZG82MGZVdUZJMTJXazR2VFM5NnNqTFhU?=
 =?utf-8?B?M0duL1plbzhvTkdYRFI0b2xHd1JSbDMyQmNBT3BSOExrcnMrQ2JXMTVjV2xF?=
 =?utf-8?B?bEZ4WjJua1hIdGR3elJyNHJuVE5VM2I0ZUFrRzlqWjZLYWJpTXlLWWpCL0xq?=
 =?utf-8?B?a055SHJkQ1NjVnc4Mldvc2xHaUxQLzF0TGFHcElNKy9FbkV0S3hhQTBWdHdo?=
 =?utf-8?B?VitRbWgxb01NV2QrV3FvK0cvWGhxVmFWYUVsRUpvZDhab2pUWmJYaGZTc0hz?=
 =?utf-8?B?ejZpbWNMQ0Yxd3I2TTBPeE0rZ3h0YmpFOG15Nm1GSi9ueFhnSUVhNDJTQ0p5?=
 =?utf-8?B?WStCdHBiRUVuRnZEWFdValc2QnFQZ3Q4RURWM0M3VzBBZlUwMHVSWW9PR2xw?=
 =?utf-8?B?NXYrWlp4S2ZwcHYzTEZDMVVjZUlyaUNTdThwMXBwMU9yK2xWcjB4Q1FiTVRM?=
 =?utf-8?B?c0wwZUpqZEQ3ZlJmbW5yK3RTaHY5RW9WNmZlZkFNemdDQnVEU3BGZm02TE9k?=
 =?utf-8?B?WXhQRWRubVptaG84ZmV0M3dUUXpyMFg4cEx5d3I1RUJaUzJObm9FbmRzM0ZG?=
 =?utf-8?B?MEtzOHR4dFdud0g5RDJua2NIMjhpalFFYlh3UDJYckU1RVFDYWNtZFNqbWFP?=
 =?utf-8?B?S2ZIcUhKVXN6L1FxQWhFV2RKQlhZZk1DdjBDYi9nL3dXYkQ2T08yeEJuMW1t?=
 =?utf-8?B?V3dhb1JVNy8xNkYvVFlHMENNa05zV3F0Y2RsSldBVkR3SGhTVVpIbk9vcDhE?=
 =?utf-8?B?bmZwa2ZzNktqNzdGcHlMd3BMMCtmVU9YSWVrZFd1QmJlS3JyNlJLc1g2ekRC?=
 =?utf-8?B?OGRZUURXc1hrOTFKQlJNWlRWaVBnYlE1RXUrNTJTd2dYNGQ5LzVmVFl0RHJP?=
 =?utf-8?B?S3hodXo5L0p4QXJySzNMdEd2RHNqcHBjSmpaSU56Qm1TRmdGcXdNbHhZQTVh?=
 =?utf-8?B?eDdQOTdDZ0pBY3lPL1lvWEY0ZE9URm5OOUQ0Z1F6WXJBSmpSK2pxUmxoTjdF?=
 =?utf-8?B?V3R0T3d2dnhrRlQrMDBsVUNvUVZhOHVpRjFnNGlQL2xFWjNDVEY5QmdCdVJO?=
 =?utf-8?B?K2ZQbWpuV0JTU0lDUkNvdlBMeVMvUEdCdGpSc3VYL2FMTnh1RDBZa1Y4UHJn?=
 =?utf-8?B?dCs2ZjVmRFVSN3lvOHpFNE5JVDhWREROTWJHOGluM0doaGNSUFRCcGs1S1pa?=
 =?utf-8?B?aC8vL3A5Wkp0eVo0Q0Q1aE1XRHBlUzkrMnBkRnV2dkFldXduMUd5VmVhcUhE?=
 =?utf-8?B?cksxY2lQZTZaaXJPM3hJRWwyZit3dWdKLzJkelJOcldVUzRTalVaWEZjY1gr?=
 =?utf-8?B?NHR4MUladnR3SURMSmF3dVhoMmRTRi8yVFptb3VJb01mMCtTakpiRUQrc2lq?=
 =?utf-8?B?Q1lydllWYWJRZjRFakVCVlBkYlBiTDdXamkwaEU1cEZtalVFcjRzUXdVUVlz?=
 =?utf-8?B?UmFwbWRkZTFKazM4U2Q4OXBjcFVPcEdPcTBYTjNLdkltYXNjUHJvMlM0TmVY?=
 =?utf-8?B?eEFEMmk1N050QWVoQkU1d1FkWVFiTnBRM0VLWWtWU1h6aXRDQldOWUJTRUY4?=
 =?utf-8?B?U2hWMkZLQ29pM0ZNY01oajhxdFhKWEN5K1N6TldBcGY1NG1CUngwSlkvYllU?=
 =?utf-8?B?MWpibVhOc3RxS3RodWUwdWh0amJWamZ0Qjk0RHJ0RDJRK2hHNWVmN0FoM0cw?=
 =?utf-8?B?V205Ym5nK25jcXc0S3pzK3YrK2RPdERUbEFlT21rbFVIUFo5YWlmZ3hOTTA3?=
 =?utf-8?B?QlpGMzA3eVUyWHNMY1o2bWs0UEFjU3RZdC9acGx0UDBteGNuN1h4Zk00SzVr?=
 =?utf-8?B?VFE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3928cf53-0d7c-4972-d837-08dcc97bac69
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2024 05:13:39.0164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WG4dz2F+O1cXHlgJmUP5/U29sq7esH7yx6PdC5SIXcA0pC151ol9RTQ+X++95n8qPqySTaQhsgLFC8nSG868CnK+ITxTNJXLdX85VIWY8W0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6674

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjbGF1
ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBGcmlkYXksIEF1
Z3VzdCAzMCwgMjAyNCA5OjIzIEFNDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDAvMTZdIEFkZCBp
bml0aWFsIFVTQiBzdXBwb3J0IGZvciB0aGUgUmVuZXNhcyBSWi9HM1MgU29DDQo+IA0KPiBIaSwg
VWxmLA0KPiANCj4gT24gMjkuMDguMjAyNCAxODoyNiwgVWxmIEhhbnNzb24gd3JvdGU6DQo+ID4g
T24gVGh1LCAyMiBBdWcgMjAyNCBhdCAxNzoyOCwgQ2xhdWRpdSA8Y2xhdWRpdS5iZXpuZWFAdHV4
b24uZGV2PiB3cm90ZToNCj4gPj4NCj4gPj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUu
YmV6bmVhLnVqQGJwLnJlbmVzYXMuY29tPg0KPiA+Pg0KPiA+PiBIaSwNCj4gPj4NCj4gPj4gU2Vy
aWVzIGFkZHMgaW5pdGlhbCBVU0Igc3VwcG9ydCBmb3IgdGhlIFJlbmVzYXMgUlovRzNTIFNvQy4N
Cj4gPj4NCj4gPj4gU2VyaWVzIGlzIHNwbGl0IGFzIGZvbGxvd3M6DQo+ID4+DQo+ID4+IC0gcGF0
Y2ggMDEvMTYgICAgICAgICAgIC0gYWRkIGNsb2NrIHJlc2V0IGFuZCBwb3dlciBkb21haW4gc3Vw
cG9ydCBmb3IgVVNCDQo+ID4+IC0gcGF0Y2ggMDItMDQvMTYgICAgICAgIC0gYWRkIHJlc2V0IGNv
bnRyb2wgc3VwcG9ydCBmb3IgYSBVU0Igc2lnbmFsDQo+ID4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdGhhdCBuZWVkIHRvIGJlIGNvbnRyb2xsZWQgYmVmb3JlL2FmdGVyDQo+ID4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdGhlIHBvd2VyIHRvIFVTQiBhcmVhIGlzIHR1cm5lZCBvbi9v
ZmYuDQo+ID4+DQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgUGhpbGlwcCwgVWxmLCBH
ZWVydCwgYWxsLA0KPiA+Pg0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIEkgZGV0YWls
ZWQgbXkgYXBwcm9hY2ggZm9yIHRoaXMgaW4gcGF0Y2gNCj4gPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAwNC8xNiwgcGxlYXNlIGhhdmUgYSBsb29rIGFuZCBsZXQgbWUga25vdw0KPiA+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHlvdXIgaW5wdXQuDQo+ID4NCj4gPiBJIGhhdmUgbG9v
a2VkIGJyaWVmbHkuIFlvdXIgc3VnZ2VzdGVkIGFwcHJvYWNoIG1heSB3b3JrLCBidXQgSSBoYXZl
IGENCj4gPiBmZXcgdGhvdWdodHMsIHNlZSBiZWxvdy4NCj4gPg0KPiA+IElmIEkgdW5kZXJzdGFu
ZCBjb3JyZWN0bHksIGl0IGlzIHRoZSBjb25zdW1lciBkcml2ZXIgZm9yIHRoZSBkZXZpY2UNCj4g
PiB0aGF0IGlzIGF0dGFjaGVkIHRvIHRoZSBVU0IgcG93ZXIgZG9tYWluIHRoYXQgYmVjb21lcyBy
ZXNwb25zaWJsZSBmb3INCj4gPiBhc3NlcnRpbmcvZGUtYXNzZXJ0aW5nIHRoaXMgbmV3IHNpZ25h
bC4gUmlnaHQ/DQo+IA0KPiBSaWdodCENCj4gDQo+ID4NCj4gPiBJbiB0aGlzIHJlZ2FyZCwgcGxl
YXNlIG5vdGUgdGhhdCB0aGUgY29uc3VtZXIgZHJpdmVyIGRvZXNuJ3QgcmVhbGx5DQo+ID4ga25v
dyB3aGVuIHRoZSBwb3dlciBkb21haW4gcmVhbGx5IGdldHMgcG93ZXJlZC1vbi9vZmYuIENhbGxp
bmcNCj4gPiBwbV9ydW50aW1lX2dldHxwdXQqKCkgaXMgZGVhbGluZyB3aXRoIHRoZSByZWZlcmVu
Y2UgY291bnRpbmcuIEZvcg0KPiA+IGV4YW1wbGUsIGEgY2FsbCB0byBwbV9ydW50aW1lX2dldCoo
KSBqdXN0IG1ha2VzIHN1cmUgdGhhdCB0aGUgUE0NCj4gPiBkb21haW4gZ2V0cy1vci1yZW1haW5z
IHBvd2VyZWQtb24uIENvdWxkIHRoaXMgYmUgYSBwcm9ibGVtIGZyb20gdGhlDQo+ID4gcmVzZXQt
c2lnbmFsIHBvaW50IG9mIHZpZXc/DQo+IA0KPiBJdCBzaG91bGQgYmUgc2FmZS4gRnJvbSB0aGUg
SFcgbWFudWFsIEkgdW5kZXJzdGFuZCB0aGUgaGFyZHdhcmUgYmxvY2sgaXMgc29tZXRoaW5nIGxp
a2UgdGhlIGZvbGxvd2luZzoNCj4gDQo+IA0KPiAgICAgICAgICAgICAgICAgICBVU0IgYXJlYQ0K
PiAgICAgICAgICArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4gICAgICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICB8DQo+ICAgICAgICAgIHwgUEhZIC0tLT5VU0IgY29udHJvbGxl
ciAgfA0KPiBTWVNDIC0tPiB8ICBeICAgICAgICAgICAgICAgICAgICAgIHwNCj4gICAgICAgICAg
fCAgfCAgICAgICAgICAgICAgICAgICAgICB8DQo+ICAgICAgICAgIHwgUEhZIHJlc2V0ICAgICAg
ICAgICAgICAgfA0KPiAgICAgICAgICArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCg0KSG93
IFVTQiBQV1JSRFkgc2lnbmFsIGlzIGNvbm5lY3RlZCB0byBVU0I/IA0KDQpVU0IgYmxvY2sgY29u
c2lzdHMgb2YgUEhZIGNvbnRyb2wsIFBIWSwgVVNCIEhPU1QgYW5kIFVTQiBPVEcgQ29udHJvbGxl
ciBJUHMuDQoNCklzIGl0IGNvbm5lY3RlZCB0byB0b3AgbGV2ZWwgYmxvY2sgb3IgY29ubmVjdGVk
IHRvIGVhY2ggSVAncyBmb3IgdHVybmluZyBvZmYgdGhlIFVTQiByZWdpb24gcG93ZXI/DQoNCj8g
T3IgSnVzdCBQSFkgKEhXIG1hbnVhbCBtZW50aW9ucyBmb3IgQVdPLCB0aGUgVVNCIFBXUlJEWSBz
aWduYWwtPlVTQiBQSFkgUFdSUkRZIHNpZ25hbCBjb250cm9sKT8gDQoNCklmIHRoZSBVU0JQV1JS
RFkgc2lnbmFsIGlzIGNvbm5lY3RlZCBhY3Jvc3MgbW9kdWxlcyB3aXRoIHRoaXMgcmVzZXQgc2ln
bmFsIGFwcHJvYWNoDQp0aGVuIHlvdSBtYXkgbmVlZCB0byB1cGRhdGUgYmluZGluZ3MgWzFdIHdp
dGggdGhhdCByZXNldCBzaWduYWwNCg0KWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcv
cHJvamVjdC9saW51eC1yZW5lc2FzLXNvYy9wYXRjaC8yMDI0MDgyMjE1MjgwMS42MDIzMTgtMTIt
Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20vDQogDQoNCkNoZWVycywNCkJpanUNCg0K
PiANCj4gV2hlcmU6DQo+IC0gU1lTQyBpcyB0aGUgc3lzdGVtIGNvbnRyb2xsZXIgdGhhdCBjb250
cm9scyB0aGUgbmV3IHNpZ25hbCBmb3Igd2hpY2gNCj4gICBJJ20gcmVxdWVzdGluZyBvcGluaW9u
cyBpbiB0aGlzIHNlcmllcw0KPiAtIFBIWSByZXNldDogaXMgdGhlIGJsb2NrIGNvbnRyb2xsaW5n
IHRoZSBQSFlzDQo+IC0gUEhZOiBpcyB0aGUgYmxvY2sgY29udHJvbGxpbmcgdGhlIFVTQiBQSFlz
DQo+IC0gVVNCIGNvbnRyb2xsZXI6IGlzIHRoZSBVU0IgY29udHJvbGxlcg0KPiANCj4gQ3VycmVu
dGx5LCBJIHBhc3NlZCB0aGUgU1lTQyBzaWduYWwgaGFuZGxpbmcgdG8gdGhlIFBIWSByZXNldCBk
cml2ZXI7IHcvbyBQSFkgcmVzZXQgdGhlIHJlc3Qgb2YgdGhlDQo+IFVTQiBsb2dpYyBjYW5ub3Qg
d29yayAobmVpdGhlciBQSFkgYmxvY2sgbm9yIFVTQiBjb250cm9sbGVyKS4NCj4gDQo+IEN1cnJl
bnRseSwgdGhlIFBIWSByZXNldCBkcml2ZXIgY2FsbCBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0
KCkgaW4gcHJvYmUgYW5kIHBtX3J1bnRpbWVfcHV0KCkgaW4NCj4gcmVtb3ZlLiBUaGUgc3RydWN0
IHJlc2V0X2NvbnRyb2xfb3BzOjp7YXNzZXJ0LCBkZWFzc2VydH0gb25seSBzZXQgc3BlY2lmaWMg
Yml0cyBpbiByZWdpc3RlcnMgKG5vDQo+IHBtX3J1bnRpbWUqIGNhbGxzKS4NCj4gDQo+IFRoZSBQ
SFkgZHJpdmVyIGlzIHRha2luZyBpdHMgUEhZIHJlc2V0IGluIHByb2JlIGFuZCByZWxlYXNlIGl0
IGluIHJlbW92ZSgpLg0KPiBXaXRoIHRoaXMgYXBwcm9hY2ggdGhlIG5ld2x5IGludHJvZHVjZWQg
U1lTQyBzaWduYWwgd2lsbCBiZSBkZS1hc3NlcnRlZC9hc3NlcnRlZCBvbmx5IGluIHRoZSBQSFkg
cmVzZXQNCj4gcHJvYmUvcmVtb3ZlIChlaXRoZXIgaWYgaXQgaXMgaGFuZGxlZCB0aG91Z2ggUE0g
ZG9tYWluIG9yIHJlc2V0IGNvbnRyb2wgc2lnbmFsKS4NCj4gDQo+IElmIHRoZSBTWVNDIHNpZ25h
bCB3b3VsZCBiZSBwYXNzZWQgdG8gYWxsIHRoZSBibG9ja3MgaW4gdGhlIFVTQiBhcmVhIChhbmQg
aXQgd291bGQgYmUgaGFuZGxlZCB0aG91Z2gNCj4gUE0gZG9tYWlucykgaXQgc2hvdWxkIGJlIG5v
IHByb2JsZW0gZWl0aGVyLCBBRkFJQ1QsIGJlY2F1c2Ugb2YgcmVmZXJlbmNlIGNvdW50aW5nIHRo
ZQ0KPiBwbV9ydW50aW1lX2dldHxwdXQqKCkgaXMgdGFraW5nIGNhcmUgb2YuIEFzIHRoZSBQSFkg
cmVzZXQgaXMgdGhlIHJvb3Qgbm9kZSB0aGUgaW4gdGhlIGRldmljZXMgbm9kZQ0KPiB0cmVlIGZv
ciBVU0IgdGhlIHJlZmVyZW5jZSBjb3VudGluZyBzaG91bGQgd29yaywgdG9vIChJIG1heSBtaXNz
IHNvbWV0aGluZyB0aG91Z2gsIHBsZWFzZSBjb3JyZWN0IG1lDQo+IGlmIEknbSB3cm9uZykuDQo+
IA0KPiBJZiB0aGUgU1lTQyBzaWduYWwgd291bGQgYmUgaGFuZGxlZCB0aG91Z2ggYSByZXNldCBj
b250cm9sIGRyaXZlciAoYXMgcHJvcG9zZWQgaW4gdGhpcyBzZXJpZXMpIGFuZCB3ZQ0KPiB3YW50
IHRvIHBhc3MgdGhpcyByZWZlcmVuY2UgdG8gYWxsIHRoZSBibG9ja3MgaW4gdGhlIFVTQiBhcmVh
IHRoZW4gd2UgY2FuIHJlcXVlc3QgdGhlIHJlc2V0IHNpZ25hbCBhcw0KPiBzaGFyZWQgYW5kLCBB
RkFJSywgdGhpcyBpcyBhbHNvIHJlZmVyZW5jZSBjb3VudGVkLiBUaGUgZGV2aWNlcyBub2RlIHRy
ZWUgc2hvdWxkIGhlbHAgd2l0aCB0aGUgb3JkZXIsDQo+IHRvbywgaWYgSSdtIG5vdCB3cm9uZy4N
Cj4gDQo+IFRoYW5rIHlvdSBmb3IgbG9va2luZyBhdCB0aGlzLA0KPiBDbGF1ZGl1IEJlem5lYQ0K
PiANCj4gPg0KPiA+IFsuLi5dDQo+ID4NCj4gPiBLaW5kIHJlZ2FyZHMNCj4gPiBVZmZlDQo=

