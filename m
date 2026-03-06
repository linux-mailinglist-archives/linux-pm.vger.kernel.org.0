Return-Path: <linux-pm+bounces-43763-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AusFoWcqmnPUQEAu9opvQ
	(envelope-from <linux-pm+bounces-43763-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 10:21:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C1F21DCE9
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 10:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C25DB3088638
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 09:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9259433E373;
	Fri,  6 Mar 2026 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nh0jnMzp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA8326B973;
	Fri,  6 Mar 2026 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772788743; cv=none; b=T82VwL+IESiJehj8IHCEbBxS3rSGjjM+aNh/l2pJtiCjLKhjl4T+c9UUnZ3taM4K4cTMKVnJd6tUR8dPWpDLt+kjiSk19+X3NuUR9DQ4CFYbg5W12GJDtv6qKoDkIcla7if/v7I4mrlt4QWE29x4CqF1CevjjKJ28y4zXpYso6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772788743; c=relaxed/simple;
	bh=rcNhgcNUGNZ8uyJh2MXj2JdwKdgCXDdUV5KAxsXXjtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcNcG0crNOLXdG2WkYVNGdcg6zASS7uPD3Mw9uhAczDfKp9B2Q7MjMolzl9lyQYvPLKdrnXmz7NZnOV9gdfMr1U/bez9JZZb5/PWWZTHexjEP028+jURgy9M4i0GUiI22vAJH+RaSoADb+UQ1ovOwijfr+sK2aNS47+s/wwhjEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nh0jnMzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D38DC4CEF7;
	Fri,  6 Mar 2026 09:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772788743;
	bh=rcNhgcNUGNZ8uyJh2MXj2JdwKdgCXDdUV5KAxsXXjtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nh0jnMzpMFDdfrRc6q0bfvR38HeiuyJpOt6sh+rHe+cxv9xBjf2i77F9AzmguAH11
	 tXtlDOGS5qpSSbvn4SQFOld//WW+50t92Uy/DFmLU7cuzGjUH9xisztv0TIQYHfiNo
	 5vYDizno/gBHDnmo02bFndoxp3SbBQLz+gUNITpQyXvw2i5KinCjFVckw2WhLcNGF/
	 yHoWkhoz94hr1VJoTprrVfvCwjbBIjPK9aQHx997STk+tFglvtknRKgIuiVMwZXyLs
	 52/F6OdREfDHbt5IJm2Kgr60QJxQRjibE0Y4VDXzlcVkkWEznCVx/xZuyq6vfMEN0/
	 1l5AyQURgX15g==
Date: Fri, 6 Mar 2026 09:18:56 +0000
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 4/9] mfd: Add driver for Asus Transformer embedded
 controller
Message-ID: <20260306091856.GD183676@google.com>
References: <20260209104407.116426-1-clamor95@gmail.com>
 <20260209104407.116426-5-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260209104407.116426-5-clamor95@gmail.com>
X-Rspamd-Queue-Id: 00C1F21DCE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43763-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arndb.de,linuxfoundation.org,rere.qmqm.pl,agorria.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qmqm.pl:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 09 Feb 2026, Svyatoslav Ryhel wrote:

> From: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> 
> Support Nuvoton NPCE795-based ECs as used in Asus Transformer TF201,
> TF300T, TF300TG, TF300TL and TF700T pad and dock, as well as TF101 dock
> and TF600T, P1801-T and TF701T pad. This is a glue driver handling
> detection and common operations for EC's functions.
> 
> Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/mfd/Kconfig         |  15 ++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/asus-ec.c       | 467 ++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/asus-ec.h | 138 +++++++++++
>  4 files changed, 621 insertions(+)
>  create mode 100644 drivers/mfd/asus-ec.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 7192c9d1d268..312fd15eec6a 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -137,6 +137,21 @@ config MFD_AAT2870_CORE
>  	  additional drivers must be enabled in order to use the
>  	  functionality of the device.
>  
> +config MFD_ASUSEC

MFD_ASUS_EC

> +	tristate "ASUS Transformer's embedded controller"
> +	depends on I2C && OF
> +	select SYSFS
> +	select ASUS_DOCKRAM
> +	help
> +	  Support ECs found in ASUS Transformer's Pad and Mobile Dock.
> +
> +	  This provides shared glue for functional part drivers:
> +	    asus-ec-kbc, asus-ec-keys, leds-asus-ec, asus-ec-battery
> +	    and asus-ec-charger.

