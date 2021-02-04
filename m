Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E81F30FB7D
	for <lists+linux-pm@lfdr.de>; Thu,  4 Feb 2021 19:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239106AbhBDS3t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 13:29:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59363 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239083AbhBDS3J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 13:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612463262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bgQhr2F2iWGQLtH9Fikx9Lr/KlJCKowpxuZEQeaIbIk=;
        b=OyeEgzmvDs4MIsL2UsVmWzOZRMvjJN4YcLeUJQ4BwCVzoE3ajDY8MKjLpr3XCkiKgeKxTa
        buj+Ug+S1dm93++V7pZtFdAq9YzoxWe7vFtdOgf3ncyhc8e7fceDT9E4IYhBMiXztoZ2Lo
        wYVf9gv2xz5/y/LTP3ty1dfYvllYixs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-VLSumFWrMRerslSeRlXRSg-1; Thu, 04 Feb 2021 13:27:40 -0500
X-MC-Unique: VLSumFWrMRerslSeRlXRSg-1
Received: by mail-ed1-f72.google.com with SMTP id b1so3620571edt.22
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2021 10:27:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bgQhr2F2iWGQLtH9Fikx9Lr/KlJCKowpxuZEQeaIbIk=;
        b=aiaFtXolmCx9cCNvuB4g6mSxPFG0ZV6/3t3cOogjenbQgAYS/r061BBtSJvlr5yyDp
         4wScf7rTjwwPvwq3Ngtq7McRmxbIRzTFHJpqHYo5+DdmJu+8OhPdFS3i5p75TCAwQIW+
         1vYLVmEuvnf08bRTQXsr8DmFbsn6tHHOBB3L1TbJz/DI+5KYXb88p07TCfF/uNFPOTK7
         hMW1J7rh4Ossxz5p3vNMammZusfHWDK9+KrPGAaBuh6lAN9CRPMfP2Ky8FVo4seuVIn9
         tgb/rYkTaUh/+yoXbszFAEh1y1RAhLAZ3MVt3lkac6qOHy/VIskYcVb7BPrhI4Dvg6Ax
         zLnw==
X-Gm-Message-State: AOAM53019N6y1B2GU+MB+1AuyuDZPJEULaqhNlDe5+b5P/a+GL3FoKfu
        iFzkZEVkARDCLi+F9dWSSuaF3p5YQDr2fbJjfIQvqC/MBLflmFpp5btoulxLCcacp6ZqjVPgjdl
        wJNjR28UKRtLHA54AxTA=
X-Received: by 2002:a17:906:e106:: with SMTP id gj6mr366033ejb.337.1612463259255;
        Thu, 04 Feb 2021 10:27:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7EHttt3Ocd9Um49oN8bi+MGMe8Aenc72i4nYwgueWCXVsUO9BQN9mkLPSJXZLI9oq4d/yRg==
X-Received: by 2002:a17:906:e106:: with SMTP id gj6mr366017ejb.337.1612463259068;
        Thu, 04 Feb 2021 10:27:39 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id bf8sm2945126edb.34.2021.02.04.10.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 10:27:38 -0800 (PST)
Subject: Re: [PATCH v3 2/5] ACPI: battery: Clean up printing messages
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Joe Perches <joe@perches.com>,
        Hanjun Guo <guohanjun@huawei.com>
References: <2367702.B5bJTmGzJm@kreacher> <1991501.dpTHplkurC@kreacher>
 <1961054.9MKZ8ejxOh@kreacher> <1731128.lCOlkKr4QW@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3ca5dcaa-094a-9f4f-a802-81c54a681c96@redhat.com>
