Return-Path: <linux-pm+bounces-27611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 260E5AC2A30
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 21:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562931BC6296
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 19:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889FA29A332;
	Fri, 23 May 2025 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cM0o/4z4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5381F18E1F;
	Fri, 23 May 2025 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748027179; cv=none; b=BfObZr0UTTnSPW5sSCsAz6tGnWLn6tQPFXkFsVMEJPJAt0Qu2jAbkGqTnGwChfZ7oEktHDeF5P3TJkolJ07VbtHX6KA9TElO2oPVZu6QjkCSRcWq8Kwl+7lNWh0Yz4Wh7F3tYIr0OQXyqyMeJ630WAiDWQJ3PivSVEtWzY4OKD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748027179; c=relaxed/simple;
	bh=dowtiTbRoFlV8eT1KQwifTloJBwKyQ2IOWNLlXZ6olA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UduUI/VPoS9b4oOk2l3pW/H3CrOO2vzUmo/FwYo8O4RJFUzU1agc2WXdJNDOTRRN2yYssR9QRRKKbCSjMjHkgP7klcSD+R7tmaFIa8VNEjl/KvfOiFZlITfsyjPYO53jYgodBAOvRYWmpn/0TZQFsQ/t6tGGjy1UDH55AP0KXLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cM0o/4z4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60B9C4CEEB;
	Fri, 23 May 2025 19:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748027176;
	bh=dowtiTbRoFlV8eT1KQwifTloJBwKyQ2IOWNLlXZ6olA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cM0o/4z4cZjBN9IAuXC+0cO74JgQw/wcwo+g5cvuCUHnL8lQ7GtdNh49TsOfdfNKp
	 3g4oJZbAGgLuPIWJ/KHa4zDmGzl2LLw3Zm8TT/W58Bxz/bL+IqkZd1WgTXSe0AxHAd
	 /DqvIkGukZ6p+R5Db1+389IaCPoxlhxlqB/PWL56G8vuLhxsCkLRNms4XHMzH/e2Z2
	 1MHLX8ZgmdCC9H90D0B2hlirwPt903ePMNtDpDWe9wlg/KePyr6s1wz6r0tjk95Tp2
	 IC+0DDuTGOeY+jkTYJWNGzzqP9o3mZ+o4Hv6BjptOkYVza6Yua5LlsBRAt9Gphz8TG
	 AcFu9OW2GcOqg==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-60402c94319so144201eaf.1;
        Fri, 23 May 2025 12:06:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVoxxLpjOm+XZCzal7qCnjff2etHZpiZBr+AoLIh+jXv9B4hfbZw7WlmfPXSnCwHwN78vCnMW/fVFU=@vger.kernel.org, AJvYcCWYUk02+snIYdgLpMXIjb9gty/3sVKSR53DC7YFbEIoITl1o6Uea/ZGn0N8kBxCFKh1XXJfCGTXcuo=@vger.kernel.org, AJvYcCXoe7Og7y1HfoYJcXZgo37g/kiSgzR3k36cXogcWD4Wdxpyr3CymTLDdvQceH4meld4XnHeQTWhe4Xh5AEf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Q6/cNLSCihQwyi5umIK+uGObDcffMWbe9X4uZzn6CrCCW8Y6
	GQypXZTqxNaUYvJfwQFK6qKNMjXODOCrkqkqI7E5xu9DZU4d1DLV6BjHRYbk7E5VjHnBrOSHcT5
	iNelHH94XDJEr//ZQzVnFU1qTHCHAou4=
X-Google-Smtp-Source: AGHT+IHlpJPwqrqmWx0LCdlImq8x5osSWYa3sVvHx8E0yBP07iYaYazf6lTOFhEeGQChguc3hHON81aeo9NzO3FeB90=
X-Received: by 2002:a05:6820:151f:b0:60b:9d5b:e94c with SMTP id
 006d021491bc7-60b9fb9eac8mr371310eaf.6.1748027175885; Fri, 23 May 2025
 12:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com>
 <15871c67-0d18-430f-935e-261b2cda855b@gmail.com> <CAJZ5v0gz3Y+RGqBf9E1hzq9rwfrryd98Xpk51DtLd-uck5y-rw@mail.gmail.com>
 <b62c0462-8185-4eb8-8ac6-7f2abc387768@gmail.com> <aC_4yLsFVVszI_FA@JPC00244420>
