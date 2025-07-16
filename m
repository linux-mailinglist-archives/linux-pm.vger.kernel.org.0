Return-Path: <linux-pm+bounces-30953-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C09AB07F67
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 23:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11663B4886
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 21:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E9B19E83C;
	Wed, 16 Jul 2025 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOBhMT+W"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D03A2AE8E
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700619; cv=none; b=AG4jtXLbwAQAWxcULf+fsyeAPH0CqBDJLLypdZNY3WDdOETj4etQEg2mkxYM67bPw45TAzBEDtH3+guqMIvfMMv1U4gbkklXol4S3YUta9m8ZjRS8J53XH1QZnBF2S8O7U9A8WBdNEJP9opZ9/maVgUBEAZZ1PDjVQWoWGMpkTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700619; c=relaxed/simple;
	bh=tcjGxbzYfT2qRkY4hws0v2JK/cBslhaPDsQnhrpt4BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EpkydUXE7yDJFPuXQSY0TidqVYs7JfGR4sXfnn03gP4BLcjlwbnG7z1jn6001wFjjxqIVA7uvhA/yQHs2wLsauM/6yLmjR766XApzBe42xectC7RVAsZPfQBrDZUprMSdnzn+hZjg6HTKPwuQ8VjOrX35DIsRXnwc/5qpll6Lps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOBhMT+W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752700616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3oZFjKuSvQRdJFWBBzC1ZFh8hwPphkcoQq9dfmPG380=;
	b=EOBhMT+WCRfM4ZSuOMpi7o2gTedLuQd4nCZXZF+D9RXWDYzm54WKHTr+rFDqM1KdgcED/T
	5dhkhbs4r/YiNoeF5rfS5BFk75F1T9YEFrkKpPViEVbnKpZdCZDfeEXeCCA2hDr8++Gwke
	EPOBwt6sDk47yXdLnYq3blHvMy7ZAk4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-YyaeGlVmN1KtsS0fSa8k-A-1; Wed, 16 Jul 2025 17:16:54 -0400
X-MC-Unique: YyaeGlVmN1KtsS0fSa8k-A-1
X-Mimecast-MFC-AGG-ID: YyaeGlVmN1KtsS0fSa8k-A_1752700614
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ae3c5ca46f2so19090766b.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 14:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752700613; x=1753305413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3oZFjKuSvQRdJFWBBzC1ZFh8hwPphkcoQq9dfmPG380=;
        b=UO1Z7n6o8PNScltWK07YgiCQWcVDIDDe2yw/noNDztZ7dttgX+F7Gx0bnRUPkaUQgQ
         iDH7mDql+cCGYF7sYMM+5Rax67iA/TQBx4KT31naiX0ZjxtQY7VcMVk0jR7gYo+NhbBe
         SqoKediW1ISrbUEO4lmMaMy+mQFeWCjqqmQhx3K0dlWzcXW5Gbv1iOInAivsE0Odtsgh
         Pa7yt1xMGG/2NqNeTqDzRnGf8kww7ncExiyxyB1zCWOG9Yq/mrerFeCvVWm2xjLvGm5K
         /1/v+KxcfQVixjvH0Qb1lGfTE2nfjHPiOpLfpsxaD+zDFcBW7jXcV3ahl/HxE/oLAYzi
         2IHg==
X-Forwarded-Encrypted: i=1; AJvYcCWTRFRZAT9CqsbmaXPOQSy4XVrmzIhIjyopDIBE8h/T4vMnbr3XuHIeLVzYJn1c5sh9+NLiNh4JLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMw5QTRQ8XV7NjIB2VAiwi+TSS327bqSWIEWvxUTmMRxG8wEOL
	ns4geb2K3S6HREq+oU0VNkQin/jP5a2C3JUT10YVfz6q8EvIkKTDPg0r8+viKpfG3+dMmacZUzs
	Na1X1GMYoxI1ZC1To/SG208dCN/QF2AdIp4fR+bz3j8pALn+Fb2DJO4NkS1OU
