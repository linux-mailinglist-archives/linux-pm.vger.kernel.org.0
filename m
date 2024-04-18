Return-Path: <linux-pm+bounces-6676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7E48A9DB0
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 16:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34362812AA
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129FB168B06;
	Thu, 18 Apr 2024 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pf47Y+eM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6617B15E5C2
	for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2024 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452195; cv=none; b=usbvuuuhxlyCXDY+hMn44bsM+xsEjfzK1PdOFhyinTJ0TPB0YZeM6/l56qn2pODtgtQC73h0xqs+uGCFD9hkiYp0MqA+dWC2w3ARU6XrNnzmB2XnD1JRGK0qQ8FpN4FHsjS4vjntRcdXVWtytGCCdQq/TgGki6bKGQyMab7C7fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452195; c=relaxed/simple;
	bh=LCgK1Nl7X6eiOEgLnSDHPjrE4OmWhWaXYy1AgFyQE4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6IZsr8wKRgZjvlKURefUtwU1eTshp4nOCVUSU0G3PW9q8ArsANiv/5JRYiD4Lhi2iQAE8bm5nkGBXN+cb9dnHZGuc8k5b1Xp28LyHYdyHZ9HcqpwMfbEettSrIBxwdBTahjf7yuUSdQZnheFymyTESfCvwxkSvNFc3ygr1I7cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pf47Y+eM; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dd10ebcd702so1014732276.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2024 07:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713452192; x=1714056992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4lP11AC4mEgAygBmUrYdUs5fesWy/SPsDBJGp96UBo=;
        b=Pf47Y+eMT+p3ZzFS/PCe8WBSpgREFwme6x77bmIOwtmxRZalN0Wr2VPqDVYrQ/sK5A
         MZqSo1DF+vVUK1Tm1RJ9cLFAvAA8J8C/FLG63CtA8aHA1Q6SDI+q1hYJppLvtqWz0mkl
         grG8ywpcR1J/0o294kRuffKkS20NTJULm7bDSW0sX/SQAirRllihO9AMCfRi43zW04/T
         fivg2GkbKsV6Bm51SLJcQmQLOy6XkLgbQ2vXTTqi7LBJ56qPuwVm56AuYPMcv5CFswtl
         5O9+vUP83JKMldlcYxKpLx29A4EFFpGfg5fyb1YaezrGya1T8t8s4mMWHl3TdatprsTl
         7n+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452192; x=1714056992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4lP11AC4mEgAygBmUrYdUs5fesWy/SPsDBJGp96UBo=;
        b=Jd54nmz/e5fSsfFxZ4HntrgzVsdVI4u0Eaxm5dLXB3fcwW/UXOJDe2+YkBeP6eSFab
         jLIHJnOSjyvZruDVzxsU+jImsShSGlr2DPc48vCeUZg1l46IQ4Rrb9vQ4up597MGG49J
         vFWhFoZQImvdmnqPB4c3dMbYQKh493+5OCgf0PLQ3G0Kqq8/S+m2jyBC9xTrtPGY0xO0
         8Hqyl8iaYcHAA2pw11Glj0X2/7dORkBV1P0GohxVJ/eb4i0XXYsrTvbRQW1PYhYHYc7Y
         IqRhxO/dF30U+y6R9nmyU5vPJo+RN6Z04gUZpukJcQeB3873VET4M89AQjmO7rKnpeKX
         8qLw==
X-Forwarded-Encrypted: i=1; AJvYcCUL9MTHBZC6FLd45tSvafnNAtVWthD+HBP1uufwBz3Iwc2kb6Hvb7cKgQMr1koVKo/b2deYIPWDer6Qr0NCo05QzfMvj0bLL48=
X-Gm-Message-State: AOJu0YyaHh25bZVXuKE+aiknl4VDdWiLpD2UopLwYf/6J/QVKm9jEP9L
	+4Co5N9gZad0fvks3gIWlOLjfEfXcaS9SdZ2tP8x/9Jsz2btPNEadwQnDs/GtADueFX1+jenBrD
	QgXQtU5mHjByCP1xzWcazwlu4hLUpxIS5I5pDdS2a7SUR77Jm
X-Google-Smtp-Source: AGHT+IFYsnYxZkuoVUYNlb8Ts5dFS8t8z3/D+sz6e79RFN3U2QXIkbUK1DFABjBRkpsq61z+xoVBtqPAJ7iR6Mrk2nI=
X-Received: by 2002:a25:ae1f:0:b0:dcc:787:e8f9 with SMTP id
 a31-20020a25ae1f000000b00dcc0787e8f9mr3107129ybj.51.1713452192453; Thu, 18
 Apr 2024 07:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713348705.git.geert+renesas@glider.be>
In-Reply-To: <cover.1713348705.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 18 Apr 2024 16:55:56 +0200
Message-ID: <CAPDyKFqSmBOgiUumtctsd71_Ee1LqZ+vuZ87SkUYVPYT0VStNA@mail.gmail.com>
Subject: Re: [PATCH 0/4] pmdomain: renesas: rcar-sysc: Cleanups and R-Car M3-W
 quirk handling
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Apr 2024 at 12:31, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>         Hi all,
>
> According to the hardware team, R-Car H3 ES1.0 and R-Car M3-W have a
> rare quirk where powering down the A3IR, A3VC, and A3VP power domains
> requires an extra delay of 1 =C2=B5s.  So far upstream never handled that=
,
> but the BSP has a fix[1].  As support for R-Car H3 ES1.x was dropped in
> v6.4, only R-Car M3-W still needs to be handled.
>
> The BSP fix relies on hard-coded string comparisons of power domain
> names, and thus applies to all R-Car Gen3 SoCs (many introduced after
> the original fix was written) having domains with a matching name,
> whether they are affected or not.  Hence I took the opportunity to
> refactor the R-Car SYSC driver first, and came up with a less-intrusive
> fix.
>
> Thanks for your comments!
>
> [1] https://github.com/renesas-rcar/linux-bsp/commit/495e47e390499c522197=
352a08f423e8a3b41e83
>
> Geert Uytterhoeven (4):
>   pmdomain: renesas: rcar-sysc: Absorb rcar_sysc_ch into rcar_sysc_pd
>   pmdomain: renesas: rcar-sysc: Split R-Car M3-W and M3-W+ sub-drivers
>   pmdomain: renesas: rcar-sysc: Remove rcar_sysc_nullify() helper
>   pmdomain: renesas: rcar-sysc: Add R-Car M3-W power-off delay quirk
>
>  drivers/pmdomain/renesas/Makefile             |  4 +-
>  .../{r8a7796-sysc.c =3D> r8a77960-sysc.c}       | 34 +++------
>  .../{r8a7796-sysc.c =3D> r8a77961-sysc.c}       | 28 ++------
>  drivers/pmdomain/renesas/rcar-sysc.c          | 70 ++++++++-----------
>  drivers/pmdomain/renesas/rcar-sysc.h          |  9 +--
>  5 files changed, 43 insertions(+), 102 deletions(-)
>  copy drivers/pmdomain/renesas/{r8a7796-sysc.c =3D> r8a77960-sysc.c} (64%=
)
>  rename drivers/pmdomain/renesas/{r8a7796-sysc.c =3D> r8a77961-sysc.c} (6=
9%)
>

Applied for next, thanks!

Kind regards
Uffe

