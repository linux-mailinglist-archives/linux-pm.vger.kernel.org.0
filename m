Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D32D01600AF
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2020 22:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgBOV0S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Feb 2020 16:26:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgBOV0S (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 15 Feb 2020 16:26:18 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5FA52187F;
        Sat, 15 Feb 2020 21:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581801977;
        bh=456H1arBg2ny039cE9fykCoscX8DtNuNRnNfHS0JYfE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XpmSJNiw1UeXX4PNwVFyassotj+/NeWiXy+3REorYkFC6gRUTnuAJTu50UN2v4qWB
         JRE3Q57MkXlAAnMJX5cRRSn0WBr/hw0qDV5zYV3JCRIQQrM/8Epmb6xGLoNcsIvnUr
         p8/x7kd2VjEs1Be4GHV3e190QUVMtKIIpBpFZT9o=
Received: by mail-qk1-f169.google.com with SMTP id u124so12192266qkh.13;
        Sat, 15 Feb 2020 13:26:17 -0800 (PST)
X-Gm-Message-State: APjAAAWpJrwn38GghfcuYV04JdD6Ziv5pFeADXZt0JzHoj0yk83qM6bx
        QpGMzQ0K9iwPVHnIOLByBEgTuGQeiiDcA+AyKQ==
X-Google-Smtp-Source: APXvYqzreRCr1JVHhpedQ1v8Psvs3yx0fI5GSvrekouHSVo4nh51pCSJa6fHb1HAIteTeW6xsCzBNFDsYhR4SX41tO0=
X-Received: by 2002:a37:5347:: with SMTP id h68mr8162498qkb.393.1581801976744;
 Sat, 15 Feb 2020 13:26:16 -0800 (PST)
MIME-Version: 1.0
References: <20200214004413.12450-1-john.stultz@linaro.org>
 <CAL_Jsq+P0FZU9DnRhgYu6kvCFVbia=Z20VWNR2qi-Zwv=YtQhQ@mail.gmail.com> <CALAqxLWN84baRzByTSfzz7-MpAexgKyY2YkrsPFG9BPBqQdhXw@mail.gmail.com>
In-Reply-To: <CALAqxLWN84baRzByTSfzz7-MpAexgKyY2YkrsPFG9BPBqQdhXw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Sat, 15 Feb 2020 15:26:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK=7=OzYGxT=u9H7CrPE=1gFVq63GMR1A2GR4qhifBUkg@mail.gmail.com>
Message-ID: <CAL_JsqK=7=OzYGxT=u9H7CrPE=1gFVq63GMR1A2GR4qhifBUkg@mail.gmail.com>
Subject: Re: [RFC][PATCH] driver core: Extend returning EPROBE_DEFER for two
 minutes after late_initcall
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Alexander Graf <agraf@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 13, 2020 at 8:42 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Thu, Feb 13, 2020 at 5:51 PM Rob Herring <robh@kernel.org> wrote:
> > On Thu, Feb 13, 2020 at 6:44 PM John Stultz <john.stultz@linaro.org> wrote:
> > > Due to commit e01afc3250255 ("PM / Domains: Stop deferring probe
> > > at the end of initcall"), along with commit 25b4e70dcce9
> > > ("driver core: allow stopping deferred probe after init") after
> > > late_initcall, drivers will stop getting EPROBE_DEFER, and
> > > instead see an error causing the driver to fail to load.
> > >
> > > That change causes trouble when trying to use many clk drivers
> > > as modules, as the clk modules may not load until much later
> > > after init has started. If a dependent driver loads and gets an
> > > error instead of EPROBE_DEFER, it won't try to reload later when
> > > the dependency is met, and will thus fail to load.
> > >
> > > Instead of reverting that patch, this patch tries to extend the
> > > time that EPROBE_DEFER is retruned by two minutes, to (hopefully)
> > > ensure that everything has had a chance to load.
> >
> > I think regulators already has some delay like this. We should use the
> > same timeouts.
>
> Sounds good. My memory was a bit foggy from the time I initially
> brought this up, and I looked briefly before sending this out and
> didn't find the regulator change you had mentioned. If you have a
> specific pointer (or patch name or something) let me know, otherwise
> I'll dig around later tonight/tomorrow.
>
> > We also have the 'deferred_probe_timeout' cmdline option. It's deemed
> > a debug option currently, but we could change that and change the
> > default.
>
> I looked at that code, but couldn't really make heads or tails of it.
> The initcalls_done is checked and returns before the
> deferred_probe_timeout is looked at, so I was guessing the
> deferred_probe_timeout was addressing a bit more subtle issue than
> what I was going for. If its really the same functionality, I'm happy
> to try to rework it.

Subsystems have to opt-in in the current code to stop deferring at
init done. Though this was extended with
driver_deferred_probe_check_state_continue() which defers until the
timeout (commit 62a6bc3a1e4f4).

The only purpose of the timeout was to dump out what devices are still
deferred. I don't see any point in having 2 timeouts, so make
deferred_probe_timeout do what you want it to do. I think that's
mainly default to a sensible timeout value and have the subsystems you
care about honor the timeout. Perhaps we don't need both
driver_deferred_probe_check_state() and
driver_deferred_probe_check_state_continue() and can just have the
latter if all the subsystems need to honor the timeout.

I think it would be good if the console printed something periodically
about waiting for drivers. That way the system doesn't appear hung for
30 or 120 sec before giving up.

Also, there was one issue in particular that I ran into. Consoles have
to be built in and probed before init is done. So if your UART has any
dependencies, then those dependencies also have to be built-in. I
don't think anyone working on the 'everything is a module' problem has
fixed that.

> > > Specifically, on db845c, this change allows us to set
> > > SDM_GPUCC_845, QCOM_CLK_RPMH and COMMON_CLK_QCOM as modules and
> > > get a working system, where as without it the display will fail
> > > to load.
> > >
> > > Cc: Alexander Graf <agraf@suse.de>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Cc: Kevin Hilman <khilman@kernel.org>
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Cc: Pavel Machek <pavel@ucw.cz>
> > > Cc: Len Brown <len.brown@intel.com>
> > > Cc: Todd Kjos <tkjos@google.com>
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: linux-pm@vger.kernel.org
> > > Fixes: e01afc3250255 ("PM / Domains: Stop deferring probe at the end of initcall")
> > > Fixes: 25b4e70dcce9 ("driver core: allow stopping deferred probe after init")
> >
> > We can debate the design, but those work as designed. So Fixes?
> >
>
> Well, clk module loading would have worked, and then stopped working
> with e01afc3250255, so it is a regression of sorts.

If there was a clock driver upstream where this worked, then I agree.

> And really the
> tags are mostly for making sure patches get applied to trees that
> backported these commits (and it's not my intention to shame a patch
> as broken. :)

But 'Fixes' implies 'apply to stable' which is not the same as 'apply
backport to a distro kernel'.

Rob
