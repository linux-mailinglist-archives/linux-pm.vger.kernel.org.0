Return-Path: <linux-pm+bounces-33876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5D0B444B2
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 19:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088371893685
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 17:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F200F31A565;
	Thu,  4 Sep 2025 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evZN+BCJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C633128CC;
	Thu,  4 Sep 2025 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008193; cv=none; b=tlvUE25LIyQSFUAgjQyf/AVngdlO8u8Rz42EdwHiQn8M5+ko7+Fm9x026zXk2uBSLZmFRznH8CcLFLTi0ADviwdk5V7esa7yWbvSLfB93K/ibxyQiQneyXKke8BUGaJ50QncE12J87iudeMlYNgqyicDtyC/iV3MdcXkYAx6dtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008193; c=relaxed/simple;
	bh=1OwhFp6QY2B9dXyCDZ9mtktpC15PTprmIsEgeb1yOCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQK8SSpOAsEXT9DhacEYyrjhZ1xD4jbBgsuTVTgb54UhzOM+dY1g6ZNAJ3DQOL8rMxlXB/inibZQAqNl11uyUZidNF3yst1Smr5WJcb2hbeqryRuaDs6k8Tqxa7ytwdmoGebWwR36NVsEYnMtx0B09/K0xhAm2RI7d9k27/L0iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evZN+BCJ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-333f92d60ddso11847731fa.3;
        Thu, 04 Sep 2025 10:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757008189; x=1757612989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OwhFp6QY2B9dXyCDZ9mtktpC15PTprmIsEgeb1yOCg=;
        b=evZN+BCJIrgR+DFdcgMy45ij4uajXQHpNyY0ZPYu9d5yBAclw/pTXYbVubo1sgdXYO
         UR+6Rplh67axriipwjwwBF725VAr7SqPEhh5tcBCjbR0RZLXnij5T08kxByLeCIWkzww
         1PYsQ0S989CGAuErYyg+g0FCJi4RoKpKiKU7igmRlmi2F28sOY/zLoO5CuTnXvsNK7uu
         hjuIVSITORjZBhzYkljF7bDmIBrmS1XS4KsikEmDWszPRW/0+J/LK6WsOhNtACbMMQnG
         A8uVpVlAV85u20brieWTkYwZ0qRKny3PcWLMftRThPH+xnrOuQCq1aMfqLXL8d0f3guG
         uvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757008189; x=1757612989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OwhFp6QY2B9dXyCDZ9mtktpC15PTprmIsEgeb1yOCg=;
        b=NDAYs9xozJQrik89fceWegPJ/C+gWKKhgy4qae78acaimy4jnAwi69uGFPp8lPqIG6
         ggju94B1t8JGxGeTM6WQPvHUrNI/6uXWDndphNbuWLihs8TjPY4REcurPUKgDMxkQlIA
         EUT3molCyBGaz1COd2t8Hvqskcl3gRc6A4JJWgg96LN1KbOGLkb2KRWmLJOneDOgQLy6
         ZMAT7c2FP1Q6LBaU1duvxK4ZDk7Q8fFqCQXd+fjNL/meq//rocOgbQntNaVMMlzKfSXO
         DcGh0DWCWBrsQ8FW8bRvtSJXIEWcw3CTKrucyYuGMwWkal5BLd+3WOWgxG603ndlyRfY
         DjGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo5WgbL8rTWkg5Iz1nw3v3/CvxFPveyClnqYIHeynA3aUwOwXZ1X1NdwZiV1ysUBLeUoE1/rkCi40Q@vger.kernel.org, AJvYcCV/EFKP9dUkDK8nWmJZqdNGsvDQVV0Mh7yj8U0OnalJb0ckm1oOtsifPzEGY3po8/CjQR4ILZx47oR7U9s5@vger.kernel.org, AJvYcCVPZIJJ1uIF306B8RmiTuZ+eawhSncjO2ykBB4wj9VRSuMzwIOJxsq6PLPagr3bFrH+lPI4xlrL8rg=@vger.kernel.org, AJvYcCWms9lW7sdtS0hapVIOWS4RrQbKMuy6kK6vT3TH3gmFOStLpd1E+JL5qhCUsq8nDTOdWyklrZkpNK/w4x0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp9es5ACgbxxZg5BkHS2RgT6Aiv6K2/UuHLdeLQykPLUjv6uRm
	hD3nEpP9LSfG3twV7/Wfua/CBVJEzoBiWqwZ7Obc6sY7qTfbN2vPzazjHRpf1Ce5cLry4EMZu9x
	y4eSp8mgxLEl6Qpa7A2q5Dl7h6MkQXXU=
