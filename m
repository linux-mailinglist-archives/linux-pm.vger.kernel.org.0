Return-Path: <linux-pm+bounces-15835-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCAC9A1A58
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 08:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3AB2887C4
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 06:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFCB16FF26;
	Thu, 17 Oct 2024 06:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z06Jh9f6"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAC31304B0;
	Thu, 17 Oct 2024 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729144874; cv=fail; b=jKBg3gjDw5FsrrEnqeZCx1Ob0saJjxYZ5uO2xiHuaL3Lu2CXUt5VjVTxi/aiafdrUuc/dTX4NcggOcUpg9R2DjgaoB5xi1Fnc93wZachPQWGPkxEID63CWc1R7jmfg2aRhWq9+491Tra1mYlLUY+1CHvVaSoYK+GtvFkLnca/lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729144874; c=relaxed/simple;
	bh=OFDLSqUdxaEvgSS2y98R4qWtsqkTmWN4S2AvX90q7CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EvwlVKAaZch3V3l/5f+OJJZSWuEyfZFiBeM3HUdmTxTbP+C2WI1V4DlSW5NeHTgx2SB7BUbrI3dWaIjP9PQLog75nf0Efv5EPwRnVzA3wc8n0PU/ZeOCkQIcJSo4WNgB6FGP6WLRrD5nH4xfo6qQLObVi2LCmCZz6BubqVzc8ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z06Jh9f6; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVElfYwj3oiE0sq4N3soZ6tyGhdCtH4N8h7XnGm0ZaTQCT4FMaHxMR1nWUn6LGvdeMprDu4e6Jq6nD/KUlZXJCiTN3OwC0Fla6HlULtM8GU1WXM+AsBGh6Gifki6VBrvIDqu7ObLsT+GJ2yeyhjDQTh4g20rk6PVcCRjzb6EHXWqCVki9Pz/wfpPaohkK7u/mcJrkp7NODjPvyrzlz0AVzjM5BTN+zz7LxnDcjPGGWxELWQ4QSzRJJ+CZpflwVBrIC7MssMSCygrI5cU4oQjNi6vJf1FPg++1mEBozr3L86ofsHQItzUFrq/eV8xmIB719gwoLdAxpeZ08oA5is3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuhK2nxsK33hkdcb510TvSUj5SQ6iCXfGqj/L+AvZAI=;
 b=iMjzTeISOgmRbb9HZ91gULKCrDoh5aJUIuTRls5+tLMLjKppj1xBOEFMhLW1hUh8aqTl3yav3NI48zpJU4V+B81pS/K4ZifweXa/enG8734m0AGcAby0PEA4BBLWLNrINSLdYq9od10f7VrVnp1NNfsRS3rz3WuP1Oqcrjf0ocqPmQBG520DZxW3Vz7imRMcpyPPwAA/9NEAULI3Pjq7U7Ah4OmDSQOCf80O7nHUpdf7PVBGYZzA5BtpHWGh3SpRVWvl7j1jFPWo54To67Rd474eObPCI6FgWaro2B+5Cn7OU7KoOiDFCrr1yNIoETHRZ2l5Kinz8eq8rFik7n3ORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuhK2nxsK33hkdcb510TvSUj5SQ6iCXfGqj/L+AvZAI=;
 b=Z06Jh9f6+Shg7sL+p2Z1dQUUIAJPkVbFjMdSLQ3SEutMMv2gyOoHiXMbhAZcW0CR/ahVOQ90ZEmd65JCVyIz3zTGTvzPWryUHfy59bVzTjceywCGPyDce+shKMsJbq+fgeEdZy+I1Nn1E9cDCnBWPMa5cFoG2WEiadeTjV5rdRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Thu, 17 Oct 2024 06:01:08 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%5]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 06:01:07 +0000
Date: Thu, 17 Oct 2024 11:30:59 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	x86@kernel.org, Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v3 09/14] platform/x86: hfi: add power management callback
Message-ID: <ZxCoG7vaLmvTMXFT@BLRRASHENOY1.amd.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
 <20241015213645.1476-10-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015213645.1476-10-mario.limonciello@amd.com>
