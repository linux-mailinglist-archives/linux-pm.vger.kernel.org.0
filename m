Return-Path: <linux-pm+bounces-33081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CA6B35523
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 09:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E333BD20C
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 07:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E116723C4FF;
	Tue, 26 Aug 2025 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArjZKrN3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291CF1CEAC2;
	Tue, 26 Aug 2025 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192677; cv=none; b=FUg6mQLiN/E6kEFwHsCb1ZeDG1FoNvAS464iqwPMv+TRohO1M6cfjRCVKMRP7HNy/zkGuDXCsGhvZ6ZOUVJPk3AW7mGh6yNmp8BAjmgGvOFv/AUsF7U78p4owCoS6SG175jKScZLPcfzKukkpBSQ+6K4mETLCfc/wwJEkDdRHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192677; c=relaxed/simple;
	bh=YRgjxHWGx0sm+DrsEHB20sbddHUAvH5kG7RAji1bxw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEkw4Btaum7sG+0XfIV7n3ar9VDuiSSNhLDFkAH4r6dHhqpGNsghF9qW/itQqnZ11wrWM9xCfwQsRYjZv4HRx/lzhd4mFcTiW6onibvOKaFgJHyd4G+uTDXe9eSeTvU5T1PdsghQm8s/ZPmKKDaMeEYvkGvexonJhjrhkK9B8AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArjZKrN3; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-333f92a69d4so38030081fa.2;
        Tue, 26 Aug 2025 00:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756192674; x=1756797474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRgjxHWGx0sm+DrsEHB20sbddHUAvH5kG7RAji1bxw8=;
        b=ArjZKrN3qZDZHSWjj4fL4BHDDYr5P4wdE2JiktOhUqbTMP9k4loAqLZZeetv6X/7Gn
         JGnAdTqU5+kRM4qxI0ep8KuZfXMDAwRavNN11tL5t/Z+082e80565cOSCGCtviEzFYH5
         Om0nlyOhDvtDT1Ty8Las6ESOoFm1Kik00tx7B9DTm9aiBosglQ7/0RYmkis/Aa+tNzjj
         Y5O6ZFZYHgu7Ci2NTLGIKVn/n+uMHA4xuzTYHALFK5woJhgIsmqUEwsXIBTLsHuDnEDP
         RWjbZOKLPZOQpFXOeDDCBGzWNRpTVxioWjT5gdLaza2L1Sly+mojlBqPWjJ3VT4KzCG4
         EuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192674; x=1756797474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRgjxHWGx0sm+DrsEHB20sbddHUAvH5kG7RAji1bxw8=;
        b=fShFD/hFmvaLOHSH/INn/xekJipndM/3EV0XTmTxidN34JplDiSjfPIpKbhNwtU/pc
         Smi0LXu0dtYOd9/nMexx6XuPgStsL03MLNoQej4dBX3+AW5cYO5GwAnoLu67+kJS//IF
         7gThsEQLgK72kSO1B7e3pigvjedDHpFZJKjPy5hrLKw6wHoYXtS1iC+QswUq0wvPIjIU
         6czYMY8O8nElveaHe9IBTZnw649ecliPWKH6S686+kg09fBHWHgUX6uPIuLW5989fZnU
         21UFdT1o1IuZB+GIfAAx73UmTa0INQ5ErhR/ErP+Hjsa7ZbxQ7ulweqWqLAL+bVRU3V+
         mTUA==
X-Forwarded-Encrypted: i=1; AJvYcCUT2WqE8s/BdARz0t0ZyNhspqX65KfgKNKNqJBSuAzVeZ8RUlwRHi0wV5O+KAAgTp5rSurKwrftgD0Wb+M=@vger.kernel.org, AJvYcCVb+3zT990J33s7N1zBUnIPhv2k7qAJB7d3BBz+Mj9DeV8WN7ILtlNUWPMQWEkznKR881S+PyK5qgBWdvg=@vger.kernel.org, AJvYcCWt1w+udS7attN12uunpSKSD7emdqessLLJX5ycNc9RIy359ACR9+V4Nj87FM33+s6Uluw/f24UnxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg91Iu+EAfSN7rDsZ/u5WtS3HQtgWKQQJiEw7Pwel+V8O2/yqP
	Mx5S3IfG5rRcchs9X3+0zTL2pzRdrjyv3lmjluYkTkm6aUKAFeN2AXxzX8frtFOVbrZzBCv5Lnp
	qhLJPAbHBQ2Gi3JIo4RHrls3gcANFWIw=
