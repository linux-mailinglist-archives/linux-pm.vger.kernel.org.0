Return-Path: <linux-pm+bounces-10034-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C99917E49
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 12:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB96BB2701B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 10:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C753616191A;
	Wed, 26 Jun 2024 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jOnGt8gE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E7E22083
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398326; cv=none; b=q+xZX77tJb2qzZnVoEtD0vN/pQUw9SLnM5K7Zd75KNzDT2/f2dElajZYJ/d8TZy1d1S2i5ctoTp4hStExcNdx+9VJ+fE0eBe/UMURI+oi58HDDX8X8WxRpmFo7Kg1sM4kulhsAzDvB3a1Unul5ZyRRj+Mkv9HJY50X90D+OOURQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398326; c=relaxed/simple;
	bh=G9Hu0rSz9odo+/555uwylOWDqs0wLoPhDnYobZDypvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rT6jsXUwreWWWFHy5Aaa4os0L33JiVdlZfCgx6kXjBW4qmjhloFlBXmD1RdyMT19D2HWG0WwP8YGMn/1sce4cUsihiufCCkDWs9Q7dY19LznCFWDXrB2fsk8PreU9KJYnHO9jWF9Zc13EaQX2LTzpXndrIxWo1VGdyR766/ROXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jOnGt8gE; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52cdcd26d61so4706948e87.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 03:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719398323; x=1720003123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9Hu0rSz9odo+/555uwylOWDqs0wLoPhDnYobZDypvk=;
        b=jOnGt8gEsAWGLWSbCcrShDOTKT4LSg6fKcM5R1Hr8fUnN5IJHwb03CHsaw3W5ZPWcN
         JJgCVemxzht3383bTfpWXMMXDgb3yp4YCtd37AYEOljGqPkHaH9djdPxq20laYy75plg
         hGmdKKyPwy2ekvIzIMZwWlKmFWxuXChbYuYqqhwYIdx23wSmMWfj1fdTopPmdYe5DzUr
         RV6qumEFyRT8gZBUwMgWTbcIXkPQlUbWXFQZVyTgFRlaR9kiVXCpLsa9x/pB9CD385SE
         b8een99aJ3j0MM78pQwMds35DKvcVwpmXOVQcq2CSZR2igUrMY+M1TfurFBaS8xaPuAN
         MdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719398323; x=1720003123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9Hu0rSz9odo+/555uwylOWDqs0wLoPhDnYobZDypvk=;
        b=AsaKOU1aO3WdZNzip53NhNYQZ/io4kfqGKzg2EOp4HAtRK7I15NnCScDWm1iS43Pvh
         QOMDxQyU0+IyytVY8/Nt7U8lTkSHlE8iTd48hzz8lSbbRfI4cJVSoB4DJAdwocRW0mgl
         YW9onj4K75tI6kvszJSVVOiuUzwkoWGXAr7XzDbWorzx6JfrgtMv+FddPv/XFfDVI+ns
         edd0Xvlgb1lpAIjSDf8GDA30fXL8V9WhSqVeND17B+odIdzP/whxjWkyGgQS9zsMbAdt
         zUsNYGOVWWt71sQIM2caubpGVmHxr2QMSngL18Q9ZIYgLyfvstmoWZuokl/cu2dEAUMC
         s43w==
X-Forwarded-Encrypted: i=1; AJvYcCVdZHTP4uT7SXgNy44Aj6e/iilscSjoKsjGyzTX5bP2IF6a6X/erVx5vfP6/TQb6mqsP8UkvgOqRQE0ylnuqF9olaV3CTaWRZY=
X-Gm-Message-State: AOJu0YymazDA2v4WYOwqvEKpgMlLxkffyjN+mx6TRAQCN2ecwpe1+SOt
	yfF6aNtWMgzVBlwl0IFP+mMXJ0R+dhe+gr/KOqhZ6+syul2yj9BDkLZD/zIQnPumH/XrzGgVyI6
	yC+uBp0YxLBJth3r0BtCUP5VTXG11iVu83fiH9A==
X-Google-Smtp-Source: AGHT+IGeb9kRMk63OmPcq4hGusevLEvgTC/3rjFDSFhwI2qkWS4cL5PyLdwWxtexrTyhWm4WxjddDCl/NOIRPCwB5GU=
X-Received: by 2002:ac2:5f09:0:b0:52c:8fe4:b153 with SMTP id
 2adb3069b0e04-52ce1839751mr5615327e87.32.1719398323287; Wed, 26 Jun 2024
 03:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719037737.git.christophe.jaillet@wanadoo.fr> <f9f65642331c9e40aaebb888589db043db80b7eb.1719037737.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <f9f65642331c9e40aaebb888589db043db80b7eb.1719037737.git.christophe.jaillet@wanadoo.fr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 12:38:32 +0200
Message-ID: <CACRpkdbWMO__y+_xYkt0-h5gGTE67LVygwr8m0_Tt20HnD1+Bg@mail.gmail.com>
Subject: Re: [PATCH 1/3] power: supply: ab8500: Fix error handling when
 calling iio_read_channel_processed()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: sre@kernel.org, jic23@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 9:05=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> The ab8500_charger_get_[ac|vbus]_[current|voltage]() functions should
> return an error code on error.
>
> Up to now, an un-initialized value is returned.
> This makes the error handling of the callers un-reliable.
>
> Return the error code instead, to fix the issue.
>
> Fixes: 97ab78bac5d0 ("power: supply: ab8500_charger: Convert to IIO ADC")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

