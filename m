Return-Path: <linux-pm+bounces-8193-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDE18D0EBA
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 22:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8C81C2137C
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 20:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8991649C6;
	Mon, 27 May 2024 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="anjUcuIW"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCBD161302;
	Mon, 27 May 2024 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716842468; cv=none; b=GUPcEcwPHbxsy4sJ/BHH426K4iASDUgWwOAfqQMXlRp2zgnvoS4ljFZkk/ewjLCun7tRChb36OIG3OYsdOZSQNtPdDO0j0uz9KhJzvDMB2D0cN1qc6/LYR/Q/+/ZngGEeCFySUAkJwNTjmeZPq34b6hshmhpY/dqiuKiSVw87zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716842468; c=relaxed/simple;
	bh=YnuBk0ftUtaebbATSMP5EXPAvKtk1fwsowA5EmF4Vvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeA/bXiXawBGdpCCGauEhGsvCgBsXDTsI9oQpRYZtxXsDGweznGKEZOpeU5OWyVu9BaK2/QZJOLKCjxFK4U8imp8njxYDPRokkb8FqH7HBiHurtqTuB+LUjFOcFwuKJQ9neaHu1fva2Mkx3s+4l9PNqcxGCyzF+lD9mAbhqJWoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=anjUcuIW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716842455;
	bh=YnuBk0ftUtaebbATSMP5EXPAvKtk1fwsowA5EmF4Vvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=anjUcuIWe2nEJx6da/LWUAOhZz/llRdpYVO66DPj4u2vf1HGNAeSyIgVCKp+2o0Z6
	 N1EZgmYygyeSrt/zdYxYPgZclueqXUPJr0l60nbpeyZxF42Ps9Cr8YrSPLAB/KeF/h
	 YI9myriCFjxRuqmYxW2gPT1jddlbW4w8du81ZJThyK5FOxbvUkkVbwx8e2kkxgzLfG
	 TV4cgGqSKb+4lpQzb5RZlhfFGrYKXDEmr0pVX0Cp/W2kVddWu0w1X7MPKTRKpxrF9Y
	 BQYzpQETVIRnqZuoYwUbI9z0HvBoHe55zQHKXrQWUxqR0qx9ufJbdEBoldf/lr/5Bq
	 2DBlf2UwhaIRg==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EC1893781116;
	Mon, 27 May 2024 20:40:54 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 7226710612B3; Mon, 27 May 2024 22:40:54 +0200 (CEST)
Date: Mon, 27 May 2024 22:40:54 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] power: supply: ltc3350-charger: Add driver
Message-ID: <t4avn7fmzw355a73hu3yu4wzdxyc5gkupi5s4yfio5iyiygkx6@5eubzdbqthqx>
References: <20240416121818.543896-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.4a7cccf3-e7cb-4980-be8e-de8bd2795354@emailsignatures365.codetwo.com>
 <20240416121818.543896-5-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kmp6tfkrsdbvpndl"
Content-Disposition: inline
In-Reply-To: <20240416121818.543896-5-mike.looijmans@topic.nl>


--kmp6tfkrsdbvpndl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for being late with reviewing v5. Considering this adds quite
a bit of new userspace ABI, I did not want to rush this.

On Tue, Apr 16, 2024 at 02:18:18PM +0200, Mike Looijmans wrote:
> The LTC3350 is a backup power controller that can charge and monitor
> a series stack of one to four supercapacitors.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>=20
> ---
>=20
> Changes in v5:
> Fix ltc3350_set_scaled() arguments in "store" routines
> Measurement values are signed
> Report technology as "Capacitor"
> Report "full" when "capgd" asserts
> Move charge current to "current_now" of capacitor
> Add ABI documentation
>=20
> Changes in v4:
> Split into "charger" and "capacitor" parts
> Use (new) standard properties
> Header include fixups
> Explain local "scale" units
> Drop i2c_check_functionality
> Use dev_err_probe
> Use dev_fwnode
> Drop of_match_ptr
>=20
> Changes in v2:
> Duplicate "vin_ov" and "vin_uv" attributes
>=20
>  .../ABI/testing/sysfs-class-power-ltc3350     |  88 ++
>  drivers/power/supply/Kconfig                  |  10 +
>  drivers/power/supply/Makefile                 |   1 +
>  drivers/power/supply/ltc3350-charger.c        | 789 ++++++++++++++++++
>  4 files changed, 888 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-power-ltc3350
>  create mode 100644 drivers/power/supply/ltc3350-charger.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power-ltc3350 b/Docume=
ntation/ABI/testing/sysfs-class-power-ltc3350
> new file mode 100644
> index 000000000000..d4a2bb0fb62b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-power-ltc3350
> @@ -0,0 +1,88 @@
> +What:		/sys/class/power_supply/ltc3350/charge_status
> +Date:		April 2024
> +KernelVersion:	6.9
> +Description:
> +		Detailed charge status information as reported by the chip. This
> +		returns the raw register value in hex.
> +
> +		Access: Read

With regmap you should be able to get register content via debugfs
for debug purposes. Is there any other reason this is needed?

> +What:		/sys/class/power_supply/ltc3350/vshunt
> +Date:		April 2024
> +KernelVersion:	6.9
> +Description:
> +		Voltage for "shunting" the capacitors in the stack. When the
> +		capacitor voltage is above this value, the chip will discharge
> +		the excess voltage using a shunt resistor.
> +		This is typically used to limit the voltage on a single cell,
> +		to compensate for imbalance and prevent damaging the capacitor
> +		while charging. It can also be used to forcibly discharge the
> +		capacitors.
> +
> +		Access: Read, Write
> +
> +		Valid values: In microvolts, defaults to 2.7V
> +
> +What:		/sys/class/power_supply/ltc3350/gpi
> +Date:		April 2024
> +KernelVersion:	6.9
> +Description:
> +		General purpose input voltage. Returns a single measurement.

