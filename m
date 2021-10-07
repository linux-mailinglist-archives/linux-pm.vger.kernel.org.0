Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1736A42594E
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 19:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241411AbhJGRYu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 13:24:50 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:35417 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241253AbhJGRYt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 13:24:49 -0400
Received: by mail-ot1-f42.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so8431491otj.2
        for <linux-pm@vger.kernel.org>; Thu, 07 Oct 2021 10:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24H2bYEHJlPd44bZdsg325NW2L0CaxiP3otZVJAiHAU=;
        b=tGXCfCyiuW6lc1fDImgAa5jbfjZFrdV3JWFe8QLFKZ6ae1Hy90V32I5YoSjMPQfMkj
         +E/WuB/fTafQfyM8yyGa3ov7FIY0n6w6EnrjPjd1ge+dIIMjjI76kAcpPPTJZrfMQOJl
         wpu+t7u8I9QxrGohMky/GsChKRBDt4xRxHAMQRUjroae4Ts307clhmkc9CQ82U3rQCoB
         YlPhFA/i30H7KNE8JABbuLH8pe72XTSJqWt8jKfFRcEMKxNX/TDG2sOkoJvEEphqEp8O
         joUQuFWiAbDAlBoKyFdGNRUfn2iEk+klLfoC01nTfC5CemT2YRdfB+QV5pUUvZGuIpjs
         Q3hQ==
X-Gm-Message-State: AOAM530T4ph1NQoPA3syVNjF2C8Rto0cHnNPXsz6N9i7Ne9V9x+1Ujkk
        isoH+t7mgONQsD+RFFmCuU/SU6k4IJh5wKxsonE=
X-Google-Smtp-Source: ABdhPJyoSgshohga70QPc/8EHLZ3Ci8+c/gYzOV1qeV00eUigLjIKXuiTAwbD/smHDJYvkCJdGZBdLTBsCVktN0LnXI=
X-Received: by 2002:a9d:3783:: with SMTP id x3mr4726417otb.16.1633627375719;
 Thu, 07 Oct 2021 10:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211007164218.169942-1-vincent.donnefort@arm.com>
In-Reply-To: <20211007164218.169942-1-vincent.donnefort@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Oct 2021 19:22:44 +0200
Message-ID: <CAJZ5v0hnraazygV23peOKJeaWtyaD2BHtNA21Q_HqmKnZ453Rw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: mediatek-hw: Fix cpufreq_table_find_index_dl call
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>, hector.yuan@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 7, 2021 at 6:43 PM Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> The new cpufreq table flag RELATION_E introduced a new "efficient"
> parameter for the cpufreq_table_find*() functions.
>
> Fixes: 1f39fa0dccff (cpufreq: Introducing CPUFREQ_RELATION_E)
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
>
> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
> index 0cf18dd46b92..8ddbd0c5ce37 100644
> --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -109,7 +109,7 @@ static unsigned int mtk_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
>         struct mtk_cpufreq_data *data = policy->driver_data;
>         unsigned int index;
>
> -       index = cpufreq_table_find_index_dl(policy, target_freq);
> +       index = cpufreq_table_find_index_dl(policy, target_freq, false);
>
>         writel_relaxed(index, data->reg_bases[REG_FREQ_PERF_STATE]);
>
> --

Applied, thanks!
