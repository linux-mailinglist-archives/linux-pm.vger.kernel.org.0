Return-Path: <linux-pm+bounces-7887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB2D8C7161
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 07:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10FEDB227A2
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 05:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26C619BA6;
	Thu, 16 May 2024 05:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B4+bTFuH"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F4610A23;
	Thu, 16 May 2024 05:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715837815; cv=fail; b=Pth33dti6awSEiMB53qc1LBgdk6vKBpbccORwwz8OlwS5NjUPcWf/tnaXARdjd9GqHNpieJJPBKYoedc+CmcodQPNEC/9+hLWXxLKbXQ4aw9p961mm+ZPCe48lBhKKdJxhPUJUOaFcYYdGbMZmW1Fo3wkNZr4MpdIhPsgRmlIMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715837815; c=relaxed/simple;
	bh=8595lH7O2ejW2IXvbzHngaK5BGESWadAcvji7k3mn9w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b43eWC9McCnB6s83E5reAtZzvpK2vNtqRGv+v7l7emuU8Dhqxpr/OG7wWiCzqNs87udvg7GjXo0UpIPDro6XiibwX/wXVJXPzPpvcBDwy6KTxk9xo/1tyOEA4jkRUftwqL99tGmU4jndemXsmJUFpfvt1L7uhge6DP6it4yYc70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B4+bTFuH; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjb8uaPfb8qShi9gyGIlFOCfaGwe3PZGFfxkRgraNILPCIxJiSK1DSdb2HniY42Mm+hktl1x1j86UOOvWmLgbAIlUmLJL6w/sPbP4nO79qi9Nf7Zcx5aDWpeujcf9SiZfn9uRbv4s6ECpt7Rv9JGaypHKIuOtKijgGXQXlrIGRmWVVfk4Oxs+c6j4tcH2sMThUxCJqlUg2586z5ksqhcbbhqSu0Wvh5WOleqtUfy5CfBowCrfnsUdpbMhUFjK7o2oHWLvxeAriFJpjSl3/VKCxcT1IqvfT6P0MtvtR12qUqFUxCecgYmX76GTUFnJkHBepj7YoA00ZLe38f+1QHU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qv8kJNBOkTNXc36uw4LQMg1u+Chi9TM+Hy0qRTotO6w=;
 b=X8XxAQZr+AcoB3yUAgERoN7Pcj/MhHHVSjER/Eyg/1ien98ynk329UNFT5VR5id4lWEh2MrFZVgy8vg1jpk0J40HzbXJxKuG26Nlchb/lDgVTycWc98sJh22zJhsi7xoOJmbm/o0CI18Hh0NksSRjzZsIBAlnMPy/J4OV0NEzOxrqC7Nb5kf8Q32eh5weeD4S1Xi1Df3PGZ2RVenhiZEE6rnAzNQPPShX4OikKR/KfyiPynnptmNxL2Rze72fmf44QtV5vYRWFo1koet7gntOW615d1YXQ52jjODihkLR+dqAGUaiRpypbQ2BcevcS7yItRzt/yxzRrHnuwlxZkvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qv8kJNBOkTNXc36uw4LQMg1u+Chi9TM+Hy0qRTotO6w=;
 b=B4+bTFuHE0+N9PP2xMvVrBR4zCdOz+SsN33dE6tDdlMS8V8NkAkV0Hi7dl+usSM3DoA/rSbm2fULMpDZoXQ1u2MXCUAY9KadoXR7tKOQ8u+WBQG2nzQIj7Zq3gp+XVC0R5LZ7O2d3sgazVe1p12Hkn5xjwwfmPL8JERyMuiRqmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB9125.namprd12.prod.outlook.com (2603:10b6:510:2f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 05:36:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 05:36:50 +0000
Message-ID: <9f948ed8-2948-45be-98e2-5909caae3add@amd.com>
Date: Thu, 16 May 2024 00:36:46 -0500
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW3YzXSBjcHVmcmVxOiBhbWQtcHN0YXRlOiBmaXgg?=
 =?UTF-8?Q?the_memory_to_free_after_epp_exist?=
To: Ma ZhiDa <zhida312@outlook.com>, "Yuan, Perry" <Perry.Yuan@amd.com>
Cc: Peng Ma <andypma@tencent.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "rafael@kernel.org" <rafael@kernel.org>
References: <PUZPR01MB51202786825AA6A93383B7AD92EC2@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
 <CYYPR12MB8655ABCB32C6B11C6B382E649CED2@CYYPR12MB8655.namprd12.prod.outlook.com>
 <PUZPR01MB51206570679D34B15182E2B292ED2@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <PUZPR01MB51206570679D34B15182E2B292ED2@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: b10fe3ae-3372-4f84-3cdb-08dc756a2f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1BQRllFeHlmc3Mxd296eE9Eb3dMOTdmUDBWdlV3dVl4WHNIRkYzMFV2Slc1?=
 =?utf-8?B?WGVpTHlpU1AwYVFyYWI1aGxhNzhiWWc1NGZXYmNVOXFVZ2x1NWxkbTU3anM2?=
 =?utf-8?B?T1RYU25mTVpKUklJSEpKL1pZWHJaMW82Ryt2SDcvRmdsZW9PZ0YreFcydU5N?=
 =?utf-8?B?azRNbmw1Y29PU1VHRXNzaVhKVUZ5VVlNeGVSMERxRys1Um43eS8xL2ZWTmxQ?=
 =?utf-8?B?Sk94UWxMYlRqcWEwYXUwdW0xNUtGRXhvU1JHRkN5VDAxQUhWUlNDS01EQTRk?=
 =?utf-8?B?MW8veFQvLzR5M1FTWStyL3lVUzNlZVd3L0RCYUdaK0IyNjdrNndDeXhXZ0p4?=
 =?utf-8?B?RHlGbzRqa0JCejBGVlduRGVoVGRYRXowVE85UXhJcVFVbm11L1k5cStmNzRy?=
 =?utf-8?B?VFBpQ1BLNVBjbE1ubGh0ZmtxYm5tSCtXenRhSU1idU9hY0ZYSE5ZTVQzdnM4?=
 =?utf-8?B?bE5CenM3bkpqOURMYWpFdW9iQlQ3QmJvbGdmeURTMVV2cU9jZmtkbU1GWmFh?=
 =?utf-8?B?WEFSaTd6SlhpZEtMejlvNndkSm4ydmRxT1ppajZ0MWduUVVwM3dmMkNVUzlF?=
 =?utf-8?B?MTFXWllHL2V0dnl6a1BXbFNLaXBCdWlaSDhZY3dZWlJKM2ZFNWIrT3JwMXdI?=
 =?utf-8?B?Q1N6YmJVaTFRUkwwSlhZZXI1THVjK3hpYzd6Rm1JY1dnT0RIdTljWFBRNGR6?=
 =?utf-8?B?RDlMbWVETEx6RlM4NTR5cGNyV2h2ODQxR2x2Qk5xczZsV0NoTHZLZUNWYXRu?=
 =?utf-8?B?NUp0WkFTRDNvRUJEVnRXZ2xRekJCeVdybFNrM0xIRXZoZTF2dm1JVVdydUtr?=
 =?utf-8?B?dVJQRm5SdWNwSERrSDJmZEVUdXlNNTdJbUF0OTZNK1BMalUvTDVLYlJ6SmI1?=
 =?utf-8?B?d25vaWRrOHhpbmJhUlJYVFJRQzB4ZVVqclNJTEJDd3RvalJrL21FaHliT25l?=
 =?utf-8?B?YnVnVzU2RUFJYkw2RGtldU5MaVlINmZqTVI2VlVGWEZEaU9MUFIrRFZkM2c5?=
 =?utf-8?B?TGxnTktObndIZFgwS3UyR3Ezcko1R3dVT2J1Z2gyd1kzalNDZVBtOEUyTmsy?=
 =?utf-8?B?aElGZGlnWDBsVGhsVGlEK3BQRTNnRmJROFNwRnpXbDEyaXhqcnpsSmZaaWJ0?=
 =?utf-8?B?cmkxL3hueW9SdmFRYk1UazdtaUxxMVJhTStOUHliUldJcnhqRThtT2R2Nk5Z?=
 =?utf-8?B?SVBwR3lIT3g2SEIzbkY1cFRZSzJMNEdYMVlBMGFQeC9RMXlnc1E4bGRSOXhN?=
 =?utf-8?B?OWR6SHFyczdsUHQwT295SHJFRlNlV0RLTXRuTnVrUGZlc2RrcVZ1eVNvV2k1?=
 =?utf-8?B?eVQrMHpTZmoyMi9DdUVOMTE0WlVzbXJSNnQ5S3pSUGY4SG9sZ0t3a0FUVkNC?=
 =?utf-8?B?YnZ6aTVWM3k5SUZJcVEyOTFBa3lRMGdhTWhjOHhDUFRsakkzaVhNbFNNMUNZ?=
 =?utf-8?B?V1lwR1VvMU9aWUVqQjlsQmJzS3VZcFVRRHA0N3N0QXlVUnVpVUhlS3lxMm9Z?=
 =?utf-8?B?aGdFR0ErbVliTUQ2N0xVeVFXTnExQnhTQmhrb2lPUUMwSGI1SWVQRFllMk9v?=
 =?utf-8?B?SUpyNWFFeDIwSytBRnlkbjY0bzRXcitIL05wOXRYQmdyUzkzTmE4SXA0MFZv?=
 =?utf-8?B?VlRtdzY1Tk96T3FxV3NEQ0s2dGNoYzVadE1HakRtQzRQWjlhQ2hubGh2NlQv?=
 =?utf-8?B?VjBxSU9kMVVPdHBSejMxdFRYT0VnT09TYTB3eWQwbUdJWG8rVDVWYm9BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEFEZWQ3ei9kdnFrNzdSK0NYT0t6anEwbk9XTFdMSGUvbUVQamdMdlkxemVW?=
 =?utf-8?B?WnV3TnBsckdLSXBuNkZsSHczd3lRY25PeWFrYjcySkJLK3RPT0xma21TaXl2?=
 =?utf-8?B?emVabUxxbEpFeUV1Z1J4Q0VSdUhCWkl2dUhxMVQ2djlXTU1qTnJsS3B4S1Ex?=
 =?utf-8?B?N1J3ZitOSjJyTnRRaDVSZ1ZGazBXb2VpTVZiMkc0ckxLUXgzSlI0UjR6NFR4?=
 =?utf-8?B?MzlhT0ptZ2VLdkpiZktPcG41WFA3ZitzMi8wUUFLeVpIckt3R0traHhIZzl4?=
 =?utf-8?B?bWtjc25SWXlzWmVFM2wrTkRVbzNManQzeC9jT3UvMytoQW8xdklVVjdmRWti?=
 =?utf-8?B?dTV0Yldkdnk4VUFGSmhyRCs5V3VoVWViTXN1bm1LeGhVblNmR1VXNmpaSVVm?=
 =?utf-8?B?UStJai9iQWl1Ulk2ekIwU3A0Mm1Nci91NDFIUTU0TndJVFdXVzdQa09sd1RO?=
 =?utf-8?B?WWxwSlpiVDFzSjNTaS9jZU1vRUp0SDJqK3gySWhXMEtHZmFuTG9WYW54MnRE?=
 =?utf-8?B?d1lQSmpVNjYvNGcwMHRPYkRCcnBva28vMXB5OVRSS1ZFQ1pHbmZjU2thcy9v?=
 =?utf-8?B?RENuNHNrTWUrNGNKTnhIVUhEeXN5YVFraGo1V2lPcHFGUGQxTXFQeUtWREQr?=
 =?utf-8?B?TkJ0NXlucWZjeW1BaGNwZFB6RkJIZVlmNUZKZ3RVNG5kZldWMGdURDg5MGd0?=
 =?utf-8?B?WWFsU1l0S3F5U0EyaTF5R3Q3LzgyS0Q4NlJyVXA0RnFXeHJwTFhDVm9PUmNV?=
 =?utf-8?B?NFZ6cVhaNDlCcHJ5Umxyd1V2dFlrMUdZQ2dtQU1IcmZ2dDhrQ3BNWHJvMEl3?=
 =?utf-8?B?UG5Xb1lVSGlMSE9ENzJWMnNwcFl4aytVZFk1UHdPNUxucHlWS3M0RnVPZEFF?=
 =?utf-8?B?b0dheHFjK1o1aVNnRXhiZ0ptVC9UWGJ2TVpKUkd5UHlyeXlGVnZtbSs1SWNi?=
 =?utf-8?B?U1JiUlEvTnprN1pWRHQzL25BWXNzdHBlSzBoWUY0T2RjdnNHU1Y3YVNUSFJ6?=
 =?utf-8?B?U05vNE1MSzQvUzV0bjdDVGs4d2hBaURQNmxiN0JYMDlNRno5aVlJcW9lcnpT?=
 =?utf-8?B?KzR2WkUxTEdUR0lPVnV3d2Vqb0ZzS3Vka3cwdFZadmtUNWt4UFpEbHM3YWYw?=
 =?utf-8?B?MFZDL0t4THVPRjZIMm5weUNKZ0wxKytocm0yS2ZyYUdGVTZDN3NoTkdkUndE?=
 =?utf-8?B?VG95Q1dYYTlBUVY4RkZqTTFzYVdlV2R1TUUxVlZ5NHp1TGNXTmZlRjNQVzJi?=
 =?utf-8?B?RERlcG8vYTV4dE1DNHR5eitwYWtWYW51QytSZ1EvK2RMU2M1bGlOWVYyb3Ur?=
 =?utf-8?B?SzVnL2Fja1lzZkhtRThqbE16aUtMdEFYakFHbWQ0d1h0eTZoRXFia1dURjdl?=
 =?utf-8?B?MitTNVVONldPZ21DbjlZMmsyQVhZT3B5WTFUbVFNOVBpbHV6UVVyYnhyc0N6?=
 =?utf-8?B?eElBQlNBSzdrVzJRTXo1V3RTR2pqSStPZzFjSko4dWZuM2piRFRGTUc4bzN4?=
 =?utf-8?B?aktHVnlNblhRR0dFQ3ZtMWlMRjBwaC9BTjBQRHlRVmFGTTc4ak9uam1BLzlu?=
 =?utf-8?B?dGVxV1hRMG16WHBzZzlGRHNWb3NwYXlhRkJ0dC9VSFU1alRCRVBlUXpHR1do?=
 =?utf-8?B?QlFkMVhNaW9iSDBJZmhZZWwwRjBzZm1DcEhLVy9TRFdxaGVZc3psbVl3cTNx?=
 =?utf-8?B?SXpacUR5QWR2OTVDdWFmSzBNVC9iaFVsRE9QSjNBMHBSRkxqaVR0Y0lNWjVG?=
 =?utf-8?B?SU5valJ5Z2s5dXhub1E3bGd2UDZGV2MyYjVSM2VRWERoRm9BRjR0Slg1NDlS?=
 =?utf-8?B?OFR1Nm1ucmRrMWo1OG5vcnc2OFoxanI3ZW1id0RQVkdsa3MxUmFiaHVlV0VV?=
 =?utf-8?B?WTZwVEdMZzVIQ1V0ejlCdWtkamFRdFFBS2VUK1RwNFRkZWZSb28wb2I4V2Fv?=
 =?utf-8?B?WjVjU2JlekoxcDQ0YlFYVDluT09hcHVwalVDMm1TSDZwNXRhdmRIVllEcTQr?=
 =?utf-8?B?Q1dhN3QrYUU2c2dhdjltejNtRW00UE5PYkxaM09nRmRLYVFNTUp6SlJhdlRK?=
 =?utf-8?B?ZE8yRWpHbHRTY1JmWk5JQjNFNW93eEh4K1FhMDhNQVVOamZ6R2VpbFZNQ2gr?=
 =?utf-8?Q?p1USoxZ1TEAOQyDoipNBW0ySP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10fe3ae-3372-4f84-3cdb-08dc756a2f4b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 05:36:50.1414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KCMFwkpzzyMqtjq+AMFKgwiCRnxnLvwhM6u6Ncd/Y0Mat/YO1v4rStRaTtme23NfdasLEJBOCCZGDCNDPPE1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9125



On 5/15/2024 11:05 PM, Ma ZhiDa wrote:
> Hi Perry,
> 
> Got it. Thanks.
> 
> BR,
> Peng
> ------------------------------------------------------------------------
> *发件人:* Yuan, Perry <Perry.Yuan@amd.com>
> *发送时间:* 2024年5月16日 10:48
> *收件人:* zhida312@outlook.com <zhida312@outlook.com>
> *抄送:* Peng Ma <andypma@tencent.com>; Huang, Ray <Ray.Huang@amd.com>; 
> Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>; Limonciello, Mario 
> <Mario.Limonciello@amd.com>; linux-pm@vger.kernel.org 
> <linux-pm@vger.kernel.org>; linux-kernel@vger.kernel.org 
> <linux-kernel@vger.kernel.org>; viresh.kumar@linaro.org 
> <viresh.kumar@linaro.org>; rafael@kernel.org <rafael@kernel.org>
> *主题:* RE: [v3] cpufreq: amd-pstate: fix the memory to free after epp 
> exist
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Peng,
> 
>> -----Original Message-----
>> From: zhida312@outlook.com <zhida312@outlook.com>
>> Sent: Wednesday, May 15, 2024 10:54 AM
>> To: rafael@kernel.org; viresh.kumar@linaro.org
>> Cc: Peng Ma <andypma@tencent.com>; Huang, Ray <Ray.Huang@amd.com>;
>> Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; linux-
>> pm@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: [v3] cpufreq: amd-pstate: fix the memory to free after epp exist
> 
> The subject need to be update as below. " git format-patch -1 -v 3"
> 
> [PATCH v3] cpufreq: amd-pstate: fix the memory to free after epp exist
> 
> 
>>
>> From: andypma <andypma.tencent.com>
>>
>> the cpudata memory from kzmalloc in epp init function is not free after epp exist,
>> so we should free it.
>>
>> Signed-off-by: Peng Ma <andypma@tencent.com>
>>
>> Changes since v2:
>>       update Signed-off-by to Peng Ma <andypma@tencent.com>.
>>       set a space between if and "(".
>>
>> Changes since v1:
>>       check whether it is empty before releasing.
>>       set driver_data is NULL after free.
If you submit one more change, please add your changelist below cutlist.

IE:

S-o-b <user@name>
---
Changes from v3 to v4:
Foo the bar

>> ---
>>  drivers/cpufreq/amd-pstate.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c index
>> 6a342b0c0140..1b7e82a0ad2e 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -1441,6 +1441,13 @@ static int amd_pstate_epp_cpu_init(struct
>> cpufreq_policy *policy)
>>
>>  static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)  {
>> +     struct amd_cpudata *cpudata = policy->driver_data;
>> +
>> +     if (cpudata) {
>> +             kfree(cpudata);
>> +             policy->driver_data = NULL;
>> +     }
>> +
>>       pr_debug("CPU %d exiting\n", policy->cpu);
>>       return 0;
>>  }
>> --
>> 2.41.0
> 