Date:   Thu, 4 Feb 2021 19:27:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1731128.lCOlkKr4QW@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 2/3/21 7:44 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace the ACPI_DEBUG_PRINT() and ACPI_EXCEPTION() instances
> in battery.c with acpi_handle_debug() and acpi_handle_info() calls,
> respectively, which among other things causes the excessive log
> level of the messages previously printed via ACPI_EXCEPTION() to
> be increased.
> 
> Drop the _COMPONENT and ACPI_MODULE_NAME() definitions that are not
> used any more, drop the no longer needed ACPI_BATTERY_COMPONENT
> definition from the headers and update the documentation accordingly.
> 
> While at it, update the pr_fmt() definition and drop the unneeded
> PREFIX sybmbol definition from battery.c.  Also adapt the existing
> pr_info() calls to the new pr_fmt() definition.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3: Also adapt the existing pr_info() calls to the new pr_fmt()
>           definition.
> 
> v1 -> v2: Changelog update.
> 
> ---
>  Documentation/firmware-guide/acpi/debug.rst |    1 
>  drivers/acpi/battery.c                      |   33 +++++++++++++---------------
>  drivers/acpi/sysfs.c                        |    1 
>  include/acpi/acpi_drivers.h                 |    1 
>  4 files changed, 16 insertions(+), 20 deletions(-)
> 
> Index: linux-pm/drivers/acpi/battery.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/battery.c
> +++ linux-pm/drivers/acpi/battery.c
> @@ -8,7 +8,7 @@
>   *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#define pr_fmt(fmt) "ACPI: battery: " fmt
>  
>  #include <linux/async.h>
>  #include <linux/delay.h>
> @@ -29,8 +29,6 @@
>  
>  #include <acpi/battery.h>
>  
> -#define PREFIX "ACPI: "
> -
>  #define ACPI_BATTERY_VALUE_UNKNOWN 0xFFFFFFFF
>  #define ACPI_BATTERY_CAPACITY_VALID(capacity) \
>  	((capacity) != 0 && (capacity) != ACPI_BATTERY_VALUE_UNKNOWN)
> @@ -44,10 +42,6 @@
>  #define ACPI_BATTERY_STATE_CHARGING	0x2
>  #define ACPI_BATTERY_STATE_CRITICAL	0x4
>  
> -#define _COMPONENT		ACPI_BATTERY_COMPONENT
> -
> -ACPI_MODULE_NAME("battery");
> -
>  MODULE_AUTHOR("Paul Diefenbaugh");
>  MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse.de>");
>  MODULE_DESCRIPTION("ACPI Battery Driver");
> @@ -466,7 +460,8 @@ static int extract_package(struct acpi_b
>  static int acpi_battery_get_status(struct acpi_battery *battery)
>  {
>  	if (acpi_bus_get_status(battery->device)) {
> -		ACPI_EXCEPTION((AE_INFO, AE_ERROR, "Evaluating _STA"));
> +		acpi_handle_info(battery->device->handle,
> +				 "_STA evaluation failed\n");

Missing ": %s", acpi_format_exception(status), or is that intentional
(I did not see this mentioned in the commit msg) ?

With that fixed, or explained, this is:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




>  		return -ENODEV;
>  	}
>  	return 0;
> @@ -535,8 +530,10 @@ static int acpi_battery_get_info(struct
>  		mutex_unlock(&battery->lock);
>  
>  		if (ACPI_FAILURE(status)) {
> -			ACPI_EXCEPTION((AE_INFO, status, "Evaluating %s",
> -					use_bix ? "_BIX":"_BIF"));
> +			acpi_handle_info(battery->device->handle,
> +					 "%s evaluation failed: %s\n",
> +					 use_bix ?"_BIX":"_BIF",
> +				         acpi_format_exception(status));
>  		} else {
>  			result = extract_battery_info(use_bix,
>  						      battery,
> @@ -573,7 +570,9 @@ static int acpi_battery_get_state(struct
>  	mutex_unlock(&battery->lock);
>  
>  	if (ACPI_FAILURE(status)) {
> -		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BST"));
> +		acpi_handle_info(battery->device->handle,
> +				 "_BST evaluation failed: %s",
> +				 acpi_format_exception(status));
>  		return -ENODEV;
>  	}
>  
> @@ -590,7 +589,7 @@ static int acpi_battery_get_state(struct
>  		battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
>  		(s16)(battery->rate_now) < 0) {
>  		battery->rate_now = abs((s16)battery->rate_now);
> -		pr_warn_once(FW_BUG "battery: (dis)charge rate invalid.\n");
> +		pr_warn_once(FW_BUG "(dis)charge rate invalid.\n");
>  	}
>  
>  	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags)
> @@ -625,7 +624,9 @@ static int acpi_battery_set_alarm(struct
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>  
> -	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Alarm set to %d\n", battery->alarm));
> +	acpi_handle_debug(battery->device->handle, "Alarm set to %d\n",
> +			  battery->alarm);
> +
>  	return 0;
>  }
>  
> @@ -1201,8 +1202,7 @@ static int acpi_battery_add(struct acpi_
>  	if (result)
>  		goto fail;
>  
> -	pr_info(PREFIX "%s Slot [%s] (battery %s)\n",
> -		ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
> +	pr_info("Slot [%s] (battery %s)\n", acpi_device_bid(device),
>  		device->status.battery_present ? "present" : "absent");
>  
>  	battery->pm_nb.notifier_call = battery_notify;
> @@ -1282,8 +1282,7 @@ static void __init acpi_battery_init_asy
>  	if (battery_check_pmic) {
>  		for (i = 0; i < ARRAY_SIZE(acpi_battery_blacklist); i++)
>  			if (acpi_dev_present(acpi_battery_blacklist[i], "1", -1)) {
> -				pr_info(PREFIX ACPI_BATTERY_DEVICE_NAME
> -					": found native %s PMIC, not loading\n",
> +				pr_info("found native %s PMIC, not loading\n",
>  					acpi_battery_blacklist[i]);
>  				return;
>  			}
> Index: linux-pm/Documentation/firmware-guide/acpi/debug.rst
> ===================================================================
> --- linux-pm.orig/Documentation/firmware-guide/acpi/debug.rst
> +++ linux-pm/Documentation/firmware-guide/acpi/debug.rst
> @@ -52,7 +52,6 @@ shows the supported mask values, current
>      ACPI_CA_DISASSEMBLER            0x00000800
>      ACPI_COMPILER                   0x00001000
>      ACPI_TOOLS                      0x00002000
> -    ACPI_BATTERY_COMPONENT          0x00040000
>      ACPI_BUTTON_COMPONENT           0x00080000
>      ACPI_SBS_COMPONENT              0x00100000
>      ACPI_FAN_COMPONENT              0x00200000
> Index: linux-pm/drivers/acpi/sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/sysfs.c
> +++ linux-pm/drivers/acpi/sysfs.c
> @@ -52,7 +52,6 @@ static const struct acpi_dlayer acpi_deb
>  	ACPI_DEBUG_INIT(ACPI_COMPILER),
>  	ACPI_DEBUG_INIT(ACPI_TOOLS),
>  
> -	ACPI_DEBUG_INIT(ACPI_BATTERY_COMPONENT),
>  	ACPI_DEBUG_INIT(ACPI_BUTTON_COMPONENT),
>  	ACPI_DEBUG_INIT(ACPI_SBS_COMPONENT),
>  	ACPI_DEBUG_INIT(ACPI_FAN_COMPONENT),
> Index: linux-pm/include/acpi/acpi_drivers.h
> ===================================================================
> --- linux-pm.orig/include/acpi/acpi_drivers.h
> +++ linux-pm/include/acpi/acpi_drivers.h
> @@ -15,7 +15,6 @@
>   * Please update drivers/acpi/debug.c and Documentation/firmware-guide/acpi/debug.rst
>   * if you add to this list.
>   */
> -#define ACPI_BATTERY_COMPONENT		0x00040000
>  #define ACPI_BUTTON_COMPONENT		0x00080000
>  #define ACPI_SBS_COMPONENT		0x00100000
>  #define ACPI_FAN_COMPONENT		0x00200000
> 
> 
> 

