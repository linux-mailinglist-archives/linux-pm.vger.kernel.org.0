Return-Path: <linux-pm+bounces-31650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 349B9B16B0D
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 06:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE1C18C644C
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 04:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7857521CA07;
	Thu, 31 Jul 2025 04:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D48Xn5no"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B041FAC48
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 04:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753935053; cv=none; b=kTN04wzNGtlAJkGKH3IO5iGi/Rus5gLWeZVBkUo3hCuvagT9LLPPeM+j/DcsyqNzUqWwM3ELmroD83p1iZucief2414H1doiPHOUCCxyvddXYawnPdEHY5OEz0rLRXdKufkhg02/Ugl3nnPaWUH9kNeVy/oc75jWr+65qQaZrbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753935053; c=relaxed/simple;
	bh=/ja0EnpPMJAy1a6pZm+E6r8QXYWmEMOdxVyXZuJR5eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9hMC/EU1KDoeBKuOoJuw0frl+Zz7JUhQ3IU3egoJfjgm9Jrs9jNKLgPbKxg90CW5+wUUVOzpp+djzidQwIBSTKRtsFuF25uj3ztUHdO6MyuJ7+1h5naV+AXTHGej02Ai2trK9ZIcFpjzcjQIsI74sZ5Z2B+jIZOaGvC7XeCiw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D48Xn5no; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-73e8cc38e80so897008a34.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 21:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753935051; x=1754539851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1REz7lxNqCP0vRE/ucDmbyORYxFecR0vhh1/DbBdVo=;
        b=D48Xn5nohE35KEMtv9TmSrM711/5L3CcZ5j8ICTLiPSf8PrBvcaPS4KtoMp6inf0Ff
         qdg8oKR5BDs2mrvpLb6dZ+XANtLtVxQko4Vj64DwWn+cryhCn33Jz2/wkKknnZS934un
         nc9qs+ehKxPf1L5OSdId8Ig5ugfD7OqVezxNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753935051; x=1754539851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1REz7lxNqCP0vRE/ucDmbyORYxFecR0vhh1/DbBdVo=;
        b=rlgTKlROW1IMKlU3s7+O80HYvX1i3dwXKE4G1QYogx+3U0ZSKAIWDiodudEsR4kyMS
         lsVA6P0fhGUTCMbZDRwDLGbCexKN68+w7ik6rJ1QvQoJFyrGQNQfG+vbnMVg5vg6AWrg
         f86aJhHZ4myab2XKRNzCvZNBrfxdg1je+ER++VMcmia125yFNTHZvtWiNaD/n49C97Ia
         MwUo47A5BGV7KCI2oWo2S0hdfkXOFqnxqsOR0xLemvoXRqNlcqL795h9imyVZDqHKVyF
         fkgtGrQdReNDRKECp1qSogdvO+9TulEOGnkLiBxsM8PLQvusnW+wolSC6YoGpeuJ5Kfk
         VLgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWm2U/gVCkDf8PX04iHaiRyyLmRLixiz+mEtMPM3sbU1hzRV4mITlh6vquXS8NdGvB+qEsmWxs/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWsHnAvR6M7WicNxrqKphx4q+ZqMyreZ8TamSzKUc/IrHrtTNi
	d5vha6SY30Mtm0cuEDuDBTK6YhSNzUtGbYykp69UEQizxOEIKOnCNsiKGIdzEWSBLgkxAPGeC8X
	RDAk=
X-Gm-Gg: ASbGncsqq+ZoWt88DbqlbaxHMBPI8pAsuQ2astkLbWhO7a5YVx7wfPIebsctyoAFM0M
	gqVtQ9Aymf2vTNP/7yfeUNaEyYeLqisXGgBg3b4a7Of9vsI0i9TuUXm90QiLm+NzK3+dmv7smGO
	lcSiirL+QPqLCXger7RjET5VhHBbMkMkbdiIrBlifEe4+nmHH+YaC8yA51o6iCF2a545BeQ9CKQ
	niqof9loH65KptxJfsZv2DxO3B0GfGeVzyQs/BnK8H2b+MQrX+NH/GjOk+504iR4JFKrynsgjhV
	WeXAuX1wCPJEuFwyeXc5faafkmbtrxsOyJCVu2wSDv5poinlFrP6KUz+alAgxsmvXkgYEJheZlL
	0HZHzQ+nnsKfpDUmfYf+uLHvRhx8Nri6JXlje79HzJbXzZdWZhbStNg61Xg==
