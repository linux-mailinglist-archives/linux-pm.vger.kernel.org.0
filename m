Return-Path: <linux-pm+bounces-18623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285CB9E57C9
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 14:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914271884BF3
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 13:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574CD219A65;
	Thu,  5 Dec 2024 13:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LN1r8WgI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB68E56C
	for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2024 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406528; cv=none; b=UIkYqhGIjvn9gmrN0OmNpKULNnGg+kbexcRN0rTrhmQOroqEW5D0u7zPgEP6L/Q/Fsbwb7VZuGrb6wIKWcMPwAV0VUoqPifKiYhdT0gqjaYtDYjSgmpmOCmTKgD9VRtGu4x11zU+yF/cdalHg7ywADT4gJBBBHtdpwnsuSBFNfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406528; c=relaxed/simple;
	bh=iY5P+RCTX6zdy8vi+BSs28/pZLYyZcaPKm7sK512OdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXz4T7GZuJZTqA9hVLCzBg9PBuCtGkF5T8NCDdV/DBF7Zf/4T9+e3uWTbN1XoOUTvlZouoKCzQk72mzT+pmO5Mzh+yMUkJ1oKNxAOfzaA3zGDR15BL+e7MXj/zvK6jGcR4vD5IbP1yNdLrPO/FG58NxXGsDmuHfKxunZjzmlG2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LN1r8WgI; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a77ab3ebfaso146925ab.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2024 05:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733406525; x=1734011325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBYTsxurte9zUpJPRPgCb5UYJNyj1cZSr57YSjFaoi4=;
        b=LN1r8WgIvv+KYxyMlGsToMNpkn1g/zIobzt+sAsLOhg3sFx67zDvz8ByUFu+hWcsGk
         JzbL0KxVywA5MCRhLcd57Py7WzHMx37IqJiWZm3N0+T1EvdvBTOsI9leWNZ1v8o7VkgS
         HTNpyP8N+nTUQ1BMs2/jMdL93XrZNUjUOydbYploXSa7SFR0NC3tvIxCuVD7LgYS9R+8
         tFzd1fAELXQaaPix+02qKJe+zyBAR+1+t72Jo/Ju98gR0VOgoE+zzHNKDJMiEGLtlPSw
         dwCR9Tg1EfXpmX3pGFGaEPjW/2rQXrI01NZLOUsAcfi4dkgEHiPdCAFZvua6jeOI+J4a
         gcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733406525; x=1734011325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBYTsxurte9zUpJPRPgCb5UYJNyj1cZSr57YSjFaoi4=;
        b=SzmYFgDt0BUo83xurg7TSL8e/d0Q1iQUMfOYCckO6NJ/nzkee6tvmMmzudkplzrP8W
         fqPKT5j86N2kqzrOlLXg6DL4qfBXrEeRfZkYiQbvbpdJpXoVq+nClfZwpQv/zfI47gM8
         RwZyKpOoZj9ksfGsH4AFwsZX1es63Q7UpIBj33qH72dEEeOMk6Yzl5PVdbhBMLw4tCil
         Mhhma0CwZNn3VHjWXUyWixp/4TyJY/IPkGAwaBrS98RKwfTxj9mUwvaNadebDVk2m81a
         ujRc9sS1fxG4LmF+BuZsc5ng87OT2WEuESlHZN9We4cwiUBcJzIg26T1w0Qf9G5JtoON
         B6nA==
X-Forwarded-Encrypted: i=1; AJvYcCXRv78M5VrwTTNBtwAhyf7HtecFjsoZ5JMnZzNYwSNE4B5lXaH6YCly+WyKvJTjC87hTCY1Pys22w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+0gkDJgiwzhDV1N5nu7Ujb9BHwm0Hq1ZwYbj835RirkPLwvnp
	q8Dj4hNm6/Z/+wYzyxjVJ2lcPWSEpC89mlOmgF4yCXFiysxyLOo90NQnDXt7DkbmVLYFN/vC6Vh
	Iu4AOddlhHAHNUbcbmeYYcQ84YFYlLfa+iEu5
