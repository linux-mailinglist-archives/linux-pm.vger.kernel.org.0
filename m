Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE07C403F03
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 20:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243967AbhIHSWM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 14:22:12 -0400
Received: from mail-mw2nam12on2067.outbound.protection.outlook.com ([40.107.244.67]:64545
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347196AbhIHSWL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 14:22:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxvISMoPa/yDJtJE0Bl5SbUw2ND+y/UaNzcEdONGMIDXgT9mFlEwV7hO8eY1JoKMTHVDVi2CWxTYM1AW8ExAhcWdc+rqdtzGGG/LmtiaSzjVPTfxlaBydiCQrKfNyuoW6aG6cCfJpZo7Rl0rqrFOgs6Gnipy/0Ht/h3Ov0K0bkdnUcLiAQbxP9/Z7j3Rk9exVpw7u5h1JFO2M81JfCWdY+le1XO1QfHPHZzM0BKlmPbylQ9/Df9P62b0E6By/8ardxrIew/rr89u6rF22ZN9wQcyv6UInks6INxXezmWBkaXxvapBtUxnHMrb0N2sHNRjMWa/EJlRmgQiTR5iPJHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZcJaBEYfCPIioKJYKEYgkbuC6LkyPjeI8YzhvRS79F8=;
 b=dj/IqescgZeRBuHe9YhtiWh2dON5acrCaWE2aWOwxfMrdx0rjamo8to6vOR6ZzL13MqSoso9+fFtqElogS11Dt4RPYGctBpaUTH472GUK9O0OblyFNRlI7TW5uKdzUSrZCrMsA8jLR1/bbcAsB/Job/IdhoDsMXuTiHXByIZDw91ciqebp7FbyLfct3eu+1XSTEPiKD/gLgOO6NjdGr1Qjik2+Hpo3/FO4mXTVO0aLV4x8IEdrvXU2KWaknW1SmCdnHWczr30VyVHkmF48nqRmkU+zmUcg9nDVB9uGdb1ooUgGPUODrE+eiBDjcAaAwwWTEDD+kcjn1FGpdPvJg5gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcJaBEYfCPIioKJYKEYgkbuC6LkyPjeI8YzhvRS79F8=;
 b=E0gzwHS3v84bhT0EF1fH1BLvc2PY72g3Bfvb9hFnlgdIpPeW1DmTBQqC/X4jiUuSy68XIja5wifulGetXfBciNJ1wlbyi32jY5FW2sJ5Lhyqj+bwdAzPSgpF+5j4EqtzapsmBQ8BbYffdUEKiwR9us+QaARJfoev94NfrRXOBAI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 18:21:02 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::e134:658f:3a82:f750]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::e134:658f:3a82:f750%4]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 18:21:02 +0000
Subject: Re: [PATCH 11/19] cpufreq: amd: add amd-pstate performance attributes
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        linux-pm@vger.kernel.org
Cc:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-12-ray.huang@amd.com>
From:   "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
Message-ID: <a03268e4-f6c6-93ed-d977-94efbd6f923e@amd.com>
Date:   Wed, 8 Sep 2021 13:20:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210908150001.3702552-12-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0067.namprd05.prod.outlook.com
 (2603:10b6:803:41::44) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
