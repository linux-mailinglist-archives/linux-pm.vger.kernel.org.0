Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38ED316B9E7
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 07:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgBYGmp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 01:42:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726936AbgBYGmp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 01:42:45 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01P6Yc5T033317;
        Tue, 25 Feb 2020 01:42:39 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yb1qdcruk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 01:42:39 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01P6YqTP033956;
        Tue, 25 Feb 2020 01:42:39 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yb1qdcrua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 01:42:39 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01P6e9LS030359;
        Tue, 25 Feb 2020 06:42:38 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 2yaux687pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 06:42:38 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01P6gb7h51773806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 06:42:37 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3DFD124052;
        Tue, 25 Feb 2020 06:42:37 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74331124054;
        Tue, 25 Feb 2020 06:42:37 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.35.114])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Feb 2020 06:42:37 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 50C042E2F59; Tue, 25 Feb 2020 12:12:35 +0530 (IST)
Date:   Tue, 25 Feb 2020 12:12:35 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     "Oliver O'Halloran" <oohall@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, svaidy@linux.vnet.ibm.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq/powernv: Fix use-after-free
Message-ID: <20200225064235.GI12846@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20200206062622.28235-1-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206062622.28235-1-oohall@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_01:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 impostorscore=0 suspectscore=2 phishscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250053
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 06, 2020 at 05:26:21PM +1100, Oliver O'Halloran wrote:
> The cpufreq driver has a use-after-free that we can hit if:
> 
> a) There's an OCC message pending when the notifier is registered, and
> b) The cpufreq driver fails to register with the core.
> 
> When a) occurs the notifier schedules a workqueue item to handle the
> message. The backing work_struct is located on chips[].throttle and when b)
> happens we clean up by freeing the array. Once we get to the (now free)
> queued item and the kernel crashes.
> 
> Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Fixes: c5e29ea ("cpufreq: powernv: Fix bugs in powernv_cpufreq_{init/exit}")
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Thanks for this fix Oliver.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> ---
>  drivers/cpufreq/powernv-cpufreq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 56f4bc0..1806b1d 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -1080,6 +1080,12 @@ static int init_chip_info(void)
> 
>  static inline void clean_chip_info(void)
>  {
> +	int i;
> +
> +	/* flush any pending work items */
> +	if (chips)
> +		for (i = 0; i < nr_chips; i++)
> +			cancel_work_sync(&chips[i].throttle);
>  	kfree(chips);
>  }
> 
> -- 
> 2.9.5
> 
