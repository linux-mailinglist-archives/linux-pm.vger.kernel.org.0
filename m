Return-Path: <linux-pm+bounces-37653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E775C41A04
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 21:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5E0189891A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 20:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BC6306D57;
	Fri,  7 Nov 2025 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMhhYjCv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8022C2BEC3A
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548418; cv=none; b=m9uG/1NkB1I/yfYSSTDj1hy+xqbxRwX5F/f/K/fj1xkvanLIFx+cSArxG8+ajqNl/XV+azbhEFMihxo7m1nloIig3BkZqFYGeBjgYF92SzkQSh2J3m6qAyqaWcb2POaK4rLzTavBi0g6pY9kaU4wx8/zvYDu0tviRk53eYiayhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548418; c=relaxed/simple;
	bh=LIm70iNe4RFU4RUlEutJN3YV5NeEGUMDBkArh71fotc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLzJQ8009pwoovW6VJZsg44mUud9g/ahwSLCWl8wYXAMCk5uySc8dvmjsPb3j8aie77T9FTCn1jFduf40JrcuA1KWYXs6hfR3EUByKBPmYqVdCajavm+0ddaGtRy/BQjvaiLTkGxln+7cLOEQgta0kCzPQbmHoFxAspJki3F4wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMhhYjCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C061C113D0
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 20:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762548418;
	bh=LIm70iNe4RFU4RUlEutJN3YV5NeEGUMDBkArh71fotc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WMhhYjCvKeqaUFrZGUz2DfH+dGlVKDL7Fb6ACkMO6utCzYlyd1/0qbXfKkU3HhsYL
	 I/ebhA6kgXfECnIyRBrcMTsCnHJ9RuLZx1T7PKRDzP99b3XSMmVzoCbAwdJ4m9hVOd
	 RU/l0/Nw6FozbPpsq11ddweUXW7FGcTO7e+9UsRKD3+YKOeRYCwfNodNpqODJ9R5qF
	 UYW0a3bVKt2bAZC6sTmHDFDtiEnn3LHr8S9Dogxl/Lm2aqiN1wxhItvAVcDvTE7Nfi
	 L7V96Ah7QeW51or0Sk2WKo5dU6rk/z1lDOL+tGrBMP+5njQXHnLj8i9HAUKsf5TP7t
	 q3vk2CTfYcSJQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-656b7a2e7dcso588556eaf.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 12:46:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVOQtjMicKpXYuy1Fbu+DMF/vpibW3gJ9FazfdiGYE1xaQR+rXcOn66rMM8hwa3F+fXH/3Sba1oog==@vger.kernel.org
X-Gm-Message-State: AOJu0Yypf/jdoWTkx38eh/zmYHAqO1HKtzWKGnnkwUYVmdmpBrLC+8hM
	ffjnjJLPUHXGpWaQIF9fpmVE/M5h+EwS62lvFUsBKUtNw+i09s90CawoX4CUCoDePqyHVX+nQ3m
	NEgJh0QCV7NnddhUumwdzzsob5/Ck7pU=
X-Google-Smtp-Source: AGHT+IFZgui/RGbbYfRP+5Hu0XZ0807MD+8j83XPiVHELdFX/cz59XT9FYbwREuS1eUKNMBS4AtPkqNXvMbOQubmHw4=
X-Received: by 2002:a05:6820:3102:b0:656:b1fb:a8fd with SMTP id
 006d021491bc7-656d872f363mr507199eaf.1.1762548417413; Fri, 07 Nov 2025
 12:46:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027044127.2456365-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20251027044127.2456365-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Nov 2025 21:46:45 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iAHMUQ99Mc_cBDHPHcjG5p+o67SDmvwd_eAkDxR5zZmA@mail.gmail.com>
X-Gm-Features: AWmQ_bns5c7gHcJ8aj4uyf6qXF2ZBCXrlTot4dguVWxOgp1LgeZ7h4jRvY0DKcQ
Message-ID: <CAJZ5v0iAHMUQ99Mc_cBDHPHcjG5p+o67SDmvwd_eAkDxR5zZmA@mail.gmail.com>
Subject: Re: [PATCH v3] PM: Delete timer before removing wakeup source from list
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, pavel@kernel.org, gregkh@linuxfoundation.org, 
	dakr@kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 5:43=E2=80=AFAM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Replace timer_delete_sync() with timer_shutdown_sync() and move
> it before list_del_rcu() in wakeup_source_remove() to improve the
> cleanup ordering and code clarity. This change ensures that the
> timer is stopped before removing the wakeup source from the
> events list, providing a more logical cleanup sequence.
>
> While the current ordering is functionally correct, stopping the timer
> first makes the cleanup flow more intuitive and follows the general
> pattern of disabling active components before removing data structures.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
> Changes in v3:
> - Use timer_shutdown_sync() instead of timer_delete_sync() to prevent
>   timer re-arming as per review feedback
> - Remove timer.function clearing as timer_shutdown_sync() handles it

So you need to delete the WARN_ONCE() from wakeup_source_activate()
along with wakeup_source_not_registered() because now it may trigger
before removing the wakeup source from the list.

Frankly, I'm not sure you know what you are doing here and I'm not
going to consider any new versions of this patch until I'm convinced
that this is the case.

Thanks!