I think this should get this extra sentence:

"For example used for temperature measurement of the supercapacitor
stack using an NTC thermistor."

> +
> +		Access: Read
> +
> +		Valid values: In microvolts
> +
> +What:		/sys/class/power_supply/ltc3350/gpi_ov
> +Date:		April 2024
> +KernelVersion:	6.9
> +Description:
> +		General purpose input voltage overvoltage level. Triggers an
> +		alert for userspace when the voltage goes above this value.
> +
> +		Access: Read, Write
> +
> +		Valid values: In microvolts
> +
> +What:		/sys/class/power_supply/ltc3350/gpi_uv
> +Date:		April 2024
> +KernelVersion:	6.9
> +Description:
> +		General purpose input voltage undervoltage level. Triggers an
> +		alert for userspace when the voltage drops below this value.
> +
> +		Access: Read, Write
> +
> +		Valid values: In microvolts

The custom properties are not part of the uevent, so I guess there
won't be much of an alert. A sensible way to properly handle this
would be registration of a single-channel IIO ADC device. Are you
using this feature? Otherwise it might be sensible to drop GPI
support for now.

> +What:		/sys/class/power_supply/ltc3350/vin
> +Date:		April 2024
> +KernelVersion:	6.9
> +Description:
> +		Charger input voltage. Returns a single measurement.
> +
> +		Access: Read
> +
> +		Valid values: In microvolts
> +
> +What:		/sys/class/power_supply/ltc3350/vin_ov
> +Date:		April 2024
> +KernelVersion:	6.9
> +Description:
> +		Input voltage overvoltage level. Triggers an alert for userspace
> +		when the voltage goes above this value.
> +
> +		Access: Read, Write
> +
> +		Valid values: In microvolts
> +
> +What:		/sys/class/power_supply/ltc3350/vin_uv
> +Date:		April 2024
> +KernelVersion:	6.9
> +Description:
> +		Input voltage undervoltage level. Triggers an alert for
> +		userspace when the voltage drops below this value.
> +
> +		Access: Read, Write
> +
> +		Valid values: In microvolts

I added some bits about vin later.

> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 3e31375491d5..7cb1a66e522d 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -514,6 +514,16 @@ config CHARGER_LT3651
>  	  Say Y to include support for the Analog Devices (Linear Technology)
>  	  LT3651 battery charger which reports its status via GPIO lines.
> =20
> +config CHARGER_LTC3350
> +	tristate "LTC3350 Supercapacitor Backup Controller and System Monitor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select I2C_SMBUS
> +	help
> +	  Say Y to include support for the Analog Devices (Linear Technology)
> +	  LTC3350 Supercapacitor Backup Controller and System Monitor connected
> +	  to I2C.
> +
>  config CHARGER_LTC4162L
>  	tristate "LTC4162-L charger"
>  	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 58b567278034..a8d618e4ac91 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -72,6 +72,7 @@ obj-$(CONFIG_CHARGER_LP8788)	+=3D lp8788-charger.o
>  obj-$(CONFIG_CHARGER_GPIO)	+=3D gpio-charger.o
>  obj-$(CONFIG_CHARGER_MANAGER)	+=3D charger-manager.o
>  obj-$(CONFIG_CHARGER_LT3651)	+=3D lt3651-charger.o
> +obj-$(CONFIG_CHARGER_LTC3350)	+=3D ltc3350-charger.o
>  obj-$(CONFIG_CHARGER_LTC4162L)	+=3D ltc4162-l-charger.o
>  obj-$(CONFIG_CHARGER_MAX14577)	+=3D max14577_charger.o
>  obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+=3D max14656_charger_detector.o
> diff --git a/drivers/power/supply/ltc3350-charger.c b/drivers/power/suppl=
y/ltc3350-charger.c
> new file mode 100644
> index 000000000000..55b8a3922b4a
> --- /dev/null
> +++ b/drivers/power/supply/ltc3350-charger.c
> @@ -0,0 +1,789 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for Analog Devices (Linear Technology) LTC3350
> + * High Current Supercapacitor Backup Controller and System Monitor
> + * Copyright (C) 2024, Topic Embedded Products
> + */
> +
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/power_supply.h>
> +#include <linux/property.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +
> +/* Registers (names based on what datasheet uses) */
> +#define LTC3350_REG_CLR_ALARMS		0x00
> +#define LTC3350_REG_MSK_ALARMS		0x01
> +#define LTC3350_REG_MSK_MON_STATUS	0x02
> +#define LTC3350_REG_CAP_ESR_PER		0x04
> +#define LTC3350_REG_VCAPFB_DAC		0x05
> +#define LTC3350_REG_VSHUNT		0x06
> +#define LTC3350_REG_CAP_UV_LVL		0x07
> +#define LTC3350_REG_CAP_OV_LVL		0x08
> +#define LTC3350_REG_GPI_UV_LVL		0x09
> +#define LTC3350_REG_GPI_OV_LVL		0x0A
> +#define LTC3350_REG_VIN_UV_LVL		0x0B
> +#define LTC3350_REG_VIN_OV_LVL		0x0C
> +#define LTC3350_REG_VCAP_UV_LVL		0x0D
> +#define LTC3350_REG_VCAP_OV_LVL		0x0E
> +#define LTC3350_REG_VOUT_UV_LVL		0x0F
> +#define LTC3350_REG_VOUT_OV_LVL		0x10
> +#define LTC3350_REG_IIN_OC_LVL		0x11
> +#define LTC3350_REG_ICHG_UC_LVL		0x12
> +#define LTC3350_REG_DTEMP_COLD_LVL	0x13
> +#define LTC3350_REG_DTEMP_HOT_LVL	0x14
> +#define LTC3350_REG_ESR_HI_LVL		0x15
> +#define LTC3350_REG_CAP_LO_LVL		0x16
> +#define LTC3350_REG_CTL_REG		0x17
> +#define LTC3350_REG_NUM_CAPS		0x1A
> +#define LTC3350_REG_CHRG_STATUS		0x1B
> +#define LTC3350_REG_MON_STATUS		0x1C
> +#define LTC3350_REG_ALARM_REG		0x1D
> +#define LTC3350_REG_MEAS_CAP		0x1E
> +#define LTC3350_REG_MEAS_ESR		0x1F
> +#define LTC3350_REG_MEAS_VCAP1		0x20
> +#define LTC3350_REG_MEAS_VCAP2		0x21
> +#define LTC3350_REG_MEAS_VCAP3		0x22
> +#define LTC3350_REG_MEAS_VCAP4		0x23
> +#define LTC3350_REG_MEAS_GPI		0x24
> +#define LTC3350_REG_MEAS_VIN		0x25
> +#define LTC3350_REG_MEAS_VCAP		0x26
> +#define LTC3350_REG_MEAS_VOUT		0x27
> +#define LTC3350_REG_MEAS_IIN		0x28
> +#define LTC3350_REG_MEAS_ICHG		0x29
> +#define LTC3350_REG_MEAS_DTEMP		0x2A
> +
> +/* LTC3350_REG_CLR_ALARMS, LTC3350_REG_MASK_ALARMS, LTC3350_REG_ALARM_RE=
G */
> +#define LTC3350_MSK_CAP_UV	BIT(0)	/* capacitor undervoltage alarm */
> +#define LTC3350_MSK_CAP_OV	BIT(1)	/* capacitor overvoltage alarm */
> +#define LTC3350_MSK_GPI_UV	BIT(2)	/* GPI undervoltage alarm */
> +#define LTC3350_MSK_GPI_OV	BIT(3)	/* GPI overvoltage alarm */
> +#define LTC3350_MSK_VIN_UV	BIT(4)	/* VIN undervoltage alarm */
> +#define LTC3350_MSK_VIN_OV	BIT(5)	/* VIN overvoltage alarm */
> +#define LTC3350_MSK_VCAP_UV	BIT(6)	/* VCAP undervoltage alarm */
> +#define LTC3350_MSK_VCAP_OV	BIT(7)	/* VCAP overvoltage alarm */
> +#define LTC3350_MSK_VOUT_UV	BIT(8)	/* VOUT undervoltage alarm */
> +#define LTC3350_MSK_VOUT_OV	BIT(9)	/* VOUT overvoltage alarm */
> +#define LTC3350_MSK_IIN_OC	BIT(10)	/* input overcurrent alarm */
> +#define LTC3350_MSK_ICHG_UC	BIT(11)	/* charge undercurrent alarm */
> +#define LTC3350_MSK_DTEMP_COLD	BIT(12)	/* die temperature cold alarm */
> +#define LTC3350_MSK_DTEMP_HOT	BIT(13)	/* die temperature hot alarm */
> +#define LTC3350_MSK_ESR_HI	BIT(14)	/* ESR high alarm */
> +#define LTC3350_MSK_CAP_LO	BIT(15)	/* capacitance low alarm */
> +
> +/* LTC3350_REG_MSK_MON_STATUS masks */
> +#define LTC3350_MSK_MON_CAPESR_ACTIVE		BIT(0)
> +#define LTC3350_MSK_MON_CAPESR_SCHEDULED	BIT(1)
> +#define LTC3350_MSK_MON_CAPESR_PENDING		BIT(2)
> +#define LTC3350_MSK_MON_CAP_DONE		BIT(3)
> +#define LTC3350_MSK_MON_ESR_DONE		BIT(4)
> +#define LTC3350_MSK_MON_CAP_FAILED		BIT(5)
> +#define LTC3350_MSK_MON_ESR_FAILED		BIT(6)
> +#define LTC3350_MSK_MON_POWER_FAILED		BIT(8)
> +#define LTC3350_MSK_MON_POWER_RETURNED		BIT(9)
> +
> +/* LTC3350_REG_CTL_REG */
> +/* Begin a capacitance and ESR measurement when possible */
> +#define LTC3350_CTL_STRT_CAPESR		BIT(0)
> +/* A one in this bit location enables the input buffer on the GPI pin */
> +#define LTC3350_CTL_GPI_BUFFER_EN	BIT(1)
> +/* Stops an active capacitance/ESR measurement */
> +#define LTC3350_CTL_STOP_CAPESR		BIT(2)
> +/* Increases capacitor measurement resolution by 100x for smaller capaci=
tors */
> +#define LTC3350_CTL_CAP_SCALE		BIT(3)
> +
> +/* LTC3350_REG_CHRG_STATUS */
> +#define LTC3350_CHRG_STEPDOWN	BIT(0)	/* Synchronous controller in step-d=
own mode (charging) */
> +#define LTC3350_CHRG_STEPUP	BIT(1)	/* Synchronous controller in step-up =
mode (backup) */
> +#define LTC3350_CHRG_CV		BIT(2)	/* The charger is in constant voltage mo=
de */
> +#define LTC3350_CHRG_UVLO	BIT(3)	/* The charger is in undervoltage locko=
ut */
> +#define LTC3350_CHRG_INPUT_ILIM	BIT(4)	/* The charger is in input curren=
t limit */
> +#define LTC3350_CHRG_CAPPG	BIT(5)	/* The capacitor voltage is above powe=
r good threshold */
> +#define LTC3350_CHRG_SHNT	BIT(6)	/* The capacitor manager is shunting */
> +#define LTC3350_CHRG_BAL	BIT(7)	/* The capacitor manager is balancing */
> +#define LTC3350_CHRG_DIS	BIT(8)	/* Charger disabled for capacitance meas=
urement */
> +#define LTC3350_CHRG_CI		BIT(9)	/* The charger is in constant current mo=
de */
> +#define LTC3350_CHRG_PFO	BIT(11)	/* Input voltage is below PFI threshold=
 */