In-Reply-To: <aC_4yLsFVVszI_FA@JPC00244420>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 May 2025 21:06:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g1o03La9aWJF1rheC9CM8SU2iC52auEAnaBpUCMunpJA@mail.gmail.com>
X-Gm-Features: AX0GCFusKRDDjJyftuC3cu-4nzD7fvYu_7vuKevhacJCYwgojd1A84_D_3uCsDc
Message-ID: <CAJZ5v0g1o03La9aWJF1rheC9CM8SU2iC52auEAnaBpUCMunpJA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq, docs: (userspace governor) add that actual freq
 is >= scaling_setspeed
To: Shashank Balaji <shashank.mahadasyam@sony.com>
Cc: Russell Haley <yumpusamongus@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shinya Takumi <shinya.takumi@sony.com>
Content-Type: multipart/mixed; boundary="000000000000e088140635d24adb"

--000000000000e088140635d24adb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 6:25=E2=80=AFAM Shashank Balaji
<shashank.mahadasyam@sony.com> wrote:
>
> Hi Russell,
>
> On Thu, May 22, 2025 at 06:15:24AM -0500, Russell Haley wrote:
> > > The userspace governor requests a frequency between policy->min and
> > > policy->max on behalf of user space.  In intel_pstate this translates
> > > to setting DESIRED_PERF to the requested value which is also the case
> > > for the other governors.
> >
> > Huh.  On this Skylake box with kernel 6.14.6, it seems to be setting
> > Minimum_Performance, and leaving desired at 0.
> >
> > > echo userspace | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scalin=
g_governor
> > userspace
> > > echo 1400000 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_=
setspeed
> > 1400000
> > > sudo x86_energy_perf_policy &| grep REQ
> > cpu0: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pk=
g 0
>
> Oh cool, I didn't know about x86_energy_perf_policy.
>
> Consider the following on a Raptor Lake machine:
>
> 1. HWP_REQUEST MSR set by intel_pstate in active mode:
>
>         # echo active > intel_pstate/status
>         # x86_energy_perf_policy -c 0 2>&1 | grep REQ
>         cpu0: HWP_REQ: min 11 max 68 des 0 epp 128 window 0x0 (0*10^0us) =
use_pkg 0
>         pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*10^0=
us)
>         # echo 2000000 > cpufreq/policy0/scaling_min_freq
>         # echo 3000000 > cpufreq/policy0/scaling_max_freq
>         # x86_energy_perf_policy -c 0 2>&1 | grep REQ
>         cpu0: HWP_REQ: min 26 max 39 des 0 epp 128 window 0x0 (0*10^0us) =
use_pkg 0
>         pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*10^0=
us)
>
>         scaling_{min,max}_freq just affect the min and max frequencies
>         set in HWP_REQEST. desired_freq is left at 0.
>
> 2. HWP_REQUEST MSR set by intel_pstate in passive mode with userspace
> governor:
>
>         # echo passive > intel_pstate/status
>         # echo userspace > cpufreq/policy0/scaling_governor
>         # cat cpufreq/policy0/scaling_setspeed
>         866151
>         # x86_energy_perf_policy -c 0 2>&1 | grep REQ
>         cpu0: HWP_REQ: min 11 max 68 des 0 epp 128 window 0x0 (0*10^0us) =
use_pkg 0
>         pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*10^0=
us)
>         # echo 2000000 > cpufreq/policy0/scaling_setspeed
>         # x86_energy_perf_policy -c 0 2>&1 | grep REQ
>         cpu0: HWP_REQ: min 26 max 68 des 0 epp 128 window 0x0 (0*10^0us) =
use_pkg 0
>         pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*10^0=
us)
>
>         scaling_setspeed only changes the min frequency in HWP_REQUEST.
>         Meaning, software is explicitly allowing the hardware to choose
>         higher frequencies.
>
> 3. Same as above, except with strictuserspace governor, which is a
> custom kernel module which is exactly the same as the userspace
> governor, except it has the CPUFREQ_GOV_STRICT_TARGET flag set:
>
>         # echo strictuserspace > cpufreq/policy0/scaling_governor
>         # x86_energy_perf_policy -c 0 2>&1 | grep REQ
>         cpu0: HWP_REQ: min 26 max 26 des 0 epp 128 window 0x0 (0*10^0us) =
use_pkg 0
>         pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*10^0=
us)
>         # echo 3000000 > cpufreq/policy0/scaling_setspeed
>         # x86_energy_perf_policy -c 0 2>&1 | grep REQ
>         cpu0: HWP_REQ: min 39 max 39 des 0 epp 128 window 0x0 (0*10^0us) =
use_pkg 0
>         pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*10^0=
us)
>
>         With the strict flag set, intel_pstate honours this by setting
>         the min and max freq same.
>
> desired_perf is always 0 in the above cases. The strict flag check is don=
e in
> intel_cpufreq_update_pstate, which sets max_pstate to target_pstate if po=
licy
> has strict target, and cpu->max_perf_ratio otherwise.
>
> As Russell and Rafael have noted, CPU frequency is subject to hardware
> coordination and optimizations. While I get that, shouldn't software try
> its best with whatever interface it has available? If a user sets the
> userspace governor, that's because they want to have manual control over
> CPU frequency, for whatever reason. The kernel should honor this by
> setting the min and max freq in HWP_REQUEST equal. The current behaviour
> explicitly lets the hardware choose higher frequencies.

