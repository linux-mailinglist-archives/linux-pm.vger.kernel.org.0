Return-Path: <linux-pm+bounces-42253-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id i9kUIWQSiGm9iAQAu9opvQ
	(envelope-from <linux-pm+bounces-42253-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 05:34:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC44107E01
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 05:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A20A2300D698
	for <lists+linux-pm@lfdr.de>; Sun,  8 Feb 2026 04:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A40344DB7;
	Sun,  8 Feb 2026 04:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yc2bxywu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D782287505
	for <linux-pm@vger.kernel.org>; Sun,  8 Feb 2026 04:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770525281; cv=fail; b=oQFxEjgqasHv12HELjsKwysh+v7DoZ/LbzU618uIz+3bVLT2wom4m9mFLG4y5DiC/k1aKRtBTGF6uN+6pxY5whfX1a2N1vJSx4hEJ6tmG7jR/2oxyrW5w8i9B2eTRTxITXw8sRmSDbolzT/xCC/OUxjHtiMEas+YDeHO8p3C2qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770525281; c=relaxed/simple;
	bh=P65vai2tXXtb9j4pFIxjo9QzCk6/KDmXQ+2e3hnvDoE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZE0lJ3sKe8g/8qwILvKT44Jmwu9/jC5Pay4lGpy95bhqWQEkcLdiDgsN88VHy5xk71AyLSOOi30xmXkSjBFx+YeYQXf8EMiHM+qd/j6ZlwrIgi4RqYpMgelwrYwKJRlDqtEY4pZUK8Vyrtv+flJhQsZq/gRBglHXATgo1b6fEqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yc2bxywu; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770525281; x=1802061281;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P65vai2tXXtb9j4pFIxjo9QzCk6/KDmXQ+2e3hnvDoE=;
  b=Yc2bxywuW2T9vq5nZr1F72EijDN5B3gtqB71udioAIglzS2LnurfS/+E
   3bkVwdgg08NoXgwZDRVWlbaU3ZL0rPdRSRb2Co84p6KNkl2MZjK6s5pzf
   ptUYMFCeT6+Yc/v9lkBgtlSV0Sipy70RKlF/76jpFxeNq13gUSIysgjw6
   G/0fk98B5cgJ8zPx2SPCBeN7RJY16kKaCmZB5ihOW27FVzG5SakoVMEMu
   K1WHfD59wcaDzKJeYv4cVX+ROBwBiXiOTgoNa2KbnD3dlOn8GB5A6mm/1
   JouqGIRzAG/I0Xmj8bQ+YkrH7Aali7iKvlSmwZxRZ0itLV9L1/irECNoU
   Q==;
X-CSE-ConnectionGUID: QAINpOxWSkeeUJO/4DosGA==
X-CSE-MsgGUID: o87CRCztRSWi4jgZX30UZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11694"; a="82789501"
X-IronPort-AV: E=Sophos;i="6.21,279,1763452800"; 
   d="scan'208";a="82789501"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2026 20:34:40 -0800
X-CSE-ConnectionGUID: 4lQUs8hXRMST2kjtNzdj8w==
X-CSE-MsgGUID: 4cLwk4rDQvillhVKANT2Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,279,1763452800"; 
   d="scan'208";a="215752124"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2026 20:34:40 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sat, 7 Feb 2026 20:34:39 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sat, 7 Feb 2026 20:34:39 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sat, 7 Feb 2026 20:34:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbgmKfTHucmIkLzbVwEJJniQKwvtezlGElXfLfnH89lBFr4zEx2qYyK/WBbzCdk/l6ukdQayT6KAcV17WDU1OUunvdi5PDEfa/1R/Hkxoo6vAXuVgR7ZZ30/lj0g4LDuRmhD8+oV5NxWSt7nhVc3A3xicJ2NQAAkiOwb8BSuWlwo2+NJ0cTQt7a3WOEW8FxOquGQMltbmPteZJMy+EVF8w2kXrT2jxGn6Z0zjcdPd3Y+Q8lmNeRS3MNRv53h6gZ77/jw58pyUvU0N8ijG4G0CaRjfptefoBnNBbneHzooGc+Tx6KpA4+wb9Gpeg3S57VsEEn3IIC5Woi/S2ahsW2OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P65vai2tXXtb9j4pFIxjo9QzCk6/KDmXQ+2e3hnvDoE=;
 b=kD7qcE6GB1a5ac3AbyEZX6togNay4eOWoI+ZIt31FIxPAaYLPGP67RvQBqMiUusL1tEp1v2PT4k8R7XNDfWKGWXsW3D29Gcyl+pcTBTR40/o2wvoJPwTxLaMI/XHoBtQpqM3IUKjJ/38WRL3VrZa3NeBeM10iJxMTrNiFO3YTACJhXODBy+9tMghCbLbsTuI8lFsIa0cOz3pJSbfTxPttpQ7mHS8tIWQJMoVzGtPNO9J7JEk5PCYFY3XC1UxoFCaxgBxav47/4ZQJGhsoVblq2R4PTFGeNMcc5AG5y6dr9yyAO+Pm3kwD/DAIK7z3np6lozTc+OGC1N9qmyfaNk54w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by DS4PPF990BCE628.namprd11.prod.outlook.com (2603:10b6:f:fc02::3d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Sun, 8 Feb
 2026 04:34:32 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5%7]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 04:34:32 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>, "trenn@suse.com" <trenn@suse.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "jwyatt@redhat.com"
	<jwyatt@redhat.com>, "jkacur@redhat.com" <jkacur@redhat.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] cpupower: Remove incorrect EPP dependency in
 get_latency()
