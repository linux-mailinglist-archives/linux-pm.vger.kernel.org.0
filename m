Return-Path: <linux-pm+bounces-11526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CBF93EF8F
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 10:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C7B2838A1
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 08:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00CE13AA42;
	Mon, 29 Jul 2024 08:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TyGFGQ/Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC846137775
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240762; cv=none; b=bAGLhuqVUoJCfRwGUrd9Kgg9N3Z0VToFgTnZTX9X833hqtYIKldh5lym6R7dgxJvaE4EZ3iwZxv7Zn+rMWoLFLI4XO7QSM8OrjW/IQuMekccP9r+3JEMCiXVKapKvrcp20jJumSIqcxScAsX6yeqEpKeBZP8NiURCt0da1BECao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240762; c=relaxed/simple;
	bh=vmbCOUmKZ1dFjF8DwS4l7Dx84hYJKYmzgXMywQQNOdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzxRzhg07igOH1tU9eCrhrIpNMTrAWYiR2axaochmBteZDDZ/LvmxSXE2cRjGu4T8Wb6mX611FkdykTiwqa08AeV1Sv0WPISstCKROFtavUtYJE5typwjCtdnzftUu6Y8zMwUeZ5Lwo04J/c8IozGcOLxzyCLbbcoc9fIgItNP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=TyGFGQ/Z; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52f01613acbso3692303e87.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 01:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722240759; x=1722845559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgbLi1WuzrWYkt+kvg6tYyooxYHTBlvpYn0Wnr6oVFM=;
        b=TyGFGQ/ZcGpOSXwZb+5zdr1hjNZtCMyGR6bVXN8St4b2J7PJ/NbwTkjbIAHE9wLyCH
         DQ9/irDa+4IKrTV0SGoa7fUa6i9XMoivJ27aJNTgtFgw4fqHLp8NlxMt7WcMOt96EiGL
         TUtou8NZ3GHs+VBg8AdUy5DwT8CSFbDq0tvFZaxMc9LKi0571xEEOC3XZPZ6zvmNH3rH
         wAqREpBivm4GLboWAsacuygmvM06McLLRQEVx7XPhwYW9WVAFAEkqu2FFJ+5pGU+I/8E
         UZS4KvY6io79902C5YSO7J7hfq2Ij5fZgjyIH9YPEAG6vSSend0ab9ppIO5ihLDaiqB/
         8rfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722240759; x=1722845559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgbLi1WuzrWYkt+kvg6tYyooxYHTBlvpYn0Wnr6oVFM=;
        b=IxwYtv0CivHGJheE/wEzfXq45Bh/Cjh9L3Si2G0zNneCt7d0oUkEbkhxI+TpGVkobb
         My5bjFxUrwZPvNmJhGu3pqBFTNvciK33AxDrKEQ8o+adI3jj3o2SzEcWSVwl+MeY3x66
         VHaYxWe9vGS/vLwamtPMDxyAKczhA6DGxPCxJVOJSEYxynD/JWS7e+LImJ2BA1zQisT8
         NvvRBJXuHYU9HOZw9NNs5IMxWHpW02xQ1Xul+un0Hshz6R11/uGKxDFK/WyQbmtpUSoP
         medqAQP33Lyb7jU2wSIOr/LW6oqM/FH4RGupLU1pefHq6nTGCzwGEtRNjdYu8AEDAot1
         MfYg==
X-Forwarded-Encrypted: i=1; AJvYcCUd0s3FeNbEv2ODWwfRLw0/3HSvNy2IAuunk+fQHdL8t4hKB8nYCZ8CIFFXjvfV/GbeotdUvXUY7K+wLdYBgAhPQBwNCEZW3+o=
X-Gm-Message-State: AOJu0Yza/Cpf2Wmrojbhb98mjLryh6OzhaihwNTFJ5myk7/5D2+7VJQL
	6H6FhRU29mH0bGDFxnhTNRRJmadYT9fSgvccJFju5XTyJzajJVV+ZAg7VEdAz3paRvUlvsSFvMx
	8ehKbya6NYjepfJeazXzOGz2jQkZj+3JAOxG6Tg==
X-Google-Smtp-Source: AGHT+IEpYgo+6X9lNxr1Sp8ZEgqfjm0yra5DVMaSzynDm065fn1Hei1MMr6+kuuUK8+GhzuRQj4R6RUR/dmGI8kwNY4=
X-Received: by 2002:ac2:46e9:0:b0:52c:d7d9:9ba4 with SMTP id
 2adb3069b0e04-5309b720abfmr1414105e87.31.1722240758621; Mon, 29 Jul 2024
 01:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-pwrseq-wcn-config-v1-1-021dce9f2513@redhat.com>
In-Reply-To: <20240725-pwrseq-wcn-config-v1-1-021dce9f2513@redhat.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 29 Jul 2024 10:12:27 +0200
Message-ID: <CAMRc=Mcop3+00G3kZo+dazpemuj0PjXNc_3+EiyFukLevBGd_A@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: pwrseq-qcom-wcn: Depend on WCN36XX
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 6:28=E2=80=AFPM Andrew Halaney <ahalaney@redhat.com=
> wrote:
>
> This driver does sequencing for the hardware driven by WCN36XX, let's
> make it depend on that. Without WCN36XX, we're sequencing power for
> nothing.
>
> Fixes: 2f1630f437df ("power: pwrseq: add a driver for the PMU module on t=
he QCom WCN chipsets")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> I *think* this makes sense, but if you disagree please let me know. I
> was sorting out configs in fedora and noticed this was being asked for
> builds that didn't have WCN36XX enabled, which seems odd to me at least.
> ---
>  drivers/power/sequencing/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/=
Kconfig
> index c9f1cdb665248..a4765cb33a80e 100644
> --- a/drivers/power/sequencing/Kconfig
> +++ b/drivers/power/sequencing/Kconfig
> @@ -16,6 +16,7 @@ if POWER_SEQUENCING
>  config POWER_SEQUENCING_QCOM_WCN
>         tristate "Qualcomm WCN family PMU driver"
>         default m if ARCH_QCOM
> +       depends on WCN36XX
>         help
>           Say Y here to enable the power sequencing driver for Qualcomm
>           WCN Bluetooth/WLAN chipsets.
>
> ---
> base-commit: 2347b4c79f5e6cd3f4996e80c2d3c15f53006bf5
> change-id: 20240725-pwrseq-wcn-config-0b6668b5c620
>
> Best regards,
> --
> Andrew Halaney <ahalaney@redhat.com>
>

What if we want to disable the WLAN driver but keep the Bluetooth
driver enabled?

Bart

