Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C799A108BFF
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 11:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfKYKpZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 05:45:25 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45878 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfKYKpZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 05:45:25 -0500
Received: by mail-ua1-f68.google.com with SMTP id w10so4224916uar.12
        for <linux-pm@vger.kernel.org>; Mon, 25 Nov 2019 02:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3FcaoN4WpK7Q0vtzl4nYB1ganJ2eAq1FfL3c8YRofM=;
        b=ZDRYVS6oMiefCRKtfx6O85kns5YodUHvE0qkZ89CA83dG5VPVQ/5ydRUAYnvWdMIvF
         wQCIQC5Xj1D2G/oyRg+NI0d9KV0LwX3FienSwjDKbOPAAN0eDWGOd73IZ3ismtaDHgX6
         eqgctaE/jXwP7enTDv3Ur1JUOsZw0ZNhaJzd7x2yBfPxAVte2/ebjN0glqeypCe6H91e
         IwBZQYXojUnzcGvwbz3ef5J1ZA+d+DquArEddji6W/MQyfGjJoWAwtllFwVD1hfRrxx2
         r7xnWPhwnYyjDGZH+WyLSH6v/auD9V6Gn9OUbRIO8ZIWntvvC+vdV6b/92dtzN38lAlU
         nuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3FcaoN4WpK7Q0vtzl4nYB1ganJ2eAq1FfL3c8YRofM=;
        b=rc3yoZmkXAT47G36eLs33sIbOLtLz7OtC3uUHjsnml45+Eyx2cO5lF7dR0Zv/dO995
         /fHjRhLzBYfWTwpUT53l6o0N7x6YZN1VomeK4HjaABItqjJGMybkFVV1yT/RvdRMIUTR
         DwjKbWHgyyAcfyEYdaBOgRI6l9gmwFolfeyuK4FVmt/Dh4UU0RsLESIfhKsZ48B25y2+
         njtBI7fNChr3MFqzZkbBk0t1qIVyvjJUBIPQfwkCUsCS0rNXhDMO1VUJ2J1gi7bz9Owa
         TF4ry5WGBxA7TZHXp3W9TAugS80JmXGtkw8+QrqR4x/aXe2T5NNk7i2o/LsAVnE6qcnG
         CbJQ==
X-Gm-Message-State: APjAAAVq/JHa3joK4m3v+Y3uXgRF1eir2uXiSpFC/gfzr+nOY4Sv50wV
        piFZG6ACFc1ZjsCCjmTUHiMW7RmRaYxulIg105Rkkw==
X-Google-Smtp-Source: APXvYqyDzET5SML3xNWZZrjmwffcN/e/xq3A6chWsSJXUzKQk6BczKfAYyCDO2GtQX02kfBKmW4iJtVcrcnUlGDfDBA=
X-Received: by 2002:ab0:74cd:: with SMTP id f13mr17428863uaq.104.1574678724284;
 Mon, 25 Nov 2019 02:45:24 -0800 (PST)
MIME-Version: 1.0
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
 <20191029164438.17012-11-ulf.hansson@linaro.org> <20191115173053.GE27170@bogus>
 <CAPDyKFraEhFVm27YG0fVkjT0-oBBxFpfiBY4zS+1TMy=0F6GRQ@mail.gmail.com> <20191122182623.GA8290@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191122182623.GA8290@e121166-lin.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Nov 2019 11:44:47 +0100
Message-ID: <CAPDyKFruoj_r3ktAHbVJAnnCZ6EP1dB9sZLE0=BZX=UziUYJag@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] cpuidle: psci: Prepare to use OS initiated
 suspend mode via PM domains
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 22 Nov 2019 at 19:26, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Mon, Nov 18, 2019 at 02:37:41PM +0100, Ulf Hansson wrote:
> > On Fri, 15 Nov 2019 at 18:30, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Tue, Oct 29, 2019 at 05:44:35PM +0100, Ulf Hansson wrote:
> > > > The per CPU variable psci_power_state, contains an array of fixed values,
> > > > which reflects the corresponding arm,psci-suspend-param parsed from DT, for
> > > > each of the available CPU idle states.
> > > >
> > > > This isn't sufficient when using the hierarchical CPU topology in DT, in
> > > > combination with having PSCI OS initiated (OSI) mode enabled. More
> > > > precisely, in OSI mode, Linux is responsible of telling the PSCI FW what
> > > > idle state the cluster (a group of CPUs) should enter, while in PSCI
> > > > Platform Coordinated (PC) mode, each CPU independently votes for an idle
> > > > state of the cluster.
> > > >
> > > > For this reason, introduce a per CPU variable called domain_state and
> > > > implement two helper functions to read/write its value. Then let the
> > > > domain_state take precedence over the regular selected state, when entering
> > > > and idle state.
> > > >
> > > > Finally, let's also avoid sprinkling the existing non-OSI path with
> > > > operations being specific for OSI.
> > > >
> > >
> > > Mostly looks good.
> >
> > Thanks!
> >
> >
> > > I am still wondering if we can keep all OSI related
> > > info in the newly created structure and have psci_states outside it as
> > > before. And I was think psci_enter_idle_state_pc and psci_enter_idle_state_osi
> > > instead of single psci_enter_idle_state and assign/initialise state->enter
> > > based on the mode chosen. I had to closer look now and looks like enter
> > > is initialised in generic dt_idle_states. That said, what you have in this
> > > patch also looks OK to me, was just trying to avoid access to the new
> > > structure all together and keep the PC mode patch almost same as before
> > > when suspending. I will see what Lorenzo thinks about this.
> >
> > I did explore that approach a bit, but found it easier to go with what
> > I propose here. The most important point, in my view, is that in this
> > suggested approach only one if-check, "if (!data->dev)", is added to
> > the PC mode path compared to the original path. I think this should be
> > fine, right!?
>
> I don't see why we should use data->dev at runtime when we can
> have two separate idle enter functions and the detection can
> be done at probe once for all instead of every idle entry.
>
> The overhead is close to nought but the point is that it is
> really not needed.

Alright, I will adopt our suggestion and override the assigned idle
enter callback, when we succeed to attach the cpu-device to its PM
domain.

Do you have any other thoughts about the series?

Kind regards
Uffe
