Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0962D4BFF
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 21:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgLIUhG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 15:37:06 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:19459 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbgLIUhG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 15:37:06 -0500
X-Greylist: delayed 114110 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Dec 2020 15:37:04 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607546052;
        s=strato-dkim-0002; d=fossekall.de;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:From:
        Subject:Sender;
        bh=NW8oMEoZejP9UrMPWLz8vivLgh1kG3lHr/CL5F7qKGU=;
        b=O0ZB2yySXnQ5EfKnaTpty+9h9soBE31QbSPI8csivHKVyNTaMsAe8gs4nipEusgG9l
        GVqfu7OvDA4PAswKszFOIJbqrEu/Hr1sH4fcBoIwKP8YOobRjzZqKgu2ocS9+HfXhJci
        ATiNlfxDiz74MNev7MoqvIVVSpMayfj4ftCSUJAVyAnRw1owbcdQPewlnC3//2ST7KzP
        8umVu4WZA6d98RPUwktNmXOu+XOCzzZ/dBo2W2T67lDiUsAp1MPAhQJ4RZeBYCcJV6no
        3wY5X3p0piOteXx1yEWWDb69c63pp37O8zZVlJjjFYP7Fl4e9KoYpx6Tenr/NTicknSt
        vGhg==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.6.2 AUTH)
        with ESMTPSA id e07b38wB9KY2Aqh
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Wed, 9 Dec 2020 21:34:02 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <michael@fossekall.de>)
        id 1kn69x-00077t-G0; Wed, 09 Dec 2020 21:34:01 +0100
Date:   Wed, 9 Dec 2020 21:34:00 +0100
From:   Michael Klein <michael@fossekall.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] power: reset: new driver regulator-poweroff
Message-ID: <20201209203400.GA108307@a98shuttle.de>
References: <20201128103958.q6glewhhch7vtczr@gilmour>
 <20201207142756.17819-1-michael@fossekall.de>
 <20201207142756.17819-2-michael@fossekall.de>
 <20201208101052.ecq2hbixxi45h4mr@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201208101052.ecq2hbixxi45h4mr@gilmour>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 08, 2020 at 11:10:52AM +0100, Maxime Ripard wrote:
