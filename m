Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6DF163677
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 23:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgBRWvw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 17:51:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:33792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgBRWvw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Feb 2020 17:51:52 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5598024670;
        Tue, 18 Feb 2020 22:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582066311;
        bh=JVw1/p6FsCoqbFDqyFKAI1rqvqyAc6BMfIKN4ddINoY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YpnOCoaOARlUo9rIPwheEZK5IyhakaAX1XnEh505iecYtcQ8SEISOzJujPOHQCZX3
         daj+f64uNxcQzCzerBrnps0WKfP99Ga1Bqur6KfuBteNP9UnGYYKo7mGTEnjt6bh/M
         VYXbuJCthr56ppJQ896BnSJN2rz8/bewhbTUR+9M=
Received: by mail-qk1-f174.google.com with SMTP id u124so20746845qkh.13;
        Tue, 18 Feb 2020 14:51:51 -0800 (PST)
X-Gm-Message-State: APjAAAVMS5VXyubtyunRMRv/Az822nPf2t2DpP68anXRnEcuyuHW8Qpn
        Sg0hfgZLVyLd/HEyGPhk2LqzRiguvfs+RlIffg==
X-Google-Smtp-Source: APXvYqzOycS54fdMe+Mi6jmD1eUPFXsnxiEYEUbIZ2YhQGSynwd5BRWP7iCohzeOF1d0omgODT8b2Ln6vs5ynpThWSg=
X-Received: by 2002:a37:5347:: with SMTP id h68mr20566408qkb.393.1582066310364;
 Tue, 18 Feb 2020 14:51:50 -0800 (PST)
MIME-Version: 1.0
References: <20200218220748.54823-1-john.stultz@linaro.org>
In-Reply-To: <20200218220748.54823-1-john.stultz@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Feb 2020 16:51:39 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK5eVCuKiy2R_=5cyEBFM=YvMODqDYrmJxLPyN-Em-++g@mail.gmail.com>
Message-ID: <CAL_JsqK5eVCuKiy2R_=5cyEBFM=YvMODqDYrmJxLPyN-Em-++g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: Rework logic in __driver_deferred_probe_check_state
 to allow EPROBE_DEFER to be returned for longer
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 18, 2020 at 4:07 PM John Stultz <john.stultz@linaro.org> wrote:
>
> Due to commit e01afc3250255 ("PM / Domains: Stop deferring probe
> at the end of initcall"), along with commit 25b4e70dcce9
> ("driver core: allow stopping deferred probe after init") after
> late_initcall, drivers will stop getting EPROBE_DEFER, and
> instead see an error causing the driver to fail to load.
>
> That change causes trouble when trying to use many clk drivers
> as modules, as the clk modules may not load until much later
> after init has started. If a dependent driver loads and gets an
> error instead of EPROBE_DEFER, it won't try to reload later when
> the dependency is met, and will thus fail to load.
>
> This patch reworks some of the logic in
> __driver_deferred_probe_check_state() so that if the
> deferred_probe_timeout value is set, we will return EPROBE_DEFER
> until that timeout expires, which may be after initcalls_done
> is set to true.
>
> Specifically, on db845c, this change (when combined with booting
> using deferred_probe_timeout=30) allows us to set SDM_GPUCC_845,
> QCOM_CLK_RPMH and COMMON_CLK_QCOM as modules and get a working
> system, where as without it the display will fail to load.

I would change the default for deferred_probe_timeout to 30 and then
regulator code can rely on that. Curious, why 30 sec is fine now when
you originally had 2 min? I'd just pick what you think is best. I
doubt Mark had any extensive experiments to come up with 30sec.

> Cc: Rob Herring <robh@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2:
> * Add calls to driver_deferred_probe_trigger() after the two minute timeout,
>   as suggested by Bjorn
> * Minor whitespace cleanups
> * Switch to 30 second timeout to match what the regulator code is doing as
>   suggested by Rob.
> v3:
> * Rework to reuse existing deferred_probe_timeout value, suggested by Rob
> * Dropped Fixes: tags as Rob requested (Not my hill to die on :)
> ---
>  drivers/base/dd.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index b25bcab2a26b..9d916a7b56a6 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -237,13 +237,12 @@ __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
>
>  static int __driver_deferred_probe_check_state(struct device *dev)
>  {
> -       if (!initcalls_done)
> -               return -EPROBE_DEFER;
> -
> -       if (!deferred_probe_timeout) {
> +       if (initcalls_done && !deferred_probe_timeout) {
>                 dev_WARN(dev, "deferred probe timeout, ignoring dependency");
>                 return -ETIMEDOUT;
>         }
> +       if (!initcalls_done || deferred_probe_timeout > 0)
> +               return -EPROBE_DEFER;
>
>         return 0;
>  }
> --
> 2.17.1
>
