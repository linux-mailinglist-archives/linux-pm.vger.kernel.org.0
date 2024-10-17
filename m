Return-Path: <linux-pm+bounces-15838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED49A9A1A73
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 08:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C46A1F23868
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 06:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0649176FCE;
	Thu, 17 Oct 2024 06:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wxuV1ItE"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726B979FD;
	Thu, 17 Oct 2024 06:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729145239; cv=fail; b=LIG+K0qtjgZKvCrGSqUCZbDVRB3Kbjhh5fienY35n2VLKggM6L7FTkPsnjSbg7ut9SuE/4aV9YIb1Min3Z0UPRAT+bwINRGTUmbbTqpx5YZSVozazOGuPrk++vLpl4U+yxECpFq0zMpMF8HSa/hz/grtz1kHbsD9Kpkqicq0hQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729145239; c=relaxed/simple;
	bh=zU0r5Z5NMHapE/CANgKTZPqkGlSZHrfOu43PuBGgs9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d/sEWjXTWOgdcJVhBjBi4MmqW245IKoKxODQ6MZqWgr9jFh0IMPfXQlhZ0LyQhk6YRcu1BorOagAGJOD96FUwFC3cHzFNsAGSydA/d5mHFau1iWgAMlf7zPKg1INXPC0MlJg+yAZPwPvYBB2hn+ojcTdIhJhw0TipAYSmhlTUXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wxuV1ItE; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhOXynmVFHfpwSx1uJQsbiTqccdq5ScfrJtFNql8FJcOoOk1iSPJPIKCihxMk+fwDdF5hd0rmn3HR+kdV12akiQy0Uc7lDDlC3WWGznJyC20G6lVg62ug1+tNrKTbYmnC7OKjkAqPBMmPWV39UIpG2IWZ3+5bDZTgoRerkiPIrWvCqRFuPC/q/jkcLQXRcrIvGvBl+8uD7FYKZZhNvjVr34NXbtTXLUsv4LdqJrKSSYfIBQ7OY/IpH2Tu8eWJK64qMa7vrANjd+v7CjW5oL93W8DoU647VUDltfuF4zdNpsHQMbnbGs4LwiKvk2EL+ggnlEDmn1CCtsR9HBiYMkIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ak7waXA82QESIIPvIhehZX44Wft5xmsmXAM1jAPj6Is=;
 b=Yd1PKOZJQxsGOQUO+fdRS1Zu+ReX7N7OhrS/KEvvmN8jav1qCLy8ZAVAf2raW2JuXDwcA/LwCZQreRqccrOtesn6NzFq/fqOSj4lktPFjsIILrbUZZtgLgsU8+QLZzzz/ZpnCZw6CV5M2UN9ApKBlNcRHjq1osvuiAVEH9L1akpFIQ7oWug3q/7kwexC9g8UqgDJLbzt2BM+awz4RPtsBNd2UlvSdbjI65i/Ec04dp4HmB7fd2TYeBFofBlYk+jOu8iDep/jAfLgMaxVXcJRWPGLGbpPlFXcAetq1VA3OXJNTH2wIyFSB4WwJOoVed9yN/7z6dXQBLPU/WtTBnPxJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ak7waXA82QESIIPvIhehZX44Wft5xmsmXAM1jAPj6Is=;
 b=wxuV1ItEb6af5JhZy3XmFe1YJACzHUBKreyftiQAfg7UbnLcY/QlWXNgup4ibpSk/WI/wsP1GmrUhl2Qa2UjOkvOyDfcC64x+pOm2fsh988Y8NYdLo/aJ9DL++fjVvJbNxxJzdWzz93Zi4kSrllLO9DYBVAxbnL05Dxxpb7/bV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.19; Thu, 17 Oct 2024 06:07:13 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%5]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 06:07:13 +0000
