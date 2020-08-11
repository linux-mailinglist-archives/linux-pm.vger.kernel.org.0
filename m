Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A537A242031
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 21:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgHKTVx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 15:21:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:29015 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgHKTVx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Aug 2020 15:21:53 -0400
IronPort-SDR: 1QKtpfpgFufbNt9gba/8vEdFerlq9T7dD4N0M++xAdfD2U0CRwNNeQu+REKFSLbOqM9qP7QVdj
 Z7KyyN/aehYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="153789917"
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="153789917"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 12:21:52 -0700
IronPort-SDR: T2glGAwi/JsIJlV9BSkNjgkh4DJil+vf2k/n66DBeYvnSm4+hAGv3XtrwXvLcCzYiYjI6/xHE+
 7c9kWyYFrtDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="494786074"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.252.41.60]) ([10.252.41.60])
  by fmsmga006.fm.intel.com with ESMTP; 11 Aug 2020 12:21:50 -0700
Subject: Re: [PATCH] genirq/PM: Always unlock IRQ descriptor in rearm_wake_irq
To:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        linux-acpi <linux-acpi@intel.com>, rafael@kernel.org
References: <20200811180001.80203-1-linux@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <a009f2e5-8bf9-fc7d-ece6-0ee2e4381cc1@intel.com>
Date:   Tue, 11 Aug 2020 21:21:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200811180001.80203-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/11/2020 8:00 PM, Guenter Roeck wrote:
> rearm_wake_irq() does not unlock the irq descriptor if the interrupt
> is not suspended or if wakeup is not enabled on it. Fix it.
>
> Fixes: 3a79bc63d9075 ("PCI: irq: Introduce rearm_wake_irq()")
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

And it needs to go to -stable (even though the bug is latent now, 
because this function is called for suspended IRQs only AFAICS).

Or I can apply this as the mistake was in my commit.  Please let me know 
what you prefer.


> ---
>   kernel/irq/pm.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> index 8f557fa1f4fe..c6c7e187ae74 100644
> --- a/kernel/irq/pm.c
> +++ b/kernel/irq/pm.c
> @@ -185,14 +185,18 @@ void rearm_wake_irq(unsigned int irq)
>   	unsigned long flags;
>   	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
>   
> -	if (!desc || !(desc->istate & IRQS_SUSPENDED) ||
> -	    !irqd_is_wakeup_set(&desc->irq_data))
> +	if (!desc)
>   		return;
>   
> +	if (!(desc->istate & IRQS_SUSPENDED) ||
> +	    !irqd_is_wakeup_set(&desc->irq_data))
> +		goto unlock;
> +
>   	desc->istate &= ~IRQS_SUSPENDED;
>   	irqd_set(&desc->irq_data, IRQD_WAKEUP_ARMED);
>   	__enable_irq(desc);
>   
> +unlock:
>   	irq_put_desc_busunlock(desc, flags);
>   }
>   


