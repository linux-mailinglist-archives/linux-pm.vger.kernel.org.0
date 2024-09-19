Return-Path: <linux-pm+bounces-14459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA72E97C8C6
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 13:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3448B1F2374F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 11:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E74E19CD0F;
	Thu, 19 Sep 2024 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FoWW9S78"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D3C19CC34
	for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726747036; cv=none; b=c+5r/h2CkETYeOboPlJxn23Tr9E5s8gdgaF7wZl4jm30xVbNe8ZgUIVr7+DmGBhWTcXFEhxp6XypRwPxBqvQTb8KGh2wBRz6ONfjwZ7Eo3EurjKul1jbEcsJm4HPvNuSEoOWKW2+XWtyhndyrYInGg82Hzd38g4Bvtf1LbI9KeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726747036; c=relaxed/simple;
	bh=ZHVTezqsCQlUHEGrX6hFZU1B6LZK+FhI17DOKZdICPc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=dON3K/jnEj0xUBxsu8dy/Patiogir0gCz4257HqCYZdfu5dmIS4NXZtjavdoE8bOtXgATW4D+J4ndDarPHMi1ogn4Pa4rzAbnZbdi4g8nmUPVXMjgNLvTeFAiUiruPQpDhfJvpo5seKV4uZBSRljp2FM71ZQcLKojMntftOqkaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FoWW9S78; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726747033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VMtVCWKVVmEyhvCEKpScY7O+6/a/Rtk4FugRCP8H+l8=;
	b=FoWW9S788FsRpb46fhfHJRaRJhIAgYEXmMeidqFqDvkEuiPwgtPRtO41iJspUI9PcAoeoN
	w+627I0rB8A0LmZIc+PK+/ivf+xaS7s37RQR82CPR+O+lsY2+y05jKOFczufE4Dgi+3ZYQ
	tPCJkrD8XEosXOoOSEv3MCHdIDDUAlg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-EBkb_Z07MCW_Dj2ClPxj_g-1; Thu, 19 Sep 2024 07:57:10 -0400
X-MC-Unique: EBkb_Z07MCW_Dj2ClPxj_g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8ff95023b6so54027466b.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 04:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726747029; x=1727351829;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VMtVCWKVVmEyhvCEKpScY7O+6/a/Rtk4FugRCP8H+l8=;
        b=PSsExNTX7bQnEcijiAtIL5fAWQXYKMeNCL+s0OuG3FpacH3MkfxBYVOLrgcBEbAFPH
         Tyn/tpmQUnIZ7T8jx/eWqMQQBcF1PKcMoi3yXpln4FQXsrmRiq8WQNKCiw+V2lrtCwmY
         7mqFIbKHoK3x8AlrX7xkZVleIMDdTXgGOPUg09Bu3AvEqDNS9RyuYyV5eHhTW+r/qkmE
         jWD2teqBQLBN4xtyNySCr1Rso9j15k6kw/W3RYYvxbKXvZKSt7moQAbOaMmMvuGDk/Bp
         cVX1Ax39L4ma9lt2ER50S+qmRIiQBYL2SFqYKuTVOOONn2yUqO5GgMZHUJtO3AWGjm8f
         Pkwg==
X-Forwarded-Encrypted: i=1; AJvYcCV9voF8ASuJtsZ3tWlWo8h1WFtlgOF/VVNYb/2MnUYo20miv9FK2t+V8HLyV+A3HWNNFFEyVOq02w==@vger.kernel.org
X-Gm-Message-State: AOJu0YypXJtvSj//fERVMOcf2bDwxs1icWk5CAWaCT61Rd8j8nyXv9/Y
	vRYoXMCvVRg9y3fnBIp/7V0Er3EhDZXP7n2bjOEOgpSKvjLlajRY/AHSlKEF9MWlFG4kO7THJUp
	g5WmcC5g9YQvu5FeCyHYeswsMVv7wTnfduzJnqODRvlhRDPYio7L8C9wf
X-Received: by 2002:a17:907:d3c5:b0:a8d:64af:dc2a with SMTP id a640c23a62f3a-a902947b903mr2356286266b.25.1726747029018;
        Thu, 19 Sep 2024 04:57:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3C35u+lkmgjJ7a+AyTN4jw4x5gVoRh7s/g56CQ7cdgCxYSb+2G/Ujl+9lLwypdxJhbDLdbQ==
