Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 522BE3B313
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2019 12:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389361AbfFJKVr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 06:21:47 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45999 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389135AbfFJKVr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jun 2019 06:21:47 -0400
Received: by mail-vk1-f196.google.com with SMTP id r23so1523300vkd.12
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2019 03:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJxNCKHBqEq8hxmgfzQAJLVDLncAAe7CM9ROe+/BeNA=;
        b=ed47JMDehrtw98oo73hPrYOSdiClydVSZax5u/whwsvttI4jMeBg5r4kAaxNqyhRB5
         BQFS+aUFK4fp9pg9m4ABxFL8f8WSLttgJ/crALrwhCsB3v1rjfIrckms9BqtJaYXtlqc
         bzwWVino1iCNJq+uESFaHxZLWBnG33vgs3Qmd1+/6T3+zMmoiN7Dl812exIOVO1cl1F7
         +J34mbVL1NKVBr2n6AaV5gn/vEQktUbl74lRvHydB7/VR5zEDH8WVmV5fmMUTqQq4oUo
         jgFxnXWvvAWYApcTfNa6leYI+JjgeKGVBFkeuu7YRcJuNtctRfWgPTUPlWa5tSEu7aqi
         JNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJxNCKHBqEq8hxmgfzQAJLVDLncAAe7CM9ROe+/BeNA=;
        b=lCZdgW/0lJ42I7JB4/ZTYEhgM0CQzG+wz3DcU8UvK5pZR4AoH38M0i1iwDNKv66MOL
         8N+33rQh01Q9vcFc5REZbjWbVLNXl5D9sDt80r14h0Ss9z9/5W5J8HvU9YDN3HDatpqk
         QsHmGJe0cjQD5lLvFtlrCH+yG2MpKvkEcX1DtsZJe7x0KdH3xbZbL4UuyR4ZWTqgv+ik
         e/F2snJ6T9EZ8myzx6nBmYLjjBdJOwoZMoKF2qvYOhIgwSlesxpWcOLFX3q5nQpxPJI5
         idJl7aXbBWpQVNMft247IZgP1F8vcR8hsiFGr2sMD/IEag8rdZ/Bsrf7xK1qcPHJHxNb
         2HmQ==
X-Gm-Message-State: APjAAAWW4+7AQVawJwO0UEmGz4lTOboNIhdFS+acZNdQAWV9Tg/jh5h7
        qgTNA1+OYvKQGcxOiDwV6YsUGuc1ZXYHeFQl9Y+Lsg==
X-Google-Smtp-Source: APXvYqw85yEyPCfVXgt5WHExarvGTTNSk7I/nOG6fWausDPOCC8pBQhB+ownP2Y9XmGBJmpJYjtZLrkebjzWM3KbGXc=
X-Received: by 2002:a1f:12d5:: with SMTP id 204mr12861074vks.4.1560162106571;
 Mon, 10 Jun 2019 03:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190513192300.653-1-ulf.hansson@linaro.org> <20190513192300.653-8-ulf.hansson@linaro.org>
 <20190607151716.GF15577@e107155-lin>
In-Reply-To: <20190607151716.GF15577@e107155-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 Jun 2019 12:21:10 +0200
Message-ID: <CAPDyKFoKNLqLzVx8uj_-iuWAHGCvty28mVKnipFVgjKD8oDNkQ@mail.gmail.com>
Subject: Re: [PATCH 07/18] drivers: firmware: psci: Prepare to use OS
 initiated suspend mode
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 7 Jun 2019 at 17:17, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, May 13, 2019 at 09:22:49PM +0200, Ulf Hansson wrote:
> > The per CPU variable psci_power_state, contains an array of fixed values,
> > which reflects the corresponding arm,psci-suspend-param parsed from DT, for
> > each of the available CPU idle states.
> >
> > This isn't sufficient when using the hierarchical CPU topology in DT in
> > combination with having PSCI OS initiated (OSI) mode enabled. More
> > precisely, in OSI mode, Linux is responsible of telling the PSCI FW what
> > idle state the cluster (a group of CPUs) should enter, while in PSCI
> > Platform Coordinated (PC) mode, each CPU independently votes for an idle
> > state of the cluster.
> >
> > For this reason, let's introduce an additional per CPU variable called
> > domain_state and implement two helper functions to read/write its values.
> > Following patches, which implements PM domain support for PSCI, will use
> > the domain_state variable and set it to corresponding bits that represents
> > the selected idle state for the cluster.
> >
> > Finally, in psci_cpu_suspend_enter() and psci_suspend_finisher(), let's
> > take into account the values in the domain_state, as to get the complete
> > suspend parameter.
> >
>
> I understand it was split to ease review, but this patch also does
> nothing as domain_state = 0 always. I was trying hard to find where it's
> set, but I assume it will be done in later patches. Again may be this
> can be squashed into the first caller of psci_set_domain_state

You have a point, but I am worried that it would look like this series
is solely needed to support OSI mode. This is not the case. Let me
explain.

Having $subject patch separate shows the specific changes needed to
support OSI mode. The first caller of psci_set_domain_state() is added
in patch9, however, patch9 is useful no matter of OSI or PC mode.

Moreover, if I squash $subject patch with patch9, I would have to
squash also the subsequent patch (patch8), as it depends on $subject
patch.

So, to conclude, are you happy with this as is or do you want me to
squash the patches?

Kind regards
Uffe