Date: Thu, 17 Oct 2024 11:37:04 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	x86@kernel.org, Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v3 05/14] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
Message-ID: <ZxCpiMMm37Snt736@BLRRASHENOY1.amd.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
 <20241015213645.1476-6-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015213645.1476-6-mario.limonciello@amd.com>
X-ClientProxiedBy: PN3PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::15) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: e39974f5-c0ab-46bc-bf67-08dcee71f1ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r7S7PdsAe8n+SOgqU7Ea+juLGpLZ4RGjiSf5Tz0fzodaVdUj7ACLnDKEHJ0c?=
 =?us-ascii?Q?xRZkybhWRpe7Yx2ycP1n2aq9CQbgXgUonc2Tx9leZEx26WkLxuUaR+ObrTnq?=
 =?us-ascii?Q?iSwwGaTCsLysyAem5mWZpm/5ZGUVNPxvCq0SVHzDRmSODVqr4RmrBC+OneVe?=
 =?us-ascii?Q?1sctmaEz73H1zMqZHtr8nDH/up4myvionMTHaHmnn5S2i41XEPutzEzOBBrT?=
 =?us-ascii?Q?k0Jy9J4HD7glXrOcbCNIkhSdjZSC7RxtZnqZHiWFplN0rKL6ECp18vZ1Mom/?=
 =?us-ascii?Q?jhL2iRy+t+79AgE0rPtrw/oAt43sRncXWS9F9hIzRJydTlepee+36O+eem3C?=
 =?us-ascii?Q?Gcc/m5pa4FRbjhNrkdJUjjFVCN2vcvLED6plzYu0xQ6xuiJfE8m6/l/qf8zt?=
 =?us-ascii?Q?X2bi/IXwqFKJElLPiqMbRex6QF+nBWd+ZgpxvK+6RB+hUnBaWI9oXvvT4vN8?=
 =?us-ascii?Q?tZRrxJhp4JtVBJrTOYJr2oNJRfIk7oyyqoInBUNvPFLuF39qxIGcyudKLBoR?=
 =?us-ascii?Q?/qr36YR8V0lL1UhK4v7hCi1QRZjd4dx9Mb9wtdB8KE+WeEjLiWD0zD0987sr?=
 =?us-ascii?Q?N/RXE05+BaAuRvqGgWGSTBYGSA5NAG7aP/IeqgEw0A1ADZKOOe3iPAfmrD0j?=
 =?us-ascii?Q?yzVX41+h1El9bZ6aiiGurbQzgVBy63mcgipJ40xVAXUAjVuIgsf48mqCbkIl?=
 =?us-ascii?Q?PEU5NfkZKtfpN/pKjjKgHsZV5eHG00HET96YHWtLdn/GVcUVG59O4jQLUpZ3?=
 =?us-ascii?Q?Jc05pp29lhQrmz/9Gei76UBRM3HGgTUd3Kf5fQW/fpxfttjxx5AKZ8g0Mw4w?=
 =?us-ascii?Q?xxaFJWL/JxCGxKAvKuHc2Fgb9KU0PVd1iWRU0zcj54M78fXX7zRKwOpNaJdr?=
 =?us-ascii?Q?kmU7tN2b3CYZjEwoMPg/Z13y4xkvatgQg3PHOdAzNXb2/+7FUyIcelw0LBaR?=
 =?us-ascii?Q?PQJ1FDyeOinTaNgmhpU7yDFo6JO0Pb7QzMaxlQVDidPyprzwCb3PuRn5Ltm6?=
 =?us-ascii?Q?R5P+surbBwSBg+M73Y/Wg/0ipW03xJ05K3zFgW+lPKa8Dl4/q2tuT8ALhb30?=
 =?us-ascii?Q?BeM5wK828KYAN6y763KRAqjqyG6OQFwsAzPRtodk1xjSi73rI1Kmr7dc/+aE?=
 =?us-ascii?Q?EmTLgIDnwhL93EI6Tmtvx3/BU3mv2u+knBPfiFV5MSKBetS/tAQpGpCsI2AA?=
 =?us-ascii?Q?B99JN0vCoJWcgRdO/YpXmi0ByNHwOtLpyEapUJozl9eDB6B1XAYTUVF6gSrh?=
 =?us-ascii?Q?CRHFW/qn8EGVy69GArvPzBDuBg4Cs8+EnqQi0KFnC9rEhNa5I70osgC0qF2f?=
 =?us-ascii?Q?9eowOYNQ4V8jAgYuVWUfCpGu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oa6RYIRVhr6sxSp/g9pxytZnZSfqA6bskK3YQ6e6X4ScvSGzdMMHilMHb1fj?=
 =?us-ascii?Q?2G2k6vs1SgYAwmFnPo3xuUsE/K5ZgFeU+E1mLCacL0WZlMjkLxvZrsA+E768?=
 =?us-ascii?Q?SoYT+s9Xn+bYmyh0R+8z0q014JcCAdtmB7TnT4KWFHOfcwpu5faHtHfcngUb?=
 =?us-ascii?Q?WMZgQE8RBBK3Bif5O7+O1+XvFkOJzfCwznl6oGzKLXR0Q74txScv8h3cUBLF?=
 =?us-ascii?Q?ZbTaVmC5NNunf/VGAr58RtsAJCkJx/fBgHAxAtPS7q+uLaMeSW4ib65RLNZO?=
 =?us-ascii?Q?fm0s7COcyUs0Q2614Fd4/ezwTY8/UVySozk2c8Lgp/9hvtWLGD+8bHJDyiPV?=
 =?us-ascii?Q?hVVfNrZrca8Skbl9XiUE8ARdpFjgMQtF2Mi1rIklzYcjFtrq5V2Tx5KsJBAI?=
 =?us-ascii?Q?ovJZ+yiQHKk3uKy6oIsUzCZ7XABpQ6lMkZDE/UyEnlyLOs8LldPaJ+/v36F0?=
 =?us-ascii?Q?YE/iWr45BxC5QwDGo9mYnvZ4k3svOx8iaQ6Ti9xxSZrqZiatoJdMV3rVcinz?=
 =?us-ascii?Q?J7a5feajQj5yB8ex9uGR9tRjdH7PwSVBiqZb528qPamNLl3sfRtUaTh6dCuU?=
 =?us-ascii?Q?OFdfR3ohg9Zf5o5QYWpanVV4eVTN06UElAGC4cPaIfeRqqJYc50GaQ0mYkmN?=
 =?us-ascii?Q?VvYIf2DjxXj/Ssk48bgKNAeXeF6p+WCMJORVbOVg3xRM2VNcP8GIpoHDdXxi?=
 =?us-ascii?Q?8HfxGuL4eZ+NkfO/smkseeh3y9cTYtGwkSUVi6fz+soWCK0Flpnj3onlDl38?=
 =?us-ascii?Q?0j7v2OpV9s31oihghWaH96rPJxjye5No62HQdTpOhazPu5Neh8z56py3c4GS?=
 =?us-ascii?Q?sgemxz1aEiHNZ1EpPRuzU88uucRfQxpB6PWykOhbEEKRq2V59wwyq+iMPMih?=
 =?us-ascii?Q?uSLgrEEQnrbqxcirtBzyaFTyBlMCP8aPaaIlhwo8HpNlqr/ejsRPIWFMQ5Yi?=
 =?us-ascii?Q?88xK+LEs08nzrt+t17mIjEOZqJU2Ow3fF2rDOLQD/43kojxrix+q5FzLJ4Px?=
 =?us-ascii?Q?VfWsyvetKnXjZVMHrb1qG3mi7B0X7Ky0kwTbUy/iEe1L6BSQobLgzYFQRcpV?=
 =?us-ascii?Q?CJzzceQfICHIaVkcu3IRx9msLFUCEvHLgByM6RIsWN+F8MxhsWJFTN812AC0?=
 =?us-ascii?Q?kqPpEcgM7d7ORkoB81bS9gcCvbLPx1Yy2obask1TW/0OaxyylsAmlxJe6iLl?=
 =?us-ascii?Q?oM5TxWicGZzfWXYqf5SoyBxz3d0sgFmfUBTpWaOAa7fxZjdK2J7yORFXdJFb?=
 =?us-ascii?Q?RfBUSX5679z1ISb8c3YiuK6QFaFhMt6U/DARQtKtIhJEojCUcIpJ3a04kinE?=
 =?us-ascii?Q?bCEN70PWJ6cwMQc4BUc+R4JnCfe54+x8F7B1H60GS8Tn107TQhRGXYRUNSKH?=
 =?us-ascii?Q?zqp+K52CxbcKqNiMCB+3tnjXBZZoTucRce0ZK1e80KhJQ3Zvnj6XDJOiMnV7?=
 =?us-ascii?Q?u37onFfCfCtWCoyzD9QXebdV4FoRRfRzoyjqO5rGVlgHPOb/A+Dcn0mofbYq?=
 =?us-ascii?Q?ess+sDlbzn3ex/5oN6Wo8NeW+79HrAbeZMfAT1I5SfHICX4asozco4O9T0wD?=
 =?us-ascii?Q?CkBrsTBGDR3VNNwPi2I/JRaSqJ7bT1O6Qmz+uGB4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39974f5-c0ab-46bc-bf67-08dcee71f1ae
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 06:07:13.4589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxjrr8J03IVNzg+41MQrw6bUp9+pctEmCxtJLCXyB+81YB+4jfrthHCkuPTucKxqMKmGT7OluyVs7GnMm4ca5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446

