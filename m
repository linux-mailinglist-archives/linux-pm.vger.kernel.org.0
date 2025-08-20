Return-Path: <linux-pm+bounces-32715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4370AB2DDC3
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 15:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD5444E3343
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 13:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B451B320CBF;
	Wed, 20 Aug 2025 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTcHD3XD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B83302CA4;
	Wed, 20 Aug 2025 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696556; cv=none; b=mP8jSC5nDQFHQbNONqOW6IFezyCagsOf1x2CB0W8c5xg8Bp1oOJhOWdpu+gY8LPXin81DJt61DiF14uYRZLMdECfsdsAkvyH3E5aNPu/He8pO5Hj/0RSRXNW0dENNT68OURatT103hG8yw+a/sP+RRB67KwTtc/qNWWdGbqeDls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696556; c=relaxed/simple;
	bh=jcAhPAgzkLaVyfYJ6HVDIU6MyZqCUM3ppV4rWifv/Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoXtYyniJ+BMZGpMYFdQLn2I7yPfRwZcVYYKmKNDdPJrq5JV5cb2SFIdCN2S+nOKNmhAMFFFXD+2eVpTvw27HbE3jT+7F29/+0nZCjzHFeU9vUTVCHw8qHBc07GwZENEZKUKrFiDxfVFkcD8lrpSzPxDj93elP3OL/tDVedB3bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTcHD3XD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so8788558a12.0;
        Wed, 20 Aug 2025 06:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755696553; x=1756301353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jcAhPAgzkLaVyfYJ6HVDIU6MyZqCUM3ppV4rWifv/Jk=;
        b=nTcHD3XDqSDiWi4YdulM0ynlhv4y0em8zh69aidR3LNtfPWtLE1c/h8T3uxDRsKga1
         yAswCnXSpdYzuVR2ERaHZrKwdJ4mUPVHnd0aADrVX1D5VOhEgqQmkNUe3plELtVxqFXC
         78mL07vxg4hq4d/JXEpRkxnlhdzeCSJY6NJU0jY1xSmo3ol1lnZ6+vgPgkxLXARIDbtF
         l+wmw5y5zfVBY5mHc1kxRyAifKco0PxBtXC5RR3qToxIiehmBpVhRyeialZob+mllohy
         uTOpgxvCkZd7hvNvcq2gzD/NQsSp8bvLx1o+S4J/1Ot0XFyDRfZxj2cE4PwltPN0EREI
         IR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755696553; x=1756301353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcAhPAgzkLaVyfYJ6HVDIU6MyZqCUM3ppV4rWifv/Jk=;
        b=iqjHrIc5zZ/+8qjYBVKzTZ8dCZm2E2NyZMnbNQ2VjzMIS8jFcWUl/geFxrp7U7H6QM
         erwibPL2zA+ovwEK0TfUXtb+ke4iVZ/kuTDZCFCt+O1TIODxUZCfnudcpL6O/Kw7BjlY
         OhOC3In0UhvdxDJsmeA/eDj6HEzeOZZtSDrVsyBmKuHjXK+7jGFaE436amNN0YSLp2Fu
         tnliFhgU+YtLr6sDwUtKg9ONla5ZqeRKmrquuhT2jWiNK7vRYYP5kfmn7DJO5Ok44Rt4
         dsw4ElPE0VoY+KkCFuusBD1wDNiHk3qBZg7bFAKMEMWD8wkgk/UBrMdgvCQlifcWkBGm
         gvzA==
X-Forwarded-Encrypted: i=1; AJvYcCUlUWeuOG/2DY9Oz3UMoBSicKKu9aPaNHqHPtPezzt4wEcKMLXA//wRhgkV5yQ6xab2zDwErxv/zl8=@vger.kernel.org, AJvYcCUqCD/Cp77qn5OO5A1jXRbjfB1FsUDmxRq8wYDDAun/qB5+D6gIuwzKS4ZjZTOYfqa+mWLaNOZkQSS4XTc=@vger.kernel.org, AJvYcCXIVukM7FjVnCYe/32Pp2CZSt9JaPbUNR/6CFizU8KNm67RqRbzTkGXeykgE0+T+msVr13FLP1ZcZ/QLAeUo/Rp2Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwApeFRBE9yxwCp39TN9Hlz04G+27n+cTydZBbtxSFc6tbcmGRy
	mTS8AU/cNCS8e8XFCXyPD2riyTt7R9DowiLbRqVsRiV3DHfPpLlfs1EAlP+L5bkald2KNkSWtjZ
	31y/zqkDMQXzDPFUmYQ3R0uvID1CY2RY=
X-Gm-Gg: ASbGncu+MggXFBqm36CLA39hGdeiZREUwzWds9z1dnbM++z5VbdZtDiL9iy9eW9IOKb
	8ZLBuzlYPkvPwRORsJOezoiQO1zYEBI+3B1tA7csthZnIUykLtr5aHTdGuf5RgXon3Bc33xL1KY
	yZGkT2DdKM14czqcOjEfo83URYt+mQKzLOtf3im8ftnRMMyJYEZmztMv0gmE8NQBFxj+ZpprC1U
	IgH6b4hdAUZsQNE
X-Google-Smtp-Source: AGHT+IHFi3UnZfTw+Hv/V/cy2pIQVkpT2x65dTknRglGXAcVRAIsoET4c6TvnkcXRx3Ti2/3OD7ZQ+iy7/fDDxqGtI8=
X-Received: by 2002:a05:6402:510e:b0:617:e4ba:30aa with SMTP id
 4fb4d7f45d1cf-61a9786a600mr2311059a12.32.1755696553444; Wed, 20 Aug 2025
 06:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250819131814eucas1p2c57ccc084cf6736fed01a8a5c0b35fab@eucas1p2.samsung.com>
 <20250813131007.343402-8-linux.amoon@gmail.com> <20250819131803.23296-1-m.majewski2@samsung.com>
In-Reply-To: <20250819131803.23296-1-m.majewski2@samsung.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 20 Aug 2025 18:58:56 +0530
X-Gm-Features: Ac12FXxN9zWO5PU4nqi_PrX_I2ZcRMkaURhXBeEwISjFg2LiE8-GfoSiC8m4kiU
Message-ID: <CANAwSgTW7qZiSKRJuW-AqW9BKBrjsUMm8qqa1VKrxjUJFDG6zw@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] thermal/drivers/exynos: Refactor IRQ clear logic
 using SoC-specific config
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: alim.akhtar@samsung.com, bzolnier@gmail.com, daniel.lezcano@linaro.org, 
	justinstitt@google.com, krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, llvm@lists.linux.dev, lukasz.luba@arm.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	rafael@kernel.org, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Mateusz

Thanks for your review comments..
On Tue, 19 Aug 2025 at 18:48, Mateusz Majewski <m.majewski2@samsung.com> wrote:
>
> > A unified
> > exynos4210_tmu_clear_irqs() implementation now replaces the previous
> > reliance on SoC-specific functions and hardcoded register mappings.
>
> Well, right now we actually add exynos{4412,5420,5433}_tmu_clear_irqs :)
> But those are quite similar except irq_map values, so maybe they can be
> unified into one?
>
No, the BIT fields for RISE and FALL are a bit different for SoC
So that's the reason for splitting, the IRQ handle should be clean and compact.
So make them simple.

> Kind regards,
> Mateusz Majewski
Thanks
-Anand

