Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBAFFDB715
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 21:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441479AbfJQTL4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 15:11:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46355 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfJQTLz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 15:11:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id 89so2832044oth.13;
        Thu, 17 Oct 2019 12:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VfE4pHkEB0q49RVPM0ZsYNB/wm/zHNekWOHlQdV2NzA=;
        b=h53hc919+OW05u0DILT0VltiM+EeOYyRBSPpdh5FUWwIxdNFDb375AGuKuS7UxGq1A
         BQYyqowXplnd5svsCKifezkxgGtx4lTrNoAoaCqL1QFrqoYJedpI4HDpioih7cyhfpYc
         hkVtOeUzdgoN6W1z0v9gtR+9WUbEon6ZW0uZeCpBA2Sz/ieKd//cy2/DwpukRnP8hO1y
         QbrCLhb/hU2aU3iqy0WwQZknu+xxxnbtnkLqgHRn+/anIaFCtylm6lMQzDX1ZRpxn5Sy
         bgJX05pDcJ5o4+RJnkmbaWDEZmLzPeSq1cb3JnLnMv8ybM6kALlxXbfCqUXyKbpQD6c9
         lXNw==
X-Gm-Message-State: APjAAAVCPYevpQ5AAVCyn5PdzYm/cxqGGhj3beLIoYa6VNaH9WQe+7J6
        NQwYZe16wA0CewUDwNiCLxDW62rIsIMhpUyS4xw=
X-Google-Smtp-Source: APXvYqydr6smfx+tDiMQxWxqDxB06hSqqxbKElnCI8osB6kbMr16aaHPV2O8ujoYLv0xdf3M9Rs3nqRDSIyG+R+mEy8=
X-Received: by 2002:a9d:5a0f:: with SMTP id v15mr4515073oth.266.1571339514744;
 Thu, 17 Oct 2019 12:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571314830.git.amit.kucheria@linaro.org> <f1d7214951e4b2caa394c722b4d8aaca9cc2c4c4.1571314830.git.amit.kucheria@linaro.org>
In-Reply-To: <f1d7214951e4b2caa394c722b4d8aaca9cc2c4c4.1571314830.git.amit.kucheria@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Oct 2019 21:11:42 +0200
Message-ID: <CAJZ5v0gAyaXHrWe5x6ctz_zawFvudgpTVFCuwieBM5s=FMXysQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] cpufreq: Initialise the governors in core_initcall
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>, agross@kernel.org,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 17, 2019 at 2:28 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> Initialise the cpufreq governors earlier to allow for earlier
> performance control during the boot process.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

You also want to do that for the schedutil governor I think.

> ---
>  drivers/cpufreq/cpufreq_conservative.c | 2 +-
>  drivers/cpufreq/cpufreq_ondemand.c     | 2 +-
>  drivers/cpufreq/cpufreq_performance.c  | 2 +-
>  drivers/cpufreq/cpufreq_powersave.c    | 2 +-
>  drivers/cpufreq/cpufreq_userspace.c    | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index b66e81c06a57..737ff3b9c2c0 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -346,7 +346,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
>         return CPU_FREQ_GOV_CONSERVATIVE;
>  }
>
> -fs_initcall(cpufreq_gov_dbs_init);
> +core_initcall(cpufreq_gov_dbs_init);
>  #else
>  module_init(cpufreq_gov_dbs_init);
>  #endif
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index dced033875bf..82a4d37ddecb 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -483,7 +483,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
>         return CPU_FREQ_GOV_ONDEMAND;
>  }
>
> -fs_initcall(cpufreq_gov_dbs_init);
> +core_initcall(cpufreq_gov_dbs_init);
>  #else
>  module_init(cpufreq_gov_dbs_init);
>  #endif
> diff --git a/drivers/cpufreq/cpufreq_performance.c b/drivers/cpufreq/cpufreq_performance.c
> index aaa04dfcacd9..def9afe0f5b8 100644
> --- a/drivers/cpufreq/cpufreq_performance.c
> +++ b/drivers/cpufreq/cpufreq_performance.c
> @@ -50,5 +50,5 @@ MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
>  MODULE_DESCRIPTION("CPUfreq policy governor 'performance'");
>  MODULE_LICENSE("GPL");
>
> -fs_initcall(cpufreq_gov_performance_init);
> +core_initcall(cpufreq_gov_performance_init);
>  module_exit(cpufreq_gov_performance_exit);
> diff --git a/drivers/cpufreq/cpufreq_powersave.c b/drivers/cpufreq/cpufreq_powersave.c
> index c143dc237d87..1ae66019eb83 100644
> --- a/drivers/cpufreq/cpufreq_powersave.c
> +++ b/drivers/cpufreq/cpufreq_powersave.c
> @@ -43,7 +43,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
>         return &cpufreq_gov_powersave;
>  }
>
> -fs_initcall(cpufreq_gov_powersave_init);
> +core_initcall(cpufreq_gov_powersave_init);
>  #else
>  module_init(cpufreq_gov_powersave_init);
>  #endif
> diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
> index cbd81c58cb8f..b43e7cd502c5 100644
> --- a/drivers/cpufreq/cpufreq_userspace.c
> +++ b/drivers/cpufreq/cpufreq_userspace.c
> @@ -147,7 +147,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
>         return &cpufreq_gov_userspace;
>  }
>
> -fs_initcall(cpufreq_gov_userspace_init);
> +core_initcall(cpufreq_gov_userspace_init);
>  #else
>  module_init(cpufreq_gov_userspace_init);
>  #endif
> --
> 2.17.1
>