On Tue, Oct 15, 2024 at 04:36:36PM -0500, Mario Limonciello wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
> provide behavioral classification and a dynamically updated ranking table
> for the scheduler to use when choosing cores for tasks.
> 
> There are two CPU core types defined: `Classic Core` and `Dense Core`.
> "Classic" cores are the standard performance cores, while "Dense" cores
> are optimized for area and efficiency.
> 
> Heterogeneous compute refers to CPU implementations that are comprised
> of more than one architectural class, each with two capabilities. This
> means each CPU reports two separate capabilities: "perf" and "eff".
> 
> Each capability lists all core ranking numbers between 0 and 255, where
> a higher number represents a higher capability.
> 
> Heterogeneous systems can also extend to more than two architectural
> classes.
> 
> The purpose of the scheduling feedback mechanism is to provide information
> to the operating system scheduler in real time, allowing the scheduler to
> direct threads to the optimal core during task scheduling.
> 
> All core ranking data are provided by the BIOS via a shared memory ranking
> table, which the driver reads and uses to update core capabilities to the
> scheduler. When the hardware updates the table, it generates a platform
> interrupt to notify the OS to read the new ranking table.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

This patch looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.


> ---
> v2->v3:
>  * Whitespace (Ilpo)
>  * kmalloc -> kzalloc (Ilpo)
>  * Drop needless include (Ilpo)
>  * Capitalization (Ilpo)
>  * Drop needless comment (Ilpo)
> ---
>  drivers/platform/x86/amd/Kconfig      |   1 +
>  drivers/platform/x86/amd/Makefile     |   1 +
>  drivers/platform/x86/amd/hfi/Kconfig  |  20 +++
>  drivers/platform/x86/amd/hfi/Makefile |   7 ++
>  drivers/platform/x86/amd/hfi/hfi.c    | 168 ++++++++++++++++++++++++++
>  5 files changed, 197 insertions(+)
>  create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
>  create mode 100644 drivers/platform/x86/amd/hfi/Makefile
>  create mode 100644 drivers/platform/x86/amd/hfi/hfi.c
> 
> diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
> index f88682d36447..c3f69dbe3037 100644
> --- a/drivers/platform/x86/amd/Kconfig
> +++ b/drivers/platform/x86/amd/Kconfig
> @@ -5,6 +5,7 @@
>  
>  source "drivers/platform/x86/amd/pmf/Kconfig"
>  source "drivers/platform/x86/amd/pmc/Kconfig"
> +source "drivers/platform/x86/amd/hfi/Kconfig"
>  
>  config AMD_HSMP
>  	tristate "AMD HSMP Driver"
> diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
> index dcec0a46f8af..2676fc81fee5 100644
> --- a/drivers/platform/x86/amd/Makefile
> +++ b/drivers/platform/x86/amd/Makefile
> @@ -9,3 +9,4 @@ amd_hsmp-y			:= hsmp.o
>  obj-$(CONFIG_AMD_HSMP)		+= amd_hsmp.o
>  obj-$(CONFIG_AMD_PMF)		+= pmf/
>  obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
> +obj-$(CONFIG_AMD_HFI)		+= hfi/
> diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
> new file mode 100644
> index 000000000000..08051cd4f74d
> --- /dev/null
> +++ b/drivers/platform/x86/amd/hfi/Kconfig
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# AMD Hardware Feedback Interface Driver
> +#
> +
> +config AMD_HFI
> +	bool "AMD Hetero Core Hardware Feedback Driver"
> +	depends on ACPI
> +	depends on CPU_SUP_AMD
> +	help
> +	 Select this option to enable the AMD Heterogeneous Core Hardware Feedback Interface. If
> +	 selected, hardware provides runtime thread classification guidance to the operating system
> +	 on the performance and energy efficiency capabilities of each heterogeneous CPU core.
> +	 These capabilities may vary due to the inherent differences in the core types and can
> +	 also change as a result of variations in the operating conditions of the system such
> +	 as power and thermal limits. If selected, the kernel relays updates in heterogeneous
> +	 CPUs' capabilities to userspace, allowing for more optimal task scheduling and
> +	 resource allocation, leveraging the diverse set of cores available.
> +
> +
> diff --git a/drivers/platform/x86/amd/hfi/Makefile b/drivers/platform/x86/amd/hfi/Makefile
> new file mode 100644
> index 000000000000..672c6ac106e9
> --- /dev/null
> +++ b/drivers/platform/x86/amd/hfi/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# AMD Hardware Feedback Interface Driver
> +#
> +
> +obj-$(CONFIG_AMD_HFI) += amd_hfi.o
> +amd_hfi-objs := hfi.o
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> new file mode 100644
> index 000000000000..fbbc2c119a64
> --- /dev/null
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * AMD Hardware Feedback Interface Driver
> + *
> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All Rights Reserved.
> + *
> + * Authors: Perry Yuan <Perry.Yuan@amd.com>
> + *          Mario Limonciello <mario.limonciello@amd.com>
> + */
> +
> +#define pr_fmt(fmt)  "amd-hfi: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/gfp.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/smp.h>
> +
> +#define AMD_HFI_DRIVER		"amd_hfi"
> +#define AMD_HETERO_CPUID_27	0x80000027
> +static struct platform_device *device;
> +
> +struct amd_hfi_data {
> +	const char	*name;
> +	struct device	*dev;
> +	struct mutex	lock;
> +};
> +
> +struct amd_hfi_classes {
> +	u32	perf;
> +	u32	eff;
> +};
> +
> +/**
> + * struct amd_hfi_cpuinfo - HFI workload class info per CPU
> + * @cpu:		cpu index
> + * @cpus:		mask of cpus associated with amd_hfi_cpuinfo
> + * @class_index:	workload class ID index
> + * @nr_class:		max number of workload class supported
> + * @amd_hfi_classes:	current cpu workload class ranking data
> + *
> + * Parameters of a logical processor linked with hardware feedback class
> + */
> +struct amd_hfi_cpuinfo {
> +	int		cpu;
> +	cpumask_var_t	cpus;
> +	s16		class_index;
> +	u8		nr_class;
> +	struct amd_hfi_classes	*amd_hfi_classes;
> +};
> +
> +static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
> +
> +static int amd_hfi_alloc_class_data(struct platform_device *pdev)
> +{
> +	struct amd_hfi_cpuinfo *hfi_cpuinfo;
> +	struct device *dev = &pdev->dev;
> +	int idx;
> +	int nr_class_id;
> +
> +	nr_class_id = cpuid_eax(AMD_HETERO_CPUID_27);
> +	if (nr_class_id < 0 || nr_class_id > 255) {
> +		dev_err(dev, "failed to get number of supported classes: %d\n",
> +			nr_class_id);
> +		return -EINVAL;
> +	}
> +
> +	for_each_present_cpu(idx) {
> +		struct amd_hfi_classes *classes;
> +
> +		classes = devm_kzalloc(dev,
> +				       nr_class_id * sizeof(struct amd_hfi_classes),
> +				       GFP_KERNEL);
> +		if (!classes)
> +			return -ENOMEM;
> +		hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, idx);
> +		hfi_cpuinfo->amd_hfi_classes = classes;
> +		hfi_cpuinfo->nr_class = nr_class_id;
> +	}
> +
> +	return 0;
> +}
> +
> +static void amd_hfi_remove(struct platform_device *pdev)
> +{
> +	struct amd_hfi_data *dev = platform_get_drvdata(pdev);
> +
> +	mutex_destroy(&dev->lock);
> +}
> +
> +static const struct acpi_device_id amd_hfi_platform_match[] = {
> +	{ "AMDI0104", 0},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, amd_hfi_platform_match);
> +
> +static int amd_hfi_probe(struct platform_device *pdev)
> +{
> +	struct amd_hfi_data *amd_hfi_data;
> +	int ret;
> +
> +	if (!acpi_match_device(amd_hfi_platform_match, &pdev->dev))
> +		return -ENODEV;
> +
> +	amd_hfi_data = devm_kzalloc(&pdev->dev, sizeof(*amd_hfi_data), GFP_KERNEL);
> +	if (!amd_hfi_data)
> +		return -ENOMEM;
> +
> +	amd_hfi_data->dev = &pdev->dev;
> +	mutex_init(&amd_hfi_data->lock);
> +	platform_set_drvdata(pdev, amd_hfi_data);
> +
> +	ret = amd_hfi_alloc_class_data(pdev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver amd_hfi_driver = {
> +	.driver = {
> +		.name = AMD_HFI_DRIVER,
> +		.owner = THIS_MODULE,
> +		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
> +	},
> +	.probe = amd_hfi_probe,
> +	.remove_new = amd_hfi_remove,
> +};
> +
> +static int __init amd_hfi_init(void)
> +{
> +	int ret;
> +
> +	if (acpi_disabled ||
> +	    !boot_cpu_has(X86_FEATURE_HETERO_CORE_TOPOLOGY) ||
> +	    !boot_cpu_has(X86_FEATURE_WORKLOAD_CLASS))
> +		return -ENODEV;
> +
> +	device = platform_device_register_simple(AMD_HFI_DRIVER, -1, NULL, 0);
> +	if (IS_ERR(device)) {
> +		pr_err("unable to register HFI platform device\n");
> +		return PTR_ERR(device);
> +	}
> +
> +	ret = platform_driver_register(&amd_hfi_driver);
> +	if (ret)
> +		pr_err("failed to register HFI driver\n");
> +
> +	return ret;
> +}
> +
> +static __exit void amd_hfi_exit(void)
> +{
> +	platform_device_unregister(device);
> +	platform_driver_unregister(&amd_hfi_driver);
> +}
> +module_init(amd_hfi_init);
> +module_exit(amd_hfi_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("AMD Hardware Feedback Interface Driver");
> -- 
> 2.43.0
> 

