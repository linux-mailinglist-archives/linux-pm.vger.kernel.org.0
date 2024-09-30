Return-Path: <linux-pm+bounces-14942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F6198A795
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 16:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56C5FB25EBB
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424B91917FB;
	Mon, 30 Sep 2024 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aFh8j6i9"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A29523D2;
	Mon, 30 Sep 2024 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707643; cv=fail; b=AyD35nz30RILpLdpZoP+9gCXu6dyK1ATxl1I83VSISqo+jaUTi5ThFdnCb6Lx/NrDAXYzkTmTs0O9wwiTFEgeEhzRBstm22qS+NDKcijdq3MiIdawELH4kEZerAz2BjmL0vgU3w4c39sF/7nUSR3+cRoCuDbg/S7rJ2AhOM3bOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707643; c=relaxed/simple;
	bh=m4wRmNyxpkvHZ2pNEuzbqqngahfxRIwhHt2/TmdbGb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ns9c0/vTFIqvS3CwmKpMTvOp27MOBkMtV3w+7ydh/oh/wtDgXUHlkjwS3ikcMMXXOinDOUT4WB5wSSox0lVOOcmQU2qB7vugQjC7SAEVMcPMjVL+eJoBjVKf0Zj6DfSxtTFM284AX98cnEPARNmMMh3pVZc5vYpR+o1emy+l2Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aFh8j6i9; arc=fail smtp.client-ip=40.107.100.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2zjFlZxPkuJHJcXSKpVwlKIcg14FnLxNV7/o78baxcNseT1WbMcmBN0y/ZrfLrc586xramXtPzRdT+b+RBpecCKd4rISeD/88u5B46BMiQMiPFOEPKBvChG1+hcJEwmciCSwdDwo1aerYFQG8KRkZkboFm91fTAi2awQETAFjz64ROv48WPUBxJjBmBEuH26n8alyuPuf/e5QTNoqpeRsbJFCPMyn1ymx+yyq1v7MnG17AufQHPflmkDU47zgQD286eJbxr6VwJvuJzUgG8uupAOAiwPsjvx66VI3JG3ukO2jCn07tpO7nftLmNGCaCxEO37S8UCdUU7SjaJyW0zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=an156pF2StyJFOSL4eB+Ckd2bKklyOdlm+ADO76gAlc=;
 b=ZeO6p9BO+DZtTURbmjtu3b3MTw1p7+Xk38WaBw6e6dFyfT4MriuwnwNXMcyEFQdjuASspKmcLh64+3pKVh8WrgX1FIM+BFCxaWllapPfVR1Oz/p2gzSw+rXlC/mIofleENp0e8Vzd5XdiQwv7PxoX+mCH3GAHItyNQLGg9UakucRrQTH2Ysd0SO26Lktt5efdS9Cd32MyWCXCPQTE4ZzzYv4Oz02iXWVzwQTJKRThmJ6E8UtgufODgsCIwOzka2gWreQ8D3Y4HN+BDgSrnibk9ok4ycMJv9MCACb4foTej/9lVgw1qhgeAgWvIwHzRYV+y80qolnfI0YJbGo+bWkmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=an156pF2StyJFOSL4eB+Ckd2bKklyOdlm+ADO76gAlc=;
 b=aFh8j6i9dvF79UWX9YpVn/m1xSBlaSCaq8s9rCr0IXQA4P9KLTIpMoJnUpTywMc/A/TeAe1SZ+7QQ0JiRHe2iq0oG9ty2lKWv0Ww/dWJt1iU0Pd/XFtcjXoIHdhwIa+bwGhdQfVUs6uF0/E8fALxeS5vIFxPmgRcY67TT1cwWLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.26; Mon, 30 Sep 2024 14:47:18 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.8005.026; Mon, 30 Sep 2024
 14:47:18 +0000
Date: Mon, 30 Sep 2024 20:17:08 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Luna Nova <lists@lunnova.dev>
Cc: perry.yuan@amd.com, Xiaojian.Du@amd.com, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [Regression] 6.11.0-rc1: AMD CPU boot with error when CPPC
 feature disabled by BIOS
Message-ID: <Zvq57MVQBM5aMmMY@BLRRASHENOY1.amd.com>
References: <20240730140111.4491-1-00107082@163.com>
 <87zfpxsweb.fsf@BLR-5CG11610CF.amd.com>
 <2f793cc8.a13d.19108df0a58.Coremail.00107082@163.com>
 <87v80jbjpj.fsf@BLR-5CG11610CF.amd.com>
 <df99663b-23bd-43ac-b277-cd6700f16809@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df99663b-23bd-43ac-b277-cd6700f16809@app.fastmail.com>
