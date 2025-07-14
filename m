Return-Path: <linux-pm+bounces-30778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F2BB03AE2
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 11:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8EA417BB8B
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 09:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495D5241674;
	Mon, 14 Jul 2025 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="di1SOu9k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CA32E3718
	for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2025 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485689; cv=none; b=inQ3lY7P/11AuGcLWIT3OTzJtIztOroHngcRwy7j7fjbTdHfB6r2NQPp65qJbYQrtWsgDnObxT2kg0CS+5jLUFrj06UIOgcTi40H7AxV0nM6BRrcnVFg7ijhN7bRhaR/04X2UP7KcvbjIikc57OJb8+cmIj10hlJEveKUJT4WU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485689; c=relaxed/simple;
	bh=UfwKYdfhLk2Qy+lp7anf0iJDtzV7naJAbuUbpizuis4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SeJhqh0oAuOkB2ox1j/h5Z+vaIT/bVANW+6+zglQgGuqeLBcy603LQyhkmRpFOUAN104+bOnpxRvAD98jdfUDc358xt+aDuvoj4vdDJv4yLNSckNLzM3q48CaGzUy7AVvI1YOnp+iEy84TdWr7W2bK3auac8ZdcSGInCCJyJLoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=di1SOu9k; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-713fba639f3so33656257b3.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2025 02:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752485685; x=1753090485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vEmmr4XGYIHTUb8r2LHfVd1MIoDVWAOSUqn/NEpPRbM=;
        b=di1SOu9kEFU45yaf/R5J/6R+Bg6mYwoa9dYW5LtCDcJzD1ToEk5wcOtE/9Iag6dWcf
         FJzKHkIh7LL9XZpdOe9l5mpGzgzKV4lf4vbyjSiaY0E0Cf6eQHy7jBS4RssfRCQ1bwiK
         mlMjxiK0WpoBtUfGVevE+X+EhK7X41zVYyF+DisvaNNr+F3CYwihd4eVhJ0BqnSYxIce
         42AvKP1sASthFrA0dcHmdF97uoz5WHuebMavzGRy4uhPicT7vMZGkPUjU51aZViAybC4
         YlP3Ig+ZWzk68fU/dCrGTPcN4CJuLBw1XKm1RVRyE76462b88rNzZlxSw8Ef4gfToPtY
         hqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752485685; x=1753090485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEmmr4XGYIHTUb8r2LHfVd1MIoDVWAOSUqn/NEpPRbM=;
        b=ih+m9pTFTMVfaC+BkgoNPBpl8FP0xM+ZnggObK7ru+r5+ZLCpE+jO6r4yMg0REuFTD
         9BSDIucGkylcYTGUta54oemDPkJ6Bru+5CN9uLtAx+qsOyD34IAxIDcGHZ6W9Y9ea9Rt
         thCkuAvzIpuAJbha7dIq5nkUbjhhr2XE41q9GN53qqWlINMG/7+cZ+SJQPG+QlgE01yC
         CdGPCrPVM05XbFEFZ697p3EX5YUCAqF2MEhMCZe6T9oDl3+ZrsoAjN+x3bG5BE3JjHhD
         EMnF7UUByKZxCgowoijNFUyf6oIF/KXvjeKq3lxkSUrh0xDBjAGGozdji4HlJ0xux6Rz
         pxzg==
X-Forwarded-Encrypted: i=1; AJvYcCWeMSLHafuz8wrxl7K8kOuwidQA5LjtEuDLXCyRxP+6brgqnr5dhV3xZjF6Cuu3qE+UMhfhExjYWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtmc8GpdFluG+qakgipUi5gupv/0LEJVxWlCDggM5YV2/Ygexm
	toM92msiDHzFJQC8wWJGnOlTEf6DphJ/uCInOr/nUptvweviX06WyGO440Pg9AyGL0szUSGzDGs
	Qp9dyOag2MGnEuiMs1y7UJ6RBeFa1H4xPW6LwqnigxqaCLVEqr3/wrGg=
X-Gm-Gg: ASbGncvFCbzsVC4ZOgEIkilDgbj6AXgdzePBM+xx8tU5fGM6pG9Ii5MQGL5DXF7bJ+c
	Okoce3Dzp2gA0GleDs/zbxDAsSlXAb0EqV24GiGrSorVQ56yAVkvg5mUf3PaCcJA5pyp/cAkiK+
	lhAby/f5LDBVR5vEd/hRv03zAKkDHMnjDtaOVy75z1U/8APFzIQXJX168y7Fi6zkTdVyT1ROkQV
	gLacnRfC6E5sbkVpVo=
X-Google-Smtp-Source: AGHT+IHIlg2QgBnKLSKe6umOG6mLkyHuyOGa5CDuUCJGRmLch13uGRl1lyUH/fje8e3UhcJpXB/eeeAkkqwb0eDhQ3E=
X-Received: by 2002:a05:690c:628a:b0:70e:7ff6:9ff3 with SMTP id
 00721157ae682-717d5f3d391mr195973477b3.35.1752485685299; Mon, 14 Jul 2025
 02:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711114719.189441-1-ulf.hansson@linaro.org>
In-Reply-To: <20250711114719.189441-1-ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 14 Jul 2025 11:34:08 +0200
X-Gm-Features: Ac12FXwf4BfTjOB0bq-V0l481-9ls28bgQwLelpMu5ij-cJg8s7O_Ow2nAI2D7E
Message-ID: <CAPDyKFrouK9b8Gd+DYg-=BE0dYVuiwy3+Jkrp1=4dDXu90gDTw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: samsung: Fix splash-screen handover by
 enforcing a sync_state
To: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 13:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> It's has been reported that some Samsung platforms fails to boot with
> genpd's new sync_state support.
>
> Typically the problem exists for platforms where bootloaders are turning on
> the splash-screen and handing it over to be managed by the kernel. However,
> at this point, it's not clear how to correctly solve the problem.
>
> Although, to make the platforms boot again, let's add a temporary hack in
> the samsung power-domain provider driver, which enforces a sync_state that
> allows the power-domains to be reset before consumer devices starts to be
> attached.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Link: https://lore.kernel.org/all/212a1a56-08a5-48a5-9e98-23de632168d0@samsung.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Marek, Krzysztof thanks for reviewing and testing!

I have applied for this for next!

Kind regards
Uffe

> ---
>  drivers/pmdomain/samsung/exynos-pm-domains.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
> index 9b502e8751d1..5d478bb37ad6 100644
> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
> @@ -147,6 +147,15 @@ static int exynos_pd_probe(struct platform_device *pdev)
>                                 parent.np, child.np);
>         }
>
> +       /*
> +        * Some Samsung platforms with bootloaders turning on the splash-screen
> +        * and handing it over to the kernel, requires the power-domains to be
> +        * reset during boot. As a temporary hack to manage this, let's enforce
> +        * a sync_state.
> +        */
> +       if (!ret)
> +               of_genpd_sync_state(np);
> +
>         pm_runtime_enable(dev);
>         return ret;
>  }
> --
> 2.43.0
>

