Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8C324EF31
	for <lists+linux-pm@lfdr.de>; Sun, 23 Aug 2020 20:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHWSQ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Aug 2020 14:16:59 -0400
Received: from mail.v3.sk ([167.172.186.51]:42554 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbgHWSQ6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 23 Aug 2020 14:16:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id EA820DF106;
        Sun, 23 Aug 2020 18:15:56 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qrOO5I--mQz2; Sun, 23 Aug 2020 18:15:56 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2FF88DFA6B;
        Sun, 23 Aug 2020 18:15:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VZOCWdsh4qqG; Sun, 23 Aug 2020 18:15:55 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 8E92ADF106;
        Sun, 23 Aug 2020 18:15:55 +0000 (UTC)
Date:   Sun, 23 Aug 2020 20:16:53 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/6] mfd: Add driver for Embedded Controller found on
 Acer Iconia Tab A500
Message-ID: <20200823181653.GC209852@demiurge.local>
References: <20200823140846.19299-1-digetx@gmail.com>
 <20200823140846.19299-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823140846.19299-2-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

On Sun, Aug 23, 2020 at 05:08:41PM +0300, Dmitry Osipenko wrote:
> Acer Iconia Tab A500 is an Android tablet device, it has ENE KB930
> Embedded Controller which provides battery-gauge, LED, GPIO and some
> other functions. The EC uses firmware that is specifically customized
> for Acer A500. This patch adds MFD driver for the Embedded Controller
> which allows to power-off / reboot the A500 device, it also provides
> a common register read/write API that will be used by the sub-devices.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mfd/Kconfig              |  10 ++
>  drivers/mfd/Makefile             |   1 +
>  drivers/mfd/acer-ec-a500.c       | 196 +++++++++++++++++++++++++++++++
>  include/linux/mfd/acer-ec-a500.h |  80 +++++++++++++
>  4 files changed, 287 insertions(+)
>  create mode 100644 drivers/mfd/acer-ec-a500.c
>  create mode 100644 include/linux/mfd/acer-ec-a500.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 33df0837ab41..9e5cf88a52d8 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2062,6 +2062,16 @@ config MFD_KHADAS_MCU
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
>  
> +config MFD_ACER_A500_EC
> +	tristate "Embedded Controller driver for Acer Iconia Tab A500"
> +	depends on (I2C_TEGRA && ARCH_TEGRA_2x_SOC) || COMPILE_TEST

This seems to also depend on I2C and OF. Perhaps I2C_TEGRA and
ARCH_TEGRA_2x_SOC imply that, but it could lead to build failures with
COMPILE_TEST=y. 

> +	select MFD_CORE
> +	help
> +	  Support for Acer Iconia Tab A500 Embedded Controller.
> +
> +	  The controller itself is ENE KB930, it is running firmware
> +	  customized for the specific needs of the Acer A500 hardware.
> +
>  menu "Multimedia Capabilities Port drivers"
>  	depends on ARCH_SA1100
>  
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index a60e5f835283..6e3a6162ad94 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -262,5 +262,6 @@ obj-$(CONFIG_MFD_ROHM_BD71828)	+= rohm-bd71828.o
>  obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
>  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>  obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
> +obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
>  
>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
> diff --git a/drivers/mfd/acer-ec-a500.c b/drivers/mfd/acer-ec-a500.c
> new file mode 100644
> index 000000000000..f75bb60ab408
> --- /dev/null
> +++ b/drivers/mfd/acer-ec-a500.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * MFD driver for Acer Iconia Tab A500 Embedded Controller.
> + *
> + * Copyright 2020 GRATE-driver project.
> + *
> + * Based on downstream driver from Acer Inc.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/irqflags.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/reboot.h>
> +
> +#include <linux/mfd/acer-ec-a500.h>
> +#include <linux/mfd/core.h>
> +
> +#define A500_EC_I2C_ERR_TIMEOUT		500
> +
> +/*				cmd	delay ms */
> +A500_EC_COMMAND(SHUTDOWN,	0x52,	1000);
> +A500_EC_COMMAND(WARM_REBOOT,	0x54,	1000);
> +A500_EC_COMMAND(COLD_REBOOT,	0x55,	1000);
> +
> +static struct a500_ec *a500_ec_scratch;

If this is only used for power_off, please rename it. I've been told to
do so in my driver: https://lore.kernel.org/lkml/20200519104933.GX271301@dell/

