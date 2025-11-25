Return-Path: <linux-pm+bounces-38598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E5DC85533
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 15:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 943614EB748
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 14:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489F3325704;
	Tue, 25 Nov 2025 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDQnk9cs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABED2322C99
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764079522; cv=fail; b=kqlfYWx7nwS5gtULYNUTr6Oz1E6XUQcFBBmW0i33B5nehBwioiC+3U/AYP5ea2Y2f02gNiR5ExkQ051z//9IE6BBKi1nePVkwkT2lBSJxH3kHPjjTC0sQD/riVuvIsY6rNhV6PE1FNL0YbzrHN6LxLTmT7gZav+rSxzgnMLV94A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764079522; c=relaxed/simple;
	bh=Bc6rtWv9YLz7UOEDSahfnJWFnQgGlW6tk+xXLMbn9wQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZkOSWqKWV0Z1sD5f08a8FuVfb+FJrnpIHUNLQajrBReRKipx5D0YUmFuIxHj40e7bg3np0kDKW4uBm8MTzyTaCUn/a9ZYwcqvs/PDcdslGjpooo1J1rHRY3HwMcnxi5gkn00VDYwueRP7Ct6VHf+YBn4hMZj+DFg6e6xZoiNiB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDQnk9cs; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764079521; x=1795615521;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bc6rtWv9YLz7UOEDSahfnJWFnQgGlW6tk+xXLMbn9wQ=;
  b=EDQnk9csGcLJIEyxonNyIjDjvWgqNNgOyvxCbhy/Ld3aHSyqSL32wfqY
   poqgBDna1quz4E9z4DybMG/gRP/AiI+UU6l6yQ3gZyUN89LwPvFlG9VDX
   Bf9fsPVAMagIxDGE990c+e/uZ3yxmXmOZVro+uGyh5L5Y6W8wzZ0vKlcA
   +pmnXqhMhMc+WO+HKoG1eend+kHlhz/LDl0/9cOI7qWddjdjKiIgpMi7Z
   VWu7FxiCrwG7kq0ckkale9Q+dRk/riDqKw2sDaKzF08rS4bCHB6Pfl+Ux
   W00asTeHxoYMtd8WxX2qfJ1D+xb3d3BPxEbA0kTnZJpGjJb1ufDm/baXN
   g==;
