Return-Path: <linux-pm+bounces-39170-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE07CA09F4
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 18:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 605133015135
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 17:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1A23385B3;
	Wed,  3 Dec 2025 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o4xPyqOj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kMTW7Jat"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23946337BAA;
	Wed,  3 Dec 2025 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764783094; cv=fail; b=anOQr1xT/RPuYj17XkLA63oB1nNQm+Ik+8oz61U4Ihj981baARNCDB/ElRhgJc1P/7lyxXfbV8/WBYD8NdBxOUrPMDBMPgU1KU1JRA3HM3+9LPYu/5nuvFjdTwnIqyC/sbTzZwFQKQgTQaX78uUaGu9kZfqP1Q3jXXOcFGFDPvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764783094; c=relaxed/simple;
	bh=Lux+Lb+NzFIzxLo/7ZUc0uw2I1xpG0wwk/A78RjoTXM=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=t1eR5t1cknmwUiagcv9JsaBWMwLQ1+/SSBdzqkywR2k7PAKZtUtrIQAAaTytl909WMzrpOo3/ehrEG8z5V0uQz+cfnqFMs1fmbt86zfTRmYXJsAhq4TJt/mdf+q5AIC7ANN/quVc0brqILeqPPw3CeCL7dyFUegQTEvYesubyOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o4xPyqOj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kMTW7Jat; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B3F10NK2884528;
	Wed, 3 Dec 2025 17:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Uo/3YZEM5ha6JNhR
	JVgxvZfDWugJPhQMt+Tl10CK9hk=; b=o4xPyqOjn02LyBGlQqeBnHEXvaYB8yqF
	ItmWJtF/LjlXZSvoAT0HBAHoIO2oAiXMkQ6QNB+8Y9/w1H5rpKvnPr9GqIcZ9R92
	1UwUoFRxB8gI07lpZQUCPaYOcX/Wb3h9LrEEHsp8aHkUSARMwa+qkIN/5EPUwrd8
	IXIEuPydO+bCfUD2qGbOHv03ymwwIFuU8N2QjNIKaNnTNGuslyuDO3A4szqcS/t0
	ZMuHLpVmf42y6zNdLYCyyiJ3OmF6WNoOhKKZvHHYqr4Wzwm0BnO38vO8oDbzyU4f
	gJHsY9mEJNXOz6ybVYhVvI/WrLp1eq6Em3ZP0yIo6/famHtZtRZ32g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7wnduha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Dec 2025 17:31:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3HPk6V015153;
	Wed, 3 Dec 2025 17:31:23 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9ayhpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Dec 2025 17:31:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtqxafSIqeN2xTB0R9q26CGhPYLaX38tva0xa1GRVgBH93Ckag/zc4hAvtP3O6OXPbMCEOOcQm0PPDskQJo8ESQNxrZDeVN8SuC4QLlVnQXB1lPEzapxgHF+RqAlFrQjRM7dvOnM2qc/2HaKLUeQvnaPGtslnMW/5zO02UqCUsDsQG6T7jIvAKOC13JLgMYEZ1FYFEyuYycuyLnXlHjFxlfDrNoxQK4okLyeUx8bjpZUbAD9AMh6Ws3atcHgmCGHx8Mr1EdR4QQFIL9x+lETBEQbiVnnzeyQ0nUHnl9Cag+URrdFYqaDr0HUOL+jah4+ToS9vnuf5UB8qZ1cf0dnrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uo/3YZEM5ha6JNhRJVgxvZfDWugJPhQMt+Tl10CK9hk=;
 b=iBjeaRq5dMDfPpYDe1hCXuIxIRxw8hl6sUtiLHBRo79BMuvUrjWuWfPY7semyrAcrVJQyAr0TbimW9SVRjH0LwPbVqSh8jRc/uQsTqX0njb+92/2+d3SkF/Uk6DPa2Qi7SjxT59COnWZevW9d9TCr9hqyAz+zrCrnpSuVrH7nEcG2YzOf1HRIWvhmIXPJOHp+q4MIo2jI0A/WhEuzTHIAB/TZDEHOReQFRyvo+H7Wp5+UGyYlXe6xa15HQIf3Wavb+ud8sh2RBsr0cP1Ihl9nTtJOpgezSBol5UCYilWgZdDfvbR9Ef9ep2DQF7vTWWeEQA/DBAS56JASlB5ccxzbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo/3YZEM5ha6JNhRJVgxvZfDWugJPhQMt+Tl10CK9hk=;
 b=kMTW7JatwT/bArQXYakXZE+1Tc9EDo5pI3EYliBCWB7fA58LFBmMlEXRpKZ1ZoqW/roQMyNE8jW6wW0liF/Q6rwOfDMpDaIXeZKYL486J8D/okom/qxy6XW01c2gfR30Z/IwVLGoQYDd2QfeG4AQCAj5rtGnYPMSX5hNm13rokA=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH7PR10MB5814.namprd10.prod.outlook.com (2603:10b6:510:125::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 17:31:20 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 17:31:19 +0000
Message-ID: <c0b5c308-ea18-4736-b507-01cb06cb8dfc@oracle.com>
Date: Wed, 3 Dec 2025 23:01:13 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: christian.loehle@arm.com, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org,
        "stable@vger.kernel.org"
 <stable@vger.kernel.org>
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: [report] Performance regressions introduced via "cpuidle: menu:
 Remove iowait influence" on 6.12.y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO0P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::15) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH7PR10MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1246ba-0016-4a5b-3a57-08de3291c568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXd3bGROREZjZWJYNlF2b3lGUVNMbTVmbk11QVJaSmhhcWs1WmExTlJwM3ZR?=
 =?utf-8?B?dEthd0ExUHpEYTExZCtOWVV6dC8xQ21hS3pXNEJOQ1g3ZStGdGxsVWZWekFY?=
 =?utf-8?B?M2lHaGNra3V4UXRGT0I1bXRJd3EyNGd5NGFlUE9ieVZ3elgwbHIrRU0veUhJ?=
 =?utf-8?B?OVFOTjNtVHVIK1o3Q3EzL0lWdERjTG5jNkYxZTNLLzgwdjlBenhhbVhHaUZI?=
 =?utf-8?B?bXoxK0ZKRFYxWmJvRjlidlBIVCswSDlkMERVcjBJcmlxOWVrb2MyNjhhSUVp?=
 =?utf-8?B?bEowVjdVWGRMSDhYQm1LM3hpVjVVRHNNTjJyTzBveHZ6a2ovNVdsZmNBYzBK?=
 =?utf-8?B?emlqVnNvKytTSFg5bkF2Q0NHL0ZRK3FNbGZsd1lIVEs4NzR0WUxVSTh0Ykpn?=
 =?utf-8?B?UUtJREdZL3o0dnV1YmlQVEd3Y1JOMktnaTJiRC9qWldTc1dNRkx1VzU2cFB2?=
 =?utf-8?B?TGxXK2E3ZmR4YmYwdlYvb2ZoRW83V3dLdmpZUVEyT2I3ejh4dFBXQWxYWTZp?=
 =?utf-8?B?cUZnbWM0Z0FjZUtua01EMjhzSGZrU2twUE9ZK04wN05BM3FrcE5kY0xKMUhU?=
 =?utf-8?B?U0JVRVNIVE1kTFIrTlRJTVhtRmcyam1MUEJlUmJDK1NGNnpzeitjb1dEak5l?=
 =?utf-8?B?WTkrd0R4cWpBWkxqNkpvNkdtSzhKcVBNNUkrdFIyUW1NbkxZalhnb0lCc1p5?=
 =?utf-8?B?NjRuUFR1ZUNEQ2x1QmVQVm00Q0xxK2RiblcwYUdibWZpNldWbWgrTUMzekti?=
 =?utf-8?B?NGQrYysxSXVlemo2Tm9Ud0luaVZkT2pGaGNYSlAyUTVTMXJKemxtTFdjb3Np?=
 =?utf-8?B?ZGFTY25MRDBTRHdoblBwQmlTWTdUNGMrOVhJbk9IRVdMQkJPSmxKZno5elhL?=
 =?utf-8?B?b2tqeXRMdWRlT2pkVmtlcyt4SVZ3VTNMVGtnTVpVOHE3TmFnMExsMEFVNGtS?=
 =?utf-8?B?eTFuTnMyUUtMeDFQbVZ1QzVBNWdOSFF6K3JXYUhzeEpWbXBCMXFzTjJFSlR4?=
 =?utf-8?B?UW1kUzNxYlpjS0toYlZTL2dPY1VqS1Bjd0NvN3EzLzk3b3ZBb3piQ0RKei85?=
 =?utf-8?B?bmV2Z1lPUmlhSlZPUTcwUHdoTFJGMzE3MjJtT2RXVXBNd25RKzlCNVpBcnoy?=
 =?utf-8?B?MkxSL01PUm1SUGRiaTgyZkxwcjk4bUQ1OWNVc0Z6NFlKd3puc1ZZSmNJK0Fp?=
 =?utf-8?B?MTdhUTVKQnJtTWhMSXhmaHEwQ0p6M0FhVUNoUEhDQWpGM1R0cmFnUlJaWFYv?=
 =?utf-8?B?UlFIREdPUEIzTElMc0VQUzQ4Y2FqeHZ5N0xFbkZDWWdZL3FYRGl4RmhJUCts?=
 =?utf-8?B?eWpnSFJ2eFFqZWRheHBaZ2FYM1d0YVVDSTZaNmxISG9XbzRHYVV1UG4zWXZE?=
 =?utf-8?B?YmJiUHdWUUg1M0FmRWV0ZW5OUTB3dXZWRWRGUGdneE1RQVVzVWpwVlFkUWhy?=
 =?utf-8?B?NFhIdkpxeG02dng2VkJTSUM2RTlTNlRDSDdLUGgxb0x0cmZ1Q2Qxc0V1TUNM?=
 =?utf-8?B?bGdlN2ZGWWNZbmhhdXE2aWJjSzhUbjdqTWIrQU9HU1h6VHJKb0x5R0F5OFRM?=
 =?utf-8?B?VUZqbGdjYU0yMUZJdmVrYmF1Vm1VeGxHZ2JvSnd5a0FRajJPVEhMNHRiRFZW?=
 =?utf-8?B?QUp5bnB6Y25LYlN4OEN4K3JpYnFaR0dTM1lwaVNPZmduMU13VUo4VmduU01p?=
 =?utf-8?B?RHM5Z1pRNmRWaVB5M1JyQTgwK0NWd1d5MVJ5MjJzWElSK0Yrc3pLTnZEVWVm?=
 =?utf-8?B?aGkzWk5yRkhNdnRGMlpyN1BlSW0xN090cS91QWoreXl5UzVUSEtkOEViT3FS?=
 =?utf-8?B?ZHhxM05IazB5TjNYcktaUkNhT3FnNGpZYnlnUGIzTDhWaXU4cFdKOTh4bmtu?=
 =?utf-8?B?VjZkbzVBTHZJRlgxTkFNUng5Z2MxcFFVRkN0UUFBamhCaU5LRXlZMXh6UFVU?=
 =?utf-8?Q?eXI5e0LSjVvmPS7coNHsd+/EoN1/ZdxG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3NNemhBVVZ4bXJQQThKYmwya1NNQk5uS1ZHWDJseVZIY0VNMzBSTmRBU215?=
 =?utf-8?B?RVJaVEZxWVRPOTRua2l5VTdLK1MzOGlVR3l0N1diay9xYmFJM3BtOGFxYnFF?=
 =?utf-8?B?UzlCRzMzY2JRLzc0SGxNKzBnVGpuWVlUODdZbURwRVUxMXlCSEhQY2pzUFFW?=
 =?utf-8?B?dTd5Z2hMQ0ZXMnBmRWFkQ2tkYmlvejQyT1A4OW16Q2FsWEd1RzdUYjJ2MTlL?=
 =?utf-8?B?Y3B3Z3dUTUFyY2F0dzV6bXpXVXJwcXFSRjNCSlU4R1YxR291bjRDbWZZbGFa?=
 =?utf-8?B?TVE5TkVBMUpIeXhxcEJmOW1jcUFmL2Z0UG9mamV5NHYraDF6bjA4cWtjc2xN?=
 =?utf-8?B?OEFZZ1pLTHg0NVBMS0h0cGsrTHV3UXMrM1JxQlJmU1JLVlRxelMwMWVyRW9Z?=
 =?utf-8?B?d0FXaXEzNytRY1k5UHhyWHpNMnFrVENtVnp3aC9MTjROTmU3NUE4eU9lY0ZD?=
 =?utf-8?B?NzRpeVhjYitDVVdNWjlmVURyK0FOTGwzMFdQd1NkUnhucHQwM3BhYkNZdm9T?=
 =?utf-8?B?eGZqVFpTMnpIc3VwdlNydU5KTnNVMnFVZTVsZlZ1VENyLy8zZW9hVUNrU3hQ?=
 =?utf-8?B?Z1RiMjg1MnBOaStnQjhlcFFBajhJRUoySFRqVWpWN1BqK3V0eUpoSFVjVlpr?=
 =?utf-8?B?OFRkQ3V3aU1oVURYMnVTY3ZyQ1hqNWlvOVl6aHFvL0xMMWRqTkdaaE9NVklj?=
 =?utf-8?B?UXNSY3EwOE5LcWpjY1BleDRjVHZrV0pnQjcvdXBPbVR3NHFTSWcvRDNtVi9h?=
 =?utf-8?B?Q0lyTXNkd2xZQktlWjNSWE1qWHBEb1hlNGpSRDVnN2V2Ykp3eGxCT2ZvZEFv?=
 =?utf-8?B?RXhVRGNDMndFSitTaVFmOFhkM0ExbDR1U01samFlaDUrV211OGJDMzE2SU9C?=
 =?utf-8?B?dEdJVzZ1bHkzU3gzcFhpZGo3TkhiMHpyRFRiUGZNUDNxdFFGcmkxd2k3bVZY?=
 =?utf-8?B?aU4zL0NyZ2g2UXAra0xGYUZodjhoRlRQVEl0NjFoZWhPMStVVVFUVHFlR2Vv?=
 =?utf-8?B?SGNKemlQdnk3MjFhM08reTBUZWhXNzhqVkpXYUI3azVnL2ExejNiaGM3ZFRp?=
 =?utf-8?B?ME1zWEZBVW5sV3RocjI1SEVrMjBkekszekxPU1BnQmo5Q1VyMDdlbzJVUFBv?=
 =?utf-8?B?TExQSU44VUZLRTBuSzFVRFk2SFZ4Ulc0clZxdG9RVmlCY3hST1hGcXh1WkIz?=
 =?utf-8?B?NFdScGY5a2tmcXAxM2JQakpoNG0ydnFJZjhOcmtTU2poaGR6N050alFPRW1q?=
 =?utf-8?B?RjRaaDdxZ3JkY2pzdzVPcXpzcmZuZnpWUVdLUENJVlVSdzZYMkdPMnZjdWNq?=
 =?utf-8?B?ZjdzbGpkMGNYZ1JoSGJjSnFrQnc3Y0dMak8zSm4ydUF1dVhkRjVscXBHU1U2?=
 =?utf-8?B?MEp5N1QwdG56SEtFVWY4bHRDNkF1emJ4aEsvZTkxdVhiWjlmbnpJcUhMcnlH?=
 =?utf-8?B?ZUI5N1Yya0JYNlA0UVpqbVd4K2VNL1dmNmZjSnhTeDBsNWNvMURLTTBvRGty?=
 =?utf-8?B?QUFUWEVOQWpZcGE3U3lJYTFuOGk2RmdVMmxkbno5U0dYZGhHUVo5cjFNSDQ2?=
 =?utf-8?B?MVNDa21nTGdydnpEWlRGSCtGTnpLVHM5L1V5dmJQUE8xVEZKaklrS0wvblh6?=
 =?utf-8?B?OHpGUjYwZkxIT2dkNFZJbnNIQTkrN1NXTVkxYjhKSDRhaW8yNlpma0pvNjdN?=
 =?utf-8?B?WWdWbGYzT083KzZvM1JzKzJhaXFjNy83WTZocnRGN3ZOclRqUWl0eFlFMk1a?=
 =?utf-8?B?QVlMc2ZRNDF3Wm9LUTBJUXRBZ0lMQmNUTzIrZlp6ejlIR2YwZ3p4U2FPRmti?=
 =?utf-8?B?bjZrMkpDLzRBRWhqY2lsS0xnRklBeE5tN3RVL2dTWE0zN2ppK2FnVDBpUUxO?=
 =?utf-8?B?YWYvdlN3dHlzcmgrMDh0Y2pVRXlINjh5aWRscjErUGhuZnJENmVsNjhRRUtJ?=
 =?utf-8?B?VWtVR2VYWTY0VFM1OTFiTDBvVVlHTnMwTm4raURPTzJ1Wm9paGpEbEVYSHg5?=
 =?utf-8?B?VmNwRDJCZEN0Y3N2Z3l6ZVdhL29UWTN6VGNyNmFWcWFxR1lySHZTYkVkSHl2?=
 =?utf-8?B?cTJmc2ZTZjJpNGpxMnFFOThITUsxMlhydHBScWpOZ0xxekpESXFHT001ZDZJ?=
 =?utf-8?B?SUExU1d6b0VnVXZseDJHNUxneFdGeWxFbGJkMlk2bHRaOUl2OVI2SFd4YmMw?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yp+v3vM0mtKwMlFajZNs908Oqim3TIFzCZzd2qDiG8n5dS7mfjucI4VlcowhfUo4H5dqsGhXOHaYEadJJUzophV8VkaR/3Zl9Mxjq1fT20obvDqa3LFr10i3XKGI5g0HyS6StWEvY5Be+q5C+08O3YX2xwdMBkzv5SS6HSnem2meshvom0HaNUDW3pbRFjv/L76dehYfYkJ8gGb0BrECIJM9FuTRDiwgvnNbKNsG62fHyn6cLXMC9NEwvfOAKAMIvThXmO/evs2riQe/F/CR5GF+Hj5v2SUdfhTAMBJ8NGVO5EgfaR9a+ErX9oO9XMxRykqA2vQHZIooJcmjmI214fREbMSY52Nw+gyvNHFzA8eoln5wMqqnF730K4I4eKc7g4CTvae1skshcTkwfF/YnTh6H5VncTvtUuwW8XCUSAhaDuxD+h5rLdBMJoin2sQkIoDqyl+LJ/T39KZ7kniyiBswF+Vd/1YLdsu124F90K8JRWRiH5RbKmbzGgjN8l59UG33V1BhYUW37yrLJhvPxELuy1A4Pj7pq5boQiMHYsCY2umPBml2T7LuASzzHT3N0wo0zpTQKDC/z40tKQBNU5o6VhxQUBnKlaPEjIU838M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1246ba-0016-4a5b-3a57-08de3291c568
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 17:31:19.8643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18fOKi35lfIMrVwO2M1ije2xJ6VMLIkvmQoWFJuUX4emlv42Fe56svCdVTSvGY7rwLswHBjgLacBOcMupSnI8Z1Vv1qMLHhgYfWWOxF0Tlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030138
X-Proofpoint-GUID: NPmzfyJho2sJN4Q-l2_DcUwr9X2g2n_X
X-Proofpoint-ORIG-GUID: NPmzfyJho2sJN4Q-l2_DcUwr9X2g2n_X
X-Authority-Analysis: v=2.4 cv=SbX6t/Ru c=1 sm=1 tr=0 ts=693073ec b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XijJ0rKuI5-6PQn_0NcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDEzOCBTYWx0ZWRfX3kOMLT3wEAYX
 F42Ct0QEOU2+cVS3lFxD263bBVgg42911O/mM1Mp+yxhm+9lJXI5fTM6/utGMK6e3OOXPENZ7DH
 heizHOfrNCfpmybHMVxIm1C1D16f656KpZUC/oW/SIBTcxNdBV3TFmvxt8Qv5/6J/+l+rPZKDin
 PHisI0bZmC5e6pum3PmLfJm0phsbKGfzxVrB/VfyylfjL7xtOC1mIowz5TwfbztnG3yZydBTixT
 iEZSyFdAJcRwt5FUxVQha4euvOm22y8Zoc3up9d0f+jBXf0vxZ48YJ53Dc+0hP5q9W3rpci6b5h
 f7oSIW6NG8ccHUz4IakFNUUeCrrthWTuoW1tf7zJan5sZHFXSEUE2xcYNqUaiIPx2C/U0c6bCpm
 +WzI96dmsgJHxTB1gcJu8phO+hJuXw==

Hi,

I’m reporting a performance regression of up to 6% sequential I/O
vdbench regression observed on 6.12.y kernel.
While running performance benchmarks on v6.12.60 kernel the sequential 
I/O vdbench metrics are showing a 5-6% performance regression when 
compared to v6.12.48

Bisect root cause commit
========================
- commit b39b62075ab4 ("cpuidle: menu: Remove iowait influence")

Things work fine again when the previously removed 
performance-multiplier code is added back.

Test details
============
The system is connected to a number of disks in disk array using 
multipathing and directio configuration in the vdbench profile.

wd=wd1,sd=sd*,rdpct=0,seekpct=sequential,xfersize=128k
rd=128k64T,wd=wd1,iorate=max,elapsed=600,interval=1,warmup=300,threads=64


Thanks,
Alok

