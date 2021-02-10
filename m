Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2569316139
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 09:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhBJIjC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 03:39:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229866AbhBJIgl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Feb 2021 03:36:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D80CD64E4B;
        Wed, 10 Feb 2021 08:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612946154;
        bh=wgCPkGGS0IKofl2KiKwa9tYDcV/QzFJiyPoJ3KXa+GM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dYgZaO/82CpuCbPdGwT0XIMPc/iTQyjvcysKCXfIj6lTKfQnS2tXhOeBvNbsBroGV
         LJfQHFFABgkK3MTQKg4YyLaAlJgbMZUXzhBgE1DkXM5ZSwF9f7FRKMYpH3URn+xEzx
         Syrf30SrqZKbTML0UKYIT2QWdzT9msClTBDTLOpoPLgaBbWqSyhbZ/xDG3RCCvr609
         DplZi+PelRT6Xa59TydyBaSvV3I1yKCCdap52mPM8ZWbRtZgaaTsP8PZ6N/r+8N8Ob
         Sia+tg8boNorx2ydm2gPgftyuPsoTcpGSYpNIaeSf4g7gt1PPXhqkovVvPq0N0wdgC
         5zP4ktUTofNLg==
Received: by mail-ej1-f48.google.com with SMTP id l25so2540643eja.9;
        Wed, 10 Feb 2021 00:35:53 -0800 (PST)
X-Gm-Message-State: AOAM532jm8zV9G7oB9tm7BQpi1N0Puaz4HxOzQAbAugZvbhyrFr42mpE
        ZZPBHsqSEaSPg24Kt3mikKJavzQuBms0L4xl0fY=
X-Google-Smtp-Source: ABdhPJyshAsfw41zuCJPO5U9sz20Bb4CD663F3F49sEEPxxSkGNo+Qksxg0XGPWppVGjuUTKS5dqCI4fE5WDjrwQWNk=
X-Received: by 2002:a17:907:20ae:: with SMTP id pw14mr1864916ejb.454.1612946152268;
 Wed, 10 Feb 2021 00:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20210202021747.717-1-r-rivera-matos@ti.com> <20210202021747.717-3-r-rivera-matos@ti.com>
In-Reply-To: <20210202021747.717-3-r-rivera-matos@ti.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 10 Feb 2021 09:35:40 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdmJEVNNj4+d+GV4zchw=87ZKMiEpA6naADTMMMz-3j=w@mail.gmail.com>
Message-ID: <CAJKOXPdmJEVNNj4+d+GV4zchw=87ZKMiEpA6naADTMMMz-3j=w@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] power: supply: bq25790: Introduce the BQ25790
 charger driver
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dmurphy@ti.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2 Feb 2021 at 03:20, Ricardo Rivera-Matos <r-rivera-matos@ti.com> wrote:
>
> From: Dan Murphy <dmurphy@ti.com>
>
> BQ25790 is a highly integrated switch-mode buck-boost charger
> for 1-4 cell Li-ion battery and Li-polymer battery.
>
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Looks like wrong order of Sobs. Since Dan was the author, did you
really contribute here before him?

(...)

> +
> +static bool bq25790_state_changed(struct bq25790_device *bq,
> +                                 struct bq25790_state *new_state)
> +{
> +       struct bq25790_state old_state;
> +
> +       mutex_lock(&bq->lock);
> +       old_state = bq->state;
> +       mutex_unlock(&bq->lock);
> +
> +       return memcmp(&old_state, new_state,
> +                               sizeof(struct bq25790_state)) != 0;
> +}
> +
> +static irqreturn_t bq25790_irq_handler_thread(int irq, void *private)
> +{
> +       struct bq25790_device *bq = private;
> +       struct bq25790_state state;
> +       int ret;
> +
> +       ret = bq25790_get_state(bq, &state);
> +       if (ret < 0)
> +               goto irq_out;
> +
> +       if (!bq25790_state_changed(bq, &state))

You will be waking up user-space on every voltage or current change.
It was expressed on the lists that this is not desired and instead you
should notify only on change of important attributes (e.g. SoC, charge
status, cable status).


> +               goto irq_out;
> +
> +       mutex_lock(&bq->lock);
> +       bq->state = state;
> +       mutex_unlock(&bq->lock);
> +
> +       power_supply_changed(bq->charger);
> +
> +irq_out:
> +       return IRQ_HANDLED;
> +}
> +

(...)