> +
> +static void a500_ec_delay(unsigned int delay_ms)
> +{
> +	/* interrupts could be disabled on shutdown or reboot */
> +	if (irqs_disabled())
> +		mdelay(delay_ms);
> +	else
> +		msleep(delay_ms);
> +}
> +
> +int a500_ec_read_locked(struct a500_ec *ec_chip,
> +			const struct a500_ec_cmd *cmd_desc)

Any reason you're exporting these to the cell drivers instead of using
regmap?

I think regmap would also help you with the locking if you set .lock() and
.unlock() callbacks in regmap_config.

> +{
> +	struct i2c_client *client = ec_chip->client;
> +	unsigned int retries = 5;
> +	s32 ret = 0;
> +
> +	while (retries-- > 0) {
> +		ret = i2c_smbus_read_word_data(client, cmd_desc->cmd);
> +		if (ret >= 0)
> +			break;
> +
> +		a500_ec_delay(A500_EC_I2C_ERR_TIMEOUT);
> +	}
> +
> +	if (ret < 0) {
> +		dev_err(&client->dev, "i2c read command 0x%x failed: %d\n",
> +			cmd_desc->cmd, ret);
> +		return ret;
> +	}
> +
> +	a500_ec_delay(cmd_desc->post_delay);
> +
> +	return le16_to_cpu(ret);
> +}
> +EXPORT_SYMBOL_GPL(a500_ec_read_locked);
> +
> +int a500_ec_write_locked(struct a500_ec *ec_chip,
> +			 const struct a500_ec_cmd *cmd_desc, u16 value)
> +{
> +	struct i2c_client *client = ec_chip->client;
> +	unsigned int retries = 5;
> +	s32 ret = 0;
> +
> +	while (retries-- > 0) {
> +		ret = i2c_smbus_write_word_data(client, cmd_desc->cmd,
> +						le16_to_cpu(value));
> +		if (ret >= 0)
> +			break;
> +
> +		a500_ec_delay(A500_EC_I2C_ERR_TIMEOUT);
> +	}
> +
> +	if (ret < 0) {
> +		dev_err(&client->dev, "i2c write command 0x%x failed: %d\n",
> +			cmd_desc->cmd, ret);
> +		return ret;
> +	}
> +
> +	a500_ec_delay(cmd_desc->post_delay);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(a500_ec_write_locked);
> +
> +static void a500_ec_poweroff(void)
> +{
> +	struct a500_ec *ec_chip = a500_ec_scratch;
> +
> +	a500_ec_write_locked(ec_chip, SHUTDOWN, 0);
> +}
> +
> +static int a500_ec_restart_notify(struct notifier_block *this,
> +				  unsigned long reboot_mode, void *data)
> +{
> +	struct a500_ec *ec_chip = a500_ec_scratch;
> +
> +	if (reboot_mode == REBOOT_WARM)
> +		a500_ec_write_locked(ec_chip, WARM_REBOOT, 0);
> +	else
> +		a500_ec_write_locked(ec_chip, COLD_REBOOT, 1);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block a500_ec_restart_handler = {
> +	.notifier_call = a500_ec_restart_notify,
> +	.priority = 200,

What would happend if you didn't set priority explicitly?

> +};
> +
> +static const struct mfd_cell a500_ec_cells[] = {
> +	{ .name = "acer-a500-iconia-battery", },
> +	{ .name = "acer-a500-iconia-leds", },
> +};
> +
> +static int a500_ec_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct a500_ec *ec_chip;
> +	int err;
> +
> +	ec_chip = devm_kzalloc(&client->dev, sizeof(*ec_chip), GFP_KERNEL);
> +	if (!ec_chip)
> +		return -ENOMEM;
> +
> +	ec_chip->client = client;
> +	mutex_init(&ec_chip->lock);
> +
> +	i2c_set_clientdata(client, ec_chip);
> +
> +	/* register battery and LED sub-devices */
> +	err = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
> +				   a500_ec_cells, ARRAY_SIZE(a500_ec_cells),
> +				   NULL, 0, NULL);
> +	if (err) {
> +		dev_err(&client->dev, "failed to add sub-devices: %d\n", err);
> +		return err;
> +	}
> +
> +	/* set up power management functions */
> +	if (of_device_is_system_power_controller(client->dev.of_node)) {
> +		a500_ec_scratch = ec_chip;
> +
> +		err = register_restart_handler(&a500_ec_restart_handler);
> +		if (err) {
> +			dev_err(&client->dev,
> +				"unable to register restart handler: %d\n",
> +				err);
> +			return err;
> +		}
> +
> +		if (!pm_power_off)
> +			pm_power_off = a500_ec_poweroff;
> +	}
> +
> +	return 0;
> +}
> +
> +static int a500_ec_remove(struct i2c_client *client)
> +{
> +	if (of_device_is_system_power_controller(client->dev.of_node)) {
> +		if (pm_power_off == a500_ec_poweroff)
> +			pm_power_off = NULL;
> +
> +		unregister_restart_handler(&a500_ec_restart_handler);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id a500_ec_match[] = {
> +	{ .compatible = "acer,a500-iconia-ec" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, a500_ec_match);
> +
> +static struct i2c_driver a500_ec_driver = {
> +	.driver = {
> +		.name = "acer-a500-embedded-controller",
> +		.of_match_table = a500_ec_match,
> +	},
> +	.probe = a500_ec_probe,
> +	.remove = a500_ec_remove,
> +};
> +module_i2c_driver(a500_ec_driver);
> +
> +MODULE_DESCRIPTION("Acer Iconia Tab A500 Embedded Controller driver");
> +MODULE_AUTHOR("Dmitry Osipenko <digetx@gmail.com>");
> +MODULE_LICENSE("GPL v2");

MODULE_LICENSE("GPL");

Your SPDX tag suggests newer versions of GPL than v2 are okay.

> diff --git a/include/linux/mfd/acer-ec-a500.h b/include/linux/mfd/acer-ec-a500.h
> new file mode 100644
> index 000000000000..08bc681e6525
> --- /dev/null
> +++ b/include/linux/mfd/acer-ec-a500.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * API for Embedded Controller of Acer Iconia Tab A500.
> + *
> + * Copyright 2020 GRATE-driver project.
> + */
> +
> +#ifndef __LINUX_MFD_ACER_A500_EC_H
> +#define __LINUX_MFD_ACER_A500_EC_H
> +
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +struct a500_ec_cmd {
> +	unsigned int cmd;
> +	unsigned int post_delay;
> +};
> +
> +#define A500_EC_COMMAND(NAME, CMD, DELAY_MS)				\
> +static const struct a500_ec_cmd A500_EC_##NAME = {			\
> +	.cmd = CMD,							\
> +	.post_delay = DELAY_MS,						\
> +};									\

I think that the mfd driver should decide about the delay, not the cell
drivers.

> +static const __maybe_unused struct a500_ec_cmd *NAME = &A500_EC_##NAME
> +
> +struct a500_ec {
> +	struct i2c_client *client;
> +
> +	/*
> +	 * Some EC commands shall be executed sequentially and some commands
> +	 * shall not be executed instantly after the other commands. Hence the
> +	 * locking is needed in order to protect from conflicting accesses to
> +	 * the EC.
> +	 */
> +	struct mutex lock;
> +};
> +
> +int a500_ec_read_locked(struct a500_ec *ec_chip,
> +			const struct a500_ec_cmd *cmd_desc);
> +
> +int a500_ec_write_locked(struct a500_ec *ec_chip,
> +			 const struct a500_ec_cmd *cmd_desc, u16 value);
> +
> +static inline void a500_ec_lock(struct a500_ec *ec_chip)
> +{
> +	mutex_lock(&ec_chip->lock);
> +}
> +
> +static inline void a500_ec_unlock(struct a500_ec *ec_chip)
> +{
> +	mutex_unlock(&ec_chip->lock);
> +}
> +
> +static inline int a500_ec_read(struct a500_ec *ec_chip,
> +			       const struct a500_ec_cmd *cmd_desc)
> +{
> +	s32 ret;
> +
> +	a500_ec_lock(ec_chip);
> +	ret = a500_ec_read_locked(ec_chip, cmd_desc);
> +	a500_ec_unlock(ec_chip);
> +
> +	return ret;
> +}
> +
> +static inline int a500_ec_write(struct a500_ec *ec_chip,
> +				const struct a500_ec_cmd *cmd_desc,
> +				u16 value)
> +{
> +	s32 ret;
> +
> +	a500_ec_lock(ec_chip);
> +	ret = a500_ec_write_locked(ec_chip, cmd_desc, value);
> +	a500_ec_unlock(ec_chip);
> +
> +	return ret;
> +}
> +
> +#endif /* __LINUX_MFD_ACER_A500_EC_H */
> -- 
> 2.27.0
> 

Cheers
Lubo