X-Received: by 2002:a17:907:d3c5:b0:a8d:64af:dc2a with SMTP id a640c23a62f3a-a902947b903mr2356283766b.25.1726747028491;
        Thu, 19 Sep 2024 04:57:08 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a906109678fsm709977266b.30.2024.09.19.04.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 04:57:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------r0lxKVxbcauw7w7YLuV0GqM0"
Message-ID: <aa60da75-7931-462d-addd-49adfbd9893b@redhat.com>
Date: Thu, 19 Sep 2024 13:57:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux fails to ACPI S3 supend on Dell XPS 13 9630
 (6.11.0-04557-g2f27fce67173)
To: Paul Menzel <pmenzel@molgen.mpg.de>, Marek Maslanka
 <mmaslanka@google.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 regressions@lists.linux.dev, Petr Mladek <pmladek@suse.com>
References: <18784f62-91ff-4d88-9621-6c88eb0af2b5@molgen.mpg.de>
 <154114fb-276f-45f6-bba0-98133c7c5d4d@molgen.mpg.de>
 <3b600845-77d5-42d3-8556-53cc0b2eab25@molgen.mpg.de>
 <1c10c0c4-f4d7-490f-85d2-0278c062fb87@molgen.mpg.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1c10c0c4-f4d7-490f-85d2-0278c062fb87@molgen.mpg.de>

This is a multi-part message in MIME format.
--------------r0lxKVxbcauw7w7YLuV0GqM0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 19-Sep-24 1:03 PM, Paul Menzel wrote:
> Dear Marek,
> 
> 
> Am 19.09.24 um 10:17 schrieb Paul Menzel:
> 
>> Am 19.09.24 um 07:51 schrieb Paul Menzel:
>>
>>> Am 19.09.24 um 07:51 schrieb Paul Menzel:
>>
>>>> On the Intel Kaby Lake laptop Dell XPS 13, Linux 6.11.0-04557- g2f27fce67173 (“6.12-rc0”) fails to ACPI S3 suspend the system. The screen turns black (as expected) and the power button LED stays on.
>>>>
>>>> Doing
>>>>
>>>>      echo N | sudo tee /sys/module/printk/parameters/console_suspend
>>>>
>>>> and on tty2
>>>>
>>>>      sudo systemctl stop gdm3
>>>>      sudo systemctl start getty@tty1.service
>>>>
>>>> and then on tty1
>>>>
>>>>      sudo systemctl suspend
>>>>
>>>> I see some panic messages and traces containing ktime_get or so, but I failed to save the messages. (Hints very much appreciated.)
>>>>
>>>> I try to test the printk changes, but otherwise bisecting is not feasible, as it’s my production machine.
>>
>> It’s not the printk changes. I tested some commits, and assume it’s the timer core changes:
>>
>>      $ git log --oneline --merges daa394f0f9d3c -3 --no-decorate
>>      daa394f0f9d3c Merge tag 'core-debugobjects-2024-09-16' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>      9ea925c806dbb Merge tag 'timers-core-2024-09-16' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>      cb69d86550b3f Merge tag 'irq-core-2024-09-16' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>
>>
>> 1.  6.11.0-02659-gcb69d86550b3 succeeds to ACPI S3 suspend
>> 2.  6.11.0-02710-gdaa394f0f9d3 fails to ACPI S3 suspend
> 
> It truns out your commit e86c8186d03a (platform/x86:intel/pmc: Enable the ACPI PM Timer to be turned off when suspended) causes the regression. The laptop defaults to s2idle, but due to problems, I force it to `deep`.
> 
> Revert on master is not easily possible due to other changes it seems.

First of all thank you for reporting this so early in the cycle and
for pinning it down to a specific commit. Both are really appreciated.

I guess that the power-savings from disabling the pm-timer are mostly
relevant for s0ix suspend. If regular S3 suspend is used the the
firmware is in control of the suspend and if necessary it should disable
the timer.

So I think we can fix this by limiting the new handling to s0ix suspend.

Can you please give the attached patch a try ?

Regards,

Hans

--------------r0lxKVxbcauw7w7YLuV0GqM0
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-platform-x86-intel-pmc-Leave-ACPI-PM-Timer-alone-whe.patch"
Content-Disposition: attachment;
 filename*0="0001-platform-x86-intel-pmc-Leave-ACPI-PM-Timer-alone-whe.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA3ODRkYjMxM2EyMWM4N2VlNDk5MDBhNGVmNDZjNzBkODViY2M2ZDk0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBUaHUsIDE5IFNlcCAyMDI0IDEzOjUwOjU1ICswMjAwClN1YmplY3Q6IFtQ
