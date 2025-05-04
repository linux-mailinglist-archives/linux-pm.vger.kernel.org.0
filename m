Return-Path: <linux-pm+bounces-26631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D461CAA8971
	for <lists+linux-pm@lfdr.de>; Sun,  4 May 2025 23:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43F38170E83
	for <lists+linux-pm@lfdr.de>; Sun,  4 May 2025 21:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D4244C77;
	Sun,  4 May 2025 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LtZTOSCs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACF917F7;
	Sun,  4 May 2025 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746394367; cv=none; b=bqD9RmUn8tU44BIVlggde1ZVoCmnQtiuoR8n/Z9wOaIGEHRxRpkXh2nsx9EVhBCrW9WbEQDDGoGyp59g6LKI/EYPOR+zQpzz23S+1PvoljzE5iBLzUZ9JPXFjP7V/9I4i4GOTkxOPl5P2cdllUBYOfAu+6qgB+6yi3hAKG7kqt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746394367; c=relaxed/simple;
	bh=gJ2HmiGarirPqxN24oNBY9CnoSDSrrG6jmTGGopJ774=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZmu2r/HI2I+7vFCmWHvW385juMKLBRaO0DsfWq661x2R2wWgyni3LooBVW42jc/KylBE6BlyfXPdoaYUN8ifjFaXFhFlWqhRh4d7+oz1ZLyWknq/yXoMccViGeJ+59GOw6LsU5P5K3xuONLsBpJy65JShv2pPMe4h8BmtE13rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LtZTOSCs; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22e033a3a07so38000065ad.0;
        Sun, 04 May 2025 14:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1746394365; x=1746999165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7jhF8o/D6lmk3tfJaXQJC7Uck51GK/MCbYz8uYsAmw=;
        b=LtZTOSCsKLMoSrGAUp0p5ZsqHZCAZa4EcjwO7JvMYMjjCVimtBMslUIQMSb2Fv6Nqe
         0qlxZdgWkfQpvjQb3zEAREiloEwTYs+KsvqhFNx/Ib0ALlCJuVzzgjIOsO9fsKkj37qx
         +g0uusegjsT5yYnuGELNAG9BB/0ALbL752LR94xRpLH7a7ntpz6pu0/8cY9GzvFvvHSU
         kP6pZBy02+3xHILeOXICJEvNYgtLVfrR3X9EXR55BWtib1q9B530akALo03uxn9ZTN/j
         Kr06/EvLektDvQpcOftfW0YSDYnGvslIyz/GKeji0S76txqKhaeorNGJd9dHTEngdUb3
         5Kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746394365; x=1746999165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7jhF8o/D6lmk3tfJaXQJC7Uck51GK/MCbYz8uYsAmw=;
        b=o9bLJn/w+t7E4lejJ7A++Z8JnipMWqPtvouJNAHypnv4tJeLwIoIStgHeMGalVAJ4Z
         HafBXwgc3HpEr0fc/OGF+Y3f/D1LGryiZKxuA05Wyr8/XVc0Jxldwh1kTP2d4umYPF8T
         oyBwSILEKn1GiQ+KChxFIMJYJTi42Nf7u02unPKobVbaWfAVfMGJLgCeLRWtsv0DocnZ
         vgwd8a3Nn0NprPrFACw8So6z4NzCfgempJunRaDLljtXyw2U/bW9Z/EAbK7FizC9+63z
         F2HE/xlfy9MopVWfr0ku9hWEj0wOJ63Qk1E1/4pA2fSdAtinUGu+GbjHac+zUef+L+Mf
         kSdw==
X-Forwarded-Encrypted: i=1; AJvYcCVjjT2HBtApQ1WHLOmkkHOLvfYYYVbfg7UokJTttuUNEd8df4l3IP8sB5Fle6JZCTVHkfLPZt0pkYA=@vger.kernel.org, AJvYcCWzIrULWEKk3o+sDgHjF9d1T5Y41wdVIGNxbykKwtMjA5x1sR4NUH09PZm0wAoLQakyj9Ei0GbypndutRBmQjk=@vger.kernel.org, AJvYcCX3YvH0JLEdT7xB51g1u/VRzly4lzvm5L3TwaSf8vC4Rxr/Fd02gkkUjTKQ93IMhzhjBa8RDBXcNfOWqTRe@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ3dNUuDgnQw9Ux6Lsc/BiMnWaosLQI+tkNitM8lBU5NND14tt
	0ZLiqo3fknNxuEEXsENRzScsnK0h/JgPNM7q6oEUpqt2VZD+If1QP6SuELRrYN9CJpUXU8orMWX
	5OVB9HswaCIUzIQrqkEyEOMkmXc4=
X-Gm-Gg: ASbGncszFCdynoSIcSRSISU2q9wZq1PUX4v+stQ9j+CJmLLsB+BUflikH3sVGm3bpeK
	FQpWwgVMKCdmpkccPFh2BwujfqfRHlpVh+pMS/TYm0kQOzS7KTnS/6n7KDSu5STIf047A0Nj6sC
	iFhwESKhMKOVU8EJXdBb67vPYTN6QJaArsJvRmQWZA5b1uZ4YshcAC6F8=
X-Google-Smtp-Source: AGHT+IHH/nfY7aawda+5dqP8fu9k5FCWHizevZPZQCYz7HUea62/Pz9JW8anHy4Qa9uOMj4WeQphD+IA9QE9XTMVDwQ=
X-Received: by 2002:a17:902:d2c7:b0:220:ff3f:6cc0 with SMTP id
 d9443c01a7336-22e18c377c5mr110852105ad.38.1746394365180; Sun, 04 May 2025
 14:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <edc560afe2a8763c93341d161daeb8b33ba606c6.1746199917.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <edc560afe2a8763c93341d161daeb8b33ba606c6.1746199917.git.christophe.jaillet@wanadoo.fr>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 4 May 2025 23:32:34 +0200
X-Gm-Features: ATxdqUHqROfRe8ULU08R_OGbVQNLhxSobV1JquQn41JtqjzAQCz4SzZnaHeJ7Fo
Message-ID: <CAFBinCC04F0PVd_wn2NmaTBn3WTLYDQEoRShU0mhrTiL0MfPCg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: amlogic: Constify some structures
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 5:32=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Most structures in this driver are not modified.
>
> Constifying these structures moves some data to a read-only section, so
> increase overall security, especially when the structure holds some
> function pointers. (This is the case for see meson_ee_pwrc_domain_desc)
>
> On a x86_64, with allmodconfig, as an example:
> Before:
> =3D=3D=3D=3D=3D=3D
>    text    data     bss     dec     hex filename
>    8924    3832       0   12756    31d4 drivers/pmdomain/amlogic/meson-ee=
-pwrc.o
>
> After:
> =3D=3D=3D=3D=3D
>    text    data     bss     dec     hex filename
>   12396     336       0   12732    31bc drivers/pmdomain/amlogic/meson-ee=
-pwrc.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

