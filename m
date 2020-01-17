Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F07AB140F15
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 17:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgAQQgy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 11:36:54 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41968 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgAQQgx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 11:36:53 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9F7F12946EA
Subject: Re: [PATCH v7 3/3] power: supply: cros-ec-usbpd-charger: Fix host
 events
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Prashant Malani <pmalani@chromium.org>
Cc:     groeck@chromium.org, bleung@chromium.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Jon Flatley <jflat@chromium.org>
References: <20200117002820.56872-1-pmalani@chromium.org>
 <20200117002820.56872-3-pmalani@chromium.org>
 <20200117011216.p7etrc6oarptmhcb@earth.universe>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <cc46a6a3-706e-06df-882f-10e66cf89735@collabora.com>
Date:   Fri, 17 Jan 2020 17:36:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200117011216.p7etrc6oarptmhcb@earth.universe>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 17/1/20 2:12, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Jan 16, 2020 at 04:28:24PM -0800, Prashant Malani wrote:
>> From: Jon Flatley <jflat@chromium.org>
>>
>> There's a bug on ACPI platforms where host events from the ECPD ACPI
>> device never make their way to the cros-ec-usbpd-charger driver. This
>> makes it so the only time the charger driver updates its state is when
>> user space accesses its sysfs attributes.
>>
>> Now that these events have been unified into a single notifier chain on
>> both ACPI and non-ACPI platforms, update the charger driver to use this
>> new notifier.
>>
>> Reviewed-by: Benson Leung <bleung@chromium.org>
>> Co-Developed-by: Prashant Malani <pmalani@chromium.org>
>> Signed-off-by: Jon Flatley <jflat@chromium.org>
>> Signed-off-by: Prashant Malani <pmalani@chromium.org>
>> ---
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> I currently have one cros_usbpd-charger patch queued in -next.
> This patch looks like it should not create conflicts, but it's
> probably better to merge an immutable branch.
> 

I still have some concerns on the platform/chrome side and I have some problems
with this driver testing it on Samsung Chromebook Plus (kevin). So it is not
ready yet to merge, I'll create an im when ready.

Thanks,
 Enric

> -- Sebastian
> 
>>
>> Changes in v7(pmalani@chromium.org):
>> - Alphabetize #include header.
>>
>> Changes in v6(pmalani@chromium.org):
>> - Patch first introduced into the series in v6.
>>
>>  drivers/power/supply/Kconfig              |  2 +-
>>  drivers/power/supply/cros_usbpd-charger.c | 50 ++++++++---------------
>>  2 files changed, 19 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>> index 27164a1d3c7c4..ba74ddd793c3d 100644
>> --- a/drivers/power/supply/Kconfig
>> +++ b/drivers/power/supply/Kconfig
>> @@ -659,7 +659,7 @@ config CHARGER_RT9455
>>  
>>  config CHARGER_CROS_USBPD
>>  	tristate "ChromeOS EC based USBPD charger"
>> -	depends on CROS_EC
>> +	depends on CROS_USBPD_NOTIFY
>>  	default n
>>  	help
>>  	  Say Y here to enable ChromeOS EC based USBPD charger
>> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
>> index 6cc7c3910e098..7eea080048f43 100644
>> --- a/drivers/power/supply/cros_usbpd-charger.c
>> +++ b/drivers/power/supply/cros_usbpd-charger.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/module.h>
>>  #include <linux/platform_data/cros_ec_commands.h>
>>  #include <linux/platform_data/cros_ec_proto.h>
>> +#include <linux/platform_data/cros_usbpd_notify.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/power_supply.h>
>>  #include <linux/slab.h>
>> @@ -524,32 +525,21 @@ static int cros_usbpd_charger_property_is_writeable(struct power_supply *psy,
>>  }
>>  
>>  static int cros_usbpd_charger_ec_event(struct notifier_block *nb,
>> -				       unsigned long queued_during_suspend,
>> +				       unsigned long host_event,
>>  				       void *_notify)
>>  {
>> -	struct cros_ec_device *ec_device;
>> -	struct charger_data *charger;
>> -	u32 host_event;
>> +	struct charger_data *charger = container_of(nb, struct charger_data,
>> +						    notifier);
>>  
>> -	charger = container_of(nb, struct charger_data, notifier);
>> -	ec_device = charger->ec_device;
>> -
>> -	host_event = cros_ec_get_host_event(ec_device);
>> -	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
>> -		cros_usbpd_charger_power_changed(charger->ports[0]->psy);
>> -		return NOTIFY_OK;
>> -	} else {
>> -		return NOTIFY_DONE;
>> -	}
>> +	cros_usbpd_charger_power_changed(charger->ports[0]->psy);
>> +	return NOTIFY_OK;
>>  }
>>  
>>  static void cros_usbpd_charger_unregister_notifier(void *data)
>>  {
>>  	struct charger_data *charger = data;
>> -	struct cros_ec_device *ec_device = charger->ec_device;
>>  
>> -	blocking_notifier_chain_unregister(&ec_device->event_notifier,
>> -					   &charger->notifier);
>> +	cros_usbpd_unregister_notify(&charger->notifier);
>>  }
>>  
>>  static int cros_usbpd_charger_probe(struct platform_device *pd)
>> @@ -683,21 +673,17 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
>>  		goto fail;
>>  	}
>>  
>> -	if (ec_device->mkbp_event_supported) {
>> -		/* Get PD events from the EC */
>> -		charger->notifier.notifier_call = cros_usbpd_charger_ec_event;
>> -		ret = blocking_notifier_chain_register(
>> -						&ec_device->event_notifier,
>> -						&charger->notifier);
>> -		if (ret < 0) {
>> -			dev_warn(dev, "failed to register notifier\n");
>> -		} else {
>> -			ret = devm_add_action_or_reset(dev,
>> -					cros_usbpd_charger_unregister_notifier,
>> -					charger);
>> -			if (ret < 0)
>> -				goto fail;
>> -		}
>> +	/* Get PD events from the EC */
>> +	charger->notifier.notifier_call = cros_usbpd_charger_ec_event;
>> +	ret = cros_usbpd_register_notify(&charger->notifier);
>> +	if (ret < 0) {
>> +		dev_warn(dev, "failed to register notifier\n");
>> +	} else {
>> +		ret = devm_add_action_or_reset(dev,
>> +				cros_usbpd_charger_unregister_notifier,
>> +				charger);
>> +		if (ret < 0)
>> +			goto fail;
>>  	}
>>  
>>  	return 0;
>> -- 
>> 2.25.0.341.g760bfbb309-goog
>>
