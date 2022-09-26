Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4DE5EA9B0
	for <lists+linux-pm@lfdr.de>; Mon, 26 Sep 2022 17:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiIZPIy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Sep 2022 11:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbiIZPId (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2022 11:08:33 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE4C58DCB
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 06:40:19 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id a20so4055967qtw.10
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 06:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Xwyf5kvixonXPa/ZqWH/Z4+aLmRlLokq9pfdHFjlrDg=;
        b=awzjjI/48srHdy6rimLXC7oRGaCphOILy2ye8jSKty2jxkKSO/PRS1DAS5S6vEeSYl
         pBVarXixsHetT/VJtnUNEnNv1wqmlxxW7UrS5sk3/5Bc6XZo6rOXWjocjkS9YEQs2yQ2
         RqZHnamBW2r9uQoqHDG95QNAIuU4BTgAHznH2y2/MI6z3SNJuNYlPFlWa3ZTjDckniwC
         b/W6EO/EVWYJsm4MfQ3xOzHttP/j5ayHl5HujI1vRz2sp9Co3zwiIRYhk5bYij4nI9B7
         ZOSdPu6QyMpjUJC9P7HloB7L3HNIRCu54zyJLY98VwB3aovkUy/cyYyYcu78+rYEnl6V
         tpyA==
X-Gm-Message-State: ACrzQf1OOgk+rTFT0HSDb4/PHo+WQVzIDSaT5X9dLtX2JsfuE5JeMMYY
        k5UXKQtBGoK/DyOVHr2zZmSTqyFJ/xe+GtPqa/zbRZxCQ/g=
X-Google-Smtp-Source: AMsMyM4s5LZgQeqJCxjGxk1B5yoKziEYbjE/t2tJYWMjQActsGMwE+36SpnLnwJceI9Tt1sV/y/TGND26gFOv4C4ayw=
X-Received: by 2002:a05:622a:620a:b0:35c:bf9e:8748 with SMTP id
 hj10-20020a05622a620a00b0035cbf9e8748mr18241532qtb.494.1664199618762; Mon, 26
 Sep 2022 06:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <4c99f34b-40f1-e6cc-2669-7854b615b5fd@linutronix.de> <12f6625f-bd93-80c2-3a8c-19c63f49ea10@linutronix.de>
In-Reply-To: <12f6625f-bd93-80c2-3a8c-19c63f49ea10@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Sep 2022 15:40:06 +0200
Message-ID: <CAJZ5v0hpqdX78LWqyMLHWLmy47NiGpuavg-V9D6wrGPekPjMTA@mail.gmail.com>
Subject: Re: cpufreq - powernv driver
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 26, 2022 at 3:20 PM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> ping?

Sorry, this fell off my radar.

> On Mon, 27 Jun 2022, Anna-Maria Behnsen wrote:
>
> > Hi,
> >
> > during my work on a timer hierarchy I stumbled over powernv cpufreq driver
> > which is using a timer which is deferrable and pinned. This is the only
> > timer in kernel which uses this combination and I would like to get rid of
> > it.
> >
> > Only removing the pinned or deferrable flag could not be the proper
> > solution, right?
> >
> > I'm not familiar with cpufreq. I was wondering if it's possible to rework
> > the powernv cpufreq driver to use cpufreq infrastructure instead handling
> > it's own timer for ramping down? I would be happy if someone could help me
> > with some pointers how this could be solved.

cpufreq drivers need not use timers at all in general.

What they need to do is to register a callback via
cpufreq_add_update_util_hook(), like intel_pstate or the schedutil
governor.

I'll look at the powernv driver later this week.


> > Thanks,
> >
> >       Anna-Maria
> >
