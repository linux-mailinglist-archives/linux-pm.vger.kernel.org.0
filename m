Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABBF51BA35
	for <lists+linux-pm@lfdr.de>; Thu,  5 May 2022 10:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347271AbiEEI00 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 May 2022 04:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349558AbiEEI0A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2022 04:26:00 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FDB53B61
        for <linux-pm@vger.kernel.org>; Thu,  5 May 2022 01:21:13 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2ebf4b91212so40358767b3.8
        for <linux-pm@vger.kernel.org>; Thu, 05 May 2022 01:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KWHwsHAH/QNPAWhLW8VZQ58/vBlErs9/usiIXf3KUrM=;
        b=gfOnepr9p4T6e4DX9fXIsS/lXlfXLPOIMboG7QC7AhvSQqXD9OUAMPpF0z3/waGD0D
         XeQghg5wasvlfwxOCcj1rq9vEqnZIz3MmdkM/lmUPiNgpIs29AEmze8LbdMbZjG6Ppl6
         990cMEYj3x/t49XSKjftcWTDQn/E5JEpgrRT0u9kzb0//RgKeNF0xOmu9sYKwX8ShEPq
         hFM/BtKmE6wilxejb0d/p4INQ2MlR3IqynuzdsiDhc+m6cs/zCnQPmRssYb1J/Dt3g5o
         BUVFbMbCW93dS5zoMWZdOjlnAr2xmD0pCgGD+c7QRrbEmXlo4/wFaHNxx58GA4nDLwsR
         xPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWHwsHAH/QNPAWhLW8VZQ58/vBlErs9/usiIXf3KUrM=;
        b=kWHb7Yh487RauawT4zhatuiqVd875D+RFyBI/Q9Lz9HCXeNuvO3+5bShXxQ9l4S0bd
         emwmYCN8di34sEtfpjme86kg2/uhtrq+NT63PUALQ3sotO/kUMmKOe8detk98vmDjM+2
         jDAWucyG2294ZFOhW5Crdg1dJlKuXYSDMsvRhVBZomVqUhK68HwNlroYbA3+QdbHgxpJ
         Jbjwsic0ZRVikMPXuRqHiBbdQFJOTJdSext8NWEw20HzLApz1Ik8xDJCON8UDEhqxsjb
         BD5JPVRVhtby5Spkjt4MKxny5Nu464LzHZ3V7em0OXL++WhCaZBBGwwL44IgnDK1Lsch
         uRRQ==
X-Gm-Message-State: AOAM531kqgoZn0E8h4Q8/aaqnWkRgyR0IC6Q+f/12xMM51tw1WNyn9sy
        6DPfryqEtpkVxP4nDW1eUUuKQnkc5mmd6sAkVqJrpQ==
X-Google-Smtp-Source: ABdhPJzui0KnZztjb5KstyzUpmWxsYAZfym4/bUssFwP1MMh4zPXCOqTOLPEIjR0Y/5C69tQGwJC+KpVlnbcmXo2J/Q=
X-Received: by 2002:a81:6189:0:b0:2eb:deb5:9f63 with SMTP id
 v131-20020a816189000000b002ebdeb59f63mr21498742ywb.319.1651738873208; Thu, 05
 May 2022 01:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <39e39a7d30c8ee6af81fb64670a330abeb87402e.1651652493.git.viresh.kumar@linaro.org>
 <CAKfTPtDbsd+RLwY+0ZfnNWkQD+jOHmoX2K+ZfsOMnEH81ouVjw@mail.gmail.com> <20220505074408.ayzmd5kdbw2fagbq@vireshk-i7>
In-Reply-To: <20220505074408.ayzmd5kdbw2fagbq@vireshk-i7>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 5 May 2022 10:21:01 +0200
Message-ID: <CAKfTPtCuJGsrsBJ2jACr_YeKN3RXNVMkgRgo+cw9t7CAyGwHWQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Avoid unnecessary frequency updates due to mismatch
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 5 May 2022 at 09:44, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 05-05-22, 09:28, Vincent Guittot wrote:
> > On Wed, 4 May 2022 at 10:21, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > For some platforms, the frequency returned by hardware may be slightly
> > > different from what is provided in the frequency table. For example,
> >
> > Do you have more details ?
>
> This is where the problem was discussed.
>
> https://lore.kernel.org/lkml/20220422075239.16437-8-rex-bc.chen@mediatek.com/

Thanks for the link

>
> > Do you mean that between 2 consecutives reads you can get either
> > 500Mhz or 499Mhz ?
>
> No, the hardware always returns something like 499,999,726 Hz, but the

Part of your problem is that cpufreq use khz whereas clock uses hz

Would it be better to do something like below in cpufreq_generic_get

(clk_get_rate(policy->clk) + 500) / 1000

so you round to closest instead of always floor rounding


> OPP table contains the value 500 MHz. The field policy->cur is set
> based on opp table eventually (target_index) and so contains 500MHz,
> almost always. But when cpufreq_get() is called, it finds the current
> freq is 499 MHz, instead of 500 MHz. And so the issue.
>
> > Or is it a fixed mismatch between the table and the freq returned by HW ?
>
> Yes.
>
> --
> viresh
