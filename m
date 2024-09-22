Return-Path: <linux-pm+bounces-14532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2736D97DFD0
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 04:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB14A281705
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 02:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF39618F2CF;
	Sun, 22 Sep 2024 02:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctOj0FAL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9D21E529;
	Sun, 22 Sep 2024 02:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726970859; cv=none; b=JecuxHdAg450Mk81dTVHBWu6qmTUdm2RL1SnLX7mIrBaemSwgLjnchgfrQWxq1bD3XS3qyKcwvu+9lYL2kxj0GXB51vA+eeFtxVkV+BFodM+voc4MGumLzuMRJfFQ+wk7+D1H5reutbY3Nw5zqJPuIIB14KL2bOxaUVlQ6nqDFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726970859; c=relaxed/simple;
	bh=Ga9yAiHhhCAY/j9jBJ+fqSp5cm7HoOFURxXd6JyAZqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8TkSbWHj+iGR1Mzl/WV5HCyTakBqBIocxR40Ibtr2JR8JCCYm5m0R3jkJRNAjyI+72VQiPpRugYOflK884C+jfy+yQOi6xWBGIUWWYPbX7bKIqMRqYJxjDVp7Ffac6mzKNSjkzI5YcuKXvvNpTKcnfl5vydYbjs8WzvH79KW7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctOj0FAL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42e5e758093so27530255e9.1;
        Sat, 21 Sep 2024 19:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726970856; x=1727575656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9oohvC6lTfiSYwOYed900cv9HTEJuIzCC7mv3WEC2cw=;
        b=ctOj0FALDiV/HbB0n8gDItxMTFf5Mqa/5xhGjngPorh/5kGLH6uxh06SGf9L3ozyMH
         8sUiu99drj2Whf9edImKX8oX29o5VC2HhTPdMdD/9nmZPJpBbWkrBi/Sgd9FsVp+jY/d
         5qH4zeR6qRBYCcsf5JBOS9Yeenn9QVQdrXvAOxcWwac7VDeg5WH/9Batyu1g9XWbiWxl
         ofwrfyDuS8euqzy6tQl29+MFpKQIHyVPEI1EFECwTtHt1+cvjiD1sV6Jfi1/isFWHQEI
         1FQ8MaACUYpD8PKrpyixH24jevIoqv17reKtMAqjbzaIB6bCtlblYcOu7yav6p9/62GF
         F1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726970856; x=1727575656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9oohvC6lTfiSYwOYed900cv9HTEJuIzCC7mv3WEC2cw=;
        b=JS3Am89ILXp+fPMO8CUVZdQuQnnI+d1CbXWBGIXEJmndoFmYoobL+n/QGHjhQ/fpQi
         OORwndp2peH52tfmDWF1aZUQmlA1gYPfflOlU+CuiNnQvjgnmQJbFBrxK3ZerJ7Dmy3q
         k86FQ95zU76BT0gkaEjh1Eq4Y5EBdE+hivtqo++5oRsOJKkdfjQajIAdk7MOekKiE9be
         KM0g0R57M2B+TBT+GfssOBBcbVeTu7jHuVZpCFF9QFMtYKGUwsifJyGnrj8gWt0mzBse
         VmEkZcRaRKtyX53m6Y0qcR1HlapdTYN1jxJpTcC5IxcGBWxowAPLSQFsvvY9XphxYMyn
         OOfA==
X-Forwarded-Encrypted: i=1; AJvYcCUED5dA/FQVdXlpsVnW9CKJBAFtNsdwfFAv8gOxlV/+Po87BaX2OzDCgmyFUuukc0JZTA8ZguEtJ72H2FxFVksc4Q/Flg==@vger.kernel.org, AJvYcCVhYTRmm33vTGCxXQDzcp8XEjRDPfdFn9hcADS1NPBQiDF/mOzs6kKAkuuieUV2Jxng12CQH4Empg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yznboycq+njyqs4lghEZoNdyyIz+ELNjNdASFyJboWxSLGVe8pY
	GXpu5sSbTn2QI/YFF2HBvIgetXVJol+U+JSttpb5+utnbJDPkXYuWMXLtGJK
X-Google-Smtp-Source: AGHT+IGcpkVwGXrA9CQpkzepX3rS1Hzev6lDrPPoCNhq91QaZXLWpV5OUk7yV2HUjGX1yR3URVkWhA==
X-Received: by 2002:a05:600c:1907:b0:42c:b6db:4270 with SMTP id 5b1f17b1804b1-42e7abefbb6mr53611725e9.11.1726970856019;
        Sat, 21 Sep 2024 19:07:36 -0700 (PDT)
