Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7633254FDF9
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 21:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiFQT6O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jun 2022 15:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbiFQT6N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 15:58:13 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F9538793
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 12:58:12 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-f2a4c51c45so6769944fac.9
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 12:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:user-agent:date:message-id:subject:to:cc;
        bh=A8JJMVbZngK6NaVYvhxrE43QJFDmbjJcs++TiSORqUk=;
        b=aW2v/DYU2Usd+mTFmULe9Bqe1w3rcI9eZXk7h+q0xwRblBqUXiuTNc46pmjZ3ZKHgd
         5zzI3L4XFDskEtEKrP1ArYQmnwM1Fs6TpbOki2XmDOz98N+2OhOmXxnhR3XTlqWhy2D8
         OY1vhyUpl85BZ4asz6nEltUqaYpKNLGsXqbaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:user-agent:date:message-id
         :subject:to:cc;
        bh=A8JJMVbZngK6NaVYvhxrE43QJFDmbjJcs++TiSORqUk=;
        b=TLZDHdex5gDinR5NNDAP/TmUWgEb8w6wS+APhAlAAr6cQ1VSrA+EObor5gwV1GH5x6
         hgM64Yvnx1l55MAfJcNJEEiD1ZAQukk2qPUbfVmqEowyPjezRxM4mii6NlRxfwgbMhRC
         LijT5tTOk2cNXyQtIc5tkScd7Aw3GU3JeWBMK3LLGgojI8xMzbsYEgkyY0cXwL6PzlOl
         8EJx1lQTWwjBQEkH20Z9TxQDNVeB6+VrCFWfNSlPuSyEo9Aui5AokPYGi3qe8K25TMZZ
         fOCa6V98jV9IqDXTLstyzlT+RJO/c3jgDiD4/G8OCEpxYI+CQ5L2su1b+zJcMeVva7se
         fwEQ==
X-Gm-Message-State: AJIora9N4HNxRxAZxdvKlSTdm3YqqWOj9aOMJZsCJ4YJkDe5JrBA+5hC
        qI4y+TaqSwNE38bP1Diivn3R4OjOu7Kfg/DWpDMnIqb44zI=
X-Google-Smtp-Source: AGRyM1vThDhDqP0PhYfZVq8vkNpd2vUQo0ppMWV9t0NxanyTHP+FhzT6Q3fc6CqnvvPOBarxGmE9XTJPQ7+z8YbSrck=
X-Received: by 2002:a05:6870:b381:b0:fe:2004:b3b5 with SMTP id
 w1-20020a056870b38100b000fe2004b3b5mr6450848oap.63.1655495891813; Fri, 17 Jun
 2022 12:58:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jun 2022 12:58:11 -0700
MIME-Version: 1.0
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 17 Jun 2022 12:58:11 -0700
Message-ID: <CAE-0n52xbZeJ66RaKwggeRB57fUAwjvxGxfFMKOKJMKVyFTe+w@mail.gmail.com>
Subject: clk: qcom: genpd lockdep warning in gdsc
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Yu Zhao <yuzhao@google.com>, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bjorn and Dmitry,

Yu reported a lockdep warning coming from the gdsc driver. It looks like
the runtime PM usage in gdsc.c is causing lockdep to see an AA deadlock
possibility with 'genpd->mlock'. I suspect this is because we have
commit 1b771839de05 ("clk: qcom: gdsc: enable optional power domain
support"), and that is now calling runtime PM code from within the genpd
code. I think genpd already has nested lock support, so the only
solution is to not use runtime PM from within genpd code and start
expressing genpd parent relationships in genpd itself? Or maybe genpd
needs to drop locks while calling down into gdsc_disable() and reacquire
them after that?

============================================
WARNING: possible recursive locking detected
5.19.0-rc2-lockdep+ #7 Not tainted
--------------------------------------------
kworker/2:1/49 is trying to acquire lock:
ffffffeea0370788 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x24/0x30

but task is already holding lock:
ffffffeea03710a8 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x24/0x30

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&genpd->mlock);
  lock(&genpd->mlock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by kworker/2:1/49:
 #0: 74ffff80811a5748 ((wq_completion)pm){+.+.}-{0:0}, at:
process_one_work+0x320/0x5fc
 #1: ffffffc008537cf8
((work_completion)(&genpd->power_off_work)){+.+.}-{0:0}, at:
process_one_work+0x354/0x5fc
 #2: ffffffeea03710a8 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x24/0x30

stack backtrace:
CPU: 2 PID: 49 Comm: kworker/2:1 Not tainted 5.19.0-rc2-lockdep+ #7
Hardware name: Google Lazor (rev3 - 8) with KB Backlight (DT)
Workqueue: pm genpd_power_off_work_fn
Call trace:
 dump_backtrace+0x1a0/0x200
 show_stack+0x24/0x30
 dump_stack_lvl+0x7c/0xa0
 dump_stack+0x18/0x44
 __lock_acquire+0xb38/0x3634
 lock_acquire+0x180/0x2d4
 __mutex_lock_common+0x118/0xe30
 mutex_lock_nested+0x70/0x7c
 genpd_lock_mtx+0x24/0x30
 genpd_runtime_suspend+0x2f0/0x414
 __rpm_callback+0xdc/0x1b8
 rpm_callback+0x4c/0xcc
 rpm_suspend+0x21c/0x5f0
 rpm_idle+0x17c/0x1e0
 __pm_runtime_idle+0x78/0xcc
 gdsc_disable+0x24c/0x26c
 _genpd_power_off+0xd4/0x1c4
 genpd_power_off+0x2d8/0x41c
 genpd_power_off_work_fn+0x60/0x94
 process_one_work+0x398/0x5fc
 worker_thread+0x42c/0x6c4
 kthread+0x194/0x1b4
 ret_from_fork+0x10/0x20
