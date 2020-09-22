Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529372745EB
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 18:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgIVQA6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 12:00:58 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:44221 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgIVQA5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 12:00:57 -0400
Received: by mail-oo1-f68.google.com with SMTP id 4so4256911ooh.11;
        Tue, 22 Sep 2020 09:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/hRlydglRVNXGFoU5hGQ1OeE+TAhwihYs4cEF4JRKk=;
        b=gz86OH+HpYLnBdzK/QUu9XlpuaFd2uzzOC9LJ1knvkGkztqpKVNoHvfmvkZ6SAvXTX
         l5N3C9id5wzVSnJpF2pwEMu41561l1EGV7CQdl1l2jpwIkkPtoXPI+dgrlsIK68htyoO
         5Rq9JFTzdzrd5BEx0XmHehG4FxAvQJ8UN8VUjzR/E8KUwc05sBg8QnGAmtEaNnbekMia
         WpK+C0WspQaZm2dz7WQMg9uBGQYtbn2EivYTX4pU4vAby9FPJfcqLcMZ2DCost/Z8JpT
         h278KUgKDVNADMca49nHtYPR25cqJfLFNRoPZjV3unrTomP0rssEUkU2GdKSTzSpRbJw
         KQeA==
X-Gm-Message-State: AOAM531/gHhBhNEcFmBxRI+LMGtXsn20pgFjJ5bfxfwmpbZ4xESGI5J/
        tpcsG6l+LVxBFGOYVwxMmGMeadDdexYiJgq5ulsLx5QO
X-Google-Smtp-Source: ABdhPJwPlzVeoIp5EXVpgwLPJHxkkTMde+CYnD3pSoPHHTQUx9UC7vyQSq4tI4eS1iqlVxdTz9R57eCXssrFWRb9cJc=
X-Received: by 2002:a4a:5d84:: with SMTP id w126mr3444250ooa.1.1600790456701;
 Tue, 22 Sep 2020 09:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <010101746fc98add-45e77496-d2d6-4bc1-a1ce-0692599a9a7a-000000@us-west-2.amazonses.com>
In-Reply-To: <010101746fc98add-45e77496-d2d6-4bc1-a1ce-0692599a9a7a-000000@us-west-2.amazonses.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Sep 2020 18:00:45 +0200
Message-ID: <CAJZ5v0hJJxxb+J5UtyZe2S_Tn7ARoGvjwDjw4dq601VJrriH9g@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: governor: export cpuidle governor functions
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sorry for the delay.

On Wed, Sep 9, 2020 at 12:15 AM Lina Iyer <ilina@codeaurora.org> wrote:
>
> Commit 83788c0caed3 ("cpuidle: remove unused exports") removed
> capability of registering cpuidle governors, which was unused at that
> time. By exporting the symbol, let's allow platform specific modules to
> register cpuidle governors and use cpuidle_governor_latency_req() to get
> the QoS for the CPU.

Which platform-specific modules may want to do that and why?

> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  drivers/cpuidle/governor.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
> index 29acaf48e575..0e51ed25665e 100644
> --- a/drivers/cpuidle/governor.c
> +++ b/drivers/cpuidle/governor.c
> @@ -102,6 +102,7 @@ int cpuidle_register_governor(struct cpuidle_governor *gov)
>
>         return ret;
>  }
> +EXPORT_SYMBOL_GPL(cpuidle_register_governor);
>
>  /**
>   * cpuidle_governor_latency_req - Compute a latency constraint for CPU
> @@ -118,3 +119,4 @@ s64 cpuidle_governor_latency_req(unsigned int cpu)
>
>         return (s64)device_req * NSEC_PER_USEC;
>  }
> +EXPORT_SYMBOL_GPL(cpuidle_governor_latency_req);
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