X-ClientProxiedBy: PN3PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::6) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SJ2PR12MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe29a12-696d-4d4b-573a-08dce15ec803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CP4NuVU0qvXTds3rmsUrti473o+HQk5X+gbxBHZHtvnyuFBNoP3hzpQqiWDX?=
 =?us-ascii?Q?dTQ/5HH8G5nwSXM8FPHBchidZfVtYR0wmpCTrm+ZVKsOv4pSjqSi65CnFc7R?=
 =?us-ascii?Q?7FZjHkSEr7iMMks3H7SgBvlLTO7ueJpwnLV0WCYX+bznptC/jGEp0U2PRbSn?=
 =?us-ascii?Q?45IJucAlj+RB2JTSsWeTnU0Foru6gn39JcGZTdQiBvyrqFVNXB6S+R+ZTO2g?=
 =?us-ascii?Q?BINu26I55G0MMYSdCpZyH+K3c5E8e1lnXGEBrLoo9/vJPSzdTmcqPTDLzDFu?=
 =?us-ascii?Q?mhaKfWwYM0bIioOToZCNxZDqofYF6W4XGt3C5x9cCKbzE9RAUqfRT4oGC4OE?=
 =?us-ascii?Q?6e+2kVcmD8qK9O0KpU3SN+qrYsCc33Ms2yO4jGvIGrE7x5oQsPYF/hg6LpaB?=
 =?us-ascii?Q?Pph1u/aWpUwaMigiiNVlvZUIAPCBn8amaJc0x0bKsoV87vQJZHWXmXRKOJJN?=
 =?us-ascii?Q?c7jtgFoZGTkWVOteF4FR5g1Zs2g0Ss+k78tsTieuvHqALF7nZCmb3Ja6CnQY?=
 =?us-ascii?Q?BRKvhIXhFEEthqT/2Bs7SREuztVaqaYg6Z0e8EqRm7JhqKB6WLOsZ3hA2Koo?=
 =?us-ascii?Q?OHhtwmA+JbWNWWeZ/nkEXVB6/1IOYjEAc/ThRqOunWWn6L2g3OHKooVNNlzz?=
 =?us-ascii?Q?sek4NzKN98RNBknwkY+NzjKi/eDRutBnosVTh0Po+Rlh4QeL7ykRnkzyDqUw?=
 =?us-ascii?Q?l6gAydz/UeVp0cGM0nRHwgoLyihezCoOCa6HipI6F6yGlXQfAAc0lOhzkBOX?=
 =?us-ascii?Q?eLVtId5/FFcZ/HgLJi3mxwhk3uwWJmix1/Q6mn3Dll0Zy7l2ZG8SfX6b3cyc?=
 =?us-ascii?Q?Bd3/eCEokJYE1LDFlJMxqokn6c7LqbxPO5/JiArBif8+76FyB1PsiqN0ffn3?=
 =?us-ascii?Q?d9DHc+GqCVG9X64G+aex2RSQDlq1AF9NoLr6SMgFWaayKTvQ4lBVcDjbNqIv?=
 =?us-ascii?Q?VgBO9fDmqEYSV4DQVZ9K3h1RsKrCYuw0F4OVWcBmUyQyOYVCcUnCqXlK6Og4?=
 =?us-ascii?Q?FIom/6DlvwVVNmKnBmA1OH12/3fkKhNuLBzLlPHlAvz2wbZ51nESkAO/Kp0d?=
 =?us-ascii?Q?DVtnesWNjAJ+LlUSeE5cRKcJ9FMgve4wSzS12fKYpDo9kYKZZzze0wlLhquu?=
 =?us-ascii?Q?dtp1QkYHKWbWb9G9XtETNMczDftJZZWOsQ5yjgYJq7lEZrtq/E0U7LmXAfe/?=
 =?us-ascii?Q?FRu6skYrUb1Xwu1Vyj1FtSFrCexVTYA2NS4O6CNgPaw6dDQKAsR/jyBK2SpR?=
 =?us-ascii?Q?tIU1/3g3cAgG6nnr8EmUBCWk+PkhjazPaDQ6Vjplug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6vuJgLA1/b0g/LqajhPIWinslWbWw0AA6Cv2ebugLVYIAPu+tpRamWCrA2kF?=
 =?us-ascii?Q?xaHjuBVA7+YtBZv85CMJaD0Esw8J9bf62nUmi83e0KPjb9eulNInY2ziJydI?=
 =?us-ascii?Q?Rcz9eiiv/gOGq7aT30tsseYDr4k6BM9i7U/x/QIij3IFtPLwQYQmWs5iLDE0?=
 =?us-ascii?Q?IYkZOcakUD2COUbTbl+ieTaH7Y9Sx7PbD1RpLI2HOs18/ANJIw2qJTfqI6o7?=
 =?us-ascii?Q?ubJ7R7rZREiNUbGa4qZPASoqudBjsFuadEK2DCJxK3RFnl5LKbHeBCcyC36Y?=
 =?us-ascii?Q?bOSgLt60wCFd8vB6riBv7i+baO6UaqlOLBANu8MQAsXA/1jB8p9OL7xdAZT5?=
 =?us-ascii?Q?NP6f/5fXixzxVJT/zleS8IbYu0wuAlac0L+MqNrBuSNFouv8xtXfdMYSIsQx?=
 =?us-ascii?Q?o1vVoT70nj3KnPfZgGd2Hp0pzWN9CzML7VwkB1Qe/agGWLCI4Ed4QI1qKfz4?=
 =?us-ascii?Q?gTH4NHc3qWWw/mvbSQYH5ZMyYXemWiWuBMH0g7as0fyzth3lDiLe9yxi69m/?=
 =?us-ascii?Q?wCqECtOZNtlVZVBbdKsLufHSIMRGD7Wh95ecNV6YnRt2xPSXDlzkLSq5HkbX?=
 =?us-ascii?Q?rT7Y6lab5v5RHpizhjCcmsW7cMDF4ENDnLsaspqR88tb5vyf224zyf8tQ28e?=
 =?us-ascii?Q?bTJ9aBHsstmgD1/3GAzcu44fo2pwOlzs4/Xh4nCXn4p4fv+6LscRTsbBOdSj?=
 =?us-ascii?Q?KBOD+QGivNhH8+h3cokbE27vflPcZ9UIqdc/xVms4IJaCQQhE0bW1G0z+cDc?=
 =?us-ascii?Q?VebUB6owEofGpbS9QQcVl6YI2hJXAmFDEgRO4qZgBB2UGhrba1c7bZAnem/k?=
 =?us-ascii?Q?fWu50sDemqNF/F7HFn7tcHkqm13IZEieny+j7e4CXLuLOg/nN0hns2o0soWa?=
 =?us-ascii?Q?OakLLdu1gO93TLTPRyGC9Ymk6Mwqjz48PJWOpuhXHnwaSKkvAqYvaDZ1yHg8?=
 =?us-ascii?Q?ZHmUuZz79IxLmcbWpzz1hZLdRTiyCPYjoabw4xqpJJPtphttT2y1SFxKCR1S?=
 =?us-ascii?Q?iV15xY7YrVy/ChldPz7x7k9B83b1IHk1b/UUI/Gzd+mY6oiqgfAmQzHEH0Qx?=
 =?us-ascii?Q?vY0Sc2t7Sr7MFHLDOGTe6Y0Wd5SErizP6MDOA4ShVegOQvl3UYkfH3ifs/hW?=
 =?us-ascii?Q?9X7UI74In8J5BOfZ5YSWsSRS3n5664Pu2GlsBM71lufED4+esfN5ofksk0b6?=
 =?us-ascii?Q?BbnFV5QgKZ7P60m0tiiS2jWioBqYvjB5XALs3/fAHcwf8P5O0kmktcPwhvQU?=
 =?us-ascii?Q?2lmpv8+XD9dlbgpfrPGPqFUxjRuFFsSKZD6iFKxe2ZWIuZcSyAD8uX4CsysY?=
 =?us-ascii?Q?5nT9bhi8ZVF9Js6e8k6AmmnpeRSl1+PkKIoIAt00hWuFSwtKgtTl5YJUsRhU?=
 =?us-ascii?Q?VIfuc8B+TJwe5/VZtLxy9C+x+m+N7C//wO1U+D8Cbd7vua6ECI1UYa7hhj5I?=
 =?us-ascii?Q?5wp2YmXgw25MZB/3c0Or0W6ZDzWbmMO9doWUpsI8uvtnjmo89IZp2zqwhgTI?=
 =?us-ascii?Q?1TEHMIiHy8m+GA/boH+VkJqsDjeSMFAJ4qy1g0tYT87uyY18Bnb2+ZnWcTTC?=
 =?us-ascii?Q?yxVq3O5B3fjf6qfwAMhjG2wkH7lyVNXxSUVg3yg2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe29a12-696d-4d4b-573a-08dce15ec803
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 14:47:18.2853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsfpBW40U9eBjS+75dozAaZOGNcciW9itMfGX8AxezepxbLHB1Pj5P/b9L6a8lp604KeyN5mh4BfNucJDwz0RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832