Why the additional tabbing?  What example did you take that from?

> +	  This driver can also be built as a module. If so, the module
> +	  will be called asus-ec.
> +
>  config MFD_AT91_USART
>  	tristate "AT91 USART Driver"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index e75e8045c28a..b676922601ba 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
>  obj-$(CONFIG_MFD_88PM886_PMIC)	+= 88pm886.o
>  obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
>  obj-$(CONFIG_MFD_SM501)		+= sm501.o
> +obj-$(CONFIG_MFD_ASUSEC)	+= asus-ec.o
>  obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
>  obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
>  obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
> diff --git a/drivers/mfd/asus-ec.c b/drivers/mfd/asus-ec.c
> new file mode 100644
> index 000000000000..e151c1506aa2
> --- /dev/null
> +++ b/drivers/mfd/asus-ec.c
> @@ -0,0 +1,467 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * ASUS EC driver

Copyright?  Author?

> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/asus-ec.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>

Alphabetical.

Are you sure all of these are in use?

> +#define ASUSEC_RSP_BUFFER_SIZE		8
> +
> +struct asus_ec_chip_data {
> +	const char *name;
> +	const struct mfd_cell *mfd_devices;
> +	unsigned int num_devices;
> +};
> +
> +struct asus_ec_data {
> +	struct asusec_info info;
> +	struct mutex ecreq_lock; /* prevent simultaneous access */

We know what mutexes do.

If you're going to provide a comment, state WHAT is is protecting.

Or just omit the comment altogether.

> +	struct gpio_desc *ecreq;
> +	struct i2c_client *self;

"client"

Why are you storing this?

> +	const struct asus_ec_chip_data *data;
> +	u8 ec_data[DOCKRAM_ENTRY_BUFSIZE];
> +	bool clr_fmode;
> +	bool logging_disabled;
> +};
> +
> +#define to_ec_data(ec) \
> +	container_of(ec, struct asus_ec_data, info)
> +
> +static void asus_ec_remove_notifier(struct device *dev, void *res)
> +{
> +	struct asusec_info *ec = dev_get_drvdata(dev->parent);
> +	struct notifier_block **nb = res;
> +
> +	blocking_notifier_chain_unregister(&ec->notify_list, *nb);
> +}
> +
> +/**
> + * devm_asus_ec_register_notifier - Managed registration of notifier to an
> + *				    ASUS EC blocking notifier chain.
> + * @pdev: Device requesting the notifier (used for resource management).
> + * @nb: Notifier block to be registered.
> + *
> + * Register a notifier to the ASUS EC blocking notifier chain. The notifier
> + * will be automatically unregistered when the requesting device is detached.
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int devm_asus_ec_register_notifier(struct platform_device *pdev,
> +				   struct notifier_block *nb)
> +{
> +	struct asusec_info *ec = dev_get_drvdata(pdev->dev.parent);
> +	struct notifier_block **res;
> +	int ret;
> +
> +	res = devres_alloc(asus_ec_remove_notifier, sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	*res = nb;
> +	ret = blocking_notifier_chain_register(&ec->notify_list, nb);
> +	if (ret) {
> +		devres_free(res);
> +		return ret;
> +	}
> +
> +	devres_add(&pdev->dev, res);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_asus_ec_register_notifier);
> +
> +static int asus_ec_signal_request(const struct asusec_info *ec)
> +{
> +	struct asus_ec_data *priv = to_ec_data(ec);
> +
> +	guard(mutex)(&priv->ecreq_lock);
> +
> +	dev_dbg(&priv->self->dev, "EC request\n");
> +
> +	gpiod_set_value_cansleep(priv->ecreq, 1);
> +	msleep(50);
> +
> +	gpiod_set_value_cansleep(priv->ecreq, 0);
> +	msleep(200);
> +
> +	return 0;
> +}
> +
> +static int asus_ec_write(struct asus_ec_data *priv, u16 data)
> +{
> +	int ret = i2c_smbus_write_word_data(priv->self, ASUSEC_WRITE_BUF, data);
> +
> +	dev_dbg(&priv->self->dev, "EC write: %04x, ret = %d\n", data, ret);
> +	return ret;
> +}
> +
> +static int asus_ec_read(struct asus_ec_data *priv, bool in_irq)
> +{
> +	int ret = i2c_smbus_read_i2c_block_data(priv->self, ASUSEC_READ_BUF,
> +						sizeof(priv->ec_data),
> +						priv->ec_data);
> +
> +	dev_dbg(&priv->self->dev, "EC read: %*ph, ret = %d%s\n",
> +		sizeof(priv->ec_data), priv->ec_data,
> +		ret, in_irq ? "; in irq" : "");
> +
> +	return ret;
> +}

Remove both of these functions and use the i2c_smbus_*() API instead.

> +
> +/**
> + * asus_ec_i2c_command - Send a 16-bit command to the ASUS EC.
> + * @ec: Pointer to the shared ASUS EC structure.
> + * @data: The 16-bit command (word) to be sent.
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int asus_ec_i2c_command(const struct asusec_info *ec, u16 data)
> +{
> +	return asus_ec_write(to_ec_data(ec), data);
> +}
> +EXPORT_SYMBOL_GPL(asus_ec_i2c_command);

Why is this needed?  Why not share 'client' with the leave drivers and
let them make their own calls to i2c_smbus_write_word_data()?

> +static void asus_ec_clear_buffer(struct asus_ec_data *priv)
> +{
> +	int retry = ASUSEC_RSP_BUFFER_SIZE;
> +
> +	while (retry--) {

Why is the amount of retries related to the buffer size?

> +		if (asus_ec_read(priv, false) < 0)
> +			continue;
> +
> +		if (priv->ec_data[1] & ASUSEC_OBF_MASK)

No magic numbers.  Define the 1.

> +			continue;
> +
> +		break;
> +	}
> +}
> +
> +static int asus_ec_log_info(struct asus_ec_data *priv, unsigned int reg,
> +			    const char *name, char **out)
> +{
> +	char buf[DOCKRAM_ENTRY_BUFSIZE];
> +	int ret;
> +
> +	ret = asus_dockram_read(priv->info.dockram, reg, buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!priv->logging_disabled)
> +		dev_info(&priv->self->dev, "%-14s: %.*s\n", name, buf[0], buf + 1);
> +
> +	if (out)
> +		*out = kstrndup(buf + 1, buf[0], GFP_KERNEL);
> +
> +	return 0;
> +}

The driver is written now.  You can remove this over-engineered debugging
facility.

> +static int asus_ec_reset(struct asus_ec_data *priv)
> +{
> +	int retry, ret;
> +
> +	for (retry = 0; retry < 3; retry++) {

Why 3?

Why are you using for() here and while() above?

> +		ret = asus_ec_write(priv, 0);

Add a comment to explain how this works.

Or, better still, define the value.

> +		if (!ret)
> +			return 0;
> +
> +		msleep(300);

Why 300?

> +	}
> +
> +	return ret;
> +}
> +
> +static int asus_ec_magic_debug(struct asus_ec_data *priv)

What does this do?  More comments throughout please.

> +{
> +	u64 flag;
> +	int ret;
> +
> +	ret = asus_ec_get_ctl(&priv->info, &flag);
> +	if (ret < 0)
> +		return ret;
> +
> +	flag &= ASUSEC_CTL_SUSB_MODE;
> +	dev_info(&priv->self->dev, "EC FW behaviour: %s\n",
> +		 flag ? "susb on when receive ec_req" : "susb on when system wakeup");
> +
> +	return 0;
> +}
> +
> +static int asus_ec_set_factory_mode(struct asus_ec_data *priv, bool on)
> +{
> +	dev_info(&priv->self->dev, "Entering %s mode.\n", on ? "factory" : "normal");

Remove all of the debugging prints now.

> +	return asus_ec_update_ctl(&priv->info, ASUSEC_CTL_FACTORY_MODE,
> +				  on ? ASUSEC_CTL_FACTORY_MODE : 0);
> +}
> +
> +static void asus_ec_handle_smi(struct asus_ec_data *priv, unsigned int code);

No forward declarations.

> +static irqreturn_t asus_ec_interrupt(int irq, void *dev_id)
> +{
> +	struct asus_ec_data *priv = dev_id;
> +	unsigned long notify_action;
> +	int ret;
> +
> +	ret = asus_ec_read(priv, true);
> +	if (ret <= 0 || !(priv->ec_data[1] & ASUSEC_OBF_MASK))
> +		return IRQ_NONE;
> +
> +	notify_action = priv->ec_data[1];
> +	if (notify_action & ASUSEC_SMI_MASK) {
> +		unsigned int code = priv->ec_data[2];
> +
> +		asus_ec_handle_smi(priv, code);
> +
> +		notify_action |= code << 8;
> +		dev_dbg(&priv->self->dev, "SMI code: 0x%02x\n", code);
> +	}
> +
> +	blocking_notifier_call_chain(&priv->info.notify_list,
> +				     notify_action, priv->ec_data);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int asus_ec_detect(struct asus_ec_data *priv)
> +{
> +	char *model = NULL;
> +	int ret;
> +
> +	ret = asus_ec_reset(priv);
> +	if (ret)
> +		goto err_exit;
> +
> +	asus_ec_clear_buffer(priv);
> +
> +	ret = asus_ec_log_info(priv, ASUSEC_DOCKRAM_INFO_MODEL, "model", &model);
> +	if (ret)
> +		goto err_exit;
> +
> +	ret = asus_ec_log_info(priv, ASUSEC_DOCKRAM_INFO_FW, "FW version", NULL);
> +	if (ret)
> +		goto err_exit;
> +
> +	ret = asus_ec_log_info(priv, ASUSEC_DOCKRAM_INFO_CFGFMT, "Config format", NULL);
> +	if (ret)
> +		goto err_exit;
> +
> +	ret = asus_ec_log_info(priv, ASUSEC_DOCKRAM_INFO_HW, "HW version", NULL);
> +	if (ret)
> +		goto err_exit;
> +
> +	priv->logging_disabled = true;
> +
> +	ret = asus_ec_magic_debug(priv);
> +	if (ret)
> +		goto err_exit;
> +
> +	priv->info.model = model;
> +	priv->info.name = priv->data->name;
> +
> +	if (priv->clr_fmode)
> +		asus_ec_set_factory_mode(priv, false);
> +
> +err_exit:
> +	if (ret)
> +		dev_err(&priv->self->dev, "failed to access EC: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void asus_ec_handle_smi(struct asus_ec_data *priv, unsigned int code)
> +{
> +	dev_dbg(&priv->self->dev, "SMI interrupt: 0x%02x\n", code);
> +
> +	switch (code) {
> +	case ASUSEC_SMI_HANDSHAKE:
> +	case ASUSEC_SMI_RESET:
> +		asus_ec_detect(priv);
> +		break;
> +	}
> +}
> +
> +static int ec_request_set(void *ec, u64 val)
> +{
> +	if (val)
> +		asus_ec_signal_request(ec);
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(ec_request_fops, NULL, ec_request_set, "%llu\n");
> +
> +static int ec_irq_set(void *ec, u64 val)
> +{
> +	struct asus_ec_data *priv = to_ec_data(ec);
> +
> +	if (val)
> +		irq_wake_thread(priv->self->irq, priv);
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(ec_irq_fops, NULL, ec_irq_set, "%llu\n");

Document these.

> +static void asus_ec_debugfs_remove(void *debugfs_root)
> +{
> +	debugfs_remove_recursive(debugfs_root);
> +}
> +
> +static void devm_asus_ec_debugfs_init(struct device *dev)
> +{
> +	struct asusec_info *ec = dev_get_drvdata(dev);
> +	struct asus_ec_data *priv = to_ec_data(ec);
> +	struct dentry *debugfs_root;
> +	char *name = devm_kasprintf(dev, GFP_KERNEL, "asus-ec-%s",
> +				    priv->data->name);
> +
> +	debugfs_root = debugfs_create_dir(name, NULL);
> +
> +	debugfs_create_file("ec_irq", 0200, debugfs_root, ec, &ec_irq_fops);
> +	debugfs_create_file("ec_request", 0200, debugfs_root, ec, &ec_request_fops);
> +
> +	asus_dockram_debugfs_init(priv->info.dockram, debugfs_root);
> +
> +	devm_add_action_or_reset(dev, asus_ec_debugfs_remove, debugfs_root);
> +}
> +
> +static int asus_ec_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct asus_ec_data *priv;

Call this "ddata".

> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->data = device_get_match_data(dev);
> +	if (!priv->data)
> +		return -ENODEV;
> +
> +	i2c_set_clientdata(client, priv);
> +	priv->self = client;
> +
> +	priv->info.dockram = devm_asus_dockram_get(dev);
> +	if (IS_ERR(priv->info.dockram))
> +		return dev_err_probe(dev, PTR_ERR(priv->info.dockram),
> +				     "failed to get dockram\n");
> +
> +	priv->ecreq = devm_gpiod_get(dev, "request", GPIOD_OUT_LOW);
> +	if (IS_ERR(priv->ecreq))
> +		return dev_err_probe(dev, PTR_ERR(priv->ecreq),
> +				     "failed to get request GPIO\n");
> +
> +	BLOCKING_INIT_NOTIFIER_HEAD(&priv->info.notify_list);
> +	mutex_init(&priv->ecreq_lock);
> +
> +	priv->clr_fmode = device_property_read_bool(dev, "asus,clear-factory-mode");
> +
> +	asus_ec_signal_request(&priv->info);
> +
> +	ret = asus_ec_detect(priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to detect EC version\n");
> +
> +	ret = devm_request_threaded_irq(dev, client->irq, NULL,
> +					&asus_ec_interrupt,
> +					IRQF_ONESHOT | IRQF_SHARED,
> +					client->name, priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register IRQ\n");
> +
> +	/* Parent I2C controller uses DMA, ASUS EC and child devices do not */
> +	client->dev.coherent_dma_mask = 0;
> +	client->dev.dma_mask = &client->dev.coherent_dma_mask;
> +
> +	devm_asus_ec_debugfs_init(dev);
> +
> +	return devm_mfd_add_devices(dev, 0, priv->data->mfd_devices,
> +				    priv->data->num_devices, NULL, 0, NULL);
> +}
> +
> +static const struct mfd_cell asus_ec_pad_mfd_devices[] = {
> +	{
> +		.name = "asus-ec-battery",
> +		.id = 0,
> +		.of_compatible = "asus,ec-battery",
> +	}, {
> +		.name = "asus-ec-charger",
> +		.id = 0,
> +		.of_compatible = "asus,ec-charger",
> +	}, {
> +		.name = "asus-ec-led",
> +		.id = 0,
> +		.of_compatible = "asus,ec-led",
> +	},
> +};
> +
> +static const struct mfd_cell asus_ec_dock_mfd_devices[] = {
> +	{
> +		.name = "asus-ec-battery",
> +		.id = 1,
> +		.of_compatible = "asus,ec-battery",
> +	}, {
> +		.name = "asus-ec-charger",
> +		.id = 1,
> +		.of_compatible = "asus,ec-charger",
> +	}, {
> +		.name = "asus-ec-led",
> +		.id = 1,
> +		.of_compatible = "asus,ec-led",
> +	}, {
> +		.name = "asus-ec-keys",
> +		.of_compatible = "asus,ec-keys",
> +	}, {
> +		.name = "asus-ec-kbc",
> +		.of_compatible = "asus,ec-kbc",
> +	},
> +};
> +
> +static const struct asus_ec_chip_data asus_ec_pad_data = {
> +	.name = "pad",
> +	.mfd_devices = asus_ec_pad_mfd_devices,
> +	.num_devices = ARRAY_SIZE(asus_ec_pad_mfd_devices),
> +};
> +
> +static const struct asus_ec_chip_data asus_ec_dock_data = {
> +	.name = "dock",
> +	.mfd_devices = asus_ec_dock_mfd_devices,
> +	.num_devices = ARRAY_SIZE(asus_ec_dock_mfd_devices),
> +};
> +
> +static const struct of_device_id asus_ec_match[] = {
> +	{ .compatible = "asus,ec-pad", .data = &asus_ec_pad_data },

Passing MFD data through a different registration mechanism is not
allowed.  Use identifiers to match in instead.

git grep "\.data =.*void" -- drivers/mfd

> +	{ .compatible = "asus,ec-dock", .data = &asus_ec_dock_data },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, asus_ec_match);
> +
> +static struct i2c_driver asus_ec_driver = {
> +	.driver	= {
> +		.name = "asus-ec",
> +		.of_match_table = asus_ec_match,
> +	},
> +	.probe = asus_ec_probe,
> +};
> +module_i2c_driver(asus_ec_driver);
> +
> +MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
> +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> +MODULE_DESCRIPTION("ASUS Transformer's EC driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/asus-ec.h b/include/linux/mfd/asus-ec.h
> index 6a36313b9ebd..6a06b125ba30 100644
> --- a/include/linux/mfd/asus-ec.h
> +++ b/include/linux/mfd/asus-ec.h
> @@ -2,16 +2,78 @@
>  #ifndef __MISC_ASUS_EC_H
>  #define __MISC_ASUS_EC_H
>  
> +#include <linux/notifier.h>
> +#include <linux/platform_device.h>
> +#include <linux/workqueue.h>
> +
>  struct i2c_client;
>  
> +struct asusec_info {
> +	const char *model;
> +	const char *name;
> +	struct i2c_client *dockram;
> +	struct workqueue_struct *wq;
> +	struct blocking_notifier_head notify_list;
> +};
> +
>  #define DOCKRAM_ENTRIES			0x100
>  #define DOCKRAM_ENTRY_SIZE		32
>  #define DOCKRAM_ENTRY_BUFSIZE		(DOCKRAM_ENTRY_SIZE + 1)
>  
> +/* interrupt sources */
> +#define ASUSEC_OBF_MASK			BIT(0)
> +#define ASUSEC_KEY_MASK			BIT(2)
> +#define ASUSEC_KBC_MASK			BIT(3)
> +#define ASUSEC_AUX_MASK			BIT(5)
> +#define ASUSEC_SCI_MASK			BIT(6)
> +#define ASUSEC_SMI_MASK			BIT(7)
> +
> +/* SMI notification codes */
> +#define ASUSEC_SMI_POWER_NOTIFY		0x31	/* [un]plugging USB cable */
> +#define ASUSEC_SMI_HANDSHAKE		0x50	/* response to ec_req edge */
> +#define ASUSEC_SMI_WAKE			0x53
> +#define ASUSEC_SMI_RESET		0x5f
> +#define ASUSEC_SMI_ADAPTER_EVENT	0x60	/* [un]plugging charger to dock */
> +#define ASUSEC_SMI_BACKLIGHT_ON		0x63
> +#define ASUSEC_SMI_AUDIO_DOCK_IN	0x70
> +
> +#define ASUSEC_SMI_ACTION(code)		(ASUSEC_SMI_MASK | ASUSEC_OBF_MASK | \
> +					(ASUSEC_SMI_##code << 8))
> +
>  /* control register [0x0A] layout */
>  #define ASUSEC_CTL_SIZE			8
>  
> +/*
> + * EC reports power from 40-pin connector in the LSB of the control
> + * register.  The following values have been observed (xor 0x02):
> + *
> + * PAD-ec no-plug  0x40 / PAD-ec DOCK     0x20 / DOCK-ec no-plug 0x40
> + * PAD-ec AC       0x25 / PAD-ec DOCK+AC  0x24 / DOCK-ec AC      0x25
> + * PAD-ec USB      0x45 / PAD-ec DOCK+USB 0x24 / DOCK-ec USB     0x41
> + */
> +
> +#define ASUSEC_CTL_DIRECT_POWER_SOURCE	BIT_ULL(0)
> +#define ASUSEC_STAT_CHARGING		BIT_ULL(2)
> +#define ASUSEC_CTL_FULL_POWER_SOURCE	BIT_ULL(5)
> +#define ASUSEC_CTL_SUSB_MODE		BIT_ULL(11)
> +#define ASUSEC_CMD_SUSPEND_S3		BIT_ULL(41)
> +#define ASUSEC_CTL_TEST_DISCHARGE	BIT_ULL(43)
> +#define ASUSEC_CMD_SUSPEND_INHIBIT	BIT_ULL(45)
> +#define ASUSEC_CTL_FACTORY_MODE		BIT_ULL(46)
> +#define ASUSEC_CTL_KEEP_AWAKE		BIT_ULL(47)
> +#define ASUSEC_CTL_USB_CHARGE		BIT_ULL(50)
> +#define ASUSEC_CMD_SWITCH_HDMI		BIT_ULL(70)
> +#define ASUSEC_CMD_WIN_SHUTDOWN		BIT_ULL(76)
> +
> +#define ASUSEC_DOCKRAM_INFO_MODEL	0x01
> +#define ASUSEC_DOCKRAM_INFO_FW		0x02
> +#define ASUSEC_DOCKRAM_INFO_CFGFMT	0x03
> +#define ASUSEC_DOCKRAM_INFO_HW		0x04
>  #define ASUSEC_DOCKRAM_CONTROL		0x0a
> +#define ASUSEC_DOCKRAM_BATT_CTL		0x14
> +
> +#define ASUSEC_WRITE_BUF		0x64
> +#define ASUSEC_READ_BUF			0x6A
>  
>  /* dockram comm */
>  int asus_dockram_read(struct i2c_client *client, int reg, char *buf);
> @@ -21,4 +83,80 @@ int asus_dockram_access_ctl(struct i2c_client *client,
>  struct i2c_client *devm_asus_dockram_get(struct device *parent);
>  void asus_dockram_debugfs_init(struct i2c_client *client,
>  			       struct dentry *debugfs_root);
> +
> +/* EC public API */
> +
> +/**
> + * cell_to_ec - Request the shared ASUS EC structure via a subdevice's pdev.
> + * @pdev: EC subdevice pdev requesting access to the shared ASUS EC structure.
> + *
> + * Returns a pointer to the asusec_info structure.
> + */
> +static inline struct asusec_info *cell_to_ec(struct platform_device *pdev)
> +{
> +	return dev_get_drvdata(pdev->dev.parent);
> +}
> +
> +/**
> + * asus_ec_get_ctl - Read from the DockRAM control register.
> + * @ec:  Pointer to the shared ASUS EC structure.
> + * @out: Pointer to the variable where the register value will be stored.
> + *
> + * Performs a control register read and stores the value in @out.
> + *
> + * Return: 0 on success, or a negative errno code on failure.
> + */
> +static inline int asus_ec_get_ctl(const struct asusec_info *ec, u64 *out)
> +{
> +	return asus_dockram_access_ctl(ec->dockram, out, 0, 0);
> +}
> +
> +/**
> + * asus_ec_update_ctl - Update the DockRAM control register.
> + * @ec:   Pointer to the shared ASUS EC structure.
> + * @mask: Bitmask of bits to be cleared.
> + * @xor:  Bitmask of bits to be toggled or set (via XOR).
> + *
> + * Performs a read-modify-write update on the control register using
> + * the provided @mask and @xor values.
> + *
> + * Return: 0 on success, or a negative errno code on failure.
> + */
> +static inline int asus_ec_update_ctl(const struct asusec_info *ec,
> +				     u64 mask, u64 xor)
> +{
> +	return asus_dockram_access_ctl(ec->dockram, NULL, mask, xor);
> +}
> +
> +/**
> + * asus_ec_set_ctl_bits - Sets bits of the DockRAM control register.
> + * @ec:   Pointer to the shared ASUS EC structure.
> + * @mask: Bitmask of bits to be set.
> + *
> + * Sets bits of the control register using the provided @mask value.
> + *
> + * Return: 0 on success, or a negative errno code on failure.
> + */
> +static inline int asus_ec_set_ctl_bits(const struct asusec_info *ec, u64 mask)
> +{
> +	return asus_dockram_access_ctl(ec->dockram, NULL, mask, mask);
> +}
> +
> +/**
> + * asus_ec_clear_ctl_bits - Clears bits of the DockRAM control register.
> + * @ec:   Pointer to the shared ASUS EC structure.
> + * @mask: Bitmask of bits to be cleared.
> + *
> + * Clears bits of the control register using the provided @mask value.
> + *
> + * Return: 0 on success, or a negative errno code on failure.
> + */
> +static inline int asus_ec_clear_ctl_bits(const struct asusec_info *ec, u64 mask)
> +{
> +	return asus_dockram_access_ctl(ec->dockram, NULL, mask, 0);
> +}

This is all abstraction for he sake of abstraction.

> +int asus_ec_i2c_command(const struct asusec_info *ec, u16 data);
> +int devm_asus_ec_register_notifier(struct platform_device *dev,
> +				   struct notifier_block *nb);
>  #endif /* __MISC_ASUS_EC_H */
> -- 
> 2.51.0
> 
> 

-- 
Lee Jones [李琼斯]

