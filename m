Return-Path: <linux-pm+bounces-27146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1901FAB71C8
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 18:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1361886437
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 16:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BBA27A107;
	Wed, 14 May 2025 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li1cOmHw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278C914900B;
	Wed, 14 May 2025 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241003; cv=none; b=W0Cgcl8LNLJSEbsgoMntfyEuDhfniiYZGwdfMHuBFeEzCs3PFU1RFVSJMiVNfCEr1Z8WMRTrqJhf8LPN1E7ZKlG6DLt3o1KNnBzMnk+II/LKKsKFmkI0B1iKzORFTErsWRplBc44Xx6K5wa5h3/vuHb6fW/MZrTLvf1DTnErKK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241003; c=relaxed/simple;
	bh=iQ1m38GQOyvSo0ShFVx2reaUFr2mMbRCQLXAuTfGK1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxqIcWIJaN3Pd2rZVeIcgLe+Q6dKNPp3zZA2gS4j9JbYSaeS7bcg91hnz+qlzE6+VXqOfi1N1g/2hVl2MngAnQu1x32nwJUIatAH2W09sFdtG3NNF0X/FInccRGTx+khk4SAsahJAtSazsayI2AyWZfUtDDP8sxdiIXbcHy/c+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Li1cOmHw; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30de488cf81so69956481fa.1;
        Wed, 14 May 2025 09:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747241000; x=1747845800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6F6rei2m0L8nkxMIW7HJy0Xl0/HfeXnbscHf6bezmYU=;
        b=Li1cOmHwMBTOrCysrJYagSR6/8cQ4F07ZBP7Wzmw2PEWaYQdgbdCgOpDl84V/O2azW
         +/IUI3uVE0C+r/ZXu1q0pS6tgypYugFnUlahyUQ2iSi2fFNSLHmybVtHCgYRPJNZnf7f
         kpU5r5G5KFh2PBfHTWUvoWI/vvM3GjgQ1wvzVbLabyvkGd/YIbcUS92sY8ovd2SZBNQx
         W51DcOMu1jU0OFuWAQdJf54aglNIrEo9Fw5Dky6rJjhaFJRCVfDGRIcCsb6AnlUDopFd
         KMWJIZm6kjYy5l9N4zQgoBCNkYYGXdStFOq6mLZOsDQ6SmtZ9ycEvgbI33PXRLbxobk9
         BGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747241000; x=1747845800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6F6rei2m0L8nkxMIW7HJy0Xl0/HfeXnbscHf6bezmYU=;
        b=tce0okq03mFHbc6/HWMuUiHm4DcELr6tt/5Wf/phHNbkcrzzgoRkmt2Wa0Nf2r47qr
         g9tOafYc7qebU+1i6u3zGaK2nh+0H1f85Tf83zhW+BIDzP4KTbzl2avjEOU63WTKb1Q7
         dyhwqweotGYkoFjyqkK2JHsycagRXPcs3mQXKUmU/yWI6A70hJYiR899y6BcTLqK1hhG
         hvANtCWQI358k557hha5ojJhStmsdcKJ+zOM42Qi/PKN2WKJleNpkNNTOb9JGW7JZCpk
         lIDrO03uJc5E7g9G8j0dQuz+DKjy+0ms7mZp/khymoudrF+z3QKlVHcwZp6ib1qbVezB
         gD0A==
X-Forwarded-Encrypted: i=1; AJvYcCUdp4yGOSSbfnmoKLQwXIsSOqeB3iySjelcu/FsgKDcakZfS3vRyBGfEgduDEt3eEaBrQnIFkALUwLtM3w=@vger.kernel.org, AJvYcCUeb1o9/jxKxf3KXL+DjhnZdzoO9frVpyNg7USzMgi1t4REDtMDYR0gtB2KyfWDA/75ApUKyAqRidM=@vger.kernel.org, AJvYcCXTT8sL4hRUh+6Un9mdBcyoSwAg3XnEB2e384ZxuiLVwt+/UzlbLYQ6lTAivSEMwUGUaM8/iAH6D9hZtk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAEvza1mymXxevIWM6mubYwTKBwkK/UBnSBIyxszT0ovwpR0rA
	PFo7EiFTIkgdYxy0qbFSyLKndB+3vmQnPlh202CsGGujzRcsVqRu70KCrZeJmrXfiO15q5zHWJI
	0fcZz2HXYueBuN3XvkPkz8dTXs/M=
X-Gm-Gg: ASbGncsEgxGN0oeULCNe8qE7xLxfEwAnyZhLT+fmbDSNobBrOe8L05KkaK7sO1OHIvc
	Cby+HeKm4PhPU2rncamjmeGMyS4miZ5hKJhKiiANkVrgN10drgHajpsAcYW9MgrO/k1w2+5rfFb
	lGmbi6eIQlxYRNYJLCdLVCK93Wt0qN7lA/6g==
X-Google-Smtp-Source: AGHT+IEDr7Zbk1sQ13MbBNwQ19Pn/Xv7NBNG7D2ruxTV+/fxW8aeGl12mYuq0BV12IJfslfvCf3ZKA+TJHccLBKNf+8=
X-Received: by 2002:a05:651c:30d3:b0:30d:e104:d64b with SMTP id
 38308e7fff4ca-327ed229040mr15483191fa.39.1747241000028; Wed, 14 May 2025
 09:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-2-d142bcbd0234@gmail.com> <cd801698-d7cf-4e9e-aa01-5525f8687ab0@nvidia.com>
 <CALHNRZ_9tMi5iihyTsEuU4T72=oTQM6-rVhqozzLf9DiB_TpcA@mail.gmail.com>
In-Reply-To: <CALHNRZ_9tMi5iihyTsEuU4T72=oTQM6-rVhqozzLf9DiB_TpcA@mail.gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Wed, 14 May 2025 11:43:07 -0500
X-Gm-Features: AX0GCFvIwUL0tMV3pEcEjy1ST2YEdM-PnJCwo35Fk4Jwtknmqf_vneRfSpTX6iM
Message-ID: <CALHNRZ-pu9HUzVyR3-U=XZKFFZPnn5-DNLWPqPx6CSoW0dHMrA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] cpufreq: tegra124: Allow building as a module
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 11:26=E2=80=AFPM Aaron Kling <webgeek1234@gmail.com=
> wrote:
>
> On Fri, May 9, 2025 at 8:38=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> =
wrote:
> >
> >
> >
> > On 09/05/2025 01:04, Aaron Kling via B4 Relay wrote:
> > > From: Aaron Kling <webgeek1234@gmail.com>
> > >
> > > This requires three changes:
> > > * A soft dependency on cpufreq-dt as this driver only handles power
> > >    management and cpufreq-dt does the real operations
> >
> > Hmmm .. how is this handled for other drivers using the cpufreq-dt
> > driver? I see the imx driver has a dependency on this.
>
> A hard dependency would likely make more sense here. I can update this
> in a new revision. When I first set the soft dependency, I wasn't
> certain how the driver worked, so I was trying to be less intrusive.

I remember why I added this soft dep now. The kconfig already has a
dependency on cpufreq_dt. However, this driver doesn't call any
functions directly in that driver. It just builds a platform device
struct for it, then registers it. This results in depmod not requiring
cpufreq_dt for tegra124_cpufreq. So I added the softdep to work around
that, so modprobing tegra124_cpufreq by itself functions properly. Is
there a better way to make depmod map this as needed?

Sincerely,
Aaron

