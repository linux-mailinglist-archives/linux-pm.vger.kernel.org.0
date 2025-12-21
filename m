Return-Path: <linux-pm+bounces-39760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3C2CD394B
	for <lists+linux-pm@lfdr.de>; Sun, 21 Dec 2025 01:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 160EC301028F
	for <lists+linux-pm@lfdr.de>; Sun, 21 Dec 2025 00:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814421D5CE0;
	Sun, 21 Dec 2025 00:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObLK/bMu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B9E54654
	for <linux-pm@vger.kernel.org>; Sun, 21 Dec 2025 00:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766277221; cv=none; b=a7OLLo4tC78GYmAgeCsidni4jx4Xj3puxX4I9LSyVF8II553TeJVcNKmUgKSSIp2kRyyGh2alTq3NOMNkVJmD7NGAKu436nAilKAxUtJwbwSw/OoamLU3EAjeNrEjrAMfTkTG5gDoHZCDwDATJ46d7p038d1vAurihDnzmjzEPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766277221; c=relaxed/simple;
	bh=HMPSgVSQTL+epLIc/kC163AC8T4yQPlj7ZsUDuK4jB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIq9hJvfbZBq+pmXv374VMLQ/8GH4gItpDd3WdLfEPfmNFBZJ01NVTBJ7uRaoMeJxGfeuTiOs+JJjjtLCdx0GcQyz6ChQnaFwkgIcrjcXZNwXFM786iNjUXAmcpjhIKLc8e4FkcULQWY3mqF2FogKiqSrUI5j1SOUa8SGw71JAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObLK/bMu; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6432842cafdso2622623d50.2
        for <linux-pm@vger.kernel.org>; Sat, 20 Dec 2025 16:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766277218; x=1766882018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8G9KmswsznvRwWx5QwQoiucqBCNKeB6cJ130wl/F5s=;
        b=ObLK/bMuYBq2EEpGmODMAy3+JxaEEH1OsKwNLseeP2BaY4hMc8Ko/oeOd2gwA1udv+
         1Gy3wQpaYJNAD0hSdGZgTuTtGYHRDu0dxXF7R/UuSUWR/mv/BJWGsylGMAi6qpzb8Bvl
         U6N7mLn0HJdvOSk/ZqE7+rzllZFplqB3sUiYYPKJBq0+FJJobCHNfAR4R0o4ZalSgC0A
         gbaMw4QJ6FGQXa/neBtGga0wDdIPjTRIzBsdRcBo6SC9+xhJQpklb/iTiEFSlvthm+3T
         HfxZaqxjKNYxA3En55P5jc1x+CaVVq3YOCCZoT3CqsUHiwjTfc1CVszATmq2RmQv0mm1
         KB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766277218; x=1766882018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X8G9KmswsznvRwWx5QwQoiucqBCNKeB6cJ130wl/F5s=;
        b=PuDP8iigpXxCZpHZQOgyhqaVAxyZJZtY8VygH5sYSaogyd0NUZlNu1lmDqbzVEBMRM
         PFhVCnpMqmkKMve36guOtKHChMzEeKuBVyiOx0TMo02HJTAV2qCxMePM9Yxu7Pc1uIAE
         cVjQIfXmLWvsGedqoUIJEWb2MGzxA4tqp2e5WQFLZQFSPyF3EfeCBl6VVrTnid4D/adv
         P3SXN3Xn11+8fEoAd1n4df3oS8cyc6vbpifPZFvbSy9RHuIkdCclsjuEOBVcxkpcMgDs
         GRZ8m5lqVf1wfbiQT4xC46ZxkAWPdXBxHfbmWWZIU/zpYVwH54DE9OOwLWmymHKy/76g
         VFfw==
X-Forwarded-Encrypted: i=1; AJvYcCXPGV2Q+JDmjh9TFgASx+1R+rO+mH6oPHsTnycVle/gcA/5Delo5ok4vOKLAHed0ODRXexf20NTpw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1AfbVlBdWc5EC0RUro6u41YaFnZ23t+78EGW74GQ3kxDwL6Qd
	D60aIZuimpZK4No6NipekKi6UH/SFM+4KZvIrd5PVCK7G0nPt0vUm9Hn93kW1vOcWpqX00iQMKT
	p83/rfz0aU/asHxquMw9QHTlj7rSpr1M=
X-Gm-Gg: AY/fxX7+dngtdvDdeU2dQ0gL5pSTAQoG2cuYkGbDpK4sOhnMC2xB0B+XCj/i2UO4XMQ
	xzvqw+bWAUD//2W+vOgC9HAfXjEXNLSvNYqyT/Vs87JZQC6W2S0AvuA8TFaX/Ys+hyUEuJtQQyS
	LBttB2qu1zVuNnuWkjQw5EqVy8X7jz7r2nIkdtfK9O0oVky3xYxmTjLvp0512ZdsaxABB3mNplq
	r2zMAX8+n5hr7sO/ORS3BcKUO4S9d5nu8j50wygjGcM6wnoZgQ2yfa8YLxDuy7mJyghUlBSFmmM
	tVIxzSR4b5a53jhDa+ptqHhtHSN2
