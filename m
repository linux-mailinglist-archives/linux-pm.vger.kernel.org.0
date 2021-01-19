Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FF12FAE97
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 03:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393577AbhASCGK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 21:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbhASCGD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 21:06:03 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD0BC061574
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 18:05:22 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id e22so12951657iog.6
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 18:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LmnACz6MCv6NbZcaq/ZgQmXkXiPiK0sAgNTxxhkJWxk=;
        b=lov+ZMBQZfb39eGKtZogZKj9eS+PE7MQrvS190zzj7piYBfFvn/6dSudP7gPT4QHmp
         X6NXlh03cMsrDMZnw82rpQvlmgzy6zI6HHL9f41g6nSQLA0+8qfTOuwdG+7bbNJzaMmb
         Yd1atLWZvOEKdjz22VewSOVA7isv0Rksxx+XEMU07npULnCiZStUCgAm9lo2qqB3fIXZ
         RMMIJUFlF/qQ3LyVsME5Uu+80dtT5CjK5D3T7ANX8rn21Tnn9wyWwIbBi+jrKYqw4aKt
         xJS+8uWqJiEwkX7TTrew59/AGaJm50Z1fDEEos6FjSUzVOFcGJ5kebyQqs3hNJ3oLzCB
         ZOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LmnACz6MCv6NbZcaq/ZgQmXkXiPiK0sAgNTxxhkJWxk=;
        b=m6/UzpZtAxUsJpaDbtC7Tb5V9h0wnj0W4XcFSSrVzbHRvRYzmA1BCpn3afyRyo9t3U
         ME0YSyjUCl82a76VFoqW4dVMRx11ua8w2J+3+JUQryDv5UpxXf3W9hgDj7IYiuOu1JKX
         jkxX0abpgHR5ca2xEVy2udq69r7gNqhQr0pd7z8tfh16uZGLb15VuK0skfihEgPJo8Kx
         0+v8heC5JQWNfMzgfzs0Il9uH+LEUIy1nyZz7j3QpgBZiqhkE/RZYZju2CG7hT8QGKDM
         k7mPNBuVqadL40jZ2+FluDR5tU1b4T+QQ2oAhpihhfElAzs6rfLXF7B9ehV/wvPPAqvV
         pxhQ==
X-Gm-Message-State: AOAM533oG1QYKe2LcgQ0bUD6cw6tWj64NmXOnxo0swq23dEu8e2tKlcV
        4NB3ojINvpwgwyh5Qzd5+NIIRi+IJnoeqN0k9VyhGg==
X-Google-Smtp-Source: ABdhPJxF+h6yt2crjlLyZwHoOLZofMSNbSIunrTrtf10oqPrwuAeVkx6LgVyDp7oeRPV2sdbGRRMbzZo4HJ5vXmCRAI=
X-Received: by 2002:a92:4089:: with SMTP id d9mr1465251ill.199.1611021922109;
 Mon, 18 Jan 2021 18:05:22 -0800 (PST)
MIME-Version: 1.0
References: <20210118130603.16176-1-shawn.guo@linaro.org> <20210118153823.GA3310@arm.com>
 <20210119015637.GA17701@dragon>
In-Reply-To: <20210119015637.GA17701@dragon>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Tue, 19 Jan 2021 10:05:11 +0800
Message-ID: <CAAQ0ZWRsSc4J7PTPY4cBmiA04BPWiHWhD-NR-shmPxx83MWiCA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: qcom-hw: drop devm_xxx() calls from init/exit hooks
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 19, 2021 at 9:56 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> > > @@ -303,18 +305,33 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> > >
> > >     index = args.args[0];
> > >
> > > -   base = devm_platform_ioremap_resource(pdev, index);
> > > -   if (IS_ERR(base))
> > > -           return PTR_ERR(base);
> > > +   data = kzalloc(sizeof(*data), GFP_KERNEL);
> > > +   if (!data)
> > > +           return -ENOMEM;
> > >
> >
> > Nit: you could move this allocation after all resource reservation and
> > mapping below, possibly to avoid doing it unless the base address and
> > the memory resource is actually valid. Or you can keep it here and
> > remove the use of the local variables, especially the "base" variable.
>
> It's a reasonable suggestion.  I will send a new version to kill `base`
> variable, but still want to keep `res` as it saves some two level
> indirection.

I'm changing my mind :)  I will move kzalloc() to respect the original code.

Shawn
