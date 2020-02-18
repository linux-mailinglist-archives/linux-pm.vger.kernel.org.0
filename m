Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C164F163712
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 00:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgBRXVt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 18:21:49 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:47018 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgBRXVt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 18:21:49 -0500
Received: by mail-ot1-f67.google.com with SMTP id g64so21284838otb.13
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2020 15:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qZJ5sy9EEUi9bug4wmXj8jM2aJaQXXTpwRiWKESLnzU=;
        b=PZbm8bKph8Jdx+grgVEWTO7UDtijaJLrtyF36mI5UZ1MzV0qv1ByxPnrwdQjeFufog
         g+0TQvQXIiNCQIFnio2gLjFYcMUDRyK6Auy1xNa8oDjg8lD2G519s7+5gWRQTkLqcCEw
         uyzan1wdR7UPSSElZl+21fMmayooLXRzzu7Byao1rd4VaHzSuMyFI9hHdFHqzFxoocjP
         Cz5saQmYlRRe0ZkPI55oY+jIUU35k2XHObETrcS0BCVI7REAyDn0YymULPCWJvTnXQWl
         +q0pIUz/hUTR1/rkDIrLV95A0YKCz0+uH7X5TOD/SRHOLiYk5p7mFMvRQRMb/+nFud6B
         5jxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZJ5sy9EEUi9bug4wmXj8jM2aJaQXXTpwRiWKESLnzU=;
        b=dXCbD8MMM99TTsFxNguJLULBYVZvMna6XlG0YPGOM+4+7PGhNd7ia6IE9qo2v1fylv
         v/RTD1bMbnDfEzZj+5hv2jas/I3tb+3JinH5KAlG3e/X4bUzAhzWNIRgxbmLH0yu4TJ3
         VYEqPYY/i+XjstQ6eEPX1yfx/9CiKik54xEl6ZiWmppbqild84ETOymkQ/t3LMG6GoAO
         QEUcm9zZP+5rUdQK0i6/3JovEmARKhXIJxBwMug/ixqCJ1vriQlDy0GpuE/MYh/g+FMm
         S8b2CwtoWpsHDojnVzlJHCy0LyVMSiO+A6MSeBFCbk/9cotEEhL4Z4nRqfC+r6iQvu4v
         yS7w==
X-Gm-Message-State: APjAAAW+oVE3uP9jAWKzmCY57K397tWTnln7PPbh7pEbSA2t9uY4ggf9
        dcjKX90SlRr7crxgUCWnBy3Hdwkz1XGXTjIWBhOcNQ==
X-Google-Smtp-Source: APXvYqyjzBiyM8od+H9rUkwgiGfJWSxgCwepGjcqFR9huyWsnI/5DKW5vEodUdTTHs4qDgmTCmUwIGtmtfJbcxAjBX4=
X-Received: by 2002:a9d:7d93:: with SMTP id j19mr18386395otn.102.1582068108579;
 Tue, 18 Feb 2020 15:21:48 -0800 (PST)
MIME-Version: 1.0
References: <20200218220748.54823-1-john.stultz@linaro.org> <CAL_JsqK5eVCuKiy2R_=5cyEBFM=YvMODqDYrmJxLPyN-Em-++g@mail.gmail.com>
In-Reply-To: <CAL_JsqK5eVCuKiy2R_=5cyEBFM=YvMODqDYrmJxLPyN-Em-++g@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 18 Feb 2020 15:21:37 -0800
Message-ID: <CALAqxLUTNq-Dg5Nd4PozCUx3K0hnVEJYmNnkpnGWGhph8vNr8w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: Rework logic in __driver_deferred_probe_check_state
 to allow EPROBE_DEFER to be returned for longer
To:     Rob Herring <robh@kernel.org>
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

On Tue, Feb 18, 2020 at 2:51 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Feb 18, 2020 at 4:07 PM John Stultz <john.stultz@linaro.org> wrote:
> >
> > Due to commit e01afc3250255 ("PM / Domains: Stop deferring probe
> > at the end of initcall"), along with commit 25b4e70dcce9
> > ("driver core: allow stopping deferred probe after init") after
> > late_initcall, drivers will stop getting EPROBE_DEFER, and
> > instead see an error causing the driver to fail to load.
> >
> > That change causes trouble when trying to use many clk drivers
> > as modules, as the clk modules may not load until much later
> > after init has started. If a dependent driver loads and gets an
> > error instead of EPROBE_DEFER, it won't try to reload later when
> > the dependency is met, and will thus fail to load.
> >
> > This patch reworks some of the logic in
> > __driver_deferred_probe_check_state() so that if the
> > deferred_probe_timeout value is set, we will return EPROBE_DEFER
> > until that timeout expires, which may be after initcalls_done
> > is set to true.
> >
> > Specifically, on db845c, this change (when combined with booting
> > using deferred_probe_timeout=30) allows us to set SDM_GPUCC_845,
> > QCOM_CLK_RPMH and COMMON_CLK_QCOM as modules and get a working
> > system, where as without it the display will fail to load.
>
> I would change the default for deferred_probe_timeout to 30 and then
> regulator code can rely on that.

That is exactly what I do in the following patch! Let me know if you
have further suggestions for it.

> Curious, why 30 sec is fine now when
> you originally had 2 min? I'd just pick what you think is best. I
> doubt Mark had any extensive experiments to come up with 30sec.

I had two minutes initially as, due to other delays I still have to
chase, booting all the way to UI on the db845c can sometimes take
almost a minute. So it was just a rough safety estimate. But in v2, I
tested with the 30 second time used by the regulator code, and that
seemed to work ok.

As long as 30 seconds is working well, I'm ok with it for now (and it
can be overrided via boot arg). Though from past experience with
enterprise distros running on servers with tons of disks (which might
take many minutes to initialize), I'd suspect its likely some
environments may need much longer.

thanks
-john
