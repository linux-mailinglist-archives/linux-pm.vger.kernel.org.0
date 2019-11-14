Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56FD6FC0ED
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 08:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfKNHlz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 02:41:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36240 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfKNHlz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 02:41:55 -0500
Received: by mail-ed1-f67.google.com with SMTP id f7so4182523edq.3
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 23:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b4oVKxmBs4/RCYOKu4hwaTsf6M0D7a2xIkhCkKT+Pto=;
        b=B9xFb8FNqh/gxYhmiXwmoboX9b0W301cObyelGcHy+jepHxS+R9vPMMrJYylMOQXlM
         51z2p/t5u0IbsMSgsDBX5z2VowBIW5MPZtYErL29n1z3iPMkQrfib/Lu2WTZRChW3FXd
         0zV4AvJNKL+6nlpVVhTwC7oi15bZdlzyWb7rM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4oVKxmBs4/RCYOKu4hwaTsf6M0D7a2xIkhCkKT+Pto=;
        b=ihNGT5bLYSR5ZLiyNodPF4WzKdN7O0+12cKrOmHI87XyCyAycMM/+YuNOwDFTfqjpb
         38lRCy8eQ+1U7qOTiouhnKSxyFKdfpDPNpZ38UY65aOaNFT2DNPY9hATxuOtwA+Tix9j
         4G8mkog6LZlJbTy+Kot0MkUPM3FMxqJHqLiYkmYjf+OK7djA/X1AjKzqA5205P7YoXnx
         bdrhKqmfwBDvRUca1dm6J2ygp3IwYZs2wj2DzYYgIfRV0NZbqYRqeyN2UHkEuXNDXH9B
         S//TXzozvSsaX3J1+Sx8JOxML7jaoCX1M4klZXCYMKj8qn7vjrUQJhQ+C4ioKghHDICI
         hzyg==
X-Gm-Message-State: APjAAAWWt0TSilVvUJQ+SA8tcNekeCswyGsz/q5PkFQhhMNS15Ig8ZdR
        1IUZFTMgFytSEDmUlRomqXDok3/U9A2Jf5XbqIHhRQ==
X-Google-Smtp-Source: APXvYqz6yZbtrJ5sSQUSRuZpeFS1kkbqDoajndNm+AhsVzWJvYBAWCTn8mxQzSajS+KvpujI+sImRayrC8IGh/nQuQg=
X-Received: by 2002:a17:906:2518:: with SMTP id i24mr7155659ejb.4.1573717312605;
 Wed, 13 Nov 2019 23:41:52 -0800 (PST)
MIME-Version: 1.0
References: <20190906100514.30803-1-roger.lu@mediatek.com> <20190906100514.30803-4-roger.lu@mediatek.com>
In-Reply-To: <20190906100514.30803-4-roger.lu@mediatek.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Thu, 14 Nov 2019 15:41:16 +0800
Message-ID: <CANdKZ0eEMQe+OFOJxOs37gyUm2vGQ2F-NeAkcxmgYXVKvRzQBw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] PM / AVS: SVS: Introduce SVS engine
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>, yt.lee@mediatek.com,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nishanth Menon <nm@ti.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Roger,

