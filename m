Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA70421D794
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 15:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgGMNwu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 09:52:50 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40751 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbgGMNwu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 09:52:50 -0400
Received: by mail-oi1-f193.google.com with SMTP id t198so11008040oie.7;
        Mon, 13 Jul 2020 06:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UTOSP8CmAN/brRf5qrtudeU7fQ1Ik4iA8qlKt3ENOLg=;
        b=niv9km/zC2bREr/OgF9N2/SzTB9OtQBd6PlwGk14Ury0cTMvdzGTqCCHO59g4yhOru
         N68lvEgd4Gokj3l3UYOeU3XCimlew/nUyFrEClHbE44Q2dCNKDci9ehKm37nFEmG9XhZ
         Z+01YsOkgqTbO5fguZz6UUeoLnew/bAAt4VEfKdsvcRHQsUQ14bRZsnqjAo6ZdDzM4QL
         9BnKlH9rSw9KAsPGTlouHp8L7chK2htF2lltQvGsqjsKdkIsMYeA7Z4Y77K0idsdeev4
         2Yc0vpcXV4su+cVb5U2RT1nIEtPFOdidLDtiAEDH8OyJWFjWAxiJw/t++Y8wCuSv/TVJ
         dlIg==
X-Gm-Message-State: AOAM531Se6s6S8JzNlGfVtHQbxRu+xCJ0H43K6ra9lTA63UQhf/qshWv
        GQlqUhT5QMXEOMdpUUIS338h3pz3V4sNkRk0HCKLhA==
X-Google-Smtp-Source: ABdhPJyACb7vJrkMQ2E5g2Yr8GkMR4QvYEEnISjH0AXD3dBEMv/lAPecNlmIOn5fcWeDKVb0wlFQIjkCfUkQJK0Ik44=
X-Received: by 2002:aca:4a89:: with SMTP id x131mr14518559oia.103.1594648369100;
 Mon, 13 Jul 2020 06:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200709200522.3566181-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20200709200522.3566181-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Jul 2020 15:52:38 +0200
Message-ID: <CAJZ5v0j-HC0azxizK0eJcDOt3_HmRid2DqZRk86ne0mE-5nZ4A@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix static checker warning for epp variable
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 9, 2020 at 10:05 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Fix warning for:
> drivers/cpufreq/intel_pstate.c:731 store_energy_performance_preference()
> error: uninitialized symbol 'epp'.
>
> This warning is for a case, when energy_performance_preference attribute
> matches pre defined strings. In this case the value of raw epp will not
> be used to set EPP bits in MSR_HWP_REQUEST. So initializing with any
> value is fine.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> This patch is on top of bleed-edge branch at
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/rafael/linux-pm
>
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 44c7b4677675..94cd07678ee3 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -709,7 +709,7 @@ static ssize_t store_energy_performance_preference(
>         struct cpudata *cpu_data = all_cpu_data[policy->cpu];
>         char str_preference[21];
>         bool raw = false;
> -       u32 epp;
> +       u32 epp = 0;
>         int ret;
>
>         ret = sscanf(buf, "%20s", str_preference);
> --

Applied, thanks!
