Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8921847B9
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 14:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgCMNOR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 09:14:17 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34876 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCMNOR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 09:14:17 -0400
Received: by mail-vk1-f193.google.com with SMTP id g25so1183208vkl.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2020 06:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r5nej1zKnErVM5m54Oa8OEYdJkqeTYbYSG60lIVS6MM=;
        b=AlM5pRFdaXDjEYep11vgb+5n8li/qmCjD7OTv2H8gwaG4LR5CLy7UD/hPFTWaKbdLn
         qpUzrJj65b/u5moBdm1Z8zmDvNtnwbfkpurjBgjpSiD6fvuyec4p3KZ0lsqQg+hXdk/I
         x94A/LTz7EzPkaIo9LSAQO93wnDnBB7pfQpQ1fSINeagF4IHQnN9s+EENifH2Bopa43O
         ocHMUFUw+q1QqiMvnKdzGmhuaF8ypliYhDnspbR0eAHkIbPN1MYe/mnci5D0ZKusbmol
         nqei0veUc+3zGDmKDx9i5aJ1ca8D9rH9VBRQO5koUw+rEv+o7V2BwR8Phon75UtiGia5
         sdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r5nej1zKnErVM5m54Oa8OEYdJkqeTYbYSG60lIVS6MM=;
        b=LfcdY9N3+Jd2xEj5BtcqQQ9RMeaPYzOs9ITPaSHWAdMmkgtv6a22+4x1fftO6RESJ1
         f3vlRzv5jsfm+JKqozHr7JVOxtutsd7CpdcFpmGDRFbded8yWgPSSf6OkOD0AIEfbhKo
         vvHJB0VylWInkw3zPmF2tUeJNpT1GN+jOGEbBc9VlieqlCvxY6ATuNv/pZh248qWXUvZ
         wcwBz2oPwTpzgPIxyf8Hs+6pIwpb+7ZuwPOsCG5WyEDOBjVR4KMxAHsAts6TcMRCDMu3
         A0bH7HQxJF+Wbg1D7xtndaPhqFxdmz5OXcxpohJMu4xouB7HsNTZlW/DoHhFoBADJAQF
         s1gA==
X-Gm-Message-State: ANhLgQ0e/gh2BeQ9g5wpBXabNGO0n+RcMpa4f6ouQjLVLJlzKq1yYGpQ
        Sv8BHNVR40Qedm1QCW9VIQ5Z1zERDxZB9uvjLtrNfTaL4RU=
X-Google-Smtp-Source: ADFU+vsIHMtphZ7t20Aii8tQJpMdxFA3wJFF6idsgMVs2k35O6ilYeLCvXoAQk+u9++kmhpmSvDedexyES6m1u95NLA=
X-Received: by 2002:a1f:52c5:: with SMTP id g188mr8502433vkb.25.1584105255211;
 Fri, 13 Mar 2020 06:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
 <1574254593-16078-5-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFqBusMHWNHBCMXx6TxFO=8B6ytoyvvSfi14Z=-ahBDV5A@mail.gmail.com> <ac341c33-003a-587a-7078-84a7f0c01a3a@linaro.org>
In-Reply-To: <ac341c33-003a-587a-7078-84a7f0c01a3a@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 13 Mar 2020 14:13:37 +0100
Message-ID: <CAPDyKFotwoiDkF6Ru39rOv+GxF7dgXG6tc0oQHMim8yKB2hRvQ@mail.gmail.com>
Subject: Re: [Patch v4 4/7] thermal: Add generic power domain warming device driver.
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[...]

> >> +static struct thermal_cooling_device_ops pd_warming_device_ops = {
> >> +       .get_max_state  = ::pd_wdev_get_max_state,
> >> +       .get_cur_state  = pd_wdev_get_cur_state,
> >> +       .set_cur_state  = pd_wdev_set_cur_state,
> >> +};
> >> +
> >> +struct thermal_cooling_device *
> >> +pwr_domain_warming_register(struct device *parent, char *pd_name, int pd_id)
> >
> > Maybe rename this to: thermal_of_pd_warming_register()
>
> How about pd_of_warming_register? It is consistent with other cooling
> device register like cpuidle_of_cooling_register and
> cpufreq_of_cooling_register.

Well, we actually have the following:
of_devfreq_cooling_register()
of_cpufreq_cooling_register()
cpuidle_of_cooling_register()

So maybe this is the most consistent. :-)
of_pd_warming_register()

>
> > Moreover, I think you could replace the "struct device *parent", with
> > a "struct device_node *node" as in-parameter. That's all you need,
> > right?
>
> You mean pd_wdev->dev.parent need not be populated ? The device
> in this case will be created under /sys/devices which I do not think
> is the correct.

