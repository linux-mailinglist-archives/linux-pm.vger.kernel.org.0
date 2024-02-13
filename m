Return-Path: <linux-pm+bounces-3870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D17C853093
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 13:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C7128543D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 12:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A6124A1F;
	Tue, 13 Feb 2024 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQBnyYOY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2692D43ADD
	for <linux-pm@vger.kernel.org>; Tue, 13 Feb 2024 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827633; cv=none; b=Az2evFBdlA8L9esiGYYfJfZazb0HDWljsjxLNIksxRasBiWNlro2srsgRT7UcPZQyxJ6MdlC8bEYmUZAIllR1340WARLREZ4OWhJV0fRuPKx5VQzhYKlUQ1qCQ/+OhvJ1Y6HT5UCOMUiLJyqKwzdwz5/pczy9E5BTWQMTxu/8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827633; c=relaxed/simple;
	bh=GwGj3mbaxyxX+GCZuXwjYyfxv+yWwqjHGw+1fC+8EL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+C7QxoBjmAw1HaFV/kShrKmnAcVTptibl3io40rfZN1QSMYPhuwD4DOg2GKzTht7a+oDJjYQxg55yP6Jluqc7kJKaC6tpXHLGqH7gYvy/4lekuLzAJV6sPMd3y/TngzNaio/o2c3j0xzvWggVB8IixMlNJpllwLoaYOq2BgTn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xQBnyYOY; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc236729a2bso760049276.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Feb 2024 04:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707827631; x=1708432431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ww8CUkzhNxlH2/JABJGWf2qJPAzOGVrVZBAqevbwVMY=;
        b=xQBnyYOY13OjZjWG05dOWbOmEU0NYf3RiKBYzSiFETrw5F0cpyCc0xhhpkEUQRlFTJ
         zCdTDPGW65YcTWiDa5wyAFmR0Hx4hmhfK0Vt3px5cwR2KrZJ3xbZzwinD+1odL3XU+av
         A6KGYXdIPQGb6hNZC0IUEw+SF//KaR999+PFqit0bCRimtKEqpLzHWnps+H15ZEJBXpf
         gbuhf9oNFFfJLIXsjAlOhEQb0vA9ccvoX+KgnyELB9yFITmR61MuYsLjs/d0LfhTacuk
         HvivKbBAERLyjQYED4dF6bSwULYMBX8EkV6cBcVu0o6r1dWYRlBYGCgESx8WOHAhWh7X
         aH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707827631; x=1708432431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ww8CUkzhNxlH2/JABJGWf2qJPAzOGVrVZBAqevbwVMY=;
        b=se1ax0r95p6M7Nzaufzjlem6N7Hv9r3uLovMJv2iGRlLClRnmeTc6IQqfyC2/5U0iA
         M0VIW2dgL5uSu2lqlEGcDXz56NEBDnH9jV3deXs9wGIepv12l3qgIV84eztCHFSKAsbP
         X02uqg2DVNZMRo24dkYqCwRk1pJRRtrGbUFBBMRY80PM6D9iJf6gfhexvu33JbR8rbH7
         dh2fh284snYwiSzj1yWHtTFsuAlP+j9tIEo2bDyqr/3U1+g6SxdRKGyOuZmaI2M4oCut
         h5RGYBnD7DxbyU3tZyX7N7AHXJitsdB0G7g1/SaX6rXVT8SEI8r8yBpCKql73bG1A4xl
         QWFw==
X-Gm-Message-State: AOJu0YwDFl2qpHtAk7neQI8fvLYS3hhRFPy8929GwNTU+xxGOMKzpEJX
	Pl+u37nqZqlAwpc9xtrhL3lN+N1NhO71QJ1I+pv0C+zDdVS5MEK+K3+hzpj8UeajU+Nk2/npgiC
	QBA1aRjrdJyRdS3oARHMXy17In1+O+M5AwnyqDw1/bc9ukn2s
X-Google-Smtp-Source: AGHT+IF9w+B8KAIajg/d76zw1NDEHpTCzI8mhGX8cc3DsoJdJrZq8fwBkGtmBkG59dgo+MR3Z52ad+x+t/vovg8m4jQ=
X-Received: by 2002:a05:6902:e12:b0:dc6:ff32:aaea with SMTP id
 df18-20020a0569020e1200b00dc6ff32aaeamr9200487ybb.24.1707827630991; Tue, 13
 Feb 2024 04:33:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8734tx8b18.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8734tx8b18.wl-kuninori.morimoto.gx@renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 13 Feb 2024 13:33:15 +0100
Message-ID: <CAPDyKFohZo6KALX2dUxruoDKLy2C+XOmnTrG1g6=s_mQB_W9ZA@mail.gmail.com>
Subject: Re: [PATCH v3] pmdomain: renesas: Adjust the waiting time to cover
 the worst case
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Feb 2024 at 01:26, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> From: Dien Pham <dien.pham.ry@renesas.com>
>
> Description in HWM rev0.51E, 9.4 Usage notes, page 455 tells
>
>         "It takes several hundreds of microseconds to shutting off and
>          resuming power domain. Because actual time required for
>          shutting off and resuming depends on the status of on-board
>          power line, shutoff/resume time is not guaranteed by
>          electrical specification"
>
> Let's assume the safe value of waiting is about 1000us.
>
> Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Tho Vu <tho.vu.wh@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2 -> v3
>         - remove Signed-off-by Geert
>         - add    Reviewed-by   Geert
>
>  drivers/pmdomain/renesas/rcar-sysc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
> index eed47696e825..35d9aa0dfab8 100644
> --- a/drivers/pmdomain/renesas/rcar-sysc.c
> +++ b/drivers/pmdomain/renesas/rcar-sysc.c
> @@ -45,10 +45,10 @@
>  #define PWRER_OFFS             0x14    /* Power Shutoff/Resume Error */
>
>
> -#define SYSCSR_TIMEOUT         100
> +#define SYSCSR_TIMEOUT         1000
>  #define SYSCSR_DELAY_US                1
>
> -#define PWRER_RETRIES          100
> +#define PWRER_RETRIES          1000
>  #define PWRER_DELAY_US         1
>
>  #define SYSCISR_TIMEOUT                1000
> --
> 2.25.1
>