X-Gm-Gg: ASbGncvuM53H3ncg+Rg2aSVf5DEv4lPCO/kxOno50RKR1UvVHwYNrE3LmMHj6GX/DwM
	6/jgjWSGH7CMo8e4Qg5sShacqe6EwEub2xzbCobaJ1uaKBgCUWbu2PZIGoUMfU3R6ySMTlhRiwU
	jTlnUY/5CDuQEOVQGNP+vTyu2T6oxYF5OtSDmnlon3VV7V3qnXwJjjutCkiOqKgkdahYFGSpuVV
	d7KiVqT4uqHaWTxAX7QiTngpNA1Hj6JwPQ+CXYXYQcJHYGumiPIJnb+U+kFxPPnIEQ7nAfz8QYO
	dJkEwWVKxUm7+yZ2yWUffCaDe5eweJ0GtQpXpwRC3om/f7LKJrKcAyFR4yFX7bYUwB+DAw1QNhZ
	5BqglBQJ0Ty6UgRe83uYpY5Xd+gEKvWLfGkKj+hQ78lhZx8DaD3bvHoxyRE2G3nnJePSnsjKlYc
	ptKRSUiRhZTQ0U+g==
X-Received: by 2002:a17:907:cd05:b0:add:ed0d:a581 with SMTP id a640c23a62f3a-ae9cdde83a4mr403036966b.17.1752700613604;
        Wed, 16 Jul 2025 14:16:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeaWZnT5Yr74rCS5uGahUnwTFK3i1c8AEjzxYnVRq/aJIVd2XlYvT5wHSWBtdmWLc9jCoLzw==
X-Received: by 2002:a17:907:cd05:b0:add:ed0d:a581 with SMTP id a640c23a62f3a-ae9cdde83a4mr403035166b.17.1752700613223;
        Wed, 16 Jul 2025 14:16:53 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294bf2sm1225989966b.122.2025.07.16.14.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 14:16:52 -0700 (PDT)
Message-ID: <2a588cd1-94ca-4b39-a76c-0f18352df632@redhat.com>
Date: Wed, 16 Jul 2025 23:16:52 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] power: supply: Add new Intel Dollar Cove TI
 battery driver
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
References: <20250107113346.170612-1-hdegoede@redhat.com>
 <20250107113346.170612-7-hdegoede@redhat.com>
 <CACRpkdb-YQZeJ4igWaJAr-FwokW721tdM28TtgrZYtar1j=Ydg@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CACRpkdb-YQZeJ4igWaJAr-FwokW721tdM28TtgrZYtar1j=Ydg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

On 9-Jan-25 8:09 PM, Linus Walleij wrote:
> Hi Hans!
> 
> This patch set continues to be intriguing, I like it!
> 
> I try to help out as best I can, more comments below.
> 
> On Tue, Jan 7, 2025 at 12:34 PM Hans de Goede <hdegoede@redhat.com> wrote:
> 
> 
>> +       /* Read Vbat */
>> +       ret = iio_read_channel_raw(chip->vbat_channel, &volt_raw);
>> +       if (ret < 0)
>> +               goto out_err;
>> +
>> +       /* Apply calibration */
>> +       volt_raw -= chip->vbat_zse;
>> +       volt_raw = volt_raw * (VBAT_GE_DIV - chip->vbat_ge * VBAT_GE_STEP) / VBAT_GE_DIV;
>> +       *volt = VBAT_RAW_TO_UVOLT(volt_raw);
> 
> This thing looks like a property of the ADC rather than this charger.
> 
> Can you not simply implement this as a processed channel in the
> ADC driver and use iio_read_channel_processed[_scale]()
> with IIO_CHAN_INFO_PROCESSED?
> 
> (The _scale version is used when you wanna just say *1000, which
> you often want to do because these tend to be microvolts or
> microamperes).
> 
> See drivers/iio/adc/ab8500-gpadc.c ab8500_gpadc_read_raw()
> ab8500_gpadc_ad_to_voltage()
> for a (complex...) example.

Interesting. I'll try to switch over to this and move
the calibration calculations to the adc driver for v3
of this series.

Regards,

Hans




