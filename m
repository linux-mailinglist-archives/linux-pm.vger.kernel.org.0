Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57C720BD02
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jun 2020 01:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgFZXH2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 19:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFZXH2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2020 19:07:28 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80282C03E979
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2020 16:07:28 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id r9so3561923ual.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2020 16:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJu142I3MQU4tDZL5/HtbZkkpBzAFWK5KVBPpeJ833Y=;
        b=mW1LmcFoAEYJTi0av1PZVGk57YAulYqXFnM92NceQr3/3MkWmdHoYqfvSSd27XQt3h
         Orzo+DAZXHMp7bOTX4LfE2EStB3ug2xgxCCzsYCCQcVuIa+IyOFXJP9W45xCIrnSP4+c
         Mkf34E3pf9grLoCXz6HrV4mGUuOhnfkfZucG3x4YoP8hZsb3564Py3L+8AsQljnCFoer
         ixRQkMfucXermYS5jVTc+a8lP8mexv6LrCPBbH3DoPihRukFbHf6RSaGhgcs4xxQilyK
         oPvJiZeBlOGYMn3mW8zR/MvdmXvL6dZW82XOEEAM9GuuKg9XER8mViIxGH3eLmZZOzhp
         s/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJu142I3MQU4tDZL5/HtbZkkpBzAFWK5KVBPpeJ833Y=;
        b=nEbNe2yvO42MQ9p6J7LA+9jMVj00YXI+i4GxGHmY/Bxb6E1sYKE4Q+ux9NOBUfBq9S
         9rPC/EJy3phRmeKqeQijHiqltHmII1pP2ZlUZZxZG57c+8asj8UYN32GWq9VFipZcGYk
         FvDYwHMO2BLxkrZ8yZDIjsM2QJVyv/MtecexZtLkTD/ithHvfyNUqhL7911OjjGLpTiv
         mZ74io5eJWcbAVUpyIwEUjKpoWIqGd0EgSfIbsRytBuZH6LwBMUH1nzO9JRwkIR0rhLI
         U9InZTE9izlBxMNOofUtcWd9R+SLuOVRzNyLsauR4SMZljZD4l4b1VWBCd6M++65+xYv
         Cqjg==
X-Gm-Message-State: AOAM531FUjgnHFS1O1vBWW7DGdXGeVwJ/USrWrnAZ8odyu31wvuH/VE2
        yIOz2duuia2XeGKzI3GcYqRX843yCseljgPED7XlqA==
X-Google-Smtp-Source: ABdhPJxEfhjBVSpELsbmCevPI/1pYwkuZ44EubkOcWHNIRyQkdhHvtYzFNfXEF5u0SCtKou2H/Bwedvewq0lsgpROfs=
X-Received: by 2002:a9f:2338:: with SMTP id 53mr2538572uae.129.1593212847709;
 Fri, 26 Jun 2020 16:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200615152054.6819-1-ulf.hansson@linaro.org> <20200615152054.6819-3-ulf.hansson@linaro.org>
 <20200626144218.GD27140@bogus>
In-Reply-To: <20200626144218.GD27140@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Sat, 27 Jun 2020 01:06:51 +0200
Message-ID: <CAPDyKFow99_DmQV3-Bmox5Jj0_nJsOWMK7QHBxCdhyWSCJpNNw@mail.gmail.com>
Subject: Re: [PATCH 2/5] cpuidle: psci: Fix error path via converting to a
 platform driver
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 26 Jun 2020 at 16:42, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, Jun 15, 2020 at 05:20:51PM +0200, Ulf Hansson wrote:
> > The current error paths for the cpuidle-psci driver, may leak memory or
> > possibly leave CPU devices attached to their PM domains. These are quite
> > harmless issues, but still deserves to be taken care of.
> >
> > Although, rather than fixing them by keeping track of allocations that
> > needs to be freed, which tends to become a bit messy, let's convert into a
> > platform driver. In this way, it gets easier to fix the memory leaks as we
> > can rely on the devm_* functions.
> >
> > Moreover, converting to a platform driver also enables support for deferred
> > probe, which subsequent changes takes benefit from.
> >
>
> Though I don't have strong opinion, I don't like platform device for cpuidle.
> But that's not main issue. I am more worried about the need for whole
> deferred probe for cpuidle. Is this due to OSI and Qcom dependencies ?
> Ideally, the firmware is already to accept suspend calls soon after they
> are powered on in psci f/w.

I agree that a platform device for cpuidle isn't very nice, but that's
the best I could figure out to use. If you have a better idea, please
tell me.

From the PSCI FW point of view you are right. Everything is ready.

So, yes, as you stated, this boils down to the initialization of the
PSCI PM domains, registered in cpuidle-psci-domain.c, which I am
converting to platform driver in patch4. That change means that
cpuidle-psci-domain driver are about to support deferred probe (and
more importantly the ->sync_state() callback), which means that when
psci_dt_attach_cpu() is called, it may return -EPROBE_DEFER - hence we
should cope with it.

I hope this further clarifies the reason behind $subject patch!?

Thanks for reviewing!

Kind regards
Uffe
