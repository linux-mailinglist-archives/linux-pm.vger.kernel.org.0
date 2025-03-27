Return-Path: <linux-pm+bounces-24558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA9BA731A6
	for <lists+linux-pm@lfdr.de>; Thu, 27 Mar 2025 13:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE0E1898A4F
	for <lists+linux-pm@lfdr.de>; Thu, 27 Mar 2025 12:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2333B20E6F6;
	Thu, 27 Mar 2025 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="WTUYiAle"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010064.outbound.protection.outlook.com [52.101.228.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3201B960;
	Thu, 27 Mar 2025 12:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076982; cv=fail; b=BV+Mr2aqZ3W9OBa9TOPu/W6hHDD5HflijpSDblvKo7K3dsUsvS5VKf3fB+ZvGRO1M0Vb/AhtvK3plkyIVFAEEHATOD5ZTUH0qWRpbSnYtHCA31mw9IeVezIDJDw1IAYPYFifq/k2JJyZQq2aRFAe9iRlOXamfmtPpYotjx4BM6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076982; c=relaxed/simple;
	bh=S6IC1RVqNB8+JYRk6UfbWtQD4TW7iVwdtlUp82I6fQM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ShHRNL6X7FXxC12c5nyMXjnRAlrgMnRySvMeB+LLFk92ZoLloPRKTeNCqU/b1yf+X7XUKpK4GvbdtsYtLHmGa0PpiwFzHQvengswBpt0wtrciWwPXTfWg6urtd7qJA2F7OC5zutJMRv1QrkGQfT4qEXmQZwqgll43wPgHX7GEOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=WTUYiAle; arc=fail smtp.client-ip=52.101.228.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWve8/w7YCsOUsM/cjYqf5Ev7Cw8o5yEwSWSci4qqDkh6J+KwoIgoczIFFu0zmL4sUDch1CNnRmBCppIaCQy7M1ULXOGEpXldSblV0Nm4ukHR0OY1w0tvDp65h1yhdhI6+5AEYmEhsZpGQS9tYl7Pr2oj/JO4bc9WCtzQYfPnWsWnMaFd3gmtHgQwuEsrW0Dieb0swIXL4NBifTPedPweXV359iaoUujL0cDRZg5mRZEUWjtNpflnMPuk7ym0os+W9QLyGFNjpdljFKozdMoamsioAv7C/xUlMIStgLELMiIUZV0E9sw5V3aHKFv2/MLv5VONUu7fvQ4lgBtQX0CvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6IC1RVqNB8+JYRk6UfbWtQD4TW7iVwdtlUp82I6fQM=;
 b=doluisz8TOj8U/0q2GpoRdsJUp1AofR2xC6zaAYvYO+2Ww3PouYNTdAQ+BaFiy5BPbfZRgqH9xjIbN5sO1zIgLnpcY7zN4o3Ba+60y7XzZyaryJt9I24ksILXKlZv4LPTIBJ3U+nfBKxLtiWwYQsxLsPM6uxvwG4ZeWRCVNXE4crId6pQhkJVZ09QS9DlvZL0JfOUzcXgzHuQpuOpqEDM/gHtmVT6YKghomZn5GC/vv5PyBEXOpQ0fRNI/upViYMlQKEddu8Evg8OXFhElCXPP8EiJIR9o3Eu3haJgzvi2psFxOOjxxDshm7sICbMADsn9jVFvtGyylHgqLCOiiDKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6IC1RVqNB8+JYRk6UfbWtQD4TW7iVwdtlUp82I6fQM=;
 b=WTUYiAlezYODYqNHFMYrNqDuMXFzr7AkUuv3cXp8hnnaYyHMYwp4yKVp9drbNF0Gl59ruST5fWLSY5cPtElxroZdiJsr4BSMuF88bdzPYKtL31BXIBv311L+uqFu2DlqOyW04i8dSn1OnjKhQ1Q4aZXDFdB0cQzlwKOsjzsVSYU=
Received: from OSAPR01MB2772.jpnprd01.prod.outlook.com (2603:1096:604:4::9) by
 OSYPR01MB5464.jpnprd01.prod.outlook.com (2603:1096:604:83::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.27; Thu, 27 Mar 2025 12:02:56 +0000
Received: from OSAPR01MB2772.jpnprd01.prod.outlook.com
 ([fe80::7280:12fa:872f:e753]) by OSAPR01MB2772.jpnprd01.prod.outlook.com
 ([fe80::7280:12fa:872f:e753%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 12:02:56 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"john.madieu@gmail.com" <john.madieu@gmail.com>, "rui.zhang@intel.com"
	<rui.zhang@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "sboyd@kernel.org" <sboyd@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>
Subject: RE: [PATCH v3 1/6] soc: renesas: rz-sysc: add syscon/regmap support
Thread-Topic: [PATCH v3 1/6] soc: renesas: rz-sysc: add syscon/regmap support
Thread-Index: AQHblYIGivVFYFKgUECiS3DWld6hrrN3cxkAgA9/YWA=
Date: Thu, 27 Mar 2025 12:02:56 +0000
Message-ID:
 <OSAPR01MB2772364A3736EC6C737634F2FFA12@OSAPR01MB2772.jpnprd01.prod.outlook.com>
References: <20250315081225.92118-1-john.madieu.xa@bp.renesas.com>
 <20250315081225.92118-2-john.madieu.xa@bp.renesas.com>
 <CAMuHMdXWGLUzJFKdDR3hLf0iOoKzb15fNQmvzZZQq-a8e6cxfQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXWGLUzJFKdDR3hLf0iOoKzb15fNQmvzZZQq-a8e6cxfQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB2772:EE_|OSYPR01MB5464:EE_
x-ms-office365-filtering-correlation-id: 2660a8c8-842f-46d2-30ef-08dd6d274f98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V0xUemtkRmQvUFIrYTF0WFlaWUVZOTUwVXNab0l0WEZKT1o4c2tpR2x1UitI?=
 =?utf-8?B?VTVYVmNUcEpiOXdMc0RRSERSZmQ2UitEaUFyQzVOLzdFSHpMOWpuMkJ0SkU4?=
 =?utf-8?B?TVZibENkRWtXL0VzekV3YXJWc3ZqcXJVak9VY1hPOEpYQ1VLSGl4U0YyR0k4?=
 =?utf-8?B?Y2xtcC9jdEpSQys1MGxBQXYxMWVEdXhIVElzNExyWnR5SGRzd29JblJ5amNz?=
 =?utf-8?B?Uk5JWTRRRVZnV3MwTGZTMERWVXVsL29KYmRGMFQzYnBTbjdzSnRWVEZEZ1lJ?=
 =?utf-8?B?eHpoNklWQWxvbFdmeVNIbko4MGJSU0tUdnB3NTdkODI5Njg2Z2dEekRodk1t?=
 =?utf-8?B?UHdMRmNObXNIZVVaVWxXUkhGWlVyQmgxeldXaGRlNUphajBDd2NFQlJLaFFp?=
 =?utf-8?B?cDZ6dC9YbmRsTFlBdGR0NTJ5VktMbE5zOU5ac2swU2s0RCtwNktmU3RRYSts?=
 =?utf-8?B?SmgzNjdEa0R5bUNGKzJhRFRMeHFoU3BlV3doMFRNamljVUxyNGpqRDFSSHoy?=
 =?utf-8?B?VVhRZmNCRDFmYUZoS256K3BFbWdueUNpZ2pETXFaS053ekx0V01vWG1sOGV0?=
 =?utf-8?B?Zlo1Qlp3U3NaSmxKU1dzejlOVFRxWnlhRzZ2ejNXN2krS2VEYmZnbXhTazNj?=
 =?utf-8?B?czZUdDRrUVBNR0tpNGkwYUloYU1ESmI5SlVBUklqR3hCOHk2WUt0R0lOTmhu?=
 =?utf-8?B?RHEwWlRjOHdOSmNucHJNakpSc0ZGUGg3eGJJazQ5MFpZTHRyYTYvN1gyRitE?=
 =?utf-8?B?R2NvYW5WSm1TZ3hEWEtkck1HcnR3SWJ1Y0swdlN3WExwOTNhMDJGSFZWaXlQ?=
 =?utf-8?B?bFZqMlNvVEdTa085RTNZK0J3ZVdnQXdxRFR1NzB6NTlvMVRmT3kwY09jeHB3?=
 =?utf-8?B?cUptaEcwMFJoRnVQZm9ZWWlwb3NKZ2lhRlZleHNkRURsUFJJMC9nS0kzdUR0?=
 =?utf-8?B?OUJoK1VPUklZMXBaYi9XUDRSMGE1NHk5cUQ3RStTaGdsZno0QW1rNDh1WTdQ?=
 =?utf-8?B?d2tRYUVjUjJDNlVtc29hVFlzUlFld3NodkU5cjR0M2R0S01adkR2Y2V5OFZs?=
 =?utf-8?B?OVkxQUhQYzd5MGt2UnRvZ0VrSlBiYklkaXc0dys1NjRJbGRpMEtRZDZuTkV1?=
 =?utf-8?B?Yk1wUHFGeGdPV1lSY0F5cERRZjg5c2xaQjFhK2JjcVlmY3hSM1pRaW8yRjZR?=
 =?utf-8?B?QXBkZW0rT1FKQ3JvNHdpMG5PVlRENDFTL2FGYWFyK2lmU3JGQ1Vqc1NEcjlh?=
 =?utf-8?B?RmQ1NjFsUWxPcXU2TGpwejZPY2RyUHkrQzhGalFka2UydHZEVDVZNjU1c2JR?=
 =?utf-8?B?aHpFeDh0UmthTlZqMThmaVhmcFZEYjRjZHFOTTJ0cEcyalVkWHFOcGZjSzdE?=
 =?utf-8?B?ak5hL0EyaElQVjVmT2lJTkVHTkloSzVySWtNOHpzZVJMMFhDWHJ2SkhQU2J0?=
 =?utf-8?B?cEJ1Y2YyQkNtQkRETDJ4UEJZcTd4WU15djI5NXQ1b3FNeHpmaVpnUGEyMTBQ?=
 =?utf-8?B?K1VZTFp0cXllNDdGOCtUc2tHSlZhWjFKSUcrdGxRQ3dGNUtCVEJuR1dsajNm?=
 =?utf-8?B?WWFONUJQdkVmMk9PSzBSajdQSHlSWm5DNTJnb2h6YXpITFNTdXFEV1E2eVV3?=
 =?utf-8?B?cnF6djRLZUJscjUyZHh3WWkzUGFaLzBHdjJBdGN3Qy9jQk5PM3lIT2lVMVB5?=
 =?utf-8?B?VCsyY0c2emowZWJva2tSMWJiMGRHT2s2VUVUSzhnUzZLZ0JEcFdEbkRuS084?=
 =?utf-8?B?YURnc1d6L2dsZ28vbDY0L1FNb25LZUc4a2tpWnJPR1FEdk5PVmxhSGdFSnI4?=
 =?utf-8?B?eEpkMW5ma3Byd2xtQTZPbmJTMlZWY0lVVjJOck1FakwzQm1LU3BDcFJVZ3Fn?=
 =?utf-8?B?VVFjWUNHZ3hmd1FxZEZXM3NpT2ExaVQ2RnNXVEpWSXVJYTlGWUM5c0t6elRB?=
 =?utf-8?Q?7VT8YWKKXYKpmCK0lPynP1TlGENT4Oox?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2772.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHpwL0s0UXhUQWlGRTZZWXA4cDRLWUdRdno4dnhXL3hMbU5uK1lLMWc2K2V1?=
 =?utf-8?B?Z0JiRlllMzlpd1R0dUR2Rlp4QlhrY3o0TmYyeHgwTzBGUXB3OXp0MTlrYzdI?=
 =?utf-8?B?WklxTytsSkdtcmNVYTQwZnI5ZnYxUUZDU21KNGY4dDVuU3VvSkU3RzN6bThU?=
 =?utf-8?B?RzFDaWo0Z3RiTThJS2lqM3ZtWmdIMWtDNzZ3OFkrcTl1RUEvZU4vT2NmQUVo?=
 =?utf-8?B?bEc4Z2RmMk91RGJzeG1wSk5EMG1KdmViZVU4c0pEQjRGM2ZSNndCMUpnWTNZ?=
 =?utf-8?B?MVYzQjFpS2s5TTNhTklkVTB1ZURpK2hnT0xnT0dmMDhnWm5MMk9oU1QzTFky?=
 =?utf-8?B?aUxrbnJlZEhVT2hXZWVwWCtKL0E4Y0RkaG81eldrV1o4SlRWMXA0WVdKTkJm?=
 =?utf-8?B?SFQ0VjR6U0ltMmxQY24zT1prZGkzdERTcWprSEJnaWVIWTRQMkZvazY0cWQ4?=
 =?utf-8?B?NGM3Y29JenNrdkZadDlzanVlNzJ2cGcwNHZjVmsyZmh3Yk5YcXFhUGFtaWRZ?=
 =?utf-8?B?RTd5YkEvMnhQSXEvOURTU3lidHhoTXF6QjVQbWVLNENuSG1WRmhIYXR0NmJV?=
 =?utf-8?B?RUpZVWxGSU5kOHRUQmoxTzJwT1NnWG5xVzNYWFpKTW5sYkVLQ2FGRmYxcWVk?=
 =?utf-8?B?MVFuUVFvcGJRRXhDM2o4cWdDWDJybWZvZlNCR05sTWZuTFRvSlNoWEl1L2tj?=
 =?utf-8?B?NTVnNFZXSWFTbitnQnpiWEFlU053OHQ3dkpXblZ0dnNjNk01YnVIcHhKRVRh?=
 =?utf-8?B?RFNkd0xkYkkzZDNjUE1zK1NkT0M5WTNCN0JCUndmZlpzMm9CZUJ1UElkRzZn?=
 =?utf-8?B?K2RBVXI4N1BadUZSMzBUVE5TVkl6NEhPL2d2b0dIQnN6d29oT3o4SkEweWsw?=
 =?utf-8?B?cXpzNXp5ak84djZISmlUYXFacTltdG9CTWxOVzduQkt0SFlGTjJ1dDlndHY1?=
 =?utf-8?B?NmlWUXlhdWVOUmN3aStzKzljcDVZQ2VraFlrZ1hydStDNVc0UXRpU09KMFQr?=
 =?utf-8?B?NFFwYU9kSk1JM09oWHVEczhTVXlReXZuR3ZsWTRuRXozdDkweVlXS3kwaHJz?=
 =?utf-8?B?OHJWSTBNMjZoSUtuTU4vVk1zNmc1UERtekYwQ3RTSDNRbmpFVmtNSzBpM0Qz?=
 =?utf-8?B?ZXdHdFRuWjhBSnFNblNiQUxMazUwcHowS25HbmlzMHM1N29pallaNldadXNP?=
 =?utf-8?B?R1hjeFgwMHlMSXRoRVZyWkdwcjhMTzRDakFZYzVQdUlZK1FHL1ErRFE5MjJ0?=
 =?utf-8?B?VlhSMUxmOTNkejJBZE8xMWZTWWd4TUFlOVpWdENkd0lBN200d3g3aWJjdTY2?=
 =?utf-8?B?aUpKaitVU1JVOHVwZVptQTYwakQ3SEVsTjR1WkI0eElMMVpiZ29UK01ZVDlp?=
 =?utf-8?B?SXF5aW1YVHdYMHE0bXhuQ2syVHpKR09acTQvMG4zb2FhVG1KcWVnQTdrcis4?=
 =?utf-8?B?cnFFazRoUzB3T3M1NW82R2JzMkQ5UGVLQmJhSmRMeGg5UGV4WU5XRnE1ZWZo?=
 =?utf-8?B?LzhJbVJlOG1OczV3TG1HZ1BTZEZrYzAxbjdiZFp4RUgzblR0MEZMVS9VUkdU?=
 =?utf-8?B?YTBqMFNnWkFjOTRkYyt0Vm5CL3BPcUw4YTdiVmZmdjNsTzJBNVd3QmlzZFk5?=
 =?utf-8?B?cXdnakE5NW9NakwrL3dNYTdicDM0dmYwTWdhTjdQZDRSVlpBSE13alJ0bmFx?=
 =?utf-8?B?U0lnVGM1S1kzeXE5RHBSL1BPeU9UOTlmNFplTEQxZjNXNFlzY0dmU0RiMENN?=
 =?utf-8?B?V1krREFHaGFQZWpqVGVvWVN3d3huMGZQTWF2SGxqdkVmSEFJeWNkclYzSFor?=
 =?utf-8?B?OElTQnRBSTB5UlBXclZybUhMa3k3OTlwc0tOSGlZTGI3SzNDaGFFQXpSM1hP?=
 =?utf-8?B?bmJ0Y0dEYVAyNTNYdFQyVjM0Nll1a0grOVJldHVhVEZ6Rmh0ejZXRXVicisr?=
 =?utf-8?B?QlY2Z0g3dS9rWnRUMG9Td3E2MkkzcXFPZ3VTblpOdkpIdVF6cEtvU2lYei9N?=
 =?utf-8?B?WU8yYjhIZE81V0Q1Vit4V1kxOXR4NlBtQ3liWXEzcHQ3cGdoT1praEs3Tmx3?=
 =?utf-8?B?ZXZoRlpQakJBWW9JS3I4YlZ1cEZ0MWNnd1N6TUFFU1ova0EwZENWMEZnWGQw?=
 =?utf-8?B?Nk1qeXY1U3h0WEp0NGdGWEdDQmZ0RVg4SW1GbkZCZS8vYWpkVnQ2KzlqSTdM?=
 =?utf-8?B?QUE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2772.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2660a8c8-842f-46d2-30ef-08dd6d274f98
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 12:02:56.2730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9BYA4sXVeRf+sc1WInpPMVfvi02WUvJJ/V1Id9DxkwrJY/4XZKv3kDyqubUUoiKN+M+6F20Ww8ybBdHiDoZW4g7IPZ263skOC95zcfDGOC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5464

SGkgR2VlcnQsDQoNClRoYW5rcyBvbmNlIG1vcmUgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0
QGxpbnV4LW02OGsub3JnPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDE3LCAyMDI1IDQ6MTMgUE0N
Cj4gVG86IEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBicC5yZW5lc2FzLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MyAxLzZdIHNvYzogcmVuZXNhczogcnotc3lzYzogYWRkIHN5c2Nv
bi9yZWdtYXANCj4gc3VwcG9ydA0KPiANCj4gT24gU2F0LCAxNSBNYXIgMjAyNSBhdCAwOToxMiwg
Sm9obiBNYWRpZXUgPGpvaG4ubWFkaWV1LnhhQGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToNCj4g
PiBUaGUgUlovRzNFIHN5c3RlbSBjb250cm9sbGVyIGhhcyB2YXJpb3VzIHJlZ2lzdGVycyB0aGF0
IGNvbnRyb2wgb3INCj4gPiByZXBvcnQgc29tZSBwcm9wZXJ0aWVzIHNwZWNpZmljIHRvIGluZGl2
aWR1YWwgSVBzLiBUaGUgcmVnbWFwIGlzDQo+ID4gcmVnaXN0ZXJlZCBhcyBhIHN5c2NvbiBkZXZp
Y2UgdG8gYWxsb3cgdGhlc2UgSVAgZHJpdmVycyB0byBhY2Nlc3MgdGhlDQo+ID4gcmVnaXN0ZXJz
IHRocm91Z2ggdGhlIHJlZ21hcCBBUEkuDQo+ID4NCj4gPiBBcyBvdGhlciBSWiBTb0NzIG1pZ2h0
IGhhdmUgY3VzdG9tIHJlYWQvd3JpdGUgY2FsbGJhY2tzIG9yDQo+ID4gbWF4LW9mZnNldHMsIGxl
dCdzIHJlZ2lzdGVyIGEgY3VzdG9tIHJlZ21hcCBjb25maWd1cmF0aW9uLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogSm9obiBNYWRpZXUgPGpvaG4ubWFkaWV1LnhhQGJwLnJlbmVzYXMuY29tPg0K
PiANCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9yZW5lc2FzL3J6LXN5c2MuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvc29jL3JlbmVzYXMvcnotc3lzYy5jDQo+ID4gQEAgLTYsOCArNiwxMCBAQA0KPiA+ICAg
Ki8NCj4gPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvaW8uaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4
L21mZC9zeXNjb24uaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4gICNpbmNsdWRl
IDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5o
Pg0KPiA+ICAjaW5jbHVkZSA8bGludXgvc3lzX3NvYy5oPg0KPiA+DQo+ID4gICNpbmNsdWRlICJy
ei1zeXNjLmgiDQo+ID4gQEAgLTgxLDYgKzgzLDE0IEBAIHN0YXRpYyBpbnQgcnpfc3lzY19zb2Nf
aW5pdChzdHJ1Y3Qgcnpfc3lzYyAqc3lzYywNCj4gY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAq
bWF0DQo+ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBzdHJ1
Y3QgcmVnbWFwX2NvbmZpZyByel9zeXNjX3JlZ21hcCA9IHsNCj4gDQo+IFdBUk5JTkc6IHN0cnVj
dCByZWdtYXBfY29uZmlnIHNob3VsZCBub3JtYWxseSBiZSBjb25zdA0KPiANCj4gQWJvcnRpbmcg
cmV2aWV3LCBuZXcgdmVyc2lvbiBoYXMgYmVlbiBwb3N0ZWQuLi4NCg0KU2luY2UgSSBzZW50IGEg
djQgd2hpbGUgeW91IHdlcmUgcmV2aWV3aW5nIHRoaXMgdjMsIEkndmUgcmVjZWl2ZWQNClJiIHRh
Z3Mgb24gdHdvIHBhdGNoZXMgZnJvbSBLcnp5c3p0b2Ygb24gdGhlIHY0Lg0KDQpJJ2xsIHRoZW4g
c2VuZCBhIHY1IHdoaWNoIHdvdWxkIGluY2x1ZGUgdGhpcyB3YXJuaW5nIGZpeCBhcyB3ZWxsIGFz
DQp0aGUgUmIgdGFncyBJJ3ZlIHJlY2VpdmVkLiBJIGhvcGUgdGhpcyBpcyBPayBmb3IgeW91Lg0K
DQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IEdlZXJ0DQo+IA0KDQpSZWdhcmRzLA0KSm9obg0K

