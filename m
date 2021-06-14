Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F643A6893
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jun 2021 15:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhFNN7H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 09:59:07 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:40743 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbhFNN7D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 09:59:03 -0400
Received: by mail-ot1-f46.google.com with SMTP id l15-20020a05683016cfb02903fca0eacd15so10856153otr.7;
        Mon, 14 Jun 2021 06:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=It8/xfz4qGru+02akan3vPxiBgccrY3v2vjpai/Lw1Q=;
        b=Z5u1d8cEQq27UaClScsaUK3whsSMBTjena8uQaJGLrFmmg0R3PlYQx0HKzKtejIgkf
         3gSVInnTHt6SCRWpOGUiXl8cO5Q8U/sbePDPnE5oBexRjQo1WfzWF5A/iFuufki1PMgq
         wIhZxeBn300ejugImK8ZwSUDfSsl92VXOUqfUjGW57KohkeBJzDZFsa4b/Y4/YJzs3y5
         SNL5FPKuKI87nwKmr7md7j13MTIXEMqsUoDeXh+cJHS3j0D+gQvvHOuXRfa+IoN0jTDD
         rVKjDrmjmPYD84A75gZJ6EHUKcOW/yfsAiLu4pl7QFi6kzyize5l/84nOuih15tyP808
         sovw==
X-Gm-Message-State: AOAM5322u7D575xP5PXg4W/XjCc8CkwSpjPf4lG+Qb3ByibKOBHRPgjy
        GFP5/ZpJzBaqUI53qiQ31BPBl9PHABWHb98yIQQ=
X-Google-Smtp-Source: ABdhPJz7765reXNPcw48XWTUNLJWbTmx25V1EuubicWXOhkq4ZqZ+gNXkIOvYaCs2AC31J3YQvWpXrQJK9mu2o2IUDk=
X-Received: by 2002:a9d:3e53:: with SMTP id h19mr13436510otg.260.1623679020501;
 Mon, 14 Jun 2021 06:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <a71c48fb0150f505680da68a82b4e4fca9a18439.1623381430.git.viresh.kumar@linaro.org>
In-Reply-To: <a71c48fb0150f505680da68a82b4e4fca9a18439.1623381430.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Jun 2021 15:56:49 +0200
Message-ID: <CAJZ5v0jYwS1Srr65EbUT+wy=A4rfnZGWONiuDMF22dRQF=zKrA@mail.gmail.com>
Subject: Re: [PATCH V2] Revert "cpufreq: CPPC: Add support for frequency invariance"
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 11, 2021 at 5:18 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> This reverts commit 4c38f2df71c8e33c0b64865992d693f5022eeaad.
>
> There are few races in the frequency invariance support for CPPC driver,
> namely the driver doesn't stop the kthread_work and irq_work on policy
> exit during suspend/resume or CPU hotplug.
>
> A proper fix won't be possible for the 5.13-rc, as it requires a lot of
> changes. Lets revert the patch instead for now.
>
> Fixes: 4c38f2df71c8 ("cpufreq: CPPC: Add support for frequency invariance")
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2: Revert the original patch instead of marking it broken.

Applied as 5.13-rc material, thanks!