>On Mon, Dec 07, 2020 at 03:27:54PM +0100, Michael Klein wrote:
>> This driver registers a pm_power_off function to disable a set of
>> regulators defined in the devicetree to turn off the board.
>>
>> Signed-off-by: Michael Klein <michael@fossekall.de>
>> ---
>>  drivers/power/reset/Kconfig              |   7 ++
>>  drivers/power/reset/Makefile             |   1 +
>>  drivers/power/reset/regulator-poweroff.c | 107 +++++++++++++++++++++++
>>  3 files changed, 115 insertions(+)
>>  create mode 100644 drivers/power/reset/regulator-poweroff.c
>>
>> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
>> index d55b3727e00e..ae6cb7b0bd4d 100644
>> --- a/drivers/power/reset/Kconfig
>> +++ b/drivers/power/reset/Kconfig
>> @@ -177,6 +177,13 @@ config POWER_RESET_QNAP
>>
>>  	  Say Y if you have a QNAP NAS.
>>
>> +config POWER_RESET_REGULATOR
>> +	bool "Regulator subsystem power-off driver"
>> +	depends on OF && REGULATOR
>> +	help
>> +	  This driver supports turning off your board by disabling a set
>> +	  of regulators defined in the devicetree.
>> +
>>  config POWER_RESET_RESTART
>>  	bool "Restart power-off driver"
>>  	help
>> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
>> index c51eceba9ea3..9dc49d3a57ff 100644
>> --- a/drivers/power/reset/Makefile
>> +++ b/drivers/power/reset/Makefile
>> @@ -19,6 +19,7 @@ obj-$(CONFIG_POWER_RESET_OCELOT_RESET) += ocelot-reset.o
>>  obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) += piix4-poweroff.o
>>  obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
>>  obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
>> +obj-$(CONFIG_POWER_RESET_REGULATOR) += regulator-poweroff.o
>>  obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
>>  obj-$(CONFIG_POWER_RESET_ST) += st-poweroff.o
>>  obj-$(CONFIG_POWER_RESET_VERSATILE) += arm-versatile-reboot.o
>> diff --git a/drivers/power/reset/regulator-poweroff.c b/drivers/power/reset/regulator-poweroff.c
>> new file mode 100644
>> index 000000000000..df2ca4fdcc49
>> --- /dev/null
>> +++ b/drivers/power/reset/regulator-poweroff.c
>> @@ -0,0 +1,107 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Force-disables a regulator to power down a device
>> + *
>> + * Michael Klein <michael@fossekall.de>
>> + *
>> + * Copyright (C) 2020 Michael Klein
>> + *
>> + * Based on the gpio-poweroff driver.
>> + */
>> +#include <linux/delay.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +#define DEFAULT_TIMEOUT_MS 3000
>> +
>> +/*
>> + * Hold configuration here, cannot be more than one instance of the driver
>> + * since pm_power_off itself is global.
>> + */
>> +static struct regulator **poweroff_regulators;
>> +static u32 timeout = DEFAULT_TIMEOUT_MS;
>> +
>> +static void regulator_poweroff_do_poweroff(void)
>> +{
>> +	struct regulator **it;
>> +
>> +	if (poweroff_regulators)
>> +		for (it = poweroff_regulators; *it; ++it)
>> +			if (regulator_is_enabled(*it))
>> +				regulator_force_disable(*it);
>> +
>> +	/* give it some time */
>> +	mdelay(timeout);
>> +
>> +	WARN_ON(1);
>> +}
>> +
>> +static int regulator_poweroff_probe(struct platform_device *pdev)
>> +{
>> +	int count;
>> +	const char *name;
>> +	struct regulator **it;
>> +	struct property *prop;
>> +	struct device_node *node = pdev->dev.of_node;
>> +
>> +	/* If a pm_power_off function has already been added, leave it alone */
>> +	if (pm_power_off != NULL) {
>> +		dev_err(&pdev->dev,
>> +			"%s: pm_power_off function already registered\n",
>> +		       __func__);
>> +		return -EBUSY;
>> +	}
>> +
>> +	count = of_property_count_strings(node, "regulator-names");
>> +	if (count <= 0)
>> +		return -ENOENT;
>> +
>> +	poweroff_regulators = devm_kcalloc(&pdev->dev, count + 1,
>> +		sizeof(struct regulator *), GFP_KERNEL);
>> +
>> +	it = poweroff_regulators;
>> +	of_property_for_each_string(node, "regulator-names", prop, name) {
>> +		*it = devm_regulator_get(&pdev->dev, name);
>> +		if (IS_ERR(*it))
>> +			return PTR_ERR(*it);
>> +		it++;
>> +	}
>> +
>> +	of_property_read_u32(node, "timeout-ms", &timeout);
>> +
>> +	pm_power_off = &regulator_poweroff_do_poweroff;
>> +	return 0;
>> +}
>> +
>> +static int regulator_poweroff_remove(__maybe_unused struct platform_device *pdev)
>> +{
>> +	if (pm_power_off == &regulator_poweroff_do_poweroff)
>> +		pm_power_off = NULL;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id of_regulator_poweroff_match[] = {
>> +	{ .compatible = "regulator-poweroff", },
>> +	{},
>> +};
>> +
>> +static struct platform_driver regulator_poweroff_driver = {
>> +	.probe = regulator_poweroff_probe,
>> +	.remove = regulator_poweroff_remove,
>> +	.driver = {
>> +		.name = "poweroff-regulator",
>> +		.of_match_table = of_regulator_poweroff_match,
>> +	},
>> +};
>> +
>> +module_platform_driver(regulator_poweroff_driver);
>
>Since this can't be compiled as a module, you can use
>module_platform_driver_probe instead.

actually no, as platform_driver_probe() does not support deferred 
probing and the regulator might not be available during 
regulator_poweroff_probe() yet:

# dmesg | grep poweroff
[    0.788135] poweroff-regulator poweroff: probe deferral not supported

-- 
Michael
