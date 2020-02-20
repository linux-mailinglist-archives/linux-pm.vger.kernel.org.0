Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A423E165EF5
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 14:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgBTNjA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 08:39:00 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37584 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbgBTNjA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 08:39:00 -0500
Received: by mail-vs1-f65.google.com with SMTP id x18so2667694vsq.4
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 05:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9l++DCXufdLXm9XLDzVSaxos88atxrWAtSR1NHhF4gs=;
        b=ym2KXZVdEHiCU8vHjy8My+7wkUnHMQG/cOhk0DsdnYxgZq41d4MVywXZMGA6KAEIAU
         qMeqoITbdKNFQpjYOcsRmC1L3joYg4Taflrn+9aec4EMjAJ/iZZtFn+5GUZJqrEuus5m
         ckNujPDaYhol+D3bRW3q1Os7Zzimc1zJ/rZJIumZGleJeYIUnDUREoc2sofXnV0vdc5t
         78cNmFADz1TOyZ++mkMzNp/na3/0AiIv4fg8nDJUJEF8LbVMejm54oZ8+tY4w+GKY8Jx
         JYJ1KdFJ9bk8G7Pl9JbEt495Ckf1IJrXaZouEjSu9t/PXA3f3ApFwcli8iWb1WKDv36h
         DflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9l++DCXufdLXm9XLDzVSaxos88atxrWAtSR1NHhF4gs=;
        b=S+EKQvAPR6zy8jeitfUXzpE2yRJBz9Tw7PBVk8kZYSqAUNeVOjeYgP+hmmmriYphAM
         7NvAykqSm0VFa8PV432KvD1K00xY76KHXNmaTURlVDRxHdbmLtDldIZqN9YX7CD6sCxH
         +WbUBNXSNMOTGGOwVc390xH/a62Hu1+Vifzoldtu2p20eD46oHOpwCkWrhx2iBVzrLsZ
         NkZpBZTBTmGLfV30oxNqs2tHrGLVJffMSTlXaKlSsek3ephaX+GalljtVXWEFPTToIou
         BWeAL//61ufg24k0uoTUMweTW9LMcTb/6pdt0aP21TvQ8qSwwiePWE3AYkieBRgfgxQm
         2aTw==
X-Gm-Message-State: APjAAAXvBbwLUS42+9ePnC1jHgkCG1l8mGAamQ2Dq1hmiX2YGQlEPvQ2
        43sYcWE5sPKLrnZY8OFOpYiJoKDqXzTzXVFXOaVQFg==
X-Google-Smtp-Source: APXvYqxXwVhO8u4M/slsd7HjlRfC2UHqCmjvtpaM3sw1gBHnKEOXllmPORh09cMFgvW5/XqEvtTgO/1fjfHMN2zKMO4=
X-Received: by 2002:a05:6102:22d6:: with SMTP id a22mr16389607vsh.191.1582205937696;
 Thu, 20 Feb 2020 05:38:57 -0800 (PST)
MIME-Version: 1.0
References: <20200211160321.22124-1-paul@crapouillou.net> <20200211160321.22124-4-paul@crapouillou.net>
In-Reply-To: <20200211160321.22124-4-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 20 Feb 2020 14:38:20 +0100
Message-ID: <CAPDyKFquXSB+ztXZQS4MPV20dRN_-CKJkmCF0A97pG+vJYRsbg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] mmc: jz4740: Use pm_sleep_ptr() macro
To:     Paul Cercueil <paul@crapouillou.net>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        od@zcrc.me, Linux PM <linux-pm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 11 Feb 2020 at 17:03, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Use the newly introduced pm_sleep_ptr() macro to simplify the code.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/mmc/host/jz4740_mmc.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index fbae87d1f017..09554f9831de 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -1099,24 +1099,18 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM_SLEEP
> -
> -static int jz4740_mmc_suspend(struct device *dev)
> +static int __maybe_unused jz4740_mmc_suspend(struct device *dev)
>  {
>         return pinctrl_pm_select_sleep_state(dev);
>  }
>
> -static int jz4740_mmc_resume(struct device *dev)
> +static int __maybe_unused jz4740_mmc_resume(struct device *dev)
>  {
>         return pinctrl_select_default_state(dev);
>  }
>
>  static SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
>         jz4740_mmc_resume);
> -#define JZ4740_MMC_PM_OPS (&jz4740_mmc_pm_ops)
> -#else
> -#define JZ4740_MMC_PM_OPS NULL
> -#endif

All of the above code can be simplified in this way, without having to
convert into using the new pm_sleep_ptr() macro, below.

The only "penalty" would be that, the struct dev_pm_ops
(jz4740_mmc_pm_ops) would then be referenced even when CONFIG_PM* is
unset, thus the compiler would be able to throw it away.

Just wanted to point this out.

>
>  static struct platform_driver jz4740_mmc_driver = {
>         .probe = jz4740_mmc_probe,
> @@ -1124,7 +1118,7 @@ static struct platform_driver jz4740_mmc_driver = {
>         .driver = {
>                 .name = "jz4740-mmc",
>                 .of_match_table = of_match_ptr(jz4740_mmc_of_match),
> -               .pm = JZ4740_MMC_PM_OPS,
> +               .pm = pm_sleep_ptr(&jz4740_mmc_pm_ops),

If the driver would have runtime suspend/resume callbacks, then it
would need the use the pm_ptr() macro instead, I guess.

>         },
>  };
>
> --
> 2.25.0
>

My overall feeling is that this series improves the code/behaviour,
but I am also a bit worried about adding yet another pair of macros
for dealing with CONFIG_PM* callbacks as it could add more confusion.

An option could be to introduce only the pm_ptr() macro, then skip the
optimization that pm_sleep_ptr() gives. This could make it easier to
use, as you wouldn't need to decide between two macros. Just a
thought.

I don't know what Rafael's thinks about this, let's see if he has some
other ideas.

Kind regards
Uffe
