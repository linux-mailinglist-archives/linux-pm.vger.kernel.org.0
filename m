Return-Path: <linux-pm+bounces-16183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4FE9A991E
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 08:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DBFDB215AB
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 06:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AC613B592;
	Tue, 22 Oct 2024 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nclEtoyw"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9299112CDB6;
	Tue, 22 Oct 2024 06:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729576933; cv=fail; b=iCefolOYhRQ0R6x34/8bV7AiETMSgf7ve4m8GFrchhwKqaLJ6P0l88k6dG55wq1cIcmwbpmQyhWXAdeFITeqpSgp9mSnJnf62THKJeZSpBHvwK0YZeVYdJy0PIdI9/ApwRZhs2rfMVXMsOxzErvOqUkAP9s3Ngm1M8JJWNqCFIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729576933; c=relaxed/simple;
	bh=MMtoKL+DRzXa4oV1DdtmNrUND5m/Olpq2toniV1V9ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KzZZFG/Joa1nlIexkLD1GoGEHAqxOec48GXUDDGg7LlPPTQslx0RHdEj/1tu0+SkHg0TfwTwGTLo4KQ11Ke97TSZ32lZcCNZbv7W6V2i3IJcXwPHsCb3LkNUlGe+9gqT67vNqbokM0rNJcjN5oUidMeEn5P4hZo9Og1Fxc2T65g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nclEtoyw; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDoYFT/OIG1VkQ8WhCNbhkw50wri8z6cF+VvSutFwcA90fZQ/AwqODsm62lPcOqNCkrbKCn/A8wgOBbyVfJemFOYV3fsoMOyar2ByzyJLWAaC+9iZLc8cnKml2mT5tTCeSW9CBt0GlXNNpuelekmCZFjpFht9a9rrLA6vQmIWmGFAPH8FXDtFMwwCzTv8BwsTJhU5i0XwdaKl7WvwSdMWRZtST4FVLEDCmPDbgoEv+vdn3Rsn1oTgdy7XSbroNR12MSsoSf4JMBPS5PHlzBDMJ4+KYibc67o2c16OFHnuT0jtp828onTljLQEzbHrgxECeioxBtNoPL/qVH71imzLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aK1mfXUJR599QztXH5NH6yJYzqOrjQPPigw/F82QsqM=;
 b=eAlZjcTjdxWfOnmYO5e8BrBGbDHwWteCN0nE0m2Rmv7wiUCJfb7wEYFcG2gBWrjbsZ1zACakeoS2ae1zvulE0palmOPPkAbQcnAIqiwgLJFILmCvxodtXxwmxZtoVsnMDdMK5Ypxa8ixRT9EKaASIfP79I+SRd056SEQ53pUVQNYW+7olbjx2Q9pEOP1ycYbWeoFM85jg3LY9HJvy5uohdMTfvhpCl+Ai9wE9gFLCd5tSpJ+jrWGFT1Ll/214zT/UD3oNcPq2syW4lKLYVDo996lDLo6E7Z/TW2m7o/dRR4GGR1Orv4SnNF452awyjmZoAphf2Vi8sJcCozoXRf7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aK1mfXUJR599QztXH5NH6yJYzqOrjQPPigw/F82QsqM=;
 b=nclEtoywphkmHY8Vh07/M7ELIvwQdquwTCRX9nqYzDVHad7nTZ4TzW7XjgOo3omq+EFy3u1Bo/nvTx0bhJrz14baAsvCLFMjKjqD64jDm2coeTTMebVwFzOd7hE9R0NbQAvxbx+9CAoQAfxUCSa1RSQpi0iP1l1yg1Nhj+lISjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Tue, 22 Oct
 2024 06:02:08 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 06:02:08 +0000
Date: Tue, 22 Oct 2024 11:31:59 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	x86@kernel.org, Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v4 09/13] platform/x86: hfi: add power management callback
Message-ID: <Zxc/1zw/LGd3PKl5@BLRRASHENOY1.amd.com>
References: <20241021180252.3531-1-mario.limonciello@amd.com>
 <20241021180252.3531-10-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021180252.3531-10-mario.limonciello@amd.com>
