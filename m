Return-Path: <linux-pm+bounces-9525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DE390E1D1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 05:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99E98B20C83
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 03:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CBE50249;
	Wed, 19 Jun 2024 03:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pk1AOM1g"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DF680C;
	Wed, 19 Jun 2024 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718766387; cv=fail; b=fqHAouuOWGD6Nw4vP88+y5i9O3hRQ9MdT7qzY3FNpq6PRtI8Wc85Xb4ZYOiDHyMxhnL+bUzBbGYctbKc457Tn20Lql1JwK7oQLcgTu3BP2UMXf49mobg0LNZ4l6GUq8l1fTK8Vinf6fxRfKzckGNKgmOG1HxN2kUk5zVovec1Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718766387; c=relaxed/simple;
	bh=Ez6FXZk62bpZvCSFlh3dDAYSA/pQiC7ZMjxuT8s/7Uo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XNkWAadXXUYcoEKeZefCAAQqI2GxwYa6rcgBGmDyQoFvTW4texjFGz3cr/PIZfUXn1QJibXyF/9q+GBhUdwjjAFZagT6dzH4o6L5nH4OJ/28r3jx5mi9YqidsK1vXfUh6CiuoqL+ba0LFOYBEeBPajixyYoJ+DO5SWEKz0VWG8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pk1AOM1g; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBwxKlYTQ8hxrJDsRUex7KZcUgLMhxqprb8Xkv/3KBsUQe4q63/P8YaOChnINhxTMuMMLHRXHnaopzX+mrZrhCejZRbW8V/O6M4PWpFcEIethIe8pZY/mBQJbCnNq+nZePR/ER4IrhI0kcCMKlEjC/5z5KewsWUznmzy+kEEOtrPFXfosFXvqbTurjvwRMxb/mTBTmWDzShYsmkuL5Q536ANHAxD0mfonmaXz4cINdc6QdYVk10G4xGRn9GNP4JObeflZ24zitdp4BUXzA3YhukUtS9/M8JvPemY5SQdmKH5FohP8Hdscc6lnO7wxem6tAdUt321Da5ufzWNTbBq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez6FXZk62bpZvCSFlh3dDAYSA/pQiC7ZMjxuT8s/7Uo=;
 b=PEl31EYMK9gzAkDI4C2JoQQ8gCT1pxWj+Y0ieOEg4Qyhv1ZQlOarWjJMP1WYLJHUepohG6hmxkW2NMmK8wLD1XdXA/LsACgvCK3EV3edRgcriZzuk7ttFcyG+791Kmgzd6v6UtoIKd0U6EaV9iw6JC7xsDdF3aMQVXP1KYBRKnnpacXCQDihZR2Qrm7iIVqFoLYvlaID20Rb6nY6akaDRV/ME+kVrQ7M3t7ngUrNaqXZs5UWtfEOEe6eeJV+t/Fm3zqihniFVrYtaDvL7XUhvuGee4Gfi8l+N5/dwfCg8kZrFq9zqMW7ud6yCxyfbqyAdfqTyTwog6Ho9x3vYtnBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez6FXZk62bpZvCSFlh3dDAYSA/pQiC7ZMjxuT8s/7Uo=;
 b=Pk1AOM1gnPz8JZaDmdehykyJ+tfejZ9OQML6+L8cXvkGN4po9oaZ1iG3b9FxGJYueLm2hxW3KJAqa+AxkAbYUNtwKXCzz8rra90MCQQmtHP9Gbe6ZIGFgszD9Xu3o/NUiL6wZByWjitxokJzavTNQAwj8uUDb5gBluzYKXRnFk8=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CH3PR12MB8458.namprd12.prod.outlook.com (2603:10b6:610:155::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 03:06:22 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 03:06:22 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Huang, Ray"
	<Ray.Huang@amd.com>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 11/11] cpufreq: amd-pstate: enable shared memory type
 CPPC by default
Thread-Topic: [PATCH v4 11/11] cpufreq: amd-pstate: enable shared memory type
 CPPC by default
