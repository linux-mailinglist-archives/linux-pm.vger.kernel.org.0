Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5550910679C
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2019 09:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfKVIOx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Nov 2019 03:14:53 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38155 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfKVIOw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Nov 2019 03:14:52 -0500
Received: by mail-vs1-f66.google.com with SMTP id u18so4246142vsg.5
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2019 00:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFTfLz77NfOOoLRcjoRQoDvWTF66Atpx3UZ3GFfFuKk=;
        b=ZwDWMqx+Nhi1GjLIEgBzGDzcliHIzbVRqH6FsQsZS3QO+ytfBXNLs2DUa758bQdkdh
         66Rb4/Vdi7d875DaOKhoxbpjLYWaf87TSMA8tpEP7kinrYYMXfmu+TqSxno3zNOPFxnb
         taF3ZXVXk9b9/EabAcdMnv3VsekR7jctf7FAlzMwS3G2WjpJFtw444OcwMV0vlF4eJZK
         PE78xHeCfX5fr2GCXh2wglMMw/bCdh2Zpw4mvFUsJJsTeKvLuN0e4SwQ60kthIwiFLqj
         Y9E17GJcAzWqbhXPs1AJ1ei9+JDNjX1DKVx8fdlOE1AJcV0vv+3tHgyiAWxazI+fIF3X
         jEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFTfLz77NfOOoLRcjoRQoDvWTF66Atpx3UZ3GFfFuKk=;
        b=CB/pmYWnMi1HtTMtdscWLx6rpHpxRq7XLbIvrTXZp7X5sYMZ2MC7Y1ZGSXCdx7Yyo8
         8y1q5+ICV7j4ucRQI8nWJg55gA6phlb1NzLWrCxVYIA0pZjfnjd005+R1jV0Svh7vp/B
         LFQY0fUTDYAFKa4tJ3ojP0GHDZgT2RMk7WSMYDBhSDjCxPvgJP/wKJbfxwmZ1iGhWC5d
         My/SYpzrTYEyTvixh9qTWr7j39wv2Fxwy6O+enldl0GfJmX79RTAN8PEjjCFoR6kf4qf
         22vfutvc0Jkf+0BHKPrevkJrZ7IAsHFyliY1aVVDI3jVuPGP5tP2vewv0QVyi0C7yg8s
         Yq0A==
X-Gm-Message-State: APjAAAUFPawjIMXr1tJVhHal3tOQZsg5HlFm1h0pjUPS1C9aya2TOWqF
        kk1NfW/4aTXFhugXcQuPmXx33TEbehy6ucUI6xTkhA==
X-Google-Smtp-Source: APXvYqzK+cyn8m/2M4gYVtla7YFWEf/01wZBxA5Qm1kV1UpsOuvqk37Xn1jmB1PigbuN81mwvRR8Jtk1ZnfSecXaf4I=
X-Received: by 2002:a67:5ec1:: with SMTP id s184mr9129478vsb.200.1574410490515;
 Fri, 22 Nov 2019 00:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20191029164438.17012-1-ulf.hansson@linaro.org> <CAPDyKFpiMK_P+4+n9wHc+68X6j44XOoTm=J8OXz5HkqoMxOsOg@mail.gmail.com>
In-Reply-To: <CAPDyKFpiMK_P+4+n9wHc+68X6j44XOoTm=J8OXz5HkqoMxOsOg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 22 Nov 2019 09:14:14 +0100
Message-ID: <CAPDyKFprrtTJ8b5B1AgOWEGNeMGdjS4NbVFU1h4E2SA_oZ2dAw@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] cpuidle: psci: Support hierarchical CPU arrangement
To:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 11 Nov 2019 at 12:00, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 29 Oct 2019 at 17:44, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Changes in v2:
> >         - Avoid to affect the non-OSI path with specific changes for OSI. This
> >         forced me to re-order the series and a caused more or less minor changes
> >         to most of the patches.
> >         - Updated the DT bindings for PSCI to clarify and to include the "psci"
> >         name of the PM domain to attach to.
> >         - Replaced patch1 with another patch from Sudeep, solving the same
> >         problem, but in a different way.
>
> Hi Sudeep and Lorenzo,
>
> Apologize for nagging you about reviews, again. Can you please have a
> look at the new version!?

Lorenzo, apologize for nagging you about reviewing this series.

It seems like both me and Sudeep are now waiting to hear from you, can
you please have look.

Kind regards
Uffe
