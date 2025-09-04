Return-Path: <linux-pm+bounces-33882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29272B44622
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 21:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF393A424B2
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 19:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EE125A2A5;
	Thu,  4 Sep 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOhjNsab"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1662417D4;
	Thu,  4 Sep 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012816; cv=none; b=fYMWtzlD+GPr+5muurmiDDq5zpL4ymOFP/XQBTrwlIX8mEewuZ1sj2+4uQONuAzzPcHawApN9OL8BIYz9Ll0LtEJ86/8DAQ7qUrP0lt2qF9cYUj3LWWozmZppbM6weSNQPgMqcAnrvjlSEMYbjb34eB0Fw8D0iYHR7GKRAhmQpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012816; c=relaxed/simple;
	bh=uzFFK+oAV4o+/Z6Ea8q6YgA+56IAqj4eUydEcdT1QYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpLNMLiAvI38egnmJDXw3knrvoNyaLwKlEQJk85WwZuvxD971iLlnHGY/IhtI4qafTpoR0kS/pCRnICmytShGa0z6ty21iHU0F2j6yHJ/fqglevYnRW3HCsPGwnjspOqPGtX+GAxKGqGL2ezFsLhyNhqRiem1aR5oaokUiSkUuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOhjNsab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28929C4CEF0;
	Thu,  4 Sep 2025 19:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757012816;
	bh=uzFFK+oAV4o+/Z6Ea8q6YgA+56IAqj4eUydEcdT1QYg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nOhjNsabw6l3g77wM4M2YpnfZkNiKs1OrjYsbsMm4p+DgEXVfgFdnWT3BIY93zfMY
	 +vlcvPuiyin740afy1+F+0u+WdISkyzN80VAVYJp0Ax3PuI3UBPpaHuPsXywelB+cw
	 IetMqTx92cEJsl5hWQyV+5+unoK+AN72X3fYorUkqCc1oXaICw4L5UqYh3sRIwbPrf
	 MK5g8qwGb92TfkJCxGrKMOMKOQiS/DQxUINgLy5qjGcS4dvH6JHGcotPI6VgjyRZ2v
	 L00brth37zgd6ed+esE2gwMZzwQo8kdB0LbH85UGEmGM8yhL09qv4cj+Xa51vYy9yW
	 8pnjErRKwf/dw==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-61bf9ef4cc0so835807eaf.0;
        Thu, 04 Sep 2025 12:06:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUC0ObMKFyWih5nSIgcXGRm0yidBuwQSvz7sXTrWQhtN1Fn4etDhCSFuWcFmNB9JZuRMPlyKbdRc5ep9YM=@vger.kernel.org, AJvYcCXg9XRHcR+pOjRtgqtpR8KKNClrZ1IgJm2YR+JkTXgR6xdl/bdOBqXKHFLNiNyuU43MvXknrHnuDkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvD3OlJbCu7CIRB7kuHhW+y4ApgdMAei+pBgBgH/4VgeyCgudH
	9Y9pLzkKyIAywVm7fLbJ+H+plGqymQPCWff/6FxzWmH7lGb6H7tgQqn78tEDt4jFV76hYQhD0di
	bn/mUDhO8kohC4tGQkDgUHDNj38Q3XLM=
X-Google-Smtp-Source: AGHT+IHlcABl4lYSNC2Neohra2TuA90Q/9eeXf30jxyYpHVlPesEYQId/gXLk7grB5kT9hQ1FNxF6hY5j9op/ZftYKM=
X-Received: by 2002:a05:6808:a545:20b0:438:1c76:d3e with SMTP id
 5614622812f47-4381c7610fdmr4396935b6e.31.1757012815437; Thu, 04 Sep 2025
 12:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821004237.2712312-1-wusamuel@google.com> <20250821004237.2712312-2-wusamuel@google.com>
In-Reply-To: <20250821004237.2712312-2-wusamuel@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 21:06:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gmDnEr_WtVarWRTFWNTzK+fg9jTTD9FXJ5dTwGH0jPRQ@mail.gmail.com>
X-Gm-Features: Ac12FXwQDLunXv5qPLGgcOUC5UpRC803tqZZybQGLk-Xa7bMRIvRD-GbPkbu1-A
Message-ID: <CAJZ5v0gmDnEr_WtVarWRTFWNTzK+fg9jTTD9FXJ5dTwGH0jPRQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PM: Make pm_wakeup_clear() call more clear
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:42=E2=80=AFAM Samuel Wu <wusamuel@google.com> wro=
te:
>
> Move pm_wakeup_clear() to the same location as other functions that do
> bookkeeping prior to suspend_prepare(). Since calling pm_wakeup_clear()
> is a prerequisite to setting up for suspend and enabling functionalities
> of suspend (like aborting during suspend), moving pm_wakeup_clear()
> higher up the call stack makes its intent more clear and obvious that it
> is called prior to suspend_prepare().
>
> With this patch, there is a slightly larger window when abort events
> can be registered, but otherwise suspend functionality is the same.
>
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>  kernel/power/process.c | 1 -
>  kernel/power/suspend.c | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index dc0dfc349f22..8ff68ebaa1e0 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -132,7 +132,6 @@ int freeze_processes(void)
>         if (!pm_freezing)
>                 static_branch_inc(&freezer_active);
>
> -       pm_wakeup_clear(0);
>         pm_freezing =3D true;
>         error =3D try_to_freeze_tasks(true);
>         if (!error)
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index b4ca17c2fecf..4bb4686c1c08 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -595,6 +595,7 @@ static int enter_state(suspend_state_t state)
>         }
>
>         pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[s=
tate]);
> +       pm_wakeup_clear(0);
>         pm_suspend_clear_flags();
>         error =3D suspend_prepare(state);
>         if (error)
> --

Applied as 6.18 material with Saravana's R-by and minor edits in the
subject and changelog.

Thanks!

