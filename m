Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCC5B8556A
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 23:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfHGVsO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 17:48:14 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38094 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfHGVsO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 17:48:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id d17so110478128oth.5
        for <linux-pm@vger.kernel.org>; Wed, 07 Aug 2019 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mSHuaNu9lU+Ixx/n7ozjIH9HBqiia438/8ymvVIMAzo=;
        b=uBFoTtJSlZhO1SE9sCfYIGHgskii+KRgmHrwqFouPvnAAx3QzreFFpEOjNUpWZsfj7
         zt3dsS39gmm1NqcDwBT5p+pXt8qZ+8UxDG+n58CqtRftnFIOhsFFgNPU5HsSlJKsNaJm
         tii5GXKSlXEE3jx4YSVrg3ZGJownDOilh2KORliCGNw3PuAOyjxatgOiUUyw6XXVaCP3
         JqWxMbVAytMEytOl/BAMj8uoNsQTeTRdx/Te++uS8kyf7e7Arf0rF4qaUi815xnEl4ey
         sPnCKz48tksLVQKzagMAlfl0xJJbNQr2EwmJHcLosNjpjBZTMACDTWSJ1rUYAbYmeFVF
         UK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mSHuaNu9lU+Ixx/n7ozjIH9HBqiia438/8ymvVIMAzo=;
        b=iqG58nKcNh98ay7dfUNSmgIWw/qfKS0Ua1dfFiV6sKoPoExWaS25gJ+D/q0PLX2vWG
         De5DoutkYGFCyse8wArwPoQEblWVD2HD+ZiMGjok47ktU0mKd5KSXXp+SOfDEVrPJ/Mo
         1Q/oWznDNDKlXjEgQPqhhATI7vVVBsTh7vlyBMbfb+ESN0nnuQQQdsqW737xDrAdMfQz
         mdMli4twMx/k+Ck+9OIbYaBsM7Xv4rEKm8mElmZay3qJVx21IMnap2Z/Uc/v4tn1V5wn
         KdUtJKWeCd2nl712INmcx9XDWekfXSswUPPVqqvWNlHEp6dwa2hkNi81RVi7bFp1CzfQ
         wQww==
X-Gm-Message-State: APjAAAWlrymNc4CaWA4A2DCU+qxW8MeR0Y6kKn7Vh24x63xRyGxGanOx
        mzR1C6VqqSAJHPK0j57KngktRsI0Og0ddvqKucu9Yg==
X-Google-Smtp-Source: APXvYqyV040mWDZ3MB5lgeANEpPxbK+KRrG9Vv9kvaD41Q+ixuU9H8WRTO3d94OarM/N9zV1zHRTPH4VJgBN7g89l2E=
X-Received: by 2002:aca:6104:: with SMTP id v4mr210784oib.172.1565214493009;
 Wed, 07 Aug 2019 14:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <bcbab490489ef5143361048db93752741b38e379.1565081126.git.leonard.crestez@nxp.com>
