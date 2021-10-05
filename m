Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C114D422B49
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 16:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhJEOoI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 10:44:08 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:43923 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhJEOoH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 10:44:07 -0400
Received: by mail-oi1-f177.google.com with SMTP id o4so2583766oia.10;
        Tue, 05 Oct 2021 07:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZwLpL3VR1cDxPTIuLWceDkViaFbLKix0Hx3TUG7elc=;
        b=SU3ofwoQli/UBW8PwznNzXTHtUtlVI4P8/WZCpJpEqcK8RL01sekP7dwCQR+MDjHND
         /KpyGNU3I99K4La/USw4iDmhCctIoSsEVdLraq5QhBeS8SwHv8f96yGAZZnuBXdUvQUH
         +vlcuund9X/mgXJEGjDCdN5JufBizxDDuHkP5Ic2NOZR87VJJdo0QN02oBFoi59IjqSx
         aBr6LLlGZ+awJO717qiEOcdWmlUk6m/vaiZrPKdXAQk84yHrAS7exsX4mGQ/CTA4Yygd
         DD1Hrz1vJ3mM2PzdeUgFUnZryf+sa/THKDigJ9mkuVaOjm0zbUTXVne5HY6FFolUIa90
         YkFg==
X-Gm-Message-State: AOAM532ui/9KjAR90Tumk/5CGV7I4KSIobrsGDcdebbd7+h8e6ZTkENt
        cH+RhUAzsivjmxAAgXIq2RoqRyz/Tt7M8FENxoI=
X-Google-Smtp-Source: ABdhPJwBSQTruG4tXHdQMFKRNdq9o7SvD0P5bn3E9E1CZEYOchSGi2uTsPDGXPY9h9SA95cqB2Yd2ha3bikKX6rl05E=
X-Received: by 2002:a05:6808:1816:: with SMTP id bh22mr2786784oib.69.1633444936747;
 Tue, 05 Oct 2021 07:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <f7513027ae9242643b5ddb6ed48a3aeca1b0f2a8.1632640557.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <f7513027ae9242643b5ddb6ed48a3aeca1b0f2a8.1632640557.git.christophe.jaillet@wanadoo.fr>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Oct 2021 16:42:05 +0200
Message-ID: <CAJZ5v0hSRn2Au5phOHnoR3SMtA0B-H_tn+dskHSZEfHt1g9G_g@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel_powerclamp: Use bitmap_zalloc/bitmap_free
 when applicable
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Sep 26, 2021 at 9:17 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'cpu_clamping_mask' is a bitmap. So use 'bitmap_zalloc()' and
> 'bitmap_free()' to simplify code, improve the semantic of the code and
> avoid some open-coded arithmetic in allocator arguments.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/thermal/intel/intel_powerclamp.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> index a5b58ea89cc6..9b68489a2356 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -705,10 +705,8 @@ static enum cpuhp_state hp_state;
>  static int __init powerclamp_init(void)
>  {
>         int retval;
> -       int bitmap_size;
>
> -       bitmap_size = BITS_TO_LONGS(num_possible_cpus()) * sizeof(long);
> -       cpu_clamping_mask = kzalloc(bitmap_size, GFP_KERNEL);
> +       cpu_clamping_mask = bitmap_zalloc(num_possible_cpus(), GFP_KERNEL);
>         if (!cpu_clamping_mask)
>                 return -ENOMEM;
>
> @@ -753,7 +751,7 @@ static int __init powerclamp_init(void)
>  exit_unregister:
>         cpuhp_remove_state_nocalls(hp_state);
>  exit_free:
> -       kfree(cpu_clamping_mask);
> +       bitmap_free(cpu_clamping_mask);
>         return retval;
>  }
>  module_init(powerclamp_init);
> @@ -764,7 +762,7 @@ static void __exit powerclamp_exit(void)
>         cpuhp_remove_state_nocalls(hp_state);
>         free_percpu(worker_data);
>         thermal_cooling_device_unregister(cooling_dev);
> -       kfree(cpu_clamping_mask);
> +       bitmap_free(cpu_clamping_mask);
>
>         cancel_delayed_work_sync(&poll_pkg_cstate_work);
>         debugfs_remove_recursive(debug_dir);
> --

Applied as 5.16 material, thanks!
