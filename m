Return-Path: <linux-pm+bounces-39816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1E6CD7512
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 23:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B73653013388
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 22:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3A63590C3;
	Mon, 22 Dec 2025 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFYzCnK7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A27E3590C0
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442971; cv=none; b=VlWZvWPx4qTZ+/iV4mnHx+t7fjfuUbZmLCahhZzmJSt0AVNQ1qIp4xTxFmdbt7At3/p4v32ixtZ1lEiaz/wETszwCBcfA62yrJXQZ6g0jfehxl9+zqFrNPdrWRR7eSwjUUxItrrBwhjVJtRUQw5FjhFU1Op6JVo26Wy2NA8woTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442971; c=relaxed/simple;
	bh=ZTSi5WfjcxWNheb3HVG1mIlxTye7We2VnyRSgSM5Yog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udq3CbZ2S8MJuS/YaFUrSt2UihizotTT8Tt0WcFARlRlwQmSVOY2RsgJjLsLIGtRI8ixTDUyaGhSDBCZnD/vpp09ekTFB/xCacMwnK+X48GwzA5yxTRSkxVQa6r4seE+pvk2wV99otAy4DCaHbw6eb/CDnm54rsdeWvirB80F8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFYzCnK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A33C19422
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 22:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766442971;
	bh=ZTSi5WfjcxWNheb3HVG1mIlxTye7We2VnyRSgSM5Yog=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aFYzCnK7g7A3777d+EZo/3VmyM8QwOK4A6HyllqrWu4HYVbMWTPlgNWPvzEFPztDK
	 Bbo1gz/Jpsm+0FhDma4ofNv/zTPSmQnrlUJhgT9dDIE+xCG3OBsQwsOGUSL1MbFRW2
	 d5jfLaeVKaSwYtEzrU0HxQI8C98Y7XhAE6JSksUdGe+xuIE6EUUOMZWAluRXkOIc+k
	 P73LWUGpL1WF9XX9+d9zHMNCMNwTaEzQ7T+JZtsX3VflsViOpGrFHzTqFDN6ctwdKM
	 fbsZabgKMUs6Z4eBGi9MlG2SDjAA55YbMTRH3XQ9Zx5ATM8sdJQDwAUo/Orizpr8Cl
	 WNOUqsDJ8RQZw==
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6420c08f886so5724138d50.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 14:36:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXxwYB9DLX0ymM+djaa+RfngTb6ZwbVJXqcPR5NUgKFtND6O2dlCaJWnrpuDNCws26UwvZ6x8lcoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsUipkhE7GD3cJzknae8ki50H184VJ/kminreYVTB/O4BD/V+n
	g05lNNhmhKHFVI5W0nZcj0/8nxQmaukUKhI171cSFl0nWM2QPP6sEqNuf30P0Kw5col6eZGAndM
	+rd85dhV328Moj8/mt9OshXWTXgvchKs=
X-Google-Smtp-Source: AGHT+IHr1mVvjUcKQYlJez+7/vVibHPw/PLSqX0yA7RlNrH7URuXVoJM7Q4OahaUoSTP8q7uDbm2tdeOHKa2JLeulb4=
X-Received: by 2002:a05:690e:dc4:b0:644:60d9:7531 with SMTP id
 956f58d0204a3-6466a8dec8emr9014234d50.87.1766442970350; Mon, 22 Dec 2025
 14:36:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1766268280.git.waqar.hameed@axis.com> <ccf83a09942cb8dda3dff70b2682f2c2e9cb97f2.1766268280.git.waqar.hameed@axis.com>
In-Reply-To: <ccf83a09942cb8dda3dff70b2682f2c2e9cb97f2.1766268280.git.waqar.hameed@axis.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 22 Dec 2025 23:35:59 +0100
X-Gmail-Original-Message-ID: <CAD++jL=Ejfjvj7n19jpCHfB6U1QkOAZZRKqx0ToFSLS91JtNHw@mail.gmail.com>
X-Gm-Features: AQt7F2pm_rMu981uN04Q8q3VNZOKIuNYr13gWDjXT_qWrMEs0y4BbeAyBb08u48
Message-ID: <CAD++jL=Ejfjvj7n19jpCHfB6U1QkOAZZRKqx0ToFSLS91JtNHw@mail.gmail.com>
Subject: Re: [PATCH 01/11] power: supply: ab8500: Fix use-after-free in power_supply_changed()
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Sebastian Reichel <sre@kernel.org>, kernel@axis.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Waqar,

thanks a lot for looking into this!

On Sat, Dec 20, 2025 at 11:36=E2=80=AFPM Waqar Hameed <waqar.hameed@axis.co=
m> wrote:

> Using the `devm_` variant for requesting IRQ _before_ the `devm_`
> variant for allocating/registering the `power_supply` handle, means that
> the `power_supply` handle will be deallocated/unregistered _before_ the
> interrupt handler (since `devm_` naturally deallocates in reverse
> allocation order). This means that during removal, there is a race
> condition where an interrupt can fire just _after_ the `power_supply`
> handle has been freed, *but* just _before_ the corresponding
> unregistration of the IRQ handler has run.
>
> This will lead to the IRQ handler calling `power_supply_changed()` with
> a freed `power_supply` handle. Which usually crashes the system or
> otherwise silently corrupts the memory...
>
> Note that there is a similar situation which can also happen during
> `probe()`; the possibility of an interrupt firing _before_ registering
> the `power_supply` handle. This would then lead to the nasty situation
> of using the `power_supply` handle *uninitialized* in
> `power_supply_changed()`.
>
> Commit 1c1f13a006ed ("power: supply: ab8500: Move to componentized
> binding") introduced this issue during a refactorization. Fix this racy
> use-after-free by making sure the IRQ is requested _after_ the
> registration of the `power_supply` handle.
>
> Fixes: 1c1f13a006ed ("power: supply: ab8500: Move to componentized bindin=
g")
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>

Hats off, it's a clean and precise fix.

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

