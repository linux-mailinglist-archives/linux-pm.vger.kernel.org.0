Return-Path: <linux-pm+bounces-10035-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CE6917E53
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 12:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD3028908E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 10:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EC5171E7F;
	Wed, 26 Jun 2024 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="On7RFdeG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D2316191A
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398382; cv=none; b=b7Qb/Z+YkfWCCDa7d5qjo/WkRv5KIjBi7oz4q86ZHevWy1PJ/v45I/lrIhNqVzSui2n/ZoKSciJJBQgS8f0UeME96YglP1bzMOgmdFkGx4jfICTmZIK4ywGjInVvIp2DVw7NNFSYS8B7XPFXKkOhRIvEGsfefdQj/Ju40bKHjvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398382; c=relaxed/simple;
	bh=dhzrmXSqkGs39FUvRpHqoDKx6vIwMQj8MYGTdhz07CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMyOcKPHu1Pldj/zbZZg8v4SlABiVPBvsRxyZmh3f5tdsYrVpvJNAtaC6+GooDR8nxh4tap1M5wKZkT+Cbqn8+YaQI1jfQkpXvCdoEtX0uVmvh6a5SzPfa8OPyVJXSjB14lIyOULMaBm1DAHmraNkoJi6eC+Jtftj8bhnPWINFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=On7RFdeG; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ce6c93103so3891104e87.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 03:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719398379; x=1720003179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhzrmXSqkGs39FUvRpHqoDKx6vIwMQj8MYGTdhz07CA=;
        b=On7RFdeG1xPYwaPUbXA3LF4Lvo1BTHHGBkowyixrxTt5fNrtGWmx9mN7RwR5OJjCnh
         djJ2XCUKpGRfF0IkbLlekQe8zVSe1+gOLEmaDygCiOV+R2Jh+wXdvlYTnm6rScIrUoDR
         0F5uXpkukLnO8VR6w90w79K03Kw97O2WWsbA4S5TzVy/38L10DFZGuFDomc7bx+DBxsJ
         Xxru/nGDxoXjtRtbY7y/HI0nMWU2hSvxdbin/nA7Qh+V8mMR3Dma70toNnTLyjAtGTEe
         CCE/wU4F0802JoXHI19UU1ALKeZNLdwdUH6OYAhdbI4lbPUG8GY1sZPegNJdYsl8S2lk
         2f3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719398379; x=1720003179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhzrmXSqkGs39FUvRpHqoDKx6vIwMQj8MYGTdhz07CA=;
        b=nyOntFuGjfVcyqaDfGmPgtZaSmVUB2aMGjgnU2uBunXhBGvA4pbhhXuG2UbsnZl/sD
         2bZw0he18da3ZRfw9ES/jyMPNfjgjp50S1TWFqZWEr/iyPhaf2Z5uPZyinoviJWlk7Jf
         w2OLjUybIzicHlEnV59/mBwzpNvbE/5QzM/LxrxhzE8H481zyV9fx6j92WPJtgLyTfoi
         7u+sLHuiTGjP//f1oF4DUDFxhS18FE2gwyUAAlHBmptCwwgnqv4WE0u5UKbXMweAj97I
         EC6GQzAxhqQCpfuoDXzpOKuLpxPBHpOPLDy1Hs0g2QVA8vcfK9QT9MadlUdwH78Ar7DK
         NYBw==
X-Forwarded-Encrypted: i=1; AJvYcCXmAPce03CwWyvUh1IkMm7xlKvcyO0+aZUseIjMpSOcEGQwH3uQvgso7OzJgUz+8BCv++e8KmAvmn/7cKuP0JKgayrF/ovE52k=
X-Gm-Message-State: AOJu0Yx9lCVvELASLa2stkls2gdKTHo+Rkrn0pw5rw0WaPpEU1kIRM3D
	7WmCuUJ/qQhmLQpd/vq/NL5v/MGUseallDpOEqzP9tfTvTkjOMk252TR/En8H+fA/h1/NIOGzRl
	mMc1TgaHGshA+25RK+VxKI+fuA2j8D2YERJI9P5DMmfnNk1b3I/g=
X-Google-Smtp-Source: AGHT+IGYshSBJsGbHR85N3D0SqXv/Z+CwmWb6YgKDMMrKH9xuw/NNa4H4iXEgCzLOZ4A8G7yHxUcn65HQg/ShR4nufU=
X-Received: by 2002:a05:6512:ea4:b0:52b:c33a:aa7c with SMTP id
 2adb3069b0e04-52ce185ced0mr9513273e87.65.1719398379358; Wed, 26 Jun 2024
 03:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719037737.git.christophe.jaillet@wanadoo.fr> <5668d73b92eb6318c7f094a9a8fa914c909485ca.1719037737.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <5668d73b92eb6318c7f094a9a8fa914c909485ca.1719037737.git.christophe.jaillet@wanadoo.fr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 12:39:28 +0200
Message-ID: <CACRpkdaXQ+qgXsZ=nUzz+MNzTWsK32YEpJH3FT5WzDXVS=hd7A@mail.gmail.com>
Subject: Re: [PATCH 2/3] power: supply: ab8500: Use iio_read_channel_processed_scale()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: sre@kernel.org, jic23@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 9:05=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> Instead of rescaling current or voltage channels after the fact, use the
> dedicated scaling API. This should reduce any inaccuracies resulting from
> the scaling.
>
> This is also slightly more efficient as it saves a function call and a
> multiplication.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Very nice!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

