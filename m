Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C202F298C05
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 12:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773556AbgJZLXJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 07:23:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:45924 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1773545AbgJZLXJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Oct 2020 07:23:09 -0400
IronPort-SDR: AQPJCmOWyDCt1fTVmqa/g+30VRwlTnEE9gATZD9EheOPiOqPjbPHIvNaFJ+EUQeidnafkeDDJd
 VSWQJFDNu5xw==
X-IronPort-AV: E=McAfee;i="6000,8403,9785"; a="164409860"
X-IronPort-AV: E=Sophos;i="5.77,419,1596524400"; 
   d="scan'208";a="164409860"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 04:23:08 -0700
IronPort-SDR: jH3KRvu3kE/2wmI0opc2g9EWpDcYd+H1XvLHrkQJWFdbGiytWvv+sioabit5JWBAAWCVF4D+g7
 Z5YtVB7qLgQA==
X-IronPort-AV: E=Sophos;i="5.77,419,1596524400"; 
   d="scan'208";a="535321010"
Received: from rfsaliev-mobl1.ger.corp.intel.com (HELO [10.249.155.161]) ([10.249.155.161])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 04:23:06 -0700
Subject: Re: [PATCH] PM: Use WQ_MEM_RECLAIM flag for PM workqueue
To:     Ravisankarreddy lingareddy <ravisankarreddylingareddy@gmail.com>,
        rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com
Cc:     masaya.takahashi@sony.com, Shingo.Takeuchi@sony.com,
        Srinavasa.Nagaraju@sony.com, soumya.x.khasnis@sonymobile.com,
        ravisankar.reddy@sony.com, linux-pm@vger.kernel.org
References: <20201024064955.GA30892@tsappmail.ltts.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <3c1d6e03-729d-0357-8f69-aa742289bc3b@intel.com>
Date:   Mon, 26 Oct 2020 12:23:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201024064955.GA30892@tsappmail.ltts.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/24/2020 8:49 AM, Ravisankarreddy lingareddy wrote:
> Deadlock is seen under below high memory usage scenario.
>
> kswapd waiting to reclaim memory is blocked on i/o kworker and pm_wq
> context which needs to wakeup i/o kworker is waiting for kthread
> creation which is again blocked in memory reclaim path.
>
> Use WQ_MEM_RECLAIM flag for PM workqueue to avoid this deadlock.
>
> Signed-off-by: Ravisankarreddy lingareddy <ravisankarreddylingareddy@gmail.com>
> ---
>   kernel/power/main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 40f86ec4ab30..ff5f3349e76f 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -933,7 +933,7 @@ EXPORT_SYMBOL_GPL(pm_wq);
>   
>   static int __init pm_start_workqueue(void)
>   {
> -	pm_wq = alloc_workqueue("pm", WQ_FREEZABLE, 0);
> +	pm_wq = alloc_workqueue("pm", WQ_FREEZABLE | WQ_MEM_RECLAIM, 0);
>   
>   	return pm_wq ? 0 : -ENOMEM;
>   }

Please resend this with a CC to linux-pm@vger.kernel.org.

Also it would be good to know how to reproduce this issue.


