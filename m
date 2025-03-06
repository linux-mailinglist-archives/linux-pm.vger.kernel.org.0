Return-Path: <linux-pm+bounces-23567-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0320A54DE4
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 15:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34850168151
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1511A16D9AA;
	Thu,  6 Mar 2025 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyqoTaE+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E018C1632F3;
	Thu,  6 Mar 2025 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271680; cv=none; b=Pdx7av9V5PBsezlu2o0SKH8YYTo6epggPnJVXy2pfTwG6Vk55g8EFcsqKwHyETU45dR8YeAMSo+0tLHGBecd3vQ34jIp/9zPWukLKETvSoxVLjG1oKQ2po9hKkjaxlfa7R2eLvinE2V/mNVqtCwCp7u6WLbGa8Zh/LSqFTH+w6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271680; c=relaxed/simple;
	bh=0Jc/b+RVcAyArNS0kW+l2wvhg69dAf2fkVEU8cOAqOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYoPJ43DsMzoKqEfymoolMppHwBS8wbjVgWqcpH3ARphiW8TejVSvslLEKOpwPef/O2kIWz6udusHTCsh7QTR9eDSZhCeCOisNMWYkIAu/N+SphBt5fvr1AF5x/8R5pELGafS0amJeEcSLc/Q/Np6drGjrlInx0qOAijQvhsPWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyqoTaE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B17AC4CEEB;
	Thu,  6 Mar 2025 14:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741271679;
	bh=0Jc/b+RVcAyArNS0kW+l2wvhg69dAf2fkVEU8cOAqOk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hyqoTaE+btD9+IcrJD8FzoHqlORfjxKucfc5RINlt52v7Ugt8K/0nOW8no4SIbmmW
	 CLVH4mQZjFg2TcNTJmoIKJX/5ju0QJTluDZuI2Zc7hcp6VZaDEPVw7hZiS7PjkyKkO
	 yA8/k4aqOVPBEqYaoitFqnn51TgukEuG3ahjeKcs/7/DJcLkqUa3sPjcSSC53ByVlT
	 XGG0qgeUHGAvnCf+g6U8ZGbB/LyAnIuzOtSQ2IFPUN14tn78UI0jlasNGkAgo1VexU
	 XENkc2mHY2/iFlxOW3sgYGQdksxABHtmQghCCdUvbRUkEdXH9P7leXGZTUfBoLUUYQ
	 nw3jI9C7tQcig==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f6818bec2dso410712b6e.3;
        Thu, 06 Mar 2025 06:34:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhoPWI3+gIP1HQpjWUbfrgXbqqYtFrf8FMWqPH78GXSn2CpmDlIs8t+WlzLpDu8MOjzfHy9f/aDkSH6KY=@vger.kernel.org, AJvYcCX6Y1HToyHerdyJuNcGoRPOOezYRzTe9GLL8ZB/+pv/EWyxR9D5N1V+ZDLk3BZzubgYdmqKsKrqrZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIaogmzj62AVrA5mvMmWGzfINYE6inds/bGXJd9d1mkSDEJPdx
	frb94psbOYllfQKq6kZsW6tRjM7LUww+wS9M9qlrFIyMnHgCeIO/LrSqhQKnbdLW3OsqdFUytYc
	4xl2nfMg2C/XWa4srabnoaAokwHA=
X-Google-Smtp-Source: AGHT+IFK7agm8Vp8tLIIyi1ZbEYV/pprq1zDLa9CaGXx/0GRq8vrcg476q3BcaaXkcjkQiBv/gJAqs2LqlEYMRdHxF0=
X-Received: by 2002:a05:6808:13c2:b0:3f6:7ecc:6811 with SMTP id
 5614622812f47-3f68316cac7mr3850042b6e.19.1741271678628; Thu, 06 Mar 2025
 06:34:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306113549.796524-1-ulf.hansson@linaro.org> <20250306113549.796524-2-ulf.hansson@linaro.org>
In-Reply-To: <20250306113549.796524-2-ulf.hansson@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 6 Mar 2025 15:34:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hhHv7P8UXEqtRMwC66aSqs115e8gN8rzn_QzZgnVULzA@mail.gmail.com>
X-Gm-Features: AQ5f1JrBt3td-r3vm7NFyydwUVOwMmI3tH-LTfvscYNmbENxVXyiwD3_wcRj1cw
Message-ID: <CAJZ5v0hhHv7P8UXEqtRMwC66aSqs115e8gN8rzn_QzZgnVULzA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: s2idle: Drop redundant locks when entering s2idle
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 12:36=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> The calls to cpus_read_lock|unlock() protects us from getting CPUS
> hotplugged, while entering suspend-to-idle. However, when s2idle_enter() =
is
> called we should be far beyond the point when CPUs may be hotplugged.
> Let's therefore simplify the code and drop the use of the lock.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  kernel/power/suspend.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 09f8397bae15..e7aca4e40561 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -98,8 +98,6 @@ static void s2idle_enter(void)
>         s2idle_state =3D S2IDLE_STATE_ENTER;
>         raw_spin_unlock_irq(&s2idle_lock);
>
> -       cpus_read_lock();
> -

As you said above, this is not expected to be contended, so it mostly
serves as an annotation.

The correctness of the code "protected" by it in fact depends on the
number of CPUs not changing while it runs and this needs to be
documented this way or another.

I guess a comment to that effect can be used here instead of the locking.




>         /* Push all the CPUs into the idle loop. */
>         wake_up_all_idle_cpus();
>         /* Make the current CPU wait so it can enter the idle loop too. *=
/
> @@ -112,8 +110,6 @@ static void s2idle_enter(void)
>          */
>         wake_up_all_idle_cpus();
>
> -       cpus_read_unlock();
> -
>         raw_spin_lock_irq(&s2idle_lock);
>
>   out:
> --
> 2.43.0
>

