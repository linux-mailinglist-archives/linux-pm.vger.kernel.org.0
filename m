Return-Path: <linux-pm+bounces-29638-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 845A2AEB053
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 09:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C427A6522
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 07:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADAB21D3EB;
	Fri, 27 Jun 2025 07:41:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9743021C16A;
	Fri, 27 Jun 2025 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010078; cv=none; b=fX3j4bpmDGmpHd01SwDO32uCN5+lu9xongPZqlN4SkDSW0ryTra62+Rl1l2/9b7AZ6pyop1UEom3yK4Px7yCCFmPzp0XfJUunYTOLsRTnOxZ6PztlUKzedzjkLfP4SiNKp0pC7dtLW5k63mRG79Bq2smHAFK5FLwI6D+F/5OYj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010078; c=relaxed/simple;
	bh=/ILX68ZdimjRT8sZQymo/tfc8nvGg3ozzP0Mjsj2CaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9N+dFcAz9ffJvxrBEVtwWqp4xANTsVlJCu5CwydQVeneg8DhDL3QZDHVyik/MzJeA+objVAYmZ05JriWP38o35lzs3xzdkexeTo8s4HQFMZef3TgAwR+y2dmmot/RjPHYmeseuH0QAwARTz8cvpmCJk7KSne4XglSm3DzCRNXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-532d498eb95so546614e0c.1;
        Fri, 27 Jun 2025 00:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751010074; x=1751614874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9O6AjL1bfiOb1lDaebH7BAFsorBp1P0F7E/Ese0vi9Y=;
        b=Ld7ORTafBOTy6oXeYgxUliWhHfHMG8jVeftogazaM53FqAEKDubltnyDfcirpQDC6y
         p5hjNmfSCGG/0ybH+FXVOcVIIlFiZwms2ocHBna24hu1jmq8KSQA7/YltC8wezidC2ez
         TZbdXvOAXVKE2scjaxfcUOV7GrI/k9GyUwNonUAz5ltqrknd8sWExjTP6lyErFf8Fily
         PSojYqVATnhJes0Pn9q/l6L6+P8IF/dSHoWMO7r2OrEVwTuLxWqS0VsgtgkA6O/Jss7Q
         mQ08uGO2kssUjw9bS3CvxNqTpqQ+ngOo7cqOGWpNyQHsq7cAJzRyVOftla8vfx7hJtz+
         8UEA==
X-Forwarded-Encrypted: i=1; AJvYcCUuh4lMcevO5AX6p4zsxVUEstEQCqHjnNbZ9zFrE5MmiDXsJPmdb0iFJPDzPID/TnMKQlshEbqXALnhz7FJliSlNPU=@vger.kernel.org, AJvYcCV51KWBNuakVmU6pMIsJgV9QHpsDZGyKJ5txO9usQRdnQz+7NATLF/QUDAwZns8vXeg1AZ7hRNzHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIgoy6E+z0TmhGErpNb+6/RjLirVFAky5iWmyBnCm//KNjb6Wd
	IwJxjkHp/RLGsM4C1I212jt9xIa6i84VhZOFXht+8UKlLf+KO6pYi1KRW9qJGWKGwM8=
X-Gm-Gg: ASbGncvgZDLogV4TZrzzlls5OjJjde9Mp7qxZlPUUNxJea7ZY1bLv7SfW1nUJAgP+fO
	zQuq+x70uXKKBKC4L1GTNpw0lXf4TT3Gi+UeTRrZolCQ2paA5ZHt1CfFdIy7HHpM1dwl2opSxGo
	g2LwmR08EuMhJn2xA1xzN84mW3NJjZ/LNaXxeyfiLVmIgi+CHpZL6X+V3KLxDWL+34Mhu2+uvn0
	HmWO6roJ2LsXIswMNJZT5krMxwLNvqDfII1FDnJAOyYZFxrKCQwEUHwpZyzIt9o8AS/ACMgSZwW
	Ff5b/FVZi5sDTDdiSRwBs81/Bjrq7EcWRQ65ze+5Wx0olWWhWhb0hQ4aireYcWGMMjDokKFbJD8
	E0Bi6H6PjlZcti18OvFI8enEJ
X-Google-Smtp-Source: AGHT+IG7RcAoTCMNP4A164BcD0D1mUfJ1PszCyUTAddwd8v4C22jkZtwYIpIIvq5DYjMuiwa1h+rLQ==
X-Received: by 2002:a05:6122:3283:b0:530:7bd4:1761 with SMTP id 71dfb90a1353d-5330c0f8ddamr1552766e0c.11.1751010073978;
        Fri, 27 Jun 2025 00:41:13 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5330909c2e2sm291964e0c.11.2025.06.27.00.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 00:41:13 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4e7ade16082so469894137.1;
        Fri, 27 Jun 2025 00:41:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvgyHwmST4RwWRyCiPrJQmXkkKU925dhd4JhhZhnmRzx31mmcfGf3a48zZfv00/vFTqDBzwBByd7blcYRETMga9Zg=@vger.kernel.org, AJvYcCXawdlBw9Ls3Xc3V514HbbxZ6pgV7fYIaGdL1W1pXlsOTNkIuavj5mZ9z8pC5+NtI/c9pd1lVEBig==@vger.kernel.org
X-Received: by 2002:a05:6102:5717:b0:4e9:c773:dca1 with SMTP id
 ada2fe7eead31-4ee4f6d96fbmr2008309137.11.1751010073518; Fri, 27 Jun 2025
 00:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <875xghhk2y.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <875xghhk2y.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 27 Jun 2025 09:41:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUMd9OThTQz0NYF=_vX77nJcHNiLY5e7WHjoE89J+uhFw@mail.gmail.com>
X-Gm-Features: Ac12FXzPZeAwTyrQxvU3ljrTlAxwRi1jSOzKeGuXY87r-gPbS4it6FJmQm5Y8jc
Message-ID: <CAMuHMdUMd9OThTQz0NYF=_vX77nJcHNiLY5e7WHjoE89J+uhFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmdomain: renesas: use menu for Renesas
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Morimoto-san,

On Fri, 27 Jun 2025 at 06:42, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Current Renesas PM Domains appears on top page. Let's create new
> menu for Renesas.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for your patch series!
Unfortunately something must have gone wrong, as I only received
the first patch? The second patch is also missing on lore.

For this one:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