> +
> +/* LTC3350_REG_MON_STATUS */
> +#define LTC3350_MON_CAPESR_ACTIVE	BIT(0)	/* Capacitance/ESR measurement =
in progress */
> +#define LTC3350_MON_CAPESR_SCHEDULED	BIT(1)	/* Waiting programmed time */
> +#define LTC3350_MON_CAPESR_PENDING	BIT(2)	/* Waiting for satisfactory co=
nditions */
> +#define LTC3350_MON_CAP_DONE		BIT(3)	/* Capacitance measurement has comp=
leted */
> +#define LTC3350_MON_ESR_DONE		BIT(4)	/* ESR Measurement has completed */
> +#define LTC3350_MON_CAP_FAILED		BIT(5)	/* Last capacitance measurement f=
ailed */
> +#define LTC3350_MON_ESR_FAILED		BIT(6)	/* Last ESR measurement failed */
> +#define LTC3350_MON_POWER_FAILED	BIT(8)	/* Unable to charge */
> +#define LTC3350_MON_POWER_RETURNED	BIT(9)	/* Able to charge */
> +
> +
> +struct ltc3350_info {
> +	struct i2c_client	*client;
> +	struct regmap		*regmap;
> +	struct power_supply	*charger;
> +	struct power_supply	*capacitor;
> +	u32 rsnsc;	/* Series resistor that sets charge current, microOhm */
> +	u32 rsnsi;	/* Series resistor to measure input current, microOhm */
> +};
> +
> +/*
> + * About LTC3350 "alarm" functions: Setting a bit in the LTC3350_REG_MSK=
_ALARMS
> + * register enables the alarm. The alarm will trigger an SMBALERT only o=
nce.
> + * To reset the alarm, write a "1" bit to LTC3350_REG_CLR_ALARMS. Then t=
he alarm
> + * will trigger another SMBALERT when conditions are met (may be immedia=
tely).
> + * After writing to one of the corresponding level registers, enable the=
 alarm,
> + * so that a UEVENT triggers when the alarm goes off.
> + */
> +static void ltc3350_enable_alarm(struct ltc3350_info *info, unsigned int=
 reg)
> +{
> +	unsigned int mask;
> +
> +	/* Register locations correspond to alarm mask bits */
> +	mask =3D BIT(reg - LTC3350_REG_CAP_UV_LVL);
> +	/* Clear the alarm bit so it may trigger again */
> +	regmap_write(info->regmap, LTC3350_REG_CLR_ALARMS, mask);
> +	/* Enable the alarm */
> +	regmap_update_bits(info->regmap, LTC3350_REG_MSK_ALARMS, mask, mask);
> +}
> +
> +/* Convert enum value to POWER_SUPPLY_STATUS value */
> +static int ltc3350_state_decode(unsigned int value)
> +{
> +	if (value & LTC3350_CHRG_STEPUP)
> +		return POWER_SUPPLY_STATUS_DISCHARGING; /* running on backup */
> +
> +	if (value & LTC3350_CHRG_PFO)
> +		return POWER_SUPPLY_STATUS_NOT_CHARGING;
> +
> +	if (value & LTC3350_CHRG_STEPDOWN) {
> +		if (value & LTC3350_CHRG_CAPPG)
> +			return POWER_SUPPLY_STATUS_FULL;
> +
> +		return POWER_SUPPLY_STATUS_CHARGING;
> +	}
> +
> +	/* Not in step down? Must be full then (never seen this) */
> +	return POWER_SUPPLY_STATUS_FULL;
> +};
> +
> +static int ltc3350_get_status(struct ltc3350_info *info, union power_sup=
ply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC3350_REG_CHRG_STATUS, &regval);
> +	if (ret)
> +		return ret;
> +
> +	val->intval =3D ltc3350_state_decode(regval);
> +
> +	return 0;
> +}
> +
> +static int ltc3350_charge_status_decode(unsigned int value)
> +{
> +	if (!(value & LTC3350_CHRG_STEPDOWN))
> +		return POWER_SUPPLY_CHARGE_TYPE_NONE;
> +
> +	/* constant voltage is "topping off" */
> +	if (value & LTC3350_CHRG_CV)
> +		return POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +
> +	/* input limiter */
> +	if (value & LTC3350_CHRG_INPUT_ILIM)
> +		return POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE;
> +
> +	/* constant current is "fast" */
> +	if (value & LTC3350_CHRG_CI)
> +		return POWER_SUPPLY_CHARGE_TYPE_FAST;
> +
> +	return POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
> +}
> +
> +static int ltc3350_get_charge_type(struct ltc3350_info *info, union powe=
r_supply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC3350_REG_CHRG_STATUS, &regval);
> +	if (ret)
> +		return ret;
> +
> +	val->intval =3D ltc3350_charge_status_decode(regval);
> +
> +	return 0;
> +}
> +
> +static int ltc3350_get_online(struct ltc3350_info *info, union power_sup=
ply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC3350_REG_MON_STATUS, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* indicates if input voltage is sufficient to charge */
> +	val->intval =3D !!(regval & LTC3350_MON_POWER_RETURNED);
> +
> +	return 0;
> +}
> +
> +static int ltc3350_get_scaled(struct ltc3350_info *info, unsigned int re=
g,
> +			      int scale, int *value)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, reg, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The "scale" here is 10 =CE=BCV per LSB, this allows all calculations=
 to