On Fri, Sep 6, 2019 at 6:06 PM Roger Lu <roger.lu@mediatek.com> wrote:
>
> The SVS (Smart Voltage Scaling) engine is a piece of hardware which is
> used to calculate optimized voltage values of several power domains, e.g.
> CPU/GPU/CCI, according to chip process corner, temperatures, and other
> factors. Then DVFS driver could apply those optimized voltage values to
> reduce power consumption.
>
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>  drivers/power/avs/Kconfig     |   10 +
>  drivers/power/avs/Makefile    |    1 +
>  drivers/power/avs/mtk_svs.c   | 2075 +++++++++++++++++++++++++++++++++
>  include/linux/power/mtk_svs.h |   23 +
>  4 files changed, 2109 insertions(+)
>  create mode 100644 drivers/power/avs/mtk_svs.c
>  create mode 100644 include/linux/power/mtk_svs.h
>
> [...]
> diff --git a/drivers/power/avs/mtk_svs.c b/drivers/power/avs/mtk_svs.c
> new file mode 100644
> index 000000000000..78ec93c3a4a5
> --- /dev/null
> +++ b/drivers/power/avs/mtk_svs.c
> [...]
> +static int svs_set_volts(struct svs_bank *svsb, bool force_update)
> +{
> +       u32 i, svsb_volt, opp_volt, low_temp_offset = 0;
> +       int zone_temp, ret;
> +
> +       mutex_lock(&svsb->lock);
> +
> +       /* If bank is suspended, it means init02 voltage is applied.
> +        * Don't need to update opp voltage anymore.
> +        */
> +       if (svsb->suspended && !force_update) {
> +               pr_notice("%s: bank is suspended\n", svsb->name);
> +               mutex_unlock(&svsb->lock);
> +               return -EPERM;
> +       }
> +
> +       /* get thermal effect */
> +       if (svsb->phase == SVS_PHASE_MON) {
> +               if (svsb->svs_temp > svsb->upper_temp_bound &&
> +                   svsb->svs_temp < svsb->lower_temp_bound) {
> +                       pr_err("%s: svs_temp is abnormal (0x%x)?\n",
> +                              svsb->name, svsb->svs_temp);
> +                       mutex_unlock(&svsb->lock);
> +                       return -EINVAL;
> +               }
> +
> +               ret = svs_get_zone_temperature(svsb, &zone_temp);
> +               if (ret) {
> +                       pr_err("%s: cannot get zone \"%s\" temperature\n",
> +                              svsb->name, svsb->zone_name);
> +                       pr_err("%s: add low_temp_offset = %u\n",
> +                              svsb->name, svsb->low_temp_offset);
> +                       zone_temp = svsb->low_temp_threashold;
> +               }
> +
> +               if (zone_temp <= svsb->low_temp_threashold)
> +                       low_temp_offset = svsb->low_temp_offset;
> +       }
> +
> +       /* vmin <= svsb_volt (opp_volt) <= signed-off voltage */
> +       for (i = 0; i < svsb->opp_count; i++) {
> +               if (svsb->phase == SVS_PHASE_MON) {
> +                       svsb_volt = max((svsb->volts[i] + svsb->volt_offset +
> +                                        low_temp_offset), svsb->vmin);
> +                       opp_volt = svs_volt_to_opp_volt(svsb_volt,
> +                                                       svsb->volt_step,
> +                                                       svsb->volt_base);
> +               } else if (svsb->phase == SVS_PHASE_INIT02) {
> +                       svsb_volt = max((svsb->init02_volts[i] +
> +                                        svsb->volt_offset), svsb->vmin);
> +                       opp_volt = svs_volt_to_opp_volt(svsb_volt,
> +                                                       svsb->volt_step,
> +                                                       svsb->volt_base);
> +               } else if (svsb->phase == SVS_PHASE_ERROR) {
> +                       opp_volt = svsb->opp_volts[i];
> +               } else {
> +                       pr_err("%s: unknown phase: %u?\n",
> +                              svsb->name, svsb->phase);
> +                       mutex_unlock(&svsb->lock);
> +                       return -EINVAL;
> +               }
> +
> +               opp_volt = min(opp_volt, svsb->opp_volts[i]);
> +               ret = dev_pm_opp_adjust_voltage(svsb->dev, svsb->opp_freqs[i],
> +                                               opp_volt);

The version of this function in opp tree
(https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=opp/linux-next&id=25cb20a212a1f989385dfe23230817e69c62bee5)
has a different function signature, so this should be changed too.

> +               if (ret) {
> +                       pr_err("%s: set voltage failed: %d\n", svsb->name, ret);
> +                       mutex_unlock(&svsb->lock);
> +                       return ret;
> +               }
> +       }
> +
> +       mutex_unlock(&svsb->lock);
> +
> +       return 0;
> +}
> +
> [...]
> +static int svs_init01(struct mtk_svs *svs)
> +{
> +       const struct svs_platform *svsp = svs->platform;
> +       struct svs_bank *svsb;
> +       struct pm_qos_request qos_request = { {0} };
> +       unsigned long flags, time_left;
> +       bool search_done;
> +       int ret = -EINVAL;
> +       u32 opp_freqs, opp_vboot, buck_volt, idx, i;
> +
> +       /* Let CPUs leave idle-off state for initializing svs_init01. */
> +       pm_qos_add_request(&qos_request, PM_QOS_CPU_DMA_LATENCY, 0);
> +
> +       /* Sometimes two svs_bank use the same buck.
> +        * Therefore, we set each svs_bank to vboot voltage first.
> +        */
> +       for (idx = 0; idx < svsp->bank_num; idx++) {
> +               svsb = &svsp->banks[idx];
> +               search_done = false;
> +
> +               if (!svsb->init01_support)
> +                       continue;
> +
> +               ret = regulator_set_mode(svsb->buck, REGULATOR_MODE_FAST);
> +               if (ret)
> +                       pr_notice("%s: fail to set fast mode: %d\n",
> +                                 svsb->name, ret);
> +
> +               if (svsb->mtcmos_request) {
> +                       ret = regulator_enable(svsb->buck);
> +                       if (ret) {
> +                               pr_err("%s: fail to enable %s power: %d\n",
> +                                      svsb->name, svsb->buck_name, ret);
> +                               goto init01_finish;
> +                       }
> +
> +                       ret = dev_pm_domain_attach(svsb->dev, false);
> +                       if (ret) {
> +                               pr_err("%s: attach pm domain fail: %d\n",
> +                                      svsb->name, ret);
> +                               goto init01_finish;
> +                       }
> +
> +                       pm_runtime_enable(svsb->dev);
> +                       ret = pm_runtime_get_sync(svsb->dev);
> +                       if (ret < 0) {
> +                               pr_err("%s: turn mtcmos on fail: %d\n",
> +                                      svsb->name, ret);
> +                               goto init01_finish;
> +                       }
> +               }
> +
> +               /* Find the fastest freq that can be run at vboot and
> +                * fix to that freq until svs_init01 is done.
> +                */
> +               opp_vboot = svs_volt_to_opp_volt(svsb->vboot,
> +                                                svsb->volt_step,
> +                                                svsb->volt_base);
> +
> +               for (i = 0; i < svsb->opp_count; i++) {
> +                       opp_freqs = svsb->opp_freqs[i];
> +                       if (!search_done && svsb->opp_volts[i] <= opp_vboot) {
> +                               ret = dev_pm_opp_adjust_voltage(svsb->dev,
> +                                                               opp_freqs,
> +                                                               opp_vboot);

Same here.

> +                               if (ret) {
> +                                       pr_err("%s: set voltage failed: %d\n",
> +                                              svsb->name, ret);
> +                                       goto init01_finish;
> +                               }
> +
> +                               search_done = true;
> +                       } else {
> +                               dev_pm_opp_disable(svsb->dev,
> +                                                  svsb->opp_freqs[i]);
> +                       }
> +               }
> +       }
> +
> +       for (idx = 0; idx < svsp->bank_num; idx++) {
> +               svsb = &svsp->banks[idx];
> +               svs->bank = svsb;
> +
> +               if (!svsb->init01_support)
> +                       continue;
> +
> +               opp_vboot = svs_volt_to_opp_volt(svsb->vboot,
> +                                                svsb->volt_step,
> +                                                svsb->volt_base);
> +
> +               buck_volt = regulator_get_voltage(svsb->buck);
> +               if (buck_volt != opp_vboot) {
> +                       pr_err("%s: buck voltage: %u, expected vboot: %u\n",
> +                              svsb->name, buck_volt, opp_vboot);
> +                       ret = -EPERM;
> +                       goto init01_finish;
> +               }
> +
> +               init_completion(&svsb->init_completion);
> +               flags = claim_mtk_svs_lock();
> +               svs_set_phase(svs, SVS_PHASE_INIT01);
> +               release_mtk_svs_lock(flags);
> +               time_left =
> +                       wait_for_completion_timeout(&svsb->init_completion,
> +                                                   msecs_to_jiffies(2000));
> +               if (time_left == 0) {
> +                       pr_err("%s: init01 completion timeout\n", svsb->name);
> +                       ret = -EBUSY;
> +                       goto init01_finish;
> +               }
> +       }
> +
> +init01_finish:
> +       for (idx = 0; idx < svsp->bank_num; idx++) {
> +               svsb = &svsp->banks[idx];
> +
> +               if (!svsb->init01_support)
> +                       continue;
> +
> +               for (i = 0; i < svsb->opp_count; i++)
> +                       dev_pm_opp_enable(svsb->dev, svsb->opp_freqs[i]);
> +
> +               if (regulator_set_mode(svsb->buck, REGULATOR_MODE_NORMAL))
> +                       pr_notice("%s: fail to set normal mode: %d\n",
> +                                 svsb->name, ret);
> +
> +               if (svsb->mtcmos_request) {
> +                       if (pm_runtime_put_sync(svsb->dev))
> +                               pr_err("%s: turn mtcmos off fail: %d\n",
> +                                      svsb->name, ret);
> +                       pm_runtime_disable(svsb->dev);
> +                       dev_pm_domain_detach(svsb->dev, 0);
> +                       if (regulator_disable(svsb->buck))
> +                               pr_err("%s: fail to disable %s power: %d\n",
> +                                      svsb->name, svsb->buck_name, ret);
> +               }
> +       }
> +
> +       pm_qos_remove_request(&qos_request);
> +
> +       return ret;
> +}
> +
> [...]
