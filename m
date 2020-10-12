Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DEA28B249
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 12:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbgJLKee (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 06:34:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39474 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387463AbgJLKed (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 06:34:33 -0400
Received: by mail-oi1-f196.google.com with SMTP id c13so18243769oiy.6;
        Mon, 12 Oct 2020 03:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jvl1uNpai0+Z9/xkkl9P1c4uC5A00NigHSFBn2BljHM=;
        b=dYgdmI+A3jiryNepEr/LSkszwyxINfx3FRiJu8Gaeeb4eQKOeszbslwkCqvp5BdRWD
         hyoGxAK9cNX4T2/B29c1Scg5oeyyzknItLb63BqpYWtO1hYM8IPENzWGhiIgTV9v/ySa
         2+X4h4Gvoebcu8Fme4Z4CEsA9MIcArHQLez9aQlg2B5BjhL/OxPNVN0ZHg2j37OLOY7T
         57nhzXfZhO5N244B62dpn9t7hdiykm3z7oCMUBzXOPPOi6M06QwCMNiyzOrJwFs5PJFf
         kGS5lpN3eohArMijI4jNj0U/BqEyZIs69QxEF53q9W3up/hIQx2veKtiaRsrmnSFjSZh
         Bw/Q==
X-Gm-Message-State: AOAM530DdjpQ/LZ1YG8PpUz/rYTJagoT+LhDGJViBurht5mK/akMQ2wR
        04Vxxl7ot87459mNAl0/gNdgQdpwxuUoipllUIQ=
X-Google-Smtp-Source: ABdhPJx6uN7tu4QRGeMwub0VWq2S/xcIycEV9s+wBnNitxuxv9EtDYCkFI5lWj+m90/kr6Rv/9Sq0ZLFFLh8XmdQgy0=
X-Received: by 2002:aca:5256:: with SMTP id g83mr5839116oib.71.1602498871268;
 Mon, 12 Oct 2020 03:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <9c499a132d06f31e81a516c91bd92d619eb118ba.1602478204.git.viresh.kumar@linaro.org>
In-Reply-To: <9c499a132d06f31e81a516c91bd92d619eb118ba.1602478204.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Oct 2020 12:34:16 +0200
Message-ID: <CAJZ5v0iC7hs7jEdm0q3wnFycEr-WAZSKhiYkwPwGgkGDew3ZEw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: stats: Fix string format specifier mismatch
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 12, 2020 at 6:50 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Fix following warning:
>
> drivers/cpufreq/cpufreq_stats.c:63:10: warning: %d in format string (no.
> 1) requires 'int' but the argument type is 'unsigned int'
>
> Fixes: 40c3bd4cfa6f ("cpufreq: stats: Defer stats update to cpufreq_stats_record_transition()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 1b1389face85..6cd5c8ab5d49 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -62,7 +62,7 @@ static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
>         if (READ_ONCE(stats->reset_pending))
>                 return sprintf(buf, "%d\n", 0);
>         else
> -               return sprintf(buf, "%d\n", stats->total_trans);
> +               return sprintf(buf, "%u\n", stats->total_trans);
>  }
>  cpufreq_freq_attr_ro(total_trans);
>
> --

Applied, thanks!
