Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B28F10CDB5
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 18:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfK1RVn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 12:21:43 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42853 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfK1RVn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 12:21:43 -0500
Received: by mail-ua1-f68.google.com with SMTP id 31so8406772uas.9
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2019 09:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jWkZvzbR/ZCBOrIAXP6oks1/eAZlhWE0zqLBZ2M7SMQ=;
        b=W7UDV4c14mrLGdwXUV3VoqTwJpaneaRNFmFy1VATFsdnCSCAulu4QwYp4RjIE/e7JM
         GN46LWMlA6UAie8zMpuPYDWPG6ULVAcd0HciOad4dQ4sJkG7Vt0RHZhBJ1Pk1zzejrzv
         l29MYkqpwLmImsYg2NbH3UjIqv2tpsXl9UGxly4b5aFY3DWK/JlSo+6wyzMZPJgSdgp7
         n5RJiDEVmvvda5B1e5zxk0HWG14uoKstjsjp4tY39lA8SewBGUsbzd/TlSdL8eeWYtYh
         zf8XbelUETKTkMPfY94sq2yA2GbVXJ4VuLD+JUrzM4lndZlXdi1aiFDdwcm6lOUskK+A
         W6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jWkZvzbR/ZCBOrIAXP6oks1/eAZlhWE0zqLBZ2M7SMQ=;
        b=JY/D5K9tr9BRQSeIoy5fj5xTDMvdI6RpGwfaHyIunY1BK3kcYQNhLTVepLPaExIhIN
         NcHmxMyjPgv9wWsV9K8uVdZ2YWcaG6NjfbsDKYcehLm30D29mwQYYsTnbGjoatAMMpkQ
         ikZdeiYmpxzlZZLFDSZY4BEYMp9nvQBlpEyYDMWr28VZ5iK84KU6zXWihFUul1YKxZ1K
         ljpgNzM8OXZ05fgEGecMG7mEXYzHuTTnVXHnZ3bgjNr9LyU38Dc/IDTFwGSPeXN7+M74
         XT1j8o7JdeCNCexGcDOOz0GWJoRfW/BmYWch4L3T3ikDeGnXi4esOVwZrnL8shr4vwIT
         7JHQ==
X-Gm-Message-State: APjAAAX9RzZ65L/CHsssc3L/15fMb2zfVdP42OQNyMxxbJaJu79Dcd6a
        TBLyLswVvIYge6GolDCesGbfBB+1uvFUA2HyRcPVRw==
X-Google-Smtp-Source: APXvYqzFtMI/TaLzyv+05fJQrBZJzoCKp1k35HT7uhgJP/uJmSW4zO/ZIlZYzh1OEUl2NOO2zPDyUA5n1fUHYdvCgww=
X-Received: by 2002:ab0:2042:: with SMTP id g2mr7289164ual.19.1574961700051;
 Thu, 28 Nov 2019 09:21:40 -0800 (PST)
MIME-Version: 1.0
References: <20191127102914.18729-1-ulf.hansson@linaro.org>
 <20191127102914.18729-9-ulf.hansson@linaro.org> <20191128141443.GA31123@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191128141443.GA31123@e121166-lin.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 Nov 2019 18:21:03 +0100
Message-ID: <CAPDyKFr1GTAkNyTmLvvC1ovm4yOtMGLOVWA-e-wjGJz2ENdN1g@mail.gmail.com>
Subject: Re: [PATCH v3 08/13] cpuidle: psci: Add a helper to attach a CPU to
 its PM domain
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 28 Nov 2019 at 15:15, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Nov 27, 2019 at 11:29:09AM +0100, Ulf Hansson wrote:
>
> [...]
>
> > +struct device *psci_dt_attach_cpu(int cpu)
> > +{
> > +     struct device *dev;
> > +
> > +     /* Currently limit the hierarchical topology to be used in OSI mode. */
> > +     if (!psci_has_osi_support())
> > +             return NULL;
> > +
> > +     dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), "psci");
> > +     if (IS_ERR_OR_NULL(dev))
> > +             return dev;
> > +
> > +     pm_runtime_irq_safe(dev);
> > +     if (cpu_online(cpu))
>
> It is unclear to me how we handle (or rather we don't) CPU hotplug
> with this series - it does not look OK unless genpd code manages
> that automatically.

The series doesn't handle CPU hotplug at the moment, simply because I
am targeting to get the basic support, upstream first.

For a functionality point of view, this isn't a problem in my opinion.
Simply because the consequence is only that the idle states for the
"cluster" will not be reached if there is a CPU brought offline.

As we talked about at LPC and as also told Sudeep for the v2 series,
CPU hotplug is going to be implemented by using a CPU HP notifier.
That should be fine, right?

Kind regards
Uffe
