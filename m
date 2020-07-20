Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD8B22578C
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jul 2020 08:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgGTGYc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jul 2020 02:24:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbgGTGY2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2020 02:24:28 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06K64RT0039511;
        Mon, 20 Jul 2020 02:24:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d5p8ggdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 02:24:25 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06K66DuT049369;
        Mon, 20 Jul 2020 02:24:25 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d5p8ggcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 02:24:25 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06K6BahU020085;
        Mon, 20 Jul 2020 06:24:23 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 32brbh2933-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 06:24:22 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06K6OKiX22937866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 06:24:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3974AE056;
        Mon, 20 Jul 2020 06:24:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FD65AE053;
        Mon, 20 Jul 2020 06:24:19 +0000 (GMT)
Received: from drishya.in.ibm.com (unknown [9.85.113.150])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 20 Jul 2020 06:24:19 +0000 (GMT)
Date:   Mon, 20 Jul 2020 11:54:16 +0530
From:   Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/5] cpuidle-pseries : Fixup exit latency for CEDE(0)
Message-ID: <20200720062416.GD4000@drishya.in.ibm.com>
Reply-To: svaidy@linux.ibm.com
References: <1594120299-31389-1-git-send-email-ego@linux.vnet.ibm.com>
 <1594120299-31389-4-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1594120299-31389-4-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_01:2020-07-17,2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=1 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200040
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Gautham R Shenoy <ego@linux.vnet.ibm.com> [2020-07-07 16:41:37]:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> We are currently assuming that CEDE(0) has exit latency 10us, since
> there is no way for us to query from the platform.  However, if the
> wakeup latency of an Extended CEDE state is smaller than 10us, then we
> can be sure that the exit latency of CEDE(0) cannot be more than that.
> that.
> 
> In this patch, we fix the exit latency of CEDE(0) if we discover an
> Extended CEDE state with wakeup latency smaller than 10us. The new
> value is 1us lesser than the smallest wakeup latency among the
> Extended CEDE states.
> 
> Benchmark results:
> 
> ebizzy:
> 2 ebizzy threads bound to the same big-core. 25% improvement in the
> avg records/s with patch.
> x without_patch
> * with_patch
>     N           Min           Max        Median           Avg        Stddev
> x  10       2491089       5834307       5398375       4244335     1596244.9
> *  10       2893813       5834474       5832448     5327281.3     1055941.4
> 
> context_switch2 :
> There is no major regression observed with this patch as seen from the
> context_switch2 benchmark.
> 
> context_switch2 across CPU0 CPU1 (Both belong to same big-core, but different
> small cores). We observe a minor 0.14% regression in the number of
> context-switches (higher is better).
> x without_patch
> * with_patch
>     N           Min           Max        Median           Avg        Stddev
> x 500        348872        362236        354712     354745.69      2711.827
> * 500        349422        361452        353942      354215.4     2576.9258
> 
> context_switch2 across CPU0 CPU8 (Different big-cores). We observe a 0.37%
> improvement in the number of context-switches (higher is better).
> x without_patch
> * with_patch
>     N           Min           Max        Median           Avg        Stddev
> x 500        287956        294940        288896     288977.23     646.59295
> * 500        288300        294646        289582     290064.76     1161.9992
> 
> schbench:
> No major difference could be seen until the 99.9th percentile.
> 
> Without-patch
> Latency percentiles (usec)
> 	50.0th: 29
> 	75.0th: 39
> 	90.0th: 49
> 	95.0th: 59
> 	*99.0th: 13104
> 	99.5th: 14672
> 	99.9th: 15824
> 	min=0, max=17993
> 
> With-patch:
> Latency percentiles (usec)
> 	50.0th: 29
> 	75.0th: 40
> 	90.0th: 50
> 	95.0th: 61
> 	*99.0th: 13648
> 	99.5th: 14768
> 	99.9th: 15664
> 	min=0, max=29812
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.ibm.com>


> ---
>  drivers/cpuidle/cpuidle-pseries.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
> index c13549b..502f906 100644
> --- a/drivers/cpuidle/cpuidle-pseries.c
> +++ b/drivers/cpuidle/cpuidle-pseries.c
> @@ -353,12 +353,42 @@ static int pseries_cpuidle_driver_init(void)
>  static int add_pseries_idle_states(void)
>  {
>  	int nr_states = 2; /* By default we have snooze, CEDE */
> +	int i;
> +	u64 min_latency_us = dedicated_states[1].exit_latency; /* CEDE latency */
> 
>  	if (parse_cede_parameters())
>  		return nr_states;
> 
> -	pr_info("cpuidle : Skipping the %d Extended CEDE idle states\n",
> -		nr_xcede_records);
> +	for (i = 0; i < nr_xcede_records; i++) {
> +		u64 latency_tb = xcede_records[i].wakeup_latency_tb_ticks;
> +		u64 latency_us = tb_to_ns(latency_tb) / NSEC_PER_USEC;
> +
> +		if (latency_us < min_latency_us)
> +			min_latency_us = latency_us;
> +	}
> +
> +	/*
> +	 * We are currently assuming that CEDE(0) has exit latency
> +	 * 10us, since there is no way for us to query from the
> +	 * platform.
> +	 *
> +	 * However, if the wakeup latency of an Extended CEDE state is
> +	 * smaller than 10us, then we can be sure that CEDE(0)
> +	 * requires no more than that.
> +	 *
> +	 * Perform the fix-up.
> +	 */
> +	if (min_latency_us < dedicated_states[1].exit_latency) {
> +		u64 cede0_latency = min_latency_us - 1;
> +
> +		if (cede0_latency <= 0)
> +			cede0_latency = min_latency_us;
> +
> +		dedicated_states[1].exit_latency = cede0_latency;
> +		dedicated_states[1].target_residency = 10 * (cede0_latency);
> +		pr_info("cpuidle : Fixed up CEDE exit latency to %llu us\n",
> +			cede0_latency);
> +	}


As per PAPR spec the CEDE hints are in increasing order of exit
latency.  Hence a given state's exit latency cannot exceed the one
following it.  The quirk is such that the first one (hint 0) is
implicit and hence we have to use the above logic to extract its
characteristics.

--Vaidy



