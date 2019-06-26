Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50B9F56797
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 13:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfFZL2b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 26 Jun 2019 07:28:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42749 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfFZL2b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2019 07:28:31 -0400
Received: by mail-ot1-f66.google.com with SMTP id l15so2119547otn.9;
        Wed, 26 Jun 2019 04:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zYG7+FYrQci0B0NIIaV4SdyVIkXx7HP7jsA5/CTPT+A=;
        b=I/rVUbKcJWx0fApH7NgpK6+ISwu3DE1elJmg+JSChHT5MddeovLDMcyCNgMsvF8L3V
         x0hldkNCghWWU4eFQfXRRC0jwZtLFcnIUNZPXrFckHL4NrQdVkkCyls+82x3i+rUtp5V
         4j4WmRF8xVeF0AjlP5CPuMIKy2WUzTjIizmvGsJQdzUGo/B5MVQty3855y9tLGsf8IyA
         MHho5/17RwhTMyt3vCXJYwYJknCcPizUmh+G88iI3FaewxgAEYNnrBdRQLb8/4mtBvWa
         EJk1iTE5LTMfujhzApk9a3qnzsdLf9Wy5dlTWLaR5Xh7FRTTzqW8ONWwyjD8sA/OYgxs
         LT3A==
X-Gm-Message-State: APjAAAWPMA82e1z6z6aBm9mXpacR1GSoy1biySEA77/lbDUww3tDNv89
        cNMLcx3taCTUXLxUNJ2knGhcYm3DKe9lGxPEvOzgsbEg
X-Google-Smtp-Source: APXvYqxQcfGkDZskFmpDKI+mK6sXWnA1QxcoJlpLtksnfosbfzd0ZwAqux1kiyfOCsazXPoyKgzI+/UQgzyr5VyCpbU=
X-Received: by 2002:a9d:6959:: with SMTP id p25mr2713084oto.118.1561548510328;
 Wed, 26 Jun 2019 04:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190625113244.18146-1-daniel.lezcano@linaro.org>
 <20190625113244.18146-2-daniel.lezcano@linaro.org> <20190626025831.jmyzyypxr6ezpbtu@vireshk-i7>
 <da1d2603-e30a-d877-54c3-1fad218f9d57@linaro.org> <20190626063716.cechnzsb75q5lclr@vireshk-i7>
 <CAJZ5v0jFXmJ3ikEPQUp-cLv3+ZSnp1kP8CxdkZVofV1BS3+UwQ@mail.gmail.com> <8a9b7bd0-9b21-1ce1-6176-cffff4b8d739@linaro.org>
In-Reply-To: <8a9b7bd0-9b21-1ce1-6176-cffff4b8d739@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Jun 2019 13:28:19 +0200
Message-ID: <CAJZ5v0h7=BqnQqvULnQr3MuQsS2qwSn7RCZbMo-V+cUi+kbvSg@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] thermal/drivers/cpu_cooling: Unregister with the policy
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 26, 2019 at 12:19 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 26/06/2019 11:06, Rafael J. Wysocki wrote:
> > On Wed, Jun 26, 2019 at 8:37 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >>
> >> On 26-06-19, 08:02, Daniel Lezcano wrote:
> >>> On 26/06/2019 04:58, Viresh Kumar wrote:
> >>>> On 25-06-19, 13:32, Daniel Lezcano wrote:
> >>>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >>>>> index aee024e42618..f07454249fbc 100644
> >>>>> --- a/drivers/cpufreq/cpufreq.c
> >>>>> +++ b/drivers/cpufreq/cpufreq.c
> >>>>> @@ -1379,8 +1379,8 @@ static int cpufreq_online(unsigned int cpu)
> >>>>>            cpufreq_driver->ready(policy);
> >>>>>
> >>>>>    if (cpufreq_thermal_control_enabled(cpufreq_driver))
> >>>>> -          policy->cdev = of_cpufreq_cooling_register(policy);
> >>>>> -
> >>>>> +          of_cpufreq_cooling_register(policy);
> >>>>> +
> >>>>
> >>>> We don't need any error checking here anymore ?
> >>>
> >>> There was no error checking initially. This comment and the others below
> >>> are for an additional patch IMO, not a change in this one.
> >>
> >> right, but ...
> >>
> >>>>> -void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
> >>>>> +void cpufreq_cooling_unregister(struct cpufreq_policy *policy)
> >>>>>  {
> >>>>>    struct cpufreq_cooling_device *cpufreq_cdev;
> >>>>>    bool last;
> >>>>>
> >>>>> -  if (!cdev)
> >>>>> -          return;
> >>
> >> we used to return without any errors from here. Now we will have
> >> problems if regsitering fails for some reason.
> >
> > Specifically, the last cpufreq_cdev in the list will be unregistered
> > AFAICS, and without removing it from the list for that matter, which
> > isn't what the caller wants.
>
> Indeed,
>
> What about the resulting code above:
>
> void __cpufreq_cooling_unregister(struct cpufreq_cooling_device
> *cpufreq_cdev, int last)
> {
>         /* Unregister the notifier for the last cpufreq cooling device */
>         if (last)
>                 cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
>                                             CPUFREQ_POLICY_NOTIFIER);
>

Doesn't the notifier need to be unregistered under cooling_list_lock ?

>         thermal_cooling_device_unregister(cpufreq_cdev->cdev);
>         ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
>         kfree(cpufreq_cdev->idle_time);
>         kfree(cpufreq_cdev);
> }
>
> /**
>
>  * cpufreq_cooling_unregister - function to remove cpufreq cooling
> device.
>  * @cdev: thermal cooling device pointer.
>
>  *
>
>  * This interface function unregisters the "thermal-cpufreq-%x" cooling
> device.
>  */
> void cpufreq_cooling_unregister(struct cpufreq_policy *policy)
> {
>         struct cpufreq_cooling_device *cpufreq_cdev;
>         bool last;
>
>         mutex_lock(&cooling_list_lock);
>         list_for_each_entry(cpufreq_cdev, &cpufreq_cdev_list, node) {
>                 if (cpufreq_cdev->policy == policy) {
>                         list_del(&cpufreq_cdev->node);
>                         last = list_empty(&cpufreq_cdev_list);
>                         break;
>                 }
>         }
>         mutex_unlock(&cooling_list_lock);
>
>         if (cpufreq_cdev->policy == policy)
>                 __cpufreq_cooling_unregister(cpufreq_cdev, last);
> }
> EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
>
>
>
>
> --
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
