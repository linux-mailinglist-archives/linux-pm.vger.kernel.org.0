Return-Path: <linux-pm+bounces-29560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C08AE983C
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 10:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1329B1C21648
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 08:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397B0289812;
	Thu, 26 Jun 2025 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vxnKb/Za"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3850128935A
	for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926339; cv=none; b=QUdEMLSCEfbQOIGIDJIgcFiS1eYcz4LhMNmxqaL14KFmZ1Sj6c7Sbn+h6Wpr5s3Gdt3S7ftXmxObIjuyolmjdSouqn5Dc0ABC3DxDMnSDKePJtEXHZpELQoSHIij7l9mKreE95m6MM5mYK6kscEWOJzupWp+sKlX4MeyOntmJvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926339; c=relaxed/simple;
	bh=tcbJ4dMHWa+h9imojMEcUHTRNC8LuPrUj/4HSqv1epI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SI7UWrjncOgpPNxkkO6cXnwQo0ciWMVGBps65r6x6/KwVaUvdlf+h3Un5AUAqkKuEx7hIbw/JG/ADMg7rKJoUBmT4fGb1iwkQI2NWWYEwhbi0CHK4Pqhua+lSEyZvilojKVxMAO3vDEAgIIwj0jNtUwRajO7K3/JE8VBFhle/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vxnKb/Za; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553b165c80cso693470e87.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 01:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750926335; x=1751531135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KiWcI/ZEWKnAMfwKiluqNNZ9TMq7+QkURM7ieGMhCI=;
        b=vxnKb/ZaUgxtnVa1WM2x2l6fxPib1MEdwgMostPsDxQV9aNZZ37OwVFkCIzCnMjaPm
         iRzUvTNnM9Roh4wIK41jbK+b2h85ZtQr9iymbVuQ60Cq6wXDc++8GULEa35gtzjD7okJ
         q+sbMMCqhSdn5DbXZUkO3AGBPrm1KnOfUHGU3EKTs5EidA2mBjrTEunnJs8uIRQ2hnif
         F4eXuSFJ7sWZQN8eP2d+BK1CojcEJ+odw3l46WO/0uokHNnMDimoVG0eb8bMgwtSJpzH
         4DXT10WM9Tir0+bO4uh36WLT9ACJIYziG6/iWoAumKV5T9mo0fVO1mFzlCgb/eUoyJNs
         HgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750926335; x=1751531135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KiWcI/ZEWKnAMfwKiluqNNZ9TMq7+QkURM7ieGMhCI=;
        b=DvQcTcsnp/Ru7dHGBEO8ICJ74V4i72bujgGe+F9wk4ldMUUb+6WLvy5Bp/pZPhVmmJ
         JOUQdpEFQJTMEFqs1NexSMhC0vs3are/XR2BxS5HfMfoedydexbemBYKfdlubf15bckf
         hJ/LmG/RioORLDrfK3KYxEkSl4IwdP+KjqYBAG9QJfRk1GBcj7gJZrGRqQm0pnEunD5W
         enLg5tuMyZrVSlqxO0Zq9Y6nRKZv64Keye1MTKjMlVlwVcBXvOVL0lAWtaf9aKXP3B6t
         pMUINaqAgxSjTGAEjFCtdxRpZdYZnB0E36Kkvx408DLABXJT1NXfDfZIkLDVnzo9uRYb
         9nVg==
X-Forwarded-Encrypted: i=1; AJvYcCW3JBi1umKYNmrYyX/B4LnelY/VLvcC3NPzQUJWN4G4eOnuoZ9pcX00eGw6ZchXeCbOzVAlo7Lw0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFATNaKTqs7ywiYJUXYIEmYmp1i7QoacKveEEHk9TYsjkw7qtk
	9LRygmWJx+RZq8ONdxoaDZnOMVRQS3uKQs0sTAnbBryxPa7pR39G581Ey9Ps7TOIFdLZR1OYkpv
	E4RZzrTY4F9YXf3UQaRxPknDCJ4kkaoklLCBC8NeG1w==
