Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE86F1F07A6
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jun 2020 17:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgFFPpS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Jun 2020 11:45:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58757 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726968AbgFFPpR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 6 Jun 2020 11:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591458315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJQzV0rdN7ALnL6NeYYp172fRlPbPlchooy6Ga8Vcnw=;
        b=hdWfJjyv+qpTD95utnbVggtkePgX7CNyj9QZWTdGduImB6TzY9AWYSkiCNKMxKBwWAgup0
        hVgg/ncIdOCVrOYtcXU2mLdl9zI80gcwCurBEI0pZeVcwP3xKsBkFPObpAr1HYAa5syaJf
        kFnHnhe3RNwAIzdm+UJfPKFLpMGt4qg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-sYtX0IxZOHeA8eWgfXHM-Q-1; Sat, 06 Jun 2020 11:45:13 -0400
X-MC-Unique: sYtX0IxZOHeA8eWgfXHM-Q-1
Received: by mail-wr1-f70.google.com with SMTP id p10so5180627wrn.19
        for <linux-pm@vger.kernel.org>; Sat, 06 Jun 2020 08:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VJQzV0rdN7ALnL6NeYYp172fRlPbPlchooy6Ga8Vcnw=;
        b=VkZ1Z/hdpnd2jmGlau6fhHRVoHPAjz5ypDopVTpeEXx2vjjPqjsJoAt/9qWYR0VwBU
         Qre7RxiCC7ry+QIJUTUqK7OmGjFOrs0eUU3tx4QmM0p+ROxuZ7WgNg8IyAkyaYrEFIb/
         mtWE+GwPkPW2tSkp6eV45230N8AG5fATDdj+CzGfXevUGw+w6x1gUiTBEtLMMSVBMT93
         P/PHs1Ew2yBqI3HBGO4/bIDDJdYlJXxMevYQuMuqZyTQEjWKiKVgS+JWFg7ZL91sk3g1
         Td0pM41CbHDkj5gv9ykTb0BlKoCZn8StEif6gXQMT/FjUUXWbGL5Fn9x3+/a9VLGQmSd
         csfg==
X-Gm-Message-State: AOAM532dgWqHRv2HFnCxLcZPQDAXjbEsONz2VoMuAn5jZ8fVr2KMgDm3
        QT5ULC+S7uv6IwUsvhlQlBz7ETG9AY+/jruE0EFYkfjRcimgqApjphHjWGvzjmpibsB8vSn5m0j
        DmqsrAqs/3dq+TBp+mhc=
X-Received: by 2002:a1c:3987:: with SMTP id g129mr7911380wma.139.1591458311908;
        Sat, 06 Jun 2020 08:45:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCDW5eisq+hVdc/k8mWioQT6xTsFq1sXcnNLuRMkVzcYDUxMLASfVmmPO56Y+qGXj0fQVHZA==
X-Received: by 2002:a1c:3987:: with SMTP id g129mr7911353wma.139.1591458311579;
        Sat, 06 Jun 2020 08:45:11 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id t14sm18219200wrb.94.2020.06.06.08.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2020 08:45:10 -0700 (PDT)
Subject: Re: [PATCH] ACPI: PM: Avoid using power resources if there are none
 for D0
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        youling257@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20200603194659.185757-1-hdegoede@redhat.com>
 <CAJZ5v0g7rhiWs0ZeGGS5OoSMH7DiVT1D-EUgX5HFXYkcvXcm2Q@mail.gmail.com>
 <d084b424-a340-a24a-d681-c92d80d8421d@redhat.com>
 <13388608.OHKVb9tm6R@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fddf7e38-cbc3-e923-9e4c-fe4f9903f24e@redhat.com>