Thread-Index: AQHawISJ6jIxNrxA6EalA9hhaFP7nrHN6XUAgACAe2A=
Date: Wed, 19 Jun 2024 03:06:22 +0000
Message-ID:
 <CYYPR12MB8655FFD225C8958CC2D7E7B99CCF2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1718606975.git.perry.yuan@amd.com>
 <0700459b88b496963dd5914631eee753bcf0a560.1718606975.git.perry.yuan@amd.com>
 <4e84249b-2fa1-4d47-aa08-e8c429003714@amd.com>
In-Reply-To: <4e84249b-2fa1-4d47-aa08-e8c429003714@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=196bfd16-8db9-40b7-b786-849e1a0eedcf;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-19T03:05:06Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CH3PR12MB8458:EE_
x-ms-office365-filtering-correlation-id: 899ac847-2ff8-470e-5123-08dc900ccc98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|376011|1800799021|38070700015|921017;
x-microsoft-antispam-message-info:
 =?utf-8?B?dDcwaUFYd0tlOUVreEU2SE9QUkRYVTFsNWEvM214ak84SHczWmpkUmovOVc3?=
 =?utf-8?B?SDhNUDB3NlMxcmJBNlEzSWRVZUhLMGJFUEo1SVhQRGZFc2l5dUJVeENEQTRJ?=
 =?utf-8?B?VmhVSWllTk9hUEFwWDAveE10dUkwNlhyMUVLVnBwL3JIWmRUU25JTE5DeHhj?=
 =?utf-8?B?d1RRMEdWbFpZaHR6Um41U0FURGhCazNjN2RIU2kxUUlINDVBTlBrUHZMQUlq?=
 =?utf-8?B?QW5lcXdBYk1udFJJV0ZaQk5kbFlxWkMzTEJCcHFQbTlyYlh3SFhCaVlIelBw?=
 =?utf-8?B?TWYyanNmeTRMVjliMjJNWm8wSzIxWE9Sdy9CYVlKTDBiOXErY1ZmNGZKd0Y3?=
 =?utf-8?B?V3lxYU1vVXlwOWRhenkzUlp5T21zZVRnMHBDT3FJUDFCS1I5eTdzd09DL2sw?=
 =?utf-8?B?R1AyQk9UTHBrYTlTMkpWd1ZEV1BGWVBaSmkxRVRnaDE3S2x0OWFwamJQcFBR?=
 =?utf-8?B?MnRlYjl5NHphMUprMGllTXpUaTFiL2I3VytNZ1JwYWdqYVFqa0N1UGJRR0xK?=
 =?utf-8?B?YitUVmlQTUZ3dnJlYkJxa3c0VFdXaC9BT0FZcEN0YzBTR3NNNW9yOWg0Mjl3?=
 =?utf-8?B?ZkI4dnRxQ0dkUVFjMnBjVkxwN28wWW01UkwrLzRxRGI5TVluU3NDN2NCZXdj?=
 =?utf-8?B?bVpZNXVPYWhpUWllakpWYnVncW9wOTFSM1gzTWJEcGptR2pBQklsMUltMTlK?=
 =?utf-8?B?bXlFbTIvVnczd3grRFFhd2R3SlZYKzNnL1YzNDNqV050NUF1OHFQdmEwQ29n?=
 =?utf-8?B?ZGFFNTdkNEFHU0x0RitGUUJhdmk1ZnpvYm0zWHhkRGpJaklxOGs2R3ZKWkJx?=
 =?utf-8?B?Wi9jM3pEVTJOUHZVV0hudW9HU3BYTElZRVE1bVdKNlRjcnFZMkJWcDRuem5a?=
 =?utf-8?B?eHVyeDMvMGJIa1R1SGl5TGZtSkxFUEF3T2VDajdibStadlJuRmd6V01IajJi?=
 =?utf-8?B?NVdaeDRXalBxbnMvZ0pRVDlhWm1neTQzbVJZQWlENXB4ZEhSbGs1aWFOTnNi?=
 =?utf-8?B?V2lNUEVUY0tISVBERUhQWUxNczYwZkhkdVZPOUtQSm5Td1pKbU5wK3RtTjFV?=
 =?utf-8?B?WkRTRUNmVlcvNmlDa1huZWhzUUJvSUdYN1J6SHYxaTFXR1c0KzZoMHB3bWwz?=
 =?utf-8?B?bS8xZ0R6TDRTRGJKbFIvT2xvazVLUXZwdDI4SzgrYjhPS2Z2ejI2RVFtRmgv?=
 =?utf-8?B?aFUyOFFJeDdNVmdQSUZEUlBSK3M1dGhBdmZyTHAxNEZqVGhiZHZ0MXFVN3FS?=
 =?utf-8?B?K2gzZXVOOUFVZ3N4Y0I1MUJtTkdNUGcya3pwa3grSEwrckRDZ0d6Q2ZjZVZQ?=
 =?utf-8?B?b1hqYTRpcHlPSlRRajF0UHI2K2ZtTm12aG9HLzFCQTJmbHVob1JqMGprTU5t?=
 =?utf-8?B?bE42RC9lUC81RGUxTUNmUjhqSGhPbkNvdUUvNGovNWFQL2R1M3diWlZBTFZk?=
 =?utf-8?B?OGFtWGZnNUxpRU5ScnQ3NDAraEFwZWE3dS9zeDRWOTVKUDhxc09YazNiNGZS?=
 =?utf-8?B?eU1reE5oNVhOdkJ0V0s3aG92RE14SVBYSWxlWGN3ZUFxcnFLempWTG9jMkpV?=
 =?utf-8?B?R0dBQWpoTklGOWlyNitsUndpRkNLQVpTUExjcEpjS29pRzdMejc0SHBMNjJQ?=
 =?utf-8?B?T0Rlek1TdmtPOGFvNko2cE9hT0JERmxNYlZhWG16OGtHeUVwc3RFUU0xZFlC?=
 =?utf-8?B?UDU5NnlJVFU2ZnBib1BIdCsxbWcvQXhsTlNKNE5taFdFb0ZXbGFzZWEvRHND?=
 =?utf-8?B?RUFQZTVYR2g5SExyR0tpbnZmMnZ3TDNHVGtBUm5sK1lTUm51WVYvUllwVWNr?=
 =?utf-8?B?bDFrOG53SGV3MTV1Y0FEcU8xUjJ1QU4yRkNPY0hoQXE3UUY4d3RoS2diaTBT?=
 =?utf-8?Q?QZvkX4DWv/c5Z?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015)(921017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVBFcEVzWG9zRXVFTXJOanIxN1dBQUlHT2VTZFltWkNDNytWQnlWcjRHZms5?=
 =?utf-8?B?cFkyM1IwVVhLOUxiak5SdU1OUU05SzlHbkR1Z01xTHB3aGF0M0M3UXBhRFBq?=
 =?utf-8?B?N201RnQ2US90RnlWWjhhOUR3WkYvUitHY3RXVmZ1WGZyaUNzV1hvb0E0L2lK?=
 =?utf-8?B?cE1IRldyR042Tjk0VzBGZUlsVmdBSGhsUGFmVWZYRUt1UFFKWllYVWsxZ0dw?=
 =?utf-8?B?QmZPRDZmWFdJTENCREtpV2VKeXFWUlFQb0pHT3JLRkliNmRTSWRlWUtkbzdW?=
 =?utf-8?B?Tm5Dak9VZ3p3THNzM0hzTC9WYXZDTnlXaTRnQVI1ZUpjRnNTU1krT2kyQ1VP?=
 =?utf-8?B?cjh1N3oya2NZditJWk5HbXdicVBnUWtLYzNPS3gzZHFDdzdQMTRqUGpJL09h?=
 =?utf-8?B?akxXaFEwcGl5TVFVbHJ4VUUvd1hYcXNieis3ZllQaHZxMUwvNE1EOGpwbUgz?=
 =?utf-8?B?NzFIWlpOeWwyKzhPRXA0MzNHU0NEa3J5Zmp1Y2xMWmFEWTlXOEZJMjJJVTUy?=
 =?utf-8?B?ZmIvU3lXeE8xaUVsUEVjOFkwdFRjQXlPVWs5R3Baajk3NTRFekRPNUV1bERR?=
 =?utf-8?B?SzhLSHBibkw0RkY3WVlNRW9WMFEvb2YxZ2MrMVNPVmsyUGFoRXZtWWhIcFNW?=
 =?utf-8?B?QjVyMk5meklUbmo0Mi91ZXB2VWppMHdxTjAyaHRoQmJxT0RHTzFGdW11T004?=
 =?utf-8?B?bFUyZ0NxQStqVUlSWFFlcEV4QlhTQ2N5dkJqOG1ybTJkUmlSbUhrL1N4VGVq?=
 =?utf-8?B?bkltRHNNTWsvSGw4OWZMOEtwdXFYeVRxU2dFcEd5aDBBYmphZjlQUWM2VVdv?=
 =?utf-8?B?a2Q0c1A3ZTR2emNSZ1J1Nm5xY00rK29FU2ltaXVaNk5TOVhibGtqN3drcU5n?=
 =?utf-8?B?MEVrTkRleGhMTlV3TVFreUgzRy9CSThtRGc4S2xaTzNOdlZncjdLNU5EeGpm?=
 =?utf-8?B?VEFPazhGanhVVkVJdGpkeWJuMHJCR01MRzZmTlQ1bXF3V0pWaklUdzV5eXpP?=
 =?utf-8?B?blc0ZFdxUklrNVRKNmppcXlVU1gra1ZVUnZlVEViaWxYMHo5cUo2eFRXUVFl?=
 =?utf-8?B?Z29KeENmUTZJVWNpd1ovMXJzNWx4cjQxWmNBT25acWwwRS96WVFrL1ZwMG9I?=
 =?utf-8?B?Rlp4dnl6bTc4eCs5N2VicXU1TlFPblliMGhpVlVoSy9LQjdMWlI3MnU4bkhB?=
 =?utf-8?B?VWRXWXdNNlNFUzNpd1JsNWN2SWtCaGlEcFJsRDdpeng0U1dmVEJGZW9GalZp?=
 =?utf-8?B?d0pDMllVb0g5T0w4L055SSs5RmZlYmhyM3g2UTFzUVhtNFZWeVF5YXZsREdv?=
 =?utf-8?B?WjhzYzYzY0xOckFBS3pQdVhUSjhWU2M2eGNZaDA1KzBnRzh6eDN4ekJhM0Nj?=
 =?utf-8?B?L2ZuTGlGVjJkb2JKM3hWYmNta3ZZR1hMMm40eWJadElEdHBvZlNRZXhZTXpu?=
 =?utf-8?B?ZXVpQzVlVFdCR1ZEcUwrakZTN2dOMTl4WkxmSmRtNjNGQTd0MDU0d01hWXVh?=
 =?utf-8?B?Q3V0ZWU2d1pub1hPQmtMT2k0bUI2MHM3dGV4bmNWR1h4YytxWi9yeERNdVdI?=
 =?utf-8?B?MUtjZHRVQjhKYjU5SCtoUEtzYnNKT2xSYUNuY2FuV2JIWmRWRTZoeTFGWEJP?=
 =?utf-8?B?VVFFU2hhUjF4b1pleFBOZ0l2SWFQQXozQjAvSXpKaXRPb0ZnbS91dVIwMktJ?=
 =?utf-8?B?Y2k3TmxzRzh5Umw5NGliYktkdFluRWVCTmYxRGNmenlDT1pvWENNTUh3eFNk?=
 =?utf-8?B?QmhUMjVqRDNMeEc4TDQyak1KeHhsOXZ1NkZpUnRYalVCWFlwTEE5RDNTaXFZ?=
 =?utf-8?B?d0tKY3ZzSzQxdVBneTQxQzlhMnRyMXRXbXMvaXRMT29Jd01tbmJJbnVKSjhS?=
 =?utf-8?B?SzNROTlJS0w0TG9IMHRvTnNkSWVRRnJvNVh6NUlidnNoMDk1dmlOT3UwUUVC?=
 =?utf-8?B?aWJsM1Q3OG4wQ3Rpc3kyRTNyTjYyK2NxbzJGMkNFM3dPZmY5NWhyaHVBU2tk?=
 =?utf-8?B?WHQrc0NmM09HdTRHY2dBdlBHcWxHakI2ZUMzVkJRZklEU1pMNFNHNTcweGI3?=
 =?utf-8?B?SUJEaGVnTW9HWFVGTGJ2Q3JZUEYzRHNVRjF6Ynd3blMwdXlPTXBSZFI0ckdT?=
 =?utf-8?Q?FZn8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899ac847-2ff8-470e-5123-08dc900ccc98
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 03:06:22.5695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ewFDUwK6j0LtJzJiE21ZQho99XAjeeMGcB6WDavKcXOlNzK+DgVg7gPjVKDtflfYQLCsIiSiYqF5R9/rGaBp3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFy
aW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAx
OSwgMjAyNCAzOjI1IEFNDQo+IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsg
cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb207DQo+IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBI
dWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47IFNoZW5veSwNCj4gR2F1dGhhbSBSYW5qYWwg
PGdhdXRoYW0uc2hlbm95QGFtZC5jb20+OyBQZXRrb3YsIEJvcmlzbGF2DQo+IDxCb3Jpc2xhdi5Q
ZXRrb3ZAYW1kLmNvbT4NCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IEh1YW5nLCBTaGltbWVyDQo+IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBE
dSwgWGlhb2ppYW4gPFhpYW9qaWFuLkR1QGFtZC5jb20+OyBNZW5nLA0KPiBMaSAoSmFzc21pbmUp
IDxMaS5NZW5nQGFtZC5jb20+OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMTEvMTFdIGNw
dWZyZXE6IGFtZC1wc3RhdGU6IGVuYWJsZSBzaGFyZWQgbWVtb3J5DQo+IHR5cGUgQ1BQQyBieSBk
ZWZhdWx0DQo+DQo+IE9uIDYvMTcvMjAyNCAwMTo1OSwgUGVycnkgWXVhbiB3cm90ZToNCj4gPiBU
aGUgYW1kLXBzdGF0ZS1lcHAgZHJpdmVyIGhhcyBiZWVuIGltcGxlbWVudGVkIGFuZCByZXNvbHZl
cyB0aGUNCj4gPiBwZXJmb3JtYW5jZSBkcm9wIGlzc3VlIHNlZW4gaW4gcGFzc2l2ZSBtb2RlLiBV
c2VycyB3aG8gZW5hYmxlIHRoZQ0KPiA+IGFjdGl2ZSBtb2RlIGRyaXZlciB3aWxsIG5vdCBleHBl
cmllbmNlIGEgcGVyZm9ybWFuY2UgZHJvcCBjb21wYXJlZCB0bw0KPiA+IHRoZSBwYXNzaXZlIG1v
ZGUgZHJpdmVyLiBUaGVyZWZvcmUsIHRoZSBFUFAgZHJpdmVyIHNob3VsZCBiZSBsb2FkZWQgYnkN
Cj4gPiBkZWZhdWx0IGF0IHN5c3RlbSBib290Lg0KPg0KPiBJIHRoaW5rIHRoaXMgY29tbWl0IG1l
c3NhZ2Ugc2hvdWxkIHNwZWNpZmljYWxseSByZWZlcmVuY2UgdGhhdCBpdCdzIGJlaW5nDQo+IGVu
YWJsZWQgYnkgZGVmYXVsdCBvbiBzaGFyZWQgbWVtb3J5IGRlc2lnbnMgYXMgdGhhdCdzIHRoZSBu
ZXQgbmV3Lg0KPg0KPiBUaGUgY29kZSBjaGFuZ2UgbG9va3MgZ29vZCwgZ28gYWhlYWQgYW5kIGFk
ZA0KPg0KPiBSZXZpZXdlZC1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxv
QGFtZC5jb20+DQo+DQo+IG9uIHRoZSBuZXh0IHZlcnNpb24gYXMgbG9uZyBhcyB5b3UndmUgYWRk
ZWQgYSBzZW50ZW5jZSBhYm91dCBzaGFyZWQNCj4gbWVtb3J5IGRlc2lnbnMgdG8gY29tbWl0IG1l
c3NhZ2UuDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldywgd2lsbCBhZGQgdGhlIHNoYXJlZCBtZW1v
cnkgc3lzdGVtcyB3b3JkcyB0byBjb21taXQgbG9nIGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCj4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPHBlcnJ5Lnl1YW5AYW1kLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgfCAxMyArLS0tLS0t
LS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEyIGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMN
Cj4gPiBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgaW5kZXggYjQ4ZmQ2MGNiYzZkLi5l
Y2EyZjdkY2Y3Y2UgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiBAQCAtOTYsMTUg
Kzk2LDYgQEAgZW51bSBhbWRfY29yZV90eXBlIHsNCj4gPiAgICAgQ1BVX0NPUkVfVFlQRV9VTkRF
RklORUQgPSAyLA0KPiA+ICAgfTsNCj4gPg0KPiA+IC0vKg0KPiA+IC0gKiBUT0RPOiBXZSBuZWVk
IG1vcmUgdGltZSB0byBmaW5lIHR1bmUgcHJvY2Vzc29ycyB3aXRoIHNoYXJlZCBtZW1vcnkNCj4g
PiBzb2x1dGlvbg0KPiA+IC0gKiB3aXRoIGNvbW11bml0eSB0b2dldGhlci4NCj4gPiAtICoNCj4g
PiAtICogVGhlcmUgYXJlIHNvbWUgcGVyZm9ybWFuY2UgZHJvcHMgb24gdGhlIENQVSBiZW5jaG1h
cmtzIHdoaWNoDQo+ID4gcmVwb3J0cyBmcm9tDQo+ID4gLSAqIFN1c2UuIFdlIGFyZSBjby13b3Jr
aW5nIHdpdGggdGhlbSB0byBmaW5lIHR1bmUgdGhlIHNoYXJlZCBtZW1vcnkNCj4gPiBzb2x1dGlv
bi4gU28NCj4gPiAtICogd2UgZGlzYWJsZSBpdCBieSBkZWZhdWx0IHRvIGdvIGFjcGktY3B1ZnJl
cSBvbiB0aGVzZSBwcm9jZXNzb3JzDQo+ID4gYW5kIGFkZCBhDQo+ID4gLSAqIG1vZHVsZSBwYXJh
bWV0ZXIgdG8gYmUgYWJsZSB0byBlbmFibGUgaXQgbWFudWFsbHkgZm9yIGRlYnVnZ2luZy4NCj4g
PiAtICovDQo+ID4gICBzdGF0aWMgc3RydWN0IGNwdWZyZXFfZHJpdmVyICpjdXJyZW50X3BzdGF0
ZV9kcml2ZXI7DQo+ID4gICBzdGF0aWMgc3RydWN0IGNwdWZyZXFfZHJpdmVyIGFtZF9wc3RhdGVf
ZHJpdmVyOw0KPiA+ICAgc3RhdGljIHN0cnVjdCBjcHVmcmVxX2RyaXZlciBhbWRfcHN0YXRlX2Vw
cF9kcml2ZXI7IEBAIC0xODY3LDExDQo+ID4gKzE4NTgsOSBAQCBzdGF0aWMgaW50IF9faW5pdCBh
bWRfcHN0YXRlX2luaXQodm9pZCkNCj4gPiAgICAgICAgICAgICAvKiBEaXNhYmxlIG9uIHRoZSBm
b2xsb3dpbmcgY29uZmlncyBieSBkZWZhdWx0Og0KPiA+ICAgICAgICAgICAgICAqIDEuIFVuZGVm
aW5lZCBwbGF0Zm9ybXMNCj4gPiAgICAgICAgICAgICAgKiAyLiBTZXJ2ZXIgcGxhdGZvcm1zDQo+
ID4gLSAgICAgICAgICAgICogMy4gU2hhcmVkIG1lbW9yeSBkZXNpZ25zDQo+ID4gICAgICAgICAg
ICAgICovDQo+ID4gICAgICAgICAgICAgaWYgKGFtZF9wc3RhdGVfYWNwaV9wbV9wcm9maWxlX3Vu
ZGVmaW5lZCgpIHx8DQo+ID4gLSAgICAgICAgICAgICAgIGFtZF9wc3RhdGVfYWNwaV9wbV9wcm9m
aWxlX3NlcnZlcigpIHx8DQo+ID4gLSAgICAgICAgICAgICAgICFjcHVfZmVhdHVyZV9lbmFibGVk
KFg4Nl9GRUFUVVJFX0NQUEMpKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGFtZF9wc3RhdGVfYWNw
aV9wbV9wcm9maWxlX3NlcnZlcigpKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICBwcl9pbmZv
KCJkcml2ZXIgbG9hZCBpcyBkaXNhYmxlZCwgYm9vdCB3aXRoIHNwZWNpZmljDQo+IG1vZGUgdG8g
ZW5hYmxlIHRoaXNcbiIpOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7
DQo+ID4gICAgICAgICAgICAgfQ0KDQo=