Thread-Topic: [PATCH] cpupower: Remove incorrect EPP dependency in
 get_latency()
Thread-Index: AQHcmEyd6a376sGoJESJEJHT6ypleLV4NPqg
Date: Sun, 8 Feb 2026 04:34:32 +0000
Message-ID: <LV3PR11MB8768F16244C44C0554F1C4E3F564A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20260204111104.3490323-1-kaushlendra.kumar@intel.com>
 <96b8e23d-8f65-440c-b3ff-d6afd218d329@linuxfoundation.org>
In-Reply-To: <96b8e23d-8f65-440c-b3ff-d6afd218d329@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|DS4PPF990BCE628:EE_
x-ms-office365-filtering-correlation-id: 9b3d2bab-40bc-45e2-ac8a-08de66cb5af7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?L1ZJbW9QYWhsbEp3MkFtNWZkL2VoSGE3ZTVzVFZVTklDZFMyWnp4dHZQRWMz?=
 =?utf-8?B?T08xSFkyYTYzOEp6RllhVmVFT3NSK1lDVmFRZVNaV2RxODM4M1RELytUYkhQ?=
 =?utf-8?B?U2o5ejJIbFY1RXhMTEhnQkpIV2tXRS9ZSlBmRUp2bk12K01GNFpiKzVUQnFX?=
 =?utf-8?B?clpwc1VibVp4d3RxNlZPRjFDREhRNHZwT2VqQjI2MVNLVHNEa2pzb3ljalpY?=
 =?utf-8?B?d1BuQzlkUFFHaktIUXVGTjh5bnhHMG81L3NUb21WUU9jQmlrNDRCVnVHazhM?=
 =?utf-8?B?OFEwTVdCMXBycnlaK1I4cWt2T0c0NFBielN0RW5uMUhXeU40YWFDd21YUy9S?=
 =?utf-8?B?aklGcTBpa3lmS0lPZ1E3NjZ1aUYzbUx6djZjeU9rM3ZBV2gyVzRLblRLK3hv?=
 =?utf-8?B?RjNibktZcENjazlrZ1ZZY0g4YTQ1SlplMGJWUFhjNE1RdmtKYzBFZjh0S0pR?=
 =?utf-8?B?aU56UmFnQ0M1NDJzWWhlYVpOdXE5VGpIbDVzQVRMZm40VlNFN2c5OS9hSk5w?=
 =?utf-8?B?MUVZcXhXWDVTb2IzK2RFZGtvUjkzM2syREN0d1JxUFRyRk4vZlZzS1lJbURt?=
 =?utf-8?B?eU9XMmlGOHZhM3Y2YTZDNk9KQXl4am04cDJCQ0M0Z3hXRnA0U25Ia0RHcHNk?=
 =?utf-8?B?dXcyUXljenVJcmM2anU2NzZUNEVQNW9iUHI1M3hnazNzRHpyYmJ5TGFXdDA0?=
 =?utf-8?B?NXJWNS9PY0NuQkZUT2lTbW94WDE1aXhEdjJzZ1RKZG0zYzFYTjBJQUFxZDNn?=
 =?utf-8?B?L1N0UCtXQXc2SnRXcFlMa0xCWjNLL0YyN2twdUVmdlVlVHA1SDZQbEw1bmJ5?=
 =?utf-8?B?Y1luTXlHVi9JRzlXR040QmFiUEJoRDE3M3JUVHRwdHFEU2ZwOVZPSitNZk5W?=
 =?utf-8?B?dmI2Vi81U0F3bUsrNjEzNXgwZVpDS0hzdmtYZjdPVFB6UWN6Z2NpLzFQQlJl?=
 =?utf-8?B?TDdlQ0lRdjFSUDN2VytRejBBQmJqZVFIeUFlN2xjVXA4SjRaRnh2MGVBWU5G?=
 =?utf-8?B?WXhlNldtYWprb2lvYXFTbUh1U2Q1ZUhZaU45ck9PTHlVS2p1OGRWSUV0MW5K?=
 =?utf-8?B?NzMwSWx4RHptb2JiZDF6ZzdxYVVKZi8zNTE3S2tvMklxd1VhSzg4cXgzZ2c0?=
 =?utf-8?B?ODNHNWUyQjhwWkl3c3czTE9lK085NHhMK2RaT0ZFVVJVYWVVVitjQ2hYN0xa?=
 =?utf-8?B?Qm1ZdURZeitVTmg0RWpqNUNWclp2VEt4Zm9mLzRyc20ydmozaGljcUY0UUxG?=
 =?utf-8?B?c0k3SDRPaEVwYk5FRmdVbGFPOGdPNWpQZjNIN3JBeTB0dUExeEhSMCtrY2to?=
 =?utf-8?B?T0FLNzRvaVZPakpnTVU3aThvaUNSS2ZPdXdTcXo3V0RrdTA0RHNOSXFXTUR6?=
 =?utf-8?B?bTRPM1RLdTArRnNZOFcwNTdSUElXZTU5c0ErdGk5NDV6UjJwQlVmWW1GMVFr?=
 =?utf-8?B?Ym1kZ1VZSE9ZMFZYaFQ2NU9tVi96Nk1DQ205aFQ5aGVReDg3c0hmYWJWMDYv?=
 =?utf-8?B?RHQzNnRTV0lXVTNiSURXL2t1V0FabEJNSzhINEkzTUdkSW5uMkVJNnFxcUEz?=
 =?utf-8?B?NW5aR1h6ZDRkZVlxWXZWWlZDN2VzNkNZd29TWkRZNXlzTDdSSUZMVDhGM3FN?=
 =?utf-8?B?V3U5bENSL3FtYVRKeW9seDA2U29XRlUycmE5TEV6cmVxVk45Q0ZJYlZUV081?=
 =?utf-8?B?YW1mcWVvMXRVa3Y0cjY2dGZzTWtzUDlDcFpXTlM1MWs4Q2tqUW04N1lLQVFJ?=
 =?utf-8?B?emd1NE0wZ2dZVy9xV1Q1a254d2lpamZpRFpMUHFRR2RtZ0lORFZocXpZaW9F?=
 =?utf-8?B?VENXb2dwY1o2UVIxYUVVamQxR0o3d2xISGtZMFpsdERLVVZBWlJtbUNvSG1D?=
 =?utf-8?B?OUpNN2p6Z0VGTlYzY0EwbUd1ZHhkbjlzSjg5ODRHOTFOdDdRcHZMQXROV2wv?=
 =?utf-8?B?dEFESzhzTjFsdnJ2TkYwQnZ6bGJPU0J0Tmp5RnpCa0k1Z1lEeTVudDBTdDQy?=
 =?utf-8?B?eWJ1YnZwNjBRb0E0Y0FvTGhLMHZteHBLNVRPSnUyazRWYmh3YW9vL1BjT1lK?=
 =?utf-8?B?NmpyRFFEUTlERUlhbGhHWWpsVmpzYXM0eXNOVUFwMEJvTklXRDZyeVl3b3Zv?=
 =?utf-8?B?eXZic25OMW1jaHRtSnBrNSt4Y2VWZCtxZ3ovQWpRbHZ6Um41bk1DUExDS1do?=
 =?utf-8?Q?NEKG+0hr4x4gttUs+BMZajc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmhMOXJTc0U1dUpYTHNyTHlCaWY3aGMvTG5OaVV0OW4xTFA1aGJVOUx5TDZC?=
 =?utf-8?B?UjRFWmgvN3orREVKb1QzcmFsZGUvMHp2OFdNbUFsVS9TVm1zYWR1a1dLZWFV?=
 =?utf-8?B?WklDRGU5TE5KMVF0dVNEV3RmKzZiT0lWOXkybHE0V0ZyR3VsdmV4QjdaRDBS?=
 =?utf-8?B?Y3NpZm52YTFzSklmeU00M1NQZjdzcU5CK2NPZXpHMmVnRTU3bnc1RmF6U2hi?=
 =?utf-8?B?dG91bXA1QWo4d2FRUytVeEhjcHZqbDVndllOSHptWEJXS3VEZ2Yrb1JmOUlJ?=
 =?utf-8?B?TzdLU3hSOHlWUkF5bjFqL2U2KzRML2R5c1BBT3RoT0RMNXlhU3VZNmYxSTFP?=
 =?utf-8?B?VjFRUE9KUW5ZNktrQ3NHeDZRTVR0SlVvU0kxbjNXNllnSnY2V0hhNUpyNzdR?=
 =?utf-8?B?MnpEVkIrZThKZW9wSDJORFNkNnB5b3JWalNUZkx2WGZRdjZOU2lSME1KTS95?=
 =?utf-8?B?THZFQmo2eDQ4ZHl3UkhKRm11dWdJaGxhME1iRXZTWmlIWDRlU3B3MFhSY0cw?=
 =?utf-8?B?Tnd0UTRPTGwwcnhFME5KQlE5Mjk5Z2NSa0Ftd0NQZ3BwbGIybmhydmlMQWlw?=
 =?utf-8?B?bDFkcmdzN2xEeFVkMXU3Wjg2cDhzS1UwWG5NNno2SGsxRDdmbGtuWnAxbDBi?=
 =?utf-8?B?YnliOGtMSEdCQVJtM21YRUpaS3Q1RzlwcVhaNStlRnhpZksvUHQrTWs5ZzNx?=
 =?utf-8?B?UzhrdVZiSmJUQVVhbDlScGxmcGhtRi92cFBaalBWdVJxQnpBMGtFOGI2MXZQ?=
 =?utf-8?B?d2svbVhBdHlqeFVBWTRpYUM1bjc0NkVTLzh1WkZGL1ZmcW9obExJSzYyOVd0?=
 =?utf-8?B?TEJ3ek5VTFc3ZnBhaWY3NG5tc05RRmJmbUZxQlRNWWxEM0hvRVZjd2lVZ3Yw?=
 =?utf-8?B?a1lOOGRuMEFOMmZRQTRRTjg3THc5QVg3QXhzajV2MHRCZUZ1ZVdRUFRmc3U4?=
 =?utf-8?B?SnNjdHZLc0drNkVOWmRLUkJ0cWdTMnNwaWhiZFFObWFhZTR1OHdISmZqUlly?=
 =?utf-8?B?dWM0K1U5MDFzcmtpV0V2MEZTYVI1djhtVXJadGdZY1V1NHc0UGxJRDdOeTU4?=
 =?utf-8?B?TklmdytkbFhEYWJSN291NGtpR0FORC9vQlZ4WUpKUGp4NFNyTnkyamw5aito?=
 =?utf-8?B?TmNHWTZXWmdncVpKZWp0NnEvZmhzNUFZdlNIcjI1N1FyWURiTGM2RStJa2oz?=
 =?utf-8?B?WXRMWWt5bTV0eStldllyU3lMdW9OSDJiY05jNzhxVk1NUnowWmU4VWZxd1J2?=
 =?utf-8?B?bFhMUmx3QnBGNmZ0eE5lVXJjd0hoTGs2VFJ5SlFWZkJPSndhV0RRKzRkRXVU?=
 =?utf-8?B?OGNpYVZWQTRKWG5JaUZzSVlSaDRBRmhXYWhjT3p3V0NmN3NDNDJKYWFZRDFF?=
 =?utf-8?B?eUxXVGtSZ1czbTA5REgyVUZIekNvK2NZKzhwRUpRQlZiMnJVY0JVWC9nTTJ0?=
 =?utf-8?B?VE56WWlzQm1ObTFpakVWaVE4STUvbE1PU0F6RDZoYWpwWm1RY2dHV1E4RURW?=
 =?utf-8?B?Zk9udU5MTnJJeTdxZEt2aXRvMzFqZFQwZ3IvYVk0WkVMcWNqNmx4VTgzMnha?=
 =?utf-8?B?VmxqeVFQQUxhY2xlSjNZaXhFVjhkd3NpVXpqMVJVMVlmclg2VEpxUjBsVWcz?=
 =?utf-8?B?bjUvUzdoQS8yOEhWYmNEWm4wb3ZGOXNPRGJXMTczUFJwV3NnUzhoa3lNdE1E?=
 =?utf-8?B?VnA0TU9Qb3NjS2JGaHc4dmRRMThHOE4wOUZYUVEza2tremo0eUtVRThST1V6?=
 =?utf-8?B?WWlPemJaaHh1b0cyZ1l1NENNVlV3UGorbkM0TVM1VTN2RVhKUlFyWUsvZmxt?=
 =?utf-8?B?Z2dWVHRVZkxsWWp4eUQvQ3lUVzZUMmVpRTZxS2I1dXZvSzcwajFOeE1mTWRm?=
 =?utf-8?B?VUl2WUM0c1Y1UFE2aUhFRjNXdTI4QnZhaHRxYyt6bzBONng3SnR3NUdPUlc4?=
 =?utf-8?B?VzNtbzVVRDcwcUVWZXhyU2crOGFMV2JNa05pMHh6djBXY2JiUXpLUGhRY041?=
 =?utf-8?B?NGdMMXc2NTZrVVovMTg0NlBaclJOVVFSYWVhWldHc0x2RjRjSFZmOEZ5WGV2?=
 =?utf-8?B?VW1hYXM5elBDc2I1dXVFcmlzanJ6dEcxeUVnUmtlbVk5Sk9Fa0twdUQ4aFpJ?=
 =?utf-8?B?ZXJuVmFCblBVWG5HQm96SHZXelpiMnd1S2tSMmRUQkRscndjNDFUd1NYbjRR?=
 =?utf-8?B?dGpNbE5BOGRXYU5TcG9mUlJKdllyblRNYmVXSXAyYXdkTDB4a24zZ2ZoaERQ?=
 =?utf-8?B?UXlLK0FFWm1NMHd4OUtkSmpzRW0ySUV1M1Zmem4ydkxNQzRLajZJWWZNMW5T?=
 =?utf-8?B?d29aQzVmdTdSRlQyd1dWVXhkZmJiRkxWOE5nVlZwa0lEeUx6Nnd6WWJjL2la?=
 =?utf-8?Q?8xFmO4ha6OT0ga4ujX2iuoDKmmnhCI0Ax0VN4byPAArwi?=
