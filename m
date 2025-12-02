Return-Path: <linux-pm+bounces-39080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D34BC9BCEE
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 15:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6DF5345BD4
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 14:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508A021CC71;
	Tue,  2 Dec 2025 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTNuxDtf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978E6202F65;
	Tue,  2 Dec 2025 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764686296; cv=fail; b=fwazkRDkw62DnQhTAKzRW2dOCjHGIZj4m++Wa1SHGgQQtq/4IQhIY4dWtzFt2ip/K1Evu0bVKkuMU1je/lwylEUGueTBRN3BC/gB0a1fHxHuqQkz+sYurjQSv6n2zxcS/POv1tWpuFsIUqLwwJ7FtC4kN2Iwk5hWamI9MtICiv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764686296; c=relaxed/simple;
	bh=bq2ghed0tplHaJsGYiS3e4YQfi+k9/FiMB2UB3WBnfg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZcmhJTBowP4JFyPkUWABZSUrpBfJQ+Tyldv5rHli6u+RwhOjeXzZSmesPsGRHXOz751CW/Wx+KvTaYU1mPjnurMXvo0ncmHMISeGirZxYsLdQ2fKYWkGbf0pH23gTkhWukUb3UUfsi3u2QqT3YZUw+cvc7Cjea7yLPVCgbBM3oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTNuxDtf; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764686295; x=1796222295;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bq2ghed0tplHaJsGYiS3e4YQfi+k9/FiMB2UB3WBnfg=;
  b=bTNuxDtfx0v3SSD8DUsW73Zt2sTYO7Z2sx81U1RaXL5/seFV9JfuGbTk
   LF1vLRz/8NPZcVi7W4ezWcm+BQfWwqTAXUg2YcKdekQaXOWCJYW4Nfr6j
   yBoj+jdnlvWfGaDe+RMYat2DJyiOd53UlFzgizoV5ObBydgfmjM6XB2iX
   JmhNwam+fxGc2v8oCzRCaxXQO9lCOBe7rSHdpQ4g5011vOMxiJBpFRVW+
   eKQOrW3SfaOp3TMSvn1f3tVDWeEiWl/x6dW8ICPzBOcNKp0jePf1XIsZS
   KfRU7EoO3D3AMWI3F8h3ji62zxJ//taKqXBT/ObJcn7JjxpIKNDfRCj1d
   A==;
X-CSE-ConnectionGUID: 20aSLvwXQCWHwW6yNKgyBA==
X-CSE-MsgGUID: Fei9E51CSbKzzaqAOz75/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66368021"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="66368021"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 06:38:13 -0800
X-CSE-ConnectionGUID: 74Kdxs3eRWKBGTTNWd/2Nw==
X-CSE-MsgGUID: iYHxNlLqQ9eww+JsCRQYNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="194484156"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 06:38:13 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 06:38:11 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 06:38:11 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 06:38:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/aSZ/oNkWheC7/fLWjBjZE2v5DI2fD/nHOvvo0+Hn56KsCTZ6VKuoljHrJk04gnkvA1jvSbO+uAS2sKo7WR6IXM+2YjlCnDo3otaKX+NXiZA6sAOeIryfGzbulkxZJBMLDBK9pRBbTCHYq7pjaXUvBmN/9HIS5nO/HF+tvuOqWDpPXcdyMtIHeUjXaDBm2ei1M/ccPf998UiO/tTeB61GqdcnuTYtVGKdXk5cv0lGJV9hdSZrSFUXpJd2F/m9B5JX/msAonxZF/mFmBjo+NA+lEOeeX8/bG5GyBZ3ig8dp0eCFBWH/bilC78dVcfCMKLSBY8Ega0VTsRmIDblj4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6AI/TU6VqRPeNu6gDwnuH/SbLS9xpWxiKsWQBbLavQ=;
 b=bHMnu7exZnT64tqRVwKAVBmwIKEqFi2IdLk6l4KwCpspbBacXiKfPyDmmQjnRYHX5jegtcUiubsoTXkDzZtKwc64urT5lUJgmI7Jbx5HJ/E+bgss8zZ72QyYfezrDxMW8iWoHrCWueJvSeqd62BUkXtoOTltl5L5O98Kb0SX2et3DKhwK5sUYKMEftmUUa4WLAcRq/E1sLZN8dgnqOj2dxAwV0PRKyJUGBKNPYZgJjIt0S5sPNbGX2emkPv9r7uKEKVi96tGRQz4f56btRb44p86S0aSTCnYPP+uAAeiSPc5iCUXGGsGCfZZjd3yGM3Qqco7K/Vykt4HP/b9fpycJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by IA3PR11MB9399.namprd11.prod.outlook.com
 (2603:10b6:208:577::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 14:38:03 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c%2]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 14:38:03 +0000
