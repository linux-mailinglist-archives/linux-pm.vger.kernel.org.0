Return-Path: <linux-pm+bounces-2662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE17A83A62B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 11:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1251F21BDA
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 10:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70097182B5;
	Wed, 24 Jan 2024 10:00:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566955690;
	Wed, 24 Jan 2024 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090422; cv=none; b=i4YuNuMJGR2j1r5teF2il2GTE/ZpBBKEAjRRW4APTLnHkyRWpBVoWz3SSIY4+Rd/+O8SmmlRFCBNh01qkI3ETghNKLf3zQ0ewaAJX5X/nl60kPB4S+dWQupV6oUjw7cVv7JhQ1dyi5lXdr0sU/m/aG5BnSqNZFmcc16QI0SboXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090422; c=relaxed/simple;
	bh=uzwzMyyRR6BpI8v/QUIVLzjcKzxhDq26lgHipI/5X5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/i4LGkjKPIh5AmuvhOkwd+hXUOjREHRgt+0olZfD06UJ1qUcBdmSgRz5bydpPbQSc6obsSbhoN35cbUi/51xb5y/r8MZ2Eveeyd5D7bavvL9y0vWHx4UPmWCMN/hisc5Sm/5cJOGr/r6osGtGvG67ygZPiVrdnY1w+pzUYWxuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbe344a6cf4so4676304276.0;
        Wed, 24 Jan 2024 02:00:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706090419; x=1706695219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Xv/thtT5CkvacpZdWIS8taCoZhG0GyZivlNTL5Pu4A=;
        b=fWCX80gQHS7QJGFeXC6d432IuaoB6Hk9TZVmhIt+4MioyfYWTDItpU/dBMsTflBmtY
         SVBZmUBmx/vvzGS0UDqXQYD/4tkq/BfZWpi8Pz/xapR1AYzuwJC5HsgwWaUqCgI7zQ9N
         nyJfn1YhPDf6e6kTtibXHq5FoippBh92ccRv7fZ5sm/68V6ej/P6VZCXzezai3ZnFd/a
         c5V+PYiEle8P6AOQLZ810ad+i3b7dXteAfyVbzFDvKMgXA6G/COem2cCQvNNXI4QlYlL
         KSAm5SUII0W5qophhrIlqAEHfULLbs8fYcg2k5daA0kwmu0eQvVJMYRG6xYD4h8sCsY1
         xq0g==
X-Gm-Message-State: AOJu0YyGIBTEbvrsQxfGIh7tyWsT/9vCego9Bq8z7QcWwmi3vUKML46F
	2ZdrBex+OCx0/vKJYeG0K1irh+nkekF3bk9Qnw0S/uCEg0eoQWzDz4CyzMnDtuk=
X-Google-Smtp-Source: AGHT+IEmHP6SbHYLkEvwSsp7Iq2KGYSOKZLwDCvY6OiNaZ/2mXz1KDr2xjB0iy1fSpNl80SR81ptxw==
X-Received: by 2002:a05:6902:2189:b0:dc2:5456:789d with SMTP id dl9-20020a056902218900b00dc25456789dmr473864ybb.33.1706090418873;
        Wed, 24 Jan 2024 02:00:18 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id c11-20020a25f30b000000b00dc265e2b087sm2672508ybs.43.2024.01.24.02.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 02:00:18 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5edfcba97e3so54363437b3.2;
        Wed, 24 Jan 2024 02:00:18 -0800 (PST)
X-Received: by 2002:a25:ab48:0:b0:dc2:4cf0:e7c6 with SMTP id
 u66-20020a25ab48000000b00dc24cf0e7c6mr389779ybi.124.1706090418376; Wed, 24
 Jan 2024 02:00:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87sf2no5xo.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sf2no5xo.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Jan 2024 11:00:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXMDXK9uXMkj48J1sbk4LCH+rjPKjfvGvNOrscS0ywpFg@mail.gmail.com>
Message-ID: <CAMuHMdXMDXK9uXMkj48J1sbk4LCH+rjPKjfvGvNOrscS0ywpFg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: renesas: sort each SoC on Kconfig
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Morimoto-san,

Thanks for your patch!

On Wed, Jan 24, 2024 at 2:51=E2=80=AFAM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Renesas has many SoCs and it has generation/series/model number,
> but these are listed randomly in Kconfig. This patch tidyup it.

They are not listed randomly, but sorted alphabetically by description,
cfr. your commit 6d5aded8d57fc032 ("soc: renesas: Sort driver
description title").  Have you changed your mind?

=E2=80=9CA wise man changes his mind sometimes, but a fool never." ;-)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

