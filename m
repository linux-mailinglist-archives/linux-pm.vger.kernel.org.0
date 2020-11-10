Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56612ADF92
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 20:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbgKJTck (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 14:32:40 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44932 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731874AbgKJTcd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 14:32:33 -0500
Received: by mail-oi1-f195.google.com with SMTP id t16so15693723oie.11;
        Tue, 10 Nov 2020 11:32:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjN4V2HIi7t5V1yE5EQ/0Tonc9lqELoKPGUr8UGft1A=;
        b=Enw4R6mJDWrZmSE99fqUhtP0/pLk2c7dBc4mZXEoVuvAB/6OxP61Hp2aE+1vaeDKFY
         rM7rb9wYRMmLvcGlIBDd3KEGpUDbvLqGt3mGI5VSsHakAu3qUWa3IJodP2iqDVfBhduT
         CF1o7vk0IySZwH5vGsYNVOs82utOSMlKn02AYQlmFyRU44wuEyHsf7gqyg2TyY95rVo3
         xWGCBWhDYa4gh7xyjjjS10i4dc5AqOj7Fua5iHETh0wgSsOYLJbHTEKQYiJZycfYehyv
         FWWuE/bbdFWKJ4iPAPdX2SzK4ZwkoJqlINXKtdZl74epXdBI/cRsDHMGlaDx4z/iH581
         iUPQ==
X-Gm-Message-State: AOAM533Qa1o4x7ZC0qEqWC8IzoUmgWFvJ4M3kaiso8sMsJf9ApKNsBbh
        h2/5qY9J2AEw7X70Cj1lWHm3z/gGJLoNkdsH7p0=
X-Google-Smtp-Source: ABdhPJwfZG2tPHJgdaIakKbL1+cVFhfUETa9QStHz8A6yQ1aKSW3znTuh3CMGkAWBFZ9ov+Mv7hn61/NclBkv4xn6iM=
X-Received: by 2002:aca:1c0b:: with SMTP id c11mr440766oic.71.1605036752777;
 Tue, 10 Nov 2020 11:32:32 -0800 (PST)
MIME-Version: 1.0
References: <20201103090600.29053-1-lukasz.luba@arm.com> <9382ea70-cc50-7b78-f5de-716678bdefbf@arm.com>
In-Reply-To: <9382ea70-cc50-7b78-f5de-716678bdefbf@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Nov 2020 20:32:21 +0100
Message-ID: <CAJZ5v0iS2jFvqiddjTDFpXq0gcNrrKML6raQOq=S4boZZC_V5Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Clarify abstract scale usage for power values in
 Energy Model, EAS and IPA
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 4, 2020 at 11:58 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Rafael,
>
> On 11/3/20 9:05 AM, Lukasz Luba wrote:
> > Hi all,
> >
> > The Energy Model supports power values expressed in an abstract scale.
> > This has an impact on Intelligent Power Allocation (IPA) and should be
> > documented properly. Kernel sub-systems like EAS, IPA and DTPM
> > (new comming PowerCap framework) would use the new flag to capture
> > potential miss-configuration where the devices have registered different
> > power scales, thus cannot operate together.
> >
> > There was a discussion below v2 of this patch series, which might help
> > you to get context of these changes [2].
> >
> > The agreed approach is to have the DT as a source of power values expressed
> > always in milli-Watts and the only way to submit with abstract scale values
> > is via the em_dev_register_perf_domain() API.
> >
> > Changes:
> > v4:
> > - change bool to int type for 'miliwatts' in struct em_perf_domain
> >    (suggested by Quentin)
> > - removed one sentence from patch 2/4 in IPA doc power_allocator.rst
> >    (suggested by Quentin)
> > - added reviewed-by from Quentin to 1/4, 3/4, 4/4 patches
>
> There was no major objections in the v3 and this v4 just addressed
> minor comments. The important discussions mostly happen in v2.
>
> Could you take the patches via your tree, please?

Applied as 5.11 material, thanks!
