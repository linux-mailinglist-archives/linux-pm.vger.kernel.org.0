Return-Path: <linux-pm+bounces-27553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FDBAC2184
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 12:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769F23AF4E2
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 10:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD99F22A4FE;
	Fri, 23 May 2025 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RMgPcdtV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1989314A627
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747997530; cv=none; b=QsBtCmDrVGl+dWUOI0t05FS6L+xq+R5/8DyaNhNz+lZ3cbULs6Y7X5Nni++OiZKVUYgILiKdA5qwPGmfQd+svSMUtb9lN2tVLBp3gpoYUkKYEe2jkkOK3SILP0SdKfKeQi6WMXdSTKCvTFk80sOqkDcpvgSgWHrapT0u/Y5VQQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747997530; c=relaxed/simple;
	bh=j1XZzWdwtTmEvvN2qv3t6z37DY91Kr1PWlQJJLrpV1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=My01tA23b1ZbRfTdBCgcZQ2LQWcHe0kFFdZWg1rF6U6mmEpB01tvOx2TwhrRCmZTX+OJ9M5Cgg8M61Lv/ijAnW6HU/SMqfZCmhuV6eUXTooJc2QKy5k4dl97+hlh35YwkrMrWgyD16y0kY0oQAxDxO+IQsWlhd/0yVfiTJrad4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RMgPcdtV; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f3f04b5dbcso13664282a12.1
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 03:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1747997525; x=1748602325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XwP8jYnybIYdZwiFlF4p0pHyTP1yOv6D4gpD/fnEuLY=;
        b=RMgPcdtVQFRHdCZBiBKbtXQG0qgQDhPDt74zDK4mNDBZ7sYmm+FzV0Z1DZgY6j37xe
         123Ske63/i4rSU2z5SlP0szNl0B+YECVWvMx1/tQKz0qJ3COzgGz4lA3osbiZkNX0C/l
         tOkoV+0oDUOajEvaw6DeddEriNwIueCo8cCMkoijQpy5QkLJlAv56KkWHEhCOyqEz0yZ
         4hfO3Vj4XD/m3HB3RNRyfdpHttBJ96fQhSiLlyZnXqVgMUvVU5ONK43IzesqtQ0kyye9
         5INYQUVR0dXL0AoplQZJW9b1KVTPOX3NnfdLby7Ay1N+tdY94glxR/O2oM7MyZqD76Am
         IHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747997525; x=1748602325;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XwP8jYnybIYdZwiFlF4p0pHyTP1yOv6D4gpD/fnEuLY=;
        b=vFlnz4caizka1d6X5gbOnJlgFEvukJUOlApZ3+pFjFKWDDjDpqC4P1ZwnQ/d88LO3U
         V06QPcmxX2QaJMc9wcjvIoKsRKiRE306e9Cq2l+zoK3szMT9f05L+nmKPdPortcm9YQY
         PcP68417/NwthuyKqPVmTOoKJ7C3Vd8R03OWdaQzK5w4r1nqkMvqG33f/wGpZQi/29yB
         zbOXy8vPl43yCf6ZMNRn7VS4IE6JgbNiGq71p+FGSODXnxwkaTChuC8TkswP8omK9cV9
         2sewmzG82K7q/40TE2q5/zTvNy4Y9se218UOQkLkm17pUCtk7gLbJDI5gs93Fxa2dncu
         k2AA==
X-Forwarded-Encrypted: i=1; AJvYcCXqz2n+9QX+5v8M6wcxlZEJIcEViH49Oe9BWByNkSB5vqkSUGfSx7No7T6PnHvjdHplnxIlDSgk9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1xquRWPWppy0H12OAXa5YamI+yCRqvZNgwEsZEJ7xlqh2fR8x
	/7fe3OKuRQp3WDMcklDzS6MCLxgew+GV0pr16fbeftt3pWrks13UOypn/P/V6dY6by0=
X-Gm-Gg: ASbGncvDHSGY+HgsoZF2u9rkwCQN/1WwxLvrfdr/rfOQ2R8Bf1tvR0Q5ZhBOcrPidm5
	FYh20mGVGSPIekIYrZiCSgfLhlbd0aqE1uXTpGMIttgGBqnnTC7QVzL7neZa/JcCXq2wcQtmPRR
	WUy208vIMGJp+GOsSvGG2tkue3GHYbOL9n+b6SGmjr3DDuB2pMHxLGFl5dMPw8hdJAcEfMR2z9x
	QuA6xkeWiTR+ReL4jYECbN/49UhPkz9hj0kOfJY1SbxgfK6cRKzQmRuGreylHItSxkwp5kiPGbw
	bBDPYzKFpUkSErh4TfQcOKi6YOEkzzzHxRKdZgzOxpkEGZ9qC0Avy2woHwbJeio7UXOsPA==