X-Google-Smtp-Source: AGHT+IF+DcP7RBnj1eO65Ay4KAdaw9prgtbEqd38CqDRILia9eh90RWgdc07UopBt80TakLnfpkNrhhTAdF11Rmi1Ew=
X-Received: by 2002:a53:b08c:0:b0:644:6422:cb2 with SMTP id
 956f58d0204a3-6466a8c09ddmr4928743d50.47.1766277218122; Sat, 20 Dec 2025
 16:33:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220-mt8196-shader-present-v2-0-45b1ff1dfab0@collabora.com>
In-Reply-To: <20251220-mt8196-shader-present-v2-0-45b1ff1dfab0@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Sat, 20 Dec 2025 16:33:26 -0800
X-Gm-Features: AQt7F2pQeCDszCkhBlVBNoYZ8W1xv30ESuUDKy-HkDBic1PvCA7PvceQ4heu6Pg
Message-ID: <CAPaKu7QST65NPQ7rZAGhqLsb4FN21D-rOvUf-UzgsBCrOv1skA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Make MT8196 get its Mali GPU shader_present from nvmem
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 10:50=E2=80=AFAM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> The MediaTek MT8196 SoC's Mali SHADER_PRESENT register does not list
> only functional shader cores, but also those that are fused off to
> improve yield.
>
> The SHADER_PRESENT bitmask with the one fused off core omitted is to be
> found in an efuse. However, the efuse address is considered
> confidential, and is not public knowledge.
>
> The MT8196 GPUEB MCU, which does the power management for the Mali GPU
> on this SoC, knows and reads the efuse however, and exposes it in the
> shared memory intended to communicate state to the application
> processor. Reading the bitmask from this shared memory area is the
> vendor's intended solution.
>
> This series models this in the binding and implements it in the
> corresponding Linux drivers:
> - the mali-valhall-csf binding gets an nvmem-cells/nvmem-cell-names
>   property to declare that shader-present is in a different castle
> - the mt8196-gpufreq binding requires nodes to expose the shader-present
>   cell
> - panthor checks for the presence of the shader-present cell and uses it
>   as the shader-present value if it's found, instead of the Mali GPU
>   register contents
> - mtk-mfg-pmdomain becomes an nvmem provider and will happily serve
>   queries for the shader-present cell
>
> While it would be preferable if we could read the efuse directly, it's
> not possible as things stand, and insisting on it will just keep this
> hardware from working in mainline. Running a GPU workload with a
> SHADER_PRESENT bitmask that includes a faulty core results in corrupt
> GPU rendering output.
>
> Modelling the mt8196-gpufreq device as a nvmem-cell provider however is
> not lying about the hardware's capabilities, as it truly does provide
> access to the nvmem-cell, even if it acts as a proxy.
>
> From a bindings and panthor perspective, this is also generic enough to
> where hypothetical other vendors doing the same thing (even with direct
> efuse access) can rely on the same cell name and implementation.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Series is Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
> Changes in v2:
> - panthor: move to nvmem_cell_read_variable_le_u64
> - mtk-mfg-pmdomain: put of_node in error path
> - mtk-mfg-pmdomain: remove leftover stray of_node_put on NULL
> - Link to v1: https://lore.kernel.org/r/20251217-mt8196-shader-present-v1=
-0-f6f8f3aa1e93@collabora.com
>
> ---
> Nicolas Frattaroli (4):
>       dt-bindings: gpu: mali-valhall-csf: Add shader-present nvmem cell
>       dt-bindings: power: mt8196-gpufreq: Describe nvmem provider ability
>       drm/panthor: Implement reading shader_present from nvmem
>       pmdomain: mediatek: mtk-mfg: Expose shader_present as nvmem cell
>
>  .../bindings/gpu/arm,mali-valhall-csf.yaml         | 14 +++++
>  .../bindings/power/mediatek,mt8196-gpufreq.yaml    | 13 +++++
>  drivers/gpu/drm/panthor/panthor_hw.c               | 36 ++++++++++---
>  drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c       | 59 ++++++++++++++++=
++++++
>  4 files changed, 116 insertions(+), 6 deletions(-)
> ---
> base-commit: 638148c6ffa31d2e4958d51708ff3675221e2da7
> change-id: 20251217-mt8196-shader-present-e2dc3f97fc74
>
> Best regards,
> --
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>

