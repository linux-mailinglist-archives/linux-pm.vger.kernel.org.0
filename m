Return-Path: <linux-pm+bounces-8471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759928D61A9
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 14:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0506D1F25CF7
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 12:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E204158865;
	Fri, 31 May 2024 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+oidtya"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF66B15884F
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158323; cv=none; b=ktCASx4sWxR8iNkonOBgvqEZf68lcLq627JNDrndjRO9me5bxbbHSsEtudlnXu6pfp+1yfJ53LQHRwshlzdZ5h1TnxVmfqICb1LUMKGu5sYMyEUMhxL+NEF3Yaivi6ASKcRpuvIm27zg/U97arH1BfMYfQwnS71yGi8vXxBNV7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158323; c=relaxed/simple;
	bh=529H4seeYbvq1uFn776ChzJIAtVLr8Fs7W9zkeFaNSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCOYCzPjlKAUjkXff88xzDSzPE1IQueCpXxuqRGG7aKWtI3MGF3yOaUCS4uqAInrdd5bPOgZZVFHRobSO6Kz/I42G1q82wa/wUFZxRX84fYyKACyTTPCvwRk8roSfHXLKboRwDpjw3ANtGQvw2jVyqyhsdOGSKr87rcz1t4/GOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+oidtya; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717158320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7f/MkaaHIZ/0UQbdKRkwJXei2osLqgSgM+3SS6lRxnE=;
	b=M+oidtyaU0tyNFFr2mrWvMWUNcPpsfKTb6NxoZRp7OQBaN8n8nMsE1SjC36VD/tNcDxp72
	1hq+/1etBJYV6xJJtch4BMjzkDHIG8tnPDZECBmzcw4wkI3vlt4UWAaN8pBnBdzb5effH0
	PDu74TnZhUA1mkUISD6vFbZw1nJBcYk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-k3VTMJSeNvWG84dBBHq1sQ-1; Fri, 31 May 2024 08:25:18 -0400
X-MC-Unique: k3VTMJSeNvWG84dBBHq1sQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a67e55a460bso71069366b.0
        for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 05:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717158317; x=1717763117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7f/MkaaHIZ/0UQbdKRkwJXei2osLqgSgM+3SS6lRxnE=;
        b=VGcp4yNYRsEukMqX7tNv+5Os1N6bKe/ojbnGNobe70HXKfEiPTVmBENpaRXJulyAWZ
         uE/9Dd2RNP2CZpM+dhdv2GHAMrQ5exBkZoCRRbtJ8pJgsMNpKkgsfoToFjb2V256dlhy
         HkCsosa3rmEastuD1NNZ5SP2CSyU1XgrWdKcj1rhqXo1MNhXZNF3j0kwybDbZg6VmaY0
         k1AcrJ+Q9XxUmDs8yCzLxGyUMIncPlSZwGezFCHYtxYGPRKd+ySpJNAFcvtZbx9yKB6m
         OKuLWcgIfDzUY4hqPkZAnXs2hRNV79JNgITNNSQHxJMfYfpM43gMEfH0riWjBc+ZX/Ph
         IG+A==
X-Forwarded-Encrypted: i=1; AJvYcCUfQjpmx98BS6W+6i5JOwk0VrpXnH1CTC4BBbQC9uV8QfZ+QNwoIzLeNPoZteeOL07EFdQhPnHwkqhbfmFum0To3W1jXMHpO9A=
X-Gm-Message-State: AOJu0YyHjAkhFadexn87dXbbcPw31fpCqN6vfWxgAN9BlWRjd+bxTNTs
	ussRgCZG5vpMQdBajDORHrM/oiqZK2yx/J6RjE9/lPXkk9LCFhuOt2neryJINFxhxmaIHqmJ3jk
	atpC0JWkOs2u/mbyEDfjRh6puKgeq8UgBPON5kpay/B+XnFClKe8DL802nuBrVIAV
