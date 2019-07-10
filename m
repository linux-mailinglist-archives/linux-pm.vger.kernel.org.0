Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC6B164824
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 16:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfGJOUB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 10:20:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37501 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfGJOUB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 10:20:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id z28so2285166ljn.4;
        Wed, 10 Jul 2019 07:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PfXp9O7NkxQUzXeKEd8RHmqfUCQPLxouDpd9A/Tc3mg=;
        b=RksVEUHero0wvQ1UcYgh96O6ZP2FyuowK7EqMgdY8AFRdUbDQCaVPIU0oaYLqYF+X7
         ipF7LoRLHh2LjpZdICDvYRm3oF9tSLpw40GdgEBpS8jbwxgpoKP4HLPByJsE4rVotiFL
         Q5UFDvX2E2J2FBkZN627uwpy6fZtVuOttHsvjzSmIRXAxU4Kf4X2rPbUpTfvkSpz9235
         zMwi1albNT6qJPj/ECFOJ7tg/aWUUc/ixwJ0pJC+DHMo2Q3DAwIvCcdy8c6eBtVzGgOw
         1UslE3BXlr6eNJj6eQYkvZlbPivsc8JkMXRw5VnMXfwXiaJxlqGDRNuX0ECQQ7ZNym4C
         mUBQ==
X-Gm-Message-State: APjAAAUN3LcovAwmRIw0ZP5e22lXJpW3E1KnV7uxsG52bdr32uGGkXnY
        2MoSCyfJE0bzRN8yOmAiSw7adlPan4R7oq42pnhl4pBA
X-Google-Smtp-Source: APXvYqzPPqJ5Um9RE3P5Mh6iXGaD0KDMa3tuZzVJrMnQ1d95d45Xx642SUQwvj61pR1zzl/Y33AaK/wwgZVtva+atxU=
X-Received: by 2002:a2e:b0c4:: with SMTP id g4mr17000838ljl.155.1562768398488;
 Wed, 10 Jul 2019 07:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190708124743.3585020-1-arnd@arndb.de> <1562765663.2597.16.camel@intel.com>
In-Reply-To: <1562765663.2597.16.camel@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 10 Jul 2019 16:19:41 +0200
Message-ID: <CAK8P3a09EHDzjhz9dD9DPGujuBz-=RqhtTM58rqBedJVSxLFjg@mail.gmail.com>
Subject: Re: [PATCH] drivers: thermal: processor_thermal: mark pm function __maybe_unused
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 10, 2019 at 3:34 PM Zhang Rui <rui.zhang@intel.com> wrote:

>
> From 6c395f66e98c895cf3ebf87c0b2fc63b6a57a196 Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Tue, 9 Jul 2019 21:19:12 +0800
> Subject: [PATCH] drivers: thermal: processor_thermal_device: Fix build warning
>
> As a system sleep callback, proc_thermal_resume() should be defined only
> if CONFIG_PM_SLEEP is set.
>
> This fixes a build warning when CONFIG_PM_SLEEP is not set,
> drivers/thermal/intel/int340x_thermal/processor_thermal_device.c:446:12: error: 'proc_thermal_resume' defined but not used [-Werror=unused-function]
>  static int proc_thermal_resume(struct device *dev)
>
> Fixes: aaba9791fbb4 ("drivers: thermal: processor_thermal: Read PPCC on resume")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

This looks correct to me as well.

> ---
>  drivers/thermal/intel/int340x_thermal/processor_thermal_device.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index a3210f0..77dae1e 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -443,6 +443,7 @@ static void  proc_thermal_pci_remove(struct pci_dev *pdev)
>         pci_disable_device(pdev);
>  }
>
> +#ifdef CONFIG_PM_SLEEP
>  static int proc_thermal_resume(struct device *dev)
>  {
>         struct proc_thermal_device *proc_dev;
> @@ -452,6 +453,9 @@ static int proc_thermal_resume(struct device *dev)
>
>         return 0;
>  }
> +#else
> +#define proc_thermal_resume NULL
> +#endif

I would suggest you drop the #else part though, as it is not needed here.

Please apply whichever version you find most readable otherwise.

Thanks,

       Arnd
