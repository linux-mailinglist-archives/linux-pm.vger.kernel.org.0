Return-Path: <linux-pm+bounces-15388-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 711DE9967B5
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 12:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131312877CD
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 10:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6672F19047F;
	Wed,  9 Oct 2024 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFYWg7wm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DA1817
	for <linux-pm@vger.kernel.org>; Wed,  9 Oct 2024 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471083; cv=none; b=I1tPmgXcz05sFmaEg8kT1368T7pAuTYnibOWr9BHuc1l1huOH7G8rbxQ3PKK+Elk00szHZbG2hX/FoK1QSEbH9kR0HZgrs4ZW/XL7tBbNbTvnhN066wmHtyWF/uNQh2Z+OOu/t+G6be2mDbOExypCaaTvJ3H6K+uu3V4a1F18eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471083; c=relaxed/simple;
	bh=+yvFAbQ7s0rgRQQpPZtq6CE0U2hIXEf6wBenPgPDXqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzDyXr+XPgfMr1BBn4tcaj5Hxu71MRYE/KRvzljkZ2V++z5FQcn3Q2kq0rrJNxKkFkCKqHpf8YvOtaDPkqZiYfPXFpo71O1eQyAfCGXp3tEXHQZP4IfnwHsZqrwWmoOTni93khJiy69VNpGj6fedbyMW8An/g43UZP9H6lcvAA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RFYWg7wm; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e25cc9e94eeso5796036276.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2024 03:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728471080; x=1729075880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXqRckUcaLEwb08tvELxqUUlJj2ycSVSO8hNl/Y5Qqk=;
        b=RFYWg7wmjtYrOUlytTJiJqrCRtpYn7ES7P2+DJeRVjhoggdTpTrirU/WwTyJLi4n1J
         6J4JbfCY8GDCptnAd+VKqffpoCYHkO2HMmK6g4l7haMhNiCzczxecmhe5bCl+atTBwKQ
         EnQZR9vRjsYBWtAY5g9Mldo6FnifQJghNuFTafD9PUPSJK4ND37/RtjGg4BqsF4tLBfU
         HGggfvXY1SbM/4aMF4GBpPpAIhAmWyhQF0ZDETyd4vROc3wYs7yTvR94aPyiBMVGXjaG
         caz9fUCGvWf/sE09709bAss9dFSCIbR74X//Y2Dgr5nz8LJVEpxeD/xww/23ZqEjn62E
         ZTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728471080; x=1729075880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXqRckUcaLEwb08tvELxqUUlJj2ycSVSO8hNl/Y5Qqk=;
        b=MznPJJ/3OInYLBYMkVcSlEAa3uPQQGsD5Zp9dDjO9QCo/dk/nyN5OTzD55CrxH1u3k
         en9zvP40zK8E4mbgchwH68uQhcEuPkvwgJLgOio/CY2Xpa8ApFZI0V66/lE236Tf0XtB
         PWtke8NAOLKJQQL5/YzDG9LnOonGZYqGFziyLVox9/g5ILz5SJfMBixz0aHk3A5Q/bbJ
         99xqkTHUMwm0ympcKbhigneCJD58BmRnPDthOY+usN0V3mnpz92xYn84xQEjPdoKbDbT
         hdA4/qRgyBAB82/I8ven2UGuI/NvTj811zQHWkwyStPA+0NM757QHnfFQFvumd0m+Gu7
         5snw==
X-Forwarded-Encrypted: i=1; AJvYcCXT6wGH7XlPQh1Olh2YSOBY9sxyyJ/yVMlBWzLxjPpAphdCbDVQGyIdA6xd68KFqJKS/Lcc1T8t3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgTscLCIr3FSyvGlGjgYfGoanHpZLBTu9R+ifUIdGFdbmCAJ6y
	/rD8163VJikt+lgdCMJ9iaTj8AHsrW5f/OjU8vvYXwiT3/crv+a+R+uGTtUq5lEokTotfmkhWl2
	dkwwFuibOao07qAGoSuVCJuIG7YbxgTG7H86PAQ==
X-Google-Smtp-Source: AGHT+IFMmaCoYqELojZrx455Xf9B0d6jXNtv4wk+RYx3eU7mtusx7xzvsECrueDK/C+TiR4avlTI+nzU55aqnY0+2rQ=
X-Received: by 2002:a05:6902:e0c:b0:e28:f3e7:d92b with SMTP id
 3f1490d57ef6-e28fe36916dmr1640596276.24.1728471079940; Wed, 09 Oct 2024
 03:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-8250-omap-no-console-suspend-v1-0-e7f0365c02f0@bootlin.com>
 <20241008-8250-omap-no-console-suspend-v1-2-e7f0365c02f0@bootlin.com>
In-Reply-To: <20241008-8250-omap-no-console-suspend-v1-2-e7f0365c02f0@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 12:50:43 +0200
Message-ID: <CAPDyKFpnsV-c4F7SNPQmLBSM1sUknr-3sTyiXMDt9n43UBQkNg@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: 8250_omap: mark the serial as on the wakeup
 path if no_console_suspend
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, u-kumar1@ti.com, tony@atomide.com, 
	khilman@kernel.org, gregory.clement@bootlin.com, thomas.petazzoni@bootlin.com, 
	theo.lebrun@bootlin.com, richard.genoud@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Oct 2024 at 11:34, Thomas Richard <thomas.richard@bootlin.com> wr=
ote:
>
> If the console suspend is disabled, mark the serial as on the wakeup path
> to keep its PM domain powered on.
>
> Suggested-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/825=
0/8250_omap.c
> index 88b58f44e4e9..6764fe2f9cad 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1660,8 +1660,12 @@ static int omap8250_suspend(struct device *dev)
>         if (!device_may_wakeup(dev))
>                 priv->wer =3D 0;
>         serial_out(up, UART_OMAP_WER, priv->wer);
> -       if (uart_console(&up->port) && console_suspend_enabled)
> -               err =3D pm_runtime_force_suspend(dev);
> +       if (uart_console(&up->port)) {
> +               if (console_suspend_enabled)
> +                       err =3D pm_runtime_force_suspend(dev);
> +               else
> +                       device_set_wakeup_path(dev);
> +       }

Isn't this already managed by the serial core? See commit a47cf07f60dc
("serial: core: Call device_set_awake_path() for console port")

[...]

Kind regards
Uffe