X-Gm-Gg: ASbGncvF+aCs3ZKEJThSiQGD+VrvwCUvpJQu+JPei/tFt9a/P4TDJzohlGNkP/GkWDF
	KNuOTtZ9OgyzlFTSNQZE6AKdwTlvo8g==
X-Google-Smtp-Source: AGHT+IHMJ2LYSkIEPnmFAtJ/qhvJXzOnlIJQIcrzt34NRX9egb83JFVidMlWNFcEjFM8/VPM9BvJDc/4F/SK2o7SrC8=
X-Received: by 2002:a05:6e02:3a85:b0:3a7:5099:8159 with SMTP id
 e9e14a558f8ab-3a8083ebabfmr3283715ab.16.1733406524798; Thu, 05 Dec 2024
 05:48:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com> <465c927c-88f0-45fc-9178-4c6981f82fd9@amd.com>
In-Reply-To: <465c927c-88f0-45fc-9178-4c6981f82fd9@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Dec 2024 05:48:33 -0800
Message-ID: <CALMp9eT7zNniaJMWguKKMLYA2hZg_QzkDb0iVrbpXAuT1bDscQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/22] KVM: x86: Virtualize IA32_APERF and IA32_MPERF MSRs
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: Mingwei Zhang <mizhang@google.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Perry Yuan <perry.yuan@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 1:00=E2=80=AFAM Nikunj A Dadhania <nikunj@amd.com> w=
rote:
>
> On 11/22/2024 12:22 AM, Mingwei Zhang wrote:
> > Linux guests read IA32_APERF and IA32_MPERF on every scheduler tick
> > (250 Hz by default) to measure their effective CPU frequency. To avoid
> > the overhead of intercepting these frequent MSR reads, allow the guest
> > to read them directly by loading guest values into the hardware MSRs.
> >
> > These MSRs are continuously running counters whose values must be
> > carefully tracked during all vCPU state transitions:
> > - Guest IA32_APERF advances only during guest execution
> > - Guest IA32_MPERF advances at the TSC frequency whenever the vCPU is
> >   in C0 state, even when not actively running
>
> Any particular reason to treat APERF and MPERF differently?

Core cycles accumulated by the logical processor that do not
contribute to the execution of the virtual processor should not be
counted. For example, consider Google Cloud's e2-small VM type, which
is capped at a 25% duty cycle. Even if the logical processor is
humming along at an effective frequency of 3.6 GHz, an e2-small vCPU
task is only resident 25% of the time, so its effective frequency is
more like 0.9 GHz (over a sufficiently large period of time).
Similarly, if a logical processor running at 3.6 GHz is shared 50/50
by two vCPUs, the effective frequency of each is about 1.8 GHz (again,
over a sufficiently large period of time). Over smaller time periods,
the effective frequencies in these examples would look like square
waves, alternating between 3.6 GHz and 0, much like thermal
throttling. And, much like thermal throttling, MPERF reference cycles
continue to tick on at the fixed reference frequency, even when APERF
cycles drop to 0.

> AFAIU, APERF and MPERF architecturally will count when the CPU is in C0 s=
tate.
> MPERF counting at constant frequency and the APERF counting at a variable
> frequency. Shouldn't we treat APERF and MPERF equal and keep on counting =
in C0
> state and even when "not actively running" ?
>
> Can you clarify what do you mean by "not actively running"?

The current implementation considers the vCPU to be actively running
if the task is in the KVM_RUN ioctl, between vcpu_load() and
vcpu_put(). This also implies that the task itself is currently
running on a logical processor, since there is a vcpu_put() on
sched_out and a vcpu_load() on sched_in. As Sean points out, this is
only an approximation, since (a) such things as I/O completion in
userspace are not counted, and (b) such things as uncompressing a
zswapped page that happen in the vCPU task are counted.

> Regards
> Nikunj
>