Date:   Sat, 6 Jun 2020 17:45:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <13388608.OHKVb9tm6R@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 6/4/20 7:22 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> As recently reported, some platforms provide a list of power
> resources for device power state D3hot, through the _PR3 object,
> but they do not provide a list of power resources for device power
> state D0.
> 
> Among other things, this causes acpi_device_get_power() to return
> D3hot as the current state of the device in question if all of the
> D3hot power resources are "on", because it sees the power_resources
> flag set and calls acpi_power_get_inferred_state() which finds that
> D3hot is the shallowest power state with all of the associated power
> resources turned "on", so that's what it returns.  Moreover, that
> value takes precedence over the acpi_dev_pm_explicit_get() return
> value, because it means a deeper power state.  The device may very
> well be in D0 physically at that point, however.
> 
> Moreover, the presence of _PR3 without _PR0 for a given device
> means that only one D3-level power state can be supported by it.
> Namely, because there are no power resources to turn "off" when
> transitioning the device from D0 into D3cold (which should be
> supported since _PR3 is present), the evaluation of _PS3 should
> be sufficient to put it straight into D3cold, but this means that
> the effect of turning "on" the _PR3 power resources is unclear,
> so it is better to avoid doing that altogether.  Consequently,
> there is no practical way do distinguish D3cold from D3hot for
> the device in question and the power states of it can be labeled
> so that D3hot is the deepest supported one (and Linux assumes
> that putting a device into D3hot via ACPI may cause power to be
> removed from it anyway, for legacy reasons).
> 
> To work around the problem described above modify the ACPI
> enumeration of devices so that power resources are only used
> for device power management if the list of D0 power resources
> is not empty and make it mart D3cold as supported only if that
> is the case and the D3hot list of power resources is not empty
> too.
> 
> Fixes: ef85bdbec444 ("ACPI / scan: Consolidate extraction of power resources lists")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=205057
> Link: https://lore.kernel.org/linux-acpi/20200603194659.185757-1-hdegoede@redhat.com/
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Cc: 3.10+ <stable@vger.kernel.org> # 3.10+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thank you.

I've tested this and I can confirm that it fixes the issue:

Tested-by: Hans de Goede <hdegoede@redhat.com>

I've also looked at the code and it looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





> ---
>   drivers/acpi/device_pm.c |    2 +-
>   drivers/acpi/scan.c      |   28 +++++++++++++++++++---------
>   2 files changed, 20 insertions(+), 10 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -919,12 +919,9 @@ static void acpi_bus_init_power_state(st
>   
>   		if (buffer.length && package
>   		    && package->type == ACPI_TYPE_PACKAGE
> -		    && package->package.count) {
> -			int err = acpi_extract_power_resources(package, 0,
> -							       &ps->resources);
> -			if (!err)
> -				device->power.flags.power_resources = 1;
> -		}
> +		    && package->package.count)
> +			acpi_extract_power_resources(package, 0, &ps->resources);
> +
>   		ACPI_FREE(buffer.pointer);
>   	}
>   
> @@ -971,14 +968,27 @@ static void acpi_bus_get_power_flags(str
>   		acpi_bus_init_power_state(device, i);
>   
>   	INIT_LIST_HEAD(&device->power.states[ACPI_STATE_D3_COLD].resources);
> -	if (!list_empty(&device->power.states[ACPI_STATE_D3_HOT].resources))
> -		device->power.states[ACPI_STATE_D3_COLD].flags.valid = 1;
>   
> -	/* Set defaults for D0 and D3hot states (always valid) */
> +	/* Set the defaults for D0 and D3hot (always supported). */
>   	device->power.states[ACPI_STATE_D0].flags.valid = 1;
>   	device->power.states[ACPI_STATE_D0].power = 100;
>   	device->power.states[ACPI_STATE_D3_HOT].flags.valid = 1;
>   
> +	/*
> +	 * Use power resources only if the D0 list of them is populated, because
> +	 * some platforms may provide _PR3 only to indicate D3cold support and
> +	 * in those cases the power resources list returned by it may be bogus.
> +	 */
> +	if (!list_empty(&device->power.states[ACPI_STATE_D0].resources)) {
> +		device->power.flags.power_resources = 1;
> +		/*
> +		 * D3cold is supported if the D3hot list of power resources is
> +		 * not empty.
> +		 */
> +		if (!list_empty(&device->power.states[ACPI_STATE_D3_HOT].resources))
> +			device->power.states[ACPI_STATE_D3_COLD].flags.valid = 1;
> +	}
> +
>   	if (acpi_bus_init_power(device))
>   		device->flags.power_manageable = 0;
>   }
> Index: linux-pm/drivers/acpi/device_pm.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/device_pm.c
> +++ linux-pm/drivers/acpi/device_pm.c
> @@ -186,7 +186,7 @@ int acpi_device_set_power(struct acpi_de
>   		 * possibly drop references to the power resources in use.
>   		 */
>   		state = ACPI_STATE_D3_HOT;
> -		/* If _PR3 is not available, use D3hot as the target state. */
> +		/* If D3cold is not supported, use D3hot as the target state. */
>   		if (!device->power.states[ACPI_STATE_D3_COLD].flags.valid)
>   			target_state = state;
>   	} else if (!device->power.states[state].flags.valid) {
> 
> 
> 