Received: from [172.31.130.72] (165.204.78.25) by SN4PR0501CA0067.namprd05.prod.outlook.com (2603:10b6:803:41::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 18:20:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63df8c71-fc92-44a5-58ef-08d972f569ca
X-MS-TrafficTypeDiagnostic: SA0PR12MB4576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB457605BA48344B395E9C58C9ECD49@SA0PR12MB4576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBj21znrXWYaHIpy1A76994b/MImoUtUwxCzx4TO+e+7+AvWH2WmRO9vWlJ5yRzFA2NaehyTb14zGJ+OgRqzl1j9EphNMaeVeT71sNBTKmHciriB8sDJLgK93Pa8Km1JLc3EeNAXh43U+/dw+3oHlXd2n5qV+HOnEVELRLr/S1G+e2FT4uJGVzaKf6CgiSLiG4bOX26juw7sZIXjMVidmuHchBxcYOP5ZDOmuOX3WQq15S++Wr/jmus6yNtO7LCbCB2noO/ScUQdcQu5678WmvcDZn/WdSxuo3AgQLMSFPSfDDoxyAMC1b4fvU5Kog9Y1A2L33n9KhcOoD8pe7/MhthOHcXqOufYKs/YQFhFtua/RHRrRP4scLuqwcKwi8MqRqu6sxwaf/Ao+WRjRr1cGGPsceiVPl6colzJJosbJ6OOASVL32OLQgKbBkhYzyYHalam/N/IEOMEf/5IcOuvnnqFWdPB2AsPe6IWzjWULiuv5oPKShb2yDf9WWK3vXg0aynxEyHhnQjLDdQ+n/TeT7Juhjtw7+dtbd9tD34emr1vLmiQlrqy6PGVDlsWYAjedD3CJOJsUKMitNnuT3B6HUDzTXOMC5phUM9+u3SWWo8zYQg9RJlh+dhH1dyjjnTevtN75vseAunxa08EYFNZ91cnD1E99jBnLq+w9S4Gua5nn32lfCO6dESo/NJ+GYwfqSZj3OHTp++sC+g0cioAN7Nge0N3xq0VPsZRppoKrc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(26005)(4326008)(2616005)(66556008)(66946007)(5660300002)(86362001)(186003)(83380400001)(66476007)(478600001)(2906002)(8936002)(8676002)(110136005)(16576012)(31696002)(54906003)(31686004)(38100700002)(36756003)(6486002)(316002)(956004)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlFQLzNGVGIvaDNQaUQrT3VZemtUSlhrZEhWVmtQem8xeVdoWTIzS0ZMcGFF?=
 =?utf-8?B?QmJQME01Q2oxQmRWSmJpbkFyNWxSMGp2MzBobFZmYkNzN0lKM3dZTTN2L3BG?=
 =?utf-8?B?dCs0ZGZZdjR0TGkyQmpkQ3JEaURXaXZkSkk3aGpLdlhocnpTWDRNNXBaL2xU?=
 =?utf-8?B?KzNRTlFSMDJpSW1CNE9kczJFaFNOdVJzNlgrOEdySXl2K1UyRkc4VlhQUndX?=
 =?utf-8?B?ejh0ajlFeUw3TkVOTDlCN1hhYzFLMXRVSXFjZnNtL2dVNEdXeXh0ZGRaQm5y?=
 =?utf-8?B?UnIwQ1dhaE5Lei9aRmR4WkxYbXlNQ1dKTkdQUkx6L1ZyZ0FjMHZWbFBULzk0?=
 =?utf-8?B?Y3J5d3BRdHNRZVRvaG5KSnFvMlRyajNSaGcvUUcvV1pzR0JJdHVXTzh0TCtp?=
 =?utf-8?B?NjlSbVNwU2NjQ2RGTnhPbnNhYnpFcmNBRjB0WnFQVmFLZlZOMmt1MFVVQldE?=
 =?utf-8?B?a2hJVDJJRjNJWmcxakhCMG9VdFNMQTV1N1BwZVplWDhvclhFbWIza2RrMjFN?=
 =?utf-8?B?RUxQc002c29QYUJlRnplYUpZUjFxZU5lNXBjWDlkMklEdEhNak5TR2JNQitD?=
 =?utf-8?B?MGxGZUsycnQzU3dnMXpwdy9LaUVkaWpiNGZkNGR5RkdCSlNubG5Ob2FsMy9E?=
 =?utf-8?B?MXJoZENWNS90WE1PN0J5dUtxbmRkdzVMUkZublZnRXlHWUpYNXVYVVFlTnZi?=
 =?utf-8?B?eTVRY041aUd2UmZncUFjczlEVjU0NFYvYkV2a2xyNmdDWUc1cTExR0cvcVdh?=
 =?utf-8?B?N0l5dFRCRFNqSFJPek1rNFBsTjVZQlo2QktWRTVxckhpb01xTm9zb2QrelVh?=
 =?utf-8?B?SHZQb0xlV2RuSDNMUy8rem83eTZDSTUxdFRpTlR2ZVFodlIvbThOa25sWU4r?=
 =?utf-8?B?b2V5T0tqOUlFZ082V2VWeERpdG04YVFtbjdQTXBOZjBsNyttOFJobzk1QUlT?=
 =?utf-8?B?ZDZFNUtNbUc1NkdHTnhPbTJPbXpib3IrV3hyTTQxM0wrTStZbE1iU050ZlF1?=
 =?utf-8?B?YkF1ZmVISWptYU1rSmVlazV2ampQWW04S0FZZTlVTWtZcDdSYXlqN0lScjVk?=
 =?utf-8?B?UlZ4a2pNd3J2cS9WTXFVOGpjVFZpVTl6NlVCY1A3bEhiaWhCQ2VtbHBqZDBw?=
 =?utf-8?B?VktENnRzUlJkMmI4SEhUZWI4WTF6b3dRMm9Na2lWa2R4bkYwZlcwVE4yb1lK?=
 =?utf-8?B?YzRFdUp6YmRDNlpvZitsRUlBVDU1OGhnampENXNrWDRvb0lScWYwYTROTlJQ?=
 =?utf-8?B?ZHAvOGZFeHVpbkkxZUQvMnhMcVdPNTdBMDIydEtsQUdhUThWTEVyaVB4c3ZS?=
 =?utf-8?B?VTNZVjA2akY5SkJKYnlnWmRHOForcGtPQ1JSZDJwL1M4ZU9LL2dlNUlCYm1L?=
 =?utf-8?B?bGRuL0YrN29qbFcvb3gvKzJBcFc1V2UvaWRLZ3R5MExmRjhBdlBaMHRmWHBr?=
 =?utf-8?B?aWhGa212Wk1Hd1dxcWJtUFltcTFRL1pMY3ZRZkljUVdUVUlxaGw2RnlmU1dC?=
 =?utf-8?B?TEMrY1p5WTIya1Q4aExjbDBad21XR29CRXZER3RMWkJadjFTSnNrM2NGSHcz?=
 =?utf-8?B?RVhrZjVZYzJJMmYvOVJ0dDZreTQ4clVQREFRNWNKV3R4bFE0RFp4a0FRK1hn?=
 =?utf-8?B?UDIyb2JXWVdRa2tpamtaRTV3WkNRYWxEVlUzZlRFRWNETGdlZVliVUhDeGFM?=
 =?utf-8?B?NmtjbGlaNXFNRWxoSHhsTEc5d1dsMEVYblFocGU5ZG9nL3I3OUFMS3NoZnFG?=
 =?utf-8?Q?+wDwF+ocOyfn2xyDCd3zkEYPZT5o/6v1tOjPqfM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63df8c71-fc92-44a5-58ef-08d972f569ca
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 18:21:01.8357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GJYAhqsSBy2aGYBLa1+8fxrx6EHMhIlU1wZxLG88ITkeLBlFwfAIUFN12e48nVX7jhewo7t+5jFDHUr34FhQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4576
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/8/2021 9:59 AM, Huang Rui wrote:
> Introduce sysfs attributes to get the different level amd-pstate
> performances.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 66 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 3c727a22cb69..9c60388d45ed 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -647,6 +647,62 @@ static ssize_t show_amd_pstate_min_freq(struct cpufreq_policy *policy, char *buf
>  	return ret;
>  }
>  
> +static ssize_t
> +show_amd_pstate_highest_perf(struct cpufreq_policy *policy, char *buf)

Here (and in the other functions) the function return value and name should
be on the same line.

> +{
> +	int ret = 0;
> +	u32 perf;
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	perf = READ_ONCE(cpudata->highest_perf);
> +
> +	ret += sprintf(&buf[ret], "%u\n", perf);
> +
> +	return ret;

Same comment as the previous patch here and in the functions below, just do

	return sprintf(&buf[ret], "%u\n", perf);

and get rid of the intermediary 'ret' variable.

-Nathan

> +}
> +
> +static ssize_t
> +show_amd_pstate_nominal_perf(struct cpufreq_policy *policy, char *buf)
> +{
> +	int ret = 0;
> +	u32 perf;
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	perf = READ_ONCE(cpudata->nominal_perf);
> +
> +	ret += sprintf(&buf[ret], "%u\n", perf);
> +
> +	return ret;
> +}
> +
> +static ssize_t
> +show_amd_pstate_lowest_nonlinear_perf(struct cpufreq_policy *policy, char *buf)
> +{
> +	int ret = 0;
> +	u32 perf;
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> +
> +	ret += sprintf(&buf[ret], "%u\n", perf);
> +
> +	return ret;
> +}
> +
> +static ssize_t
> +show_amd_pstate_lowest_perf(struct cpufreq_policy *policy, char *buf)
> +{
> +	int ret = 0;
> +	u32 perf;
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	perf = READ_ONCE(cpudata->lowest_perf);
> +
> +	ret += sprintf(&buf[ret], "%u\n", perf);
> +
> +	return ret;
> +}
> +
>  static ssize_t show_is_amd_pstate_enabled(struct cpufreq_policy *policy,
>  					  char *buf)
>  {
> @@ -654,17 +710,27 @@ static ssize_t show_is_amd_pstate_enabled(struct cpufreq_policy *policy,
>  }
>  
>  cpufreq_freq_attr_ro(is_amd_pstate_enabled);
> +
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_nominal_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>  cpufreq_freq_attr_ro(amd_pstate_min_freq);
>  
> +cpufreq_freq_attr_ro(amd_pstate_highest_perf);
> +cpufreq_freq_attr_ro(amd_pstate_nominal_perf);
> +cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_perf);
> +cpufreq_freq_attr_ro(amd_pstate_lowest_perf);
> +
>  static struct freq_attr *amd_pstate_attr[] = {
>  	&is_amd_pstate_enabled,
>  	&amd_pstate_max_freq,
>  	&amd_pstate_nominal_freq,
>  	&amd_pstate_lowest_nonlinear_freq,
>  	&amd_pstate_min_freq,
> +	&amd_pstate_highest_perf,
> +	&amd_pstate_nominal_perf,
> +	&amd_pstate_lowest_nonlinear_perf,
> +	&amd_pstate_lowest_perf,
>  	NULL,
>  };
>  
> -- 
> 2.25.1
> 
