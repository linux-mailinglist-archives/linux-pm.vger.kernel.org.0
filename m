Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFCDDABD3
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 14:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393407AbfJQMSL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 08:18:11 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42376 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731634AbfJQMSK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 08:18:10 -0400
Received: by mail-ua1-f68.google.com with SMTP id r19so580372uap.9
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 05:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D4W/LUm+J8OxNKkDBXKqSGiLQb0w0oPg2mn0tFVhPes=;
        b=aUrV05JDeAStB20D0EX8t5S/U35e9v3DZtU8XmQCMwCu+E1mzgEFvRAaT62RK8LVhN
         0+gx3U0i+AMedaIcGuc7NNcHMTX2Ebp3L0dUnVqrKUSh4UZ8reHpCt8o5Pw7fmTgz8Uk
         PfGmF7U49F4uO8Qt7u44Ny9Pe+Tn/RCw/fo1+Zi5F2aDqEQhIVdck+z/PwbRCxMW+Zyu
         tfgxkaq0lGWgKKhhl69S5UOUTLfIxxNkF8Mc+AhjYtBftcvck8Q+uIiesqmy7pJ0DH8Y
         KJVkC2wh2eSWJ0mHB+pP3ssfzdAgfY+U0ZgyhYVjSgFKMBnTl7635nW0HUn5rWHnVgLF
         +5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4W/LUm+J8OxNKkDBXKqSGiLQb0w0oPg2mn0tFVhPes=;
        b=avMcmC5XjeJDUx2cNf5qd5Y6MYIpcfWX6fi4rHIhXhi7nsMhheqW41ueNXsAuCnL2J
         zwLJ9VD8ULbx1y6USoRWNqQgXutitYMVLAKmUENQxcxi0K/W1k5IaMfuy169rKFEeah8
         /cDIANOm9oYMJEE4EdBREqoIbKxVCQrNX9ydu3B0YX1d2QNL4FQV8dIYogwHUt1ggJIs
         T66J3ObrfCTzzeo2FQxmuODbP8W/ZK5r/ZI5VQBFvZ4LEsHqimsNTjodGJXQ6GvLz4jF
         ETQqeHdD1s5YqvKuIU/KaExy8gC8YX0PRGdIHbHBs9eueZFP47fzGdyDh/NU7JZ4D6AG
         t//Q==
X-Gm-Message-State: APjAAAW1YvzSXCQTZ8FgZ7g2Bi+HdGlHoXu14KfCPlFvbhZw2fuo6wJx
        kodiJfOWQ7JQc61yWPFH5Baq68Tq9SKEdIhIu8IkWw==
X-Google-Smtp-Source: APXvYqwtJORCUbSCwLJQHhNVBn6YlmaEa3VkSkslE27JU8UAlyFstCIC0GKWyqQLWVsobv/VC7fukLjO0zgVnbI+QwY=
X-Received: by 2002:ab0:4704:: with SMTP id h4mr2115415uac.67.1571314689598;
 Thu, 17 Oct 2019 05:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571307382.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571307382.git.amit.kucheria@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 17 Oct 2019 17:47:57 +0530
Message-ID: <CAHLCerOrMjG0JqBEUf3NqQijPwzjYkiq7Kkstrh+p91rvF9_Bg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Initialise thermal framework and cpufreq earlier
 during boot
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is embarassing. I generated this series incorrectly. It is
missing a patch removing netlink support. v3 coming right up.

Sorry for the noise.

On Thu, Oct 17, 2019 at 4:00 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> Changes since v1:
> - Completely get rid of netlink support in the thermal framework.
> - This changes the early init patch to a single line - change to
>   core_initcall. Changed authorship of patch since it is nothing like the
>   original. Lina, let me know if you feel otherwise.
> - I've tested to make sure that the qcom-cpufreq-hw driver continues to
>   work correctly as a module so this won't impact Android's GKI plans.
> - Collected Acks
>
> Device boot needs to be as fast as possible while keeping under the thermal
> envelope. Now that thermal framework is built-in to the kernel, we can
> initialize it earlier to enable thermal mitigation during boot.
>
> We also need the cpufreq HW drivers to be initialised earlier to act as the
> cooling devices. This series only converts over the qcom-hw driver to
> initialize earlier but can be extended to other platforms as well.
>
> Amit Kucheria (5):
>   thermal: Initialize thermal subsystem earlier
>   cpufreq: Initialise the governors in core_initcall
>   cpufreq: Initialize cpufreq-dt driver earlier
>   clk: qcom: Initialise clock drivers earlier
>   cpufreq: qcom-hw: Move driver initialisation earlier
>
>  drivers/clk/qcom/clk-rpmh.c            | 2 +-
>  drivers/clk/qcom/gcc-qcs404.c          | 2 +-
>  drivers/clk/qcom/gcc-sdm845.c          | 2 +-
>  drivers/cpufreq/cpufreq-dt-platdev.c   | 2 +-
>  drivers/cpufreq/cpufreq_conservative.c | 2 +-
>  drivers/cpufreq/cpufreq_ondemand.c     | 2 +-
>  drivers/cpufreq/cpufreq_performance.c  | 2 +-
>  drivers/cpufreq/cpufreq_powersave.c    | 2 +-
>  drivers/cpufreq/cpufreq_userspace.c    | 2 +-
>  drivers/cpufreq/qcom-cpufreq-hw.c      | 2 +-
>  drivers/thermal/thermal_core.c         | 3 ++-
>  11 files changed, 12 insertions(+), 11 deletions(-)
>
> --
> 2.17.1
>
