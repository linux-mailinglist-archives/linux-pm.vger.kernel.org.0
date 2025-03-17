Return-Path: <linux-pm+bounces-24177-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC249A6523D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 15:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B911893D39
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 14:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C5323CF11;
	Mon, 17 Mar 2025 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIN1Qb+X"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37B178F43
	for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220249; cv=none; b=PeR4MbPVrOOiAjmMe5bM4+paUbJcTlE5JB07x6V3fQxU2OMuq/O4ZtHUYcsOZLvLS1rAKOL84AzKXPWpSvT3130yz+BR5YT03y2yQgVU/Lbav0BcAHCC4DwbTMpk/2pImAduxmnlAlSjGXzJkondu4UdD4DZ+w1GAuu+ycy0lwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220249; c=relaxed/simple;
	bh=iBF0gJlnP188yvkLa6tZpOjI1ZaFED9P9+keeH/VW0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yl3uattqY7kE3Omsyexq79PihzrWyp+Z2tPUP560bj9hQfXG7ECCBsbjWT31RpqUs6o/h4xWphInlcvh3CoAIswPYJPniwtWhz9oi7BBiJ5E6r3ofktGx4Zv0V3GBZEo5bOH2isy/8WWTWNmyMAuxI4GK3ljimv8ocXK6IAYuLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iIN1Qb+X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742220246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=219eUn+jdPFzVfDH/DzPCIrl9FP/mjzb8qSFJuWYfr8=;
	b=iIN1Qb+Xe6uii4+wf37A8kc0hVqD1Z3W+cX7wzGiHjXU1/UXn8eTRc1ecr0+EktZBGH95B
	GxIsvtOcKu3vdWLWMbAvm8Ah8R5aM+WcTS5lQUJlo9+AZlzaxqMcepqNRerJ1eNJUowhsj
	9lt1bSDqL6yiXvNluEZv3qnSxMHrPgg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-hqt3aatINya9XItrDC8Bkw-1; Mon, 17 Mar 2025 10:04:00 -0400
X-MC-Unique: hqt3aatINya9XItrDC8Bkw-1
X-Mimecast-MFC-AGG-ID: hqt3aatINya9XItrDC8Bkw_1742220239
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac287f284f8so320457066b.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 07:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742220239; x=1742825039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=219eUn+jdPFzVfDH/DzPCIrl9FP/mjzb8qSFJuWYfr8=;
        b=GelXAP4eMa9BW3b9FfW2Qp7tIXpxfdPGzuX69NRD2j8/sfLazblaMApK7JlL0DgOIh
         fvSU3f3FnCl+OGKNtgmvxrHGS9FdNBHCst70BwDhOxD5BkeTFvSkAE9gOcqTeX4Ouux1
         Tq7p7rbmJ8RnlfOTdl6jQ4zq/wg5WAPlI8dO2Kdva/DC6WvMLWQmeN++Bpx/DRXTjPi7
         HiUcyc9iK0jqQHUac9++/vy82HAv9s8vdEtpDMeycO0eNTySzYDxB5dvnyei6C0hi9+J
         uCL5gitXOEr3HnUbrnBRIZFs6Nh38uOhVobvcItalCOGNXfmBi/vkDKZtq8cgB+jjhvM
         wXXg==
X-Forwarded-Encrypted: i=1; AJvYcCUh36EyMRVgZQ+i6hZklzWdMqUuelGapWuwiWuoNaVsdLHnSSBbaUWKvAqWxd3jGgezb6UyU3q+/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTXFdC1PBjde3B4Eu0f50YyMws+4zdPunjd8WbxD3tvyJwe+/P
	2Pwp0MBf1QLeShm07Xuza7y+qCiNa3REAqUlgfQ5dJ4DXzZUzFg0IGyBsr8JoZzsp6cDUizShRf
	FE0pMNm85ZjGREOSzkYI6ogLwp05APRjls5ggwVxYThTDg70bVgTHtz/Q
