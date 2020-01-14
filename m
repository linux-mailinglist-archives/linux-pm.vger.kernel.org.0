Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C09E013B10E
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 18:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgANRg3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 12:36:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:47268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgANRg3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Jan 2020 12:36:29 -0500
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBBE02467C;
        Tue, 14 Jan 2020 17:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579023388;
        bh=a9R3hUWXn3kAB+DS0N+9xFdgrpDwftcTX/kWypdj37U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dYMr4g7yJ5aOXktTFjc1j2XEGesBlPo9euxdwpbPfcFul0dglZnApPzzchTHX40zn
         MIsuubK1uTrkCyAj3aH9ygJGyv5fQQhLwrNFp3Xg1tPWohwQVGDL+edgGaTUk8kOs9
         jQjVrzAsazVrPPQ/KkmurqpRN3vX0RaP4GX8PQaU=
Received: by mail-lf1-f50.google.com with SMTP id r14so10486002lfm.5;
        Tue, 14 Jan 2020 09:36:27 -0800 (PST)
X-Gm-Message-State: APjAAAW1HjhLUKOZUF2k/LXzW4zdcV1K+ORFtyaIjInJ7zJfOSMi3vTi
        yc3TJfTjCB7bt7ReLMO0pDiF9phTv9yTeVlSQQU=
X-Google-Smtp-Source: APXvYqxsDsO+lIIfwcNPo350CZUzBBMBQ0YQ6cSV/DYGyUOUba2f/Vb0dvS/IajiFBdN2w69nUq9HITTtVYz4jSKItE=
X-Received: by 2002:ac2:5582:: with SMTP id v2mr2461646lfg.183.1579023385769;
 Tue, 14 Jan 2020 09:36:25 -0800 (PST)
MIME-Version: 1.0
References: <20200110094913.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
 <CGME20200110174932epcas1p345b0e750b48cc9e351dca14e0dd4de86@epcas1p3.samsung.com>
 <20200110094913.2.Ie8eacf976ce7a13e421592f5c1ab8dbdc537da5c@changeid>
 <c793c2e5-dd0e-bff4-9769-26344afe914e@samsung.com> <VI1PR04MB702308C23513581F33EFE697EE340@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB702308C23513581F33EFE697EE340@VI1PR04MB7023.eurprd04.prod.outlook.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Wed, 15 Jan 2020 02:35:48 +0900
X-Gmail-Original-Message-ID: <CAGTfZH1YvkSQtVTCrCYyWyBNUvKoTk8Vfrc2hHYsH=3AHr-tqw@mail.gmail.com>
Message-ID: <CAGTfZH1YvkSQtVTCrCYyWyBNUvKoTk8Vfrc2hHYsH=3AHr-tqw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM / devfreq: Use exclusively PM QoS to determine
 frequency limits
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 15, 2020 at 1:08 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On 13.01.2020 09:24, Chanwoo Choi wrote:
> > Hi,
> >
> > Any device driver except for devfreq_cooling.c might
> > use dev_pm_opp_enable/disable interface.
> > So, don't need to remove the devfreq->scaling_max_freq
> > and devfreq->scaling_min_freq for supporting OPP interface.
>
> It seems that devfreq_cooling was the only upstream user of
> dev_pm_opp_enable and the remaining callers of dev_pm_opp_disable are
> probe-time checks.

OPP interface has still dev_pm_opp_enable and dev_pm_opp_disable
function. As long as remains them, any device driver related to devfreq
could call them at some time. The devfreq supports the OPP interface,
not just for only devfreq_cooling.

