Return-Path: <linux-pm+bounces-35731-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF775BBE038
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 14:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B0A3A9865
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 12:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4DC27E07A;
	Mon,  6 Oct 2025 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tzVkgaso"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDE87080D
	for <linux-pm@vger.kernel.org>; Mon,  6 Oct 2025 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759753407; cv=none; b=ZEbqtgUmKGKUQziycnNh6OmKeKLtZa5Eu5l9QtLexb2hWM+AkQdfaryoAegBY/I1VzunDJ4884p8u+JJ5mdJic3WvzBCyKu3chT8rUyCQ6puvBq+m/JNmgDbdJ0lPciXacQEYVQUxbE6JLeHytK3siq/9QdqLAaOEoJ2nklf+l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759753407; c=relaxed/simple;
	bh=XhPKKZ+qLVDcEGkmaBKKeLZU4bI38h/0RXwXpIaRLSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+FKxXDca8seHJn5JGxFZDzV81uJVn7NV40YIgGaQnWSb4e43n2kbFKOuNY1e+g5dgG2e1iXLugsjvLEQJ5zh2JhByejN7BdavHbkgUg/kL1k9Islt18O0CfpryxJyg++1sLB3dx7MJSuWD6y7IvgHDgryRl8iUYiWvC0K8dTF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tzVkgaso; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-638d01a8719so5118765d50.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 05:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759753405; x=1760358205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Azz9O4mUwwwsxG7mSBpJ+zeBvEA2Nl0F6icaY3vg3+s=;
        b=tzVkgasoeNABEGjycNgI13q+p20/nCUiBQkzgyC5nB1L98da+0KoGPABkI/eBpqupo
         noNlVXskyPcdStqiOrSEOcXx+841/gYQlb7VGJH8BzUh9KtvNSKGp9N3BIrMsKOMdrgp
         IWtfKZn6O2Vsyw5JTZt5ej5CcSjMB57bGKnkQVYhNCC8kVpDInMk9gaKaoBIwb7HD504
         5ZVMrye10z2TkLxuErUVInsrUbLXsMP3yjJ0NCdmmtK/7RrPE0ghW3w3PLX7pmbRl6x0
         P44Q0A8hGXl5W0HzDnExvQ9pr2JoRgxSBqXAxjtW/ZI/R6qnNb40xQtY/twcTtiJ+0Jc
         CkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759753405; x=1760358205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Azz9O4mUwwwsxG7mSBpJ+zeBvEA2Nl0F6icaY3vg3+s=;
        b=NqXiA/ZCHjkZ9pdgDMFCH8y1evR8UqmqdoBw7tE/mQXZzBVpCOLQ2DA5ioSZgrQfZi
         fmZifPwqVJXR3Ld7cw/X2wdHLmatgHBx+530S0WVeJMM2vIrDQLulqkyg35JlPRoMcdN
         Blzq6l8lD3rzA5TFD1DkglMtKMP2d4MBfbLV3utA6CC01PmdzpqCZZ8qhbqleEKF3s7R
         7GYcc72jKQ6aKmEgq1pA9YCxdGK+EyONJgqV1DDpAerQT2yWY+R7LCF/esl/IDxMT7RW
         iFhVHjujDzgzNf11qirsWCvNiUBhCPwS55882lhzi2Fwfmpj9hF8hgmJTbuVqdYv8Wqt
         PgJg==
X-Forwarded-Encrypted: i=1; AJvYcCXxXNMS0Cmq4MuhrvXv/9fNsyLBm9NYgHPuOQWOC4D6kt+f2f90cm7DhNwAcDij76J+4GZ+frOSRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmj354cRTFZsb4RlLNrIQoGaHa28PmXR7Y6Ba7wUgA6Xdkfygf
	3qiJpwwspDEa+klxdw2oixaroz6wLXXjyM1wXa5j5i4W0SU64iK6PpdVtz4EZs9awUJTV7aB/st
	WIBhOee/dvLAoFngi7vCo+PFoMr5EhYx4m/jnERIAuEOtoz82X/VWAZQ=
