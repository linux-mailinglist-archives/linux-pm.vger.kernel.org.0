Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD403BF744
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 11:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhGHJLL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 05:11:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47232 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231254AbhGHJLL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jul 2021 05:11:11 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16894jlV055988;
        Thu, 8 Jul 2021 05:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=JPJDLe0p4ZjhEFucYJlDDkxue6Tk2PTl5d+5nvsL6qE=;
 b=AzNQwZ6xuDPxnCb7xw9sj+naBglfF8O3fijEP1F6hyyXSGYVht3RGUaR7yMMy1funRtC
 K5x9vHRf/v19nEV0cK2zVvzpFxI3g10CICZQ/e+PM7sRxgBbI/gOK09TB3u1WJdoILM/
 BSpDeTxygKxzhKB+2/KbGJnJrAOrV58KaBY/0JkNBzOThnfS7Dr/j4CW/6Qw8HyekyTT
 fbhox1BSJsEc7/Vg6McbpeL7DvDu2AdAX60SbZEoBKic40yWZ87R4JlEGAQ+fwQjGbFr
 HBv6sy/Hjb/JeCA2EB493JJWwVPWQT0w+Yovywq7K830AfXyKRLD0mHbwS9r1GRdsLX6 Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39nwn01c8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 05:08:16 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 168951xJ059928;
        Thu, 8 Jul 2021 05:08:16 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39nwn01c8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 05:08:16 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 168979ig006029;
        Thu, 8 Jul 2021 09:08:15 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01wdc.us.ibm.com with ESMTP id 39jfhca9r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 09:08:15 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16898EoM18612528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Jul 2021 09:08:14 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E1686E058;
        Thu,  8 Jul 2021 09:08:14 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D14F96E052;
        Thu,  8 Jul 2021 09:08:13 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.199.42.113])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  8 Jul 2021 09:08:13 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 451722E3B06; Thu,  8 Jul 2021 14:38:08 +0530 (IST)
Date:   Thu, 8 Jul 2021 14:38:08 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     "Pratik R. Sampat" <psampat@linux.ibm.com>
Cc:     mpe@ellerman.id.au, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        pratik.r.sampat@gmail.com
Subject: Re: [PATCH] cpufreq:powernv: Fix init_chip_info initialization in
 numa=off
Message-ID: <20210708090808.GA21260@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20210615050949.10071-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615050949.10071-1-psampat@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UgbXKmIpz22uEgfbU_KqL_zudiRSdQ8B
X-Proofpoint-ORIG-GUID: twlkEIaGgywqDefwKHZo2OlwpgoN0mA-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_04:2021-07-06,2021-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107080050
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Pratik,

On Tue, Jun 15, 2021 at 10:39:49AM +0530, Pratik R. Sampat wrote:
> In the numa=off kernel command-line configuration init_chip_info() loops
> around the number of chips and attempts to copy the cpumask of that node
> which is NULL for all iterations after the first chip.

Thanks for taking a look into this. Indeed there is an issue here
because the code here assumes that node_mask as a proxy for the
chip_mask. This assumption breaks when run with numa=off, since there will only be a
single node, but multiple chips.


> 
> Hence adding a check to bail out after the first initialization if there
> is only one node.
> 
> Fixes: 053819e0bf84 ("cpufreq: powernv: Handle throttling due to Pmax capping at chip level")
> Signed-off-by: Pratik R. Sampat <psampat@linux.ibm.com>
> Reported-by: Shirisha Ganta <shirishaganta1@ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index e439b43c19eb..663f9c4b5e3a 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -1078,6 +1078,8 @@ static int init_chip_info(void)
>  		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
>  		for_each_cpu(cpu, &chips[i].mask)
>  			per_cpu(chip_info, cpu) =  &chips[i];
> +		if (num_possible_nodes() == 1)
> +			break;

With this we will only initialize the chip[0].throttle work function,
while for the rest of the chips chip[i].throttle will be
uninitialized. While we may be running in the numa=off mode, the fact
remains that those other chips do exist and they may experiencing
throttling, during which they will try to schedule work for chip[i] in
order to take corrective action, which will fail.

Hence a more correct approach may be to maintain a chip[i] mask
independent of the node mask.





>  	}
>  
>  free_and_return:
> -- 
> 2.30.2
> 
