Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4471C2702F8
	for <lists+linux-pm@lfdr.de>; Fri, 18 Sep 2020 19:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIRRMg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Sep 2020 13:12:36 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:36227 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRRMg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Sep 2020 13:12:36 -0400
Received: by mail-oo1-f65.google.com with SMTP id z1so1609466ooj.3;
        Fri, 18 Sep 2020 10:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=haTV4N92YD3XTJg4rwyqtCpCekV18WFtoLI6oSZhE3U=;
        b=opdr0B2G1MC7m32DULisZja+CpZTrkCfcLo5/3Ghu2eBZQ7qmOkP/7NCUtyFIBJxIO
         qNr8qYG6NiZ6jumxLj+Kk1UW9UMxqArw/rAVbVLaeFMnwGQN7L9gMwFpi97g0O/ctkCs
         EzPYS/FubkBCKksg+nqujjZdNKT0yTXtBX11lp+6pFD4J+JPc1LLl+8i9UXxqPipQQUs
         +LAajxx9rAv8iMx401GzY4PbFdG7ZS5TDy7nAks7TUdQisYhYsBXiXnX4Q4KWaMd/HUO
         LxHaoFp3duqUQdOS/S5E/lmv482NcyyBCVJJYabWUvt9Vb/xCMxhnXoepddSo7OXmZT2
         /mhQ==
X-Gm-Message-State: AOAM533DL8FgKWsu+NRSAfPhKAJhRQjGBI58Dw9/KmyahvrP7WLlYHG8
        eCwia47as/ziwuAxYYNpY5lh6WJZaFNkKcm0VcmafTer
X-Google-Smtp-Source: ABdhPJwL1pK1aC3NkV/cbjkQ6IF7RJiX/D3Bf9dlGIvpUFgRXkUm1YCRuFPkB0F0UxNSPMxqcDjX8rURoVMXFirGu6A=
X-Received: by 2002:a4a:e946:: with SMTP id v6mr24822843ood.38.1600449155398;
 Fri, 18 Sep 2020 10:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200901205549.30096-1-ionela.voinescu@arm.com>
 <20200903133203.GA29370@arm.com> <20200904043847.g4ss3o4uofwujnyk@vireshk-i7>
In-Reply-To: <20200904043847.g4ss3o4uofwujnyk@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Sep 2020 19:12:24 +0200
Message-ID: <CAJZ5v0iw4pRpGxXCR6pB9o+ynsNLAHPug-XyPWZktJ7i6TPtHQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] cpufreq: improve frequency invariance support
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 4, 2020 at 6:39 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 03-09-20, 14:32, Ionela Voinescu wrote:
> > Hi Rafael, Viresh,
> >
> > Would it be okay for you to apply this series, as the majority of
> > changes are in cpufreq? For arch_topology and arm64 changes, they have
> > been reviewed and acked-by Catalin and Sudeep.
> >
> > Also, please let me know if I should send v6 with Sudeep's Reviewed-by/s
> > applied.
>
> No need to resend. Rafael will apply these with the tags.

Right. :-)

So now applied as 5.10 material, sorry for the delay.

Thanks!