X-Gm-Gg: ASbGncuFFLxjW31cVUS2ogRnDWa30otDmENkIJINItsYTnxFk/tlzvrXSlpuFuQDT2K
	wrjWqbs89dPX7xIoK6gnpXclmAkW3Fbap/CxbmpX/olHO3bQhJOX3dYqgC+HwPF89aAIpA8cXRI
	lQsUeR44A8Uc4r/e03b5329pol4Culo6q+j46THInRPsffU0z1AuChLKtuuMbIwNabilqHNvnKQ
	bPUWlA0xAZbrwLDnGxV0yUu027ESCJkwPZITWXSa99Giro=
X-Google-Smtp-Source: AGHT+IH2DWL1rMufHJoRTaOEsDQX80kfcKh2Smoz9/7LaEmtgBq0ndRVK0/fgAr61uabtKnXzQgGo5LH2G/ebFNXG8o=
X-Received: by 2002:a53:a006:0:b0:636:13d5:6968 with SMTP id
 956f58d0204a3-63b9a07802cmr9764799d50.15.1759753404956; Mon, 06 Oct 2025
 05:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003150251.520624-1-ulf.hansson@linaro.org>
 <20251003150251.520624-3-ulf.hansson@linaro.org> <20251006-manipulative-urban-antelope-31101f@sudeepholla>
In-Reply-To: <20251006-manipulative-urban-antelope-31101f@sudeepholla>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 6 Oct 2025 14:22:49 +0200
X-Gm-Features: AS18NWCQYiaPlcdiDQop43x4w0EDfpR_gEuiAFidF0pHvlZI8_2qX-prnyesMvw
Message-ID: <CAPDyKFoz4P6cZWNA-omNtF3XqKKciC07aVXBTVQp8ueyyYxmxA@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: smp: Implement cpus_has_pending_ipi()
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Oct 2025 at 12:54, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Oct 03, 2025 at 05:02:44PM +0200, Ulf Hansson wrote:
> > To add support for keeping track of whether there may be a pending IPI
> > scheduled for a CPU or a group of CPUs, let's implement
> > cpus_has_pending_ipi() for arm64.
> >
> > Note, the implementation is intentionally lightweight and doesn't use a=
ny
> > additional lock. This is good enough for cpuidle based decisions.
> >
>
> I=E2=80=99m not completely against this change, but I=E2=80=99d like to d=
iscuss a few points
> based on my understanding (which might also be incorrect):
>
> 1. For systems that don=E2=80=99t use PM domains for idle, wouldn=E2=80=
=99t this be
>    unnecessary? It might be worth making this conditional if we decide to
>    proceed.

For the non PM domain case, cpuidle_idle_call() calls need_resched()
and bails out if it returns true. I think that does the job, for other
more common cases.

Making this conditional could make sense. Not sure how costly it is to
update the per CPU variables.

>
> 2. I understand this is intended for the DragonBoard 410c, where the firm=
ware
>    can=E2=80=99t be updated. However, ideally, the PSCI firmware should h=
andle checking
>    for pending IPIs if that=E2=80=99s important for the platform. The fir=
mware could
>    perform this check at the CPU PPU/HW level and prevent entering the
>    state if needed.

I think this is exactly what is happening on Dragonboard 410c (see the
stats I shared in the commit message in patch3).

The PSCI FW refuses to enter the suggested idlestate and the call fails.

>
> 3. I=E2=80=99m not an expert, but on systems with a large number of CPUs,=
 tracking
>    this for idle (which may or may not be enabled) seems a bit excessive,
>    especially under heavy load when the system isn=E2=80=99t really idlin=
g.

Right, making the tracking mechanism conditional sounds like worth
exploring. I guess the trick is to find a good way to dynamically
enable it.

Kind regards
Uffe

