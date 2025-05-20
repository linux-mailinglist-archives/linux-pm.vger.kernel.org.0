Return-Path: <linux-pm+bounces-27419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E46ABDF47
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 17:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59EB47AA575
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 15:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128A02512D5;
	Tue, 20 May 2025 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqdfLoKM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414E31FFC54;
	Tue, 20 May 2025 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747755550; cv=none; b=XrgqNLfnGBOKeKdIhKTxsVmubFFGpvS0IHBECHCZrgwk++OtPEvXj4Rb3Pu27tcoKAPU1K+7YyK2whMM8sEoJdXoTeWTimEweFirUiZf3UKT2mJxUa7d1fInvUhdgb9QY3l9XMyPaEJFF6kzBjrTYcYjn99ma3eUXCajzY0IV7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747755550; c=relaxed/simple;
	bh=l1hOo4kpWzGJBNZGsCZ606pi5hXSzOaGiN8p6gFUftY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i44m9iDtJOM/R6kF1brZXkKi13sQM95R32+ysQQ16m0jsZz+wzbFiWNAe18JDOjdnHldnggFr804w3PAz5EYMmUsuYw+/svKsXPV8S/4R8Zxot1EC7R+zkq2Qxlz6BgXrdZvBKjx6KuP8HFdkGMb/aJ1oGelLNzlTEejGTb6NAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqdfLoKM; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-551f14dc30dso2420263e87.1;
        Tue, 20 May 2025 08:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747755546; x=1748360346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+l+FDt25UF55NIxFW0g1GLWBPYAD9X7H0nxKJbiYyvQ=;
        b=SqdfLoKMEIXka8yPwVZIxvbnowdKQ/biGXU7pTdNprSkhGpMWH+hblfQs+Sjti5T4c
         SYu4bO9Vu4MldnrXK8m+78DzwVqOT423YESq0n1qhZFmTPSPtP2oyn8rPfRUo99nybQ+
         prOi1pOotFt440iHeUYfPDcfLRSGdpMESl1Ptzi12aClVzErSwx86v7kvMu4WYHdoyEp
         dojV6+M1Vft9p8zk3Rc/sICr1JLYMIb/xwAy31iq2+nkD/dNmhw9L9mPS7QB33Ris2RC
         rfs8d9cL6A6dV5VpxTfNn0DKRjgpyT+1Cq9fhB2K3b/QpjdWjQG6l6RR9Bpy/3yCngAC
         M0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747755546; x=1748360346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+l+FDt25UF55NIxFW0g1GLWBPYAD9X7H0nxKJbiYyvQ=;
        b=UhCNdS4HI6xNMPKwjbx2SLVpS/vZvhV2zrstHrU1iBfB0/gvs7OvHPjizms4naUDfz
         Xp3phfEs2iOGfgMgsSkNI5rIrwBFhrWDwJ0oqb05yYJFsBKxiGrU3jYAENgupK8VeYsG
         PH6NEKC9tqdS1PUZ4L38ooQH+5QhQGhZuKGgkEnoYbhMUllI+D53BC/DZMGpojyOuUjr
         xweSwgHQkKjbfErwRkM/R21LbdfO5Gm9eSMs9SOZlSiUqKdM07dAAHlv62csBCXpzMQ1
         bKno+XEyJhA6bUQvGaLdZatGQj3NaUsyBoiTRumhBilM7ETeDkr81VMeouEIjGtW8Pbz
         iXTA==
X-Forwarded-Encrypted: i=1; AJvYcCW3ZM6UYP79vU1pnpJPN1lGHMVB9ltLu3ETkaeaeBrA3sUUB7+ZcgNm9hQycyt5Wiq6dmS1EGq+qAzqGNY=@vger.kernel.org, AJvYcCWtxx1mis5LjngCVhJrWOIhqq5trUbrvpkUyXVSWCEGqQaMf6rqJDNHk2xGmwsxGJ/yx/1wF9Z10Vo=@vger.kernel.org, AJvYcCXfH1nhahxtHNLLrNyUQrnfCfo5Vn2GkCoNOo4duHmTaB/SphVlhdkCQD4nNiOQZYgqR14Hv3t7nNxN1g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLJeTG455nIPKCXckeJMf/wqpE2TsaMbDxZ+ZCG/gUFGj1mVPS
	cCmQmlPZb7BqaC9Xuen5yzSNd5Xjz8OpFtpOsis/abd49sZ+cJ2kzA8wpPRPLMn5VlQECq0pEgF
	H7EqOw78/uLwxGgtEr5G0hG/TSfGnR2UmiA==
