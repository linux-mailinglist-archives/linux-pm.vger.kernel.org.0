Return-Path: <linux-pm+bounces-9972-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F1A9170D4
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 21:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E84C286050
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 19:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B851D17C235;
	Tue, 25 Jun 2024 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oldd+0G7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFFD17A932;
	Tue, 25 Jun 2024 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342265; cv=none; b=VA8eVgYAF4WBM60R8Y76IebSP+JAG/7eq0wnzum8/CceSnuzhEfOT434koR4XTcryJc4MJWN9BtMG3U2677pF41/x9fIqNtZZnnDCRwnipOdC1wou3Iryrt4E2xc6jpBAwS/ydcEhXQbpSNrECfxJyB9QZXmp8AnxlLd3UlblqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342265; c=relaxed/simple;
	bh=yvWF/Eos8ZpDkFBQU1tpHh00PSApTKghgVxDjJVdZDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6D3nnsq9sEH2CpeWwuUSEcbjg/jKMUGJZ4APV41C1erS/RUEJIvdaW3EDlJ1NrBTiMutA51PmXkcRLqqBvfCp4QFLaMKi8fWu5o9mBecGHcCNQFO3J63PKTbgTSLXh+4cSHfZtsPBZcGIs5QCphU3CK6pBnI/ADSTSJlEYjbyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oldd+0G7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6B9C32781;
	Tue, 25 Jun 2024 19:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719342265;
	bh=yvWF/Eos8ZpDkFBQU1tpHh00PSApTKghgVxDjJVdZDU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Oldd+0G7T7y6J2WlKyA2WXI+HUQ05spcf1Kke9tOG3REs4VYLG6WBx3hnkAZRvrmj
	 zU2VZihuhxiU1ODmRxJs5AiWyytp84FmHRFCZHt142N9i91KRRjrX2XTw1hb3MZjNH
	 JbCWYegPz6sgfVSDgO5ePBeMvvR4xGVJyWrJtDpiz1MMI5aThxSECgbX441wuq5rSo
	 zKTiA2M4bL/sudkPWHjehjL8UDvwiWNI/8OoAZLFUgTAgXFoVAV6Je7lgKO3M6QQnq
	 0KvwcAd9mRdyodX2Yo4+pd4BVJZ59QjgngwgkuhHPs0RAWnCoSDk9oLxUB0g34PDh5
	 /MTXuOizNxziQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-254925e6472so706534fac.0;
        Tue, 25 Jun 2024 12:04:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqBLXEJFeRN3PFxRw76vmzsL/A47NQLJv5kfYJaSVIMJ97Z7zbEUXhvgzQ9lColteQkxdAbpqUY4IyAVfrFfBpgzRdf4YbGfPWJ++fTMB0fkARF1ETZwcO33lO0vfgSsn9LyAUFMk=
X-Gm-Message-State: AOJu0YzbXYxprgjQjPt3lWJnTSWBzCOXwWudovKbz358ShTc4fLcxyFt
	e2FQE7N4DtQ8uPq//0jeziS2qeBvKOrd/Nc+wZIKKEKWZRATqEbBvo+vV7A8ARDhz9HlH8j9XB2
	HcfNxe2YFKd9hdbL1haHsT+HPgmo=
X-Google-Smtp-Source: AGHT+IFECvS8bz3J4yCr4RlaaTMVf4uhnXjLyI3Opj7zT3s50/XB7+c5ujXvvl0q2y1HndU7usqRsAxx4pQROKiF1N8=
X-Received: by 2002:a05:6870:5587:b0:258:476d:a781 with SMTP id
 586e51a60fabf-25cf02d87f7mr9683000fac.3.1719342264416; Tue, 25 Jun 2024
 12:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624161109.1427640-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20240624161109.1427640-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Jun 2024 21:04:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iE_-eMi1JvWfDJM5-Z810WUdQPUoq9Qn8q62F5daXoSg@mail.gmail.com>
Message-ID: <CAJZ5v0iE_-eMi1JvWfDJM5-Z810WUdQPUoq9Qn8q62F5daXoSg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Update highest frequency of a CPU after boot
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, x86@kernel.org
Cc: rafael@kernel.org, viresh.kumar@linaro.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 6:11=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Intel Xeon servers, which are capable of dynamic highest performance
> change, are unable to achieve the highest frequency when the performance
> profile is changed.
>
> The highest frequency at which a CPU can operate is not fixed and can
> vary after the system boots. These changes can be initiated by switching
> to different performance profiles using the Intel Speed Select Technology
> interface. Additionally, adjustments can be made remotely through a BMC
> (Baseboard Management Controller) interface. Administrators can select
> various performance profiles to align with specific performance
> requirements, as these choices will directly influence the total power
> consumption and cooling requirements.
>
> Whenever an administrator switches to a different performance profile tha=
t
> alters the highest frequency, the hardware sends an interrupt and update
> the new highest frequency at which the system can operate. This interrupt
> can be enabled via the MSR_HWP_INTERRUPT register, and only if support is
> indicated by the CPUID[6].EAX[15] =3D 1.
>
> To enable changes to the highest frequency, add a CPU features flag and
> enable the HWP (Hardware P-states) highest performance change interrupt
> when it is supported by the CPU.
>
> v2:
> - Prevent display in /proc/cpuinfo flags
> - Use cpu_feature_enabled() instead of boot_cpu_has()
>
> Srinivas Pandruvada (2):
>   x86/cpufeatures: Add HWP highest perf change feature flag
>   cpufreq: intel_pstate: Support highest performance change interrupt
>
>  arch/x86/include/asm/cpufeatures.h |  1 +
>  drivers/cpufreq/intel_pstate.c     | 23 +++++++++++++++++++----
>  2 files changed, 20 insertions(+), 4 deletions(-)
>
> --

Please let me know if there are objections against this from the x86 angle.

If not, I'll pick it up.

Thanks!