x-ms-exchange-antispam-messagedata-1: iRz7pQXCe+1AXLkJ/MX3zJSZqV70HQbwKaw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3d2bab-40bc-45e2-ac8a-08de66cb5af7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2026 04:34:32.3599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: teiBQrussmJFDBZyR3ZUIi0cLtatoFWxFxZo5vZJgGGfxytRYCOCtM4mH/L17olD6imDKeDcvhKUXqvhXwRphdmk/yrXDhi6u+nJ62D/8go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF990BCE628
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42253-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,LV3PR11MB8768.namprd11.prod.outlook.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaushlendra.kumar@intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DCC44107E01
X-Rspamd-Action: no action

T24gMi83LzI2IDE0OjIzLCBTaHVhaCBLaGFuIHdyb3RlOg0KPiBPbiAyLzQvMjYgMDQ6MTEsIEth
dXNobGVuZHJhIEt1bWFyIHdyb3RlOg0KPj4gVGhlIGdldF9sYXRlbmN5KCkgZnVuY3Rpb24gaW5j
b3JyZWN0bHkgY2FsbGVkIGdldF9lcHAoKSBhbmQgcmV0dXJuZWQNCj4+IGVycm9yIGlmIEVQUCAo
RW5lcmd5IFBlcmZvcm1hbmNlIFByZWZlcmVuY2UpIHdhcyBub3QgYXZhaWxhYmxlLCBldmVuDQo+
PiB0aG91Z2ggdHJhbnNpdGlvbiBsYXRlbmN5IGFuZCBFUFAgYXJlIGNvbXBsZXRlbHkgaW5kZXBl
bmRlbnQgQ1BVDQo+PiBmcmVxdWVuY3kgZmVhdHVyZXMuDQo+IA0KPiBIb3cgZGlkIHlvdSBmaW5k
IHRoaXMgcHJvYmxlbT8gQXJlIEVQUCBhbmQgQ1BVIGZyZXF1ZW5jeSBmZWF0dXJlcyANCj4gaW5k
ZXBlbmRlbnQgb24gbm9uLWludGVsIHBsYXRmb3Jtcz8NCg0KSGkgU2h1YWgsDQoNCldoeSBkbyB3
ZSBuZWVkIHRvIGNhbGwgZ2V0X2VwcCgpIGFmdGVyIGNhcHR1cmluZyB0aGUgbGF0ZW5jeT8NCg0K
VGhlIGVycm9uZW91cyBnZXRfZXBwKCkgY2hlY2sgY2FuIGNhdXNlIGdldF9sYXRlbmN5KCkgdG8g
ZmFpbCwgZXZlbiB0aG91Z2ggdmFsaWQgbGF0ZW5jeSBpbmZvcm1hdGlvbiBpcyBhdmFpbGFibGUu
DQoNClRoYW5rcywNCkthdXNobGVuZHJhDQo=