X-Gm-Gg: ASbGncttFGYTp75UoTIe7oHt19nh8GR7lckiV0vILVfT5pNwDBkar1wTBQxcZo9aUH4
	s2uCB84OVxPK2+ud+PGHwZAWxSEUaapZyZ01XcVfSHWLaY4w5vEI36SOG2eQOEQhisqcpX/7SAs
	WevErVYEoQgcPYGeWTxMcUW2UDAzU9CHGFlnUZovfR29gKBdYlYOCk8Pph0F5ITzvx8CNPU3jQY
	XynMiU=
X-Google-Smtp-Source: AGHT+IH7QIHZ0cpl1bQSa5L4Bb5DytTvCb/2gvt8Gsq4gOq49faXMoYH00vGZ0ZJuXaKzDud/8jnwgq3KDUTQ3B7Nx0=
X-Received: by 2002:a2e:a4d8:0:b0:32a:6e20:7cdb with SMTP id
 38308e7fff4ca-336ca997e26mr43184441fa.17.1757008188845; Thu, 04 Sep 2025
 10:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
 <20250902-glittering-toucan-of-feminism-95fd9f@kuoka> <CALHNRZ_CNvq_srzBZytrO6ZReg81Z6g_-Sa+=26kBEHx_c8WQA@mail.gmail.com>
 <47c7adc9-fa91-4d4e-9be4-912623c627d6@kernel.org> <CALHNRZ8rxyRvb1GCifeXRKjPkkBE+sK6VnPc2nS01iZV_NcjaQ@mail.gmail.com>
 <08062eb7-1b7d-4fc3-86ea-af70069065eb@kernel.org>
In-Reply-To: <08062eb7-1b7d-4fc3-86ea-af70069065eb@kernel.org>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Thu, 4 Sep 2025 12:49:37 -0500
X-Gm-Features: Ac12FXymL814iB6fXAOm_7ikLix-XDwcIFwbTiMJt5Sq938zGMyGgX9ZoGVSnow
Message-ID: <CALHNRZ-iGASiVknUFJXJ8OkYYrG+0VMTistreDAG38WytHmEPQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Support dynamic EMC frequency scaling on Tegra186/Tegra194
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 3:19=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 03/09/2025 08:37, Aaron Kling wrote:
> > On Wed, Sep 3, 2025 at 1:20=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel=
.org> wrote:
> >>
> >> On 02/09/2025 18:51, Aaron Kling wrote:
> >>> On Tue, Sep 2, 2025 at 3:23=E2=80=AFAM Krzysztof Kozlowski <krzk@kern=
el.org> wrote:
> >>>>
> >>>> On Sun, Aug 31, 2025 at 10:33:48PM -0500, Aaron Kling wrote:
> >>>>> This series borrows the concept used on Tegra234 to scale EMC based=
 on
> >>>>> CPU frequency and applies it to Tegra186 and Tegra194. Except that =
the
> >>>>> bpmp on those archs does not support bandwidth manager, so the scal=
ing
> >>>>> iteself is handled similar to how Tegra124 currently works.
> >>>>>
> >>>>
> >>>> Three different subsystems and no single explanation of dependencies=
 and
> >>>> how this can be merged.
> >>>
> >>> The only cross-subsystem hard dependency is that patches 5 and 6 need
> >>> patches 1 and 2 respectively. Patch 5 logically needs patch 3 to
> >>> operate as expected, but there should not be compile compile or probe
> >>> failures if those are out of order. How would you expect this to be
> >>> presented in a cover letter?
> >>
> >> Also, placing cpufreq patch between two memory controller patches mean=
s
> >> you really make it more difficult to apply it for the maintainers.
> >> Really, think thoroughly how this patchset is supposed to be read.
> >
> > This is making me more confused. My understanding was that a series
> > like this that has binding, driver, and dt changes would flow like
> > that: all bindings first, all driver changes in the middle, and all dt
>
> You mix completely independent subsystems, that's the main problem.
> Don't send v3 before you understand it or we finish the discussion here.
>
> > changes last. Are you suggesting that this should be: cpufreq driver
> > -> bindings -> memory drivers -> dt? Are the bindings supposed to be
> > pulled with the driver changes? I had understood those to be managed
> > separately.
> What does the submitting patches doc in DT say?

The only relevant snippet I see is:
"The Documentation/ portion of the patch should come in the series
before the code implementing the binding."

I had got it in my head that all bindings should go first as a
separate subsystem, not just docs. I will double check all series
before sending new revisions.

Aaron