QVRDSF0gcGxhdGZvcm0veDg2OmludGVsL3BtYzogTGVhdmUgQUNQSSBQTSBUaW1lciBhbG9u
ZSB3aGVuIHVzaW5nCiBTMyBzdXNwZW5kCgpEaXNhYmxpbmcgdGhlIEFDUEkgUE0gdGltZXIg
Y2F1c2VzIHN1c3BlbmQgdG8gbm8gbG9uZ2VyIHdvcmsgb24KYSBJbnRlbCBLYWJ5IExha2Ug
RGVsbCBYUFMgMTMgdXNpbmcgZGVlcCAvIFMzIHN1c3BlbmQuCgpUaGUgcG93ZXItc2F2aW5n
cyBmcm9tIGRpc2FibGluZyB0aGUgcG0tdGltZXIgYXJlIG1vc3RseSByZWxldmFudCBmb3IK
czBpeCBzdXNwZW5kLiBJZiByZWd1bGFyIFMzIHN1c3BlbmQgaXMgdXNlZCB0aGUgZmlybXdh
cmUgaXMgaW4gY29udHJvbCBvZgp0aGUgc3VzcGVuZCBhbmQgaWYgbmVjZXNzYXJ5IGl0IHNo
b3VsZCBkaXNhYmxlIHRoZSB0aW1lciBpZiBuZWNlc3NhcnkuCgpMaW1pdCB0aGUgZGlzYWJs
aW5nIG9mIHRoZSBBQ1BJIFBNIFRpbWVyIG9uIHN1c3BlbmQgdG8gd2hlbiB1c2luZwpTMGl4
IChzbyBub3QgZmlybXdhcmUsIGJ1dCBPUyBoYW5kbGVkKSBzdXNwZW5kIHRvIGZpeCB0aGlz
LgoKRml4ZXM6IGU4NmM4MTg2ZDAzYSAoInBsYXRmb3JtL3g4NjppbnRlbC9wbWM6IEVuYWJs
ZSB0aGUgQUNQSSBQTSBUaW1lciB0byBiZSB0dXJuZWQgb2ZmIHdoZW4gc3VzcGVuZGVkIikK
UmVwb3J0ZWQtYnk6IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+CkNsb3Nl
czogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcG0vMTg3ODRmNjItOTFmZi00ZDg4
LTk2MjEtNmM4OGViMGFmMmI1QG1vbGdlbi5tcGcuZGUvCkNjOiBNYXJlayBNYXNsYW5rYSA8
bW1hc2xhbmthQGdvb2dsZS5jb20+ClNpZ25lZC1vZmYtYnk6IEhhbnMgZGUgR29lZGUgPGhk
ZWdvZWRlQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1j
L2NvcmUuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9jb3JlLmMgYi9kcml2
ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMvY29yZS5jCmluZGV4IGY0NDNiZjhiYjgyYy4u
Yzc1M2YwMTNiNTlkIDEwMDY0NAotLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9w
bWMvY29yZS5jCisrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9jb3JlLmMK
QEAgLTEyNzUsNiArMTI3NSwxMCBAQCBzdGF0aWMgdm9pZCBwbWNfY29yZV9hY3BpX3BtX3Rp
bWVyX3N1c3BlbmRfcmVzdW1lKHZvaWQgKmRhdGEsIGJvb2wgc3VzcGVuZCkKIAlpZiAoIW1h
cC0+YWNwaV9wbV90bXJfY3RsX29mZnNldCkKIAkJcmV0dXJuOwogCisJLyogQ2hlY2sgaWYg
dGhlIHN1c3BlbmQgd2lsbCBhY3R1YWxseSB1c2UgUzBpeCAqLworCWlmIChzdXNwZW5kICYm
IHBtX3N1c3BlbmRfdmlhX2Zpcm13YXJlKCkpCisJCXJldHVybjsKKwogCWd1YXJkKG11dGV4
KSgmcG1jZGV2LT5sb2NrKTsKIAogCWlmICghc3VzcGVuZCAmJiAhcG1jZGV2LT5lbmFibGVf
YWNwaV9wbV90aW1lcl9vbl9yZXN1bWUpCi0tIAoyLjQ2LjAKCg==

--------------r0lxKVxbcauw7w7YLuV0GqM0--


