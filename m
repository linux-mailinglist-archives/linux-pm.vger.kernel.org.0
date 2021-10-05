Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8DC422F8D
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 20:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhJESDL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 14:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54927 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231858AbhJESDK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 14:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633456879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VPT2lJtFqJ4PZ7OlneiKomZaGpFl1acLf3AN7VvJT+8=;
        b=bFm/VhzAQNitaM/rf9FYy4B/yRMAxlmYKUeOlHlNsHfB0LsEK0V1GWJ3u84a4whXnC8l0e
        KFoo2gbcBasJxr6w5iGeHjCCjtSEvZZyItvaWjcN+OFxiw3doObD8vvdoXpYLlb8wrnDhA
        Hk7QXpbm6qyzmJMSUmFk9jNx5AtDm/g=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-BwNO5RhjMp--XB2fGDkhWA-1; Tue, 05 Oct 2021 14:01:14 -0400
X-MC-Unique: BwNO5RhjMp--XB2fGDkhWA-1
Received: by mail-ed1-f72.google.com with SMTP id r21-20020a50c015000000b003db1c08edd3so1600354edb.15
        for <linux-pm@vger.kernel.org>; Tue, 05 Oct 2021 11:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VPT2lJtFqJ4PZ7OlneiKomZaGpFl1acLf3AN7VvJT+8=;
        b=khSmI4yZ9kASvpg3LdlL+hzSjTheledyS9yA86aBZYq85EzAfxdRX8blioeBXegZDp
         i9izdmsTCjCr06qELhU+DIrujIh8l12ZeazXMq8HsfT5tdJdqyVi9lKlWEoT2t1shw6B
         MVqsiToVvkdi8AmHujAp7pBOjQ817AdPPAuntQPl5Rjb+vxsxpLadhzI8QGPzCgzcXrv
         9vVo8EjqTzaepymE3h2jjeIeQlV8ykRPDt1qZKZ3IMG2WihpJkxO6TKbqNKD2+uWqEYQ
         B9mVu9g0AYUTEqgj7d5guMg6WUbOZHO6ak8dc4pPSCC9P5Q+TBEtxy+DdTr71ydjElv8
         QGEw==
X-Gm-Message-State: AOAM532e4qNKuRNXojC57FWJbBXGVSqY41WWZk4e5AV1dvMZ7OaPenWX
        dcCCxyTGnaqZEeYNw6pYy9P2OL6HabheXs9IUByaPwQQJUY4Vj0NBaKID2QX9yzBxmIf2meb7do
        tvqXgNGKNsYhKZcroRfs=
X-Received: by 2002:a50:e08a:: with SMTP id f10mr28618003edl.319.1633456873394;
        Tue, 05 Oct 2021 11:01:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrnrM5VTJgJtDmY8LQ3Wy9+91X7RjxF3T4JTssow6l9ZKGta+q9TNtyVdBTffFoWfreFIxKw==
X-Received: by 2002:a50:e08a:: with SMTP id f10mr28617976edl.319.1633456873145;
        Tue, 05 Oct 2021 11:01:13 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id m22sm4636513eds.19.2021.10.05.11.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 11:01:12 -0700 (PDT)
Subject: Re: [RFC] add standardized attributes for force_discharge and
 inhibit_charge
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     =?UTF-8?Q?Nicol=c3=b2_Piazzalunga?= <nicolopiazzalunga@gmail.com>,
        linux-pm@vger.kernel.org,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Thomas Koch <linrunner@gmx.net>,
        "smclt30p@gmail.com" <smclt30p@gmail.com>
References: <21569a89-8303-8573-05fb-c2fec29983d1@gmail.com>
 <77e39b3e-fa51-54fe-1898-4f43895ac2c6@redhat.com>
 <20211005162352.emaoveimhkp5uzfw@earth.universe>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <06fa7a23-4dec-cba9-4e00-c00cf0bf9337@redhat.com>
Date:   Tue, 5 Oct 2021 20:01:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211005162352.emaoveimhkp5uzfw@earth.universe>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 10/5/21 6:23 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Sep 29, 2021 at 11:38:12AM +0200, Hans de Goede wrote:
>> On 9/28/21 10:11 PM, Nicolò Piazzalunga wrote:
>>> this is a proposal to introduce separate and standardized attributes
>>> for force_discharge and inhibit_charge of a battery.
>>> These are simpler than using status from a user-space perspective,
>>> as discussed on the platform-driver-x86 mail list.
>>
>> To clarify things a bit here, the reasons for not using status for
>> this are:
>>
>> 1. This would require adding new status-es which so far have never
>> been seen by userspace, which will likely cause confusion of e.g.
>> upower. IOW I believe that adding new status-es for this would
>> be a userspace ABI break.
> 
> Some embedded devices have status writable and use existing status
> and reset when adapter is replugged. That's why there are no extra
> status already.

Right, so then a userspace process can write "Discharging" to the status
property to enable "forced discharge" mode, I get that.

And from then on any reads of status will read "Discharging" but how
does (another) userspace process now differentiate this forced
"Discharging" from normal discharging ? It cannot differentiate the
2 unless we add a new "Forced Discharging" status string which
comes with the problem of current userspace not being prepared to
deal with this status string.

Which IMHO makes this idea of overloading / adding this new usage
to status a not so great API, this seems like something which
the status attribute was never intended for.