X-ClientProxiedBy: PN2PEPF000001AC.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::12) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: 570e672b-4774-4642-b001-08dcf25f0ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CfbXhp21pRfRI1MK3VoQj6UwQAfCfe6m8prQSiRivbuWZWKD10nqwMvmhwSQ?=
 =?us-ascii?Q?QGHN8V4NlSw/riCdIqDk3KN6D+0qRN4MjH/im0knYJETkN0loxAbaJJepXpl?=
 =?us-ascii?Q?LR1IVo3nCW45vAOiPd5iazCuCSgyBt+nrQN+QNWNLb4+u2OIoDdGdcH/9ORi?=
 =?us-ascii?Q?T8LyDg5SXT2dDaJxqzmW25VbCfdTgtPChDPAFTZEEldZc8o5YyPPh1BMyrxs?=
 =?us-ascii?Q?56RfAGNvS3o5Yd5JPpGOe0A0XgQQK9ysWrbu/3ETeBvrKkZdw1JtaYDhP+xb?=
 =?us-ascii?Q?X7Z16y0GIuhoN8QETD2n3UMffnKFMVzl0dL5gXV3JHI4K//JsxFXL6bTYLBH?=
 =?us-ascii?Q?+j6hmh2ZbURpLuLz3y/7xTWP7xRgawLjnD21jr27Y4Zn41MEy3RSQUY7CZaw?=
 =?us-ascii?Q?C+xeYzGuXO8p2Vem9pmUF9Nmn7fktoaSHy+IdMJTPYEBd57l9/vLo8nBd1n5?=
 =?us-ascii?Q?igAlmS9dTX7LEEp/JK/P2LTOzNX5oxo1hvOFp+/mq/ReZWGAAYn6lEOZQlxU?=
 =?us-ascii?Q?JYakcBTeWKByhT1zhF30iRmPjAHgWN5VhXWctg7VGvikQ9ueMr1k7q4pLNHd?=
 =?us-ascii?Q?NJAmVN+/iavHmbuPNaEiN8xmbJa0iSWoQ3+W/iwWqsGBbs1j9enDP2RYT6V8?=
 =?us-ascii?Q?bEZKISj7yPcizo8k/bhTkwBST6e1oTf5jIrE1NuPWX3IzbjCZCnFpleRHZ6T?=
 =?us-ascii?Q?pPHrt3iK1exsP86PI7pVdRw+7DQGwOcDaeBXUsqZjqjIT93TTw5yXMUD4hui?=
 =?us-ascii?Q?zQrMXLgPBWHSAbTjXr8qVPK/Msy8dzifhyvmX3CGsHQIbdaUB2UsCnDjumLT?=
 =?us-ascii?Q?owcnZ7pjlVPGDZIAmXlPriYEkq8wjeg3/VAr9WVHhNZTHOVyH6nwharpP0YL?=
 =?us-ascii?Q?hlKjZLGMJ4NDAFieXSO5L3s21wXVHG3oVCK1jWVyV7wb2aRe0c894iJ0lLdV?=
 =?us-ascii?Q?/+O0cHFDZbsiTsy/k8JnHEy9lRrjcZ+Ix5NKegqOHciJbHgD+kBL0NiyAHyK?=
 =?us-ascii?Q?+GwZ7/00BQLqp+Eu5B1Pxa/xRz2YFdAfFuvpQ/aNUzpthoRDfgM2W6bGCNEi?=
 =?us-ascii?Q?pvYcVcSYIey0iP64QRaS1GzYDXF2QX/KQ0MYXqyxN7/XdKnB/UexdnsC2a+D?=
 =?us-ascii?Q?mQnV9vc68Lf3UO6fNKP4oep7b48le2d4EtN/5VshO2bNO9hJ+8/NgO+Vr/Ix?=
 =?us-ascii?Q?TG1nvEurywoi+6jzDzFCsuJv32L3DKehHtPBuqKEHjVieHrtDAFf91YTdPLi?=
 =?us-ascii?Q?Uzs0CU624hplqptKR0RlnEhtJLLoZgGNL4qtnrGAqZGr1wNpC4jZzYJGLGaF?=
 =?us-ascii?Q?KDNsG3WWRUmoakBawwHGc2Sc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NHgCqzPunaugMtyuQAhbVI/7Tb4pTGAo2AtsAjjumtFSlWtyN/B8FIppXJZB?=
 =?us-ascii?Q?m6AtZ02ZVW4a5cZ+d97hcQ/mZsm/m088E2WOqOusMalsD/gRAJxh1RgUeks1?=
 =?us-ascii?Q?LkeULZjMG28hChf0tcK3VqwIhhtXUKaP6gdmy3Vkbr25qDMTG9tVuJnjovOC?=
 =?us-ascii?Q?LQWlzAySydjnKwxbbBuLqzs6PiD5s87auPXq0ZprRNZnBW+wBljmfr3qv1M0?=
 =?us-ascii?Q?btTTT55neDqopCDRR56GWb3CcByCJRwLjK1NyUWRxe59BmVbPS+EDMWGDZHs?=
 =?us-ascii?Q?WlRcnke545qc3dMDhoiQJJ8kt+6n3PFXK5YJoKj7qbzBNtE96vBlf1H5z3la?=
 =?us-ascii?Q?NeaYN2+VGtcy2aE/uhO2WCNnZTiAugiXxpgjB0820WvmRNXe3uOHS0GEjsIl?=
 =?us-ascii?Q?58z0EM9X1AoybVeLJANRc/cUcAMYpH+UGidr7M9pVFcK/VsgMBKyjCyYjJA+?=
 =?us-ascii?Q?Rd7iLTe6zYCmNZ/Uu+am9Ctc/aYWyn/gfum4awbEndPx5KM3P1lwXz/kA0sE?=
 =?us-ascii?Q?1+U+ieg0+CCeMvxKJK9Q+ev06N+ljZjfiSyYpVF7S85mnNF4HmLnTObbThb6?=
 =?us-ascii?Q?MUo0HaT1qkzm7RFHtrQ43gweN0BeHpZwEs/Ml8YGLzyzTnekDC/PlBke0Wk+?=
 =?us-ascii?Q?zn6zBPDu6ir07Uh31aK8ZzmfHMOZ4MxASt8CLgLKTs2xh/Wj76vYnCsLKU+b?=
 =?us-ascii?Q?pusXOtdNb75dd7plwXl19uAbmxKJp3IERFBHYq0D57W0C3deZlcwvhU18HSK?=
 =?us-ascii?Q?1jpC4y/0TC5mvIIzO6PK6PeiVr8Xje/X+kk0fMKzX2xJviq2miJfmIV9aPa2?=
 =?us-ascii?Q?4LUBo3gBJOJ9Qi9mf9KiZpqnLVZOHMrfz/Q2fjMiCNfAoCrmVD1DTHn0zUgE?=
 =?us-ascii?Q?jbRF8aDkr44d82sN2xMBgwkNQoBUrBhYglnNeNKbjyryTMAqxCtcWm+/ttJl?=
 =?us-ascii?Q?BJfVTt1xiLdk1OC6N6V2FWYYhH7KXQ+0+oVl+6jWoB+6E911q/lSSnM2tVnV?=
 =?us-ascii?Q?yKPoHr/3Nh0KOgAp6y4thmu8YVPlbh1+0Z2p4slQjbLbChXOxfz1qI6XAR5e?=
 =?us-ascii?Q?W+LzGOCCBaXLZ1JWN7d0J+qLjI6BlJ8DUAOgHISf/FtPcvl1Ed5qfIzE7peM?=
 =?us-ascii?Q?Znchd9KVpOi7bjW/QchYXleP3k15jVPhQ00c1u+0z1NzLew6nJlDLjGZzlgs?=
 =?us-ascii?Q?B4ZzL5Pv/g3yMeCGe7ywTaWyl8mKfUlapKIQ9I+/9G2KPvjB83c58LZeF+D9?=
 =?us-ascii?Q?l3CzuPLGHnopCDS0Qq2RHINrC3+7grDp3lzjFUQFsoPe5l08gLsX9cK3YKIO?=
 =?us-ascii?Q?Xo0H8Rfqzm4ug0tawci4DzV9EwRBcxWjw5gQyKuvAVCjbEQOJBNSKC7jVlOi?=
 =?us-ascii?Q?09YcvoAsAGWktLdo4Td3EI7jG607wF1yuiQ4RPLgORyH8Xe/5WovZWjqc2zi?=
 =?us-ascii?Q?duRfo6bmqxiO/hex5bCCCRFOCQ/gl5pOHLfgqqnfFa1E207eJgoi0meqFOCu?=
 =?us-ascii?Q?weyeiL2PTHtzavRxI4G1YI1Rga3fYzR+6cxo6Z1/Chfi8QtDoLATW9mIa4Mu?=
 =?us-ascii?Q?DwrvqvBLGBHOTNLeypRjdv91ZQOfaclfj80P5GC9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570e672b-4774-4642-b001-08dcf25f0ff2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:02:08.6617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 366jkUBCng904o367rJ4gpe83Yzy9tv+3N+jc8uwT5PFb61JqLw6SLpSNocXexI1zyKcJUlSMWK/bpSjIx33UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126