Message-ID: <fb19346c-908a-47e1-ad45-bc44f0a10f7c@intel.com>
Date: Tue, 2 Dec 2025 15:37:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.18
To: Brian Norris <briannorris@chromium.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Guenter Roeck
	<linux@roeck-us.net>
References: <CAHk-=whnC+hRftevTLeVs3tyyqwn+7un=jUES2-WX+pZhDdKNw@mail.gmail.com>
 <93259f2b-7017-4096-a31b-cabbf6152e9b@roeck-us.net>
 <aS5wCcwpgkS9n67u@google.com>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <aS5wCcwpgkS9n67u@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0140.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::24) To DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF63A6024A9:EE_|IA3PR11MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c8ee19-1c22-4966-6429-08de31b06611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHBGVTY4dEczM040QlZWaXY0ZHVTNmo1RkJBMC9QZmo5RDlNTXcvL08vZ2R3?=
 =?utf-8?B?R2pKejFaMWRVUDZSOVE2aWNmY2ZWZ0J6TXlZRS9aS3dTU2VyNFlGYVgrSTBM?=
 =?utf-8?B?amxRdXpPMlhMZHJDbUYyS2RvL3dBWmVIZ0dlYWFRVGl1enJydHppdWFNTnBu?=
 =?utf-8?B?U1JsNEQrL1lrVWtQUUtEeXF2bUFiNWFVbUtXVU9NUndPOHVvaHJ1d2FSN2xS?=
 =?utf-8?B?SGMrZ2NremxkbkViQmVMWnQzOEJmZHZQL21xSG1mU21DNG93REo2aGlwSkgr?=
 =?utf-8?B?akFZYW0raTAwaUVjTlhFeUtaOGJXUFBONXlYQThUTXJJSEl6WjdZd1JRYkpq?=
 =?utf-8?B?bDhoSU5ENUo1eE8zdnpIM0JPd1lMRElVOENJUnNZWk85WndKOWV2cmNzeXpL?=
 =?utf-8?B?UkxGc0F1bmpLZURETFQvTWJpQktMNGxQUVJDNzh5SkVlM2QydjdhMC9XYW9D?=
 =?utf-8?B?NEduOG1DcExvQ05xdUhZUG56Q2QvZFpNQjF6eFdTdlVscCs2cCtCQWxybnJR?=
 =?utf-8?B?c2M0QldOR3VNbVRJYXJ4VndVOG5uWnAyQXM5RHJQT21QQUlnSUpRZjdMZFlB?=
 =?utf-8?B?QVFsdHdSa1YyS0g2QWFjUzkrVDRJeG8yWnZQRHBPZlNlTm5YckErcTQ2UHZK?=
 =?utf-8?B?RnM3ZVdDMGdxMHo5dDBqdkZmbU5YdDNoREcyR1VzdmlEekRxRzBrdE5kZ1JO?=
 =?utf-8?B?dW5tSEsyWFZDYTNmM1lTUmRUM09uKzNwWEIrL00zWnlyQkQ2dXVEUHNXTDB2?=
 =?utf-8?B?Z3psK2hLMCt1QS9ma3IxU3g4ZGlsRzhYcUdYVmhOV1RURjFkNVdHQmlJeGts?=
 =?utf-8?B?RnhVNGg1RFY5VStwbHJCNjZKVDhwa3JuRTloSW1HUE94OC9jdDd1bjZFZFYy?=
 =?utf-8?B?bElMYjRYdTBqQjVRWThDNGhJUW82c2I3YXJrWmlRQ25JRjJBMnBjRTNUM0Zo?=
 =?utf-8?B?dk1ndFFHTThNZ0hDdWgwUFpNOGMwK1M4aENTYjJta01pYzBwNmh2eXNBM2Zw?=
 =?utf-8?B?dldSZTlZbk1qd3hEQXBKOHZhcDJacFVTd0NmWEtBU0x0TFd1YnZaUjdEUjdP?=
 =?utf-8?B?SjBLWCtvcVJnT1NkZXprZlhNQ2krdCtWTEhSTmdaeE1TMittbnAybzdobTJt?=
 =?utf-8?B?clZ6dFUwb2NORTd2Ry9zSkh5eWVibXFXTFQ4V3VLL1B5S1p4L1VNRGx5WHJJ?=
 =?utf-8?B?QlJkYXV1VC9Cc0xONEp5M2JHaDZKbW5YMnN4dnZ6bVdxZVpwN3d1K2J3SHAx?=
 =?utf-8?B?QStUQTJZMUhpa1VwUGZGL0hUSGQyU3VxQ3BzQzNaOUM1ZXJ4TDJ2TENtdkRY?=
 =?utf-8?B?djBVS1BFMUlrTTlpZ0JONmplSEgrL0hiWnlCOEZSTzgyL2NQaHg5bktHOGs3?=
 =?utf-8?B?QXIxZ1JUdllZcWkvK2pBT1F6cWRLamx4a2xDckxuMWlYWVRMSXNBVXdiODlU?=
 =?utf-8?B?UWI1bklhQytENjk1UUZKNkhhUnpobEk5TDdQMG52bU1UTXViM2E4a0xUcGFE?=
 =?utf-8?B?UlcyUVZwMDNWaFRsc0t3djBMRzZUTSsyc0ppS3VDK3ArdGtIUnRMc2lKa2ti?=
 =?utf-8?B?bzFleHZvY0t6emJwbUFXU3RBTlFPTnVsQ2tkdlF6TFRIZHp6Zlg5dGVJQVo3?=
 =?utf-8?B?VEhYbUcrRFUzWDg5bEx0eS8vNmF2WVQyS251WnNSSDdrTTNTYStPclR4bkhB?=
 =?utf-8?B?enE3VTN0VjRSUzhzak16OGZVNGhxRExhVTkwMzBkbmNVbVYzaTBidUwveEs1?=
 =?utf-8?B?ZzhqVkxLRmxxTDdiMEJFYWZnYkVSTjF0NXBwT0NJUEFkbU1YNkhuK2M1SEs4?=
 =?utf-8?B?OUJKRVlPRmRXY2kwMi9RMEwzVVo4N2hEQjhJUDIzVTJLR0lDRFA4cGFSMW50?=
 =?utf-8?B?ejh3WldzalFGaXNqR2dmMlFneDhtQ0thWnhsc1p3MWdqak4vbjlQbzJ4OGNH?=
 =?utf-8?Q?1e+XoJjT+KhTJ8BYRamApVjZqF2LuhCh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ykw4U2s0WlhMM2Z1T2I4RHJtOGhuZElNbzlQOEJlVTNVRGwrTE9CZ2RGYTgy?=
 =?utf-8?B?SWR1TE15ejRBK0NkbklNSkNsUXdqZm4vV2VjeW9HNDBEZGRoVCs2OEFwVG04?=
 =?utf-8?B?SUU3aWVmaCtsOUZyMkhadHU3YThvVDBNV1VsZHpGVlR2T3hPYkZ6RndUQzE3?=
 =?utf-8?B?cC94K3VHbmxkVzVoTTB2SXM3UHBEc3ZqcmR6My92UU9DN1hqU0xHVUhEVm4y?=
 =?utf-8?B?QkM1Z2xEY2tFMkxjcnpINk1pQ0NIblNiSHdNQ2VOcGltU3loVm9BUWFxb1Y4?=
 =?utf-8?B?OTVKWXA0S08xbUNtYllVdmJzcGRWUHVSSmFhOFlkVzZsYWlya1ZaR3RLdkhW?=
 =?utf-8?B?MmhvLzRRYlR5TnlMVDRxZEg0WGYvTFFmZ3JQQ3RSODZhQnRQeDFrRTN4M0pj?=
 =?utf-8?B?YlRKUXdmVzgybWRpYnFyV3lsMzNob0NqNmJWR1FiQjA2TzFQY1E1VlZkaVl5?=
 =?utf-8?B?YmxHSnVhSXVwenV4RU50cktyZTN2K0lUMUduT3cvZDlDT3FXb1J6QTFQNFNS?=
 =?utf-8?B?a2lxMlJWd0NPd1dmaUlrNkhJcDdobG51NVppemFhN2xxcGRYdzlTWHdiWnFN?=
 =?utf-8?B?b3VnOHl5clRlZU1yMHl2SGxYbjRDTlcrK3VjaWJtYjJyKzZSTVhlVyt6TmFk?=
 =?utf-8?B?Y2F5L0cwM0lEdGhOU1VmTC9ocW14SEJmWEgwRHEySkFveTUrcXFtSlVnblZ4?=
 =?utf-8?B?dG1pK2grM016V0dSTVFpdXo1a0p4WkRYUWJwOWNMa3BFU2NSenVuSWFjWThL?=
 =?utf-8?B?enhyUWVTZ1BCWHQ0Y3E3WnJpejNTcEVaQ3JFNkYxZlJReWhQbVdxaHg1M2Zn?=
 =?utf-8?B?KzhqcjgzUy9jVGZZRHlpbGtrRlhjZjFyU2pUa3R2aGVVQXRuYm5vd2pJZ05W?=
 =?utf-8?B?a1lqWGI5dDlmR0lET1UrNW9scll4WVZsNVF2WXB0bmhIQ3k3Y1pabU5tdDg4?=
 =?utf-8?B?a0szOFdxR2tpTnR5dEdpZ2F2QVRYWlVCWDd0cGtTRkgrMzEyL1lybm1HZjJT?=
 =?utf-8?B?dlUrd2lGS1Nqdkllb1cwa0FDeU9zb0ZPejVtRkx0RmRsWnZDTEJOY1NzaTly?=
 =?utf-8?B?K3JwTjRyYytDUmdOZlNSQkpSb3pJdmVTcUxBL2RISkQ3T2V1UnVLRXRTSTl0?=
 =?utf-8?B?eFg4dE9jUmwzdU9mTTNlOUZTNitYeHRxOGtnK2sxTnhmeG01cGtYMFdUUFVk?=
 =?utf-8?B?K0JDUW91bFBObUE2K09TQTU1bWlEVk9kWkJJUVlBbUlaRnFuWTJLU2NteWpJ?=
 =?utf-8?B?dUs2YXJCbHYvZzZRdzd3RlNHZ3hBekZ0aGc0Qy9WWDMvMndyWjBEbU5kL29B?=
 =?utf-8?B?MksySEFuSHc0T3V1OVMrVThTQS9QSXpINkNKNnpzb0h1dkczREtpZnViREUw?=
 =?utf-8?B?Qjllb3hhM1VCdGlCR1I3Sm1ERDEyWHlXQk9qOG1tdXBESlpCZUZESXpKTURa?=
 =?utf-8?B?d240QzZ6NFE5aGNSZ01iaHQ3eVk0RVk4WEptSHBrOUp6eEl5MEdCdHMrajRZ?=
 =?utf-8?B?WTlQS1lycVJ2N3EzQjdhR1V6Z3RPSkZHczVhRWlPK3FQSnRBUWQ2Y2owUm5D?=
 =?utf-8?B?ZHpnSlFCSkRabmpReXNOdnEvME5RRUNQVHNZRmZQUVZMWFNJclRlMVI3V2tx?=
 =?utf-8?B?QjVnMUZ0clEvbUM0UytUekpwdTlEb3ZScVk4c2xwS0w5Zjh0TFVoOXJuVlhs?=
 =?utf-8?B?dktxNGtnUWt6QU9TVnN2bGUwSzlBU0VXY2dqYS9LTXJtbis1aGt5M3A4ZG5r?=
 =?utf-8?B?YzN4bVRKeGxXcVR4Vm9UNTgxZUkyT29DQnh4NTUrd3hIM1BrRFBQWUZ0cEwx?=
 =?utf-8?B?cnM0RVdrZXlJK0R0Y2c1ajgzZUJKazJpamtsR3dGUFRKVnc3N0Zkd1Y2MEF5?=
 =?utf-8?B?ZmxiZytiZHYvR29VZzRZaVdJcUJJL1Z0TWIwOUpRay8wV2hkVWhaU1FPYU9K?=
 =?utf-8?B?QndsNzExMDhySHA4eEVNa1JqMnVKN3lic2dIVkl6a3JOQk41Q01jVmVOUjRm?=
 =?utf-8?B?eDRMVnp4V1BvK2x2K1ppaVduVU0xYnYyTE9Md29uUXVrbGpNRmNEWnVlS2Rt?=
 =?utf-8?B?RDE4eUFDV0xNZG9wbFdyRGs2TmF1OGErdzdYSzE1aDZTN0lVL04zOFFHbUpz?=
 =?utf-8?B?cXpWNHZlRUxuT1ppZGpLaHgyaXN1RGZlOUZWZnA2UzkwYkpTZ29YYlNQSXpn?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c8ee19-1c22-4966-6429-08de31b06611
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 14:38:03.1948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8qY5Xuz0JHk50QcDKbrxTQmb3x2Z4Dugx8h6p+L3nSmJy9nEaQ4Ga5kug9hKGL09hU15yIuA1u5LU5mwxVkfo3dePwRvM7QiRMVYWWCpEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9399
X-OriginatorOrg: intel.com

