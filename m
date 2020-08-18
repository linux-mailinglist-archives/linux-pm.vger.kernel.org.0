Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477EF2480AA
	for <lists+linux-pm@lfdr.de>; Tue, 18 Aug 2020 10:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgHRIcS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Aug 2020 04:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRIcP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2020 04:32:15 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C206CC061389
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2020 01:32:15 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id j188so9698586vsd.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2020 01:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gdzGXdJzbzfy/qK6DtfKB+VKyIPw+983nFML+OWFz6U=;
        b=VSQrVY7RXrLQ0ue8Q2I0aBrYUTi/7u+IErMMNMzzRccXnUEEU2TOzHRM3xqK7goqn0
         H6Sue3kIy6YO2ixq6n0SG+xg31x70KolAaBqaa1+7Iq2n0hbcabF2rHpoZWaqshNGZ7I
         9UhD8baZn0iCciDdT6bUU9y5UDf0MphN68NxcVkg3LFhHnSLFuwsroPAUse787hFycEq
         n0OJdH26+KNKmkq+DMwybYTMq0rfq0yXPdrKOrwvrZS0+9sdLWP9U4MmwuhHgiBNKWEN
         83Rnk0azT3tn9sjo3ZNe3BjymZ/79Bj01tKEvtSIe/Uf9wI7xgWk8HW9pvQK+j4mV00y
         osag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gdzGXdJzbzfy/qK6DtfKB+VKyIPw+983nFML+OWFz6U=;
        b=AYyP7VTIiR3+B0tCKW24UKpHsB/0SsMRoGD7JmYQebubqsSLeqg+yWd89Md8EVOJWM
         xd8sxAHpRzFiHIGF+tdkl9rFtZZrGn0mLxvKjnaakEcqROVrTsXFx29CfSkPyypUv7tU
         ipGfhP9rqX/5R+1RRP8zAvppVmeVZSy0OYS7hXqhh1emycHo0XaJ8S0cfJrP42I3tumf
         BNcRiHS2C4NU+4vCs7QXifRRpPsBvEemQLrVMdzd44XkucsWuDgfludeUmuu96x8WWUH
         YWp3nngwNk7EudER/SCtZ5viZLd8Lc7OU1USOwqKIpxLGyk8qZ7cehdRkZCcW2XYHnsl
         Rspw==
X-Gm-Message-State: AOAM533FN8UubX+IWVEQPFe4Tl8gYOwDgO6tS+ze6hHrxhwWc7bir88+
        PVwyQbx51kBV34uJq/6b1qheESlIJ1kusX2SBu2AGg==
X-Google-Smtp-Source: ABdhPJyC/9bxBpbbBnKbGc/Ktsk24e1jIQYYpsHyLYSOr2rKEYgB+318Ug7FCqybaniWCNklMXNQYm4zkZo+HxoVhrk=
X-Received: by 2002:a67:e9d8:: with SMTP id q24mr10518427vso.165.1597739534917;
 Tue, 18 Aug 2020 01:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200811190252.10559-1-sibis@codeaurora.org> <CAPDyKFqNMEtHwcJFxYQP5H1Yjrsr1T3UUZoXes69EthSjAYs2A@mail.gmail.com>
 <1ba3e4d703dd0a52547d63fa014451eb@codeaurora.org> <CAPDyKFrH9WTg4O5L+e1AijNvsagLYZ9QVTeoD0x0SQgYd3hkBg@mail.gmail.com>
 <1ca666c336ebee569a429e729d5ae547@codeaurora.org> <CAPDyKFrqxRrWSX5VaMy4DSjFNaMikKBYsZy5NiPMJvUybYttsw@mail.gmail.com>
 <33169e221707a2456397e478b275cfa9@codeaurora.org>
