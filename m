Return-Path: <linux-pm+bounces-14360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A04FF97AD8D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 11:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C502E1C213A0
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 09:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1B91BF24;
	Tue, 17 Sep 2024 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXVZNupE"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B33136351
	for <linux-pm@vger.kernel.org>; Tue, 17 Sep 2024 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726564009; cv=none; b=ZQtopVf0Lzawk1+gURKJQd2Iv0G1XOLDQl1zHiA6pjXAPPxAUbLYB6YI1Bp+t9u2ywPlQCc464hXJYi3f170FfxewoSSIWH8iLFoEZcOtbyReMSwSLM4tm/Ll+3ND7+miuO1JvsWwVNxjF/xij6vcy7Z1C2ClJqji0DkwKJwHOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726564009; c=relaxed/simple;
	bh=jPOb0JQIK5vN4ygvo+QPK+TweTRvxL8D2BKP7YCm/dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjQw5q8UnIWTfOoWbhOWo2liEAyaXJQfvR2KPqBTWn7zavMiJhEu0PObPqExj1BGnpuYwQb34zpxDoj2GYz9/E1AGK8IsLHogdSyziKGFwSGZpy8cWkJrK29XhYHWfoF3rGlZxZutZxB9nSAkDn0nzHoCC7tTD2zRAdUj5SxQGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXVZNupE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726564006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7obLZgeKuYqWkeslMNYYNf0DeF5TTlVqiV364RRxE8=;
	b=WXVZNupEjOtL0mcqFppBUqbRxqDP5ARASaVebDv7We0Fb4LjE6ap54OxonkBqGiOBdzVvD
	So+yNBiz3LJZAafrty46wMTr8uFWhj+fGCedbq3sNfMP4Q3AThvvG0GM3iAhucVKxsbX1v
	C6b7t0o7wnakekk+I63MiM0l1cSgEp0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-Al2oCj37MrK0YAV0UE5jAQ-1; Tue, 17 Sep 2024 05:06:45 -0400
X-MC-Unique: Al2oCj37MrK0YAV0UE5jAQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8a877c1d22so112014466b.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Sep 2024 02:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726564004; x=1727168804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7obLZgeKuYqWkeslMNYYNf0DeF5TTlVqiV364RRxE8=;
        b=IRI7om86W3d1qIcvFyP125HpEXOQmrAHkSLmoNUQ9lhBFSHE1itQzk6L8kCeF9AWpV
         gZF9F9I1fximPCGXSyYD/qHF6M0kS+p5kgNI+nkNyZuFc8/NyIKWLzsirySR0vAGV7Ai
         P4Kg4itkEniQcgDSZORL5jW0SBWQTbGj1SE39iQeghLP+XiMBXZuinaTmE/NDIlR+oWe
         NUA8wmPhmT7v5KztIqqgrXI61EYuEgfIjAroMCQOdGlPWpzt+ZjVt/NeftIVqBm5/FfM
         VctfqT0VfDsfI3QOPJF48eVnbmAThT3nPBUBU4eK2V45atCv2usLkXJcol3HcqZgV4hV
         pr9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEbHhef+qruKsDFY80Q/m91dNws0troPngaAlpQDXl/EgYrZc8JaVnC/0fD/6ZT9MUb5eJ255k0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfDJBdHopaW275TOySKYwnLf6aiY1K27UhSrDvXdUeT/u//gfS
	DbTCO4azjeCn6jqykUhdltLxtfdXooZK9lgo7Kbi8QzSqaYtox6TFjDl/nj54m4GxmgsVbWhNy3
	5gooMTMNGxT39SiGVwHEL1h8LU2OV4qj2ldaAmAfewKtF7vZdcH6Lh4zPijmr0btn
X-Received: by 2002:a17:907:6d26:b0:a8b:6ee7:ba2c with SMTP id a640c23a62f3a-a9047c9c2cemr1302322066b.16.1726564004220;
        Tue, 17 Sep 2024 02:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhBq2aObMO2W2ZenntjvnGnyQt+T/63ry9Nr68kYJ0C95G+f4zirK+qxNLRpSk06M4zTZJXA==
