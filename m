Return-Path: <linux-pm+bounces-13004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251259617A5
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 21:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BFF1C20349
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 19:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB6F1CDA3C;
	Tue, 27 Aug 2024 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpweFfaV"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19B3B677
	for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785468; cv=none; b=mq9jc5G6wZWDyz9dQiSdHZ6xJJl7WHQZ40+caajXwS3pD/QY/A1KJFX2O/kvXYUCphi1OvdG4QKzgIVrSBeyIS5m69W2mOep1WcK4rO4Wzj2gfm9OrwqM4qnmBBYxKuLapunzscRX4t+FHKfICgJ7LTCUGyAYm1pLrWAZDKs0S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785468; c=relaxed/simple;
	bh=xB+tRyst4h/JkZ6zWo+HspsZwigVOpyOfVR2Meo+9zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agJp+An2L2zYZkQMKV5jDQihTU461bwmdB/HxZEJwGmfoa0UAmIGEnCtgqFAUzaNF25Y0PTx+5Uw2rk/mZ/KLxKE1xEgoX2qPWzO3eObw6usxzLcVCzjIj6CQU6vG6wxQ4WM9MHcxP3JOjnqb9BVrizVXc5dVUl1LMcPl+vrr6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpweFfaV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724785466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HkWCAaDqu2XZmQMkoLU93xiUV6PoV/L38xqUed5LNOs=;
	b=cpweFfaVZCKCMEa+NU4qICQ4hlcG7A/qca/G5khysnq/8YV43PS4BIly2g0WeOrtZ9BXNe
	zn9jZ3BKmmT8w44OJDzH0DN+efGutu95lREy6v7KOrdslLcHcavJEcI9rHk8ojxRu9F7d5
	wcubaYWCwOMQUj5dadYg5yw8TaEy0Ws=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-fZSZZb8VNzez89_m6_jNhQ-1; Tue, 27 Aug 2024 15:04:24 -0400
X-MC-Unique: fZSZZb8VNzez89_m6_jNhQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428207daff2so53394295e9.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 12:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724785463; x=1725390263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HkWCAaDqu2XZmQMkoLU93xiUV6PoV/L38xqUed5LNOs=;
        b=K5d0sU/xvtvO8NHizFOkpmzoGPtD0e17GoGhyT8n3nac+DGBOFrtHAgo0xWoLKb9Fs
         OfxtR381JbO+rlQ9QR5Qrab0n00THpVoo06sv1De+pQFlIgzO/aNUWUDv9LqWiizdgIh
         1QdKbR485d4VsVj3mBEUoHq2s/ayIcm5t+ep22G9GZOpMgrn2o9LdnK9DSN+MGVDskM+
         DyMcemuQIw6hG2I8eGHcYQR+/uKGnXyHD4T6svjEULWZwYZp0/0vbjvmuYX66xw8cESQ
         c/vrnrLZwbkAxocHkP0gHP7Ddt7Toku3m3OAf/sC73h6DGwtc4vtU0nW5anWG3LTbixS
         pAHw==
X-Forwarded-Encrypted: i=1; AJvYcCXHtRADuvyfO+vf8VysVp32q3Z+k2wRhtExNbfG6Yrr9oeMO+ZJCbl69a0aC3Bjx+yfRpvFU02pVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLyn30m2BJXET5AovW0EQHLEHamar5FAwFCEEIe6p0twm+iOr3
	yx+pTK6GkiEQXeMwIFX4Ud4WvnwLGxTYDKykk9tW3yjbLt3SRqe72WpH45TSwnbgEipsIiyzOH6
	b+t9OtuAxcmI3CnRVwgVbJsGLDviCb99WTcflF2iTVbPDZCj9cBHdgY7a
X-Received: by 2002:a05:6000:400f:b0:371:8f19:bff5 with SMTP id ffacd0b85a97d-37311857877mr11933157f8f.3.1724785463437;
        Tue, 27 Aug 2024 12:04:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1i/xHwfH62KeEf74CXSi1HrJpaaxieMRJplttOqZqnN5NHZ0E2WbImpYcSF+/j2WB6c89uQ==
X-Received: by 2002:a05:6000:400f:b0:371:8f19:bff5 with SMTP id ffacd0b85a97d-37311857877mr11933128f8f.3.1724785462851;
        Tue, 27 Aug 2024 12:04:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb20a5a4sm1305368a12.42.2024.08.27.12.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 12:04:22 -0700 (PDT)
Message-ID: <a0bfd438-6d18-4334-aa79-b35aed43f3c7@redhat.com>
Date: Tue, 27 Aug 2024 21:04:20 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
To: Andres Salomon <dilinger@queued.net>
Cc: linux-kernel@vger.kernel.org, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
 Sebastian Reichel <sre@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
References: <20240820033005.09e03af1@5400>
 <04d48a7c-cad1-4490-bbcd-ceb332c740bd@redhat.com>
 <20240827142408.0748911f@5400>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240827142408.0748911f@5400>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/27/24 8:24 PM, Andres Salomon wrote:
