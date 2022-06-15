Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A77B54D3FB
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 23:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346937AbiFOVx7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jun 2022 17:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245104AbiFOVx6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 17:53:58 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2102633349
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 14:53:56 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id l18so14733807lje.13
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 14:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iDVg/FA0pYo41spuROBgnDvSwaRGKSPT5P3fJJ2BRE8=;
        b=MKK7fdiA02lh91kUWcFomPfAYzD439YFS5if+A5yoJRQTfPiB2he3HQs9P2LyTXay8
         5cbDmFk0HwO2gLoFflOESfo4m1l1dtTsFVsxTqfdeXd8ssTonS3ecfwsuXEZFLgMFSrv
         z2xTSKgAuTNs3kRoDUUAe0kwstm+YnL+/uEONkJUvyOM4MG0S15ZCbBNfoCk8LhUecL8
         9mup20brXoYO0GaFoESehVo0DfbuKOF4BHtXlxRruclV71Ib8elzCZXZBNMeN/Anvq3Y
         XlgkXI242oRP3LW7yofnUcLseZg0b3j9skjFxdExIq1aGCbvOPAkWVetIiN1AC7jN4QI
         1IAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iDVg/FA0pYo41spuROBgnDvSwaRGKSPT5P3fJJ2BRE8=;
        b=FpWYrwsqT/xrNH4eSXuCGEkV0DzOMyzmuUo75AB8liKaf0PQxqHGeiy0IkoR/HTFGe
         gyDJi+Dtp2wFDhQ0X2ipUN3BPopG95QRdq0Oh/m7zKAnu5zAwJKEq0t4mBKMx3ER1tvL
         M8DnS05dj64HSpayUE9hHuN5ae79gMzCdGsS2Vf6vpeiZBVEygf9iNS9MLpMZ/W3T8Sv
         AFzfe5dzHTK9CjwGxB+NvdiF3gi9i1iF/bZ7aEgv0oGak7+d9BRGoLEMBFtDw6Zcb8Ci
         /WJ9OQlQOOrRzhYaugOxG6od+xUcmQ6Totd+5XGED1j5rsmVatKx19Vr8iil6wSB5Dg0
         6YGg==
X-Gm-Message-State: AJIora9k6+T8b0KrRr3J+gOzuCoiQB3IMNAo+wSshpUP3Tljt4+IcJWt
        AvOh/uyhLDFeHmpXo7kBUZ0kr26dT1zh8bEnoX6doQ==
X-Google-Smtp-Source: AGRyM1vOL4LUrKEzNwVxPL1XJb7vkDMLUxYNns3++dlDw+6192WV7aeknRNHvyyF/yMzKG4BFZJ240kSVxHoM7FtTwY=
X-Received: by 2002:a2e:818c:0:b0:255:a6c5:4304 with SMTP id
 e12-20020a2e818c000000b00255a6c54304mr893444ljg.367.1655330034492; Wed, 15
 Jun 2022 14:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220615203605.1068453-1-athierry@redhat.com> <CAPDyKFrLbNsdxfoWRfYBUfijLF0m7XjtH5_aY7LLmzbW5pkn9A@mail.gmail.com>
In-Reply-To: <CAPDyKFrLbNsdxfoWRfYBUfijLF0m7XjtH5_aY7LLmzbW5pkn9A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Jun 2022 14:53:18 -0700
Message-ID: <CAPDyKFqk4ngQ+DAMt=wKAqfJBHN3+bx3dTJURztwgNeEP-Ow_A@mail.gmail.com>
Subject: Re: [PATCH RFC] base: power: replace generic_pm_domain spinlock by
 raw spinlock
To:     Adrien Thierry <athierry@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>,
        Brian Masney <bmasney@redhat.com>, linux-pm@vger.kernel.org
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