Good point!

> With a parent device specified, the power controller that resides the
> power domain that can act as the warming dev, becomes the parent of the
> warming dev. In case of this patch series, for the mx warming dev,
> 179c0000.rsc/179c0000.rsc\:power-controller/ becomes the parent.(The
> device will be created under
> /sys/devices/platform/soc\@0/179c0000.rsc/179c0000.rsc\:power-controller/)
>
> Other way might be to register the warming device under virtual devices
> as a new category of devices.

No, that sounds wrong.

Another option is to create a specific bus type for these new
pd_warming devices. But I admit that sounds a bit too much, let's
assign a parent.

>
> I prefer to keep it as a child of the power controller device, but I am
> open to explore other options and to re-do this bit. What do you think?

Sure, sorry for the noise.

>
> >
> >> +{
> >> +       struct pd_warming_device *pd_wdev;
> >> +       struct of_phandle_args pd_args;
> >> +       int ret;
> >> +
> >> +       pd_wdev = kzalloc(sizeof(*pd_wdev), GFP_KERNEL);
> >> +       if (!pd_wdev)
> >> +               return ERR_PTR(-ENOMEM);
> >> +
> >> +       dev_set_name(&pd_wdev->dev, "%s_warming_dev", pd_name);
> >
> > Perhaps skip the in-param *pd_name and make use of the suggested
> > "struct device_node *node", the index and something with "warming...",
> > when setting the name.
>
> Won't the index have to be in-param in this case ?

Isn't that already the case?

Huh, long time since I reviewed this.

>
> >
> > Just an idea, as to simplify for the caller.
> >
> >> +       pd_wdev->dev.parent = parent;
> >
> > This isn't needed, I think.

So ignore this comment, as discussed above.

> >
> >> +
> >> +       ret = device_register(&pd_wdev->dev);
> >> +       if (ret)
> >> +               goto error;
> >> +
> >> +       pd_args.np = parent->of_node;
> >> +       pd_args.args[0] = pd_id;
> >> +       pd_args.args_count = 1;
> >> +
> >> +       ret = of_genpd_add_device(&pd_args, &pd_wdev->dev);
> >> +
> >
> > White space.
>
> Will fix it.
>
> >
> >> +       if (ret)
> >> +               goto error;
> >> +
> >> +       ret = dev_pm_genpd_performance_state_count(&pd_wdev->dev);
> >> +       if (ret < 0)
> >> +               goto error;
> >> +
> >> +       pd_wdev->max_state = ret - 1;
> >> +       pm_runtime_enable(&pd_wdev->dev);
> >> +       pd_wdev->runtime_resumed = false;
> >> +
> >> +       pd_wdev->cdev = thermal_of_cooling_device_parent_register
> >> +                                       (NULL, parent, pd_name, pd_wdev,
> >> +                                        &pd_warming_device_ops);
> >
> > As stated in patch3, I don't get it why you need to use this new API
> > for "parents".
>
> I agree with you. I cannot re-collect my thought process for this API.
> I compiled and tested using the regular API and everything works fine.
> I will drop patch 3 and use the thermal_of_cooling_device_register here.

Great, one confusing piece seems to go away then. :-)

>
> >
> >> +       if (IS_ERR(pd_wdev->cdev)) {
> >> +               pr_err("unable to register %s cooling device\n", pd_name);
> >> +               pm_runtime_disable(&pd_wdev->dev);
> >> +               ret = PTR_ERR(pd_wdev->cdev);
> >> +               goto error;
> >> +       }
> >> +
> >> +       return pd_wdev->cdev;
> >> +error:
> >> +       put_device(&pd_wdev->dev);
> >
> > If device_register() succeeds you need to call device_unregister(),
> > rather than put_device() as a part of the error handling.
>
> Will fix this.
>
> >
> >> +       kfree(pd_wdev);
> >
> > You need a ->release() callback to manage kfree(), after you called
> > device_register().
>
> mm?? I did not get this. What release callback? You mean for power
> controller driver to call ?

No, this how life cycle management of devices should be implemented.

Have a look at genpd_release_dev() - and see how that is being used
for genpd's virtual devices, that should explain more.

>
> >
> >> +       return ERR_PTR(ret);
> >
> > Another thing is missing in the error path, which is to remove the
> > device for the genpd. I think calling pm_genpd_remove_device() should
> > work fine here.
>
> I will fix this. I am thinking this will be be needed in
> pwr_domain_warming_unregister as well.

Yep.

Kind regards
Uffe
