Return-Path: <linux-pm+bounces-15411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECBB997117
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 18:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767151C22022
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 16:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3507D1E0B95;
	Wed,  9 Oct 2024 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VKW6Ou+W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED42197A77
	for <linux-pm@vger.kernel.org>; Wed,  9 Oct 2024 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490011; cv=none; b=OxEnwzfuSr8P6AOUvdhs27phAthIueagmMD5/WzpglqAyeAkz1j/X6T9ioGNb134O8veZUoIYTi4Fr6F4UPqxWPPk2Sa/sP+UyTyEE8Jei4KyUdgyITrPzv6BFgSvF3LU2WAX7NGhDRdwY4ueI7dz4EAeK1gs2+nqc4qYQmRtxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490011; c=relaxed/simple;
	bh=nkfcKspWQ8hexMjCW+X8wh5gyfzaCeAToCi4rgQ7REw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CD9qyE6IC3xGzDsHbbBBgQ2DjDHh52N7m5IEoRTFUNYijgqSQhHkNCL0FQWo0NPt56Xg/6MSRBUxCrASQ9ABgRowUFZv88PUXuGnMOKuCDF6EMeiYCzYci/dtDByivFaw79y0/0abeNuWGNFwHWX3J5LIIJUz7duYt//mAUFiIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VKW6Ou+W; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e235a61bcbso6874877b3.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2024 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728490008; x=1729094808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkfcKspWQ8hexMjCW+X8wh5gyfzaCeAToCi4rgQ7REw=;
        b=VKW6Ou+WFI6CYLkbWHCWM50aVe77PG3KQEyt7XEV88psUHzfK4smhXKMLRfyvx0Vv4
         FO8gUno2MoyDAT0p5NqE+Il/RHEfSSZRDIqFJAxLRjeEEea3sxC2Tot2FoLTsay++34h
         /FNTNWoUu2lNR1TY+d3CgDhreupc3NbWoqQTtUdAiPMjHLGz7manVa2Hlluzc8X+TCWZ
         Kbcd6Jmqp7SLz2s8ePMxjip9aI0UIDyA3AlEU7OxP716YkQbFwPj1Jz2J+LLqrE6Rhnp
         ViCtzrIw2L81FMMuQsu6wHgfp6m55erNcq6G/Cw268SSlBul3uktkr7HO0oWBRFKq7yf
         Sdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490008; x=1729094808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkfcKspWQ8hexMjCW+X8wh5gyfzaCeAToCi4rgQ7REw=;
        b=xJb1xT/ZlwKjdhLiolf68fReNdRIVcGijpGMuWS/HcA0hCv1U1DQXN+KxT7YpIfRpZ
         q4+js3C+BDrhqLTxkU7Sc/2E/Mj4Bn4q1ezJ3feZP5cPDqOnaTkhpkumrWRJlId1wBj0
         PCpjw8YgKuNYMbxojxpepG9YOAXqB+Sc+o4atVab4A/RSo0qsiKJUo8JTTU4tofBGkfH
         vx7ekXiqz8E8cVZdJEIuVSt2xWIkzX4Wr09pJrVAyS5BsD+dnfI7oNvlNfcpLNi4Yuyu
         QzIbKxHUSRg3pHf4mr8UygQbLej1ls05j0idhodTdPGf5WaERmbIzGaHJ0lOldvBa160
         Nhzg==
X-Forwarded-Encrypted: i=1; AJvYcCULiqEcUur+JD8of+iAfiknoyz6SgLKvnyGV2qme1LMqbW6b8xs7Nj8Hgd3/rDZ0QsEryK5y26KRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfEftOVpZVtI2CtvFoVbIpNn88jpnSlFRinCBL136QU0C+sx4H
	oZ/FQg1JaXNvTL6ZGgpnqgioovj+FpR5B5A4EMtTBnfHChltkjm0H8dnoEOkvdVFIDj6QPHc7zA
	llvwkXlY4n8nmSfqR7mbptvG6+md/LbvVLjg6+Q==
X-Google-Smtp-Source: AGHT+IEB7615ehnAAzSlp9QeY7Exo9QxBnJB+eLgmqzfktq+2EhfQ1a1O+UY0RdpmmKJABEdhGOUsHTE88vgiT+tHak=
X-Received: by 2002:a05:690c:f93:b0:6dd:ddf6:90aa with SMTP id
 00721157ae682-6e32f134e85mr1925237b3.5.1728490008640; Wed, 09 Oct 2024
 09:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
In-Reply-To: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 9 Oct 2024 18:06:34 +0200
Message-ID: <CACRpkdZtUHAaF1cqmyJcthp=6-w4quYAF=PMdknU4iQZ3_E-Tw@mail.gmail.com>
Subject: Re: [PATCH 0/7] power: supply: constify ocv and resistance tables
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Sebastian Reichel <sre@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 12:04=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:

> These tables are nevery modified. Reflect this in the API and constify
> the table definitions.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