Well, the userspace governor ends up calling the same function,
intel_cpufreq_target(), as other cpufreq governors except for
schedutil.  This function needs to work for all of them and for some
of them setting HWP_MIN_PERF to the same value as HWP_MAX_PERF would
be too strict.  HWP_DESIRED_PERF can be set to the same value as
HWP_MIN_PERF, though (please see the attached patch).

> Since Russell pointed out that the "actual freq >=3D target freq" can be
> achieved by leaving intel_pstate active and setting scaling_{min,max}_fre=
q
> instead (for some reason this slipped my mind), I now think the strict ta=
rget
> flag should be added to the userspace governor, leaving the documentation=
 as
> is. Maybe a warning like "you may want to set this exact frequency, but i=
t's
> subject to hardware coordination, so beware" can be added.

If you expect the userspace governor to set the frequency exactly
(module HW coordination), that's the only way to make it do so without
potentially affecting the other governors.

--000000000000e088140635d24adb
Content-Type: text/x-patch; charset="US-ASCII"; name="intel_pstate-use-desired-hwp.patch"
Content-Disposition: attachment; 
	filename="intel_pstate-use-desired-hwp.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mb166us90>
X-Attachment-Id: f_mb166us90

LS0tCiBkcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMgfCAgICA0ICsrLS0KIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgotLS0gYS9kcml2ZXJzL2Nw
dWZyZXEvaW50ZWxfcHN0YXRlLmMKKysrIGIvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5j
CkBAIC0zMjQ5LDggKzMyNDksOCBAQAogCQlpbnQgbWF4X3BzdGF0ZSA9IHBvbGljeS0+c3RyaWN0
X3RhcmdldCA/CiAJCQkJCXRhcmdldF9wc3RhdGUgOiBjcHUtPm1heF9wZXJmX3JhdGlvOwogCi0J
CWludGVsX2NwdWZyZXFfaHdwX3VwZGF0ZShjcHUsIHRhcmdldF9wc3RhdGUsIG1heF9wc3RhdGUs
IDAsCi0JCQkJCSBmYXN0X3N3aXRjaCk7CisJCWludGVsX2NwdWZyZXFfaHdwX3VwZGF0ZShjcHUs
IHRhcmdldF9wc3RhdGUsIG1heF9wc3RhdGUsCisJCQkJCSB0YXJnZXRfcHN0YXRlLCBmYXN0X3N3
aXRjaCk7CiAJfSBlbHNlIGlmICh0YXJnZXRfcHN0YXRlICE9IG9sZF9wc3RhdGUpIHsKIAkJaW50
ZWxfY3B1ZnJlcV9wZXJmX2N0bF91cGRhdGUoY3B1LCB0YXJnZXRfcHN0YXRlLCBmYXN0X3N3aXRj
aCk7CiAJfQo=
--000000000000e088140635d24adb--

