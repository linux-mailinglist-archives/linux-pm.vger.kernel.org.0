Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E43A73B30F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2019 12:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389214AbfFJKVC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 06:21:02 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45693 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389349AbfFJKVC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jun 2019 06:21:02 -0400
Received: by mail-vs1-f67.google.com with SMTP id n21so4947253vsp.12
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2019 03:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SP4C91hkmfb8nf4pEfeOT8GgXw6uPbDXmSTuJCq/gGc=;
        b=NnLT/vHjyOBGZwlrcg6VlzgOH161C3LeV8WVy/Vu8rFpi3c/FRWMWJAgX1juq3HdBx
         L8SvJdLZ3DJYOGXVVqnaHEP5aYAPVqmD06tmeB37f8Zd2tJkwL3EEk9U+CyW/i2cGMDn
         /qbzJ3ipIzTlfQIz/Ku+Z+csNl5SVYR0z0h06poDeKOV3bCxAQ4+UPlvkgzYF3sHr6PW
         fNIwoN7cDHj1MRQI75Wh16WPHdavqxIdQxDViUCNbS748aaCS+CSALai5WJM95xeE+Le
         5WlgNvBWmNkP0+IZOmesajCOvIc6FGL6UJrFm0O3ov8s+u1/KMEO8G01o2byn1gEeC98
         E3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SP4C91hkmfb8nf4pEfeOT8GgXw6uPbDXmSTuJCq/gGc=;
        b=pWUofGJLwsBr/DMi0sRtt4QNeQpxit36OEG7kYTumCmduSVksXSVCXPwjacoBMsm9z
         8FN16EtFxVzTUiDtB7JIZ4y2wGp9icZy1lApagFTPfc6e+N1eNRCtI2EJaGzLcIBQLs6
         fZ3qf7ZSB4W/xtL1Sv2tivDZ1DQkQFSYMsyYHbshSoU5a0AfzaMddDz5mAugBM0//RMp
         kfKoy9kHVTC00OBAy/T18qU3EjNf94eWanNLy2PUjaYnPG57PSS+mfbkn/Rs9C/Y4q4x
         6tALpxAJd+id1D82HDZ2wCYeWxjrtXpMiZRe2N0mgp8NW032CoMnjysCLf0zsUboA5Hl
         5NJg==
X-Gm-Message-State: APjAAAVrOHN5rlLQWhFGGrsnaI4qmAo5jmKaREiX2pci5alVvHwlkzZZ
        PUWscid/64DAJcFcF8Dvj93e7CsMsNL9E536UXyKBw==
X-Google-Smtp-Source: APXvYqyEELW5eYybi8NTzXTq1BaVxGi1afLoOiDPwggiWfgN/Ej4B4ujdWWHnp+5MIZ0eyrZ5ciJlutJA2qYMY6qJQA=
X-Received: by 2002:a67:706:: with SMTP id 6mr19148665vsh.200.1560162061544;
 Mon, 10 Jun 2019 03:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190513192300.653-1-ulf.hansson@linaro.org> <20190513192300.653-5-ulf.hansson@linaro.org>
 <20190607150052.GC15577@e107155-lin>
In-Reply-To: <20190607150052.GC15577@e107155-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 Jun 2019 12:20:25 +0200
Message-ID: <CAPDyKFqYZwQq_rDpfuV0K2-6_4N0frcFZ5iDab1OS8og+=zqPQ@mail.gmail.com>
Subject: Re: [PATCH 04/18] ARM/ARM64: cpuidle: Let back-end init ops take the
 driver as input
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
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 7 Jun 2019 at 17:01, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, May 13, 2019 at 09:22:46PM +0200, Ulf Hansson wrote:
> > To allow arch back-end init ops to operate on the cpuidle driver for the
> > corresponding CPU, let's pass along a pointer to the struct cpuidle_driver*
> > and forward it the relevant layers of callbacks for ARM/ARM64.
> >
>
> I may be wrong, but I see drv is just used to get state_count mostly.
> It's also used in flattening part, but that should not be here either.

Let me copy the note I added below the changelog for $subject patch,
as hopefully that should clarify the reason to why this is needed.

"- This patch is needed by the subsequent patch, but more importantly,
also by "[PATCH 10/18] drivers: firmware: psci: Add hierarchical
domain idle states converter"."

Kind regards
Uffe
