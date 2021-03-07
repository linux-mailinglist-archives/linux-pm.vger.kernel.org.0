Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7313301E7
	for <lists+linux-pm@lfdr.de>; Sun,  7 Mar 2021 15:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhCGORS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Mar 2021 09:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhCGOQy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Mar 2021 09:16:54 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03846C06174A;
        Sun,  7 Mar 2021 06:16:51 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id r23so11592502ljh.1;
        Sun, 07 Mar 2021 06:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=/TzNN/60wc695gP1RZeHGsrPFK5GpxsOr9GyBQ7Tc6k=;
        b=LnV/mCfNDaVEdkFff9ytx6G1iG/t6uw8cQds+0MN+0v2EBdvnqJK+axrsnITlnX2Go
         4mgMeSuSk8Mb+AnyT7jAkywQIVtdQQCoXAcNPjxBuO43F9jWFP88o6CluWYThOV9xMbp
         XDMrTSK/f5x2qAFWdBx3AsJMx2HzdIten5EUpstLmcOEmJH17aXNbltDn2prkfmBR2Am
         bQwouNVSkoq36Ui9Qj78mXwyBpzfxIrdOuDh4bH8Habdc2e/p4eT7Cez5WIuY81TbxUX
         yQisV/+pHFqzdc2eDSt32tdmHCADo7S2wWQW1cQHjQMHk4qU+1UCoNwnaMWnT6VI9c2f
         2AVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=/TzNN/60wc695gP1RZeHGsrPFK5GpxsOr9GyBQ7Tc6k=;
        b=i1NjGsOpDsWAqk0aPrBIhprS88vH3ci8zM5lobh31lYsnGoKw2qo7wVrKZQRyqMQaU
         vDWIqw/O6zI6vICgmP9Sgh2JdK8yIrB03VfnKIoLFMUlqCqgW9id8BfTN6DIdnq6tHgP
         6c7/DWGLbWyGiIl3+4NNdflDU1Bw5R0kGN0FrrrEpREFcs76Z87QA1emPH+Q5LsCwNy8
         c88CdPi6pRBo/Q2W0TYJkvohxE5RT2a4L0L2Rk4Jr3NdyaWc+IzNzbPmpAILZspgwnko
         qFj1KywthvtNd4Ic8en/uaUdB5c7rM5URQdc20NkE/fgsJ29YAtf5tmZOJPD2wQEMzY5
         avQQ==
X-Gm-Message-State: AOAM533ryzqXX8YKnDMqNfa6+MFhFOZh2bkI1RWNqDMG8fsQYs42YmUW
        lakqi8FpGqv49qbbxeeYMAA/EqBtA4dx+tpmQqc=
X-Google-Smtp-Source: ABdhPJwEVZ4bn7s9pxKOYbPwRbkhSuzAM8iP6Aihk6ac2M88HjD/erfpBWsB02YhLyCxcTkj4gn/pRYzn9mZTX7SeX4=
X-Received: by 2002:a2e:9047:: with SMTP id n7mr11289086ljg.291.1615126610317;
 Sun, 07 Mar 2021 06:16:50 -0800 (PST)
