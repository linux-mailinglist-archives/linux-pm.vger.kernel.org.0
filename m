Return-Path: <linux-pm+bounces-33908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD16FB44F5E
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 09:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16191B608EE
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 07:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F52E2EFDAD;
	Fri,  5 Sep 2025 07:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StwrOGC2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44FD2EF65E;
	Fri,  5 Sep 2025 07:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056737; cv=none; b=SL6Vs1izZ8Qo6u/oO4RRjHFXRgo9/Wr4brKfq1Q4+ONDle8Jv+ZJq3ioJD/BW4H4txRKjDTNgS1esnZm8s+ij2x5YlfR4M1b0zrcZQKHpVUfoE3xT0FMP8EfK6Ds7xV41+nR6r8OSVXSUfexQCMnOTXif1+YbuKQhSnxVSNySRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056737; c=relaxed/simple;
	bh=H223aX43nK1pPdfcIo1BT3fCYy/tXf6As0jPOBfabl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zj1QyGT+aFBk9Pq24ppRXOfYrw79bkBBCX2WOsQA4O6ly5fEiiYhcj6iaZb/04RItgb6MapvQfCuJo4ASSsYTMoA9/AWIycnMwweLSUgLWrb4603fkbQtZeCryvTBn4GaNG0PrySP0YpiJ2b0hLQLSFYxFbAI/fA+PxVa8Wudt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StwrOGC2; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3381df3b950so6780071fa.0;
        Fri, 05 Sep 2025 00:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757056734; x=1757661534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJz7bdBnKBg2ceOJglorHSW6LY+Qn3Rzkau42ItVYOM=;
        b=StwrOGC2mqJaZCD13znqfA7bngAt8MvjhWrDO5fyKQS7egU18qhNNXOhyCMzh5p5IC
         zXWXhAO566zsp9efhkd1xDdbEUhPqg9bhIybE0Qq1mcbGVw0Y+0adUtUsi/+x5xXBu8M
         P0RWLMzsoisujMpaJCG4nZY9CJ2WFZ+czv+HkYK2iMMzzhimz4bdRGzg/GNki9dY+vSS
         ESj2J1fwoaNeQoLLrHIt74kMWNBwV2HQfCxhb0fEji8vyMpZWu4PYkvm45jzuwhzgSTg
         nXbKSNLyWfCBaekvOOlIvyKN84l3TtlDSSI3s+j4BWU5k7Q9oEXyM1cs2zSnJgPfYuot
         dD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757056734; x=1757661534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJz7bdBnKBg2ceOJglorHSW6LY+Qn3Rzkau42ItVYOM=;
        b=QEuzVqN4jJ4waFTlmOXVKNFuCDTt+t/5ASX9u6lwF8NKuZY1bCIZWs9UhssKcXaQey
         KVdUPLfhJBhqB7cx8zLiPnbudnGVzVpRuR0ROGgIi7eY/eolUrWBhlyvpMGNRBS3zMab
         2IQs5hM8q5NUHnbVKaOua6tSly+LTDO8dEjfT2P8HBAvcH17KWofzEDzzmin9rQJL2aP
         lxxy73Mwi8tGddVH9QUHL1FWMLvoroqokkmFx3MRc0GFA7Bg0L6xh92mxeDppEdjTTnF
         Wi+Hb+eVYYmFjW+q8MbgNauCejLNIDWSqYQ+x9NoFqAmDP+mX0t1xx1bVrHdbky1ZnuI
         6PyA==
X-Forwarded-Encrypted: i=1; AJvYcCW3Z88TwiM1dFROUOO4B++04SH/x1y1pD6G6PofBffFqTeYcOxIIlOAJsbbd6XpRu2VOzKCyUCtDpnsEGY=@vger.kernel.org, AJvYcCX1/6DguGsJZYXfvRvsTlE8OIVU7u8TXMHrakdAnQI5tAv7HyK+kxxiKU5EZDBmgC5EsOPgUhZbds/8@vger.kernel.org, AJvYcCXSL8oxGQyh2j01WGmpBMhpUHWTCtQ/Qz+09w56fWG8muOw/q9PtIRNZAjjmz91aRMvgZNcwsZByDw=@vger.kernel.org, AJvYcCXxVHN4sEBVjuxMfECsj1nIs5MCwD0ZPNRUtvtbbmDisWHimR2X7mcMLs8wAzbUa5OBPJ0i0KXsmY2m3giq@vger.kernel.org
X-Gm-Message-State: AOJu0YwDnmY3d9vobz2z7/gwoNBVlYurjS4+ZofqQeHBkPXHfwLqLQpa
	jURd8EdZwBk44MSU9X4Ml2kyU0JOqrmbobXlF8r++lqmUWcrshSKK/E8j/ET8mjeQbDkfAOw2hT
	ofMgz31mVPVpi7jUgcrC1IADi4jVK8hY=
