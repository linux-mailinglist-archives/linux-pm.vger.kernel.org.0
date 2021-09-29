Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0F441C1B8
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 11:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245097AbhI2Jj6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 05:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60727 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245091AbhI2Jj6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 05:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632908297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a2VLRqIeQMjxdhXChG02+zBG9Ub9Twsnh9MImIQkR/c=;
        b=Mu0SM/pmGUo9+X74hlmiPiHqzmEiVJSzxVoyfEzv1RbTd2/x6btSzXxBHMGuIqMQVufS0B
        BxhhO9VdpAXdUar+bJyMagSoHRTm2/VG/wUuojoHRrHX609Ycht3i/nbe4JEKQeeeMsMMt
        U6gZqUwSMBV4g7yE5Ic/8uyX0kjkDX4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-XD8QCpoUNCWgkwR2gZWbNg-1; Wed, 29 Sep 2021 05:38:15 -0400
X-MC-Unique: XD8QCpoUNCWgkwR2gZWbNg-1
Received: by mail-ed1-f72.google.com with SMTP id z6-20020a50cd06000000b003d2c2e38f1fso1824058edi.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 02:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a2VLRqIeQMjxdhXChG02+zBG9Ub9Twsnh9MImIQkR/c=;
        b=bAynsndOQq+7a0+xioHfBd0QWy5Ma4MiJSO3uJB1WxCh/oOxAirmruIXq2RmaqcHPJ
         LicrWMahG/0crYKkXDHBJvYs7JWikounPxbyPOaHN5gKYqKzL9aQC580MbSMCFlOjfA/
         qTHd6bbDHuSxebTiJebLFqE0iQYQjqXvnmOnhER0YIiiDSJ85DLO7nMzX0U18LBo/00N
         K7D9dSmhIXQjM1ZjBzqaxnhrpAkbB7VyzTfMoB32zcwyzWXGF/AR+/JLQBRSvF64C2qh
         iNlBqKcPnkgXDWaKRGRg03T+V5ECvOB3Wr2mAtt/PciVjfAoWYKNtwOe94LH3EMvAyX2
         mAnw==
X-Gm-Message-State: AOAM532XseSeD7Ztfr5SlCiiTz8ycjRF2zCN1Ohsx8rhRWOmXUwYZF4U
        2SDLPF+GizTC5dQnZlhMvIiNLQgfUY7bQux0uPgH5nQ5qCGoJIUsY9JxsfvJ1zK1FxvhfEnwu5v
        dgDRG4KHYG+20LXDkmQA=
X-Received: by 2002:a50:9d49:: with SMTP id j9mr13265803edk.39.1632908293597;
        Wed, 29 Sep 2021 02:38:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRfSVCIAdDZnCC26aPSj1/BggBi+9ozAXUqI2G8dfol8PLMfmrcvmbuXLCr/aa/3YEFJMEAQ==
X-Received: by 2002:a50:9d49:: with SMTP id j9mr13265787edk.39.1632908293427;
        Wed, 29 Sep 2021 02:38:13 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id dk27sm1137855edb.19.2021.09.29.02.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 02:38:12 -0700 (PDT)
Subject: Re: [RFC] add standardized attributes for force_discharge and
 inhibit_charge
To:     =?UTF-8?Q?Nicol=c3=b2_Piazzalunga?= <nicolopiazzalunga@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Thomas Koch <linrunner@gmx.net>,
        "smclt30p@gmail.com" <smclt30p@gmail.com>
References: <21569a89-8303-8573-05fb-c2fec29983d1@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <77e39b3e-fa51-54fe-1898-4f43895ac2c6@redhat.com>
Date:   Wed, 29 Sep 2021 11:38:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <21569a89-8303-8573-05fb-c2fec29983d1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 9/28/21 10:11 PM, Nicolò Piazzalunga wrote:
> Hi Sebastian,
> 
> this is a proposal to introduce separate and standardized attributes
> for force_discharge and inhibit_charge of a battery.
> These are simpler than using status from a user-space perspective,
> as discussed on the platform-driver-x86 mail list.

To clarify things a bit here, the reasons for not using status for
this are:

1. This would require adding new status-es which so far have never
been seen by userspace, which will likely cause confusion of e.g.
upower. IOW I believe that adding new status-es for this would
be a userspace ABI break.

2. The devices where we currently want to use this functionality
use the ACPI battery interface, which is standardized between
vendors and dealt with by drivers/apci/battery.c  but this kinda
extra functionality is vendor specific. The drivers/apci/battery.c
has code allowing vendor drivers to "hook" ACPI batteries and get
add/remove calls for them. Then in these calls currently the
vendor drivers do:

	device_add_groups(&battery->dev, my_prop_group))

Which allows them to register extra sysfs_attributes for
for example charge_control_start_threshold and
charge_control_end_threshold.

This works well, but having vendor drivers somehow intercept /
muck with the status handling in drivers/apci/battery.c is a
non trival problem. Where as with new separate attributes
this is already a solved problem.

> ---
>  Documentation/ABI/testing/sysfs-class-power | 27 +++++++++++++++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  2 ++
>  include/linux/power_supply.h                |  2 ++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index ca830c6cd809..2c5f48f49273 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -455,6 +455,33 @@ Description:
>  			      "Unknown", "Charging", "Discharging",
>  			      "Not charging", "Full"
>  
> +What:		/sys/class/power_supply/<supply_name>/force_discharge
> +Date:		September 2021
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Represents the forced discharging status of the battery.
> +
> +		Access: Read, Write
> +
> +		Valid values:
> +			== ====================================
> +			0: Force discharge while AC is attached
> +			1: Terminate forced discharging
> +

I think you have 0 and 1 swapped here? I would expect 1 to be enable forced
discharging and 0 be normal operation, iow only discharge when not on AC.

> +What:		/sys/class/power_supply/<supply_name>/inhibit_charge
> +Date:		September 2021
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Represents the presence of a manual override over the threshold
> +		attributes of the battery, thus inhibiting battery charge.
> +
> +		Access: Read, Write
> +
> +		Valid values:
> +			== ======================
> +			1: Stop charging
> +			0: Terminate the override
> +
>  What:		/sys/class/power_supply/<supply_name>/technology
>  Date:		May 2007
>  Contact:	linux-pm@vger.kernel.org
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index c3d7cbcd4fad..6e7303935810 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -136,6 +136,8 @@ static const char * const POWER_SUPPLY_SCOPE_TEXT[] = {
>  static struct power_supply_attr power_supply_attrs[] = {
>  	/* Properties of type `int' */
>  	POWER_SUPPLY_ENUM_ATTR(STATUS),
> +	POWER_SUPPLY_ENUM_ATTR(FORCE_DISCHARGE),
> +	POWER_SUPPLY_ENUM_ATTR(INHIBIT_CHARGE),
>  	POWER_SUPPLY_ENUM_ATTR(CHARGE_TYPE),
>  	POWER_SUPPLY_ENUM_ATTR(HEALTH),
>  	POWER_SUPPLY_ATTR(PRESENT),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 9ca1f120a211..4340fe65df4d 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -96,6 +96,8 @@ enum {
>  enum power_supply_property {
>  	/* Properties of type `int' */
>  	POWER_SUPPLY_PROP_STATUS = 0,
> +	POWER_SUPPLY_PROP_FORCE_DISCHARGE,
> +	POWER_SUPPLY_PROP_INHIBIT_CHARGE,
>  	POWER_SUPPLY_PROP_CHARGE_TYPE,
>  	POWER_SUPPLY_PROP_HEALTH,
>  	POWER_SUPPLY_PROP_PRESENT,
> 

Regards,

Hans