X-Gm-Gg: ASbGncsin9TljWY2c7Say/YK+aZ1S2H6dIenAOOiAW2KECtN6lmevY4ZRRhgzwKztPs
	is7k8q8JKtOtIzyS/a1BmLEip1QFahaVqiWGm23tGenhMmkbZgiD/iB8dmPcLLYx1aez0ZMh0V4
	HXWeFX/rYduXzy3P6G7vHFnyVHMDYS1IBs
X-Google-Smtp-Source: AGHT+IEH7i9q6i9KUI6txwUbjtLe8y2vI6+YwyNe7U12nLUG+bx0jXWcJbykZxu6YF3OtmK30cumXUZ1J3n+uTatHsQ=
X-Received: by 2002:a05:6512:660e:b0:550:e04d:2b66 with SMTP id
 2adb3069b0e04-550e7506bb8mr5290328e87.17.1747755546022; Tue, 20 May 2025
 08:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-2-d142bcbd0234@gmail.com> <cd801698-d7cf-4e9e-aa01-5525f8687ab0@nvidia.com>
 <CALHNRZ_9tMi5iihyTsEuU4T72=oTQM6-rVhqozzLf9DiB_TpcA@mail.gmail.com>
 <CALHNRZ-pu9HUzVyR3-U=XZKFFZPnn5-DNLWPqPx6CSoW0dHMrA@mail.gmail.com>
 <bc0a4c75-df5b-4b4d-9c9e-a2c99d3f4f6e@nvidia.com> <20250519103749.falgd64ikkwkfpg7@vireshk-i7>
 <9a15ea89-5e33-48e7-8c75-b041f6832bc1@nvidia.com> <20250520103304.jfevon546rft2ncr@vireshk-i7>
In-Reply-To: <20250520103304.jfevon546rft2ncr@vireshk-i7>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 20 May 2025 10:38:53 -0500
X-Gm-Features: AX0GCFu2LIx9ldoHs1ixgTO3PVVcIJszJylkzn45qiIBEebHWvwZ7Z6SKL2Dr0Q
Message-ID: <CALHNRZ9ue242oAJctGszHb128ak8ovbESs5Y-TLfesSus5FAyg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] cpufreq: tegra124: Allow building as a module
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 5:33=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 20-05-25, 10:57, Jon Hunter wrote:
> >
> > On 19/05/2025 11:37, Viresh Kumar wrote:
> > > On 15-05-25, 07:41, Jon Hunter wrote:
> > > > Yes and that is understood. I see a few drivers calling ...
> > > >
> > > >   platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> > > >
> > > > One option, and I don't know if this would be acceptable, would be =
to add a
> > > > new wrapper function in the cpufreq-dt driver for the above that ot=
her
> > > > drivers could call and that would create the dependency you need.
> > >
> > > Doing that won't be a problem, but I doubt if that is a better than
> > > adding a soft dependency here. I personally felt that the soft
> > > dependency may be the right way here. The cpufreq-dt file presents a
> > > driver, a device can be added from any file and that doesn't require
> > > the driver file to be inserted first. If the platform wants to
> > > simplify and create a dependency, a soft dependency looks okay.
> >
> > The only downside of a soft dependency is that this driver could load b=
ut if
> > the cpufreq-dt driver is missing for whatever reason, it might not be
> > obvious. Ideally it is better if this driver does not load at all if th=
e
> > cpufreq-dt is not present.
>
> Fair enough.
>
> Aaron, you can introduce a helper like cpufreq_dt_pdev_register() to
> solve the linking here.

Will do. I'll get it queued for when patch 1 is actionable.

Aaron

