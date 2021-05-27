Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831CB39298A
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 10:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbhE0I1P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 04:27:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:10062 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235492AbhE0I1E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 May 2021 04:27:04 -0400
IronPort-SDR: 9didIKyxiIC8vKPI42l31QdHMLQoz+oY+ZeTyBnoEXwTnLCZ4bu2zTlckd1BSgKMKEW/9e0Eps
 oRygDG0CZoxA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="182334130"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="182334130"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 01:25:21 -0700
IronPort-SDR: zUuONXKllXerxgPUigzBX88IHvVlzT1yknWIKwbMimhnP/hw9nUDciABVzg0gTDb6yBz6kRjW2
 EcZslD2h0dzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="414800514"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 27 May 2021 01:25:21 -0700
Received: from abityuts-desk1.fi.intel.com (unknown [10.237.68.32])
        by linux.intel.com (Postfix) with ESMTP id 7BE4B5808F1;
        Thu, 27 May 2021 01:25:19 -0700 (PDT)
Message-ID: <f5975692426cb27efd5779e7987a7def2a08728d.camel@linux.intel.com>
Subject: Re: [PATCH] intel_idle: Adjust the SKX C6 latency and residency if
 PC6 is disabled
From:   Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To:     Chen Yu <yu.c.chen@intel.com>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Date:   Thu, 27 May 2021 11:25:18 +0300
In-Reply-To: <20210527045647.3599-1-yu.c.chen@intel.com>
References: <20210527045647.3599-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2021-05-27 at 12:56 +0800, Chen Yu wrote:

... snip ...

> Exit latency:
> The C6 exit latency is measured when woken up from CC6/PC6. In the past,
> if PC6 is disabled, CPU would be demoted to CC6/PC3, which is close to
> the latency from CC6/PC6 and there is no need to update the C6 exit latency.
> However on newer platform there is no CC3/PC3 anymore, then the C6 exit
> latency with PC6 disabled should be CC6/PC0.
> 
> Target residency:
> With PC6 disabled and C3/PC3 supported, the OS requests C3 if idle
> duration is within [CC6, PC6) target_residency. On new CPU generations
> with C3/PC3 deprecated, the OS would request C1E. This would cause
> low energy-efficiency. In summary, the question is, should we lower
> the bar to request C6 when PC6 is disabled? The answer is yes.
... snip ...

Hi Yu,

Thanks for this patch, it is very actual and helpful.

Comments about the commit message below.

This patch is specifically about SKX. It also covers CLX and CPX,
because they have the same ID.

Now, this platforms do not have C3 and PC3. So I would avoid talking
about these states
in the commit message. Why making a simple thing more complex?

Here are all the SKX C-states.

1. Linux-level C-states (linux can ask for): C1, C1E, C6.
2. HW-level C-states (HW supports under the hood): C1, C1E, CC6, PC2,
PC6.

Here is the story of this patch in my understanding.

1. C6 maps to CC6 and PC6.
2. CC6 is "shallower" than PC6.
3. Linux assumes worst case - PC6.
4. Many datacenters and users disable PC6.
5. We can optimize intel_idle in this case: adjust C6 latency and
target residency to match (faster) CC6.

That's it.

Then may be it is worth mentioning that CC6 vs PC2 difference is not
really measurable, so
the adjustment is only for PC6.

Artem.

