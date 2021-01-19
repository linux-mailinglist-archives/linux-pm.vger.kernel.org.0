Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D515E2FBA2A
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 15:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390471AbhASOpS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 09:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405088AbhASLDT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 06:03:19 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1B6C0613ED
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 03:02:38 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id 186so8374544vsz.13
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 03:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=51aRHVM9MtmiP0LM6KVSBIfypf8NCoJI3/kkLCUIyQc=;
        b=cO9pngCqzzQU5+wYm76QgcPi+sSh5wfMsbcSm2rfew1o6UU+XMprqcdkv8Tat7a3sj
         dZ1uP2iZAQeaaPqA9q3x/D9TRd5FTzLxx9Ujcm/4TCxNZHTRKgnZEYSqRfUV/idaFtUI
         oLzD/IohWXy5i90tTRAvvJl1rLywYJhSrRpjC91JF1wtZyouUt/RdQE4rGgESI8mp19Z
         XuETWBfpczg9ESTyyyrb1l0HWs/4hVK8iNjlxaoFSpzUhxUnp5o2zuCyqcmVLs4IdQSG
         fp73BBTKRzw62HJLaxJ9z/8c5RwdpNy+ViRHrZHpkxe2g1y5yS4VXmvvGLyFRM7UrbEi
         w3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=51aRHVM9MtmiP0LM6KVSBIfypf8NCoJI3/kkLCUIyQc=;
        b=Fb8WxDnHIR1IuC635ZfoQqmwZ/PnSP4y+bs2DaTZg8ZO/ETWhx8pAymYX5AgfTBGEK
         wdHDuTzDi/EbPRsyuJuv+a0MXhXQb76eSEd6mednkKowtpAAgz3IPy6LAj69s4o91ccE
         A0kknyR3BsxvmMkN3NQ1LiWf4OrFSUL9daw9BtIvbyxWgGZl7QSxREWE5GVc2foyqFtZ
         +MCfe4OAq/kbjATG9W6Euw/QkgTV9S6rmofw8pmKiy0XtPHkh5mdhE2HR7yCyn9sedRw
         ghtr1tD86DPTD2ltC+f3czgnnLgFfaBV2CEki6NkpqoT+3EYp5i4OSt0dizBpw3GtWes
         MjuA==
X-Gm-Message-State: AOAM5310PplSHhduIwcLdi0/5dVdh5IGRsbP8QvK1Zm3EqS6X2N97+RB
        iJi4E7lcZVBwqWBKde5q188Heo6f6Z3qAtW6MFDDUA==
X-Google-Smtp-Source: ABdhPJzmHhIQqV/usHrcyHk3rDz6//q3bjjAW5H2CFufPw2AHrOrqfaIxGqrbhGDRrsQtReKyxV9CP3hwLdfWdsh4uM=
X-Received: by 2002:a67:7f41:: with SMTP id a62mr2178224vsd.55.1611054157249;
 Tue, 19 Jan 2021 03:02:37 -0800 (PST)
MIME-Version: 1.0
References: <20201224111210.1214-1-rojay@codeaurora.org> <20201224111210.1214-4-rojay@codeaurora.org>
 <YAGqKfDfB7EEuZVn@builder.lan> <6bfec3e6-3d26-7ade-d836-032273856ce2@codeaurora.org>
In-Reply-To: <6bfec3e6-3d26-7ade-d836-032273856ce2@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Jan 2021 12:02:01 +0100
Message-ID: <CAPDyKFqF0NE3QRAEfiqj5QOXXH2om4CpyyeudeqoovANfvjsaQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] i2c: i2c-qcom-geni: Add support for 'assigned-performance-states'
To:     Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Roja Rani Yarubandi <rojay@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>, akashast@codeaurora.org,
        msavaliy@qti.qualcomm.com, parashar@codeaurora.org,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 18 Jan 2021 at 06:36, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
>
> On 1/15/2021 8:13 PM, Bjorn Andersson wrote:
> > On Thu 24 Dec 05:12 CST 2020, Roja Rani Yarubandi wrote:
> >
> >> @@ -629,6 +658,16 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
> >>      struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
> >>
> >>      disable_irq(gi2c->irq);
> >> +
> >> +    /* Drop the assigned performance state */
> >> +    if (gi2c->assigned_pstate) {
> >> +            ret = dev_pm_genpd_set_performance_state(dev, 0);
> >> +            if (ret) {
> >> +                    dev_err(dev, "Failed to set performance state\n");
> >> +                    return ret;
> >> +            }
> >> +    }
> >> +
> >
> > Ulf, Viresh, I think we discussed this at the time of introducing the
> > performance states.
> >
> > The client's state does not affect if its performance_state should
> > be included in the calculation of the aggregated performance_state, so
> > each driver that needs to keep some minimum performance state needs to
> > have these two snippets.
> >
> > Would it not make sense to on enable/disable re-evaluate the
> > performance_state and potentially reconfigure the hardware
> > automatically?
>
> I agree, this will be repeated across multiple drivers which would
> need some minimal vote while they are active, handling this during
> genpd enable/disable in genpd core makes sense.

Initially that's what we tried out, but we realized that it was
difficult to deal with this internally in genpd, but more importantly
it also removed some flexibility from consumers and providers. See
commit 68de2fe57a8f ("PM / Domains: Make genpd performance states
orthogonal to the idlestates").

As a matter of fact this was quite recently discussed [1], which also
pointed out some issues when using the "required-opps" in combination,
but perhaps that got resolved? Viresh?

My concern is, if we would make this kind of change to the internals
of genpd, it would lead to the following limitation: A consumer driver
can no longer make its vote for its device to stick around, when the
device becomes runtime suspended - and how do we know that we never
need to support such a case?

>
> >
> > Regards,
> > Bjorn
> >
> >>      ret = geni_se_resources_off(&gi2c->se);
> >>      if (ret) {
> >>              enable_irq(gi2c->irq);
> >> @@ -654,6 +693,16 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
> >>      if (ret)
> >>              return ret;
> >>
> >> +    /* Set the assigned performance state */
> >> +    if (gi2c->assigned_pstate) {
> >> +            ret = dev_pm_genpd_set_performance_state(dev,
> >> +                                                     gi2c->assigned_pstate);
> >> +            if (ret) {
> >> +                    dev_err(dev, "Failed to set performance state\n");
> >> +                    return ret;
> >> +            }
> >> +    }
> >> +
> >>      enable_irq(gi2c->irq);
> >>      gi2c->suspended = 0;
> >>      return 0;

Kind regards
Uffe

[1]
https://lkml.org/lkml/2020/9/11/230