X-Gm-Gg: ASbGncuMv2MbU6BECjiapjWe/BGQmE1eYdb11AT/ExeLpS0gS8Ba4kDF/qbmnkI+/i9
	IUsLlHorDY51OKVnoj8uGQofhsJdmeGRNPaMQJYv7BGn3AWggF/Mt+lA4G7abjo5ee2E2S438MB
	+mxV8r6of0rYDj4pW193ey1j7PexzeXoovcksHFb8DyexD2g+9rjqJrj+b8cWw+G2UWu9V9dURD
	w==
X-Google-Smtp-Source: AGHT+IHiqTRhc98U7J30Q+L+jrTc1jmBUQy5Vyfvw1Z//zKbgr/TNUKjoi9hEvxXZFQA5uGpKkHKIMlulcDni5LExCA=
X-Received: by 2002:a05:6512:2399:b0:553:35c4:db08 with SMTP id
 2adb3069b0e04-555029e70d5mr987473e87.30.1750926334687; Thu, 26 Jun 2025
 01:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625-icc-clk-memleak-fix-v1-1-4151484cd24f@gmail.com>
In-Reply-To: <20250625-icc-clk-memleak-fix-v1-1-4151484cd24f@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 26 Jun 2025 10:25:23 +0200
X-Gm-Features: Ac12FXycIznnP1tC18vY9u2XdsRu_8gKuTWQBbtsSoPJ6qYsnL72hgxsDeWsTrU
Message-ID: <CAMRc=Md5+pSxx3kxhrYpt_oMUOCUkzxeWEy=YXnhY_4053gqRA@mail.gmail.com>
Subject: Re: [PATCH] interconnect: icc-clk: destroy nodes in case of memory
 allocation failures
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Georgi Djakov <djakov@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Dmitry Baryshkov <lumag@kernel.org>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 7:32=E2=80=AFPM Gabor Juhos <j4g8y7@gmail.com> wrot=
e:
>
> When memory allocation fails during creating the name of the nodes in
> icc_clk_register(), the code continues on the error path and it calls
> icc_nodes_remove() to destroy the already created nodes. However that
> function only destroys the nodes which were already added to the provider
> and the newly created nodes are never destroyed in case of error.
>
> In order to avoid a memory leaks, change the code to destroy the newly
> created nodes explicitly in case of memory allocation failures.
>
> Fixes: 44c5aa73ccd1 ("interconnect: icc-clk: check return values of devm_=
kasprintf()")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>  drivers/interconnect/icc-clk.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-cl=
k.c
> index 88f311c110207757f0609e5cec7d377a91133c6d..93c030608d3e0aad7d9c1ed81=
a51dcde0d3f85ab 100644
> --- a/drivers/interconnect/icc-clk.c
> +++ b/drivers/interconnect/icc-clk.c
> @@ -117,6 +117,7 @@ struct icc_provider *icc_clk_register(struct device *=
dev,
>
>                 node->name =3D devm_kasprintf(dev, GFP_KERNEL, "%s_master=
", data[i].name);
>                 if (!node->name) {
> +                       icc_node_destroy(node->id);
>                         ret =3D -ENOMEM;
>                         goto err;
>                 }
> @@ -135,6 +136,7 @@ struct icc_provider *icc_clk_register(struct device *=
dev,
>
>                 node->name =3D devm_kasprintf(dev, GFP_KERNEL, "%s_slave"=
, data[i].name);
>                 if (!node->name) {
> +                       icc_node_destroy(node->id);
>                         ret =3D -ENOMEM;
>                         goto err;
>                 }
>
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250625-icc-clk-memleak-fix-4462b5153970
>
> Best regards,
> --
> Gabor Juhos <j4g8y7@gmail.com>
>
>

Thanks for catching this.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