X-Google-Smtp-Source: AGHT+IGhC1l09s2i/lz8PEWexWCZvnSHBiW7sCTezbe8UogF6vARQpJzxz1nc6OjVzgMF62UUTTN3A==
X-Received: by 2002:a9d:538b:0:b0:735:a6b9:3b48 with SMTP id 46e09a7af769-74187a9b34dmr305518a34.10.1753935050701;
        Wed, 30 Jul 2025 21:10:50 -0700 (PDT)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com. [209.85.160.43])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74186ca998esm158570a34.1.2025.07.30.21.10.50
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 21:10:50 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so1169107fac.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 21:10:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5yOZLPZHh9MSIGsfojNAihplJHYIAu7GYPW6WBy2x0w6mA6cPPSNeYL3mip8STd67dGeWXskQYQ==@vger.kernel.org
X-Received: by 2002:a05:6102:5122:b0:4e7:be09:df07 with SMTP id
 ada2fe7eead31-4fc100ad7d7mr227087137.12.1753934630495; Wed, 30 Jul 2025
 21:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730152128.311109-1-laura.nao@collabora.com> <20250730152128.311109-5-laura.nao@collabora.com>
In-Reply-To: <20250730152128.311109-5-laura.nao@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 31 Jul 2025 12:03:14 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngvS9z-KOZXeV4kLiW_pDx2F+3AOMcTokaq9O=-E4Pneg@mail.gmail.com>
X-Gm-Features: Ac12FXze0WWvW6KolXpxHVZ5mr5bsteDEMGk6n5CvaPH_JsjnG6BTJ_hncHj4Ic
Message-ID: <CAC=S1ngvS9z-KOZXeV4kLiW_pDx2F+3AOMcTokaq9O=-E4Pneg@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] thermal: mediatek: lvts: Add platform ops to
 support alternative conversion logic
To: Laura Nao <laura.nao@collabora.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, andrew-ct.chen@mediatek.com, 
	kernel@collabora.com, nfraprado@collabora.com, arnd@arndb.de, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, u.kleine-koenig@baylibre.com, 
	linux-arm-kernel@lists.infradead.org, wenst@chromium.org, 
	linux-mediatek@lists.infradead.org, bchihi@baylibre.com, 
	colin.i.king@gmail.com, lala.lin@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 11:35=E2=80=AFPM Laura Nao <laura.nao@collabora.com=
> wrote:
>
> Introduce lvts_platform_ops struct to support SoC-specific versions of
> lvts_raw_to_temp() and lvts_temp_to_raw() conversion functions.
>
> This is in preparation for supporting SoCs like MT8196/MT6991, which
> require a different lvts_temp_to_raw() implementation.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 46 +++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
> index 8398af657ba2..6e4a35ecaf34 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -125,8 +125,14 @@ struct lvts_ctrl_data {
>                         continue; \
>                 else
>
> +struct lvts_platform_ops {
> +       int (*lvts_raw_to_temp)(u32 raw_temp, int temp_factor);
> +       u32 (*lvts_temp_to_raw)(int temperature, int temp_factor);
> +};
> +
>  struct lvts_data {
>         const struct lvts_ctrl_data *lvts_ctrl;
> +       struct lvts_platform_ops ops;

nit: I think this can also be a const struct, since ops are all
initialized in the platform data and never change.

Anyway, the changes look good IMO, so
Reviewed-by: Fei Shao <fshao@chromium.org>

>         const u32 *conn_cmd;
>         const u32 *init_cmd;
>         int num_cal_offsets;

[...]