> +	 * be done in 32-bit integer without overflow. This converts the
> +	 * register value to =CE=BCV.
> +	 */
> +	*value =3D sign_extend32(regval, 15) * scale / 10;
> +
> +	return 0;
> +}
> +
> +static int ltc3350_set_scaled(struct ltc3350_info *info, unsigned int re=
g, int scale, int value)
> +{
> +	int ret;
> +
> +	value *=3D 10;
> +	value =3D DIV_ROUND_CLOSEST(value, scale);
> +
> +	ret =3D regmap_write(info->regmap, reg, value);
> +	if (ret)
> +		return ret;
> +
> +	/* When writing to one of the LVL registers, update the alarm mask */
> +	if (reg >=3D LTC3350_REG_CAP_UV_LVL && reg <=3D LTC3350_REG_CAP_LO_LVL)
> +		ltc3350_enable_alarm(info, reg);
> +
> +	return 0;
> +}
> +
> +static int ltc3350_get_input_current(struct ltc3350_info *info, union po=
wer_supply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC3350_REG_MEAS_IIN, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* 1.983=C2=B5V/RSNSI amperes per LSB */
> +	ret =3D sign_extend32(regval, 15) * 19830;
> +	ret /=3D (int)info->rsnsi;
> +	ret *=3D 100;
> +
> +	val->intval =3D ret;
> +
> +	return 0;
> +}
> +
> +static int ltc3350_get_icharge(struct ltc3350_info *info, union power_su=
pply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC3350_REG_MEAS_ICHG, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* 1.983=C2=B5V/RSNSC amperes per LSB */
> +	ret =3D sign_extend32(regval, 15) * 19830;
> +	ret /=3D (int)info->rsnsc;
> +	ret *=3D 100;
> +
> +	val->intval =3D ret;
> +
> +	return 0;
> +}
> +
> +static int ltc3350_get_icharge_max(struct ltc3350_info *info, union powe=
r_supply_propval *val)
> +{
> +	/* I_CHG(MAX) =3D 32mV / RSNSC (Ampere) */
> +	val->intval =3D 3200000000U / (info->rsnsc / 10);
> +
> +	return 0;
> +}
> +
> +static int ltc3350_get_iin_max(struct ltc3350_info *info, union power_su=
pply_propval *val)
> +{
> +	/* I_IN(MAX) =3D 32mV / RSNSI (Ampere) */
> +	val->intval =3D 3200000000U / (info->rsnsi / 10);
> +
> +	return 0;
> +}
> +
> +
> +static int ltc3350_get_die_temp(struct ltc3350_info *info, unsigned int =
reg,
> +				union power_supply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, reg, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* 0.028=C2=B0C per LSB =E2=80=93 251.4=C2=B0C */
> +	ret =3D 280 * sign_extend32(regval, 15);
> +	ret /=3D 100; /* Centidegrees scale */
> +	ret -=3D 25140;
> +	val->intval =3D ret;
> +
> +	return 0;
> +}
> +
> +static int ltc3350_set_die_temp(struct ltc3350_info *info, unsigned int =
reg, int val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	/* 0.028=C2=B0C per LSB =E2=80=93 251.4=C2=B0C */
> +	regval =3D val + 25140;
> +	regval *=3D 100;
> +	regval /=3D 280;
> +
> +	ret =3D regmap_write(info->regmap, reg, regval);
> +	if (ret)
> +		return ret;
> +
> +	ltc3350_enable_alarm(info, reg);
> +	return 0;
> +}
> +
> +static int ltc3350_get_num_caps(struct ltc3350_info *info, union power_s=
upply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC3350_REG_NUM_CAPS, &regval);
> +	if (ret)
> +		return ret;
> +
> +	val->intval =3D regval + 1;
> +
> +	return 0;
> +}
> +
> +
> +/* Custom properties */
> +static ssize_t ltc3350_attr_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf,
> +				 unsigned int reg, int scale)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
> +	int value;
> +	int ret;
> +
> +	ret =3D ltc3350_get_scaled(info, reg, scale, &value);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", value);
> +}
> +
> +static ssize_t ltc3350_attr_store(struct device *dev, struct device_attr=
ibute *attr,
> +				  const char *buf, size_t count,
> +				  unsigned int reg, unsigned int scale)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
> +	unsigned long val;
> +	int ret;
> +
> +	ret =3D kstrtoul(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ltc3350_set_scaled(info, reg, scale, val);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +#define LTC3350_DEVICE_ATTR_RO(_name, _reg, _scale)				\
> +static ssize_t _name##_show(struct device *dev, struct device_attribute =
*attr,	\
> +			    char *buf)						\
> +{										\
> +	return ltc3350_attr_show(dev, attr, buf, _reg, _scale);			\
> +}										\
> +static DEVICE_ATTR_RO(_name)
> +
> +#define LTC3350_DEVICE_ATTR_RW(_name, _reg, _scale)				\
> +static ssize_t _name##_show(struct device *dev, struct device_attribute =
*attr,	\
> +			    char *buf)						\
> +{										\
> +	return ltc3350_attr_show(dev, attr, buf, _reg, _scale);			\
> +}										\
> +static ssize_t _name##_store(struct device *dev, struct device_attribute=
 *attr, \