In-Reply-To: <33169e221707a2456397e478b275cfa9@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 18 Aug 2020 10:31:38 +0200
Message-ID: <CAPDyKFoPEEvrBgs4D45027+HgdNPbcM+WVHm=QVrGWgWMR61Ng@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / Domains: Add GENPD_FLAG_SUSPEND_ON flag
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel-owner@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 17 Aug 2020 at 18:49, Sibi Sankar <sibis@codeaurora.org> wrote:
>
> On 2020-08-17 14:14, Ulf Hansson wrote:
> > On Thu, 13 Aug 2020 at 19:26, Sibi Sankar <sibis@codeaurora.org> wrote:
> >>
> >> On 2020-08-13 18:04, Ulf Hansson wrote:
> >> > On Wed, 12 Aug 2020 at 19:03, Sibi Sankar <sibis@codeaurora.org> wrote:
> >> >>
> >> >> Uffe,
> >> >> Thanks for taking time to review the
> >> >> series!
> >> >>
> >> >> On 2020-08-12 15:15, Ulf Hansson wrote:
> >> >> > On Tue, 11 Aug 2020 at 21:03, Sibi Sankar <sibis@codeaurora.org> wrote:
> >> >> >>
> >> >> >> This is for power domains which needs to stay powered on for suspend
> >> >> >> but can be powered on/off as part of runtime PM. This flag is aimed at
> >> >> >> power domains coupled to remote processors which enter suspend states
> >> >> >> independent to that of the application processor. Such power domains
> >> >> >> are turned off only on remote processor crash/shutdown.
> >> >> >
> >> >> > As Kevin also requested, please elaborate more on the use case.
> >> >> >
> >> >> > Why exactly must the PM domain stay powered on during system suspend?
> >> >> > Is there a wakeup configured that needs to be managed - or is there a
> >> >> > co-processor/FW behaviour that needs to be obeyed to?
> >> >>
> >> >> Yes this is a co-processor behavior that
> >> >> needs to be obeyed. Specifically application
> >> >> processor notifies the Always on Subsystem
> >> >> (AOSS) that a particular co-processor is up
> >> >> using the power domains exposed by AOSS QMP
> >> >> driver. AOSS uses this information to wait
> >> >> for the co-processors to suspend before
> >> >> starting its sleep sequence. The application
> >> >> processor powers off these power domains only
> >> >> if the co-processor has crashed or powered
> >> >> off.
> >> >
> >> > Thanks for clarifying!
> >> >
> >> > Although, can you please elaborate a bit more on the actual use case?
> >> > What are the typical co-processor and what drivers are involved in
> >> > managing it?
> >>
> >> The co-processors using the power domains
> >> exposed by qcom_aoss driver are modem,
> >> audio dsp, compute dsp managed using
> >> qcom_q6v5_mss and qcom_q6v5_pas driver.
> >>
> >> >
> >> > As you may know, runtime PM becomes disabled during system suspend of
> >> > a device. Which means, if the driver tries to power off the
> >> > coprocessor (via calling pm_runtime_put() for example), somewhere in
> >> > the system suspend phase of the corresponding device, its attached PM
> >> > domain stays powered on when managed by genpd.
> >>
> >> The drivers aren't really expected
> >> do anything during suspend/resume
> >> pretty much because the co-processors
> >> enter low-power modes independent to
> >> that of the application processor. On
> >> co-processor crash the remoteproc core
> >> does a pm_stay_awake followed by a
> >> pm_relax after crash recovery.
> >
> > Okay, thanks again for clarifying. You have convinced me about the
> > need for a new flag to cope with these use cases.
> >
> > Would you mind updating the commit message with some of the
> > information you just provided?
> >
> > Additionally, to make it clear that the flag should be used to keep
> > the PM domain powered on during system suspend, but only if it's
> > already powered on - please rename the flag to GENPD_FLAG_NO_SUSPEND,
> > and update the corresponding description of it in the header file.
>
> Thanks, naming it ^^ makes more sense :)
>
> https://lore.kernel.org/lkml/340a7aafcf0301ff3158a4e211992041@codeaurora.org/
>
> Also we wouldn't want to power on
> runtime suspended power domains with
> the NO_SUSPEND flag set, on resume as
> explained ^^. Do you agree with that
> as well?

Actually no.

Instead, I think that deserves a separate flag, as it may very well
turn out that resuming can be skipped for other cases than
"NO_SUSPEND".

Therefore, please add a GENPD_FLAG_NO_RESUME for this.

Kind regards
Uffe