X-Google-Smtp-Source: AGHT+IEC4yMEc83C32Rd4QKL4hSK5Wu12v5T+oSzGSvYSxS2+OO278DiRhv1/vjRF4GiSVkrB+WCww==
X-Received: by 2002:a05:6402:2709:b0:601:9dc3:2796 with SMTP id 4fb4d7f45d1cf-6019dc32a0bmr19644753a12.6.1747997525189;
        Fri, 23 May 2025 03:52:05 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.58])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005a6e019asm11583614a12.36.2025.05.23.03.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 03:52:04 -0700 (PDT)
Message-ID: <47853bb8-db03-42b1-bcc2-3338fc208abb@tuxon.dev>
Date: Fri, 23 May 2025 13:52:03 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 dakr@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 bhelgaas@google.com
References: <CAPDyKFqMB7XutXba73YHx1X4rm6uc3Fz6yMZ8yM=wgduEmgUDg@mail.gmail.com>
 <a20fc6ee-c6c3-4013-b175-4918b9a44380@tuxon.dev>
 <CAPDyKFpbeLJUiB_xQbqDib+-8Q3AcJNVg+DuEcqmVGMbFdNxwA@mail.gmail.com>
 <fgl4w5uhxci7rrbdigtni72vveb2gqemh6iccz4qruqkek5rja@rzwkcjg6hkid>
 <3b1963ba-f93f-48f2-8fb0-a485dd80ffcb@tuxon.dev>
 <CAPDyKFqrAS4iV59S-zJ9H7_3VuGr9JdZABhfUGBwTzQNDCasaw@mail.gmail.com>
 <482b55c9-a210-4b2d-8405-e9f30d48a8fd@tuxon.dev>
 <CAPDyKFpLF2P438GGWSgbXzpT7JNdUjtZ2ZxYf1_4=fNUX3s-KQ@mail.gmail.com>
 <4fzotopz57igmiyssgkogfbup6uu7qgza3t53t5qsouegmj7ii@wfiz4g3eiffs>
 <CAPDyKFoxs6wDCLp5EGHVqkqSstBLNmngps2KfanRezV_EN8tuA@mail.gmail.com>
 <hd3hobuaunmn2uqzl72yv7nz2ms25fczc264wmt6o7twrxdhsy@mm22ujnawutc>
 <CAPDyKFpRUhTK=UfcEdRdT0f5EVoGN5okLosd9_tYjdGKr0qvkA@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAPDyKFpRUhTK=UfcEdRdT0f5EVoGN5okLosd9_tYjdGKr0qvkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ulf,