X-Received: by 2002:a17:907:6d26:b0:a8b:6ee7:ba2c with SMTP id a640c23a62f3a-a9047c9c2cemr1302319466b.16.1726564003702;
        Tue, 17 Sep 2024 02:06:43 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f3aaesm420720566b.53.2024.09.17.02.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 02:06:43 -0700 (PDT)
Message-ID: <599b59f6-6cd4-463d-aafb-699fcb387f7e@redhat.com>
Date: Tue, 17 Sep 2024 11:06:42 +0200
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
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2crw2apbxixaqq6vibtlewe47nvqeo2cnwo2okdiqtaelvtjce@g6mhr4iproiz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sebastian,

On 9/17/24 9:38 AM, Sebastian Reichel wrote:
> Hello Hans,
> 
> On Sun, Sep 08, 2024 at 09:23:00PM GMT, Hans de Goede wrote:
>> Some enum style power-supply properties have text-values / labels for some
>> of the enum values containing a space, e.g. "Long Life" for
>> POWER_SUPPLY_CHARGE_TYPE_LONGLIFE.
>>
>> Make power_supply_show_enum_with_available() surround these label with ""
>> when the label is not for the active enum value to make it clear that this
>> is a single label and not 2 different labels for 2 different enum values.
>>
>> After this the output for a battery which support "Long Life" will be e.g.:
>>
>> Fast [Standard] "Long Life"
>>
>> or:
>>
>> Fast Standard [Long Life]
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
> 
> This looks annoying from parsing point of view. Maybe we can just
> replace " " with "_" and guarantee that space is a value separator
> at the cost of the values not being exactly the same as the existing
> charge_type sysfs file?

My thinking here was that if a parser wants to see if a certain option
is available it can just do a strstr() and parsing for the active
value does not change. But yes a parser which wants to tokenize
the string to get all possible values as separate tokens will
become harder to write with this.

I did consider moving to using a "_" one problem there is that
this means that echo-ing "Long_Life" to set the value should then
work. Which would require special handling in the generic store()
function. I guess we could makle 

I guess an easy solution here would be to define a second set
of POWER_SUPPLY_CHARGE_TYPE_TEXT[] strings aptly named
POWER_SUPPLY_CHARGE_TYPES_TEXT[] (with the extra s).

This can then simply contain Long_Life instead of Long Life,
downside of this would be that writing "Long Life" will then
not work. So charge_type then takes "Long Life" and charge_types
"Long_Life" which is less then ideal.

The best I can come up with is to replace " " with _ when showing
and in power_supply_store_property() add some special handling for
charge_types like this:

	/* Accept "Long_Life" as alt for "Long Life" for "charge_types" */
	if (dev_attr_psp(attr) == POWER_SUPPLY_PROP_CHARGE_TYPES &&
	    sysfs_streq(buf, "Long_Life"))
		buf = "Long Life";

	ret = -EINVAL;
        if (ps_attr->text_values_len > 0) {
                ret = __sysfs_match_string(ps_attr->text_values,
                                           ps_attr->text_values_len, buf);
        }

This isn't pretty, but this way we don't need to define a second set of
POWER_SUPPLY_CHARGE_TYPES_TEXT[] values, duplicating those (and needing
to manually keep them in sync), while accepting both "Long Life" and
"Long_Life".

Note that a generic replacing of _ with space or the other way around
in store() will not work because we already allow/use "Not Charging"
but also "PD_DRP" so replacing either _ or space with the other will
break one of those.
		
> Do you know if there is prior examples for this in the kernel by
> chance?

I'm not aware of any examples where a sysfs attr show() uses the show
all available values with the active one surrounding by [ ] where
one of the values has a space in it. It is quite easy to avoid the
values having spaces if this format is used from the start.

Regards,

Hans