In-Reply-To: <bcbab490489ef5143361048db93752741b38e379.1565081126.git.leonard.crestez@nxp.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 7 Aug 2019 14:47:37 -0700
Message-ID: <CAGETcx9pf543R4j3_YE2TtFMPM8Teh-NNj06ikvo92JuNHDtGg@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: Add dev_pm_qos support
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 6, 2019 at 2:03 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> Add dev_pm_qos notifies to devfreq core in order to support frequency
> limits via dev_pm_qos_add_request and related APIs
>
> Unlike the rest of devfreq the dev_pm_qos frequency is measured kHz:
> this is consistent with current dev_pm_qos usage for cpufreq and allows
> frequencies above 2Ghz.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 77 ++++++++++++++++++++++++++++++++++-----
>  include/linux/devfreq.h   |  3 ++
>  2 files changed, 71 insertions(+), 9 deletions(-)
>
> This was inspired by recent changes adding dev_pm_qos limits for
> cpufreq: https://lkml.org/lkml/2019/7/4/118
>
> The pm_qos code make deep assumptions that requests need to be
> expressed as "s32" through it's use of "plist". Handling freq as a kHz
> values seems the easiest solution for this, perhaps it should be
> documented in dev_pm_qos itself?
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 784c08e4f931..de9e825ae1f4 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -22,10 +22,11 @@
>  #include <linux/platform_device.h>
>  #include <linux/list.h>
>  #include <linux/printk.h>
>  #include <linux/hrtimer.h>
>  #include <linux/of.h>
> +#include <linux/pm_qos.h>
>  #include "governor.h"
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/devfreq.h>
>
> @@ -96,10 +97,26 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>                 dev_pm_opp_put(opp);
>
>         return max_freq;
>  }
>
> +static unsigned long get_effective_min_freq(struct devfreq *devfreq)
> +{
> +       return max3(devfreq->scaling_min_freq, devfreq->min_freq,
> +               1000 * (unsigned long)dev_pm_qos_read_value(
> +                               devfreq->dev.parent,
> +                               DEV_PM_QOS_MIN_FREQUENCY));
> +}
> +
> +static unsigned long get_effective_max_freq(struct devfreq *devfreq)
> +{
> +       return min3(devfreq->scaling_max_freq, devfreq->max_freq,
> +               1000 * (unsigned long)dev_pm_qos_read_value(
> +                               devfreq->dev.parent,
> +                               DEV_PM_QOS_MAX_FREQUENCY));
> +}
> +
>  /**
>   * devfreq_get_freq_level() - Lookup freq_table for the frequency
>   * @devfreq:   the devfreq instance
>   * @freq:      the target frequency
>   */
> @@ -356,12 +373,12 @@ int update_devfreq(struct devfreq *devfreq)
>          *
>          * List from the highest priority
>          * max_freq
>          * min_freq
>          */
> -       max_freq = min(devfreq->scaling_max_freq, devfreq->max_freq);
> -       min_freq = max(devfreq->scaling_min_freq, devfreq->min_freq);
> +       max_freq = get_effective_max_freq(devfreq);
> +       min_freq = get_effective_min_freq(devfreq);
>
>         if (freq < min_freq) {
>                 freq = min_freq;
>                 flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
>         }
> @@ -570,10 +587,31 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>         mutex_unlock(&devfreq->lock);
>
>         return ret;
>  }
>
> +static int devfreq_qos_notifier_call(struct devfreq *devfreq)
> +{
> +       int ret;
> +
> +       mutex_lock(&devfreq->lock);
> +       ret = update_devfreq(devfreq);
> +       mutex_unlock(&devfreq->lock);
> +
> +       return ret;
> +}
> +
> +static int devfreq_qos_min_notifier_call(struct notifier_block *nb, unsigned long type, void *devp)
> +{
> +       return devfreq_qos_notifier_call(container_of(nb, struct devfreq, nb_min));
> +}
> +
> +static int devfreq_qos_max_notifier_call(struct notifier_block *nb, unsigned long type, void *devp)
> +{
> +       return devfreq_qos_notifier_call(container_of(nb, struct devfreq, nb_max));
> +}
> +
>  /**
>   * devfreq_dev_release() - Callback for struct device to release the device.
>   * @dev:       the devfreq device
>   *
>   * Remove devfreq from the list and release its resources.
> @@ -636,21 +674,46 @@ struct devfreq *devfreq_add_device(struct device *dev,
>                 err = -ENOMEM;
>                 goto err_out;
>         }
>
>         mutex_init(&devfreq->lock);
> -       mutex_lock(&devfreq->lock);
>         devfreq->dev.parent = dev;
>         devfreq->dev.class = devfreq_class;
>         devfreq->dev.release = devfreq_dev_release;
>         devfreq->profile = profile;
>         strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
>         devfreq->previous_freq = profile->initial_freq;
>         devfreq->last_status.current_frequency = profile->initial_freq;
>         devfreq->data = data;
>         devfreq->nb.notifier_call = devfreq_notifier_call;
>
> +       /*
> +        * notifier from pm_qos
> +        *
> +        * initialized outside of devfreq->lock to avoid circular warning
> +        * between devfreq->lock and dev_pm_qos_mtx
> +        */
> +       devfreq->nb_min.notifier_call = devfreq_qos_min_notifier_call;
> +       devfreq->nb_max.notifier_call = devfreq_qos_max_notifier_call;
> +
> +       err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
> +                                     DEV_PM_QOS_MIN_FREQUENCY);
> +       if (err) {
> +               dev_err(dev, "Failed to register MIN QoS notifier: %d\n", err);
> +               panic("fail\n");
> +               goto err_dev;
> +       }
> +
> +       err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_max,
> +                                     DEV_PM_QOS_MAX_FREQUENCY);
> +       if (err) {
> +               dev_err(dev, "Failed to register MAX QoS notifier: %d\n", err);
> +               panic("fail\n");
> +               goto err_dev;
> +       }
> +
> +       mutex_lock(&devfreq->lock);
>         if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
>                 mutex_unlock(&devfreq->lock);
>                 err = set_freq_table(devfreq);
>                 if (err < 0)
>                         goto err_dev;

Where's the devfreq_remove_device() clean up of this?

> @@ -1311,13 +1374,11 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>  }
>
>  static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
>                              char *buf)
>  {
> -       struct devfreq *df = to_devfreq(dev);
> -
> -       return sprintf(buf, "%lu\n", max(df->scaling_min_freq, df->min_freq));
> +       return sprintf(buf, "%lu\n", get_effective_min_freq(to_devfreq(dev)));

Not directly related to your patch but I wish I had caught this
behavior of min_freq_show earlier and nacked it. The "show the
aggregated instantaneous min freq" file should have been separate from
the user space min freq file. So if init scripts set some minfreq and
some other userspace daemon wants to take control of the min_freq
userspace vote, there's no way for it to query the current userspace
vote because the PMQoS or OPP based minfreq limits might have caused
the instantaneous min freq value to have changed. We have this same
mess with cpufreq too. We really need to fix this and split userspace
min/max freq votes file from current min/max freq.

>  }
>
>  static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>                               const char *buf, size_t count)
>  {
> @@ -1356,13 +1417,11 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  static DEVICE_ATTR_RW(min_freq);
>
>  static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
>                              char *buf)
>  {
> -       struct devfreq *df = to_devfreq(dev);
> -
> -       return sprintf(buf, "%lu\n", min(df->scaling_max_freq, df->max_freq));
> +       return sprintf(buf, "%lu\n", get_effective_max_freq(to_devfreq(dev)));
>  }
>  static DEVICE_ATTR_RW(max_freq);

-Saravana
