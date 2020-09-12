Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0D6267B63
	for <lists+linux-pm@lfdr.de>; Sat, 12 Sep 2020 18:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgILQWS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Sep 2020 12:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgILQWL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Sep 2020 12:22:11 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6090C061573
        for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2020 09:22:10 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x69so8996879lff.3
        for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2020 09:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whTwaaFIj4VaMO00rSkvbl86UfGSXDScx4RZw5sPwwA=;
        b=pXKn1BNqhdkhBJzekoypq72xizuWmzUnDg57toV5RG6L7h6UZETD3VajMp4RJXwWmF
         ADL3juoa02yH2BfzBAzMFY9qyfK5U3DSzTyUh18/fQQvc9p75/Mw3ZFWVL08yEvh2mFd
         MbZu4EoSOia2pDnd75EtjZCFgHRE8wFj83ZY13TMN1YRe9Es/K/cZM72ymvB6kBq2840
         BlaRwBM4p6hx9mp+Fo+V9WhL9zYS4FAs2NucaJ5KqV+zsWW7f+nocrPGF8QqPzxT6MFE
         KgZqqlNSADNvwIh1x6iry8FtCAv552xvHecHGULH3DzoSCOr1AvGqpVSruBqlbAm9jOx
         QDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whTwaaFIj4VaMO00rSkvbl86UfGSXDScx4RZw5sPwwA=;
        b=ZxXvweBjPLINhM334Itp2TtCdVS85dAy40MFi5rOAAXjOJ+2jyLkTcWRCGYXwF49nw
         H4E2uM2+K1fL528Lg3fxj/Nm9PBFI4scyiEYZYoNKiaS18H69sBDl31jZzWmd0OHUrf3
         o3Q4LKxae+YKFCPOZBTLO1afarT6tnZlXfEZaFCl6EaiIs7STPiFsa7O3ZdRxzAzTTR6
         letWYSN97zLbfO80PusvsRZ+6KnfjKwy2xUZXMkMrSnnfMxQVCG3doB8moRwhm61lu8w
         HEtPRXIxDekXTd8BH7jBMUG0NlQqsj0kfpPx7310Mhg6yaL6bw3eQS/hr5MZw/ZVJTvH
         aeBQ==
X-Gm-Message-State: AOAM531H5ng3/TDNQneLfFFXGpAFRqyT7XDKXTNf3tchU6ln1hTZ3ZZy
        SyRJBvz57AqdhibPLV5cjnr2UD7YZKrJxsgEG5z3mA==
X-Google-Smtp-Source: ABdhPJxeMSkr6dF/iyWmnFtQ6JiTKbE0tAM5i3iK+Aof7w3F98npke6rRj51PEaONLLT93UNEnc5jzoKKAONnegtCFc=
X-Received: by 2002:a05:6512:370b:: with SMTP id z11mr1761753lfr.571.1599927729072;
 Sat, 12 Sep 2020 09:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200808043512.106865-1-john.stultz@linaro.org>
In-Reply-To: <20200808043512.106865-1-john.stultz@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Sep 2020 18:21:58 +0200
Message-ID: <CACRpkdZWC4078AyCJh67XW4kjLm1Eab76DS-3xy-0RgGrP09Yw@mail.gmail.com>
Subject: Re: [RFC][PATCH] pinctrl: Rework driver_deferred_probe_check_state()
 evaluation since default timeout has changed
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Aug 8, 2020 at 6:35 AM John Stultz <john.stultz@linaro.org> wrote:

> In commit bec6c0ecb243 ("pinctrl: Remove use of
> driver_deferred_probe_check_state_continue()"), we removed the
> use of driver_deferred_probe_check_state_continue() which
> effectively never returned -ETIMED_OUT, with the
> driver_deferred_probe_check_state() function that had been
> reworked to properly return ETIMED_OUT when the deferred probe
> timeout expired. Along with that change, we set the default
> timeout to 30 seconds.
>
> However, since moving the timeout to 30 seconds caused some
> issues for some users with optional dt links, we set the
> default timeout back to zero - see commit ce68929f07de ("driver
> core: Revert default driver_deferred_probe_timeout value to 0")
>
> This in essence changed the behavior of the pinctrl's usage
> of driver_deferred_probe_check_state(), as it now would return
> ETIMED_OUT by default. Thierry reported this caused problems with
> resume on tegra platforms.
>
> Thus this patch tweaks the pinctrl logic so that it behaves as
> before. If modules are enabled, we'll only return EPROBE_DEFERRED
> while we're missing drivers linked in the DT.
>
> Cc: linux-pm@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Rob Herring <robh@kernel.org>
> Fixes: bec6c0ecb243 ("pinctrl: Remove use of driver_deferred_probe_check_state_continue()")
> Fixes: ce68929f07de ("driver core: Revert default driver_deferred_probe_timeout value to 0")
> Reported-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

As noted I applied Thierry's similar patch.

Yours,
Linus Walleij
