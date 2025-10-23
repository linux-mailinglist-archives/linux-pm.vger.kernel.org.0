Return-Path: <linux-pm+bounces-36713-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98071C00927
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 12:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD0919A80D1
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 10:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67306309EF4;
	Thu, 23 Oct 2025 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/Qh9TlN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B44E29B8C7
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216618; cv=none; b=fAl0n6RfMIZQtTopYHl6KEU3kLHYUkQnxiMVT8MEMKqJat5Q2DzpfHi6oTH623wlokMZqoGBpXTm4ddtmcR8pNZeoCXDSmEdKXgcjvmIGCW+b+eVYRRnlCetRk7Kw9Io50NBuqbv7w64KK8YxKNBdnJzS60YnVxnbiCjg7gvEkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216618; c=relaxed/simple;
	bh=hHgcggWZ/t9HSfTPGxpCUE3xglrsVpf1BDu/EKLJTIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoWw0Neg3ed2pzlJZQC0o9cWV2umz4q1QA24yCRQTfW94wzZIBqRFImMPhax2DkJxSqPHN1+AaJR/mqUwJtZ+O7/WDzJSRHnVpy4XCqHiZxQ+o7w5eYVxyfBqvL2ZLfpH4h85Uk3Vn3sKb4p5mTw9hlpzTZQMuKITOmJC8zLIRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/Qh9TlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0FCC4CEF7
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 10:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761216617;
	bh=hHgcggWZ/t9HSfTPGxpCUE3xglrsVpf1BDu/EKLJTIo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z/Qh9TlNZMhSikFb104aHroPLsZVaxMwcRwB29PXAHj66rbIOKhxo3caSslysOhOR
	 eBbNQVbhOjZAZEOlKwuO5USFhDUzMfjJs0PWGHWUi4UraPXrkRL0v2l8CJVnk8PLqg
	 oHW3Nj+Pp8avk8Ycp6EhO8PoMY8AP3qLVf6FEy5bfgzoC9bVUoSYzg23pXJWxFzLja
	 ZXUQsoUtClErPrYg3NpHlz3CkJpCCzVfEn91OwhrGGP/lw60N4sFJddjR6UMEmgm9Y
	 j9lXsPdY2+JF6A6CwdysIS+LDNZSm6O7kOQgkMiUk9OdKli/JWvmGTCgF9KCgvdNoY
	 LBHGbaV+f6Q1A==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-443b4d7e927so349231b6e.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 03:50:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2tbYGediYuOsG9AdVSl+xAPn4nlk0Cy6L54DMxu4v96Oo0zgxstoLW2Q8b3iztC82UbJcsjYbVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+jhk6UMLKRKQ8j1WoFrmWBAbt//SnlCfJI1EbdBJ1T5q7UDgA
	Ncxtzwx49XMiN3grEvEpzqO+O0iV5TCE1fQ7l+Br2N1oDDxKTCmkE1XDmppwWt7aG0mxkF9e7rY
	HCa1IoxsQn4sJS1gnOvFKv3ieoqKqq1c=
X-Google-Smtp-Source: AGHT+IGCfWJiyXHV8J67lDH/mXJwOHR5+Oi30gvPpLfBalmvkb+jEOEeqsxZwOcsTBY210AxGsxZJVUKyrgU9edhkdc=
X-Received: by 2002:a05:6808:1383:b0:43f:6d5a:9cdc with SMTP id
 5614622812f47-443a2e90a97mr9424461b6e.23.1761216617126; Thu, 23 Oct 2025
 03:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022222830.634086-1-wusamuel@google.com>
In-Reply-To: <20251022222830.634086-1-wusamuel@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Oct 2025 12:50:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j6SzpA-Zp-v19RTAmGSzejGfwzjsq4UvAkKLDXCPJEPA@mail.gmail.com>
X-Gm-Features: AS18NWCa1bh2sNhE6H6CvJh4kNdHo4_Cr9awNuc0JLJhc7_KwxGiNro4tzk46-4
Message-ID: <CAJZ5v0j6SzpA-Zp-v19RTAmGSzejGfwzjsq4UvAkKLDXCPJEPA@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "PM: sleep: Make pm_wakeup_clear() call more clear"
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:29=E2=80=AFAM Samuel Wu <wusamuel@google.com> wr=
ote:
>
> This reverts commit 56a232d93cea0ba14da5e3157830330756a45b4c.
>
> The original patch changes the position of pm_wakeup_clear() for the
> suspend call path, but other call paths with references to
> freeze_processes() were not updated. This means that other call paths,
> such as hibernate(), will not have pm_wakeup_clear() called.
>
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>  kernel/power/process.c | 1 +
>  kernel/power/suspend.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 8ff68ebaa1e0..dc0dfc349f22 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -132,6 +132,7 @@ int freeze_processes(void)
>         if (!pm_freezing)
>                 static_branch_inc(&freezer_active);
>
> +       pm_wakeup_clear(0);
>         pm_freezing =3D true;
>         error =3D try_to_freeze_tasks(true);
>         if (!error)
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 4bb4686c1c08..b4ca17c2fecf 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -595,7 +595,6 @@ static int enter_state(suspend_state_t state)
>         }
>
>         pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[s=
tate]);
> -       pm_wakeup_clear(0);
>         pm_suspend_clear_flags();
>         error =3D suspend_prepare(state);
>         if (error)
> --

Applied as 6.18-rc material, thanks!

