Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBBB59828
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 12:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfF1KHf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 06:07:35 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42626 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfF1KHf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2019 06:07:35 -0400
Received: by mail-ot1-f66.google.com with SMTP id l15so5406326otn.9;
        Fri, 28 Jun 2019 03:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocXOJmtDpqphEs1B9xw0PIyGZkcOvVuYC3+naZrdwsU=;
        b=WrNtSdrmvCg3+kTHf5IIHsfjGtNp4IIMoy2mbSrFYkxihbD+P9mjpAnqHeGxAyMQyl
         3R9JaBiuwfYH0cAQ1GqIuxdDBTGKFZVPbGlpuET3AlHCe4ovoUQBhUUU//GOhU3uhV/o
         EIEm7Mua9YKi3/CrD2E1JO/0u673VIvL2sVhaE1p5mCvZwN/vLhnIhgzopvfgffQGxWH
         ADyVLL4L8hVXb86wyZYItiVfCaYv0NAX7z2YJAxhmh/vhhY4GqLGVdUJ6/eIlZXAWMUB
         oJbqy8Mcy6oudS7h6UqetEjS2TPYdHYnAng1lkmWMBxN5l9xEef6zxHDpuq1NHCmNcC7
         Gy1Q==
X-Gm-Message-State: APjAAAX64qJK2/Z4oX5HouEagQbO4GR0QSP2FtflhuJUaEiPwLRKr3JK
        0QPvXziIERstGFJBxpSxF0rreSFPHwrwqIF2nxg=
X-Google-Smtp-Source: APXvYqyKVE/rmMylB7hYkaFCDJvXdkH4u/jLDmj0EBsdPcQEotwn9XSKQlm3w/rHS1Xip9gVXvy9uMocPeF2FkUmknI=
X-Received: by 2002:a9d:6a4b:: with SMTP id h11mr7618584otn.266.1561716454690;
 Fri, 28 Jun 2019 03:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190627210209.32600-1-daniel.lezcano@linaro.org>
 <20190627210209.32600-2-daniel.lezcano@linaro.org> <CAJZ5v0jJzCGfQFqi-S3vqs74D73MaE4f7WYF_NVnDKawNV4Wzw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jJzCGfQFqi-S3vqs74D73MaE4f7WYF_NVnDKawNV4Wzw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Jun 2019 12:07:23 +0200
Message-ID: <CAJZ5v0iFk=M=0MQMb-XxR_1Vkh9J=TOG3TFBWREYLSNHFTnH-w@mail.gmail.com>
Subject: Re: [PATCH V4 2/3] thermal/drivers/cpu_cooling: Unregister with the policy
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Keerthy <j-keerthy@ti.com>,
        "open list:CPU FREQUENCY DRIVERS - ARM BIG LITTLE" 
        <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 28, 2019 at 11:12 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jun 27, 2019 at 11:02 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > Currently the function cpufreq_cooling_register() returns a cooling
> > device pointer which is used back as a pointer to call the function
> > cpufreq_cooling_unregister(). Even if it is correct, it would make
> > sense to not leak the structure inside a cpufreq driver and keep the
> > code thermal code self-encapsulate. Moreover, that forces to add an
> > extra variable in each driver using this function.
> >
> > Instead of passing the cooling device to unregister, pass the policy.
> >
> > Because the cpufreq_cooling_unregister() function uses the policy to
> > unregister itself. The only purpose of the cooling device pointer is
> > to unregister the cpu cooling device.
> >
> > As there is no more need of this pointer, remove it.
> >
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

[cut]

> > -void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
> > +void cpufreq_cooling_unregister(struct cpufreq_policy *policy)
> >  {
> >         struct cpufreq_cooling_device *cpufreq_cdev;
>
> I would do
>
>         struct cpufreq_cooling_device *ccd, *cpufreq_cdev = NULL;
>
> and then ->

Not even that. ->

>
> >         bool last;
> >
> > -       if (!cdev)
> > -               return;
> > -
> > -       cpufreq_cdev = cdev->devdata;
> > -
> >         mutex_lock(&cooling_list_lock);
> > -       list_del(&cpufreq_cdev->node);
> > -       /* Unregister the notifier for the last cpufreq cooling device */
> > -       last = list_empty(&cpufreq_cdev_list);
> > +       list_for_each_entry(cpufreq_cdev, &cpufreq_cdev_list, node) {
>
> -> list_for_each_entry(ccd, &cpufreq_cdev_list, node) {
>                 if (ccd->policy == policy) {
>
> > +               if (cpufreq_cdev->policy == policy) {
>
>                            cpufreq_cdev = ccd;
>
> > +                       list_del(&cpufreq_cdev->node);
> > +                       last = list_empty(&cpufreq_cdev_list);
> > +                       break;
> > +               }
> > +       }
> >         mutex_unlock(&cooling_list_lock);
>
> And here
>
> if (!cpufreq_cdev)
>         return;

-> It would be sufficient to simply do:

if (cpufreq_cdev->policy != policy)
        return;

here AFAICS.

>
> And that's it.  No new functions needed.
>
> > -       if (last)
> > -               cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
> > -                                           CPUFREQ_POLICY_NOTIFIER);
> > -
>
> And I don't that the above needs to be changed at all in any case.
>
>
> > -       thermal_cooling_device_unregister(cdev);
> > -       ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
> > -       kfree(cpufreq_cdev->idle_time);
> > -       kfree(cpufreq_cdev);
> > +       if (cpufreq_cdev->policy == policy)
> > +               __cpufreq_cooling_unregister(cpufreq_cdev, last);
> >  }