X-ClientProxiedBy: PN2PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::19) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 31964292-4b05-4514-e15a-08dcee7117a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VwlAmqcRxX9IcyQBN8Ns/gz3vkcF/FxWYPHlvUs0M6M5Loeh0bOGqyaBLe0t?=
 =?us-ascii?Q?jpdX6KjIzOR7Qw53l75Yh0Flr3JwlLjfAfVz5+ONWURvDh9/nkAGEwZ2D9B5?=
 =?us-ascii?Q?WjkUjJZNp1+jN8LlGO/EoR4EPMBahXZWetKUrLpNcJ+bat+I+Og7Sy+xIU7S?=
 =?us-ascii?Q?vbyl7o7uV588PP6yw2fU178CSYTZEP3yN3921B1aWOjErZciuEePV9fO+ro+?=
 =?us-ascii?Q?vuBorbjUgqN9Ctc4tHi9fZ8Tib25WezNm/VD9J+vcRym2X7ou+EHJvqshxd+?=
 =?us-ascii?Q?yJ/wAZdaZ6QMpEiCuCk/H0n5nmMIisKzVo6csaRFL/x4kZ2x0UnLyJ+SOcpD?=
 =?us-ascii?Q?usE0RYZXlLjvsQ/WF7gjSN6SYirxFpj5yaKvAQcEYYKKde2+9SzjdCeAWmEK?=
 =?us-ascii?Q?1Yy1ClU4N2WW30UmcBsFTaHIQV1q4ot4jApmGAcxbr/q7uoTQySeiC3jQO7x?=
 =?us-ascii?Q?a1Hv9EzMgdULRQNS0j+sLQ5W40soCq91CtajiTNCQtsjmhgCj3kCBPffO1AW?=
 =?us-ascii?Q?+oXNTdaVM04yLlWf0xSLzew7S5s9/paDeOEjwxaRtwgf1Yor2JXrVw6rskLr?=
 =?us-ascii?Q?FMPOFvn62obfkOZehm3Z3yDsQbC4iCaiTmRb/YxPwE0VEtGHtobSr5/q7Xdc?=
 =?us-ascii?Q?dpcs/MpK4rsThb0Hs5cHC78twjlWYojRo0cHZiC8Mor1jJohCHKsEKW/vx6D?=
 =?us-ascii?Q?wfG0oLN4oqWzeb4UWjPFCQ/W4Yz1pomrH5gO7y+LENcTrUiUNzfZTQFkrJC0?=
 =?us-ascii?Q?t8gj9D3JBWbTipww4VxzFweuiSZqfpxkH0kGLl5AKB5h24tpmTRuEAiGQvkr?=
 =?us-ascii?Q?h0jRiXW8Y+L4oOn65HEOJNbFWJO740AlOKyDejRhLoF45nS/OihfHCfa3ifr?=
 =?us-ascii?Q?OzBO0Z8ci/ifNYFrV4NgnI92g8SFKbBKhlsxzCoSeBMKuaP8TuEv7H6tQYjs?=
 =?us-ascii?Q?FXZ9yNHRCyk9I/iLBY99yvw0OrW2jnTbdRQdhqX84vUrS8fLKPIR+UMAn5eJ?=
 =?us-ascii?Q?4Pq9aSIq1++V4WF/5zdVYIwym6xVGjqaHblRBSJbdVPBa1C4aIz1NNAQOnCO?=
 =?us-ascii?Q?o7z8IK3euUfwkzMsynR22nH+8vK0qInDCv3EkdEmj7ncY8pnOUzl34lZxJSr?=
 =?us-ascii?Q?HtEw0FYvI3Yp3TAcD+DbR/rhMnRgMVOWVlR2sqJhgTNrRJMYE9B5TFw4g7yG?=
 =?us-ascii?Q?qPF3TshVbW72Ss7+JI6OqgWQZTlUSvk11BmDJWDKOr+f3/uRZhCufI2PM0TI?=
 =?us-ascii?Q?4s56ELIE2nrAmfjdf4fqdMBW9YqtoOap/V/DgpPzoygLL7eB120VHNjcCX3s?=
 =?us-ascii?Q?x8me1ubwKdifDwqOAudQE+Do?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v5PkO+mK5hjatP1WPPstOX/LQ3hBUAvFDt8sXxctFV0bgC+VPPHrHg7COEiO?=
 =?us-ascii?Q?ecguiGAVZ0RalE8bYD2K1jzIAHVLz4awnbYo2piRYvS2qbUrpd+XLo3qGO5z?=
 =?us-ascii?Q?OCGdIFiretjQ2AdjVneGkjr++MOWPLz4mxv4EyAby0gEGbHPd+eFCozjg/XY?=
 =?us-ascii?Q?V7naO2WwUwp7AnA08GymalIhXIIyOvObKBXy/O3uRVHqrd6b5pheBvBkfWmK?=
 =?us-ascii?Q?wyrRJ/Emf+ar7xaAfYQl6Zs8t0yp93R7HjtOlioFyEUxprEoL+C31ADoJB4e?=
 =?us-ascii?Q?5Egp7Ds0lXZAW7ZkwyC3GPzwUoeFVaT/K7QTiQdU/5yihXTZ41dIN/YNtEDm?=
 =?us-ascii?Q?PbIjMmkuUlbcFVZr2jtVnAPS7Qk8/8jEIEgNh1VgQwrPAR6G7GQexmyJ4zjS?=
 =?us-ascii?Q?mnJLRZqZV4KrKA7nzL7xkJ66I4Vp/2nrMkYquzgjBxV1lQw7zmlKLEJ6fIi3?=
 =?us-ascii?Q?AfzuXzL9hlWpzn/GNgNjIyNjZNc4HEJNrd7U0UfkURFnQJW88ZGjWGjjltLF?=
 =?us-ascii?Q?Bo+ZTCWZVJe3jy6pIVLYmxBIfSOw2o3QFu7GlkYWWZghPF7RSzaCzNZGMGPQ?=
 =?us-ascii?Q?bH8tztoF/AltYr5n7JGRQX2Sedgl/y8Piub9jiLPtKW4r8GlpE+/EB+ug0Sa?=
 =?us-ascii?Q?Mybs6Notk7RQ2rAeV+TEv7Sh3L/LBdi/nrGXy+MU4MDV1WdgpSiKLPIQ86sF?=
 =?us-ascii?Q?5PDrfNhOyZhqtMOcI60rJ8h3kCrUh3q+kTnDHGa3xLfJUa/4yMcYCSTLjcjT?=
 =?us-ascii?Q?hMiXHe6OxQchCBXx6JU1is2FvtxpYWPLCz+qQ/5mrztj3kMAfxZdsNxjadS1?=
 =?us-ascii?Q?eIJFsh/HhenDze2piD+DAuTMQbPD5ekx0CqiTONnUHsi+5u8CmLfYzd0bpAS?=
 =?us-ascii?Q?BfEe9alrC5aNk7Kb/eJiTfysr/Kj2Qz1UZpGMI4Knvtm2GhMioX+kOnz5Dbs?=
 =?us-ascii?Q?J+DMhmPNXS7xbgGGn4TLHQy78UKDNWpOcTAVNitrh7/jILLTbfK0QtNjler7?=
 =?us-ascii?Q?74mfK6AYlaZtzIH1sCKcZsfjzRVaDQhCsJHy9nwwyOvDktFVyGfzekfh7Xnw?=
 =?us-ascii?Q?9tNaacMg9F7OTCt3XcDlX4BQMUitUmAMuVdWC0jATaCijp2c/xnpgtg32o+b?=
 =?us-ascii?Q?AlrHbbU5jmxb5APYoEz4dwBGZvENsnhQ2jW7lfpO212gZinZ/ZpO1LET9CFB?=
 =?us-ascii?Q?SGl5Pm6/0TXBnzeQIFObTj/qAIVu0DV/qU7lFdD+tWn0WHmuXRQzgnccx1o8?=
 =?us-ascii?Q?SqtBtXIUNdCAQjS2uIbDP/dcgyVbBYufZgFMpXUv5ps4fCXz58ifuTifgaVB?=
 =?us-ascii?Q?Vvhy03UEhBmdudnyuoVZYSBoL1E6DPHIdXLmyCCrsVxPAjsH/Eh8jH2ml3BD?=
 =?us-ascii?Q?wrtv1BZeSoxl09f4IwQ+VtBudYdz9FUTO3iftF5AMTmjxzX7Ga8K4ysbEPUs?=
 =?us-ascii?Q?16f3JiEKKQkgMXGRNv+gNkiS1+LU38lnPlpIteyIKadHCC2mNWoyi4Jn9AbF?=
 =?us-ascii?Q?GoiRAHElSo+2pJcJsNDhTPlh04bU97H56BWj7H9azIdPTni0hJvA0IngTFAI?=
 =?us-ascii?Q?kK5p9j7aA1Aw9gP+hvYCmKOU9ILYB04kTXY07Mmk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31964292-4b05-4514-e15a-08dcee7117a2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 06:01:07.8344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fct/sBL25m1EhqET3T5JtZX+QgjRyhX0ApXveWeyHlKgIOF4YE8UHJrCVr/9BrtCQEV2ihdbzBrAZjQeXn0AuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258

On Tue, Oct 15, 2024 at 04:36:40PM -0500, Mario Limonciello wrote:
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
> ---
> v2->v3:
>  * Whitespace (Ilpo)
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 33 ++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index d971ec1124af..79963c423d35 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -392,6 +392,38 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static int amd_hfi_pm_resume(struct device *dev)
> +{
> +	int ret, cpu;
> +
> +	for_each_present_cpu(cpu) {

Shouldn't this be for_each_online_cpu() in light of the hotplug
notifier callbacks implemented in Patch 8?

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
> +	for_each_present_cpu(cpu) {

Ditto..

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
> @@ -438,6 +470,7 @@ static struct platform_driver amd_hfi_driver = {
>  	.driver = {
>  		.name = AMD_HFI_DRIVER,
>  		.owner = THIS_MODULE,
> +		.pm = &amd_hfi_pm_ops,
>  		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
>  	},
>  	.probe = amd_hfi_probe,
> -- 
> 2.43.0

--
Thanks and Regards
gautham.

