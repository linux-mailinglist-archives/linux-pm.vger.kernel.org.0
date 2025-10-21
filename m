Return-Path: <linux-pm+bounces-36594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7719BBF7FF6
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 19:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3478E4E1F65
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 17:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4E234E74F;
	Tue, 21 Oct 2025 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4Mr0Ft2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA2F34E740
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761069503; cv=none; b=RkGCrxdHO/QkYxHfcinYNxLjLDY91xp7j1OAFhogKYa54DzTTC+nf+dFzJJr4MFw0+aZMKRkbC7lAhaj+3YY+UcUSeT+ndEJrvz8m7hSaFeuDIGPcWtK9U6SW67R3H7TJd9Og9KUp0Us7OBkvc5N3xIKOzJ5BlXoyEPQ5yDB60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761069503; c=relaxed/simple;
	bh=G47MvJWvuOhJGsJjH6oTOX1ThsvCSd/b1SDd+h4dpKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMD0x9i3ve3C/BbZYH6HBzMH40s+KiLHuUVsPyuJG5ngKb4NFMLdU/Psrm7g0sWgGPNWLMCbBiRmnygoyyFQA0GslGQymIg62z5wYMKD2Xf+YUoVKrS84lzJfMmbqph0VxpemJrN6Thf9B3exHUUafbRWtF4sgYZGnrWpANZO08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4Mr0Ft2; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-58b025fce96so4991629e87.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761069499; x=1761674299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOocNKmVfDLIyakQcVwyYTTBvpO95NrPUt1n/fTcY6Q=;
        b=R4Mr0Ft20d+Tg1bgvcdO594QJTjZ1dvyIxKq5sVpbqAYeEjwTEUW4kPK+AerqIzuvl
         fRdK3IqrHmPY44a13qS55JQOiCTbmt3NiMCBQ7eVRIzfc/B+PZ2XsrFqNdM04xUbITPv
         0g84ZLw1lh0wSSY1b+SPt/l0W2+baZt2Q8qnEvqq0E5lteMnmlvQf5LILSXh13WZ+YxA
         lf4f7tX/t9xG7ItYsDyxe56vPjzzi4Lt+AmMx3s3o/eje2qOXcoASSIDgluIiZLwZ89m
         tShleadB3byK6cyN/EK6n/DRSYDHf1p7vNVO4yk+1Jo5Eh0g2oSz299veeLSMCcjnp9c
         Mkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761069499; x=1761674299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOocNKmVfDLIyakQcVwyYTTBvpO95NrPUt1n/fTcY6Q=;
        b=ufBtX0TTIzy5V9tsQI2+KAnb/baxEkIF1HKON+u74QBoHtDdra0j7YEC9IHhAVuysv
         CXcVqMpOfeYDfSTRE4aFuPI28h2EwA7F8RcOH5hq8osoFHCOVXjNB4f8I8NTBu5fTwtz
         8oWSX5nkac/gXhlBnCsB8nGitZ4lM/e+UqFIMQ64NyG/ckOt1kQNgwnirm+l8l+bxQul
         rvD7F0orDxScxL3wHuciZazZNQ3evexAYKNXpIZkXAMUCjCeKEeD0YGSB12IA2AQWwNo
         cnDwoEVJhyyKokqNkKNsaYg+4Mhj2x16iVQxnvlKYiru0c57KkjogM5LoeNO96iMJEPq
         qeIA==
X-Forwarded-Encrypted: i=1; AJvYcCUrMrAWmLrbxaXGt99XPWHtrmRqZgDIFvuy1rjMOYxJercHY8QPpO9y2anpjG6KAT6wh/j2eHaNCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKwRsmZVOiYOZbA8nds+ke8QZrC386VQIPDG/dEEYnZR1LqWAM
	33RFt3Mk9BTcgbXRjfUkACkbI13tXgtHy+ikfqOd6y+7hjJNtsO5tIysCY6j5U7iZ26/Sukco9q
	/hOkfUrTni9xopw3OPiE+Xcb27pSqvKE=
