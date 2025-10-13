Return-Path: <linux-pm+bounces-35943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5EFBD13B8
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 04:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F6518964E3
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 02:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5942882D6;
	Mon, 13 Oct 2025 02:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXUl1n8I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D3278154
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760322771; cv=none; b=phxTL0YCSfeKvMZhiSCIDQXv2haeosMq0Dq8hdGf4tLaLHlWlMXOkBnEHXdeCwxvMgGjGbCwTOrlAQ6OCHnIVH+BxEgLOFws/Ypnh5Xht+tTRWo8gLoMGTdTN0ffUoGlOnPbCI2vhrYuh+a92royXQxTyv/SX8qOPSgc0NIymIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760322771; c=relaxed/simple;
	bh=Mobd2nPQjln/iaGH+phCc81JbmWHC6V+ZX+OEP8c6WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9TFZutoaoARYmdyCYrTKSQYvKJ9xwQ0WGuWW2YJDt1HdPk4HwWKgK9rkEEKnemwHZZocEooQMuijxJuUCrBoWTaCQ+tsYuqrSwvDtUvssSryt9LuI9suVVeHAGIfMNVo6PYaRkrxRuuD2hrzH4oH//7pKj+/L/zLXxoGFWl03A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXUl1n8I; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so3758002e87.2
        for <linux-pm@vger.kernel.org>; Sun, 12 Oct 2025 19:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760322766; x=1760927566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSyKix+dExsW53zwh7yt2N4OdGXjl30i0H4cWLjWmaI=;
        b=AXUl1n8IHV3cVpOOSU6jhy5H9gRtJCqQqlFmwpSNEXYIIAxjniKANxWCRPkgyI4F9b
         FZCYvgFHjRlFhzyElVY9ULVvkhqDJUP3I5K/6ywQpgL82np+hl++/lu8EkH1Ycdxp/Kd
         aq9ZDSEqmTi1mVpQQBhurmmsq7UX0Sj806RIM2uqwoLL8H0k8SC4gfrz3ZTbKsQdRayu
         IhraNnBEIsv/XDqbqvjo2/Xwn2pBVg/Mqcp/kwj1PD3fM72o1zTf2+DRxr+W1PajRVRd
         O2osOnO4xKgLCkIDgjNrNuGMYbWlbwiubp+/O9q7GJz8tzKH2wpj4yZGIEHjKxBrpjbf
         UC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760322766; x=1760927566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSyKix+dExsW53zwh7yt2N4OdGXjl30i0H4cWLjWmaI=;
        b=D+rJNYMR4zLKIhMCuXZreHywUGXLzYHKCyy9QyPUH8QnawVAbXw0icIcWTyH4UNgPV
         eVibedflyR9wZj8wXvAGLzp7TPYMNZ6NS4T1riICJvHTzQvY1AE5oQTwyyKevM4dZtvz
         PnKoXA6+L97iYyc0YG+FpSD4QYgocY6NJw+K4bd4yjXy0kR3HcekPxBDhexGEDg6mVfI
         Zx42299d2bBH4AzOEggCoD25WE6WQ2lapnKResow8FjlKlHMv7WocM5ZTR1VEDq9Vc1z
         d/RICgB2lMcu7gMvsVcG6JkoLBtezBgan6WyEnBPgJYSksnbUpuMz/u0GlehDDlJwJbY
         FpJg==
X-Forwarded-Encrypted: i=1; AJvYcCXLs+XQB6laYbtg6WlIG25ZWSOYI5rnfkfNwCqYoRIzQN5UUO8SAAeBP9uyWGE155wvSYV+VFv1oQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4IIhWhy+xC2ROvkbqkJykW4thvW+XG6sdm3341WttlU/ELXO3
	Np2EejG33GAHlgL+0cK5DPADTsRTXiKrVetwwuI8SD4odaNTZq5tfR/OXYLFmgivOO/g5VzzxEw
	rkZ0KG4EeJSRIB0cqaYtLkhTqViI5vC4=
X-Gm-Gg: ASbGncsuw5hz0N4WP7pk16VlRgXJMyrng+H3XP8l8UAEwFXRWVgp03R8UeoZWKTRMzs
	qvcuEm/QQfuwknzQ4TmQVCOUxyTs/+qCgTpzY5hM6SoVKBZ25mTCEhjUzrpUMyRM68EWeYD/Nhx
	m4seIvfUOiK3VQFTCDdaq+3hgrhQ3Y+fK1gE+ueYN+sZX0AokyQ/yfnubUMeXKC1P7VIlAu6d9G
	TAh7nXJTvYi+g7oTr9xHMWieA==
X-Google-Smtp-Source: AGHT+IHWj20Z//Zd/Bj3pk8xg9qchfT20FaF7gZ8rC2cQFm5rgDMz1ihnaPh6KkjuMjFtQn3GvJXwEat84MrHNsMau0=
X-Received: by 2002:a05:6512:31c2:b0:57b:7c74:67e6 with SMTP id
 2adb3069b0e04-5906d75f85bmr5366512e87.2.1760322765941; Sun, 12 Oct 2025
 19:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-tegra186-icc-v2-0-09413724e781@gmail.com>
 <20250909-tegra186-icc-v2-1-09413724e781@gmail.com> <20250930103006.octwlx53p2shwq2v@vireshk-i7>
In-Reply-To: <20250930103006.octwlx53p2shwq2v@vireshk-i7>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Sun, 12 Oct 2025 21:32:34 -0500
X-Gm-Features: AS18NWDaKTgv8GyE1hN1DRdGL5_G-8YoPjy4LzB-vGT0ghwtG2kFi7JSPl6_Rmg
Message-ID: <CALHNRZ84s8rxQKWZeF-bfS31nK6ay4_MspmYa4+qapf9gtk+Fg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] cpufreq: tegra186: add OPP support and set bandwidth
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 5:30=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 09-09-25, 01:21, Aaron Kling via B4 Relay wrote:
> > +static int tegra_cpufreq_set_bw(struct cpufreq_policy *policy, unsigne=
d long freq_khz)
> > +{
> > +     struct tegra186_cpufreq_data *data =3D cpufreq_get_driver_data();
> > +     struct dev_pm_opp *opp __free(put_opp);
>
> The usage here looks incorrect..
>
> > +     struct device *dev;
> > +     int ret;
> > +
> > +     dev =3D get_cpu_device(policy->cpu);
> > +     if (!dev)
> > +             return -ENODEV;
>
> On failure, we would return from here with a garbage `opp` pointer, which=
 the
> OPP core may try to free ?
>
> Moving the variable definition here would fix that.

If the var was NULL initialized, would the free handle that correctly?
Keeping the declarations at the start of the function reads better
imo.

Aaron

