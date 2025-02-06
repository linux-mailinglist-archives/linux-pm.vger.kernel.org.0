Return-Path: <linux-pm+bounces-21501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 467B8A2B27A
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 20:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825953A7EFB
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 19:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71C01A9B29;
	Thu,  6 Feb 2025 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfJOnqDO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20D319F13B
	for <linux-pm@vger.kernel.org>; Thu,  6 Feb 2025 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738870971; cv=none; b=PbJWnGaIM5KYZ8xFdJDGzjx9lB7x4fEHWE9bcIn4QiW4hnOrL7xGEap+iwJlJjjl+Ajq5Az8Z+vj4h5sy2f/ODs7vao6odC98AxPqUQexWBHJ+m5i3zAqbCD+Bg+sZGWarijfTL8Esc/H6hkaSo9uCr5vLEtSSx1n4Ns7HPAhnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738870971; c=relaxed/simple;
	bh=y8LhGS2Oj9+qLve8rLE4gmBod1SucPjtYDvnP7tY0gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tr9FzmdEf4FQkER35SZX9g6YEU08lsNDgYpwK9CMh8DeWhCv0YRyrTE3u7inr0alE+ezpzUx7+kfvm9wxZ2fe29n5XRCHIS9msmsNVfbksYgwja9pPdwaQ0rhOygRI/yZ7bxngSLhtBTgTSEw5E80ylp6Mn4TWLkT3ulGonFMos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfJOnqDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29421C4CEDD
	for <linux-pm@vger.kernel.org>; Thu,  6 Feb 2025 19:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738870971;
	bh=y8LhGS2Oj9+qLve8rLE4gmBod1SucPjtYDvnP7tY0gw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OfJOnqDOGK47BzeOhiTcZl8n+Xwmp2ncylQYaYfF16i2YUMUOAas70tTE5yBVtA/8
	 7p0PfqgDnbn9hnZUojbbVFoxD1bRWDx8vkPFKL6WnCJtZ31fkz2IEUEjVWzrJxkYU6
	 3SgskWAqR0N065KGdBDUvbCILOD7XUZ6/APK9zwKWFK5LoJoZ4XWXL1Ej+7bOMjDQG
	 0GAJh/T2m4mbw0c0DsnN0Kx++/zb+Y65VDn/CqE/w+0q7XEcKqNSEKx0g9U/SIdr7O
	 waz38akkJtngu7D58s/Ip3TamPYcDJvSdCwMXFWFkXNApd2bNTwYz7JXuaSor1U9OG
	 9owl2sVTHi1Kg==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3eb7edfa42dso718906b6e.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Feb 2025 11:42:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVumMLXjhdOIloMIFhMB3T7ap+VO6Q6fThHoGjWDORRsyIzsrvIEO19QUz0g6McLlQYNkhx85LaFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKtY4rNpYqeEAfTN037Q/n2Np0ahYEoJFAxeQ9aHdiCO3DVPng
	mJNfyJRMtReG5ueVAfVHAeG2rfZQZ2CW58hKEGWoiVA5vzo1UAwdS0Vu/bpq3ClXUUW8h4RD4gH
	e8kWOktsMIGMtjghaC4aLz5ah+dQ=
X-Google-Smtp-Source: AGHT+IGJcOEUm6plJkgkeORfHRWezOVGO7txwF/KgQWvsd2AUBHhdkjp8kOdldm5VhKQoGL92X+lwJ2CVt/KJF9JIrw=
X-Received: by 2002:a05:6808:2294:b0:3eb:8354:76c4 with SMTP id
 5614622812f47-3f392221927mr459381b6e.9.1738870970463; Thu, 06 Feb 2025
 11:42:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e656ef9c-3e77-4a40-912f-cee96632bbb7@amd.com>
In-Reply-To: <e656ef9c-3e77-4a40-912f-cee96632bbb7@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 6 Feb 2025 20:42:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gstdK_TEDAH0UmgtiiDa4L87wkNKb43s=gRe2GuCpPYQ@mail.gmail.com>
X-Gm-Features: AWEUYZnkh3AtkCgyI7ZhgnwZzi1KiyC7TEEAz7IVbU_CTZQOvquEvZXNJJp1oeY
Message-ID: <CAJZ5v0gstdK_TEDAH0UmgtiiDa4L87wkNKb43s=gRe2GuCpPYQ@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate fixes for v6.14-rc (2/6/25)
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 6, 2025 at 8:32=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Hello,
>
> The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f0=
5b:
>
>    Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.14-2025-02-06
>
> for you to fetch changes up to 3ace20038e19f23fe73259513f1f08d4bf1a3c83:
>
>    cpufreq/amd-pstate: Fix cpufreq_policy ref counting (2025-02-06
> 13:19:36 -0600)
>
> ----------------------------------------------------------------
> amd-pstate fixes 2/6/25
>
> * Fix some error cleanup paths with mutex use and boost
> * Fix a ref counting issue
> * Fix a schedutil issue
>
> ----------------------------------------------------------------
> Dhananjay Ugwekar (3):
>        cpufreq/amd-pstate: Remove the goto label in amd_pstate_update_lim=
its
>        cpufreq/amd-pstate: Fix max_perf updation with schedutil
>        cpufreq/amd-pstate: Fix cpufreq_policy ref counting
>
> Lifeng Zheng (1):
>        cpufreq/amd-pstate: Fix per-policy boost flag incorrect when fail
>
>   drivers/cpufreq/amd-pstate.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Pulled and added to linux-pm.git/fixes, thanks!

