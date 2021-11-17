Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB1A454DB5
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 20:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240396AbhKQTPU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 14:15:20 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:34601 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239360AbhKQTPR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 14:15:17 -0500
Received: by mail-ot1-f54.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso6540410otj.1;
        Wed, 17 Nov 2021 11:12:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MnAMjGLOXx6DvBCS9oZtgNlomICCRY8t0AJal7Xoa3A=;
        b=FyvCu1QG+i4jTtgFWEMqJkp3cY4md8rIPysonCKmIiR6Etkh9wH3nEvvnwUWNZpoSu
         bw/KqlBeRXJxa8nxYidWDzqRMyK2MAtpfi2rCG72b/N9Gntg3H9nVjRQeUJZ0Oxh9mrc
         HiNTBo++HjKTgYYrzwZOLqwK6BU1OjzY/xeRXwPabOIRttsg4OugQhf+xDi21X2VXSym
         w3sZIl6Xcf4cUkXn+6zQz1JMHu6rHXsLeThezlHR3TE1kSL+5vvKjHKkG3torPiWtMwu
         Mmrx75NFKkrQ6ormJyIP3tC9wYMUhXGr8wAJQMGY1A6PuOF+YvJetSDV+CZXprbWEDpq
         gROA==
X-Gm-Message-State: AOAM533uVribdEnx+B/7AFMSh8wkNDA7bTtHUqH8HqP9Y2d+ic/ibE7I
        G7In4YJDcyrZdfv98EPk+PSxV0EcN2J+dbX+VTE=
X-Google-Smtp-Source: ABdhPJxFpvJcS8885hNPvt5g4wNk+Q3lLMHW4EiJcACCmIcqToTlQqF/jQ6RNx4yfFh7SYN8Qz7gX0Cee/Z/LrVRQvQ=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr15890840otu.254.1637176336374;
 Wed, 17 Nov 2021 11:12:16 -0800 (PST)
MIME-Version: 1.0
References: <20211112091657.9848-1-attofari@amazon.de>
In-Reply-To: <20211112091657.9848-1-attofari@amazon.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 Nov 2021 20:12:05 +0100
Message-ID: <CAJZ5v0i_hc8=uX_y=1z+FvOWR1-eZVbUAGf3VQ15k+gEcOrVpQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Add Ice Lake server to out-of-band IDs
To:     Adamos Ttofari <attofari@amazon.de>
Cc:     Hendrik Borghorst <hborghor@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 12, 2021 at 10:17 AM Adamos Ttofari <attofari@amazon.de> wrote:
>
> Commit fbdc21e9b038 ("cpufreq: intel_pstate: Add Icelake servers support in
> no-HWP mode") enabled the use of Intel P-State driver for Ice Lake servers.
> But it doesn't cover the case when OS can't control P-States.
>
> Therefore, for Ice Lake server, if MSR_MISC_PWR_MGMT bits 8 or 18 are
> enabled, then the Intel P-State driver should exit as OS can't control
> P-States.
>
> Fixes: fbdc21e9b038 ("cpufreq: intel_pstate: Add Icelake servers support in no-HWP mode")
>
> Signed-off-by: Adamos Ttofari <attofari@amazon.de>
> Cc: Hendrik Borghorst <hborghor@amazon.de>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 815df3daae9d..1088ff350159 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2353,6 +2353,7 @@ static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
>         X86_MATCH(BROADWELL_D,          core_funcs),
>         X86_MATCH(BROADWELL_X,          core_funcs),
>         X86_MATCH(SKYLAKE_X,            core_funcs),
> +       X86_MATCH(ICELAKE_X,            core_funcs),
>         {}
>  };
>
> --

Applied as 5.16-rc material, thanks!
