Return-Path: <linux-pm+bounces-30952-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C62B07F65
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 23:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE0A1C4253F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 21:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1469119CCF5;
	Wed, 16 Jul 2025 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCmod84+"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FD52AE8E
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700560; cv=none; b=iY4j3b4Shxmh0QHTHv4B65uMFz+6z0k235wfV5EsVKLrSaWbrfUXwimzjxw9KnadrxDFtIpuksvPwmz0ChMTY3qULX3NvcQF8NBj5/0KflrqdsR5SKRdbpJXS7y6sIrlroNPM2JYDEDL0lkCZ91AhxAYMq/UvyQjf3nlWUcQAUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700560; c=relaxed/simple;
	bh=+hlMeVn0thx8onimVBZGxi5ChkjaGkKv6l2vOOBIPd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhhvKiD4GfOZpYR1rXviDWMSicYDHKTpC3xwsxisWn4iFYhyxDNEsy4vsctaVihmTtSFleNtnzMz5GASHYH9BK61AmYIGWyJpGc1ocun6GVMAyr28oeLkTruM+bUYI4tyM88+IXu+g6GVIt6J6QuIEdrM4TzsvB2dnKISc4Pxpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCmod84+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752700557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIoY9toxzYXL00hdS1BvBEqkq65M6ejtPphwdtTAWS8=;
	b=iCmod84+OHHg42I6squQiyQobNBRuvi/Kvc3OFyHO5cruHcDkqNADOWpq9bVP194MEfzuu
	fijFLXAZldYYfZSG5VqAUirwG+peV4cEKoLxbpRNrEbUCsFQK13LI1g4h5u4WdSrNoEumq
	+Q9zFg41z8v+SjIhxdux5WpvfqL9JmM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-ELQnxPYwMl63OUDviFZm5Q-1; Wed, 16 Jul 2025 17:15:55 -0400
X-MC-Unique: ELQnxPYwMl63OUDviFZm5Q-1
X-Mimecast-MFC-AGG-ID: ELQnxPYwMl63OUDviFZm5Q_1752700554
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-606f507ede7so216244a12.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 14:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752700553; x=1753305353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KIoY9toxzYXL00hdS1BvBEqkq65M6ejtPphwdtTAWS8=;
        b=Zwu+D/5pxfQroIHOE58zSwohI+MPS2qaILX2pYKr1jrAK04Kh+ZWE4J3/ceaUC0y27
         75STep5DSNu6ym9hDNFGcKIpgbCQs7Rn4u+w/VayPUEGS3Mdfb4tvAQoACrGF61+BegE
         eNQ4LcvcdKpH4yTIT/5RIDZDzCeE59EKMX8YfgMUw1fdjUHx2GFzD1ZptCRP1LPQ2UtT
         XSIrfRFUIHwggrpiR+WD72gdEMEdwXWOi8UshVXf4yBWvmLbc1rfTg3fepSjvcgXzEdW
         v+ARw536yMYE6/OlSeNFqpOk2Pkt3bP+S6kkxRYMdGNdgolISWT3qsnD1YaJ59fXbPGU
         kQvw==
X-Forwarded-Encrypted: i=1; AJvYcCXaaYKmHSWZcAo4rj7e4NzMt2lBXvlUsC415DLbD8e+S8ioh+pWJ6S4PIbXj6fLNpT0TdoJrrHRYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxb3Wf/OBt+Q34si8Mz0/QRE1FQ2jtAFAIxWCpBhQBbCwBlhqP
	/UyWPgovWMRUSGrxuzdTg2KcKMG9L/8RoS99Z3SrIhmKk3bbDIAGdkxH4E9UyENPOqtnC0gjaLG
	i/UaSInk/rNVf+epuHUh8Q9sGaa9VXc79VCaXNwNSsaCNJEyiKf39/o6tGnGShpXHe/UsWmg=
X-Gm-Gg: ASbGncuZfrlD0UjsOcSzUzWhcg719gI7UeblnqWgBiHQu4LVEaoo62XUs9xSygt86Qi
	vHSIeGbq2cYjHzK73T9yfG5sUzudtFM5ljBHyFGhGTtVlgfeXh1OIXVtsTJvaYiwI+skPM8Z0Vk
	FYbTmaAvg+Qg7Xo5kOGBQaOj6M2gvZ01LqcIEA0EExvtdMdKIhn6uEi7C+AEybZ1ctTcXwI/sPt
	qHK2TK/7gOSVqZLvslz4c/KFrOzNNURj4oZ1LuTRZy1QDCiO/jMXSXyry2nbTJva4dIbzifJ1yX
	uCueGfyIhVJbdoLbHfBWzNGEUKOF7AdQFIX2wYPTTwnXL8tiVAWQMjmj1tNmkeiNXHverzsB5qY
	tHrs1/rTSpr90Ds5qSfIavxMOECaMYuag97Uh957nxTwf3kfdeW+vWRMN7G9FCEYqjVAdU1CLb4
	LMS7w4zGqnyNetPg==
X-Received: by 2002:a05:6402:270d:b0:60b:fb2c:b789 with SMTP id 4fb4d7f45d1cf-612823b8683mr3623638a12.21.1752700553387;
        Wed, 16 Jul 2025 14:15:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd+HSNZ91QaGyK5gCZTZyJ24wFpmZgmCZMmTmuwf1EAaS1PQ94qldpjTuqz9a0eTljRJBX8w==
X-Received: by 2002:a05:6402:270d:b0:60b:fb2c:b789 with SMTP id 4fb4d7f45d1cf-612823b8683mr3623630a12.21.1752700553032;
        Wed, 16 Jul 2025 14:15:53 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611f6f3be91sm7601480a12.26.2025.07.16.14.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 14:15:51 -0700 (PDT)
Message-ID: <91f44fa4-2473-49c2-81d5-9e16f690ebcb@redhat.com>
Date: Wed, 16 Jul 2025 23:15:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] power: supply: adc-battery-helper: Fix reporting
 capacity > 100%
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
References: <20250107113346.170612-1-hdegoede@redhat.com>
 <20250107113346.170612-5-hdegoede@redhat.com>
 <CACRpkdZnkxP5g3c35pMBBiH9No9yJCwerST_uMbg70FLe_f2TQ@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CACRpkdZnkxP5g3c35pMBBiH9No9yJCwerST_uMbg70FLe_f2TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9-Jan-25 7:52 PM, Linus Walleij wrote:
> On Tue, Jan 7, 2025 at 12:34 PM Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> The ocv_capacity_tbl[] to map the ocv voltage to capacity goes up to
>> 4.3V for LiPo High Voltage (LiHV) cells.
>>
>> For non HV cells the code assumes that the estimated ocv value never
>> comes above 4.2V, but there might be cases where it does go above
>> 4.2V leading to adc_battery_helper_get_capacity() reporting a capacity
>> above 100%.
>>
>> Do not use the table entries with a voltage above 4.2V for non HV cells
>> to avoid this use.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> I think if you use a struct power_supply_battery_ocv_table and the
> interpolation helpers I'm pretty sure you get this bug fix for free.

Ack, this patch will be dropped for v3 of the series.

Regards,

Hans