>
> > Regards,
> > Chanwoo Choi
> >
> > On 1/11/20 2:49 AM, Matthias Kaehlcke wrote:
> >> Traditionally devfreq cooling devices dynamically disabled OPPs
> >> that shouldn't be used because of thermal pressure. Devfreq cooling
> >> devices now use PM QoS to set frequency limits, hence the devfreq
> >> code dealing that deals with disabled OPPs can be removed.
> >>
> >> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> >> ---
> >>
> >>   drivers/devfreq/devfreq.c | 75 +++++----------------------------------
> >>   include/linux/devfreq.h   |  4 ---
> >>   2 files changed, 8 insertions(+), 71 deletions(-)
> >>
> >> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> >> index 57f6944d65a6..ec66e2c27cc4 100644
> >> --- a/drivers/devfreq/devfreq.c
> >> +++ b/drivers/devfreq/devfreq.c
> >> @@ -73,34 +73,6 @@ static struct devfreq *find_device_devfreq(struct device *dev)
> >>      return ERR_PTR(-ENODEV);
> >>   }
> >>
> >> -static unsigned long find_available_min_freq(struct devfreq *devfreq)
> >> -{
> >> -    struct dev_pm_opp *opp;
> >> -    unsigned long min_freq = 0;
> >> -
> >> -    opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &min_freq);
> >> -    if (IS_ERR(opp))
> >> -            min_freq = 0;
> >> -    else
> >> -            dev_pm_opp_put(opp);
> >> -
> >> -    return min_freq;
> >> -}
> >> -
> >> -static unsigned long find_available_max_freq(struct devfreq *devfreq)
> >> -{
> >> -    struct dev_pm_opp *opp;
> >> -    unsigned long max_freq = ULONG_MAX;
> >> -
> >> -    opp = dev_pm_opp_find_freq_floor(devfreq->dev.parent, &max_freq);
> >> -    if (IS_ERR(opp))
> >> -            max_freq = 0;
> >> -    else
> >> -            dev_pm_opp_put(opp);
> >> -
> >> -    return max_freq;
> >> -}
> >> -
> >>   /**
> >>    * get_freq_range() - Get the current freq range
> >>    * @devfreq:       the devfreq instance
> >> @@ -141,10 +113,6 @@ static void get_freq_range(struct devfreq *devfreq,
> >>              *max_freq = min(*max_freq,
> >>                              (unsigned long)HZ_PER_KHZ * qos_max_freq);
> >>
> >> -    /* Apply constraints from OPP interface */
> >> -    *min_freq = max(*min_freq, devfreq->scaling_min_freq);
> >> -    *max_freq = min(*max_freq, devfreq->scaling_max_freq);
> >> -
> >>      if (*min_freq > *max_freq)
> >>              *min_freq = *max_freq;
> >>   }
> >> @@ -610,23 +578,10 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
> >>                               void *devp)
> >>   {
> >>      struct devfreq *devfreq = container_of(nb, struct devfreq, nb);
> >> -    int err = -EINVAL;
> >> +    int err;
> >>
> >>      mutex_lock(&devfreq->lock);
> >> -
> >> -    devfreq->scaling_min_freq = find_available_min_freq(devfreq);
> >> -    if (!devfreq->scaling_min_freq)
> >> -            goto out;
> >> -
> >> -    devfreq->scaling_max_freq = find_available_max_freq(devfreq);
> >> -    if (!devfreq->scaling_max_freq) {
> >> -            devfreq->scaling_max_freq = ULONG_MAX;
> >> -            goto out;
> >> -    }
> >> -
> >>      err = update_devfreq(devfreq);
> >> -
> >> -out:
> >>      mutex_unlock(&devfreq->lock);
> >>      if (err)
> >>              dev_err(devfreq->dev.parent,
> >> @@ -781,19 +736,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >>              mutex_lock(&devfreq->lock);
> >>      }
> >>
> >> -    devfreq->scaling_min_freq = find_available_min_freq(devfreq);
> >> -    if (!devfreq->scaling_min_freq) {
> >> -            mutex_unlock(&devfreq->lock);
> >> -            err = -EINVAL;
> >> +    err = dev_pm_qos_add_request(dev, &devfreq->user_min_freq_req,
> >> +                                 DEV_PM_QOS_MIN_FREQUENCY, 0);
> >> +    if (err < 0)
> >>              goto err_dev;
> >> -    }
> >> -
> >> -    devfreq->scaling_max_freq = find_available_max_freq(devfreq);
> >> -    if (!devfreq->scaling_max_freq) {
> >> -            mutex_unlock(&devfreq->lock);
> >> -            err = -EINVAL;
> >> +    err = dev_pm_qos_add_request(dev, &devfreq->user_max_freq_req,
> >> +                                 DEV_PM_QOS_MAX_FREQUENCY,
> >> +                                 PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
> >> +    if (err < 0)
> >>              goto err_dev;
> >> -    }
> >>
> >>      devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
> >>      atomic_set(&devfreq->suspend_count, 0);
> >> @@ -834,16 +785,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >>
> >>      mutex_unlock(&devfreq->lock);
> >>
> >> -    err = dev_pm_qos_add_request(dev, &devfreq->user_min_freq_req,
> >> -                                 DEV_PM_QOS_MIN_FREQUENCY, 0);
> >> -    if (err < 0)
> >> -            goto err_devfreq;
> >> -    err = dev_pm_qos_add_request(dev, &devfreq->user_max_freq_req,
> >> -                                 DEV_PM_QOS_MAX_FREQUENCY,
> >> -                                 PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
> >> -    if (err < 0)
> >> -            goto err_devfreq;
> >> -
>
> Performing PM QoS initialization under devfreq->lock triggers lockdep
> warnings for me. The warnings seem to be legitimate:
>
> 1) At init time &dev_pm_qos_mtx is taken under &devfreq->lock;
> 2) At update time &devfreq->lock is called under &dev_pm_qos_mtx (it's
> held while notifiers are called).
>
> It's not clear why you moved dev_pm_qos_add_request higher?
>
> >>      devfreq->nb_min.notifier_call = qos_min_notifier_call;
> >>      err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
> >>                                    DEV_PM_QOS_MIN_FREQUENCY);
> >> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> >> index fb376b5b7281..cb75f23ad2f4 100644
> >> --- a/include/linux/devfreq.h
> >> +++ b/include/linux/devfreq.h
> >> @@ -126,8 +126,6 @@ struct devfreq_dev_profile {
> >>    *         touch this.
> >>    * @user_min_freq_req:     PM QoS minimum frequency request from user (via sysfs)
> >>    * @user_max_freq_req:     PM QoS maximum frequency request from user (via sysfs)
> >> - * @scaling_min_freq:       Limit minimum frequency requested by OPP interface
> >> - * @scaling_max_freq:       Limit maximum frequency requested by OPP interface
> >>    * @stop_polling:   devfreq polling status of a device.
> >>    * @suspend_freq:   frequency of a device set during suspend phase.
> >>    * @resume_freq:    frequency of a device set in resume phase.
> >> @@ -166,8 +164,6 @@ struct devfreq {
> >>
> >>      struct dev_pm_qos_request user_min_freq_req;
> >>      struct dev_pm_qos_request user_max_freq_req;
> >> -    unsigned long scaling_min_freq;
> >> -    unsigned long scaling_max_freq;
> >>      bool stop_polling;
> >>
> >>      unsigned long suspend_freq;
> >>
> >
>


-- 
Best Regards,
Chanwoo Choi