MIME-Version: 1.0
References: <20210307094519.9032-1-daniel.lezcano@linaro.org>
In-Reply-To: <20210307094519.9032-1-daniel.lezcano@linaro.org>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sun, 7 Mar 2021 23:16:13 +0900
Message-ID: <CAGTfZH3jFJ8CaJ1Yg=oxhVSYVDULWr83iPokL+tut8mKgSufFA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] devfreq: Register devfreq as a cooling device on demand
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Steven Price <steven.price@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 7. =EC=98=A4=ED=9B=84 6:45, Daniel Lezcano wrote:
> Currently the default behavior is to manually having the devfreq
> backend to register themselves as a devfreq cooling device.
>
> Instead of adding the code in the drivers for the thermal cooling
> device registering, let's provide a flag in the devfreq's profile to
> tell the common devfreq code to register the newly created devfreq as
> a cooling device.
>
> Suggested-by: Chanwoo Choi <cwchoi00@gmail.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   V3:
>     - Rebased on linux-pm branch without units.h
>     - Set the cdev to NULL in case of error
>     - Added description for the cdev field in the devfreq structure
>   V2:
>     - Added is_cooling_device boolean in profile structure
>     - Register cooling device when the is_cooling_device boolean is set
>     - Remove devfreq cooling device registration in the backend drivers
>   V1:
>     - Register devfreq as a cooling device unconditionnally
> ---
>   drivers/devfreq/devfreq.c | 13 +++++++++++++
>   include/linux/devfreq.h   |  8 ++++++++
>   2 files changed, 21 insertions(+)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index bf3047896e41..cf64aeec468f 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -11,6 +11,7 @@
>   #include <linux/kmod.h>
>   #include <linux/sched.h>
>   #include <linux/debugfs.h>
> +#include <linux/devfreq_cooling.h>
>   #include <linux/errno.h>
>   #include <linux/err.h>
>   #include <linux/init.h>
> @@ -26,6 +27,7 @@
>   #include <linux/hrtimer.h>
>   #include <linux/of.h>
>   #include <linux/pm_qos.h>
> +#include <linux/thermal.h>
>   #include "governor.h"
>
>   #define CREATE_TRACE_POINTS
> @@ -935,6 +937,15 @@ struct devfreq *devfreq_add_device(struct device *de=
v,
>
>       mutex_unlock(&devfreq_list_lock);
>
> +     if (devfreq->profile->is_cooling_device) {
> +             devfreq->cdev =3D devfreq_cooling_em_register(devfreq, NULL=
);
> +             if (IS_ERR(devfreq->cdev)) {
> +                     dev_info(dev, "Failed to register devfreq "
> +                              "cooling device\n");
> +                     devfreq->cdev =3D NULL;
> +             }
> +     }
> +
>       return devfreq;
>
>   err_init:
> @@ -960,6 +971,8 @@ int devfreq_remove_device(struct devfreq *devfreq)
>       if (!devfreq)
>               return -EINVAL;
>
> +     thermal_cooling_device_unregister(devfreq->cdev);

I have a question. Why don't you use devfreq_cooling_unregister()?
When thermal_cooling_device_unregister(), how can we remove
the pm_qos_request of devfreq device?

> +
>       if (devfreq->governor) {
>               devfreq->governor->event_handler(devfreq,
>                                                DEVFREQ_GOV_STOP, NULL);
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 26ea0850be9b..aba7ace11b72 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -98,11 +98,15 @@ struct devfreq_dev_status {
>    * @freq_table:             Optional list of frequencies to support sta=
tistics
>    *                  and freq_table must be generated in ascending order=
.
>    * @max_state:              The size of freq_table.
> + *
> + * @is_cooling_device: A self-explanatory boolean giving the device a
> + *                     cooling effect property.
>    */
>   struct devfreq_dev_profile {
>       unsigned long initial_freq;
>       unsigned int polling_ms;
>       enum devfreq_timer timer;
> +     bool is_cooling_device;
>
>       int (*target)(struct device *dev, unsigned long *freq, u32 flags);
>       int (*get_dev_status)(struct device *dev,
> @@ -156,6 +160,7 @@ struct devfreq_stats {
>    * @suspend_count:   suspend requests counter for a device.
>    * @stats:  Statistics of devfreq device behavior
>    * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER =
notifier
> + * @cdev:    Cooling device pointer if the devfreq has cooling property
>    * @nb_min:         Notifier block for DEV_PM_QOS_MIN_FREQUENCY
>    * @nb_max:         Notifier block for DEV_PM_QOS_MAX_FREQUENCY
>    *
> @@ -198,6 +203,9 @@ struct devfreq {
>
>       struct srcu_notifier_head transition_notifier_list;
>
> +     /* Pointer to the cooling device if used for thermal mitigation */
> +     struct thermal_cooling_device *cdev;
> +
>       struct notifier_block nb_min;
>       struct notifier_block nb_max;
>   };
>


--
Best Regards,
Samsung Electronics

Chanwoo Choi
