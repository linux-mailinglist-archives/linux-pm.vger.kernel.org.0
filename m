Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51002664669
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jan 2023 17:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjAJQou (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Jan 2023 11:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjAJQon (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2023 11:44:43 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7888C8B76C
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2023 08:44:37 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m3so9287773wmq.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2023 08:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cNH7SkNyOF9UgtR2y2rr38fSNVRaCWW0LTtvrIvd3Ak=;
        b=BJ8wnF/1uNfgTvB8CDbsjWlQQCuUw/1y4wKuD0GdWgurRWenizFSsrThziYW2qSItC
         /7V3M7j1wT38EvINpcktMW7gO1RJx+UJ2WPIcnmfpvgs1coTrtLQXwZkfl4yba5InBCu
         7qNPewzCM4SRFFiA87IMFd6zOXF2ga3RgtdThVFY6us16aOQHPQleGVY7RDrUzU+2sEn
         VXp7kDiU9G28hA+rPhH1My3zRLBrP6iON77YgZTm2jjGFjfpoShrrCSH9OeXN1911W5T
         qmTPG0eeyKZD8p2yDPYHSJP72+AuAa8Hhcvn8ZZe5m0gVnh+yGiebYsKbu+x6EoAlHRQ
         Ke/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNH7SkNyOF9UgtR2y2rr38fSNVRaCWW0LTtvrIvd3Ak=;
        b=GUHKCK15UuPqVTtoZoGevsK1GAg1jY3z0LvH28G5Xr49eWhUT0gVXHRHevXGC8fLtN
         buXtO4+toqSXQ7jEioY8AZJFdtXxx8oNt4J45LDW/aNDM5kz89oCY1hVNxVRyL2z50rC
         fYVRPEDBeJjfVN5b9Bl9p9R18sIGCKDZAmyK61yL80z6Ie//Fjz+DCB3IeEY3n0byhbV
         boBB8uxM7rsFPBIRkRKhNsqQaNHSuZiGrsRhbEb/FuVpd1fkjUQx23yeMdViOtvM3tvM
         nJGuiw97NE8PF9PADDV398t378fYw1XR9PSDkJTBcExsr1ElNipQP43nuaiZVbit1Zw1
         013Q==
X-Gm-Message-State: AFqh2krUiD31Pm4qaZBlEUfWFpSasoLLtcOht/Gc1zRPYQOztqZBczsk
        /+FvGYkOGOWXJIfx66Dt+50wfg==
X-Google-Smtp-Source: AMrXdXt7JRF4BvY/xXUFRS/HeVJx2pg5Y1/kInONMlsasfmps9CcTpJzlNvR9Xkip/DQYD90oexvLg==
X-Received: by 2002:a05:600c:4d25:b0:3d2:27ba:dde0 with SMTP id u37-20020a05600c4d2500b003d227badde0mr50510690wmp.33.1673369076054;
        Tue, 10 Jan 2023 08:44:36 -0800 (PST)
Received: from airbuntu ([104.132.45.100])
        by smtp.gmail.com with ESMTPSA id k9-20020a5d6d49000000b002bc8130cca7sm3599894wri.23.2023.01.10.08.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:44:35 -0800 (PST)
Date:   Tue, 10 Jan 2023 16:44:34 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Subject: Re: [RFC PATCH 3/3] sched/fair: Traverse cpufreq policies to detect
 capacity inversion
Message-ID: <20230110164434.pil27wzos45jcx3c@airbuntu>
References: <20221208140526.vvmjxlz6akgqyoma@airbuntu>
 <20221209164739.GA24368@vingu-book>
 <20221212184317.sntxy3h6k44oz4mo@airbuntu>
 <CAKfTPtBX0ugM87CEjAXUbVhnTZTwAAnjXu2fRfc6ezHE8=aC6w@mail.gmail.com>
 <20221220123254.to6tzznxloxq725q@airbuntu>
 <20221220135034.GA12359@vingu-book>
 <20221223115845.3azncwqlyo4zx262@airbuntu>
 <CAKfTPtCLE8DSa_kV4NgLqhGF--VkOV2x+bf_6NRL76NFnwmq2g@mail.gmail.com>
 <20230109164047.c4xktivav5jqped5@airbuntu>
 <CAKfTPtB2PNR7k_TEkjPCHs-ssOX3qYjacc_VbyMkGMyxA5gp9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtB2PNR7k_TEkjPCHs-ssOX3qYjacc_VbyMkGMyxA5gp9w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/10/23 17:38, Vincent Guittot wrote:

[...]

> > Patch 1 of this series addresses this already :-)
> 
> Ah yes.
> 
> >
> > Talking about this serries; I'm confused what's the plan for patch 2 now?
> >
> > My understanding was Peter should pick 1 and 2 as fixes until we nail this
> > patch out.
> 
> yes patch 1 and 2 should be merged to fix mainline implementation. As
> discussed offline, the end goal remains to remove any kind of external
> for loop in load balance

Good. I'll spin v3 so it'd be easier for Peter/Ingo to pick them up.
Meanwhile I'll be testing and continuing reviewing your patch.


Thanks!

--
Qais Yousef
