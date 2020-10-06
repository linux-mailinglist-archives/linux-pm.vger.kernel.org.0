Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36F1284CC0
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 15:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgJFN50 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 09:57:26 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34947 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgJFN5Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 09:57:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id s66so12354488otb.2;
        Tue, 06 Oct 2020 06:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1lgbO0KN64aF6ELTrDTiOq+HH8RynZOzp1I+2Xq3iQ=;
        b=YJC3Ek+wl9J5yVxvEwgrtYwijFlZ7wnAElOBciaVdvKX4IKihexzZfnqaABJJCkq2K
         vTZgpLvxCBIuzFCwCeZOAgp/rBS5Qoh0EOgibiET35GlqsdMu/19nKwDQmD/UuniRI2x
         oQqYwsV0ukHOcfDsnaE2mxSJHrbXn3G6q0QgM6sgY+2IAPv9hYUSHOrmLvtdBtFrGpqD
         wDa7Z8PSuoOoIVskk0/MaDa17DMla808HkZqgBjc/U57im3lKDRo7QKAnsOaFcjrf76d
         5wMuTKtiH71w65INZ6XZUtwntHjCpbkLHLuQ4BD+9sEB0wLVwJ0IJDVLDSKaCbbssbP+
         1yHg==
X-Gm-Message-State: AOAM530vRR4JWQzam9mVvvVpcfmVEYayzYRp+24NfVSVtUz0Hj9VKQA3
        tiszj8id9uTbCuQszm+R1GY0MGpCqcDmrvYTmUsDZOPH
X-Google-Smtp-Source: ABdhPJyJdIV1d8C93RfqaZttnkALg6b33zImxohE26jQQRq+Bd0F3IQ2A2x9c3gdCn6wmTBCBRuJK/B5YvLI9/2ifdA=
X-Received: by 2002:a9d:734f:: with SMTP id l15mr3185667otk.260.1601992644679;
 Tue, 06 Oct 2020 06:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <7155888.fM3j0pV3QS@kreacher>
In-Reply-To: <7155888.fM3j0pV3QS@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Oct 2020 15:57:13 +0200
Message-ID: <CAJZ5v0h5kQD-Grvw1eNP-STQ3PH03cYErpC+VV43nV0q4qO6yg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: stats: Add memory barrier to store_reset()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 6, 2020 at 1:59 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> There is nothing to prevent the CPU or the compiler from reordering
> the writes to stats->reset_time and stats->reset_pending in
> store_reset(), in which case the readers of stats->reset_time may see
> a stale value.  Moreover, on 32-bit arches the write to reset_time
> cannot be completed in one go, so the readers of it may see a
> partially updated value in that case.
>
> To prevent that from happening, add a write memory barrier between
> the writes to stats->reset_time and stats->reset_pending in
> store_reset().
>
> Fixes: 40c3bd4cfa6f ("cpufreq: stats: Defer stats update to cpufreq_stats_record_transition()")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> I couldn't convince myself that it was OK to leave the code as it was.
>
> linux-next material.
>
> ---
>  drivers/cpufreq/cpufreq_stats.c |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> Index: linux-pm/drivers/cpufreq/cpufreq_stats.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_stats.c
> +++ linux-pm/drivers/cpufreq/cpufreq_stats.c
> @@ -99,6 +99,13 @@ static ssize_t store_reset(struct cpufre
>          * avoid races.
>          */
>         WRITE_ONCE(stats->reset_time, get_jiffies_64());
> +       /*
> +        * The memory barrier below is to prevent the readers of reset_time from
> +        * seeing a stale or partially updated value. Note that they both access
> +        * reset_time only if reset_pending is 1, so corresponding read barriers
> +        * are not needed.

I'm taking this back after double-checking memory-barriers.txt.

Will send a v2.

> +        */
> +       smp_wmb();
>         WRITE_ONCE(stats->reset_pending, 1);
>
>         return count;
>
>
>
