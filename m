Return-Path: <linux-pm+bounces-4268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C517D85FBF4
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 16:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35DA1C2302D
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 15:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9785614AD14;
	Thu, 22 Feb 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UwkIsLyk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588D314A08F
	for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614688; cv=none; b=FyY1L2FJ1he7PqqwsflF1monizT1zwtbOiWUgoSvONDpBzyn9IFiJSEA+RKErtYaVxKPJUTzVl439qNoDhfgPdWCOmP2N050faft+eK2ImhJhmrVFtOY5aeBdo3GBcPjnLig/2CGFw9CV0WzeJmNxEOHE6OHeriw+u20UnL8cJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614688; c=relaxed/simple;
	bh=E0AvIIn162mSDyZwPDTo2b1xyRz7jAaOfrYbNUsD19s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhY8dLnfwAJvQLtedxUgAnuv5vShZXeYTBVJS0ZG8A7bO95tTP7JKIjDp4xGqFRSvyoWmZWMZmkzcH7GCE6Igt8lwt8KAMYhjMuH/a08KmaoERIDtrCBm4c1gGxFEC9bobC6ZeHiSvh7+se28kZ9i8d/KrQhSIvfOpHaOwxd+fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UwkIsLyk; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d2505352e6so35529731fa.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 07:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708614684; x=1709219484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1MyTAa9W6rwmrz4X17WTkjYYC8wuvxkD+qfkCmD8gA=;
        b=UwkIsLykfJRFNvIHoHGBPHMNOiHcdcQuVYCHaWoS5aYxT5Ka5iGYvLPTlpAaP+ej2l
         LkSANWN1ECg+wxpZc13XRS2NPCmfmdUMvRLiA3BV6HEdlghd1rdFyBB9kG3FgENyu2l/
         s2QvMk5J6v6XoSo9GqdOHWlQdTP/C8L3G6CQ2CKe2UVU1Lp8B5PacI1vk4kwZjZcgpnm
         ofl2c4aUnIHqRT6ifeTSNvRL1QmW+os+Fku/Nz33UOl8QJBgkr+rn2oI8K/hKqFQpmoq
         gKuDgoTMhWmU1ZnRh2GxW1UVcfpmHgexdkEe5WeeSEejr9sClJ5ibqIctcgrIy+95J+u
         C4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708614684; x=1709219484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1MyTAa9W6rwmrz4X17WTkjYYC8wuvxkD+qfkCmD8gA=;
        b=RYGkU/gYZFqJovbCHQjyEo2Z/xUvD+V7MynzUODmStxS7Nqk0YGhsB4Iz01WmfXtys
         j1tDxxwxNA9i+bCj8r2gKlob2WlqJf1PLnTl4XTfglGKigtetJ5lPXZQEgeAw85Akfvw
         IeiXSO6XkohBwZ3xzJ7EVNSMMK7LDdsJcfXB966o6w8x0sJaQ8OSkaup8LmKRU9weJzJ
         lqX0UaMckzfZc9ljwH4lAq6uLQC0mITNOkwi7jpQzceTdbdk37rSUcPQuWiBtrElIMMl
         q6uFlDRMyIlj0H7etV1OmWbXVze7LKAZ7bjSYp9F4aPzCwOboyxV+iDlI45D7FxgYerf
         gyEg==
X-Forwarded-Encrypted: i=1; AJvYcCWGniSkkysR017rKK0vXhppNGES+xuWpbF6siykYqanQY7eVEQN5s3JkDjIRjnElns1a8fqFXqXzosb2yiM1zw6pBJ1l4kxMng=
X-Gm-Message-State: AOJu0Yx9Cs1lVfQVexoL2V32sk492zy6d0rLQYRhp2LNs1EIMT7nutiQ
	I+LfNMuV3lAIKNaV6bu04Xmu3q+1kBtKDYvNDVc1wEmH1oWy8qKl8Wx78nvQwyk7vCmV/CGCJh7
	Rhn07o2SSvDzc5HFS4Fb6KHkQmHNSC8ONbbdWeg==
X-Google-Smtp-Source: AGHT+IGw3hbqPWYN/3vfhhQBFzrTvi1PbeoR9WvH0886TzS1KyGrr602I8E8lLCB6pIuc8bHxZF8tDM1xPYr0gG8zd8=
X-Received: by 2002:a2e:b166:0:b0:2d2:6002:c239 with SMTP id
 a6-20020a2eb166000000b002d26002c239mr1510902ljm.3.1708614684451; Thu, 22 Feb
 2024 07:11:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222145838.12916-1-kabel@kernel.org>
In-Reply-To: <20240222145838.12916-1-kabel@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Feb 2024 16:11:11 +0100
Message-ID: <CAMRc=McWhC0ZdR55TMkkdVov=dwT0=H-4_c4J-bq0quRpvyoBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] devm-helpers: Add resource managed version of mutex init
To: =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Aleksandr Mezin <mezin.alexander@gmail.com>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-gpio@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 3:58=E2=80=AFPM Marek Beh=C3=BAn <kabel@kernel.org>=
 wrote:
>
> A few drivers are doing resource-managed mutex initialization by
> implementing ad-hoc one-liner mutex dropping functions and using them
> with devm_add_action_or_reset(). Help drivers avoid these repeated
> one-liners by adding managed version of mutex initialization.
>
> Use the new function devm_mutex_init() in the following drivers:
>   drivers/gpio/gpio-pisosr.c
>   drivers/gpio/gpio-sim.c

Yes, please!

For GPIO part:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