On Mon, Oct 21, 2024 at 01:02:48PM -0500, Mario Limonciello wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Introduces power management callbacks for the `amd_hfi` driver.
> Specifically, the `suspend` and `resume` callbacks have been added
> to handle the necessary operations during system low power states
> and wake-up.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
> v3->v4:
>  * Use for_each_online_cpu (Gautham)
> v2->v3:
>  * Whitespace (Ilpo)
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 33 ++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index 70ddde37f283f..c8fe03d0c9ccd 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -388,6 +388,38 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static int amd_hfi_pm_resume(struct device *dev)
> +{
> +	int ret, cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		ret = amd_hfi_set_state(cpu, true);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to enable workload class config: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int amd_hfi_pm_suspend(struct device *dev)
> +{
> +	int ret, cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		ret = amd_hfi_set_state(cpu, false);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to disable workload class config: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(amd_hfi_pm_ops, amd_hfi_pm_suspend, amd_hfi_pm_resume);
> +
>  static const struct acpi_device_id amd_hfi_platform_match[] = {
>  	{ "AMDI0104", 0},
>  	{ }
> @@ -434,6 +466,7 @@ static struct platform_driver amd_hfi_driver = {
>  	.driver = {
>  		.name = AMD_HFI_DRIVER,
>  		.owner = THIS_MODULE,
> +		.pm = &amd_hfi_pm_ops,
>  		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
>  	},
>  	.probe = amd_hfi_probe,
> -- 
> 2.43.0
> 