> On Mon, 26 Aug 2024 16:44:35 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Hi Andres,
>>
>> On 8/20/24 9:30 AM, Andres Salomon wrote:
> [...]
>>> +
>>> +static ssize_t charge_type_show(struct device *dev,
>>> +		struct device_attribute *attr,
>>> +		char *buf)
>>> +{
>>> +	ssize_t count = 0;
>>> +	int i;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
>>> +		bool active;
>>> +
>>> +		if (!(battery_supported_modes & BIT(i)))
>>> +			continue;
>>> +
>>> +		active = dell_battery_mode_is_active(battery_modes[i].token);
>>> +		count += sysfs_emit_at(buf, count, active ? "[%s] " : "%s ",
>>> +				battery_modes[i].label);
>>> +	}  
>>
>> If you look at the way how charge_type is shown by the power_supply_sysfs.c
>> file which is used for power-supply drivers which directly register
>> a power-supply themselves rather then extending an existing driver, this
>> is not the correct format.
>>
>> drivers/power/supply/power_supply_sysfs.c
>>
>> lists charge_type as:
>>
>>         POWER_SUPPLY_ENUM_ATTR(CHARGE_TYPE),
>>
>> and ENUM type properties use the following for show() :
>>
>> 	default:
>> 		if (ps_attr->text_values_len > 0 &&
>> 				value.intval < ps_attr->text_values_len && value.intval >= 0) {
>> 			ret = sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
>> 		} else {
>> 			ret = sysfs_emit(buf, "%d\n", value.intval);
>> 		}
>> 	}
>>
>> with in this case text_values pointing to:
>>
>> static const char * const POWER_SUPPLY_CHARGE_TYPE_TEXT[] = {
>> 	[POWER_SUPPLY_CHARGE_TYPE_UNKNOWN]	= "Unknown",
>> 	[POWER_SUPPLY_CHARGE_TYPE_NONE]		= "N/A",
>> 	[POWER_SUPPLY_CHARGE_TYPE_TRICKLE]	= "Trickle",
>> 	[POWER_SUPPLY_CHARGE_TYPE_FAST]		= "Fast",
>> 	[POWER_SUPPLY_CHARGE_TYPE_STANDARD]	= "Standard",
>> 	[POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE]	= "Adaptive",
>> 	[POWER_SUPPLY_CHARGE_TYPE_CUSTOM]	= "Custom",
>> 	[POWER_SUPPLY_CHARGE_TYPE_LONGLIFE]	= "Long Life",
>> 	[POWER_SUPPLY_CHARGE_TYPE_BYPASS]	= "Bypass",
>> };
>>
>> So value.intval will be within the expected range hitting:
>>
>> 			ret = sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
>>
>> IOW instead of outputting something like this:
>>
>> Fast [Standard] Long Life
>>
>> which is what your show() function does it outputs only
>> the active value as a string, e.g.:
>>
>> Standard
>>
>> Yes not being able to see the supported values is annoying I actually
>> wrote an email about that earlier today:
>>
>> https://lore.kernel.org/linux-pm/49993a42-aa91-46bf-acef-4a089db4c2db@redhat.com/
>>
>> but we need to make sure that the output is consistent between drivers otherwise
>> userspace can never know how to use the API, so for charge_type the dell
>> driver should only output the active type, not all the options.
> 
> So should I just wait to make any changes until you hear back in that
> thread?

Yes that might be best.

> I'm not overly excited about changing it to use the current
> charge_type API, given that the only way to get a list of modes that the
> hardware supports is to try setting them all and seeing what fails.
> 
> I suppose another option is to rename it to charge_types in the dell
> driver under the assumption that your proposed charge_types API (or
> something like it) will be added..

Right, if we get a favorable reaction to my charge_types suggestion
then we can go ahead with the dell-laptop changes using charge_types
instead of charge_type. I was already thinking along those lines
myself too.

So if my RFC gets a favorable response lets do that.

In that case you don't even need to send a new version just
renaming charge_type to charge_types is something which I can do
while merging this.

>> This reminds me that there was a patch-series to allow battery extension drivers
>> like this one to actually use the power-supply core code for show()/store()
>> Thomas IIRC that series was done by you ?  What is the status of that ?
>>
>> Also looking at the userspace API parts of this again I wonder
>> if mapping  BAT_PRI_AC_MODE_TOKEN -> "Trickle" is the right thing do
>> maybe "Long Life" would be a better match ?  That depends on what the option
>> actually does under the hood I guess. Is this known ?
>>
> 
> I originally thought to use Long Life rather than Trickle. We discussed
> it here:
> 
> https://lore.kernel.org/linux-pm/5cfe4c42-a003-4668-8c3a-f18fb6b7fba6@gmx.de/
> 
> Based on the existing documentation and the fact that the wilco driver
> already mapped it, it was decided to stick with the existing precedent
> of using Trickle.

Ok, I was just wondering if this was discussed already, since it was
lets stick with "Trickle".

> That said, Armin at first suggested creating a new "Primarily AC" entry.
> That's personally my favorite option, though I understand if we don't
> have to have 50 CHARGE_TYPE entries that just slightly different
> variations. :)

Right.

Regards,

Hans




