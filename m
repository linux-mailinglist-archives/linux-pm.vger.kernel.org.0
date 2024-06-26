Return-Path: <linux-pm+bounces-10032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A51B917E43
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 12:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED51D1F23205
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 10:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4133AF4FB;
	Wed, 26 Jun 2024 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gCVi/Odj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F7A16C696
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398289; cv=none; b=k/w6IMY/SBamHMGjtEU5XZO0zDImVK+GrJ6ySMEfLc0+AdxI9myeha16p71d4RsgtSxoqFFA0eudL+OAkT1X6oDMgGW7qYcOSLmR6iMpFO8QPh3YSf6BSzxWWzhkqibJvRQbIJc5Gh17cvVPKs4KlewPLpc3eNAgeMAFihktQns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398289; c=relaxed/simple;
	bh=VYUz5N4gtv8iv/6U7Fma+w++MYKM4dTro8aD5iMAqJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwgi09MAOkS/Hr+0Y8fTVrQdnVLvs1YUYfNxkl+p8hcnVwm56FgFA8ss2srNilT4clA3vLOGbtqopBV7OvkGYlEMVPQIq9QzCyuWmJc1YElP+azIhnIXD4Ib+NIuKrRZwODms5X6lM3su67Ugyhr7BoFBmaJK/UwS8/r+QFC9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gCVi/Odj; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52cdbc20faeso5831382e87.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 03:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719398285; x=1720003085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAP7Avo0NqErHhw/LgeqaI6OS2BfZZmGrKu2N8kUgqY=;
        b=gCVi/OdjXk1Y+PwpYIimpHcOd6rlm3EMdwPd+qg7wNDxO30YSdDKf+Wy1sJGxbJ/uo
         1m7IWGK1Q6YNDxOOexYKXdCB51zrmPR4r/wYD0/kNtIdvw1Z8O2i1d9igV/bOwf8PPih
         pZtEX55l1npz7Tm25GTml+EascAMpqfmopNa9l+ALEFPoBy/YVRJqerPoRSZaoS6ODS2
         uYIlDuIki+ZaWyfnfeOMNHWZV1sDzcbN4zxAaYTDEIqvcall1MIVi4ytLDITCOdWixG/
         dWSTeD/RM+3XzC+qJnhuh6HzsQaWw7uqDIFAcIWFaT0P58/Qtkp7mA3xT9RkK/mqcne1
         b7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719398285; x=1720003085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAP7Avo0NqErHhw/LgeqaI6OS2BfZZmGrKu2N8kUgqY=;
        b=X0gwCSEfCnhlAGQpL20WKLhK1fPYHxRQFBG8ltZoDXst0cOvPnMGUvFMGrXish5DcS
         0HwGJ7vcRR7d7zbNUPFGcTMBvCaCm6T9LLVA4JYAmbqxRvN7EjvhP6CLcr1nLg1OHMTm
         OXYsNo64Rg9LC0/ZYvybvqS4a3rIe6gzOgCi7oEcuG4RoEGAJ+bG2US7tIeZUERvR4Zs
         IVVG+a7eLxWgngtNadf35h+as8LUvXQU8D55QXMJfszIIO+Yw7YaH+DyynR83z6dBqwE
         Een2x6TqC65ERHwcbEClnu52M6PLkSx/wRyDy5iO54PxOEHgW91VBjCFw79kClOSG9FM
         9bVA==
X-Forwarded-Encrypted: i=1; AJvYcCVmUeXaiOhsh0ZQwWlnze6nW0jdmH/63vc2m+kczfxQ7iB9C48fxeWwXSWXKrkFKhuWDyM5NE/L2vkfE3an+deyRp/Vr8xKUp8=
X-Gm-Message-State: AOJu0Yx+ADUCeUJ/YRxc5t0LJo9Ptys3w21IVjSl0s2ookxaO/wZEXWk
	jMVWgdFsnB9S+rCK488OXnXKOy1C14DYuPl1xlM/na4W9z1QzjPjjorZoij2fRlOaJZlA1/JlOr
	yKiqycWvfjt6PZn9bfvEYu5YxZQvabFDgUGq0U7QVAs9zZnUA
X-Google-Smtp-Source: AGHT+IGzCEHmUW20SzJfj/AOkF92f/FKlba7gvSlxZWz6Yna1JEIXVmc39gid0pFCtGiZI+oDk6MEqv5XprFAgIE2Tg=
X-Received: by 2002:a05:6512:3091:b0:52c:e54e:f84b with SMTP id
 2adb3069b0e04-52ce54ef9fdmr6615691e87.14.1719398285525; Wed, 26 Jun 2024
 03:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d01818abd880bf435d1106a9a6cc11a7a8a3e661.1719125040.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <d01818abd880bf435d1106a9a6cc11a7a8a3e661.1719125040.git.christophe.jaillet@wanadoo.fr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 12:37:53 +0200
Message-ID: <CACRpkdZ-DOLV1ZHALCDKaUjj4HjwX_qLJ9GttKMvrRJ867q64Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] power: supply: samsung-sdi-battery: Constify
 struct power_supply_vbat_ri_table
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 8:45=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> 'struct power_supply_vbat_ri_table' are not modified in this driver.
>
> Constifying these structures moves some data to a read-only section, so
> increase overall security.
>
> In order to do it, some code also needs to be adjusted to this new const
> qualifier.
>
> On a x86_64, with allmodconfig:
> Before:
> =3D=3D=3D=3D=3D=3D
> $ size drivers/power/supply/samsung-sdi-battery.o
>    text    data     bss     dec     hex filename
>     955    7664       0    8619    21ab drivers/power/supply/samsung-sdi-=
battery.o
>
> After:
> =3D=3D=3D=3D=3D
> $ size drivers/power/supply/samsung-sdi-battery.o
>    text    data     bss     dec     hex filename
>    4055    4584       0    8639    21bf drivers/power/supply/samsung-sdi-=
battery.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Really neat!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