X-Received: by 2002:a17:906:a15a:b0:a5a:89a8:49c5 with SMTP id a640c23a62f3a-a681ad5f82amr142182666b.33.1717158317117;
        Fri, 31 May 2024 05:25:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExfS1dkDGEGudj90bkTUvQMUyLMW0+Kw0G5nFA1ynYxXnH/uibl5HIooxlqKX2HCbVWFGoiA==
X-Received: by 2002:a17:906:a15a:b0:a5a:89a8:49c5 with SMTP id a640c23a62f3a-a681ad5f82amr142180966b.33.1717158316663;
        Fri, 31 May 2024 05:25:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eac7a340sm81192466b.159.2024.05.31.05.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 05:25:16 -0700 (PDT)
Message-ID: <f38782d7-84c4-44c2-9f62-0c75aa5e511d@redhat.com>
Date: Fri, 31 May 2024 14:25:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] power: supply: power-supply-leds: Add
 power_supply_[un]register_led_trigger()
To: Andy Shevchenko <andy@kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 Kate Hsuan <hpa@redhat.com>, Sebastian Reichel <sre@kernel.org>,
 platform-driver-x86@vger.kernel.org, =?UTF-8?Q?Andr=C3=A9_Apitzsch?=
 <git@apitzsch.eu>, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240510194012.138192-1-hdegoede@redhat.com>
 <20240510194012.138192-2-hdegoede@redhat.com>
 <Zj59zito2FILn9qD@smile.fi.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Zj59zito2FILn9qD@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andy,

Thank you for the review.

On 5/10/24 10:04 PM, Andy Shevchenko wrote:
> On Fri, May 10, 2024 at 09:40:10PM +0200, Hans de Goede wrote:
>> Add power_supply_[un]register_led_trigger() helper functions.
>>
>> The primary goal of this is as a preparation patch for adding an activate
>> callback to the power-supply LED triggers to ensure that power-supply
>> LEDs get the correct initial value when the LED gets registered after
>> the power_supply has been registered (this will use the psy back pointer).
>>
>> There also is quite a lot of code duplication in the existing LED trigger
>> registration in the form of the kasprintf() for the name-template for each
>> trigger + related error handling. This duplication is removed by these
>> new helpers.
> 
> ...
> 
>> +	err = led_trigger_register(&psy_trig->trig);
>> +	if (err)
>> +		goto err_free_name;
> 
> 
>> +err_free_name:
>> +	kfree(psy_trig->trig.name);
>> +err_free_trigger:
>> +	kfree(psy_trig);
>> +	return -ENOMEM;
> 
> Why not ret?

Fixed for v2.


> ...
> 
>> +static int power_supply_create_bat_triggers(struct power_supply *psy)
>> +{
>> +	int err = 0;
>> +
>> +	err |= power_supply_register_led_trigger(psy, "%s-charging-or-full",
>> +						 &psy->charging_full_trig);
>> +	err |= power_supply_register_led_trigger(psy, "%s-charging",
>> +						 &psy->charging_trig);
>> +	err |= power_supply_register_led_trigger(psy, "%s-full",
>> +						 &psy->full_trig);
>> +	err |= power_supply_register_led_trigger(psy, "%s-charging-blink-full-solid",
>> +						 &psy->charging_blink_full_solid_trig);
>> +	err |= power_supply_register_led_trigger(psy, "%s-charging-orange-full-green",
>> +						 &psy->charging_orange_full_green_trig);
> 
> Why not using the similar approach as you have done in v4l2 CCI?

That is a good idea I've done that for v2.

>> +	if (err) {
>> +		power_supply_remove_bat_triggers(psy);
>> +		/*
>> +		 * led_trigger_register() may also return -EEXIST but that should
>> +		 * never happen with the dynamically generated psy trigger names.
>> +		 */
> 
> Maybe this comment should be above and here just return err; (but see above remark).

With the err propagation approach from v4l2 CCI this can now simply return err
since that now correctly reflects the first error (and any following calls
are made no-ops).

Regards,

Hans



> 
>> +		return -ENOMEM;
>> +	}
>> +
>> +	return 0;
>>  }
> 


