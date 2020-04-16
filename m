Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C022D1AC9F1
	for <lists+linux-pm@lfdr.de>; Thu, 16 Apr 2020 17:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410310AbgDPP3b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Apr 2020 11:29:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57456 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731690AbgDPP30 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2020 11:29:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03GFIJWK078231;
        Thu, 16 Apr 2020 15:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=T49CaAISVOybcifzGRjEDtW7BEoeELXq2Y1S0fOYbao=;
 b=IQfHG/jCtYhUyIV9VmgicSKG66IFu0ED/azcEm5as4JsKvtUyGZmtN7TOQXkq1RBrG0k
 +/OPDPtkTTRVrTuCJJaab3DSynhsaLT3BdeJvvUxbPMPVwM5TKc4npzjbIQsbwo4iLOf
 NaKqspUs7/WJdeX6DoB3eBXFNkt0VJ9HOhMxnW7fcacssUpdQa1aezvQDckRwurv9GnE
 kGzNKu3cF2GImXmn5rD2xJzxH5vNneOU3XWJ9Y4z7v7b5vY/u789kO3N0SgLl+VDXoPV
 7cGj7hSj02irUiGMgWKmCQrkIOOZV4tRFirXFD3upTTx1bWYitvZShP23wIb33Xq4VRK Ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30dn95t5ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 15:28:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03GFIDW0085431;
        Thu, 16 Apr 2020 15:26:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30dn9fsm1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 15:26:43 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03GFQduv011664;
        Thu, 16 Apr 2020 15:26:39 GMT
Received: from [192.168.0.190] (/68.201.65.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Apr 2020 08:26:38 -0700
Subject: Re: [PATCH 2/4] x86, sched: Account for CPUs with less than 4 cores
 in freq. invariance
To:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Doug Smythies <dsmythies@telus.net>,
        Like Xu <like.xu@linux.intel.com>,
        Neil Rickert <nwr10cst-oslnx@yahoo.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Newsgroups: gmane.linux.kernel,gmane.linux.power-management.general
References: <20200416054745.740-1-ggherdovich@suse.cz>
 <20200416054745.740-3-ggherdovich@suse.cz>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Autocrypt: addr=dave.kleikamp@oracle.com; keydata=
 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
 rnNNL3zBkwD3nWcTxFnX
Message-ID: <b90ba443-9b9d-481e-7ecc-d5a25816e02f@oracle.com>
Date:   Thu, 16 Apr 2020 10:26:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416054745.740-3-ggherdovich@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9593 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004160111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9593 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160111
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/16/20 12:47 AM, Giovanni Gherdovich wrote:
> If a CPU has less than 4 physical cores, MSR_TURBO_RATIO_LIMIT will
> rightfully report that the 4C turbo ratio is zero. In such cases, use the
> 1C turbo ratio instead for frequency invariance calculations.

Thank you! This makes my Lenovo T410 happy again. I had tracked down the
problem and come up with a similar patch. I was about to report it when
I came across this patch set.

> 
> Reported-by: Neil Rickert <nwr10cst-oslnx@yahoo.com>
> Reported-by: Like Xu <like.xu@linux.intel.com>
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")

Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>

> ---
>  arch/x86/kernel/smpboot.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 3a318ec9bc17..5d346b70844b 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1945,18 +1945,23 @@ static bool skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int size)
>  
>  static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
>  {
> +	u64 msr;
>  	int err;
>  
>  	err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
>  	if (err)
>  		return false;
>  
> -	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, turbo_freq);
> +	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
>  	if (err)
>  		return false;
>  
> -	*base_freq = (*base_freq >> 8) & 0xFF;      /* max P state */
> -	*turbo_freq = (*turbo_freq >> 24) & 0xFF;   /* 4C turbo    */
> +	*base_freq = (*base_freq >> 8) & 0xFF;    /* max P state */
> +	*turbo_freq = (msr >> 24) & 0xFF;         /* 4C turbo    */
> +
> +	/* The CPU may have less than 4 cores */
> +	if (!*turbo_freq)
> +		*turbo_freq = msr & 0xFF;         /* 1C turbo    */
>  
>  	return true;
>  }
> 