X-Gm-Gg: ASbGnctUmfVc+lwWtStvhJgzoXmERf3dB+Iy0N8ovaujF0OdKv3IeTaXrgQuca2dXVw
	pW8bb3hb0Om6hUvWJcFvHy+05IJL80nxWGXfkiUMifyU6xau/7SaVspAunn5iT38sbJCvSYNJc5
	cvYa60q1hWCXNy6f6PSGVhZr4QLC2yIhmDFGmTzBsxNaZ0Fe7mFBLijj//z3UHUUq6Wqc4V3CVu
	kEoelc=
X-Google-Smtp-Source: AGHT+IG+iAZiL5a9vcVJGPUFdWSDn5K9xZdjUYWNJPmKZX7IPVD8EN9zuBxiYf7HfJEJRgarXPnKa9oD6EzDEGdw/jE=
X-Received: by 2002:a05:651c:b06:b0:336:c310:6ff9 with SMTP id
 38308e7fff4ca-336ca9cd8cemr56466581fa.19.1757056733511; Fri, 05 Sep 2025
 00:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
 <20250903-t210-actmon-v2-1-e0d534d4f8ea@gmail.com> <20250904-honest-accurate-bullfrog-fdeaf9@kuoka>
 <CALHNRZ8DEYq-DOC6jV8TAqGznd8e2mzfS7Xs61Gp3R5visPFzw@mail.gmail.com> <c64f09f5-440f-411d-b2f1-6c85b9adffb7@kernel.org>
In-Reply-To: <c64f09f5-440f-411d-b2f1-6c85b9adffb7@kernel.org>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Fri, 5 Sep 2025 02:18:41 -0500
X-Gm-Features: Ac12FXwJhmydf2_U-hTVI9iShWSyeWRBVWI7bOIm9DBcxoS9hWma7UNAMb0hcxA
Message-ID: <CALHNRZ8apdrTK_77bS05=NA_F6_fjoyySNbgS6UDLBp2pLhJpg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: memory: tegra210: Add memory client IDs
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 1:56=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 04/09/2025 19:33, Aaron Kling wrote:
> > On Thu, Sep 4, 2025 at 3:20=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel=
.org> wrote:
> >>
> >> On Wed, Sep 03, 2025 at 02:50:07PM -0500, Aaron Kling wrote:
> >>> Each memory client has unique hardware ID, add these IDs.
> >>>
> >>> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> >>> ---
> >>>  include/dt-bindings/memory/tegra210-mc.h | 58 ++++++++++++++++++++++=
++++++++++
> >>>  1 file changed, 58 insertions(+)
> >>>
> >>> diff --git a/include/dt-bindings/memory/tegra210-mc.h b/include/dt-bi=
ndings/memory/tegra210-mc.h
> >>> index 5e082547f1794cba1f72872782e04d8747863b6d..48474942a000e04914201=
4e3bcc132b88bf1a92d 100644
> >>> --- a/include/dt-bindings/memory/tegra210-mc.h
> >>> +++ b/include/dt-bindings/memory/tegra210-mc.h
> >>> @@ -75,4 +75,62 @@
> >>>  #define TEGRA210_MC_RESET_ETR                28
> >>>  #define TEGRA210_MC_RESET_TSECB              29
> >>>
> >>> +#define TEGRA210_MC_PTCR             0
> >>
> >> There is no driver user of this ABI, so does not look like a binding.
> >>
> >> You have entire commit msg to clarify such unusual things, like lack o=
f
> >> users. Please use it.
> >
> > The tegra210-mc driver has these hardcoded and should probably be
> > updated to use the bindings instead, but I think that's outside of the
> > scope of this series. I will clarify such in the updated message.
>
> If you introduce the binding, change the drivers to use it. Otherwise
> there is no point benefit in this binding, really.

Ack. I was adding the bindings to avoid magic numbers in the dt
commits at the end of this series. But I can update the mc driver as
well.

Aaron

