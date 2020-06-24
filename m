Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDEF207414
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 15:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388521AbgFXNNq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 09:13:46 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:46210 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388367AbgFXNNq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 09:13:46 -0400
Received: by mail-ej1-f68.google.com with SMTP id p20so2363055ejd.13;
        Wed, 24 Jun 2020 06:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BDyIAIkz+outt0wjRZXFGz7XkAFPA/tTfRPsaqbeBic=;
        b=cBoDk95Xr+/3SorCdmi317L0xPhuybVi2Gj+kAITdbJ+fXCnXFphYYW4v9MR86+/wH
         SQCxjmOaeBaoBe/DfLIxQ/BZVeidyamSI0Xn8q6p3o7zL8QgEXkds5McYsM+tT3ouXmc
         jvWO+m/R9IO74b22UDGPY20rbe9hZGNTFxLpkL5WiThlVd89C7sc1ZxvZ76dko5PDQG1
         j1MCLl3K89h2z1Pp4YgC3Z1RACiA3MruyYXMUkK38jX7XE1mEv/fmKyRNb3r0OeG8LnK
         p9PDysVc0uPFZhHQbxuOxgR4NLk83gYvG0dzR8gkWqurdrW3/Eqitf7O7pFjdWuF55yo
         OdRA==
X-Gm-Message-State: AOAM533KXijfBwXKl8bFvFjFROlIpzLMapfADTzEXvsb9ZNnTkju7jr1
        N996DRO2GV7ONttBSZmBEkY=
X-Google-Smtp-Source: ABdhPJzzPyKDomrh74GPMsORKH0aJpm0N4ocflgfVK159jT1jxEJ+S6d46lyTXjIsXY0GWgw/Bnkjg==
X-Received: by 2002:a17:906:ca56:: with SMTP id jx22mr11630669ejb.494.1593004424202;
        Wed, 24 Jun 2020 06:13:44 -0700 (PDT)
Received: from pi3 ([194.230.155.235])
        by smtp.googlemail.com with ESMTPSA id ss4sm15386027ejb.63.2020.06.24.06.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 06:13:43 -0700 (PDT)
Date:   Wed, 24 Jun 2020 15:13:41 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Kamil Konieczny <k.konieczny@samsung.com>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: brocken devfreq simple_ondemand for Odroid XU3/4?
Message-ID: <20200624131341.GA20905@pi3>
References: <20200623164733.qbhua7b6cg2umafj@macmini.local>
 <CAJKOXPeLuq81NC2xZh3y32EB-_APbDAchZD4OW_eCgQKKO+p8w@mail.gmail.com>
 <20200623191129.GA4171@kozik-lap>
 <CGME20200624103308eucas1p29c8572979809b129ff8ac729c6c728e2@eucas1p2.samsung.com>
 <85f5a8c0-7d48-f2cd-3385-c56d662f2c88@arm.com>
 <828b0d63-4d01-48d6-5971-64855adebed2@samsung.com>
 <20200624120651.GA20813@pi3>
 <55772862-ff8f-1e1d-91ae-7b4d7c3be1b6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55772862-ff8f-1e1d-91ae-7b4d7c3be1b6@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 24, 2020 at 02:03:03PM +0100, Lukasz Luba wrote:
> 
> 
> On 6/24/20 1:06 PM, Krzysztof Kozlowski wrote:
> > My case was clearly showing wrong behavior. System was idle but not
> > sleeping - network working, SSH connection ongoing.  Therefore at least
> > one CPU was not idle and could adjust the devfreq/DMC... but this did not
> > happen. The system stayed for like a minute in 633 MHz OPP.
> > 
> > Not-waking up idle processors - ok... so why not using power efficient
> > workqueue? It is exactly for this purpose - wake up from time to time on
> > whatever CPU to do the necessary job.
> 
> IIRC I've done this experiment, still keeping in devfreq:
> INIT_DEFERRABLE_WORK()
> just applying patch [1]. It uses a system_wq which should
> be the same as system_power_efficient_wq when
> CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set (our case).
> This wasn't solving the issue for the deferred work. That's
> why the patch 2/2 following patch 1/2 [1] was needed.
> 
> The deferred work uses TIMER_DEFERRABLE in it's initialization
> and this is the problem. When the deferred work was queued on a CPU,
> next that CPU went idle, the work was not migrated to some other CPU.
> The former cpu is also not woken up according to the documentation [2].

Yes, you need either workqueue.power_efficient kernel param or CONFIG
option to actually enable it.  But at least it could then work on any
CPU.

Another solution is to use directly WQ_UNBOUND.

> That's why Kamil's approach should be continue IMHO. It gives more
> control over important devices like: bus, dmc, gpu, which utilization
> does not strictly correspond to cpu utilization (which might be low or
> even 0 and cpu put into idle).
> 
> I think Kamil was pointing out also some other issues not only dmc
> (buses probably), but I realized too late to help him.

This should not be a configurable option. Why someone would prefer to
use one over another and decide about this during build or run time?
Instead it should be just *right* all the time. Always.

Argument that we want to save power so we will not wake up any CPU is
ridiculous if because of this system stays in high-power mode.

If system is idle and memory going to be idle, someone should be woken
up to save more power and slow down memory controller.

If system is idle but memory going to be busy, the currently busy CPU
(which performs some memory-intensive job) could do the job and ramp up
the devfreq performance.

Best regards,
Krzysztof