X-Gm-Gg: ASbGnct6G5aUP7ML1ry+3yz9ES9A705lSFaYYVJ3YrUk0RS/9KNi9laOaUGtiHodnMj
	SQEfgvXqIb2cbmOlGzF0aQrTeDRZZgLXdMQO9vb4VpauX/P0kBYvtePZJwi0A7GmPRJ1HmcPno8
	ZwV5Be1zgEigLSmtlh7nwqcVTbs/l5pGGpWi1fN3E17GRGYEp3fH8PPIyaPFsMe2ja8fIaMLE9o
	ZD9L7mWh/ukUEZTQQ==
X-Google-Smtp-Source: AGHT+IGfTjMTFaJeXNnkMRpfv5ianH6N4g5+7UuQNvCIsLnQlNqu0cDp8GJerw9dH+q9DCMcpodGRYFrSvJPoqvnMi4=
X-Received: by 2002:a05:651c:304d:b0:32a:c14b:7d95 with SMTP id
 38308e7fff4ca-33650fc9ccemr31652321fa.20.1756192673883; Tue, 26 Aug 2025
 00:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-tegra186-cpufreq-ndiv-v1-1-4669bf8f2992@gmail.com>
 <CALHNRZ8oaGaAhMVVzfeNf+M+-OvMnCnMd-fRdffmOSTBZiEXCQ@mail.gmail.com> <2325429.iZASKD2KPV@senjougahara>
In-Reply-To: <2325429.iZASKD2KPV@senjougahara>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 26 Aug 2025 02:17:42 -0500
X-Gm-Features: Ac12FXzhTw64z9ytVZyAaPNZ9y_0Q90vFsq7OuSpHiqP53-mgbnKIywtdtAt8Yk
Message-ID: <CALHNRZ8HfD+ftrQSJJLE_vsxGq3xyPxD3=m6Xg=LQKXR1nZvPQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: tegra186: Default divider to 35 if register read fails
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 11:48=E2=80=AFPM Mikko Perttunen <mperttunen@nvidia=
.com> wrote:
>
> On Monday, August 25, 2025 2:08=E2=80=AFPM Aaron Kling wrote:
> > On Mon, Aug 25, 2025 at 12:03=E2=80=AFAM Aaron Kling via B4 Relay
> >
> > <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> > > From: Aaron Kling <webgeek1234@gmail.com>
> > >
> > > Several of the cores fail to read any registers and thus fail to
> > > initialize cpufreq. With shared policies, this only affects the Denve=
r
>
> By failing to read any registers, do you just mean that they read as 0?

Yes, that is correct.

> I suspect the issue may be that the EDVD_COREx_VOLT_FREQ registers are ju=
st
> used to request VF transitions. If no one has requested anything, the reg=
ister
> will be at its reset value, zero.
>
> AIUI, in downstream, the driver retrieves the CPU clock rate by measuring=
 it
> instead of calculating it from an NDIV value, hence it would not run into=
 this
> issue. I think the conclusion would be that if the register reads as zero=
, we
> cannot assume any clock rate. Is it possible to tell the cpufreq framewor=
k
> that we don't know the rate and it should ask us to set the rate to somet=
hing?
> Or otherwise at probe time do this by ourselves.

This is a very helpful pointer. If I initialize all cores to their
respective base frequencies during probe, the subsequent get's work as
intended. I want to do a little more verification before sending in
another patch as I also found another issue with my previous shared
policy patch. I will submit a new series once that is done, so this
patch can be abandoned.

Aaron

