Return-Path: <linux-pm+bounces-21438-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 521A2A29A98
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 21:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE71C1693DC
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 20:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DBD204F66;
	Wed,  5 Feb 2025 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGVVZv6o"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B951F510;
	Wed,  5 Feb 2025 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785854; cv=none; b=nM9IJ0HcpZSiVXgFVbAPHhCSecdwMFLcYCxM8spznqVkdJUheu0yKSMr4L2ubx2S3L+vGPjs2FLiPPO327svM58JDIdFMuLlRaXF7G30khDd+//uN1S+9aOXh3A4XTzqUnK2VBL6MfhGfiiKYuLAveaefqpl8umXvX3e5+DBrhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785854; c=relaxed/simple;
	bh=+FFvkoBOl40xUJ/7W0+yCnQgdgIu/pUtsBVhDoZzfKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuHFydNHTGKnY54PAhRyLzRzRCNwfMXg7+h+F2yWJmAOTro9xGosucgbhLANb+Be57+WOPClBhPg46xwQ89qDlRN7Ywe6gXUNpX7dJfdtbzRzEl1hkSNm86WvEdDDab440hKq4mD9zpwdfYE5++Scnjn/cYF+5KSk7NKkKcSyTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGVVZv6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4D1C4AF0B;
	Wed,  5 Feb 2025 20:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738785853;
	bh=+FFvkoBOl40xUJ/7W0+yCnQgdgIu/pUtsBVhDoZzfKI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IGVVZv6o2vZ+t7qUWmblsl3a4hr4hET5tZMp/mMPXja5dzv8XUY2DzVU7fnVuGWVK
	 8u8YfNiCjvVgwlxpsfaSDSwQcjhPOZw4YMW5L4HgKwUV/wGtuo3R3IBZr877pP9ti1
	 fP6XpZI15Be9d54fIQUMz8xrl/fenJA7eWREIJxfSOEzxQo84eF0cGcDsZB/PYbW0N
	 ezfr9lpLXvBP5jJ/e2n/EEabEiCCThkz0V/QKrjBcOeyIb8z9peSCRd8Jnl1+6Mofr
	 0UDqQ/HhRqx3VB3G3lmD6BoY44gaRZ4mlTP3a6V6W43IRdtHJvp+dS1q+yfOh0p8fM
	 MJL5d8UUIEVGA==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3eba559611aso56012b6e.0;
        Wed, 05 Feb 2025 12:04:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCxYtLjuIDDKZt3IA+VQ7oCdYR3pAvTjzHETpfSkJBFp5XkulofsoMjx2Dz/5Mq4lSBqKUs6QyMrk=@vger.kernel.org, AJvYcCWCznUdch6FSjV+hBaIOZA5QMicH9sjDCQFcOS4etgbltXUOYl0YhUdiieqv2GWYteSV6FHCOTuWIrEV/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq1d8hYGd2J159ILUGZyBdiW4v4lmBNnpSETqBNis5FNZazU1W
	WO2nmi8vbAYWyIuip4zAeAH6QbXmuQlmahSUwyBgshOIxXw8b0EOdLYQKl7bMAv2ujlOHrmyLbw
	F8CrTGL8TgyJvDlRuhUiNFlwetzI=
X-Google-Smtp-Source: AGHT+IHe1Lj7yx+0CYl4Xy6nZWHrRS3pbOj2yBx2ooIdbF9l0/WenggJHevZ/XBhavH2GCvquRPkFjVJniRr8MJsM0Y=
X-Received: by 2002:a05:6808:164e:b0:3ef:27fe:e984 with SMTP id
 5614622812f47-3f37c11cb60mr2644653b6e.12.1738785852890; Wed, 05 Feb 2025
 12:04:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205181347.2079272-1-aboorvad@linux.ibm.com>
In-Reply-To: <20250205181347.2079272-1-aboorvad@linux.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 5 Feb 2025 21:04:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hx1yagWQYaHY-x=VMvw9cdZm=B88MPK=HyVOBVL7ANqg@mail.gmail.com>
X-Gm-Features: AWEUYZmbkdFJU00qM1_alhIpg9LCaxnJEtTI2qdu0dzdlv5QNye5Vi10O2JkELE
Message-ID: <CAJZ5v0hx1yagWQYaHY-x=VMvw9cdZm=B88MPK=HyVOBVL7ANqg@mail.gmail.com>
Subject: Re: [PATCH 1/1] cpufreq: prevent NULL dereference in cpufreq_online
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, zhenglifeng1@huawei.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gautam@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 7:14=E2=80=AFPM Aboorva Devarajan <aboorvad@linux.ib=
m.com> wrote:
>
> Ensure `cpufreq_driver->set_boost` is non-NULL before using it in
> `cpufreq_online` to prevent a potential NULL pointer dereference.
>
> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
> Closes: https://lore.kernel.org/all/c9e56c5f54cc33338762c94e9bed7b5a0d5de=
812.camel@linux.ibm.com/
> Fixes: dd016f379ebc ("cpufreq: Introduce a more generic way to set defaul=
t per-policy boost flag")
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e0048856ecee..30ffbddc7ece 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1571,7 +1571,8 @@ static int cpufreq_online(unsigned int cpu)
>                 policy->cdev =3D of_cpufreq_cooling_register(policy);
>
>         /* Let the per-policy boost flag mirror the cpufreq_driver boost =
during init */
> -       if (policy->boost_enabled !=3D cpufreq_boost_enabled()) {
> +       if (cpufreq_driver->set_boost &&
> +           policy->boost_enabled !=3D cpufreq_boost_enabled()) {
>                 policy->boost_enabled =3D cpufreq_boost_enabled();
>                 ret =3D cpufreq_driver->set_boost(policy, policy->boost_e=
nabled);
>                 if (ret) {
> --

Applied as 6.14-rc material, thanks!

