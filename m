Return-Path: <linux-pm+bounces-30755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9345B030D8
	for <lists+linux-pm@lfdr.de>; Sun, 13 Jul 2025 13:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB8A3BC542
	for <lists+linux-pm@lfdr.de>; Sun, 13 Jul 2025 11:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B931F7910;
	Sun, 13 Jul 2025 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxOsCIre"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014962E371B
	for <linux-pm@vger.kernel.org>; Sun, 13 Jul 2025 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752406178; cv=none; b=oSFC4uZk7K9f1Rd5ycjP9/P5Kalvqd/J0owcTELb0KfPy64oX9EFzhJtnEM5P0tQ0TUMSkltY7LGsKXnopuqKXeENld5vmpn8u0gpkk5wMLhIZNL3zaD4mXtj6TKtunRa9S+ic5Bcn+VvbJdfzD6dbUlRg2COOW3XaJRUyS2uzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752406178; c=relaxed/simple;
	bh=ig/sm57boXoszdJ3yZiDJeFX0iSRVVKic0nJd8RRGPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdd8YMJcTsHw6KAW7aR6kMatzD3HQeIf/gs9/VprYgCFPh0vJonZFx3a18rhbT9rom4xD40pqW6NgDpQmvWfzui5o6ZWW2Fwg/aMktRhUrwsaw35LABB+FCsKqw5WwqasNu2w/It7f/QfQtknR2l4vtMGY2l2ffENU92KZibWJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxOsCIre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5FDC4CEF6
	for <linux-pm@vger.kernel.org>; Sun, 13 Jul 2025 11:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752406177;
	bh=ig/sm57boXoszdJ3yZiDJeFX0iSRVVKic0nJd8RRGPI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hxOsCIred2UJMy8IbaIthkeTlB3WqZL+UnSFRVsvrqxbkpzODsQL2COS/0Bk0f4AR
	 zP1kGBTMzgb/QtYO801I/b7ZJ5vh73gJjPBxe201tM9Yaz1kNu5VP0HkWRlnpeywPp
	 vifQt/APv58PF67up35PRHRopQpj4m25DQyVW+yzHM/d5SRD4npMunrlQ/LEddghpL
	 8gvmofDAe+V6YFcFsYTYjlDBBnp40mVww4jIlWU6SV0t0rmpaz+gkVAfTnSJBOVP8Z
	 U1W918CsUTfhNmdliZtMxk0KQxzFK6RMygKtR/5R6M96ht1GvsaNlAF/fQn/j5MMy5
	 ds79+O8hDCNYg==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-40af40aee93so2191946b6e.0
        for <linux-pm@vger.kernel.org>; Sun, 13 Jul 2025 04:29:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLCk2MUHYBQcLQdyidI+k6Dht5NX/8OeOFdsJTCYYDYcCGTjy2abRAC9O4EkRoD2qgL1t1/0Q17A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiv9kaVy4zLI7M5Iz0qBqeUbDYIeHHEsW31gr1WWvxn5woovp4
	+brvvNsxzgZxU0cp0F7OzDz/wJxPjyEnrLBMjj02vGcgftk/Plm9AI1Xxbxq8XqgFb2LkDAUOhk
	o1dDv+06w19RC0qewHllUnNb8W3cMcL4=
X-Google-Smtp-Source: AGHT+IEbeIBNi8DPExLaD+X7ITACu0H7obzT6EaTy+D26zLM43xcwDkekX0CkoMJbiG8/74DftIxgzJluaI88+uCObo=
X-Received: by 2002:a05:6808:66cc:b0:415:969d:26f8 with SMTP id
 5614622812f47-415969d2775mr5248875b6e.17.1752406176681; Sun, 13 Jul 2025
 04:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712233715.821424-1-superm1@kernel.org>
In-Reply-To: <20250712233715.821424-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 13 Jul 2025 13:29:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iEquLgxScuTny0r2+H59OekpkauB4bh+1kkSXu+gtYeQ@mail.gmail.com>
X-Gm-Features: Ac12FXyLrndCakcjz9qF2YkknZuM9Pp8_2nzYOSeJvmT7z9ZPCr-NFKEOExqjkQ
Message-ID: <CAJZ5v0iEquLgxScuTny0r2+H59OekpkauB4bh+1kkSXu+gtYeQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM: hibernate: Add stub for pm_hibernate_is_recovering()
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org, pavel@kernel.org, 
	len.brown@intel.com, guoqing.zhang@amd.com, 
	Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 1:37=E2=80=AFAM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Randy reports that amdgpu fails to compile with the following error:
> ERROR: modpost: "pm_hibernate_is_recovering" [drivers/gpu/drm/amd/amdgpu/=
amdgpu.ko] undefined!
>
> This happens because pm_hibernate_is_recovering() is only compiled when
> CONFIG_PM_SLEEP is set.  Add a stub for it so that drivers don't need
> to depend upon CONFIG_PM.
>
> Cc: Samuel Zhang <guoqing.zhang@amd.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/dri-devel/CAJZ5v0h1CX+aTu7dFy6vB-9LM6t5J4=
rt7Su3qVnq1xx-BFAm=3DQ@mail.gmail.com/T/#m2b9fe212b35fde11d58fcbc4e0727bc02=
ebba7b0
> Fixes: c2aaddbd2dede ("PM: hibernate: add new api pm_hibernate_is_recover=
ing()")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> --
> v2:
>  * put stub in right ifdef
> ---
>  include/linux/suspend.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 293137210fdf4..fcb150ee83b6b 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -426,8 +426,6 @@ int is_hibernate_resume_dev(dev_t dev);
>  static inline int is_hibernate_resume_dev(dev_t dev) { return 0; }
>  #endif
>
> -bool pm_hibernate_is_recovering(void);
> -
>  /* Hibernation and suspend events */
>  #define PM_HIBERNATION_PREPARE 0x0001 /* Going to hibernate */
>  #define PM_POST_HIBERNATION    0x0002 /* Hibernation finished */
> @@ -478,6 +476,7 @@ extern unsigned int lock_system_sleep(void);
>  extern void unlock_system_sleep(unsigned int);
>
>  extern bool pm_sleep_transition_in_progress(void);
> +bool pm_hibernate_is_recovering(void);
>
>  #else /* !CONFIG_PM_SLEEP */
>
> @@ -508,6 +507,7 @@ static inline unsigned int lock_system_sleep(void) { =
return 0; }
>  static inline void unlock_system_sleep(unsigned int flags) {}
>
>  static inline bool pm_sleep_transition_in_progress(void) { return false;=
 }
> +static inline bool pm_hibernate_is_recovering(void) { return false; }
>
>  #endif /* !CONFIG_PM_SLEEP */
>
> --
> 2.43.0
>