On 12/2/2025 5:50 AM, Brian Norris wrote:
> On Mon, Dec 01, 2025 at 06:39:49PM -0800, Guenter Roeck wrote:
>> On Sun, Nov 30, 2025 at 03:59:17PM -0800, Linus Torvalds wrote:
>> ...
>>> Anyway, *today* the important kernel is the newly minted 6.18 release.
>>> Please do keep testing,
>>>
>> Build results:
>> 	total: 158 pass: 158 fail: 0
>> Qemu test results:
>> 	total: 610 pass: 610 fail: 0
>> Unit test results:
>> 	pass: 666778 fail: 113
>>
>> In terms of testing, that is worse that it sounds. I enabled
>> CONFIG_PM_RUNTIME_KUNIT_TEST last week, and it results in widespread
>> test failures. Picking one (from x86_64):
>>
>> [   34.559694]     # pm_runtime_error_test: EXPECTATION FAILED at drivers/base/power/runtime-test.c:177
>> [   34.559694]     Expected 1 == pm_runtime_barrier(dev), but
>> [   34.559694]         pm_runtime_barrier(dev) == 0 (0x0)
>> [   34.563604]     # pm_runtime_error_test: pass:0 fail:1 skip:0 total:1
>>
>> Looks like that fails pretty much on every architecture/platform where
>> it is enabled. Copying the author (Brian) for feedback.
> I wonder how you manage to be the one who hits all these problems,
> because none of the configurations and environments generated by
> ./tools/testing/kunit/kunit.py seem to hit it naturally. (I tested
> hundreds of cycles in various configurations with no failures
> previously, and I still didn't reproduce it today.) Do you make special
> effort to direct cosmic rays into your test setups while holding an
> unlucky charm? :)
>
> But since you pointed out the failure, I *can* induce the failure by
> forcing some scheduling delay.
>
> --- a/drivers/base/power/runtime-test.c
> +++ b/drivers/base/power/runtime-test.c
> @@ -3,6 +3,7 @@
>    * Copyright 2025 Google, Inc.
>    */
>   
> +#include <linux/delay.h>
>   #include <linux/cleanup.h>
>   #include <linux/pm_runtime.h>
>   #include <kunit/device.h>
> @@ -174,6 +175,7 @@ static void pm_runtime_error_test(struct kunit *test)
>   	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
>   
>   	KUNIT_EXPECT_EQ(test, 0, pm_runtime_get(dev));
> +	msleep(1000);
>   	KUNIT_EXPECT_EQ(test, 1, pm_runtime_barrier(dev)); /* resume was pending */
>   	pm_runtime_put(dev);
>   	pm_runtime_suspend(dev); /* flush the put(), to suspend */
>
> Looking closer at this part of the API, I think checking the return code
> of pm_runtime_barrier() is a bad idea, since it's inherently racy, and
> there's really no way to control that race. On the plus side, this test
> is the only one that does it. So I can probably just go ahead and make
> pm_runtime_barrier() a void function, and stop pretending it's part of
> the API surface. One fewer weird part of the runtime PM API to think
> about...

Yes, pm_runtime_barrier() should be void, the return value is a leftover 
thing.


> Maybe I can get around to that tomorrow.

I can do it unless you specifically want to take care of it yourself.


