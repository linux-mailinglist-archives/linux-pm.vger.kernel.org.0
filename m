Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8D054DCC6
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jun 2022 10:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346235AbiFPIXt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jun 2022 04:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346665AbiFPIXp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jun 2022 04:23:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1715B2458D
        for <linux-pm@vger.kernel.org>; Thu, 16 Jun 2022 01:23:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEWCjyFY6yfMy7CxaVpiNlXWgFB+4LTYHbvgUKPHNQlbcWPLLDn/YV3WfDRjAOjS5baynjQBFjbDPqg9t05SbAOBdInVFh/O7eCs/pguNqlLDY9dnBJgzVzgNeR2nQp+zzIy7Sq+5U6xS22yqVw2TwRi0y3mpMdBxHtWRZEy1C1uLjohXXT6Vmevz36dTwjY2HlSuGI4fXaPKP0XDVOf+blli9nAJDgWblKgViDS1HUverFpHDxzFmwGTie/HdJPVF+WCb8ytnE8pIvVT/tPZrhxV7qm+2ASP2bSO1mHdR1N4Afc3dXQpBmjb0IUOyCFKiktjJ3mMYVNnKLz1mpdig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o10yVtfVZncFl0c6v/v1H/LL1qgqeqm3rJawohMORaY=;
 b=lZ/5Q5t4QaMx3NwoKvtlsi+me5d4mhkojmCULD4vPpkSH10HQQmfzbWrOMI/yDQW9CDUmI4iTeH/QCq08NvHmmX0ebwehQkwEXVoyoE0z79gET+q+AEa7uZljpzlfMZnXftZJCAB/zWkShVZ1GLqEA2Ft5WOpD2D9S6PvqajM4dq9Es6GOkLckfb1Z4G0E3hlkkjg0S5wFLwK29YWzsDnMyIP/fhwgAVJNvncnabd/xHioiExFf/bOEfDD6SXnMEHdt1TkucgJkLgxrFQVNDzwzqhnVsGP5EpxW12C6mV6gk+nH8BxB0B3VUPz1jp7OByOhTAZ3JeCXNxqpbuhe9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o10yVtfVZncFl0c6v/v1H/LL1qgqeqm3rJawohMORaY=;
 b=mhCtLKyKe3wHV50w3nTp2+sG5T5OnogYLKgHu5qnm5Bsahfk/EokNo27Sr5xBJuAPoX6ePp4bj9HLCSaM2vhzuOaR88f+g4AjP8yy2xkl5LSBoTHqyDxxbc6oY5Md9bFjs3ef9LelSqRqimJ4zJRkdIg2q9cfPMiv8G3AJ3aG4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2506.namprd12.prod.outlook.com (2603:10b6:907:7::12)
 by BN6PR12MB1684.namprd12.prod.outlook.com (2603:10b6:405:6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 08:23:42 +0000
Received: from MW2PR12MB2506.namprd12.prod.outlook.com
 ([fe80::7567:d120:4673:e57d]) by MW2PR12MB2506.namprd12.prod.outlook.com
 ([fe80::7567:d120:4673:e57d%5]) with mapi id 15.20.5332.020; Thu, 16 Jun 2022
 08:23:41 +0000
Date:   Thu, 16 Jun 2022 16:23:19 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Liang, Richard qi" <Richardqi.Liang@amd.com>
Subject: Re: [PATCH] cpufreq: amd-pstate: Add resume callback for amd-pstate
Message-ID: <YqrodzDbNZkGZVlX@amd.com>
References: <20220615084526.54685-1-Jinzhou.Su@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615084526.54685-1-Jinzhou.Su@amd.com>
X-ClientProxiedBy: SGXP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::20)
 To MW2PR12MB2506.namprd12.prod.outlook.com (2603:10b6:907:7::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 538cab9e-b22d-4320-78fb-08da4f718568
X-MS-TrafficTypeDiagnostic: BN6PR12MB1684:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB16840F7C15D670C937CCD295ECAC9@BN6PR12MB1684.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lHIW262LZt9B+NnyR4Z8AQdeETmW1c15ko1vjuYhWMSdCU5E0dqG5gSOYKXz5c9cKevvlYTOIUxfemXZbtASntZ3EOg1aK5Ft1h5Fibfvkd+yuc8CnIErOsrzhqHw8gyD+svcdio9mUO9leaa7kI/bsPQPizaKBZT6azPdvvBuDedFrjZ1+bj+FiOEHJ2wtA59ye4tVmlGRo5YoYnhKVoWGozo9hxodHKw14U42vMgUn0yAcTyG81B3b8yCwS3/3Fwk6txWUb1zZ5SqAq3yaJwRl+bbOT9aB8Yeye905Z0xmiPuUfsWM1iFVgxiLQ8Z4LHEtfxkqE7T5pWCwYGe3l3HgQ5zbOqlR2ShBJv9IAGQtGyij8OdIsyCknY3vpuaNw72iHvZ1g2cawLsSbriBgz/s6tXv7qXqZ/R3yWx9iqKNcPZdwP5pu5msfIIp5L1q5JBfUv87e1uT69c/THtqHoXyJNJQtVmULghworfM+VqeoB9GAuqJUXp6PisImQHIK752KkimndjwXpiskLTz0SxFCt4l0IVbh41uPUIbAwYwRs66ubLuUbJJZerBifbgL6Hgx76tgxOo1DodkdXm6ORFl2zq4XKCSDQumnrjMl2zrTI1/1XWjcX3A9mVw/gxtct6Mqm/WoS2NIGpSqlZ8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6666004)(186003)(2616005)(26005)(66946007)(86362001)(6506007)(6512007)(38100700002)(83380400001)(5660300002)(6486002)(8936002)(6862004)(8676002)(4326008)(36756003)(54906003)(2906002)(6636002)(316002)(37006003)(508600001)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p48S+Tlz1XJZmdesqSkJD/3vUA9EyIz+QRDDaIjmHfc7PZjjzCBqetEXkmpK?=
 =?us-ascii?Q?/KB/UPQekR4u4T/1hVPaoCL66xygLV2dVQwUoG5sM9vGLqgWRYHK7uXwpVGb?=
 =?us-ascii?Q?t/QZVT7yBeI6h+UsHnYPTDwiCbq+45B9QEDLbkczttKtG0mu3pQRzeMxExqh?=
 =?us-ascii?Q?/P2sN5+ck47iGoQKeFJfqv+MnE23+41Y6+RqIQf+THKudRdi5p5AIgXgIP75?=
 =?us-ascii?Q?IyqpPNWpE5GFwPlux1psFvRX1kCtw+ofCgQKQXRVsrsLfrosFelkGHtTbOzi?=
 =?us-ascii?Q?MdRnO/phSp0IUSGEmt71o+JzNNzqVvb622z26EGz2E6cuy5j0VVolMVW2ZyR?=
 =?us-ascii?Q?v9TSeS5Igo5iGZb/4wPV6+sqrSEIsru2cZ3ABzGwtj/xSX0vACJjhPrLrh07?=
 =?us-ascii?Q?DYLVIO4FMVgore2/XGcldTMmDp6mbmhjYcmgFHzHlUp7n9tukOyuuY4yOBGJ?=
 =?us-ascii?Q?6BM9qtO3wblnfI30kkyRFkw4aJ8LVLIP7Kx1EYtyiAbiHyu/ja5c0GIg2bYT?=
 =?us-ascii?Q?BFWH4/N0/zwlp5py/yR2WhqfNKQtDBbrfmxgc7QWRyaWC9AxWUuO5M6+XOQ2?=
 =?us-ascii?Q?mPU/eutn/L58gJgqdHySHkllAVD833jDdFEJ/3vT5uOyA31FpEmfuxQBL7K5?=
 =?us-ascii?Q?4vvP2vcjVDD0oR6wuXoymmZLCdWQ/vb4HPxsJVjHs7BluSUVuftH/hE8CWpQ?=
 =?us-ascii?Q?2FvFJBLi9sT7nizkq+kuwr6nTfgkk6zuFCSvyn4uJx+PWf+LDK9OMfX4WaL5?=
 =?us-ascii?Q?n15br/2BrYHaPmOzH3CXQDCmNfF1MKOMzVwj6tczvUVGFtg507uO52RqWUlm?=
 =?us-ascii?Q?xHM+1SWkOe2CkQ9/8jI76nqkaa3FqKnZCk9A39Ztsv7AZLXd4vOATDylHDCk?=
 =?us-ascii?Q?v8NEY3E3GVhBTHmZPqasE5tMVOhrWG82rYmo6bVDIIzbxpGUZ+V5n/rMCg7v?=
 =?us-ascii?Q?HRqtZS41HuUKvljtxLEF6QXIJwLPozSm8BZtY1lQ+YbMEGwaIRz0yZXA7Avf?=
 =?us-ascii?Q?llVIBVmG9i6mK+2z9fJFzAW2Axaiph6VTlUnPGmyywWgqgTN6+mWliKtbv+W?=
 =?us-ascii?Q?G2BnHP4ct2cFxVqtjcRx8PxDN6l8WhJNVUKZiJE6U+vLh2i3cJ+lY4EGY4/9?=
 =?us-ascii?Q?nWlQLYMky1riqjnakYSo0RjepAcIVwU5OalCynu5/34EBm/5tJ7OSf1M3t/W?=
 =?us-ascii?Q?QLSkuwoHXfJimAObLu34BGh2ITa9z0bRSiwL4666HzpZk6vHpx8ZUxoGi9MW?=
 =?us-ascii?Q?dANDuJ8RaLOojcSTk7tDvsDAiZBj4RDylZpTnGB23R6/NUiR+wq9Ey+eoEkz?=
 =?us-ascii?Q?cTGhaf8Lhh3fN6uPOHLrQwKcEjOVV9UUTVCdGEbGOjXDpTfCwgrKZ+q1FfzZ?=
 =?us-ascii?Q?KlgtkOwOcQodoG7Gytfj/qyVaUdG1ZHhbGmezL6ALZ1RoU45FQ75ethLCwXJ?=
 =?us-ascii?Q?5kii301H78oSJZP7QBNvD0PTl0VMtISg5RN8H35aV01QUOFjG9jYVa06KJ5L?=
 =?us-ascii?Q?6DeZnThajcP9GG2cHuO1gPNowh8aLbTvrFrp7qwYBS7yKAxEejuW1Y9/xsYb?=
 =?us-ascii?Q?5hVbDLokcRj0iHNwgYXaiqCyZTxQYuPT1ynPEvzwmGmqnayrQCf9Y3F8vPAO?=
 =?us-ascii?Q?TSYTWUqo/KD3NTls42D0tIrGDTnpZWRxYOqfHpjI/vtNZ/b8CkL2eBz/3Okr?=
 =?us-ascii?Q?EGrbx+3w8aFGsm2w5V6hUOPmv9BDaGWVWNfaZl5cDJOBV6F8OVrGdCdbrZfU?=
 =?us-ascii?Q?tWZi8FY+aQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538cab9e-b22d-4320-78fb-08da4f718568
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 08:23:41.6649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMa7FQeETKUwqy88VJJ5Dh1VgTkHkF0WK7tCJulFfqGQghesZRadgSRyrb5MWS8hxlJ8mWNef7mfOoAdY54l5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1684
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 15, 2022 at 04:45:26PM +0800, Su, Jinzhou (Joe) wrote:
> When system resumes from S3, the CPPC enable register will be
> cleared and reset to 0. So set this bit to enable CPPC
> interface by writing 1 to this register.
> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 7be38bc6a673..e60dd51264a7 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -566,6 +566,17 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> +static int amd_pstate_cpu_resume(struct cpufreq_policy *policy)
> +{
> +	int ret;
> +
> +	ret = amd_pstate_enable(true);
> +	if (ret)
> +		pr_err("failed to enable amd-pstate during resume, return %d\n", ret);
> +
> +	return ret;
> +}

It's a nice catch, Joe. We should implement the suspend callback as well
which is pairing with the resume.

And please CC stable mailing list stable@vger.kernel.org, because it's the
fix for amd-pstate restore in S3.

Thanks,
Ray

> +
>  /* Sysfs attributes */
>  
>  /*
> @@ -636,6 +647,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.target		= amd_pstate_target,
>  	.init		= amd_pstate_cpu_init,
>  	.exit		= amd_pstate_cpu_exit,
> +	.resume		= amd_pstate_cpu_resume,
>  	.set_boost	= amd_pstate_set_boost,
>  	.name		= "amd-pstate",
>  	.attr           = amd_pstate_attr,
> -- 
> 2.32.0
> 