X-Gm-Gg: ASbGnct9yhMaZYpbS0/T4MsBcjoZUR3IseIqRMliZX6FAfwcj4+UEpByIbARTkHYAjC
	esEqSoHwMap4ySx3C5kmG9EMyKX++SRq7jpDhZGviyrN09XG7EPfwYKCk1yC9lgQzCEN/PhPSKi
	bFuJtbfYtix51lB7MCGeZR/lGwQJayT/ISQGsG+oyrXKE4VSQdZUDFe1knnWrBscqKzxFf3/BBP
	vMMuQZCPpW1jaC8qZFhVEvJGP5X/IFaANeA2q0vVlfzrNc/ZuVnkf8HpcsV
X-Google-Smtp-Source: AGHT+IGB2swM6EPMZAWJrbU+PYzr6bBq9/N58DfugsjDP4QfXY1a2mV6Zvt0xgfuUqpsHA0mxQibDBO32iQwd4Vsx3A=
X-Received: by 2002:a05:6512:1113:b0:590:651b:10e1 with SMTP id
 2adb3069b0e04-591d8566409mr5652069e87.44.1761069498973; Tue, 21 Oct 2025
 10:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-tegra186-icc-v2-0-09413724e781@gmail.com>
 <20250909-tegra186-icc-v2-1-09413724e781@gmail.com> <20250930103006.octwlx53p2shwq2v@vireshk-i7>
 <CALHNRZ84s8rxQKWZeF-bfS31nK6ay4_MspmYa4+qapf9gtk+Fg@mail.gmail.com> <5ind7yevxsrsd3ws5rkl5z3zuxw4yrqoclqg7q6beunc6kgr2n@qmgbgw5q2ltc>
In-Reply-To: <5ind7yevxsrsd3ws5rkl5z3zuxw4yrqoclqg7q6beunc6kgr2n@qmgbgw5q2ltc>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 21 Oct 2025 12:58:07 -0500
X-Gm-Features: AS18NWCSSly5o6m2t5VO9WpiY4hgkm_v2vXdcycfbSTP89Bkw5Qe_Byc5eywF7M
Message-ID: <CALHNRZ-frshyU7bGKEkMhqjJfLBawWH_F-J8-WLsU2ezYpR5rQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] cpufreq: tegra186: add OPP support and set bandwidth
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 12:08=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 12-10-25, 21:32, Aaron Kling wrote:
> > On Tue, Sep 30, 2025 at 5:30=E2=80=AFAM Viresh Kumar <viresh.kumar@lina=
ro.org> wrote:
> > >
> > > On 09-09-25, 01:21, Aaron Kling via B4 Relay wrote:
> > > > +static int tegra_cpufreq_set_bw(struct cpufreq_policy *policy, uns=
igned long freq_khz)
> > > > +{
> > > > +     struct tegra186_cpufreq_data *data =3D cpufreq_get_driver_dat=
a();
> > > > +     struct dev_pm_opp *opp __free(put_opp);
> > >
> > > The usage here looks incorrect..
> > >
> > > > +     struct device *dev;
> > > > +     int ret;
> > > > +
> > > > +     dev =3D get_cpu_device(policy->cpu);
> > > > +     if (!dev)
> > > > +             return -ENODEV;
> > >
> > > On failure, we would return from here with a garbage `opp` pointer, w=
hich the
> > > OPP core may try to free ?
> > >
> > > Moving the variable definition here would fix that.
> >
> > If the var was NULL initialized, would the free handle that correctly?
> > Keeping the declarations at the start of the function reads better
> > imo.
>
> include/linux/cleanup.h has some recommendations around that.

There was a request to split this series into separate series
per-subsystem. So I will fix this in a new patch, but it won't be
tracked as a new revision to this.

Aaron

