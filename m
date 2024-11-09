Return-Path: <linux-pm+bounces-17249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBAF9C2C02
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 11:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB3F282B55
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 10:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839DE1494BF;
	Sat,  9 Nov 2024 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fstU8d8U"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB348836
	for <linux-pm@vger.kernel.org>; Sat,  9 Nov 2024 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731149576; cv=none; b=kBkahTBRmZWp0T8q71UwaP5Y+JI+24VBl296INZun3kYzS7ePjYOYIhKEHG3L4a0UdfMWtT3+PfU/nbVlFnEvIGkDUd7Kb8yZ9Upzo7jjOZTCy7hK4PCgR0kBR+Nj8pbBE2rDC2uH6OtYNpDZ6n/DO//RScYWKv7ZFQ3rzLyp4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731149576; c=relaxed/simple;
	bh=cbdkAEq72/ZfJoij6jcGy23iPkvaSxtNCTVsA/Ygy5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4ZsrnYYx9js69FacFPPj2Uu56o7O3J+38wRvdXQFdOILTEic3myZ2ISZ1N2f+94yAz9uoHYyautlStYNvnHLmaXJtXQ95g9AZIZpT2acVzgQDa7Bvc/B7g64xX9QOLXJocv823j/TO7c/OzjtT4oYPSiwYhd3hL6cA1MdxgXqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fstU8d8U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731149573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnBxY33YcAjuXZrhTPmctubIS6qzeGoTa64AC1LeDy8=;
	b=fstU8d8U5D2z4zRUnIrOHO3C1Hhp0Cti9HR04p+ZUQe05WZntnFCdy5PF9XWl2i6Pcs4ya
	ccPSbVP5ph2TApRW6at/4F/xT5yPGTDBH5a2F1qyFvURrkaznPJBuSQqWupzPdIQo/+LLi
	HQc0ixwEvk/azsb+m0z2gvZVq+4yiDw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-N6KhGKRZMYWuuDkxaeduAA-1; Sat, 09 Nov 2024 05:52:51 -0500
X-MC-Unique: N6KhGKRZMYWuuDkxaeduAA-1
X-Mimecast-MFC-AGG-ID: N6KhGKRZMYWuuDkxaeduAA
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c930ca5d12so354707a12.1
        for <linux-pm@vger.kernel.org>; Sat, 09 Nov 2024 02:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731149570; x=1731754370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YnBxY33YcAjuXZrhTPmctubIS6qzeGoTa64AC1LeDy8=;
        b=gGmdQtiC6dPOXcv55DuTrpc7vfB+f1SMfBI4wcygKquCpWHynJhL4bgyPQurSKpH1w
         DKnMUgxh9UUOGkVoBh9NiePLitxjY+7gb7Ior3KKCZmvhAnLv5D9Xia/uGW9m09zvfrH
         Bbefnk0uyeQmyDfRuvJBFgiDocBfcRNYPfsqmIWnxpVdBgtsluoio0m/i+utsERqfc4Z
         EIC3YNiKnhdNcZHonSkePVIrDMM1uoM3Fd5O+/LhA9SicNKY34oBxAiTYy/WdaDFYkpH
         Blt25R8vjUGmIGcUNlg0QNAZlPlipT6zBZqI8zX4MKiOExKX3vy6gDbLUHC+tM3keL2h
         CWEg==
X-Forwarded-Encrypted: i=1; AJvYcCUyKR+uIg8ujGApNC+ih/FlOM5hSz808/OWZds9ekzwIPEyZO7G2TQVz2g5OZC1QWZoarwkaCMqVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC/XlOA8AsukD/aHQ83m6lSvufCXyPX34TBl7qCPd2f2Lx6r0a
	olRCBgmwyxEjCSU7+dGx2X/P2nPFeZKQ0TkDf6tOMZivSefB26tvh4EmTKKf/VFXjY0+TUa9900
	wNCSBr8Ri2Ez56SyVYqqQzUOSlBY1vXbhmsJJ6JW8Sdr6v1jLhli1Rg9f
X-Received: by 2002:a05:6402:1ece:b0:5cf:9f1:c53 with SMTP id 4fb4d7f45d1cf-5cf0a47612cmr6314321a12.6.1731149570347;
        Sat, 09 Nov 2024 02:52:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnkPpOJm6S0M9wm9aWOhCx1Ky99Nj/5XwM9Fdccq4me3hhnskWPEtZaUY/HwVzZr2+q7JlAg==
X-Received: by 2002:a05:6402:1ece:b0:5cf:9f1:c53 with SMTP id 4fb4d7f45d1cf-5cf0a47612cmr6314304a12.6.1731149569920;
        Sat, 09 Nov 2024 02:52:49 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf08ca5bdesm2067985a12.11.2024.11.09.02.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 02:52:48 -0800 (PST)
Message-ID: <2ae4400b-fa14-4292-af41-9ad091a0c1ce@redhat.com>
Date: Sat, 9 Nov 2024 11:52:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] power: supply:
 power_supply_show_enum_with_available(): Replace spaces with '_'
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 platform-driver-x86@vger.kernel.org, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Jelle van der Waa <jelle@vdwaa.nl>,
 linux-pm@vger.kernel.org
References: <20241108232438.269156-1-hdegoede@redhat.com>
 <20241108232438.269156-2-hdegoede@redhat.com>
 <CAHp75VfxCEk1OhQZX8SEk8Enyf6mz1Tt0qxsTX9Xfouw8WOL-g@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VfxCEk1OhQZX8SEk8Enyf6mz1Tt0qxsTX9Xfouw8WOL-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9-Nov-24 5:30 AM, Andy Shevchenko wrote:
> On Sat, Nov 9, 2024 at 1:24 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Some enum style power-supply properties have text-values / labels for some
>> of the enum values containing a space, e.g. "Long Life" for
>> POWER_SUPPLY_CHARGE_TYPE_LONGLIFE.
>>
>> Make power_supply_show_enum_with_available() replace these spaces with
>> '_' when showing the available text-values. After this the output for
>> a battery which supports "Long Life" will be e.g.:
>>
>> Fast [Standard] Long_Life
>>
>> or:
>>
>> Fast Standard [Long_Life]
>>
>> Modify power_supply_store_property() to accept both the original text-value
>> with space and the alternative value with the spaces replaced by '_'.
>> This allows users to write the value with '_' after seeing this on reading
>> the property.
> 
> ...
> 
>> +static void power_supply_escape_spaces(const char *str, char *buf, size_t bufsize)
>> +{
>> +       strscpy(buf, str, bufsize);
>> +       strreplace(buf, ' ', '_');
>> +}
> 
> The bufsize in all cases here is sizeof(buf), making the above to be a
> macro we may switch to 2-argument strscpy(). FTR, it embeds the check
> that buf is an array.

I did think about this already, but using a macro makes this harder
to read just to save 2 sizeof() calls. So I prefer doing things
this way.

> 
> ...
> 
>> +       char escaped_label[32];
> 
> Even more, the but size seems also the same, can we have buf defined
> inside the above?

No not really, its address would need to be returned then, requiring
it to be static, at which point we get race conditions when multiple
threads use the same function at the same time.

Regards,

Hans


