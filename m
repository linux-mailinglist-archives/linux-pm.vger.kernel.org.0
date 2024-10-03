Return-Path: <linux-pm+bounces-15127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0393398F9DA
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 00:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6AC1F21983
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 22:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213911CC171;
	Thu,  3 Oct 2024 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aftspkBY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797A0148316;
	Thu,  3 Oct 2024 22:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727994478; cv=none; b=Yniqb8CQ2LDgyfy8eZNdylqBvnjHqY1+uY/2ts+Kla6+3jHmYSqdhPLaaW5VMB9LROXdfHbMeZeOBL6RbCvNVhicceTLqXoRfuEUlsanMoLPeLhDIygJh8po0CWE/wt5XxrGUDVeCtxRVFVPAVsw1cl1SN905EyKyPOP6Meu5YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727994478; c=relaxed/simple;
	bh=uu2x9TKpC908OMI4yRbTHNSyl2uAgyko3/e+XWCSaxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oItK2W0S2a5QblR5vB8I3w5+iMYcBg6GRBTUfw5+eduRogGbUJLqlVaXhwkbtwmtnMREF+EfMSxV2mJ8JK67vpFJNrJv6MCYSMhW0sXaUFvfJpke3DJEBAFj/eyHIEnMbSZScAwMtgRmBMknx7792eo5EW4KNviHJGd8/35uzas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aftspkBY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cc8782869so14424075e9.2;
        Thu, 03 Oct 2024 15:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727994475; x=1728599275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sP5+xFCwvIfgdPuM2uoWieb2IVBCdlsyGhb48u2injk=;
        b=aftspkBYERoI38blv5n8m1cN5RJX2+SrGhU0qozhztfUzP2exVA+o5DiqoaDT7iNiw
         aEbqQ+mJnCOt16PTQLgTxUIlYsTs97ZKxayxKJttpBdCM6M1eRBOle/cdaqQQGI0efRK
         kX65WkkPoTusrMbOHgHCCxvVkd6vTN8LurRhm1DvYBwHQfOKWMm5kOQ/7EuW4o81it1C
         P3x+Oan6oQIs3MrVJGecxU2hSBhYjgRQ0/BvbOW8dIzTjithBNX+6CMyJZboIxSbHizN
         QOmQmS4l4JDBMM2reSTnvc7thEUw6eDp2G4PCWizwhE4pH82TR/dCoNwRDo58XxgCceU
         UlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727994475; x=1728599275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sP5+xFCwvIfgdPuM2uoWieb2IVBCdlsyGhb48u2injk=;
        b=btMI3f4Q7BpdcCQ9weJObhzTPyl/hQsqVYAzJo98jX3+JAIZUo9bTVzVif1NIG9Jzi
         rp0AxYgmoYCCIjU/stZA96nYFrp0tPD8Njc6lRMRk8kz9SD9PJGhUdSz2uCTWBt8Q2WI
         nLv6SfeIhgslGJ7n8H3mokejtR/+bqYRhs1HCjPLCg/SYb/4Mhpuji9NhVFyvfNHuRjN
         ZFPqqRA/7lBizz7oMd4/QfCfD2No/GydqUmOyRW+oXC/V3U9HbE8HDNFcBt5UN6NKEiZ
         SdaCXUu2frdC4qE3q8fkhw2HrR0wVxFIOCUh85l3zZ3JvOUX3P6H8yTX0Ibe3FY+k81b
         mvdg==
X-Forwarded-Encrypted: i=1; AJvYcCVD86tsjPbwyZiBFENHW9iUz8EztIyPzcMoIQ/vV4F8pF6DpbjWohhlPyFlczkCoonbAO9ZuDkpN+EunMk=@vger.kernel.org, AJvYcCW/Bl3LzXO3HejELiR5kio9Xfv7TlKME/I9aDcItfkx4v26dg6pWRH9uZs6bx08VNmq3v45hOI7UBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsY95xUTGhMtoNEBeJcA845y3Dv1nV+Nfe1j3mEMzRh9hwuivl
	njJlRG/MNs1QkV1B1hcJglUqH4Kbt9LG1fumwv7RNg+McRr8dO+H
X-Google-Smtp-Source: AGHT+IHDKi8be1luFvFObKCgtE8dWUy8+2N6ax404drWFKWhO05Bsyimgoa7KQJsvRhzNjmZfQyg/w==
X-Received: by 2002:a05:600c:3b8a:b0:42c:b95c:65ba with SMTP id 5b1f17b1804b1-42f85a6ca96mr3117955e9.6.1727994474417;
        Thu, 03 Oct 2024 15:27:54 -0700 (PDT)
Received: from [192.168.0.10] ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a1f6b4sm355535e9.6.2024.10.03.15.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 15:27:53 -0700 (PDT)
Message-ID: <ae30adc7-8bcf-4daa-923a-d4a12e2404ea@gmail.com>
Date: Fri, 4 Oct 2024 01:27:50 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Erroneous sbs-battery sysfs info a MT8173 Chromebook
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Pin-yen Lin <treapking@chromium.org>, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <6e341522-70f6-413c-b9ba-8ac86a19b5f3@gmail.com>
 <a83e80f7-2bb8-423d-b24e-e793ce5da988@notapiano>
Content-Language: en-US, tr, en-GB
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <a83e80f7-2bb8-423d-b24e-e793ce5da988@notapiano>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2024-10-03 19:08 +03:00, Nícolas F. R. A. Prado wrote:
> On Thu, Oct 03, 2024 at 06:15:49PM +0300, Alper Nebi Yasak wrote:
>> Hello,
>>
>> I have a MT8173 Chromebook ("Lenovo 300e") where I'm getting a lot of 
>> battery-related errors:
>>
>> [   34.678473] sbs-battery 6-000b: sbs_read_string_data_fallback: Returned block_length is longer than 0x20
>> [   34.702079] power_supply_show_property: 5 callbacks suppressed
>> [   34.702096] power_supply sbs-6-000b: driver failed to report `technology' property: -22
>> 
>> [...]
>>
>> I have _another_ MT8173 Chromebook ("ASUS C202X") where things work 
>> fine. But I couldn't find a good mainline kernel version for this one.
>> Anyone have any idea what is going on?
> 
> FWIW, I have also experienced issues reading properties from the SBS batteries
> before on chromebooks:
> 
> https://lore.kernel.org/all/924db470-8163-4454-8f59-f7372a132186@notapiano/
> 
> In those cases it was due to the EC firmware not implementing the SBS commands,
> but that had already been fixed in the latest EC firmware release, so simply
> updating the firmware fixed it.

(Replied there as well for a different board: cozmo)

> I don't know how ectool works, but it might be fetching the battery properties
> through a different mechanism (ie not SBS commands), so this might also be a bug
> in the EC FW despite ectool working.

AFAICT, ectool talks to /dev/cros_ec with EC commands, which makes EC 
send SBS commands to the battery on its own; whereas in the kernel 
driver case it passes kernel's SBS commands through the i2c tunnel.

But never mind all that, I should've looked into ChromeOS kernel 
sources. There's a limited i2c passthrough [1] that's implemented there. 
And this specific battery is failing to recognize a read command due to 
a stop bit or something, so they use this limited passthrough [2]. I've 
managed to apply those on top of linux-next and it makes things work, 
but I have no idea how I'd go about upstreaming it (comments on [1] 
point out it's quite hacky and not used in later boards).

[1] CHROMIUM: i2c: wire a limited smart battery passthrough
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2230594

[2] CHROMIUM: arm64: dts: mt8173-hana: Add google,limited-passthrough property
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/422609