On 23.05.2025 12:47, Ulf Hansson wrote:
> On Fri, 23 May 2025 at 01:06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>>
>> On Fri, May 23, 2025 at 12:09:08AM +0200, Ulf Hansson wrote:
>>> On Thu, 22 May 2025 at 20:47, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>>>>
>>>> On Thu, May 22, 2025 at 06:28:44PM +0200, Ulf Hansson wrote:
>>>>> On Thu, 22 May 2025 at 16:08, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>>>>>>
>>>>>> Hi, Ulf,
>>>>>>
>>>>>> On 22.05.2025 14:53, Ulf Hansson wrote:
>>>>>>>
>>>>>>> That said, I think adding a devm_pm_domain_attach() interface would
>>>>>>> make perfect sense. Then we can try to replace
>>>>>>> dev_pm_domain_attach|detach() in bus level code, with just a call to
>>>>>>> devm_pm_domain_attach(). In this way, we should preserve the
>>>>>>> expectation for drivers around devres for PM domains. Even if it would
>>>>>>> change the behaviour for some drivers, it still sounds like the
>>>>>>> correct thing to do in my opinion.
>>>>>>
>>>>>> This looks good to me, as well. I did prototype it on my side and tested on
>>>>>> all my failure cases and it works.
>>>>>
>>>>> That's great! I am happy to help review, if/when you decide to post it.
>>>>
>>>> So you are saying you'd be OK with essentially the following (with
>>>> devm_pm_domain_attach() actually being elsewhere in a real patch and not
>>>> necessarily mimicked by devm_add_action_or_reset()):
>>>
>>> Correct!
>>>
>>>>
>>>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>>>> index cfccf3ff36e7..1e017bfa5caf 100644
>>>> --- a/drivers/base/platform.c
>>>> +++ b/drivers/base/platform.c
>>>> @@ -1376,6 +1376,27 @@ static int platform_uevent(const struct device *dev, struct kobj_uevent_env *env
>>>>         return 0;
>>>>  }
>>>>
>>>> +
>>>> +static void platform_pm_domain_detach(void *d)
>>>> +{
>>>> +       dev_pm_domain_detach(d, true);
>>>> +}
>>>
>>> Well, I would not limit this to the platform bus, even if that is the
>>> most widely used.
>>>
>>> Let's add the new generic interface along with
>>> dev_pm_domain_attach|detach* and friends instead.
>>>
>>> Then we can convert bus level code (and others), such as the platform
>>> bus to use it, in a step-by-step approach.
>>
>> Right, this was only a draft:
>>
>> "... with devm_pm_domain_attach() actually being elsewhere in a real
>> patch and not necessarily mimicked by devm_add_action_or_reset() ..."
>>
>>>
>>>> +
>>>> +static int devm_pm_domain_attach(struct device *dev)
>>>> +{
>>>> +       int error;
>>>> +
>>>> +       error = dev_pm_domain_attach(dev, true);
>>>> +       if (error)
>>>> +               return error;
>>>> +
>>>> +       error = devm_add_action_or_reset(dev, platform_pm_domain_detach, dev);
>>>> +       if (error)
>>>> +               return error;
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>>  static int platform_probe(struct device *_dev)
>>>>  {
>>>>         struct platform_driver *drv = to_platform_driver(_dev->driver);
>>>> @@ -1396,15 +1417,12 @@ static int platform_probe(struct device *_dev)
>>>>         if (ret < 0)
>>>>                 return ret;
>>>>
>>>> -       ret = dev_pm_domain_attach(_dev, true);
>>>> +       ret = devm_pm_domain_attach(_dev);
>>>>         if (ret)
>>>>                 goto out;
>>>>
>>>> -       if (drv->probe) {
>>>> +       if (drv->probe)
>>>>                 ret = drv->probe(dev);
>>>> -               if (ret)
>>>> -                       dev_pm_domain_detach(_dev, true);
>>>> -       }
>>>>
>>>>  out:
>>>>         if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
>>>> @@ -1422,7 +1440,6 @@ static void platform_remove(struct device *_dev)
>>>>
>>>>         if (drv->remove)
>>>>                 drv->remove(dev);
>>>> -       dev_pm_domain_detach(_dev, true);
>>>>  }
>>>>
>>>>  static void platform_shutdown(struct device *_dev)
>>>>
>>>>
>>>> If so, then OK, it will work for me as well. This achieves the
>>>> same behavior as with using devres group. The only difference is that if
>>>> we ever need to extend the platform bus to acquire/release more
>>>> resources they will also have to use devm API and not the regular one.
>>>
>>> Sounds reasonable to me! Thanks for a nice discussion!
>>>
>>> When it comes to the devm_pm_runtime_enable() API, I think we
>>> seriously should consider removing it. Let me have a closer look at
>>> that.
>>
>> I think once we sort out the power domain detach being out of order with
>> regard to other devm-managed resources in bus code you need to analyze
>> this again and you will find out that much as with IRQs, devm API for
>> runtime PM is useful for majority of cases. Of course there will be
>> exceptions, but by and large it will cut down on boilerplate code.
> 
> Well, the problem is that the interface is just too difficult to
> understand how to use correctly.
> 
> A quick look for deployments in drivers confirms my worries.

Maybe we can add something like:

diff --git a/MAINTAINERS b/MAINTAINERS
index 96e64f3d7b47..568a8307863b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10100,6 +10100,7 @@ F:
Documentation/devicetree/bindings/power/power?domain*
 T:     git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git
 F:     drivers/pmdomain/
 F:     include/linux/pm_domain.h
+K:      \bpm_runtime_\w+\b

in MAINTAINERS file so that any new patch using the RPM will also be sent
to PM maintainers and checked accordingly?

Thank you,
Claudiu


