Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6835F10069A
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 14:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfKRNiT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 08:38:19 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33641 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfKRNiS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 08:38:18 -0500
Received: by mail-vk1-f195.google.com with SMTP id b64so3612908vkg.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2019 05:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/77pUYmYz7k7jHWCZ8ME97fD0QEJopQhVV1Wft8srRM=;
        b=rXVcwC04Dw3sP5f0UbSNsb70P5cHd+ewZ7Crr6h4d8hZ+AXTqm/fEI/LD6i03HFWVK
         mlA61V1kbYdKS30Na5zP1VkSfWKB1gQxRiPgOtoR6GeKgO+sMkE578+5wExm7co2MhGA
         eSiFPyv2zBMVZmVlG19sBdCpHTSPFIHxU6p72lS0EGXbEJ96Lcsu9aca9cIhS0tKhw5K
         BYwmnTQppZjqQMzOpFy4CcBOxmmAl+PuTF/gmqG8uuqmqQPzMvcpAgq3BuBvMWK4xqAO
         345tJ9uqP9jrlyEGUHYs3IevZPfkVgL8c+g9pPX8vlPCWrZ2YJVczaiEg1P3uT5eOqaD
         g5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/77pUYmYz7k7jHWCZ8ME97fD0QEJopQhVV1Wft8srRM=;
        b=LD7k4BWhoH2dIzBxVy45TvNaVfWSv1KzFkfzbC7UMcJfPEMluPwjozjKCpupMbF/5r
         5oiQfNDU6pT4TyktfaSP/tIUPN5RU2u3UIQzfiT53ZUL4lgP2MIaiNYq27fWDCQ+9JOV
         J57OFXC9gaytszNUFgARiOYYtZdjZx37zoNqLsRLXmRmovvIhGT8ye4BCI5/57RxI+Md
         1TyqOEltxM1Au+7xNkUlzLxSJrtFQZdFK3WTGg4cP/RVN+T26UPHEfTF5V3ppo/mP+yS
         n9pd7vy/kO6R+aVZCDfqA9Y+Fsr+laagV4KBix8rJOt6GhNY1BzzGbednU0aNgYvXiDa
         5+bQ==
X-Gm-Message-State: APjAAAXSeEdPPoc0YNXqfDoN/RvruxM0dKEbUrX2/apSlyeuAUx31C1x
        eye2it15JzeJXw/+cvALtODmkLAIcExaLLSmL7G5QQ==
X-Google-Smtp-Source: APXvYqyAccXywO3dLSpf9U8QdQsjon07qgb4WXqdwjPKakwD0V8cWv3zMIgV+w3PtKaed2gIOPIutMtXJhjD1Beh3pY=
X-Received: by 2002:a1f:7381:: with SMTP id o123mr16970902vkc.53.1574084297284;
 Mon, 18 Nov 2019 05:38:17 -0800 (PST)
MIME-Version: 1.0
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
 <20191029164438.17012-11-ulf.hansson@linaro.org> <20191115173053.GE27170@bogus>
In-Reply-To: <20191115173053.GE27170@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Nov 2019 14:37:41 +0100
Message-ID: <CAPDyKFraEhFVm27YG0fVkjT0-oBBxFpfiBY4zS+1TMy=0F6GRQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] cpuidle: psci: Prepare to use OS initiated
 suspend mode via PM domains
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
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

On Fri, 15 Nov 2019 at 18:30, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Oct 29, 2019 at 05:44:35PM +0100, Ulf Hansson wrote:
> > The per CPU variable psci_power_state, contains an array of fixed values,
> > which reflects the corresponding arm,psci-suspend-param parsed from DT, for
> > each of the available CPU idle states.
> >
> > This isn't sufficient when using the hierarchical CPU topology in DT, in
> > combination with having PSCI OS initiated (OSI) mode enabled. More
> > precisely, in OSI mode, Linux is responsible of telling the PSCI FW what
> > idle state the cluster (a group of CPUs) should enter, while in PSCI
> > Platform Coordinated (PC) mode, each CPU independently votes for an idle
> > state of the cluster.
> >
> > For this reason, introduce a per CPU variable called domain_state and
> > implement two helper functions to read/write its value. Then let the
> > domain_state take precedence over the regular selected state, when entering
> > and idle state.
> >
> > Finally, let's also avoid sprinkling the existing non-OSI path with
> > operations being specific for OSI.
> >
>
> Mostly looks good.

Thanks!


> I am still wondering if we can keep all OSI related
> info in the newly created structure and have psci_states outside it as
> before. And I was think psci_enter_idle_state_pc and psci_enter_idle_state_osi
> instead of single psci_enter_idle_state and assign/initialise state->enter
> based on the mode chosen. I had to closer look now and looks like enter
> is initialised in generic dt_idle_states. That said, what you have in this
> patch also looks OK to me, was just trying to avoid access to the new
> structure all together and keep the PC mode patch almost same as before
> when suspending. I will see what Lorenzo thinks about this.

I did explore that approach a bit, but found it easier to go with what
I propose here. The most important point, in my view, is that in this
suggested approach only one if-check, "if (!data->dev)", is added to
the PC mode path compared to the original path. I think this should be
fine, right!?

In any case, if you prefer any other solution, just tell me and I adapt to it.

Now, I am looking forward to hear from Lorenzo.

Kind regards
Uffe