X-CSE-ConnectionGUID: qzrSLWYnT6i/1IcxuLvPKw==
X-CSE-MsgGUID: CsWPMwNsQxS4ihKP5YF0mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="66043667"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="66043667"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 06:05:20 -0800
X-CSE-ConnectionGUID: Za+NmS6IS4SIcYOKqmmukA==
X-CSE-MsgGUID: 7p+dwjKATiOTNAbQrY3QjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="197579047"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 06:05:12 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 06:05:11 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 06:05:11 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 06:05:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNtcllqjjFkBQPsXyAgZJ3Pqn/9wah/4Qep3V+mIjcLID5pq81M+HrKO+5vosQ7VoKfF5gF3f82vHa/S3G0Mj7dn1djcC5C4X4Ff7vufYkQSuD7bw0WubvntNxk/i8AHigdli7JFy4CASJvYvf+VM3nPZH/QnJtIbMOUXWU/UhvsyVTp1tSj8frwNIVo6XJX4Oknco7AlZyLrL4cPh3c1VxSHDpdGKRh4rQudU5b35Wq/+erGloh02I7RTcbTwcV8CzBxl1lN5GnfNXxp4QxjbUm68vGhfV6WgL7ld2mRNhglkRu8h7v5pMMS5Yk4D12Q47ne9UWIN8lCDaEhq8MTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bc6rtWv9YLz7UOEDSahfnJWFnQgGlW6tk+xXLMbn9wQ=;
 b=uOoibSiTb9uFrlbYCSmQWMPt+hIo5us0/gR4Vk27x5pHAIGB4QwLTghM8KEWcyByUDQzetZzdPIt+MCYynTia1HVbWCIR36MLc/kdQfGofnzIxiBYaEOSDFPrcpyELGsu4rXQg2qkSFSslC9S1qW8iEM/XvARAyTpDrl6ihl70euiD4FeFnV5ymywpLB9asPE8cPuzua8MFO97mWgJrNWZYN8N7Ff9upVxq1iPlC2V2NidQs4v6kJAuN4KFOwG0q8cH6V4/EJmGFHSbemItEZQRwnkiSmv6zvfK5GQ/RA9X+FdgkMfXRJ5tW6TreWgpNKUXy02Z1n+OwUTHb2L2Mww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by SA3PR11MB9510.namprd11.prod.outlook.com (2603:10b6:806:47e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 14:05:10 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 14:05:09 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle
	<christian.loehle@arm.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Lukasz Luba
	<lukasz.luba@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"vschneid@redhat.com" <vschneid@redhat.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "bsegall@google.com"
	<bsegall@google.com>
Subject: RE: [PATCH] sched/cpufreq: Fix capacity calc in shared policy update
Thread-Topic: [PATCH] sched/cpufreq: Fix capacity calc in shared policy update
Thread-Index: AQHcXeptnEOD6bRJr0mzbLDctwrQBbUDHO0ggAA48CGAABbj8A==
Date: Tue, 25 Nov 2025 14:05:09 +0000
Message-ID: <LV3PR11MB876874B93C5ECB14A9016DB6F5D1A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20251125032437.2056626-1-kaushlendra.kumar@intel.com>
 <71ea7728-6808-4bdf-9437-3746ff8664fc@arm.com>
 <LV3PR11MB8768D5F17B1F9575DE2804B6F5D1A@LV3PR11MB8768.namprd11.prod.outlook.com>
 <CAKfTPtChUavg0TYK_BiA9NnR-9_A1nz49kMASf6g8vCwhpJzcg@mail.gmail.com>
 <5ce509d3-0e11-444f-a22e-6c01280dd9af@arm.com>
 <CAJZ5v0hj_YB91SUej3gGzQy+i3rjHwi5uxyKg5KGMJT_hpUOkg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hj_YB91SUej3gGzQy+i3rjHwi5uxyKg5KGMJT_hpUOkg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|SA3PR11MB9510:EE_
x-ms-office365-filtering-correlation-id: 2f0e33ea-2f58-477b-82bb-08de2c2ba520
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bE9WR3NzeHNSVjNrcU1hRFQ1cVc1eWs3Q2JJOUl2WUJmUHduOHlrQndpYUpt?=
 =?utf-8?B?Um84N2NvUXM2bkJzRy9nZ1Q2T1c4U202R1ZIK1dTeUFnUS9qYldlOTRWLzVt?=
 =?utf-8?B?MnYrQ3FrVjJBZ3dxZkJlbjZmcjdYSzFhU3BGUmcxaDNLRVNQb0lWV1lvRXJZ?=
 =?utf-8?B?Q0tMSjY0a2dPM1dNcllndHo3dTEvTTlqaWZhZFJiN3BxTWRqSk9ncE1kU21u?=
 =?utf-8?B?cUd0WklxZEhLY2J6V08xckdRb2VmN1BVRG1CVUhuNDdkM05YaEh3OVNDb2Ry?=
 =?utf-8?B?OS85Q0lDQlpFWXp4RUIyRklUbXVYQlB4eld2N0w1clVzOHFyR3RJUkRpdmtn?=
 =?utf-8?B?bXNSTUovYWY2Nzk4TjlwNXdoZUV3UHNLdnVRdC9TeXV4TCtwb0VRdldZdjBI?=
 =?utf-8?B?VGR4TWNET2ZMRi9EZlpBSjljVGZXVm1VQnJQUmhEaytOaHBBamliNjZwZndC?=
 =?utf-8?B?TkxOR0MyOEZ3MXJvaEZEUHNHMVM0Y01mOUVBcUtpNlN3eHYxQVlkRDdSMHJt?=
 =?utf-8?B?VW5MRWRGanBSMW44RzhtdjBaL1htSE9tVEczdjljNE5DUkc3NFp4T2dRK1JS?=
 =?utf-8?B?Zk1LMEpsTXJHYUt1UW4rdVBESW9pRnNOd0xrRlR5NmYyQWpQR01RaUM1aFJK?=
 =?utf-8?B?STMwd1JRTlFkMTlnWEJkNmVVUmJlMXYrY3RiWks0Y2JocExCeERjenNUWEtS?=
 =?utf-8?B?OFNCVVRmd2pDZEp3YW5HV1d3RkNDRFp6UzlMbHdFQ3loN1d4dm5wNDVZaklm?=
 =?utf-8?B?QlFsbzVsVjdTZlVhK2d4aDBJVDZTNk52MHZoenlQVkpzRWtjTWx3N21PTkhv?=
 =?utf-8?B?K0dOUWlUdzFuNC9TSFZqOHZva3RJcUdINjJYR1AwWk1hSWlSTWh4T3dkdUht?=
 =?utf-8?B?NUluY21PdFJjSFdKZFNrL2gwbmJJNVZHNUltV0ptdGZ6TktycERBcVB1UDFa?=
 =?utf-8?B?b3E1ZFkwU3lRd013Zml2Zjlkd21mZGViWjFONGNLMUFjbWRXWHlObTRlNHBZ?=
 =?utf-8?B?ZDNveWdiRnlIeFJTVlhpUG02eEZKOUluVW5TR0tiUXBtVlN3Q1cva3hrM1BT?=
 =?utf-8?B?eXQrV1NkLys0M0p2THIrbmFndUxWZmh4RW90TXFUVzlVT05TbjJsOFNuc2J2?=
 =?utf-8?B?bytEVVlPTHJDQ2FBdFNiNUxlRUxRSks5bW1iUm5UNnRMejhxcDQwdytqT3BG?=
 =?utf-8?B?YlRsS2lTcklxTlBJcW5HcGRHVFZ3dVo3MXlkSXU3dTFIcEJtK3Vyd1FiYjBT?=
 =?utf-8?B?OFQwUTN5ak9MbTVuVjE1S3NVY0VjeFMrM1ZqNWsvKy9CS3VOOS9vdkZ1NCtv?=
 =?utf-8?B?bmtyaXJaVFVSck1kSUFZb2haQjNaUEN6RU90UEdxWHl5Vmxoc3ZrdnZ4VEJa?=
 =?utf-8?B?RzMvc3NiR0tpRWFsenRzTHErYTF1Yy9wdmowM3hHcTVqeUFRSklNYnNIVDVq?=
 =?utf-8?B?ZUtkRjBad1piZis5Y0xLanRZOE5ZRExFem5wRzY3SUptTkgzbWoreEdkSlBN?=
 =?utf-8?B?anh1OUdERmZXbGsyRkVWSHJBeXF1QTFBdzdwUTNRRWhkK2ZTY3lIemh3WUdC?=
 =?utf-8?B?UEU5M1ZpN3hER1dvemQ0V2RlYU5HMHNwL1NBMzhqeUlMMG5LYUZUTXNyd3Bh?=
 =?utf-8?B?N0hqTkJ2VlZGUVpLNjEzV2o4bWs4TGtibHRPNlVJbTd3SWxWbmZDTDBkVlRQ?=
 =?utf-8?B?MFZyckdNMHMwWUN1REhzNGtpeUFocXJlZytnODhGdTArWk1INW1LdUxTV0hl?=
 =?utf-8?B?emhGQS9aclFnZ21YblRJNk5xcU10OUlVNk1wQThhRzg3S3Rtc3V2T3BySWJL?=
 =?utf-8?B?NDBqMmEyTHVITFdoZjZiMnJPckl6dm11SkNWNjlUZFkrcE1SZW04c0RPZkJn?=
 =?utf-8?B?ZkJvMFNtajAwOTlGMlV0b3lvOTlXemF2ZzBoRjZuNDdJOFFQa3ovTkRUNVlk?=
 =?utf-8?B?NVF3ZE43QTdUQmFRQTIydTdqcEhmN3pWS1p3NDhJV2Ixazg4QW1pQUliTHFJ?=
 =?utf-8?B?aVlUZEFCd2cwMmFOVllUZnJtblpDeUM5dGVMMEt6dXdRQUlzYjJTUkpoSDR4?=
 =?utf-8?Q?krAVUu?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckNRSE5PUVZpc013MmpLRDdIZXpmOFd0OVc0ckJoZWM4Q1VCcWJSdjYxaExx?=
 =?utf-8?B?Wk9jNWxzd3FwR1pObDJIcFAvZ0J4SC8xSTRneDRHNnlpWWthQ2pyL3JKK1BY?=
 =?utf-8?B?WmtMNlpJNUNXSmpsRlhtNXg2bEwwVlhZc2lpOVZoRkJidjcxVm9nTXViVTJy?=
 =?utf-8?B?aDFheDNqR1dSSStHKzJibzFIcXpkWlpzRnpycFV1bzE5MGlHbTR4anlVcU9Z?=
 =?utf-8?B?OCtBSmdmVlpTMzNGRzZVcndKWGY3bVRlUDNLTngvZzJnNGcwUHRZK0x5S0wz?=
 =?utf-8?B?TFRPVllIL1pZazA1MDRTWjNGZTFWcGNXbEZPcm1jdmp3SE1jS1lWSzEwQy8y?=
 =?utf-8?B?STZRK25VdXFPZVozQTQvN2czeGdOeG80WHUyM1lUMzBHYlBKSFQwajdvS3Az?=
 =?utf-8?B?aitUVHFNaVY3YW9aMnc1UG44aUR0cEZQdDVvbWVRc3VXNWZ2Q083KzR3ZDdH?=
 =?utf-8?B?dEdNZHNlTkMwYW9icnRsdyswNU9vU0E3OG9DMW1TWDNtZytkT2xtYXFtdC9W?=
 =?utf-8?B?TlBEcFNmQk01RmNVWGljWlp0MElXWnUzbnJzRTNyREgxS21XTXFmQ1J1S3BB?=
 =?utf-8?B?NkRtdTF6WGg1bUtRZGFkcUlKdXA3U1c0MG1uOFhIMEpkVzhXdzgvQnMrSlFx?=
 =?utf-8?B?V2w3WTZaYzd0UWpyYzNMVnZkSDJkbSs4QlZrREd0MHlGRHhNQ1ArLzluNHE2?=
 =?utf-8?B?emNHdms1alJJZTl1bnNpNjU5ejlyeWpxVGtodktPSnFpRjYwaitTeXZ2bXhu?=
 =?utf-8?B?VC9IQUV6WXZwaWZvT0htbVMrT2cyQmFpTlJhRGVxQnpmbE95c3BTWU1KQkZy?=
 =?utf-8?B?V3JyR0RwRG9SWWE2c2JZTXlzQUp2SVg4dFBNYnoxbVBhNDlSZ2JCTTFMSnVH?=
 =?utf-8?B?TkUramZjWmRYZi92eHY1SkdlYjRPQS9FejRiYi8rNEF5ZS9JUWZkZk1HRWhq?=
 =?utf-8?B?WHphQnQ0MVNVQXhNczgrbTZkQWl3MG1mYjJKRHpBVmpwUjhiNjdtVm5wOW9v?=
 =?utf-8?B?aCtOcDRyZjdyME5VZSsveUtOZ0YrdU5PR3ZSTW5WMnZNSm9zR1lWL0x1MEZn?=
 =?utf-8?B?UHhyZnZvY3JLR3VSM2lUVUVhRHUySjBzM1MweUFSMWJ4a0UydnEveGR0VHI3?=
 =?utf-8?B?RER2T1dCM0h1T3dKVTZrdVpyNndxaWhZYmw5dDMzV1pQNkp6UVl1d0dqZ0Za?=
 =?utf-8?B?c1ZQYlB6K0JZZkh6VW5hRlV5dTVjZWxPd0g3OHpSU3lJZUJXTmMrVHE0QXJH?=
 =?utf-8?B?c3lGTVdSdmJaT1RDc0haQ1ZCOTkydWd5eUJTMzBUYjZxeXBKZjFkWHRxbXNG?=
 =?utf-8?B?S1o4RklJTHRVN3VPNmZYUTR2REFBYTdzK0Vka1ptcitESnZuSzBnQUc3Smsv?=
 =?utf-8?B?R21qUVVuRjhaUkVYV3haSU1IdWRjd2k4enVVdUZyWnpKcjBXNFZzSzJCMkJq?=
 =?utf-8?B?QmZ0STVxQU03djFRMzhBSTR4bUovcWZTNDYyaExwMjVEWjdkTTJINjlWY05N?=
 =?utf-8?B?NDFOcTlxSnZWK2RFOC9LYklHbG9YTlQ1QmJiaUFTTEFOdVNBNTVlMWlNWG9Y?=
 =?utf-8?B?V1FTMU51ZmNBSFNYaGcxRDQxc0xQenBRMGxHNFUzQUh0OVd4aENGUzhkc0U0?=
 =?utf-8?B?QTlYSmZtYWNVS3pNbXpTSDcwbmhLN2V3bzFGcFNyY1FBUTFkWEJFeHpvanJ5?=
 =?utf-8?B?TGxiRGZHZW9aOVZRMHlDck9NdzZOMHIvNmlUY0xEdTdFK3JpMVVMRk84dHlm?=
 =?utf-8?B?b054dFFlZGZxWnBDOElrOFBqLzZFSWJMenVYeTRCdVRtMW1IUmg3V1B3Vktm?=
 =?utf-8?B?Z3gwTktEN2hud3lVSllBQitEVTdKZ3Nha0RjaCtzbTlsUERncjYxQU1Sa3Y3?=
 =?utf-8?B?UjlFdGF4bTFaNHdBMHI0QXA1b05FMlNURUpJWDRFUFZIS2hUdFZVNFVXdXpM?=
 =?utf-8?B?SkM2bllVTkVzNkJtdVV1VmpaSlFMdzhDTE5wZUlXZWJUM1g4dWVCVlZUZEJK?=
 =?utf-8?B?OVc0Nmw0STZMRHV3OUVXM2dqOUo1a2hkQ0lIU2FJRmJhdHpTV0c5aXRWbXlu?=
 =?utf-8?B?VkkrS1lOZTA1ZmdQTEg5ejJOV2pCUEIwRWVTZ2NFS1FkQzJqbjg1dG1aN0FO?=
 =?utf-8?B?NkcwU2tIUTFqeXdPTDJvUGk5UnJ3MTNlUGI0UGhtQnJvUGJValo0QTF2N0dx?=
 =?utf-8?B?bmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0e33ea-2f58-477b-82bb-08de2c2ba520
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 14:05:09.8352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NczPLaqorzY2r30P9ZZFsty/wJPaOu41wEonSYgEAVyNW8jcz0k29J7Pz0u8WN/wTIjzcn0A+5B94h+eeES06JZGf7gkjIN/SCNfKt0gybM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9510
X-OriginatorOrg: intel.com

SGkgUmFmYWVsLA0KDQpPbiAxMS8yNS8yNSBYWDpYWCwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6
DQo+IE9uIFR1ZSwgTm92IDI1LCAyMDI1IGF0IDEwOjQ2IEFNIENocmlzdGlhbiBMb2VobGUgDQo+
IDxjaHJpc3RpYW4ubG9laGxlQGFybS5jb20+IHdyb3RlOg0KPj4NCj4+IE9uIDExLzI1LzI1IDA5
OjM4LCBWaW5jZW50IEd1aXR0b3Qgd3JvdGU6DQo+PiA+IE9uIFR1ZSwgMjUgTm92IDIwMjUgYXQg
MTA6MjMsIEt1bWFyLCBLYXVzaGxlbmRyYSANCj4+ID4gPGthdXNobGVuZHJhLmt1bWFyQGludGVs
LmNvbT4gd3JvdGU6DQo+PiA+Pg0KPj4gPj4gVGhpcyBpcyB3aXRoIHJlc3BlY3QgdG8gaW50ZWwg
cGxhdGZvcm1zIHdoaWNoIGhhcyBFLWNvcmVzIGFuZCBQLWNvcmVzLg0KPiANCj4gU28gdGhpcyBp
cyBhbGwgbWlzZ3VpZGVkLg0KPiANCj4gUC1jb3JlcyBhbmQgRS1jb3JlcyBkb24ndCBldmVuIHNo
YXJlIGZyZXF1ZW5jeSwgc28gd2h5IHdvdWxkIHRoZXkgYmUgDQo+IHRoZXJlIGluIHRoZSBzYW1l
IGRvbWFpbj8NCj4gDQo+IE9uIFAtY29yZXMsIGZyZXF1ZW5jeSBjYW4gYmUgY29udHJvbGxlZCBp
bmRlcGVuZGVudGx5IHBlci1jb3JlLg0KPiANCj4gRS1jb3JlcyB0ZWNobmljYWxseSBnbyBpbiBt
b2R1bGVzIG9mIDQgYW5kIHRoZSBmcmVxdWVuY3kgaXMgc2hhcmVkIA0KPiB3aXRoaW4gYSBtb2R1
bGUsIGJ1dCB0aGUgaW50ZXJmYWNlIHRvIGNvbnRyb2wgaXQgKEhXUCBvciBDUFBDIGlmIHlvdQ0K
PiB3aWxsKSBpcyBwZXItQ1BVIGFuZCBpbnRlbF9wc3RhdGUgdHJlYW5zIHRoZW0gYXMgaW5kZXBl
bmRlbnQuDQo+IA0KPiBGb3IgdGhpcyByZWFzb24sIHN1Z292X25leHRfZnJlcV9zaGFyZWQoKSBz
aG91bGQgbmV2ZXIgYmUgdXNlZCBvbiBJbnRlbCANCj4gaGFyZHdhcmUuDQoNClRoYW5rIHlvdSBm
b3IgdGhlIGNsYXJpZmljYXRpb24uIA0KDQpCUiwNCkthdXNobGVuZHJhDQo=