>> 2. The devices where we currently want to use this functionality
>> use the ACPI battery interface, which is standardized between
>> vendors and dealt with by drivers/apci/battery.c  but this kinda
>> extra functionality is vendor specific. The drivers/apci/battery.c
>> has code allowing vendor drivers to "hook" ACPI batteries and get
>> add/remove calls for them. Then in these calls currently the
>> vendor drivers do:
>>
>> 	device_add_groups(&battery->dev, my_prop_group))
>>
>> Which allows them to register extra sysfs_attributes for
>> for example charge_control_start_threshold and
>> charge_control_end_threshold.
>>
>> This works well, but having vendor drivers somehow intercept /
>> muck with the status handling in drivers/apci/battery.c is a
>> non trival problem. Where as with new separate attributes
>> this is already a solved problem.
> 
> The second argument is a very weak one. We do not accept bad
> userspace API to avoid restructuring a driver.

I agree that this is a weak argument, but when possible solutions
are otherwise mostly equal, then easy and especially also cleanliness
of implementation definitely comes into play. We don't have an
infinite amount of developer time (the opposite actually).

> FWIW adding
> attributes that way is already racy and a bug:
> 
> http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/
> 
> The power-supply subsystem offers registering custom sysfs
> files since a few kernel releases by setting up the following:
> 
> /* Run-time specific power supply configuration */
> struct power_supply_config {
>     ...
>    	/* Device specific sysfs attributes */
> 	const struct attribute_group **attr_grp;
>     ...
> }
> 
> All drivers in drivers/power/supply/ have been converted and
> the ACPI is one of the last drivers not using this.
> 
>>> ---
>>>  Documentation/ABI/testing/sysfs-class-power | 27 +++++++++++++++++++++
>>>  drivers/power/supply/power_supply_sysfs.c   |  2 ++
>>>  include/linux/power_supply.h                |  2 ++
>>>  3 files changed, 31 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
>>> index ca830c6cd809..2c5f48f49273 100644
>>> --- a/Documentation/ABI/testing/sysfs-class-power
>>> +++ b/Documentation/ABI/testing/sysfs-class-power
>>> @@ -455,6 +455,33 @@ Description:
>>>  			      "Unknown", "Charging", "Discharging",
>>>  			      "Not charging", "Full"
>>>  
>>> +What:		/sys/class/power_supply/<supply_name>/force_discharge
>>> +Date:		September 2021
>>> +Contact:	linux-pm@vger.kernel.org
>>> +Description:
>>> +		Represents the forced discharging status of the battery.
>>> +
>>> +		Access: Read, Write
>>> +
>>> +		Valid values:
>>> +			== ====================================
>>> +			0: Force discharge while AC is attached
>>> +			1: Terminate forced discharging
>>> +
>>
>> I think you have 0 and 1 swapped here? I would expect 1 to be enable forced
>> discharging and 0 be normal operation, iow only discharge when not on AC.
> 
> Considering some Thinkpads have two batteries the naming and
> description of this is quite bad. Only the valid values part
> suggests that this is just about AC.
> 
>>> +What:		/sys/class/power_supply/<supply_name>/inhibit_charge
>>> +Date:		September 2021
>>> +Contact:	linux-pm@vger.kernel.org
>>> +Description:
>>> +		Represents the presence of a manual override over the threshold
>>> +		attributes of the battery, thus inhibiting battery charge.
> 
> The first part is specific to thinkpad implementation.
> 
>>> +
>>> +		Access: Read, Write
>>> +
>>> +		Valid values:
>>> +			== ======================
>>> +			1: Stop charging
>>> +			0: Terminate the override
>>> +
> 
> I wonder if its better to put both into the same file, considering
> that the only logical options are
> 
>  * 0 = no override (= charge when possible)
>  * 1 = force idle
>  * 2 = force discharge
> 
> I.e. forced discharge implies battery not being charged.

Right, force-discharge automatically implies charging is
being inhibited, so putting this in one file makes sense.

Any suggestion for the name of the file ?  

Regards,

Hans


>>>  What:		/sys/class/power_supply/<supply_name>/technology
>>>  Date:		May 2007
>>>  Contact:	linux-pm@vger.kernel.org
>>> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
>>> index c3d7cbcd4fad..6e7303935810 100644
>>> --- a/drivers/power/supply/power_supply_sysfs.c
>>> +++ b/drivers/power/supply/power_supply_sysfs.c
>>> @@ -136,6 +136,8 @@ static const char * const POWER_SUPPLY_SCOPE_TEXT[] = {
>>>  static struct power_supply_attr power_supply_attrs[] = {
>>>  	/* Properties of type `int' */
>>>  	POWER_SUPPLY_ENUM_ATTR(STATUS),
>>> +	POWER_SUPPLY_ENUM_ATTR(FORCE_DISCHARGE),
>>> +	POWER_SUPPLY_ENUM_ATTR(INHIBIT_CHARGE),
>>>  	POWER_SUPPLY_ENUM_ATTR(CHARGE_TYPE),
>>>  	POWER_SUPPLY_ENUM_ATTR(HEALTH),
>>>  	POWER_SUPPLY_ATTR(PRESENT),
>>> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
>>> index 9ca1f120a211..4340fe65df4d 100644
>>> --- a/include/linux/power_supply.h
>>> +++ b/include/linux/power_supply.h
>>> @@ -96,6 +96,8 @@ enum {
>>>  enum power_supply_property {
>>>  	/* Properties of type `int' */
>>>  	POWER_SUPPLY_PROP_STATUS = 0,
>>> +	POWER_SUPPLY_PROP_FORCE_DISCHARGE,
>>> +	POWER_SUPPLY_PROP_INHIBIT_CHARGE,
>>>  	POWER_SUPPLY_PROP_CHARGE_TYPE,
>>>  	POWER_SUPPLY_PROP_HEALTH,
>>>  	POWER_SUPPLY_PROP_PRESENT,
>>>
>>
>> Regards,
>>
>> Hans
>>