Hello,


On Thu, Sep 26, 2024 at 01:56:21PM -0700, Luna Nova wrote:
> Hi Gautham,
> 
> I'm seeing the same message on a server board with an EPYC Rome 7K62 CPU.
> CPPC is set to enabled in the UEFI firmware settings.
> 
> Kernel: 6.11.0 (6.11.0 #1-NixOS SMP PREEMPT_DYNAMIC Sun Sep 15 14:57:56 UTC 2024 x86_64 GNU/Linux)
> Board: Gigabyte MZ22-G20-00 Rev 1.0 (in a G292-Z20 Rev 100)
> UEFI Firwmare: R23_F01 (2021-09-06, latest available version at time of this message)
> AGESA PI Version 1.0.0.C.

This is old! Can you check with your motherboard manufacturer if they
have a latest version available?





> 
> CONFIG_ACPI_CPPC_LIB=y
> CONFIG_X86_AMD_PSTATE=y
> CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3
> CONFIG_X86_AMD_PSTATE_UT=m
> 
> $ cat /proc/cmdline
> initrd=\EFI\nixos\z16gakzlwypxbjzm5y93x10cjmxjvial-initrd-linux-6.11-initrd.efi init=/nix/store/cqhw9x7w7dc3avwri4i2lk0mgc31arll-nixos-system-tsukiakari-nixos-24.11/init sysrq_always_enabled fsck.mode=force loglevel=4 audit=0 amd_pstate=guided amd_pstate.shared_mem=1 amdgpu.lockup_timeout=10000,10000,10000,10000
> $ sudo dmesg | grep pstate
> amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect

This happens on your platform because the ACPI CPPC version on your
platform is v2 doesn't advertise the nominal_freq and lowest_freq.


> (Repeats for each core)
> amd_pstate: failed to register with return -19

Working as expected!


> stage-1-init: [Thu Sep 26 20:04:53 UTC 2024] loading module amd_pstate_ut...
> amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
> amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
> amd_pstate_ut: 3    amd_pstate_ut_check_perf      success!
> amd_pstate_ut: 4    amd_pstate_ut_check_freq      success!
> 
> It seems odd that amd_pstate fails to load but amd_pstate_ut reports success for all checks.

Hmm.. This is strange. I need to check why this is happening. 

> 
> > it appears that the CPPC version on your platform is v2 which does not
> > advertise the nominal_freq and the lowest_freq. In the absence of these,
> > it is not possible for the amd-pstate driver to infer the
> > min/max_freq. Which is why the driver bails at this later stage.
> 
> > The way around it is to add a quirk for your BIOS as done in this commit
> > from Perry:
> > eb8b6c368202 ("cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities missing")
> 
> Perry's patch you referenced as an example above targets the same 7K62 CPU but requires one specific BIOS version.

Yes, Perry's solution targets a BIOS version as a more recent version
of the BIOS may advertise CPPC v3 which is what the amd-pstate driver
expects.

> Should I submit a patch adding the version on this system to that quirk?

Yes. If your board manufacturer does not have a latest version of the
firmware that advertises CPPC v3 that is..

> 
> I'm confused by the quirk code: it's called "AMD EPYC 7K62" but it matches by BIOS revision and doesn't check the CPU model.


> An earlier version of the quirk included `boot_cpu_data.x86 == 0x17 && boot_cpu_data.x86_model == 0x31` to check the model; it now uses the nominal frequencies for a 7K62 regardless of the CPU model if the BIOS revision matches.

When you boot your system with acpi_cpufreq, what is the P0 Pstate
frequency ? Is it same as the one used in the quirk ?

> 
> Best,
> Luna

--
Thanks and Regards
gautham.