> +			     const char *buf, size_t count)			\
> +{										\
> +	return ltc3350_attr_store(dev, attr, buf, count, _reg, _scale);		\
> +}										\
> +static DEVICE_ATTR_RW(_name)
> +
> +/* Shunt voltage, 183.5=CE=BCV per LSB */
> +LTC3350_DEVICE_ATTR_RW(vshunt, LTC3350_REG_VSHUNT, 1835);
> +
> +/* General purpose input, 183.5=CE=BCV per LSB */
> +LTC3350_DEVICE_ATTR_RO(gpi, LTC3350_REG_MEAS_GPI, 1835);
> +LTC3350_DEVICE_ATTR_RW(gpi_uv, LTC3350_REG_GPI_UV_LVL, 1835);
> +LTC3350_DEVICE_ATTR_RW(gpi_ov, LTC3350_REG_GPI_OV_LVL, 1835);
> +
> +/* Input voltage, 2.21mV per LSB */
> +LTC3350_DEVICE_ATTR_RO(vin, LTC3350_REG_MEAS_VIN, 22100);
> +LTC3350_DEVICE_ATTR_RW(vin_uv, LTC3350_REG_VIN_UV_LVL, 22100);
> +LTC3350_DEVICE_ATTR_RW(vin_ov, LTC3350_REG_VIN_OV_LVL, 22100);
> +
> +static ssize_t charge_status_show(struct device *dev, struct device_attr=
ibute *attr, char *buf)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC3350_REG_CHRG_STATUS, &regval);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "0x%x\n", regval);
> +}
> +static DEVICE_ATTR_RO(charge_status);
> +
> +static struct attribute *ltc3350_sysfs_entries[] =3D {
> +	&dev_attr_vshunt.attr,
> +	&dev_attr_gpi.attr,
> +	&dev_attr_gpi_uv.attr,
> +	&dev_attr_gpi_ov.attr,
> +	&dev_attr_vin.attr,
> +	&dev_attr_vin_uv.attr,
> +	&dev_attr_vin_ov.attr,
> +	&dev_attr_charge_status.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ltc3350_attr_group =3D {
> +	.name	=3D NULL,	/* put in device directory */
> +	.attrs	=3D ltc3350_sysfs_entries,
> +};
> +
> +static const struct attribute_group *ltc3350_attr_groups[] =3D {
> +	&ltc3350_attr_group,
> +	NULL,
> +};
> +
> +static int ltc3350_get_property(struct power_supply *psy, enum power_sup=
ply_property psp,
> +				union power_supply_propval *val)
> +{
> +	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		return ltc3350_get_status(info, val);
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		return ltc3350_get_charge_type(info, val);
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		return ltc3350_get_online(info, val);
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		return ltc3350_get_scaled(info, LTC3350_REG_MEAS_VOUT, 22100, &val->in=
tval);
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		return ltc3350_get_scaled(info, LTC3350_REG_VOUT_UV_LVL, 22100, &val->=
intval);
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> +		return ltc3350_get_scaled(info, LTC3350_REG_VOUT_OV_LVL, 22100, &val->=
intval);

For USB chargers VOLTAGE_NOW/MIN/MAX refers to VBUS, which is the
voltage on the USB lines and thus the input voltage. From my
understanding of the LTC3350 this would be VIN and not VOUT. With
VOUT being supplied by either VIN or the Capacitors.

So I think your custom vin/vin_uv/vin_ov should be exposed with the
above properties.

My understanding for VOUT is, that this is basically the system
supply - I would expect more regulators to follow, which convert
it to typical voltages like 3.3V or 1.8V. In that case it would
make sense to expose VOUT as regulator, so that it can be referenced
as vin-supply. You can find a few examples for charger drivers doing
that for USB-OTG functionality.

> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		return ltc3350_get_input_current(info, val);
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		return ltc3350_get_icharge_max(info, val);
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		return ltc3350_get_iin_max(info, val);
> +	case POWER_SUPPLY_PROP_TEMP:
> +		return ltc3350_get_die_temp(info, LTC3350_REG_MEAS_DTEMP, val);
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> +		return ltc3350_get_die_temp(info, LTC3350_REG_DTEMP_COLD_LVL, val);
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> +		return ltc3350_get_die_temp(info, LTC3350_REG_DTEMP_HOT_LVL, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ltc3350_set_property(struct power_supply *psy, enum power_sup=
ply_property psp,
> +				const union power_supply_propval *val)
> +{
> +	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> +		return ltc3350_set_die_temp(info, LTC3350_REG_DTEMP_COLD_LVL, val->int=
val);
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> +		return ltc3350_set_die_temp(info, LTC3350_REG_DTEMP_HOT_LVL, val->intv=
al);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ltc3350_property_is_writeable(struct power_supply *psy, enum =
power_supply_property psp)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> +	case POWER_SUPPLY_PROP_CELL_VOLTAGE_MIN:
> +	case POWER_SUPPLY_PROP_CELL_VOLTAGE_MAX:
> +		return 1;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +/* Charger power supply property routines */
> +static enum power_supply_property ltc3350_properties[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
> +	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
> +};
> +
> +static const struct power_supply_desc ltc3350_desc =3D {
> +	.name		=3D "ltc3350",
> +	.type		=3D POWER_SUPPLY_TYPE_MAINS,
> +	.properties	=3D ltc3350_properties,
> +	.num_properties	=3D ARRAY_SIZE(ltc3350_properties),
> +	.get_property	=3D ltc3350_get_property,
> +	.set_property	=3D ltc3350_set_property,
> +	.property_is_writeable =3D ltc3350_property_is_writeable,
> +};
> +
> +static int ltc3350_capacitor_get_property(struct power_supply *psy, enum=
 power_supply_property psp,
> +					  union power_supply_propval *val)
> +{
> +	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		return ltc3350_get_status(info, val);
> +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> +		val->intval =3D POWER_SUPPLY_TECHNOLOGY_CAPACITOR;
> +		return 0;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		/* Capacitor stack voltage, 1.476 mV per LSB */
> +		return ltc3350_get_scaled(info, LTC3350_REG_MEAS_VCAP, 14760, &val->in=
tval);
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		return ltc3350_get_scaled(info, LTC3350_REG_VCAP_UV_LVL, 14760, &val->=
intval);
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> +		return ltc3350_get_scaled(info, LTC3350_REG_VCAP_OV_LVL, 14760, &val->=
intval);
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		return ltc3350_get_icharge(info, val);
> +	case POWER_SUPPLY_PROP_NUMBER_OF_SERIAL_CELLS:
> +		return ltc3350_get_num_caps(info, val);
> +	case POWER_SUPPLY_PROP_CELL1_VOLTAGE_NOW:
> +		/* Single capacitor voltages, 183.5=CE=BCV per LSB */
> +		return ltc3350_get_scaled(info, LTC3350_REG_MEAS_VCAP1, 1835, &val->in=
tval);
> +	case POWER_SUPPLY_PROP_CELL2_VOLTAGE_NOW:
> +		return ltc3350_get_scaled(info, LTC3350_REG_MEAS_VCAP2, 1835, &val->in=
tval);
> +	case POWER_SUPPLY_PROP_CELL3_VOLTAGE_NOW:
> +		return ltc3350_get_scaled(info, LTC3350_REG_MEAS_VCAP3, 1835, &val->in=
tval);
> +	case POWER_SUPPLY_PROP_CELL4_VOLTAGE_NOW:
> +		return ltc3350_get_scaled(info, LTC3350_REG_MEAS_VCAP4, 1835, &val->in=
tval);
> +	case POWER_SUPPLY_PROP_CELL_VOLTAGE_MIN:
> +		return ltc3350_get_scaled(info, LTC3350_REG_CAP_UV_LVL, 1835, &val->in=
tval);
> +	case POWER_SUPPLY_PROP_CELL_VOLTAGE_MAX:
> +		return ltc3350_get_scaled(info, LTC3350_REG_CAP_OV_LVL, 1835, &val->in=
tval);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ltc3350_capacitor_set_property(struct power_supply *psy, enum=
 power_supply_property psp,
> +					  const union power_supply_propval *val)
> +{
> +	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		return ltc3350_set_scaled(info, LTC3350_REG_VCAP_UV_LVL, 14760, val->i=
ntval);
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> +		return ltc3350_set_scaled(info, LTC3350_REG_VCAP_OV_LVL, 14760, val->i=
ntval);
> +	case POWER_SUPPLY_PROP_CELL_VOLTAGE_MIN:
> +		return ltc3350_set_scaled(info, LTC3350_REG_CAP_UV_LVL, 1835, val->int=
val);
> +	case POWER_SUPPLY_PROP_CELL_VOLTAGE_MAX:
> +		return ltc3350_set_scaled(info, LTC3350_REG_CAP_OV_LVL, 1835, val->int=
val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static enum power_supply_property ltc3350_capacitor_properties[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_NUMBER_OF_SERIAL_CELLS,
> +	POWER_SUPPLY_PROP_CELL1_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CELL2_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CELL3_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CELL4_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CELL_VOLTAGE_MIN,
> +	POWER_SUPPLY_PROP_CELL_VOLTAGE_MAX,
> +};
> +
> +static const struct power_supply_desc ltc3350_capacitor_desc =3D {
> +	.name		=3D "ltc3350_capacitor",
> +	.type		=3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties	=3D ltc3350_capacitor_properties,
> +	.num_properties	=3D ARRAY_SIZE(ltc3350_capacitor_properties),
> +	.get_property	=3D ltc3350_capacitor_get_property,
> +	.set_property	=3D ltc3350_capacitor_set_property,
> +	.property_is_writeable =3D ltc3350_property_is_writeable,
> +};
> +
> +static char *ltc3350_supply_interface_capacitor[] =3D { "ltc3350_capacit=
or" };
> +
> +static bool ltc3350_is_writeable_reg(struct device *dev, unsigned int re=
g)
> +{
> +	/* all registers up to this one are writeable */
> +	return reg < LTC3350_REG_NUM_CAPS;
> +}
> +
> +static bool ltc3350_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	/* read-only status registers and self-clearing register */
> +	return reg > LTC3350_REG_NUM_CAPS || reg =3D=3D LTC3350_REG_CLR_ALARMS;
> +}
> +
> +static const struct regmap_config ltc3350_regmap_config =3D {
> +	.reg_bits	=3D 8,
> +	.val_bits	=3D 16,
> +	.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
> +	.writeable_reg	=3D ltc3350_is_writeable_reg,
> +	.volatile_reg	=3D ltc3350_is_volatile_reg,
> +	.max_register	=3D LTC3350_REG_MEAS_DTEMP,
> +	.cache_type	=3D REGCACHE_MAPLE,
> +};
> +
> +static int ltc3350_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct ltc3350_info *info;
> +	struct power_supply_config ltc3350_config =3D {};
> +	int ret;
> +
> +	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->client =3D client;
> +	i2c_set_clientdata(client, info);
> +
> +	info->regmap =3D devm_regmap_init_i2c(client, &ltc3350_regmap_config);
> +	if (IS_ERR(info->regmap))
> +		return dev_err_probe(dev, PTR_ERR(info->regmap),
> +				     "Failed to initialize register map\n");
> +
> +	ret =3D device_property_read_u32(dev, "lltc,rsnsc-micro-ohms",
> +				       &info->rsnsc);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Missing lltc,rsnsc-micro-ohms property=
\n");
> +
> +	if (!info->rsnsc)
> +		return -EINVAL;
> +
> +	ret =3D device_property_read_u32(dev, "lltc,rsnsi-micro-ohms",
> +				       &info->rsnsi);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Missing lltc,rsnsi-micro-ohms property=
\n");
> +
> +	if (!info->rsnsi)
> +		return -EINVAL;
> +
> +	/* Clear and disable all interrupt sources*/
> +	ret =3D regmap_write(info->regmap, LTC3350_REG_CLR_ALARMS, 0xFFFF);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write configuration\n");
> +
> +	regmap_write(info->regmap, LTC3350_REG_MSK_ALARMS, 0);
> +	regmap_write(info->regmap, LTC3350_REG_MSK_MON_STATUS, 0);
> +
> +	ltc3350_config.fwnode =3D dev_fwnode(dev);
> +	ltc3350_config.drv_data =3D info;
> +	info->capacitor =3D devm_power_supply_register(dev, &ltc3350_capacitor_=
desc, &ltc3350_config);
> +	if (IS_ERR(info->capacitor)) {
> +		dev_err(dev, "Failed to register capacitor\n");
> +		return PTR_ERR(info->capacitor);
> +	}
> +
> +	ltc3350_config.supplied_to =3D ltc3350_supply_interface_capacitor;
> +	ltc3350_config.num_supplicants =3D ARRAY_SIZE(ltc3350_supply_interface_=
capacitor);
> +	ltc3350_config.attr_grp =3D ltc3350_attr_groups;
> +	info->charger =3D devm_power_supply_register(dev, &ltc3350_desc, &ltc33=
50_config);
> +	if (IS_ERR(info->charger)) {
> +		dev_err(dev, "Failed to register charger\n");
> +		return PTR_ERR(info->charger);
> +	}
> +
> +	/* Enable interrupts on status changes */
> +	regmap_write(info->regmap, LTC3350_REG_MSK_MON_STATUS,
> +		     LTC3350_MON_POWER_FAILED | LTC3350_MON_POWER_RETURNED);
> +
> +	return 0;
> +}
> +
> +static void ltc3350_alert(struct i2c_client *client, enum i2c_alert_prot=
ocol type,
> +			  unsigned int flag)
> +{
> +	struct ltc3350_info *info =3D i2c_get_clientdata(client);
> +
> +	if (type !=3D I2C_PROTOCOL_SMBUS_ALERT)
> +		return;
> +
> +	power_supply_changed(info->charger);
> +}
> +
> +static const struct i2c_device_id ltc3350_i2c_id_table[] =3D {
> +	{ "ltc3350", 0 },

please drop the 0.

> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, ltc3350_i2c_id_table);
> +
> +static const struct of_device_id ltc3350_of_match[] =3D {
> +	{ .compatible =3D "lltc,ltc3350", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ltc3350_of_match);
> +
> +static struct i2c_driver ltc3350_driver =3D {
> +	.probe		=3D ltc3350_probe,
> +	.alert		=3D ltc3350_alert,
> +	.id_table	=3D ltc3350_i2c_id_table,
> +	.driver =3D {
> +		.name		=3D "ltc3350-charger",
> +		.of_match_table	=3D ltc3350_of_match,
> +	},
> +};
> +module_i2c_driver(ltc3350_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
> +MODULE_DESCRIPTION("LTC3350 charger driver");

Greetings,

-- Sebastian

--kmp6tfkrsdbvpndl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZU79IACgkQ2O7X88g7
+pp9Dw/+N0bbVycQGZNFsdrt9np4/G5UIjx6rWrO5hLb01qWDHkN5Au5rIAESdva
0ls0s0fwXRIxf1NeOxS+GEwt/aJXs10keF7n5Qt8bElp4NMQEdl4LJIzNE3YHTjJ
YBz6IHJj7H1KgNhuq0wu30YyJmyIS580TyPdRAsR2vY/LUEfFiERp/RHAK9XvhQ+
hWVmdT97vYnrS2YsdObLUpieXtwT7RmYjQp3jx060E7xt/H4lhB8u910KIB6ditA
h32oABi83OHCDnHzdcj9UPoMhwQeGq/3QeQLiu9VEXpo+/h6OZviLegGjUozBRaP
JlFKvOGUto010idQjvaeSEVLqZLY1hL7YTPj4Sp7MyJmd5eYDfawIaqyAEG781mb
TUNhIqvqGcH2xWVBY3aRR2kE6MuqYBlG/VxnucvHsNSRDy161crefV4ob2oVVjGe
A85AT3iDGIRh6K4mPHtvxarpldOnt4yGOedQxh9P1vv5YRnIXkq3cle3N0iqYZY7
1zUW/eRaV8cehCAGIR1IGWKjgv3/6k9LXGqY1dlYEP3n/tb75nS2ihOck+NuS1e6
vYF7VK3X66jiQyBzOVQlCrFRMXhkgEmJ+epG0sO7hOh4oIyclILpUlqdarPZvZrF
sBqixuGV+3nQk51g0yfzsftZsElCaqYXOBveBhHQOQjvIC4W5uc=
=E9Fr
-----END PGP SIGNATURE-----

--kmp6tfkrsdbvpndl--

