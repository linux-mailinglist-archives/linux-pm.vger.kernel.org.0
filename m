Return-Path: <linux-pm+bounces-14522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7748497D684
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 15:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE051F217DD
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 13:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D66017B402;
	Fri, 20 Sep 2024 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdTHdwoX"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8935D156F2B
	for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2024 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726840678; cv=none; b=D1EvmK6H5zDYn244DN187KskL9I15U9FSeXrK6+9sNMRJp9RtfXpAte7BCOJVE6F4IJtY65Ypbw7rmvAOtHLrsU0eJ7fTBoatpWOxUc2oS6ObjcPF9T8r0G0L39dQ6fe1dH+2ypuX7hn4YuF1e1i7Evedky1j54U7z4i5KUeDio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726840678; c=relaxed/simple;
	bh=Ao6ZHfaspYnxO8tp9r0c0XJSgaK06chSBoE5pdrlFVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7sv2oFF2K+mCwKBEgWjqd/70pxrRLQilOuw6kQ5MkCM90/mpPLJaWosApC0EP+/dSQ/1rrGarjsH21A5Pv94LHMmsv0hE1S159jAa1xjJofkIOq5ue96I2uqPEKsAcOnplEhknOeQmgQerhob9DXwT3AQ7Gv52M988GkW8vo9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdTHdwoX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726840675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEFiNorbaSAvkWNVTL4WR8Lr6MpGBUEzbn7bF0noJiE=;
	b=cdTHdwoX3GrisJ6c2Ktk0393bhwBfTbGFCMytMOUZPlkLEDl6VCBa4ng2y6tCCm8cZcMJx
	XhuotlQSBtbSIObiIhW9CeZQES6IlKiBc75OUEnGGD6KMDah/UmlmQrS22nPtz8r5fPsbM
	PjDvQ8TnPT7Xnrlm64fm4O3AgWNjB+E=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-Xx4nG3bFODC0C-vdmyhXBw-1; Fri, 20 Sep 2024 09:57:54 -0400
X-MC-Unique: Xx4nG3bFODC0C-vdmyhXBw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2f760dce28bso15429971fa.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2024 06:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726840673; x=1727445473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEFiNorbaSAvkWNVTL4WR8Lr6MpGBUEzbn7bF0noJiE=;
        b=ogzA228jdOhvqAhbYoeNd6K59gZe00fJNO4Eab6rthTuKzcl8coi2Q1ovZT3MNMb54
         2x65dKffEHwH9NPy7pShlrCCDiQ6VC///ke/nZpR+nIzwhl9JUyVWQHlWO50iY2erKY4
         JDzFhgOjN51VhSiUBOj6xRamyrsc388hyKndlBR4eo43dUBhKb0ED1DrX9dY2ZCSnbnJ
         qKHN6Gr4fBMpDN+Aall5lxhJWfSPDj2x/r+Eds78rJdefu9pLqZpoSGYyLKdoarr2zEU
         /afBv+yIEwDh8FJj2npqTqxbdJTL8bVuIic3tK677DR5zIWCLbhqK3gj5tk3tlNVJ4d8
         t6YA==
X-Forwarded-Encrypted: i=1; AJvYcCX4+6rOG3AD5AFXQHNrsugJ9EWNcusz8Ck0RstHocPMNmWUJWPeMFSN4KC2BnjoTtuOJ/JNsP9whw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz34aL7rqveXDUV2WROAUIDk84pahhPi8XjfrnUNHZw5nsRIAGc
	7xKXzFyT57oBMjFccvFMBn4jVMCTGPvXgBBNipF925M9boSVBisU30PpAz+p7d3ZONdBZu6DZtE
	6sQx4Td1mfCn5FbORV+nSmMwbFzLvbpydCjApMnCRrgUOf8ygsbA6KBCj
X-Received: by 2002:a05:6512:3d05:b0:533:46cc:a736 with SMTP id 2adb3069b0e04-536ac32f1efmr1972541e87.37.1726840672631;
        Fri, 20 Sep 2024 06:57:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEs6iVqP+qbunDV6dCALFAn6IoqZpkEL0Wtg65AEHpiO4IfYE04DGWZsO4gNmxT9hxsKb/4A==
X-Received: by 2002:a05:6512:3d05:b0:533:46cc:a736 with SMTP id 2adb3069b0e04-536ac32f1efmr1972509e87.37.1726840672046;
        Fri, 20 Sep 2024 06:57:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5f4f1sm7244827a12.53.2024.09.20.06.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 06:57:51 -0700 (PDT)