> +
> +static int bq25790_parse_dt(struct bq25790_device *bq,
> +               struct power_supply_config *psy_cfg, struct device *dev)
> +{
> +       int ret = 0;
> +
> +       psy_cfg->drv_data = bq;
> +       psy_cfg->of_node = dev->of_node;

You parse here DT, so don't initialize power supply config in the same
time. It's mixing two things in the same function.

> +
> +       ret = device_property_read_u32(bq->dev, "ti,watchdog-timeout-ms",
> +                                      &bq->watchdog_timer);
> +       if (ret)
> +               bq->watchdog_timer = BQ25790_WATCHDOG_DIS;
> +
> +       if (bq->watchdog_timer > BQ25790_WATCHDOG_MAX ||
> +           bq->watchdog_timer < BQ25790_WATCHDOG_DIS)
> +               return -EINVAL;
> +
> +       ret = device_property_read_u32(bq->dev,
> +                                      "input-voltage-limit-microvolt",
> +                                      &bq->init_data.vlim);
> +       if (ret)
> +               bq->init_data.vlim = BQ25790_VINDPM_DEF_uV;
> +
> +       if (bq->init_data.vlim > BQ25790_VINDPM_V_MAX_uV ||
> +           bq->init_data.vlim < BQ25790_VINDPM_V_MIN_uV)
> +               return -EINVAL;
> +
> +       ret = device_property_read_u32(bq->dev,
> +                                      "input-current-limit-microamp",
> +                                      &bq->init_data.ilim);
> +       if (ret)
> +               bq->init_data.ilim = BQ25790_IINDPM_DEF_uA;
> +
> +       if (bq->init_data.ilim > BQ25790_IINDPM_I_MAX_uA ||
> +           bq->init_data.ilim < BQ25790_IINDPM_I_MIN_uA)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static int bq25790_probe(struct i2c_client *client,
> +                        const struct i2c_device_id *id)
> +{
> +       struct device *dev = &client->dev;
> +       struct bq25790_device *bq;
> +       struct power_supply_config psy_cfg = { };
> +
> +       int ret;
> +
> +       bq = devm_kzalloc(dev, sizeof(*bq), GFP_KERNEL);
> +       if (!bq)
> +               return -ENOMEM;
> +
> +       bq->client = client;
> +       bq->dev = dev;
> +
> +       mutex_init(&bq->lock);
> +
> +       strncpy(bq->model_name, id->name, I2C_NAME_SIZE);
> +
> +       bq->regmap = devm_regmap_init_i2c(client, &bq25790_regmap_config);
> +

Don't add blank line after every statement. All four blank lines above
should be removed.

> +       if (IS_ERR(bq->regmap)) {
> +               dev_err(dev, "Failed to allocate register map\n");
> +               return PTR_ERR(bq->regmap);
> +       }
> +
> +       i2c_set_clientdata(client, bq);
> +
> +       ret = bq25790_parse_dt(bq, &psy_cfg, dev);
> +       if (ret) {
> +               dev_err(dev, "Failed to read device tree properties%d\n", ret);
> +               return ret;
> +       }
> +
> +       ret = devm_add_action_or_reset(dev, bq25790_charger_reset, bq);
> +       if (ret)
> +               return ret;
> +
> +       /* OTG reporting */
> +       bq->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
> +       if (!IS_ERR_OR_NULL(bq->usb2_phy)) {
> +               INIT_WORK(&bq->usb_work, bq25790_usb_work);
> +               bq->usb_nb.notifier_call = bq25790_usb_notifier;
> +               usb_register_notifier(bq->usb2_phy, &bq->usb_nb);

Where is the error checking? Where is cleanup in remove()?

> +       }
> +
> +       bq->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
> +       if (!IS_ERR_OR_NULL(bq->usb3_phy)) {
> +               INIT_WORK(&bq->usb_work, bq25790_usb_work);
> +               bq->usb_nb.notifier_call = bq25790_usb_notifier;
> +               usb_register_notifier(bq->usb3_phy, &bq->usb_nb);

The same.

> +       }
> +
> +       if (client->irq) {
> +               ret = devm_request_threaded_irq(dev, client->irq, NULL,
> +                                               bq25790_irq_handler_thread,
> +                                               IRQF_TRIGGER_FALLING |
> +                                               IRQF_ONESHOT,
> +                                               dev_name(&client->dev), bq);
> +               if (ret < 0) {
> +                       dev_err(dev, "get irq fail: %d\n", ret);
> +                       return ret;
> +               }
> +       }
> +
> +       ret = bq25790_power_supply_init(bq, &psy_cfg, dev);
> +       if (ret) {
> +               dev_err(dev, "Failed to register power supply\n");
> +               return ret;
> +       }
> +
> +       ret = bq25790_hw_init(bq);
> +       if (ret) {
> +               dev_err(dev, "Cannot initialize the chip.\n");
> +               return ret;
> +       }
> +
> +       return ret;
> +}
> +
> +static const struct i2c_device_id bq25790_i2c_ids[] = {
> +       { "bq25790", BQ25790 },
> +       { "bq25792", BQ25792 },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(i2c, bq25790_i2c_ids);
> +
> +static const struct of_device_id bq25790_of_match[] = {
> +       { .compatible = "ti,bq25790", },
> +       { .compatible = "ti,bq25792", },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, bq25790_of_match);
> +
> +static const struct acpi_device_id bq25790_acpi_match[] = {
> +       { "bq25790", BQ25790 },
> +       { "bq25792", BQ25792 },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(acpi, bq25790_acpi_match);
> +
> +static struct i2c_driver bq25790_driver = {
> +       .driver = {
> +               .name = "bq25790-charger",
> +               .of_match_table = bq25790_of_match,
> +               .acpi_match_table = bq25790_acpi_match,
> +       },
> +       .probe = bq25790_probe,

probe_new

Best regards,
Krzysztof
