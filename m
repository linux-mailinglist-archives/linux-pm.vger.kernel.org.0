Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80B7402EE8
	for <lists+linux-pm@lfdr.de>; Tue,  7 Sep 2021 21:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345741AbhIGTXY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 15:23:24 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:39591 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhIGTXY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Sep 2021 15:23:24 -0400
Received: by mail-ot1-f53.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so432987otf.6;
        Tue, 07 Sep 2021 12:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgE8n2XBuDWUjLNWs+xuJzzbE0IA3RAmLHrQEOuCVVY=;
        b=FqWJ670/sgD6sdq70pY9r+b9eKqAaZEvhqX0K67nfcTn+swoKkVrjVZIYd4J+HEl3N
         1TAhpYsWs4pdkmxB/2hnTs9/cnkALiEA44bpkzME6bZ4djmZ2XlCC8qSSgMDgxjt39fU
         mfVwkdfPrL+g1LAiNtTnC24sYjr1HRY7r/2wkpfogqYrSJ/QhA+F3zC5/sTtMdk+rzOJ
         aeBx491+ux8OZhWUEDJpakl7AEWsJzGcEwsJ8u4slqrFw/R1k9auZXnDeMwGB0za+aqT
         74JZJyr9yM8lRz/FXorG5BVUh2HaISDiDousInERy6He69unQXIJq8kTVxYHaYnWxyy2
         OB6Q==
X-Gm-Message-State: AOAM5327uRxZM9Vnm4IIzniOHuU0dt3EWvvRaqVQrT/J/BVnARyLo7+7
        Ia/X+OwC6/R87xQaemmtF2mHOsrwhfOUTTDty+M=
X-Google-Smtp-Source: ABdhPJxc4BdQNpDIK1GmZ5K5m4v3jZkftlFVLPS2qER5wC8w/kttW9KeGeI0bxZ1ZbaMzbEJkbZncbdG2Yttl0dRzx4=
X-Received: by 2002:a05:6830:34b:: with SMTP id h11mr16713121ote.319.1631042537114;
 Tue, 07 Sep 2021 12:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210906084453.3068-1-lukasz.luba@arm.com>
In-Reply-To: <20210906084453.3068-1-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Sep 2021 21:22:06 +0200
Message-ID: <CAJZ5v0hSzzkVzO0CuP0sf16p70kppfr6oHU1VDjfuBqt_HVfSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: EM: fix kernel-doc comments
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 6, 2021 at 10:46 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Fix the kernel-doc comments for the improved Energy Model documentation.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/linux/energy_model.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 1834752c5617..39dcadd492b5 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -11,7 +11,7 @@
>  #include <linux/types.h>
>
>  /**
> - * em_perf_state - Performance state of a performance domain
> + * struct em_perf_state - Performance state of a performance domain
>   * @frequency: The frequency in KHz, for consistency with CPUFreq
>   * @power:     The power consumed at this level (by 1 CPU or by a registered
>   *             device). It can be a total power: static and dynamic.
> @@ -25,7 +25,7 @@ struct em_perf_state {
>  };
>
>  /**
> - * em_perf_domain - Performance domain
> + * struct em_perf_domain - Performance domain
>   * @table:             List of performance states, in ascending order
>   * @nr_perf_states:    Number of performance states
>   * @milliwatts:                Flag indicating the power values are in milli-Watts
> @@ -103,12 +103,12 @@ void em_dev_unregister_perf_domain(struct device *dev);
>
>  /**
>   * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
> -               performance domain
> + *             performance domain
>   * @pd         : performance domain for which energy has to be estimated
>   * @max_util   : highest utilization among CPUs of the domain
>   * @sum_util   : sum of the utilization of all CPUs in the domain
>   * @allowed_cpu_cap    : maximum allowed CPU capacity for the @pd, which
> -                         might reflect reduced frequency (due to thermal)
> + *                       might reflect reduced frequency (due to thermal)
>   *
>   * This function must be used only for CPU devices. There is no validation,
>   * i.e. if the EM is a CPU type and has cpumask allocated. It is called from
> --

Applied as 5.15-rc material along with the [2/2], thanks!