Message-ID: <5616726c-bed3-46e6-86f5-a2cfe5b341bf@redhat.com>
Date: Fri, 20 Sep 2024 15:57:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: supply: sysfs: Make
 power_supply_show_enum_with_available() deal with labels with a space
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Jelle van der Waa <jelle@vdwaa.nl>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 linux-pm@vger.kernel.org
References: <20240908192303.151562-1-hdegoede@redhat.com>
 <20240908192303.151562-2-hdegoede@redhat.com>
 <2crw2apbxixaqq6vibtlewe47nvqeo2cnwo2okdiqtaelvtjce@g6mhr4iproiz>
 <599b59f6-6cd4-463d-aafb-699fcb387f7e@redhat.com>
 <z3it2whilcvdrzv56ignyn2h6i4l5rl6cy7ah7elwxahij2fpe@6pj6foq3vz3q>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <z3it2whilcvdrzv56ignyn2h6i4l5rl6cy7ah7elwxahij2fpe@6pj6foq3vz3q>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 20-Sep-24 3:52 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Sep 17, 2024 at 11:06:42AM GMT, Hans de Goede wrote:
>> Hi Sebastian,
>>
>> On 9/17/24 9:38 AM, Sebastian Reichel wrote:
>>> Hello Hans,
>>>
>>> On Sun, Sep 08, 2024 at 09:23:00PM GMT, Hans de Goede wrote:
>>>> Some enum style power-supply properties have text-values / labels for some
>>>> of the enum values containing a space, e.g. "Long Life" for
>>>> POWER_SUPPLY_CHARGE_TYPE_LONGLIFE.
>>>>
>>>> Make power_supply_show_enum_with_available() surround these label with ""
>>>> when the label is not for the active enum value to make it clear that this
>>>> is a single label and not 2 different labels for 2 different enum values.
>>>>
>>>> After this the output for a battery which support "Long Life" will be e.g.:
>>>>
>>>> Fast [Standard] "Long Life"
>>>>
>>>> or:
>>>>
>>>> Fast Standard [Long Life]
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>
>>> This looks annoying from parsing point of view. Maybe we can just
>>> replace " " with "_" and guarantee that space is a value separator
>>> at the cost of the values not being exactly the same as the existing
>>> charge_type sysfs file?
>>
>> My thinking here was that if a parser wants to see if a certain option
>> is available it can just do a strstr() and parsing for the active
>> value does not change. But yes a parser which wants to tokenize
>> the string to get all possible values as separate tokens will
>> become harder to write with this.
>>
>> I did consider moving to using a "_" one problem there is that
>> this means that echo-ing "Long_Life" to set the value should then
>> work. Which would require special handling in the generic store()
>> function. I guess we could makle 
>>
>> I guess an easy solution here would be to define a second set
>> of POWER_SUPPLY_CHARGE_TYPE_TEXT[] strings aptly named
>> POWER_SUPPLY_CHARGE_TYPES_TEXT[] (with the extra s).
>>
>> This can then simply contain Long_Life instead of Long Life,
>> downside of this would be that writing "Long Life" will then
>> not work. So charge_type then takes "Long Life" and charge_types
>> "Long_Life" which is less then ideal.
> 
> Also having two lists sounds error prone regarding going out of
> sync.
> 
>> The best I can come up with is to replace " " with _ when showing
>> and in power_supply_store_property() add some special handling for
>> charge_types like this:
>>
>> 	/* Accept "Long_Life" as alt for "Long Life" for "charge_types" */
>> 	if (dev_attr_psp(attr) == POWER_SUPPLY_PROP_CHARGE_TYPES &&
>> 	    sysfs_streq(buf, "Long_Life"))
>> 		buf = "Long Life";
>>
>> 	ret = -EINVAL;
>>         if (ps_attr->text_values_len > 0) {
>>                 ret = __sysfs_match_string(ps_attr->text_values,
>>                                            ps_attr->text_values_len, buf);
>>         }
> 
> That's ugly, but better than maintaining a second list IMHO.
> 
>> This isn't pretty, but this way we don't need to define a second set of
>> POWER_SUPPLY_CHARGE_TYPES_TEXT[] values, duplicating those (and needing
>> to manually keep them in sync), while accepting both "Long Life" and
>> "Long_Life".
>>
>> Note that a generic replacing of _ with space or the other way around
>> in store() will not work because we already allow/use "Not Charging"
>> but also "PD_DRP" so replacing either _ or space with the other will
>> break one of those.
> 
> We only replace " " with "_" on the output side for the code doing
> multi-value printing. I think on the write side accepting "Not_Charging"
> in addition to "Not Charging" is probably fine as long as we document
> that?

Right, the problem is how do we implement this since we rely on
__sysfs_match_string(), first try __sysfs_match_string() then on
failure, if input buf contains a space, copy the input buf,
replace space with _ in input buf and try again ?

That would be more generic then my hardcoded suggestion above,
so I'll take a shot at going that route for v2, when I can make
some time to work on v2.

>>> Do you know if there is prior examples for this in the kernel by
>>> chance?
>>
>> I'm not aware of any examples where a sysfs attr show() uses the show
>> all available values with the active one surrounding by [ ] where
>> one of the values has a space in it. It is quite easy to avoid the
>> values having spaces if this format is used from the start.
> 
> Then let's please avoid that :)
> 
> P.S.: Last message before my 3 week vacation on this patchset.
> Thomas Weißschuh said, that he might have some ideas and will sync
> with you next week.

Ok, enjoy your vacation.

Regards,

Hans



