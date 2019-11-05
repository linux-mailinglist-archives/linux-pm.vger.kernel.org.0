Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98C2FEF7B6
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 10:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbfKEJEc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 04:04:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36649 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbfKEJEc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 04:04:32 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so9061683plp.3
        for <linux-pm@vger.kernel.org>; Tue, 05 Nov 2019 01:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X1aa+RRLCGC9my2m6kd83snLA2qyRmty2v6y1d5R9P0=;
        b=endRY/Rltnfhp07fO3ptST2djGJsP4DdqdYX5XkzofqOnX0ENzldtbpHu3ndfGNcRC
         WhzHSKVymDgWvFSuGgBDAcZNiaAQrJYFYWb6zhrouxvKjKspy7ST+c28KInjRb7c6HH6
         1bk0NKQLwE9OCUPkuIqVkw8JncayJ8YYWwxkLfPPSOosU91aQqmZHGGHX1+L6vCwWz7b
         q/IoI67ej+buHog5IwRC22tzfHy8P5grReGhijAXvOPweJ5VAJZzBtUISBRBgsi+uXW0
         9okhfeWC3Qnr7wPFDHtC5VtqVGxGQjbYgoBHoiBMzuWTGO6Q6fQk2w2BTOgX5FP9uWmV
         vMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X1aa+RRLCGC9my2m6kd83snLA2qyRmty2v6y1d5R9P0=;
        b=YmclAlHImCglMnvEcg3IrQ6hf5P7r5dMECs7mV4toW8r28AHknc+uen7Z3DQsjAjfh
         EjFSgP6/Qljq17SfdReGwmvtLe3heyX8f4cm2ncVeGNELFq6R5z/dcjlVOj1x/fSBzWz
         9kCE0hAX0PCK5Xb//LoeZQobBs2DSWOw8FbK+vAI9Z+ppGnwnP+TPNs7rZjj6yqQcaol
         gLBF3vyfd1ATnFmPa3WGevqZ0IpT+3tMxK69ZvkoVnzpK+8BOFNL4RHgpnLRULeiSVCn
         KgMAs0TjJ0SQpyl9nBmlcsworh0aNxVB1/G18/XGGYUrNNH9jK3q3kZaqSUPcXjBJQ1I
         bG2Q==
X-Gm-Message-State: APjAAAXkZNZpEbU55Qu6qzEKF9a56WooWTD8vyBcTAGw0g/EG5CmYit+
        3lCQsLxKL7eyiBdA6iy7Z6DyHA==
X-Google-Smtp-Source: APXvYqxpCk6VYogCmBRUaj33ltVVU8V3qzwuVeHtSMuP604mRn5mA22dm6U3ZPTDJtZl24ulfM7MIg==
X-Received: by 2002:a17:902:9a0a:: with SMTP id v10mr459102plp.190.1572944669845;
        Tue, 05 Nov 2019 01:04:29 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id a29sm26327469pfr.49.2019.11.05.01.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 01:04:28 -0800 (PST)
Date:   Tue, 5 Nov 2019 14:34:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: fix integer/pointer warnings in
 acpi_platform_list
Message-ID: <20191105090422.vehycbs7eubwq7xq@vireshk-i7>
References: <20191105075225.9083-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105075225.9083-1-ben.dooks@codethink.co.uk>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-11-19, 07:52, Ben Dooks (Codethink) wrote:
> The fourth field in this table is a pointer, not an integer so replace
> the 0 with a NULL to avoid the following sparse warnings:
> 
> drivers/cpufreq/intel_pstate.c:2667:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2668:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2669:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2670:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2671:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2672:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2673:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2674:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2675:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2676:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2677:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2678:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2679:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2680:64: sparse: sparse: Using plain integer as NULL pointer
> drivers/cpufreq/intel_pstate.c:2681:64: sparse: sparse: Using plain integer as NULL pointer
> 
> Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
> ---
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Someone else posted this before you :)

https://lore.kernel.org/lkml/20191105055427.11943-1-jamal.k.shareef@gmail.com/

Will be good if you can review that. Thanks.

-- 
viresh