On Wed, 15 Jun 2022 at 14:44, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 15 Jun 2022 at 13:36, Adrien Thierry <athierry@redhat.com> wrote:
> >
> > We've been encountering a BUG: scheduling while atomic while running the
> > 5.18.0-rt11 kernel on a Qualcomm SoC (see stacktrace below).
> >
> > It seems to occur because a spinlock is taken in the PSCI idle code path
> > in the idle loop. With the RT patchset applied and CONFIG_PREEMPT_RT
> > enabled, spinlocks can sleep, thus triggering the bug.
> >
> > In order to prevent this, replace the generic_pm_domain spinlock by a
> > raw spinlock.
> >
> > [    2.994433] BUG: scheduling while atomic: swapper/6/0/0x00000002
> > [    2.994439] Modules linked in:
> > [    2.994447] [<ffff80000810b0ec>] migrate_enable+0x3c/0x160
> > [    2.994461] CPU: 6 PID: 0 Comm: swapper/6 Not tainted 5.18.0-rt11+ #1
> > [    2.994464] Hardware name: Qualcomm SA8295P ADP (DT)
> > [    2.994466] Call trace:
> > [    2.994467]  dump_backtrace+0xb0/0x120
> > [    2.994473]  show_stack+0x1c/0x6c
> > [    2.994477]  dump_stack_lvl+0x64/0x7c
> > [    2.994483]  dump_stack+0x14/0x2c
> > [    2.994487]  __schedule_bug+0xa8/0xc0
> > [    2.994489]  schedule_debug.constprop.0+0x154/0x170
> > [    2.994492]  __schedule+0x58/0x520
> > [    2.994496]  schedule_rtlock+0x20/0x44
> > [    2.994499]  rtlock_slowlock_locked+0x110/0x260
> > [    2.994503]  rt_spin_lock+0x74/0x94
> > [    2.994505]  genpd_lock_nested_spin+0x20/0x30
> > [    2.994509]  genpd_power_off.part.0.isra.0+0x248/0x2cc
> > [    2.994512]  genpd_runtime_suspend+0x1a0/0x300
> > [    2.994515]  __rpm_callback+0x4c/0x16c
> > [    2.994518]  rpm_callback+0x6c/0x80
> > [    2.994520]  rpm_suspend+0x10c/0x63c
> > [    2.994523]  __pm_runtime_suspend+0x54/0xa4
> > [    2.994526]  __psci_enter_domain_idle_state.constprop.0+0x64/0x10c
> > [    2.994532]  psci_enter_domain_idle_state+0x1c/0x24
> > [    2.994534]  cpuidle_enter_state+0x8c/0x3f0
> > [    2.994539]  cpuidle_enter+0x3c/0x50
> > [    2.994543]  cpuidle_idle_call+0x158/0x1d4
> > [    2.994548]  do_idle+0xa8/0xfc
> > [    2.994551]  cpu_startup_entry+0x28/0x30
> > [    2.994556]  secondary_start_kernel+0xe4/0x140
> > [    2.994563]  __secondary_switched+0x54/0x58
> >
> > Signed-off-by: Adrien Thierry <athierry@redhat.com>
> > ---
> >
> > This patch fixes the bug but I'm not sure if this is the proper way to do
> > so. Suggestions for other ways to fix this are very welcome.
>
> Honestly, I am not so sure about this either.
>
> Turning the lock into spinlock_t into a raw_spinlock_t, may have the
> effect of spreading into constraints on the genpd providers. Thus
> those may need to be converted to use raw_spinlock_t too (assuming
> they use a spinlock_t and GENPD_FLAG_IRQ_SAFE). On the other hand,
> there are a limited number of genpd providers that this can become a
> problem for, if any, so maybe it would not be a big problem after all.

Ohh, one more thing. For cpuidle-psci in the idle path, we call
pm_runtime_get|put_sync(). Those calls end up using another spinlock_t
(dev->power.lock). That seems like a similar problem, but may be
harder to solve.

[...]

Kind regards
Uffe