X-Gm-Gg: ASbGncsMJhAl8H71gBqtL9nDMQHzVxNU96opnwSxsPTY5+rrZNYdAan7srFRRQN4bVI
	6vjsj/n7YB+YRIEefJ3z88g3hp6O8pQUGhnWL3uKRDQ/MfXi7kpGzWQ78YGvUsEPpavdo1HOFjD
	Y3lzfiPit93YLM1bJJ2fDH6wBCdjIjXbCzli59XEZ9p9nqBcarFioq7CS+/fLMxfNHyLzLUmo4p
	jPz3x8BP7BcMYiuMxpi2Aii0+JucVFyjUqzgFauwShAapCYPlvBICgAtUDCPQis7+6ujHDe0fBt
	bq3kGKW/4va4iQRpERQ=
X-Received: by 2002:a17:907:2d11:b0:ac3:5d65:1a51 with SMTP id a640c23a62f3a-ac35d652194mr612734066b.51.1742220238795;
        Mon, 17 Mar 2025 07:03:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVQzV/ejrIoUV6KC1aN0EHkZFXEcDCo3O9h3d+ggUaCT5M+U2JvVwpN2tUakc2NOqiW5ihEg==
X-Received: by 2002:a17:907:2d11:b0:ac3:5d65:1a51 with SMTP id a640c23a62f3a-ac35d652194mr612726466b.51.1742220238243;
        Mon, 17 Mar 2025 07:03:58 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0df9sm682160066b.99.2025.03.17.07.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 07:03:57 -0700 (PDT)
Message-ID: <1291b9af-28f0-4727-b913-67827c1861c3@redhat.com>
Date: Mon, 17 Mar 2025 15:03:56 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/13] power: supply: add inhibit-charge-s0 to
 charge_behaviour
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
 Eileen <eileen@one-netbook.com>
References: <20250311165406.331046-1-lkml@antheas.dev>
 <20250311165406.331046-6-lkml@antheas.dev>
 <b1ac8a33-06ed-482a-b5f6-ca88eb3802a1@redhat.com>
 <CAGwozwGESTw2DJsqr3uAhEymXxH4O5EXDw6O91i8CzCT0=yC1Q@mail.gmail.com>
 <82e27f38-f951-4e6f-babd-81890d590a04@redhat.com>
 <CAGwozwFCOqhyNTZPfq2nmDoAYwzrUGoDGWzvqmJf8zK2_5Hk6A@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAGwozwFCOqhyNTZPfq2nmDoAYwzrUGoDGWzvqmJf8zK2_5Hk6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 17-Mar-25 14:50, Antheas Kapenekakis wrote:
> On Mon, 17 Mar 2025 at 14:31, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 17-Mar-25 13:38, Antheas Kapenekakis wrote:
>>> On Mon, 17 Mar 2025 at 13:27, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi Antheas,
>>>>
>>>> On 11-Mar-25 17:53, Antheas Kapenekakis wrote:
>>>>> OneXPlayer devices have a charge bypass
>>>>
>>>> The term "charge bypass" is typically used for the case where the
>>>> external charger gets directly connected to the battery cells,
>>>> bypassing the charge-IC inside the device, in making
>>>> the external charger directly responsible for battery/charge
>>>> management.
>>>>
>>>> Yet you name the feature inhibit charge, so I guess it simply
>>>> disables charging of the battery rather then doing an actual
>>>> chaerger-IC bypass ?
>>>>
>>>> Assuming I have this correct, please stop using the term
>>>> charge-bypass as that has a specific (different) meaning.
>>>
>>> Unfortunately, this is how the feature is called in Windows. On both
>>> OneXPlayer and Ayaneo. Manufacturers are centralizing around that
>>> term.
>>
>> Ok, so I just did a quick duckduckgo for this and it looks like
>> you are right.
>>
>>> Under the hood, it should be bypassing the charger circuitry, but it
>>> is not obvious during use.
>>
>> Ack reading up on this it seems the idea is not to connect the external
>> charger directly to the battery to allow fast-charging without
>> the charge-IC inside the device adding heat, which is the traditional
>> bypass mode.
>>
>> Instead the whole battery + charging-IC are cut out of the circuit
>> (so bypassed) and the charger is now directly powering the device
>> without the battery acting as a buffer if the power-draw superseeds
>> what the external charger can deliver.
>>
>>> The user behavior mirrors `inhibit-charge`,
>>> as the battery just stops charging, so the endpoint is appropriate.
>>
>> Hmm this new bypass mode indeed does seem to mirror inhibit charge
>> from a user pov, but it does more. It reminds me of the battery disconnect
>> option which some charge-ICs have which just puts the battery FET in
>> high impedance mode effectively disconnecting the battery. Now that
>> feature is intended for long term storage of devices with a builtin
>> battery and it typically also immediately powers off the device ...
>>
>> Still I wonder if it would make sense to add a new "disconnect"
>> charge_behaviour or charge_types enum value for this ?
>>
> 
> The battery is not disconnected. It still provides backup. Unplugging
> the charger does not turn off the device. So it is more murky.
> 
> From a userspace perspective it is inhibit-charge 1-1.

