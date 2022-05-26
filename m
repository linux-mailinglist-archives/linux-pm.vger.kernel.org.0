Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83905349A3
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 06:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbiEZEFL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 00:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiEZEFH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 00:05:07 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3376BC0397
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2022 21:05:06 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id e7so239500vkh.2
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2022 21:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gh0p65lc0LygEWPTrX4+R74Dvkc+J7AlFlQ6fMQGs7A=;
        b=WDkVHJyAjYPx0qORIb1n/xz4fIQ74Ge5Y/ctI4/Lw+pJle3PzU2EcyqIVgnnSsn4xf
         HVgkTtjbNoaAu45jpdxbwPh9r4WsbSvWzRI/Efu3n3LTmr2CFj7H/P6HuhOFTPqrevgk
         HpiJr3HxRnGD0jjF4ag4ujYLFlrb2QBmDng3GGhklkOb7/WXcsBAlgOf23sWX3vcuO6q
         /9PtxMskfC8ETgsS4riAjqpGiTqHVTFXhopJ24NBHuiA5oKHTIe4YekOh/9pEf7+ecpa
         T0Tpv22t9Qc/bbrSQMKI7DGm+iuShpt9N5lpg4SmwHord9VX3ddWPz9iDyk7t5Vvt6g0
         xuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gh0p65lc0LygEWPTrX4+R74Dvkc+J7AlFlQ6fMQGs7A=;
        b=3smtYbnmR37w5aV4FG2azPWsvGgILO/03/nrVvvzP2c1ldZYW/qI1vJ5gw8EXSRZu4
         69VPt40ljMoljQKAuZz4v6wtGfAH8Xzl2wTDLqgnOhDerCFPXqjXPQJPnqqgmQui2EXg
         DHN03J7wb8yYMGgHdMG/LdewXh3An/PnCmOWgoiXMLkgWLd/O2dOQpbw4MUKVwQl3Azi
         g/xnUwZgdj3MNM/r3QrUaWLR954oR4E8SRILt6M5v59uvHwjCPMEw0f7vSBE1ETuiTul
         361L5rJc882lzBk6+r3HFphztCGtBFGaVhlZbGaJJl8BBD1+yZwtpTuc7pGB0Ys9kUsA
         7EaA==
X-Gm-Message-State: AOAM533/404RVyBWiznUgEV3FPCX2r0PFhobKY4+xn+7ih1EYYzYiGzt
        pe8aw5WEvxgvkRsIWTGbmwO2hcXjli0zdt5MfU/Q
X-Google-Smtp-Source: ABdhPJyIENIzh9EMBQ4zMGQQOQ7hrSoT6bxT/xDlhXYIZFK9LsIQjft/JoNh4I8fcpEm+s6X+UR+/ZaTg+Yu1MK33E4=
X-Received: by 2002:a1f:2854:0:b0:357:f4fe:3f94 with SMTP id
 o81-20020a1f2854000000b00357f4fe3f94mr5061673vko.7.1653537905182; Wed, 25 May
 2022 21:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220526034609.480766-1-saravanak@google.com> <20220526034609.480766-2-saravanak@google.com>
In-Reply-To: <20220526034609.480766-2-saravanak@google.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 25 May 2022 21:04:55 -0700
Message-ID: <CANDhNCpgK1oj5Y+meSZmGeD9Z37OVVD_-q=8ErEH9SJ+99fydQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] driver core: Fix wait_for_device_probe() &
 deferred_probe_timeout interaction
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Ferry Toth <fntoth@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-pm@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 25, 2022 at 8:46 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Mounting NFS rootfs was timing out when deferred_probe_timeout was
> non-zero [1].  This was because ip_auto_config() initcall times out
> waiting for the network interfaces to show up when
> deferred_probe_timeout was non-zero. While ip_auto_config() calls
> wait_for_device_probe() to make sure any currently running deferred
> probe work or asynchronous probe finishes, that wasn't sufficient to
> account for devices being deferred until deferred_probe_timeout.
>
> Commit 35a672363ab3 ("driver core: Ensure wait_for_device_probe() waits
> until the deferred_probe_timeout fires") tried to fix that by making
> sure wait_for_device_probe() waits for deferred_probe_timeout to expire
> before returning.
>
> However, if wait_for_device_probe() is called from the kernel_init()
> context:
>
> - Before deferred_probe_initcall() [2], it causes the boot process to
>   hang due to a deadlock.
>
> - After deferred_probe_initcall() [3], it blocks kernel_init() from
>   continuing till deferred_probe_timeout expires and beats the point of
>   deferred_probe_timeout that's trying to wait for userspace to load
>   modules.
>
> Neither of this is good. So revert the changes to
> wait_for_device_probe().
>
> [1] - https://lore.kernel.org/lkml/TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com/
> [2] - https://lore.kernel.org/lkml/YowHNo4sBjr9ijZr@dev-arch.thelio-3990X/
> [3] - https://lore.kernel.org/lkml/Yo3WvGnNk3LvLb7R@linutronix.de/
>
> Cc: John Stultz <jstultz@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
> Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Basil Eljuse <Basil.Eljuse@arm.com>
> Cc: Ferry Toth <fntoth@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Fixes: 35a672363ab3 ("driver core: Ensure wait_for_device_probe() waits until the deferred_probe_timeout fires")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Apologies for the trouble this caused. Thanks for chasing it down!

Acked-by: John Stultz <jstultz@google.com>

thanks
-john