Received: from [192.168.1.127] ([151.95.37.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7ae5fce0sm63606665e9.10.2024.09.21.19.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2024 19:07:35 -0700 (PDT)
Message-ID: <30b8c512-d76e-4acf-892e-fad7a6bb1127@gmail.com>
Date: Sun, 22 Sep 2024 04:07:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] acpi/x86: s2idle: call screen on and off as part
 of callbacks
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Mario Limonciello <mario.limonciello@amd.com>, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, luke@ljones.dev, me@kylegospodneti.ch
References: <20240919171952.403745-1-lkml@antheas.dev>
 <20240919171952.403745-4-lkml@antheas.dev>
 <7c604018-59a3-4b70-83d1-06f0ed858b73@amd.com>
 <CAGwozwGSVAExH_9zCCKreC88J0FRU4ZM3RkBk==HvRwCUuuqLw@mail.gmail.com>
 <25b14b4f-96b7-453c-b876-6a46c4f3789c@amd.com>
 <CAGwozwHmd8yHzjbutOd4T39h5CZRh2rOWYH4V4AnLN+RXrRRnQ@mail.gmail.com>
 <f164e172-0030-48d0-9c33-aaaa6d0cc6ff@gmail.com>
 <CAGwozwGNg8XZcY0AhfMfKXJo4P4Xmvn7e2Bt2gZ-emSAsn24qA@mail.gmail.com>
 <31eb2289-633d-47d8-8609-e9994d7f8353@gmail.com>
 <CAGwozwHDW_m7gx8Fb-CQUz_TtSA=G7hx37NCqntm-hYKhRf8WA@mail.gmail.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <CAGwozwHDW_m7gx8Fb-CQUz_TtSA=G7hx37NCqntm-hYKhRf8WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/09/24 21:44, Antheas Kapenekakis wrote:
> Hi Denis,
> 

Hello Antheas,

>> Beside, as for necessary kernel/software quirks, the new firmware is
>> expected to require none, at least for asus-wmi, so I ask you to leave
>> csee calls where they are now as in the future those will be used only
>> on non-updated firmware.
> I'm happy you said that, as it means this patch will not conflict with
> the new firmware and will just fix older devices.
> 

You are currently attempting to fix a problem that does not exists (or
you haven't made us aware of), in a way that is causing regressions:
no -- calling csee twice is not a problem and we have absolutely no reasons
to suspect it is.

First: the onus is on you to justify, with logs and a thorough explanation,
why you are modifying a module. You have so far failed to do so.

Second: give us explanation of why you think downloading games with screen off
has something to do with the asus-wmi driver and belongs to the same patch series.

> The only change my patch does on the Ally specifically is pull CSEE
> earlier and remove the extra call. There is nothing in this patch to
> explain what you are experiencing. There are a lot of causes I could
> point my finger to, but there is no point.
> 

A compiled version of the kernel tag v6.11 has mcu_powersave=0 working flawlessly,
that very same kernel, compiled with the very same .config, with your patches on
top exhibits what was documented: there is no reason to use fingers here.

So... for one your patches do something else (and they seems to be related to
activities done in background while in s2idle), and two you are saying that
since you don't understand why a regression is happening it is okay to ignore that.

> We will conduct our own testing, and this will include the original
> Ally as well. A lot of them actually, and after initial testing this
> will include thousands of devices, as we plan to fully dogfood this
> patch.
> 

I will be here waiting for the result, when you have identified the reason of regression I
documented, include me in CC or reach me out privately with the work ready to test.

> I was a bit busy today, so I did not update the patch. I want to
> rewrite part of the cover letter, as it includes some inconsistencies,
> and rename some variables. The inconsistencies have to do with how I
> describe the sleep stage, as I read up on some additional
> documentation, it is not related to the contents of the patch. In
> addition, it seems those sleep _DSMs cause problems on the Ally too,
> related to TDP. And no, I will not wait half a year for a BIOS update
> to fix those.
> 
> I am also looking into how to integrate Modern Standby into the
> kernel, in a more full featured way. Downloading games in the
> background is a very requested feature after all, and since looking
> into the Ally's _DSM entries, it seems like it is built to support it.
> Background here would mean the fan will be off and the suspend light
> will be pulsing, so you can safely stow it in a bag while it is
> downloading games. However, this is conjecture until the patch for
> that is built and tested.
> 

Again, userspace software running in s2idle has absolutely nothing to do with
acpi entries. You need to decide what this patch is all about:
If it is about asus-wmi then identify and solve regressions before resubmitting.
If it is about downloading games while sleeping then create a new idle driver
(this way you won't risk breaking what has been confirmed working for months or years),
do a request for comment on a proposal, or propose an interface to the userspace
that applications will use to carry on tasks while hardware is in s2idle
and drop the useless asus-wmi part as it does not belong there.

As it stands this work does not solve any problem and does not allow downloads
to happen while the console is sleeping: pick one and follow that route.

> Antheas

Best regards,
Denis