Ok, lets go with inhibit then.

>> <snip>
>>
>>>>> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
>>>>> index 2a5c1a09a28f..4a187ca11f92 100644
>>>>> --- a/Documentation/ABI/testing/sysfs-class-power
>>>>> +++ b/Documentation/ABI/testing/sysfs-class-power
>>>>> @@ -508,11 +508,12 @@ Description:
>>>>>               Access: Read, Write
>>>>>
>>>>>               Valid values:
>>>>> -                     ================ ====================================
>>>>> -                     auto:            Charge normally, respect thresholds
>>>>> -                     inhibit-charge:  Do not charge while AC is attached
>>>>> -                     force-discharge: Force discharge while AC is attached
>>>>> -                     ================ ====================================
>>>>> +                     ================== =====================================
>>>>> +                     auto:              Charge normally, respect thresholds
>>>>> +                     inhibit-charge:    Do not charge while AC is attached
>>>>> +                     inhibit-charge-s0: same as inhibit-charge but only in S0
>>>>
>>>> Only in S0 suggests that charging gets disabled when the device is on / in-use,
>>>> I guess this is intended to avoid generating extra heat while the device is on?
>>>>
>>>> What about when the device is suspended, should the battery charge then ?
>>>>
>>>> On x86 we've 2 sorts of suspends S3, and the current name suggests that the
>>>> device will charge (no inhibit) then. But modern hw almost always uses
>>>> s0i3 / suspend to idle suspend and the name suggests charging would then
>>>> still be inhibited?
>>>>
>>>> Also s0 is an ACPI specific term, so basically 2 remarks here:
>>>>
>>>> 1. The name should probably be "inhibit-charge-when-on" since the power_supply
>>>>    calls is platform agnositic and "S0" is not.
>>>
>>> I tried to be minimal. If we want to make the name longer, I vote for
>>> "inhibit-charge-awake". I can spin a v5 with that.
>>>
>>> The device does not charge while asleep. Only when it is off.
>>
>> Is suspend awake though ?
> 
> Sorry I mispoke. When inhibit-charge-awake, the device only charges
> while in s0i0. When inhibit-charge, it never charges. This includes
> s0i3, S4, and S5. The devices that support this only support modern
> standby.
> 
> I just verified this.

Ok that sounds good / sane, it likely just disables charging while in s0i0
to avoid generating extra heat while in s0i0, so inhibit-charge-awake sounds
good to me.


> 
>>>> 2. We need to clearly define what happens when the device is suspended and then
>>>>    make sure that the driver matches this (e.g. if we want to *not* inhibit during
>>>>    suspend we may need to turn this feature off during suspend).
>>>
>>> This is handled by the device when it comes to OneXPlayer. No driver
>>> changes are needed.
>>
>> Well you say no charging is done when suspended, the question also is what
>> behavior do we want here?  I'm fine with the default behaviour, but a case
>> could be made that charging while suspended might be desirable (dependent on
>> the use case) in which case we would need to disable the inhibit when
>> suspending to get the desired behavior.
>>
>> Also what if other firmware interfaces with a bypass^W inhibit option work
>> differently and do charge during suspend ?
>>
>> It is important that we clearly define the expected behavior now so that
>> future devices can be made to behave the same.
> 
> Sorry I mispoke. Charging happens under modern standby under -awake.
> 
> So -awake would mean awake (s0i0) here.
> 
> If other devices charge during sleep and awake, another option could be added.

ack, as mentioned above inhibit-charge-awake sounds good to me,
thank you for clarifying.

Regards,

Hans



