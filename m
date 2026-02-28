Return-Path: <linux-pm+bounces-43367-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KYRGClMo2nW/AQAu9opvQ
	(envelope-from <linux-pm+bounces-43367-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 21:12:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D530F1C8031
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 21:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B5DD355D33B
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 20:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DBB346E51;
	Sat, 28 Feb 2026 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYFZGdI2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3FF33F8C1;
	Sat, 28 Feb 2026 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772307602; cv=none; b=pB+lTuE+UjCct+HOi+4r6U29B/xSMEbxaA2JsUHx1nHEVt1kLFJbXc/azPDc7a8ros1QW6PFZiq8Q/4UcshJ7eM6QNg2mblpbT/bXIcPjz1J5taIF2gxSWurBvZNGJQvkOP+CHy10kwN7exGJlxgXVVqzbjoPFH6Wyi4cWsvpFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772307602; c=relaxed/simple;
	bh=OtRFMwKep69LR2roEtmTAXzyYpMvht6Ur8migbV5+1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPoNcVIbZOxTFClNKLCT/Mld6lLYoKwFSML+GLwXHAbeveOeCMRvkRqosnawV+zYXJG+WgNtapbc2MbXdY0BaKbVJFFiy/2LAepUnU9uZBNgLM2k1J9tpwehV2u3B8xHM25EKFb2jCVESg8APPE6tEPJ5mwEW/V6v72keYxFTus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYFZGdI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E47DC19423;
	Sat, 28 Feb 2026 19:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772307601;
	bh=OtRFMwKep69LR2roEtmTAXzyYpMvht6Ur8migbV5+1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eYFZGdI2X0sYjHaBxJ0rga6syqzXF/kwWdRXVqd0UsIN9OA0K4TwaPrLUmWBSzBwe
	 W1hA5MoaWmMP3JvDSBpTgXmJgSe+qGTAFLb01QjfSm9jym/02GIE5ius7KWk51WLMu
	 zEsV7LDdYIlc7GSM4dlSt9AGmNsICgKgx0kzvrpsJpdHlVOUo2pmqgAr8+wvEJdAgk
	 iGihz2+prjXB8uIdKQll0AJcPxnWndkV8z+MMdWX7IKRR2uWU5MYCa/jekrSa/4W1/
	 KCpb6HnJ2UbRK95GDbBLw2vKC8CB6466nuc0NOJVhD+niE1mL4Cd8OjF6ONc+OpFvy
	 Px3793Rzn9gXA==
Date: Sat, 28 Feb 2026 19:39:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
 dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
 daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
 thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
 subbaraman.narayanamurthy@oss.qualcomm.com, david.collins@oss.qualcomm.com,
 anjelique.melendez@oss.qualcomm.com, kamal.wadhwa@oss.qualcomm.com,
 rui.zhang@intel.com, lukasz.luba@arm.com, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
 neil.armstrong@linaro.org, stephan.gerhold@linaro.org
Subject: Re: [PATCH V11 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Message-ID: <20260228193946.2e60ea5e@jic23-huawei>
In-Reply-To: <20260209105438.596339-4-jishnu.prakash@oss.qualcomm.com>
References: <20260209105438.596339-1-jishnu.prakash@oss.qualcomm.com>
	<20260209105438.596339-4-jishnu.prakash@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43367-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,linaro.org,gmail.com,intel.com,arm.com,vger.kernel.org,chromium.org,quicinc.com];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: D530F1C8031
X-Rspamd-Action: no action

On Mon,  9 Feb 2026 16:24:37 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
> with all SW communication to ADC going through PMK8550 which
> communicates with other PMICs through PBS.
> 
> One major difference is that the register interface used here is that
> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
> There may be more than one SDAM used for ADC5 Gen3 and each has eight
> channels, which may be used for either immediate reads (same functionality
> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
> (same as ADC_TM functionality).
> 
> By convention, we reserve the first channel of the first SDAM for all
> immediate reads and use the remaining channels across all SDAMs for
> ADC_TM monitoring functionality.
> 
> Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
> ADC_TM is implemented as an auxiliary thermal driver under this ADC
> driver.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Ah. I just realized I built the immutable branch from v10 not this.
I wasn't seeing any review outstanding on that version and didn't read your
email closely enough :(

I'd rather not cause more confusion by ripping it down and creating a new
one.  From a quick look none of the changes since v10 look vital.
Perhaps we can spin a follow up patch to pull into IIO to make those
tweaks if you want them?  That way the immutable branch remains
the same.

Thanks,

Jonathan


> ---
> Changes since v10:
> - Made following changes to address Jonathan's comments:
>   - Replaced inclusion of device.h header file in 
>     include/linux/iio/adc/qcom-adc5-gen3-common.h with forwards declaration
>     of struct device.
>   - Updated all for() loops to declare and initialize the loop iterator
>     inside the for() loop statement.
>   - Moved initializations for drvdata, completion struct and mutex within
>     adc5_gen3_probe().
> 
> Changes since v8:
> - Dropped the common module (drivers/iio/adc/qcom-adc5-gen3-common.c) and moved
>   all of its contents to drivers/iio/adc/qcom-spmi-adc5-gen3.c as suggested by Dmitry.
> - Made following changes to address Dmitry's comment to use module_auxiliary_driver()
>   in auxiliary driver patch, by simplifying auxiliary device structures:
>   - Added function pointer for TM interrupt handler callback under struct adc5_chip
>     (to be called in case of TM interrupt on first SDAM), to replace the
>     tm_event_notify() callback.
>   - Add new exported function (adc5_gen3_register_tm_event_notifier()) to be called
>     by TM auxiliary driver in its probe to initialize the above callback function.
>   - Updated adc5_gen3_isr() to call this TM callback function instead of
>     tm_event_notify() callback from the wrapper struct adc_tm5_auxiliary_drv.
>   - Completely dropped the above wrapper struct definition.
> - Made following changes to address Jonathan's comments:
>   - Updated header files included in drivers/iio/adc/qcom-spmi-adc5-gen3.c and 
>     include/linux/iio/adc/qcom-adc5-gen3-common.h to follow IWYU (include-what-you-use)
>     principles.
>   - Dropped comment inside adc5_chip struct definition describing mutex lock.
> - Dropped ADC5_GEN3_TEMP_ALARM_LITE channel as it had some inaccuracy issue, which
>   is being debugged internally. Will add it in a separate patch along with channel user.
> - Replaced dev_err() with dev_err_probe() in adc5_get_fw_data.
> 
> Changes since v7:
> - Addressed following comments from Jonathan:
>   - Included regmap header file in drivers/iio/adc/qcom-adc5-gen3-common.c.
>   - Increased comment wrap length in adc5_gen3_configure() and 
>     struct adc5_chip definition.
>   - Updated error checks in adc5_gen3_isr() to remove NULL check for
>     adrv_tm and keep (!adrv_tm->tm_event_notify) error check alone
> 	  within if() condition.
>   - Removed sid initialization in adc5_gen3_get_fw_channel_data()
> - Added definitions for ADC channel macros used in adc5_gen3_chans_pmic[]
>   in include/linux/iio/adc/qcom-adc5-gen3-common.h instead of 
>   include/dt-bindings/iio/adc/qcom,spmi-vadc.h, as this latter file
>   will be moved out of bindings folder in a separate change. Also
>   removed its inclusion in drivers/iio/adc/qcom-spmi-adc5-gen3.c.
> - Cleaned up local variable declarations in adc5_gen3_isr() and
>   adc5_gen3_get_fw_channel_data() and added local variable for
>   adc->dev in adc5_get_fw_data().
> - Fixed error message after platform_get_irq() call in adc5_gen3_probe()
>   to print IRQ number correctly.
> - Added a check in adc5_gen3_get_fw_channel_data() to exit with error
>   if ADC channel value obtained from `reg` channel property is not
>   among the supported ones in the array adc5_gen3_chans_pmic[].
> - Corrected the value used in checking for max valid ADC channel value,
>   in adc5_gen3_get_fw_channel_data().
> 
> Changes since v6:
> - Addressed following comments from Jonathan:
>   - Moved functions exported in drivers/iio/adc/qcom-adc5-gen3-common.c
>     into namespace "QCOM_SPMI_ADC5_GEN3".
>   - Increased line wrap length for comments.
>   - Added local variable for adc->dev in adc5_gen3_isr().
>   - Shifted debug print showing IRQ status registers in adc5_gen3_isr()
>     to before tm_status[] check.
>   - Fixed indentation and brackets in adc5_gen3_get_fw_channel_data().
>   - Cleaned up array formatting in adc5_gen3_data_pmic struct.
>   - Used scoped variant of device_for_each_child_node() in adc5_get_fw_data().
>   - Updated auxiliary device cleanup handling to fix memory freeing
>     issues, by adding empty auxiliary device release function.
>   - Used devm_mutex_init() in adc5_gen3_probe().
>   - Updated virtual channel macro name from V_CHAN to ADC5_GEN3_V_CHAN.
>   - Set IIO device name to "spmi-adc5-gen3".
> - Added __acquires and __releases macros for exported mutex lock
>   and unlock functions in drivers/iio/adc/qcom-spmi-adc5-gen3.c.
> - Added error check to fail probe in case adding auxiliary TM device fails.
> - Replaced 2025 copyright in newly added files with yearless copyright,
>   following new internal guidelines.
> 
> Changes since v5:
> - Addressed following comments from Jonathan:
>   - Corrected line wrap length in Kconfig and driver files.
>   - Replaced usleep_range() with fsleep() in adc5_gen3_poll_wait_hs()
>   - Corrected all files to follow kernel-doc formatting fully.
>   - Removed IIO_CHAN_INFO_RAW case in adc5_gen3_read_raw()
>   - Cleaned up formatting in adc5_gen3_data_pmic struct and in other
>     struct definitions.
>   - Updated adc5_gen3_add_aux_tm_device() to keep errors alone out of line.
>   - Split mutex function exported to ADC_TM driver into separate functions
>     for acquiring and releasing mutex.
>   - Removed num_sdams member from struct adc5_chip.
>   - Fixed dev_err_probe() print in adc5_gen3_probe().
>   - Updated logic for acquiring IRQ numbers to account for removing
>     "interrupt-names" DT property.
> - Included bitfield.h header file in drivers/iio/adc/qcom-adc5-gen3-common.c
>   to fix kernel bot error.
> 
> Changes since v4:
> - Moved out common funtions from newly added .h file into a separate .c
>   file to avoid duplicating them and updated interrupt name, as suggested
>   by Krzysztof. Updated namespace export symbol statement to have a string
>   as second argument to follow framework change.
> 
> Changes since v3:
> - Split out TM functionality into auxiliary driver in separate patch and
>   added required changes in main driver, as suggested by Dmitry.
> - Addressed other reviewer comments in main driver patch. 
> 
> Changes since v1:
> - Removed datashet_name usage and implemented read_label() function
> - In probe, updated channel property in iio_chan_spec from individual
>   channel to virtual channel and set indexed property to 1, due to the
>   above change.
> - Updated order of checks in ISR
> - Removed the driver remove callback and replaced with callbacks in a
>   devm_add_action call in probe.
> - Addressed other comments from reviewers.
> 
>  drivers/iio/adc/Kconfig                       |  26 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 860 ++++++++++++++++++
>  include/linux/iio/adc/qcom-adc5-gen3-common.h | 212 +++++
>  4 files changed, 1099 insertions(+)
>  create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
>  create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 58da8255525e..5300e9236ba8 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1329,6 +1329,32 @@ config QCOM_SPMI_ADC5
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called qcom-spmi-adc5.
>  
> +config QCOM_SPMI_ADC5_GEN3
> +	tristate "Qualcomm Technologies Inc. SPMI PMIC5 GEN3 ADC"
> +	depends on SPMI && THERMAL
> +	select REGMAP_SPMI
> +	select QCOM_VADC_COMMON
> +	select AUXILIARY_BUS
> +	help
> +	  IIO Voltage PMIC5 Gen3 ADC driver for Qualcomm Technologies Inc.
> +
> +	  The driver supports reading multiple channels. The ADC is a 16-bit
> +	  sigma-delta ADC. The hardware supports calibrated results for
> +	  conversion requests and clients include reading phone power supply
> +	  voltage, on board system thermistors connected to the PMIC ADC,
> +	  PMIC die temperature, charger temperature, battery current, USB
> +	  voltage input and voltage signals connected to supported PMIC GPIO
> +	  pins. The hardware supports internal pull-up for thermistors and can
> +	  choose between a 30k, 100k or 400k ohm pull up using the ADC channels.
> +
> +	  In addition, the same driver supports ADC thermal monitoring devices
> +	  too. They appear as thermal zones with multiple trip points. A thermal
> +	  client sets threshold temperature for both warm and cool trips and
> +	  gets updated when a threshold is reached.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called qcom-spmi-adc5-gen3.
> +
>  config RCAR_GYRO_ADC
>  	tristate "Renesas R-Car GyroADC driver"
>  	depends on ARCH_RCAR_GEN2 || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 7cc8f9a12f76..cb1874fd7912 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -113,6 +113,7 @@ obj-$(CONFIG_PAC1934) += pac1934.o
>  obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
>  obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
>  obj-$(CONFIG_QCOM_SPMI_ADC5) += qcom-spmi-adc5.o
> +obj-$(CONFIG_QCOM_SPMI_ADC5_GEN3) += qcom-spmi-adc5-gen3.o
>  obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
>  obj-$(CONFIG_QCOM_SPMI_RRADC) += qcom-spmi-rradc.o
>  obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> new file mode 100644
> index 000000000000..76ea9bde6168
> --- /dev/null
> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> @@ -0,0 +1,860 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/completion.h>
> +#include <linux/container_of.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/device/devres.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +
> +#define ADC5_GEN3_VADC_SDAM			0x0
> +
> +struct adc5_chip;
> +
> +/**
> + * struct adc5_channel_prop - ADC channel structure
> + * @common_props: structure with ADC channel properties (common to TM usage).
> + * @adc_tm: indicates TM type if the channel is used for TM measurements.
> + * @chip: pointer to top-level ADC device structure.
> + */
> +struct adc5_channel_prop {
> +	struct adc5_channel_common_prop common_props;
> +	int adc_tm;
> +	struct adc5_chip *chip;
> +};
> +
> +/**
> + * struct adc5_chip - ADC private structure.
> + * @dev: SPMI ADC5 Gen3 device.
> + * @dev_data: Top-level ADC device data.
> + * @nchannels: number of ADC channels.
> + * @chan_props: array of ADC channel properties.
> + * @iio_chans: array of IIO channels specification.
> + * @complete: ADC result notification after interrupt is received.
> + * @lock: ADC lock for access to the peripheral, to prevent concurrent
> + *	requests from multiple clients.
> + * @data: software configuration data.
> + * @n_tm_channels: number of ADC channels used for TM measurements.
> + * @handler: TM callback to be called for threshold violation interrupt
> + *	on first SDAM.
> + * @tm_aux: pointer to auxiliary TM device.
> + */
> +struct adc5_chip {
> +	struct device *dev;
> +	struct adc5_device_data dev_data;
> +	unsigned int nchannels;
> +	struct adc5_channel_prop *chan_props;
> +	struct iio_chan_spec *iio_chans;
> +	struct completion complete;
> +	struct mutex lock;
> +	const struct adc5_data *data;
> +	unsigned int n_tm_channels;
> +	void (*handler)(struct auxiliary_device *tm_aux);
> +	struct auxiliary_device *tm_aux;
> +};
> +
> +int adc5_gen3_read(struct adc5_device_data *adc, unsigned int sdam_index,
> +		   u16 offset, u8 *data, int len)
> +{
> +	return regmap_bulk_read(adc->regmap,
> +				adc->base[sdam_index].base_addr + offset,
> +				data, len);
> +}
> +EXPORT_SYMBOL_NS_GPL(adc5_gen3_read, "QCOM_SPMI_ADC5_GEN3");
> +
> +int adc5_gen3_write(struct adc5_device_data *adc, unsigned int sdam_index,
> +		    u16 offset, u8 *data, int len)
> +{
> +	return regmap_bulk_write(adc->regmap,
> +				 adc->base[sdam_index].base_addr + offset,
> +				 data, len);
> +}
> +EXPORT_SYMBOL_NS_GPL(adc5_gen3_write, "QCOM_SPMI_ADC5_GEN3");
> +
> +static int adc5_gen3_read_voltage_data(struct adc5_chip *adc, u16 *data)
> +{
> +	u8 rslt[2];
> +	int ret;
> +
> +	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
> +			     ADC5_GEN3_CH_DATA0(0), rslt, sizeof(rslt));
> +	if (ret)
> +		return ret;
> +
> +	*data = get_unaligned_le16(rslt);
> +
> +	if (*data == ADC5_USR_DATA_CHECK) {
> +		dev_err(adc->dev, "Invalid data:%#x\n", *data);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(adc->dev, "voltage raw code:%#x\n", *data);
> +
> +	return 0;
> +}
> +
> +void adc5_gen3_update_dig_param(struct adc5_channel_common_prop *prop, u8 *data)
> +{
> +	/* Update calibration select and decimation ratio select */
> +	*data &= ~(ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK | ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK);
> +	*data |= FIELD_PREP(ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK, prop->cal_method);
> +	*data |= FIELD_PREP(ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK, prop->decimation);
> +}
> +EXPORT_SYMBOL_NS_GPL(adc5_gen3_update_dig_param, "QCOM_SPMI_ADC5_GEN3");
> +
> +#define ADC5_GEN3_READ_CONFIG_REGS 7
> +
> +static int adc5_gen3_configure(struct adc5_chip *adc,
> +			       struct adc5_channel_common_prop *prop)
> +{
> +	u8 buf[ADC5_GEN3_READ_CONFIG_REGS];
> +	u8 conv_req = 0;
> +	int ret;
> +
> +	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM, ADC5_GEN3_SID,
> +			     buf, sizeof(buf));
> +	if (ret)
> +		return ret;
> +
> +	/* Write SID */
> +	buf[0] = FIELD_PREP(ADC5_GEN3_SID_MASK, prop->sid);
> +
> +	/*
> +	 * Use channel 0 by default for immediate conversion and to indicate
> +	 * there is an actual conversion request
> +	 */
> +	buf[1] = ADC5_GEN3_CHAN_CONV_REQ | 0;
> +
> +	buf[2] = ADC5_GEN3_TIME_IMMEDIATE;
> +
> +	/* Digital param selection */
> +	adc5_gen3_update_dig_param(prop, &buf[3]);
> +
> +	/* Update fast average sample value */
> +	buf[4] = FIELD_PREP(ADC5_GEN3_FAST_AVG_CTL_SAMPLES_MASK,
> +			    prop->avg_samples) | ADC5_GEN3_FAST_AVG_CTL_EN;
> +
> +	/* Select ADC channel */
> +	buf[5] = prop->channel;
> +
> +	/* Select HW settle delay for channel */
> +	buf[6] = FIELD_PREP(ADC5_GEN3_HW_SETTLE_DELAY_MASK,
> +			    prop->hw_settle_time_us);
> +
> +	reinit_completion(&adc->complete);
> +
> +	ret = adc5_gen3_write(&adc->dev_data, ADC5_GEN3_VADC_SDAM, ADC5_GEN3_SID,
> +			      buf, sizeof(buf));
> +	if (ret)
> +		return ret;
> +
> +	conv_req = ADC5_GEN3_CONV_REQ_REQ;
> +	return adc5_gen3_write(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
> +			       ADC5_GEN3_CONV_REQ, &conv_req, sizeof(conv_req));
> +}
> +
> +/*
> + * Worst case delay from PBS in readying handshake bit  can be up to 15ms, when
> + * PBS is busy running other simultaneous transactions, while in the best case,
> + * it is already ready at this point. Assigning polling delay and retry count
> + * accordingly.
> + */
> +
> +#define ADC5_GEN3_HS_DELAY_US			100
> +#define ADC5_GEN3_HS_RETRY_COUNT		150
> +
> +int adc5_gen3_poll_wait_hs(struct adc5_device_data *adc,
> +			   unsigned int sdam_index)
> +{
> +	u8 conv_req = ADC5_GEN3_CONV_REQ_REQ;
> +	int ret;
> +	u8 status = 0;
> +
> +	for (int count = 0; count < ADC5_GEN3_HS_RETRY_COUNT; count++) {
> +		ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_HS, &status, sizeof(status));
> +		if (ret)
> +			return ret;
> +
> +		if (status == ADC5_GEN3_HS_READY) {
> +			ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_CONV_REQ,
> +					     &conv_req, sizeof(conv_req));
> +			if (ret)
> +				return ret;
> +
> +			if (!conv_req)
> +				return 0;
> +		}
> +
> +		fsleep(ADC5_GEN3_HS_DELAY_US);
> +	}
> +
> +	pr_err("Setting HS ready bit timed out, sdam_index:%d, status:%#x\n",
> +	       sdam_index, status);
> +	return -ETIMEDOUT;
> +}
> +EXPORT_SYMBOL_NS_GPL(adc5_gen3_poll_wait_hs, "QCOM_SPMI_ADC5_GEN3");
> +
> +int adc5_gen3_status_clear(struct adc5_device_data *adc,
> +			   int sdam_index, u16 offset, u8 *val, int len)
> +{
> +	u8 value;
> +	int ret;
> +
> +	ret = adc5_gen3_write(adc, sdam_index, offset, val, len);
> +	if (ret)
> +		return ret;
> +
> +	/* To indicate conversion request is only to clear a status */
> +	value = 0;
> +	ret = adc5_gen3_write(adc, sdam_index, ADC5_GEN3_PERPH_CH, &value,
> +			      sizeof(value));
> +	if (ret)
> +		return ret;
> +
> +	value = ADC5_GEN3_CONV_REQ_REQ;
> +	return adc5_gen3_write(adc, sdam_index, ADC5_GEN3_CONV_REQ, &value,
> +			      sizeof(value));
> +}
> +EXPORT_SYMBOL_NS_GPL(adc5_gen3_status_clear, "QCOM_SPMI_ADC5_GEN3");
> +
> +/*
> + * Worst case delay from PBS for conversion time can be up to 500ms, when PBS
> + * has timed out twice, once for the initial attempt and once for a retry of
> + * the same transaction.
> + */
> +
> +#define ADC5_GEN3_CONV_TIMEOUT_MS	501
> +
> +static int adc5_gen3_do_conversion(struct adc5_chip *adc,
> +				   struct adc5_channel_common_prop *prop,
> +				   u16 *data_volt)
> +{
> +	unsigned long rc;
> +	int ret;
> +	u8 val;
> +
> +	guard(mutex)(&adc->lock);
> +	ret = adc5_gen3_poll_wait_hs(&adc->dev_data, ADC5_GEN3_VADC_SDAM);
> +	if (ret)
> +		return ret;
> +
> +	ret = adc5_gen3_configure(adc, prop);
> +	if (ret) {
> +		dev_err(adc->dev, "ADC configure failed with %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* No support for polling mode at present */
> +	rc = wait_for_completion_timeout(&adc->complete,
> +					 msecs_to_jiffies(ADC5_GEN3_CONV_TIMEOUT_MS));
> +	if (!rc) {
> +		dev_err(adc->dev, "Reading ADC channel %s timed out\n",
> +			prop->label);
> +		return -ETIMEDOUT;
> +	}
> +
> +	ret = adc5_gen3_read_voltage_data(adc, data_volt);
> +	if (ret)
> +		return ret;
> +
> +	val = BIT(0);
> +	return adc5_gen3_status_clear(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
> +				      ADC5_GEN3_EOC_CLR, &val, 1);
> +}
> +
> +static irqreturn_t adc5_gen3_isr(int irq, void *dev_id)
> +{
> +	struct adc5_chip *adc = dev_id;
> +	struct device *dev = adc->dev;
> +	struct auxiliary_device *adev;
> +	u8 status, eoc_status, val;
> +	u8 tm_status[2];
> +	int ret;
> +
> +	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
> +			     ADC5_GEN3_STATUS1, &status, sizeof(status));
> +	if (ret) {
> +		dev_err(dev, "adc read status1 failed with %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
> +			     ADC5_GEN3_EOC_STS, &eoc_status, sizeof(eoc_status));
> +	if (ret) {
> +		dev_err(dev, "adc read eoc status failed with %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (status & ADC5_GEN3_STATUS1_CONV_FAULT) {
> +		dev_err_ratelimited(dev,
> +				    "Unexpected conversion fault, status:%#x, eoc_status:%#x\n",
> +				    status, eoc_status);
> +		val = ADC5_GEN3_CONV_ERR_CLR_REQ;
> +		adc5_gen3_status_clear(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
> +				       ADC5_GEN3_CONV_ERR_CLR, &val, 1);
> +		return IRQ_HANDLED;
> +	}
> +
> +	/* CHAN0 is the preconfigured channel for immediate conversion */
> +	if (eoc_status & ADC5_GEN3_EOC_CHAN_0)
> +		complete(&adc->complete);
> +
> +	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
> +			     ADC5_GEN3_TM_HIGH_STS, tm_status, sizeof(tm_status));
> +	if (ret) {
> +		dev_err(dev, "adc read TM status failed with %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	dev_dbg(dev, "Interrupt status:%#x, EOC status:%#x, high:%#x, low:%#x\n",
> +		status, eoc_status, tm_status[0], tm_status[1]);
> +
> +	if (tm_status[0] || tm_status[1]) {
> +		adev = adc->tm_aux;
> +		if (!adev || !adev->dev.driver) {
> +			dev_err(dev, "adc_tm auxiliary device not initialized\n");
> +			return IRQ_HANDLED;
> +		}
> +
> +		adc->handler(adev);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int adc5_gen3_fwnode_xlate(struct iio_dev *indio_dev,
> +				  const struct fwnode_reference_args *iiospec)
> +{
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +	int v_channel;
> +
> +	for (int i = 0; i < adc->nchannels; i++) {
> +		v_channel = ADC5_GEN3_V_CHAN(adc->chan_props[i].common_props);
> +		if (v_channel == iiospec->args[0])
> +			return i;
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +static int adc5_gen3_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int *val,
> +			      int *val2, long mask)
> +{
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +	struct adc5_channel_common_prop *prop;
> +	u16 adc_code_volt;
> +	int ret;
> +
> +	prop = &adc->chan_props[chan->address].common_props;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = adc5_gen3_do_conversion(adc, prop, &adc_code_volt);
> +		if (ret)
> +			return ret;
> +
> +		ret = qcom_adc5_hw_scale(prop->scale_fn_type, prop->prescale,
> +					 adc->data, adc_code_volt, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adc5_gen3_read_label(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan, char *label)
> +{
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +	struct adc5_channel_prop *prop;
> +
> +	prop = &adc->chan_props[chan->address];
> +	return sprintf(label, "%s\n", prop->common_props.label);
> +}
> +
> +static const struct iio_info adc5_gen3_info = {
> +	.read_raw = adc5_gen3_read_raw,
> +	.read_label = adc5_gen3_read_label,
> +	.fwnode_xlate = adc5_gen3_fwnode_xlate,
> +};
> +
> +struct adc5_channels {
> +	unsigned int prescale_index;
> +	enum iio_chan_type type;
> +	long info_mask;
> +	enum vadc_scale_fn_type scale_fn_type;
> +};
> +
> +/* In these definitions, _pre refers to an index into adc5_prescale_ratios. */
> +#define ADC5_CHAN(_type, _mask, _pre, _scale)	\
> +	{						\
> +		.prescale_index = _pre,			\
> +		.type = _type,				\
> +		.info_mask = _mask,			\
> +		.scale_fn_type = _scale,		\
> +	},						\
> +
> +#define ADC5_CHAN_TEMP(_pre, _scale)		\
> +	ADC5_CHAN(IIO_TEMP, BIT(IIO_CHAN_INFO_PROCESSED), _pre, _scale)	\
> +
> +#define ADC5_CHAN_VOLT(_pre, _scale)		\
> +	ADC5_CHAN(IIO_VOLTAGE, BIT(IIO_CHAN_INFO_PROCESSED), _pre, _scale)	\
> +
> +#define ADC5_CHAN_CUR(_pre, _scale)		\
> +	ADC5_CHAN(IIO_CURRENT, BIT(IIO_CHAN_INFO_PROCESSED), _pre, _scale)	\
> +
> +static const struct adc5_channels adc5_gen3_chans_pmic[ADC5_MAX_CHANNEL] = {
> +	[ADC5_GEN3_REF_GND]		= ADC5_CHAN_VOLT(0, SCALE_HW_CALIB_DEFAULT)
> +	[ADC5_GEN3_1P25VREF]		= ADC5_CHAN_VOLT(0, SCALE_HW_CALIB_DEFAULT)
> +	[ADC5_GEN3_VPH_PWR]		= ADC5_CHAN_VOLT(1, SCALE_HW_CALIB_DEFAULT)
> +	[ADC5_GEN3_VBAT_SNS_QBG]	= ADC5_CHAN_VOLT(1, SCALE_HW_CALIB_DEFAULT)
> +	[ADC5_GEN3_USB_SNS_V_16]	= ADC5_CHAN_TEMP(8, SCALE_HW_CALIB_DEFAULT)
> +	[ADC5_GEN3_VIN_DIV16_MUX]	= ADC5_CHAN_TEMP(8, SCALE_HW_CALIB_DEFAULT)
> +	[ADC5_GEN3_DIE_TEMP]		= ADC5_CHAN_TEMP(0,
> +						SCALE_HW_CALIB_PMIC_THERM_PM7)
> +	[ADC5_GEN3_AMUX1_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
> +					SCALE_HW_CALIB_THERM_100K_PU_PM7)
> +	[ADC5_GEN3_AMUX2_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
> +					SCALE_HW_CALIB_THERM_100K_PU_PM7)
> +	[ADC5_GEN3_AMUX3_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
> +					SCALE_HW_CALIB_THERM_100K_PU_PM7)
> +	[ADC5_GEN3_AMUX4_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
> +					SCALE_HW_CALIB_THERM_100K_PU_PM7)
> +	[ADC5_GEN3_AMUX5_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
> +					SCALE_HW_CALIB_THERM_100K_PU_PM7)
> +	[ADC5_GEN3_AMUX6_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
> +					SCALE_HW_CALIB_THERM_100K_PU_PM7)
> +	[ADC5_GEN3_AMUX1_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
> +					SCALE_HW_CALIB_THERM_100K_PU_PM7)
> +	[ADC5_GEN3_AMUX2_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
> +					SCALE_HW_CALIB_THERM_100K_PU_PM7)
> +	[ADC5_GEN3_AMUX3_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
> +					SCALE_HW_CALIB_THERM_100K_PU_PM7)
> +	[ADC5_GEN3_AMUX4_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
> +					SCALE_HW_CALIB_THERM_100K_PU_PM7)
> +};
> +
> +static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
> +					 struct adc5_channel_prop *prop,
> +					 struct fwnode_handle *fwnode)
> +{
> +	const char *name = fwnode_get_name(fwnode);
> +	const struct adc5_data *data = adc->data;
> +	struct device *dev = adc->dev;
> +	const char *channel_name;
> +	u32 chan, value, sid;
> +	u32 varr[2];
> +	int ret;
> +
> +	ret = fwnode_property_read_u32(fwnode, "reg", &chan);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "invalid channel number %s\n",
> +				     name);
> +
> +	/*
> +	 * Value read from "reg" is virtual channel number
> +	 * virtual channel number = sid << 8 | channel number
> +	 */
> +	sid = FIELD_GET(ADC5_GEN3_VIRTUAL_SID_MASK, chan);
> +	chan = FIELD_GET(ADC5_GEN3_CHANNEL_MASK, chan);
> +
> +	if (chan > ADC5_MAX_CHANNEL)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "%s invalid channel number %d\n",
> +				     name, chan);
> +
> +	prop->common_props.channel = chan;
> +	prop->common_props.sid = sid;
> +
> +	if (!adc->data->adc_chans[chan].info_mask)
> +		return dev_err_probe(dev, -EINVAL, "Channel %#x not supported\n", chan);
> +
> +	channel_name = name;
> +	fwnode_property_read_string(fwnode, "label", &channel_name);
> +	prop->common_props.label = channel_name;
> +
> +	value = data->decimation[ADC5_DECIMATION_DEFAULT];
> +	fwnode_property_read_u32(fwnode, "qcom,decimation", &value);
> +	ret = qcom_adc5_decimation_from_dt(value, data->decimation);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "%#x invalid decimation %d\n",
> +				     chan, value);
> +	prop->common_props.decimation = ret;
> +
> +	prop->common_props.prescale = adc->data->adc_chans[chan].prescale_index;
> +	ret = fwnode_property_read_u32_array(fwnode, "qcom,pre-scaling", varr, 2);
> +	if (!ret) {
> +		ret = qcom_adc5_prescaling_from_dt(varr[0], varr[1]);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "%#x invalid pre-scaling <%d %d>\n",
> +					     chan, varr[0], varr[1]);
> +		prop->common_props.prescale = ret;
> +	}
> +
> +	value = data->hw_settle_1[VADC_DEF_HW_SETTLE_TIME];
> +	fwnode_property_read_u32(fwnode, "qcom,hw-settle-time", &value);
> +	ret = qcom_adc5_hw_settle_time_from_dt(value, data->hw_settle_1);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "%#x invalid hw-settle-time %d us\n",
> +				     chan, value);
> +	prop->common_props.hw_settle_time_us = ret;
> +
> +	value = BIT(VADC_DEF_AVG_SAMPLES);
> +	fwnode_property_read_u32(fwnode, "qcom,avg-samples", &value);
> +	ret = qcom_adc5_avg_samples_from_dt(value);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "%#x invalid avg-samples %d\n",
> +				     chan, value);
> +	prop->common_props.avg_samples = ret;
> +
> +	if (fwnode_property_read_bool(fwnode, "qcom,ratiometric"))
> +		prop->common_props.cal_method = ADC5_RATIOMETRIC_CAL;
> +	else
> +		prop->common_props.cal_method = ADC5_ABSOLUTE_CAL;
> +
> +	prop->adc_tm = fwnode_property_read_bool(fwnode, "qcom,adc-tm");
> +	if (prop->adc_tm) {
> +		adc->n_tm_channels++;
> +		if (adc->n_tm_channels > (adc->dev_data.num_sdams * 8 - 1))
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Number of TM nodes %u greater than channels supported:%u\n",
> +					     adc->n_tm_channels,
> +					     adc->dev_data.num_sdams * 8 - 1);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct adc5_data adc5_gen3_data_pmic = {
> +	.full_scale_code_volt = 0x70e4,
> +	.adc_chans = adc5_gen3_chans_pmic,
> +	.info = &adc5_gen3_info,
> +	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
> +			   { 85, 340, 1360 },
> +	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
> +			   { 15, 100, 200, 300,
> +			     400, 500, 600, 700,
> +			     1000, 2000, 4000, 8000,
> +			     16000, 32000, 64000, 128000 },
> +};
> +
> +static const struct of_device_id adc5_match_table[] = {
> +	{
> +		.compatible = "qcom,spmi-adc5-gen3",
> +		.data = &adc5_gen3_data_pmic,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adc5_match_table);
> +
> +static int adc5_get_fw_data(struct adc5_chip *adc)
> +{
> +	const struct adc5_channels *adc_chan;
> +	struct adc5_channel_prop *chan_props;
> +	struct iio_chan_spec *iio_chan;
> +	struct device *dev = adc->dev;
> +	unsigned int index = 0;
> +	int ret;
> +
> +	adc->nchannels = device_get_child_node_count(dev);
> +	if (!adc->nchannels)
> +		return dev_err_probe(dev, -EINVAL, "No ADC channels found\n");
> +
> +	adc->iio_chans = devm_kcalloc(dev, adc->nchannels,
> +				      sizeof(*adc->iio_chans), GFP_KERNEL);
> +	if (!adc->iio_chans)
> +		return -ENOMEM;
> +
> +	adc->chan_props = devm_kcalloc(dev, adc->nchannels,
> +				       sizeof(*adc->chan_props), GFP_KERNEL);
> +	if (!adc->chan_props)
> +		return -ENOMEM;
> +
> +	chan_props = adc->chan_props;
> +	adc->n_tm_channels = 0;
> +	iio_chan = adc->iio_chans;
> +	adc->data = device_get_match_data(dev);
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = adc5_gen3_get_fw_channel_data(adc, chan_props, child);
> +		if (ret)
> +			return ret;
> +
> +		chan_props->chip = adc;
> +		adc_chan = &adc->data->adc_chans[chan_props->common_props.channel];
> +		chan_props->common_props.scale_fn_type = adc_chan->scale_fn_type;
> +
> +		iio_chan->channel = ADC5_GEN3_V_CHAN(chan_props->common_props);
> +		iio_chan->info_mask_separate = adc_chan->info_mask;
> +		iio_chan->type = adc_chan->type;
> +		iio_chan->address = index;
> +		iio_chan->indexed = 1;
> +		iio_chan++;
> +		chan_props++;
> +		index++;
> +	}
> +
> +	return 0;
> +}
> +
> +static void adc5_gen3_uninit_aux(void *data)
> +{
> +	auxiliary_device_uninit(data);
> +}
> +
> +static void adc5_gen3_delete_aux(void *data)
> +{
> +	auxiliary_device_delete(data);
> +}
> +
> +static void adc5_gen3_aux_device_release(struct device *dev) {}
> +
> +static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
> +{
> +	struct tm5_aux_dev_wrapper *aux_device;
> +	int ret, i_tm = 0;
> +
> +	aux_device = devm_kzalloc(adc->dev, sizeof(*aux_device), GFP_KERNEL);
> +	if (!aux_device)
> +		return -ENOMEM;
> +
> +	aux_device->aux_dev.name = "adc5_tm_gen3";
> +	aux_device->aux_dev.dev.parent = adc->dev;
> +	aux_device->aux_dev.dev.release = adc5_gen3_aux_device_release;
> +
> +	aux_device->tm_props = devm_kcalloc(adc->dev, adc->n_tm_channels,
> +					    sizeof(*aux_device->tm_props),
> +					    GFP_KERNEL);
> +	if (!aux_device->tm_props)
> +		return -ENOMEM;
> +
> +	aux_device->dev_data = &adc->dev_data;
> +
> +	for (int i = 0; i < adc->nchannels; i++) {
> +		if (!adc->chan_props[i].adc_tm)
> +			continue;
> +		aux_device->tm_props[i_tm] = adc->chan_props[i].common_props;
> +		i_tm++;
> +	}
> +
> +	device_set_of_node_from_dev(&aux_device->aux_dev.dev, adc->dev);
> +
> +	aux_device->n_tm_channels = adc->n_tm_channels;
> +
> +	ret = auxiliary_device_init(&aux_device->aux_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_uninit_aux,
> +				       &aux_device->aux_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = auxiliary_device_add(&aux_device->aux_dev);
> +	if (ret)
> +		return ret;
> +	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_delete_aux,
> +				       &aux_device->aux_dev);
> +	if (ret)
> +		return ret;
> +
> +	adc->tm_aux = &aux_device->aux_dev;
> +
> +	return 0;
> +}
> +
> +void adc5_gen3_mutex_lock(struct device *dev)
> +	__acquires(&adc->lock)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +
> +	mutex_lock(&adc->lock);
> +}
> +EXPORT_SYMBOL_NS_GPL(adc5_gen3_mutex_lock, "QCOM_SPMI_ADC5_GEN3");
> +
> +void adc5_gen3_mutex_unlock(struct device *dev)
> +	__releases(&adc->lock)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +
> +	mutex_unlock(&adc->lock);
> +}
> +EXPORT_SYMBOL_NS_GPL(adc5_gen3_mutex_unlock, "QCOM_SPMI_ADC5_GEN3");
> +
> +int adc5_gen3_get_scaled_reading(struct device *dev,
> +				 struct adc5_channel_common_prop *common_props,
> +				 int *val)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +	u16 adc_code_volt;
> +	int ret;
> +
> +	ret = adc5_gen3_do_conversion(adc, common_props, &adc_code_volt);
> +	if (ret)
> +		return ret;
> +
> +	return qcom_adc5_hw_scale(common_props->scale_fn_type,
> +				  common_props->prescale,
> +				  adc->data, adc_code_volt, val);
> +}
> +EXPORT_SYMBOL_NS_GPL(adc5_gen3_get_scaled_reading, "QCOM_SPMI_ADC5_GEN3");
> +
> +int adc5_gen3_therm_code_to_temp(struct device *dev,
> +				 struct adc5_channel_common_prop *common_props,
> +				 u16 code, int *val)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +
> +	return qcom_adc5_hw_scale(common_props->scale_fn_type,
> +				  common_props->prescale,
> +				  adc->data, code, val);
> +}
> +EXPORT_SYMBOL_NS_GPL(adc5_gen3_therm_code_to_temp, "QCOM_SPMI_ADC5_GEN3");
> +
> +void adc5_gen3_register_tm_event_notifier(struct device *dev,
> +					  void (*handler)(struct auxiliary_device *))
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +
> +	adc->handler = handler;
> +}
> +EXPORT_SYMBOL_NS_GPL(adc5_gen3_register_tm_event_notifier, "QCOM_SPMI_ADC5_GEN3");
> +
> +static int adc5_gen3_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct adc5_chip *adc;
> +	struct regmap *regmap;
> +	int ret;
> +	u32 *reg;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc = iio_priv(indio_dev);
> +	adc->dev_data.regmap = regmap;
> +	adc->dev = dev;
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +	init_completion(&adc->complete);
> +	ret = devm_mutex_init(dev, &adc->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = device_property_count_u32(dev, "reg");
> +	if (ret < 0)
> +		return ret;
> +
> +	adc->dev_data.num_sdams = ret;
> +
> +	reg = devm_kcalloc(dev, adc->dev_data.num_sdams, sizeof(u32),
> +			   GFP_KERNEL);
> +	if (!reg)
> +		return -ENOMEM;
> +
> +	ret = device_property_read_u32_array(dev, "reg", reg,
> +					     adc->dev_data.num_sdams);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to read reg property\n");
> +
> +	adc->dev_data.base = devm_kcalloc(dev, adc->dev_data.num_sdams,
> +					  sizeof(*adc->dev_data.base),
> +					  GFP_KERNEL);
> +	if (!adc->dev_data.base)
> +		return -ENOMEM;
> +
> +	for (int i = 0; i < adc->dev_data.num_sdams; i++) {
> +		adc->dev_data.base[i].base_addr = reg[i];
> +
> +		ret = platform_get_irq(pdev, i);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "Getting IRQ %d failed\n", i);
> +
> +		adc->dev_data.base[i].irq = ret;
> +
> +		adc->dev_data.base[i].irq_name = devm_kasprintf(dev, GFP_KERNEL,
> +								"sdam%d", i);
> +		if (!adc->dev_data.base[i].irq_name)
> +			return -ENOMEM;
> +	}
> +
> +	ret = devm_request_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq,
> +			       adc5_gen3_isr, 0,
> +			       adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
> +			       adc);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to request SDAM%d irq\n",
> +				     ADC5_GEN3_VADC_SDAM);
> +
> +	ret = adc5_get_fw_data(adc);
> +	if (ret)
> +		return ret;
> +
> +	if (adc->n_tm_channels > 0) {
> +		ret = adc5_gen3_add_aux_tm_device(adc);
> +		if (ret)
> +			dev_err_probe(dev, ret,
> +				      "Failed to add auxiliary TM device\n");
> +	}
> +
> +	indio_dev->name = "spmi-adc5-gen3";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &adc5_gen3_info;
> +	indio_dev->channels = adc->iio_chans;
> +	indio_dev->num_channels = adc->nchannels;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static struct platform_driver adc5_gen3_driver = {
> +	.driver = {
> +		.name = "qcom-spmi-adc5-gen3",
> +		.of_match_table = adc5_match_table,
> +	},
> +	.probe = adc5_gen3_probe,
> +};
> +module_platform_driver(adc5_gen3_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. PMIC5 Gen3 ADC driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("QCOM_SPMI_ADC5_GEN3");
> diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
> new file mode 100644
> index 000000000000..e352733f4a70
> --- /dev/null
> +++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
> @@ -0,0 +1,212 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * Code used in the main and auxiliary Qualcomm PMIC voltage ADCs
> + * of type ADC5 Gen3.
> + */
> +
> +#ifndef QCOM_ADC5_GEN3_COMMON_H
> +#define QCOM_ADC5_GEN3_COMMON_H
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/iio/adc/qcom-vadc-common.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +#define ADC5_GEN3_HS				0x45
> +#define ADC5_GEN3_HS_BUSY			BIT(7)
> +#define ADC5_GEN3_HS_READY			BIT(0)
> +
> +#define ADC5_GEN3_STATUS1			0x46
> +#define ADC5_GEN3_STATUS1_CONV_FAULT		BIT(7)
> +#define ADC5_GEN3_STATUS1_THR_CROSS		BIT(6)
> +#define ADC5_GEN3_STATUS1_EOC			BIT(0)
> +
> +#define ADC5_GEN3_TM_EN_STS			0x47
> +#define ADC5_GEN3_TM_HIGH_STS			0x48
> +#define ADC5_GEN3_TM_LOW_STS			0x49
> +
> +#define ADC5_GEN3_EOC_STS			0x4a
> +#define ADC5_GEN3_EOC_CHAN_0			BIT(0)
> +
> +#define ADC5_GEN3_EOC_CLR			0x4b
> +#define ADC5_GEN3_TM_HIGH_STS_CLR		0x4c
> +#define ADC5_GEN3_TM_LOW_STS_CLR		0x4d
> +#define ADC5_GEN3_CONV_ERR_CLR			0x4e
> +#define ADC5_GEN3_CONV_ERR_CLR_REQ		BIT(0)
> +
> +#define ADC5_GEN3_SID				0x4f
> +#define ADC5_GEN3_SID_MASK			GENMASK(3, 0)
> +
> +#define ADC5_GEN3_PERPH_CH			0x50
> +#define ADC5_GEN3_CHAN_CONV_REQ			BIT(7)
> +
> +#define ADC5_GEN3_TIMER_SEL			0x51
> +#define ADC5_GEN3_TIME_IMMEDIATE		0x1
> +
> +#define ADC5_GEN3_DIG_PARAM			0x52
> +#define ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK	GENMASK(5, 4)
> +#define ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK	GENMASK(3, 2)
> +
> +#define ADC5_GEN3_FAST_AVG			0x53
> +#define ADC5_GEN3_FAST_AVG_CTL_EN		BIT(7)
> +#define ADC5_GEN3_FAST_AVG_CTL_SAMPLES_MASK	GENMASK(2, 0)
> +
> +#define ADC5_GEN3_ADC_CH_SEL_CTL		0x54
> +#define ADC5_GEN3_DELAY_CTL			0x55
> +#define ADC5_GEN3_HW_SETTLE_DELAY_MASK		GENMASK(3, 0)
> +
> +#define ADC5_GEN3_CH_EN				0x56
> +#define ADC5_GEN3_HIGH_THR_INT_EN		BIT(1)
> +#define ADC5_GEN3_LOW_THR_INT_EN		BIT(0)
> +
> +#define ADC5_GEN3_LOW_THR0			0x57
> +#define ADC5_GEN3_LOW_THR1			0x58
> +#define ADC5_GEN3_HIGH_THR0			0x59
> +#define ADC5_GEN3_HIGH_THR1			0x5a
> +
> +#define ADC5_GEN3_CH_DATA0(channel)	(0x5c + (channel) * 2)
> +#define ADC5_GEN3_CH_DATA1(channel)	(0x5d + (channel) * 2)
> +
> +#define ADC5_GEN3_CONV_REQ			0xe5
> +#define ADC5_GEN3_CONV_REQ_REQ			BIT(0)
> +
> +#define ADC5_GEN3_VIRTUAL_SID_MASK		GENMASK(15, 8)
> +#define ADC5_GEN3_CHANNEL_MASK			GENMASK(7, 0)
> +#define ADC5_GEN3_V_CHAN(x)		\
> +	(FIELD_PREP(ADC5_GEN3_VIRTUAL_SID_MASK, (x).sid) | (x).channel)
> +
> +/* ADC channels for PMIC5 Gen3 */
> +#define ADC5_GEN3_REF_GND			0x00
> +#define ADC5_GEN3_1P25VREF			0x01
> +#define ADC5_GEN3_DIE_TEMP			0x03
> +#define ADC5_GEN3_USB_SNS_V_16			0x11
> +#define ADC5_GEN3_VIN_DIV16_MUX			0x12
> +#define ADC5_GEN3_VPH_PWR			0x8e
> +#define ADC5_GEN3_VBAT_SNS_QBG			0x8f
> +/* 100k pull-up channels */
> +#define ADC5_GEN3_AMUX1_THM_100K_PU		0x44
> +#define ADC5_GEN3_AMUX2_THM_100K_PU		0x45
> +#define ADC5_GEN3_AMUX3_THM_100K_PU		0x46
> +#define ADC5_GEN3_AMUX4_THM_100K_PU		0x47
> +#define ADC5_GEN3_AMUX5_THM_100K_PU		0x48
> +#define ADC5_GEN3_AMUX6_THM_100K_PU		0x49
> +#define ADC5_GEN3_AMUX1_GPIO_100K_PU		0x4a
> +#define ADC5_GEN3_AMUX2_GPIO_100K_PU		0x4b
> +#define ADC5_GEN3_AMUX3_GPIO_100K_PU		0x4c
> +#define ADC5_GEN3_AMUX4_GPIO_100K_PU		0x4d
> +
> +#define ADC5_MAX_CHANNEL			0xc0
> +
> +struct device;
> +
> +enum adc5_cal_method {
> +	ADC5_NO_CAL = 0,
> +	ADC5_RATIOMETRIC_CAL,
> +	ADC5_ABSOLUTE_CAL,
> +};
> +
> +enum adc5_time_select {
> +	MEAS_INT_DISABLE = 0,
> +	MEAS_INT_IMMEDIATE,
> +	MEAS_INT_50MS,
> +	MEAS_INT_100MS,
> +	MEAS_INT_1S,
> +	MEAS_INT_NONE,
> +};
> +
> +/**
> + * struct adc5_sdam_data - data per SDAM allocated for adc usage
> + * @base_addr: base address for the ADC SDAM peripheral.
> + * @irq_name: ADC IRQ name.
> + * @irq: ADC IRQ number.
> + */
> +struct adc5_sdam_data {
> +	u16 base_addr;
> +	const char *irq_name;
> +	int irq;
> +};
> +
> +/**
> + * struct adc5_device_data - Top-level ADC device data
> + * @regmap: ADC peripheral register map field.
> + * @base: array of SDAM data.
> + * @num_sdams: number of ADC SDAM peripherals.
> + */
> +struct adc5_device_data {
> +	struct regmap *regmap;
> +	struct adc5_sdam_data *base;
> +	int num_sdams;
> +};
> +
> +/**
> + * struct adc5_channel_common_prop - ADC channel properties (common to ADC and TM).
> + * @channel: channel number, refer to the channel list.
> + * @cal_method: calibration method.
> + * @decimation: sampling rate supported for the channel.
> + * @sid: ID of PMIC owning the channel.
> + * @label: Channel name used in device tree.
> + * @prescale: channel scaling performed on the input signal.
> + * @hw_settle_time_us: the time between AMUX being configured and the
> + *	start of conversion in uS.
> + * @avg_samples: ability to provide single result from the ADC
> + *	that is an average of multiple measurements.
> + * @scale_fn_type: Represents the scaling function to convert voltage
> + *	physical units desired by the client for the channel.
> + */
> +struct adc5_channel_common_prop {
> +	unsigned int channel;
> +	enum adc5_cal_method cal_method;
> +	unsigned int decimation;
> +	unsigned int sid;
> +	const char *label;
> +	unsigned int prescale;
> +	unsigned int hw_settle_time_us;
> +	unsigned int avg_samples;
> +	enum vadc_scale_fn_type scale_fn_type;
> +};
> +
> +/**
> + * struct tm5_aux_dev_wrapper - wrapper structure around TM auxiliary device
> + * @aux_dev: TM auxiliary device structure.
> + * @dev_data: Top-level ADC device data.
> + * @tm_props: Array of common ADC channel properties for TM channels.
> + * @n_tm_channels: number of TM channels.
> + */
> +struct tm5_aux_dev_wrapper {
> +	struct auxiliary_device aux_dev;
> +	struct adc5_device_data *dev_data;
> +	struct adc5_channel_common_prop *tm_props;
> +	unsigned int n_tm_channels;
> +};
> +
> +int adc5_gen3_read(struct adc5_device_data *adc, unsigned int sdam_index,
> +		   u16 offset, u8 *data, int len);
> +
> +int adc5_gen3_write(struct adc5_device_data *adc, unsigned int sdam_index,
> +		    u16 offset, u8 *data, int len);
> +
> +int adc5_gen3_poll_wait_hs(struct adc5_device_data *adc,
> +			   unsigned int sdam_index);
> +
> +void adc5_gen3_update_dig_param(struct adc5_channel_common_prop *prop,
> +				u8 *data);
> +
> +int adc5_gen3_status_clear(struct adc5_device_data *adc,
> +			   int sdam_index, u16 offset, u8 *val, int len);
> +
> +void adc5_gen3_mutex_lock(struct device *dev);
> +void adc5_gen3_mutex_unlock(struct device *dev);
> +int adc5_gen3_get_scaled_reading(struct device *dev,
> +				 struct adc5_channel_common_prop *common_props,
> +				 int *val);
> +int adc5_gen3_therm_code_to_temp(struct device *dev,
> +				 struct adc5_channel_common_prop *common_props,
> +				 u16 code, int *val);
> +void adc5_gen3_register_tm_event_notifier(struct device *dev,
> +					  void (*handler)(struct auxiliary_device *));
> +
> +#endif /* QCOM_ADC5_GEN3_COMMON_H */


