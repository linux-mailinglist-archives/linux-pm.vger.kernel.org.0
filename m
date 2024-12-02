Return-Path: <linux-pm+bounces-18313-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3049DF9AD
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 04:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62111626E2
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 03:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0ED1F8AD3;
	Mon,  2 Dec 2024 03:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="elbtE0eC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558D61F8AC2
	for <linux-pm@vger.kernel.org>; Mon,  2 Dec 2024 03:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733110895; cv=none; b=nSBkLV3254ja9XD3ueW4uyoB5GgfLIw3AXsq/GVpiu30XZXWJGEazDqhoPDm7weKhuPZux6Pwq+Oq6e24VEzyGA8R8ZQny1g2ggx2nF/yGLzzofXfK563xY4MqRP+xrRUf+L2c5ts/Q67kydPgRyZsffOuHUS08dslFVcLya6FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733110895; c=relaxed/simple;
	bh=WL4yh0AElDBPFlk9xy3xVvMWfNNY0b2isFFOAhLsxUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpsGZWI/oVXrsAKMp2ITw/GMvWSjEKxiviT/dnqSMmuYEPAE/QloW+O48IlSwnlCRp+uxuoEDZWdkPx+9rCsemfdqGnKIjoEy2uAVgHqKawxPHkPUTt+/UcbmvNQ0Tnto03KyvrRHacw7UySy05g7OeeSjSNGu3gu3Kz8jM0sJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=elbtE0eC; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53de852a287so4244652e87.2
        for <linux-pm@vger.kernel.org>; Sun, 01 Dec 2024 19:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733110891; x=1733715691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bTlnjRzF2JRQH5FoLyAwJy6PscFmIMIE7nVuxtFSPk=;
        b=elbtE0eC+XNjDXAm/xsnNNpXN0XQVW/t6GdTEn2eOwR5zDvKG1UOw3SrRyuLbrNt3p
         Ejv0y7X1PwIggpiJ3zhuK4CjwRNyuDWjWuJzFIZMPHa7CxisO+xA0D2DDx5mnBQq9lYs
         9SKTnMXsk1UfLdAYa/sSpDPXfbXGVLnuy5XDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733110891; x=1733715691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bTlnjRzF2JRQH5FoLyAwJy6PscFmIMIE7nVuxtFSPk=;
        b=gWa4Fc/XmF1fGHkSxCan7NpBUII3K6XTIB4KYcmDWPXh5PbPhPOQfX4YAkqVXvUgVV
         08LtWSI+Qcvq5Wwuu9rcIGHUDdTSnOuKJobOdrSmESxelfAZttl6RKx97MSY+ex1Q3Ld
         ZHpnZRnOIuhRRl+cLMeeaSdZsQBviNDNMHBwessIv/gmGHo3uiVu3kS/xJEP86VTp51l
         Sp17CJUbGDRaQ2qk48SvW5D8EIMasf3lIv0yabBeSUaez04j09LI4DWzc8AZrq7eqtK0
         J+Ziw+YXua16zOlDpwkOfmp8px/+1kphL2naXt3dtkT0r+PrqhuOAYdWss6lq8jNLZr0
         risA==
X-Forwarded-Encrypted: i=1; AJvYcCWc3QR9h1Lou0DbQeVP1vjV+7/SsM825fPF0to0l3o5cWu3aHXLOudBBdyBU8eh5LKc3R2cJvmtEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv7wN9Tz+fCcy2upWbUuQG3W+FORZqto0T+hRr/0ux7HETbkHz
	OD4m+ya6wyRz/uxdgZfFoFeeIjHfZG4vv1v/RTLyItnBfkcSnPR4jErArkV68hIUg3btXrHyiEr
	EcHQ2MVneDYZD0ecYKu9Sldsv1Lm2rf4e2cRh
X-Gm-Gg: ASbGncsThIKIV6j/doYuSozaXgNI+bBSCvT1hnQI9t5Jir7g1FfG21Qv/Z+G/wThhaL
	ZD/YzwF6nmjgok+/u/1giXvIFK7xuNI4swac4Ns++w+gOpmuQ7bV9wIQr9zY=
X-Google-Smtp-Source: AGHT+IFBGoFOaRz+qRuU+qOg6hWpwu/Z+nHG5cJ1fZ9YkpTnT8oQX9A4GdCR+xRN4nrprMU5eqtqFpCUbyCnVLzassA=
X-Received: by 2002:a05:6512:2356:b0:53d:ab10:c273 with SMTP id
 2adb3069b0e04-53df0104928mr6377365e87.40.1733110891515; Sun, 01 Dec 2024
 19:41:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112052211.3087348-1-nico@fluxnic.net> <20d3a0be-ba5f-439f-80ff-2e2bda3bb144@linaro.org>
In-Reply-To: <20d3a0be-ba5f-439f-80ff-2e2bda3bb144@linaro.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 2 Dec 2024 11:41:20 +0800
Message-ID: <CAGXv+5H0ocBWxGseoRXWyBo48+5-F-FRLZZcywcM-_vwu4=jVg@mail.gmail.com>
Subject: Re: [PATCH 0/5] thermal: multi-sensor aggregation support
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Nicolas Pitre <nico@fluxnic.net>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nicolas Pitre <npitre@baylibre.com>, 
	Alexandre Bailon <abailon@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2024 at 4:00=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 12/11/2024 06:19, Nicolas Pitre wrote:
> > This series provides support for thermal aggregation of multiple sensor=
s.
> > The "one sensor per zone" model is preserved for all its advantages.
> > Aggregation is performed via the creation of a special zone whose purpo=
se
> > consists in aggregating its associated primary zones using a weighted
> > average.
> >
> > Motivation for this work stems from use cases where multiple sensors ar=
e
> > contained within the same performance domain. In such case it is prefer=
able
> > to apply thermal mitigation while considering all such sensors as a who=
le.
>
> Do we have a real use case where we can compare the per sensor vs
> aggregated sensors approach ?

The MediaTek platforms have one sensor per CPU core, but the cores are
grouped into two clusters, and DVFS is tied together for all the cores
in each cluster, as is commonly seen on ARM systems.

Furthermore, there is a hardware block that does minute OPP voltage
tweaking based on thermal readings, and AFAIK that block wants the
per-cluster aggregate temperature.

ChenYu

> > Previous incarnation by Alexandre Bailon can be found here:
> > https://patchwork.kernel.org/project/linux-pm/cover/20240613132410.1616=
63-1-abailon@baylibre.com/
> >
> > diffstat:
> >   .../bindings/thermal/thermal-zones.yaml       |   5 +-
> >   arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 210 +-----
> >   drivers/thermal/Kconfig                       |  27 +
> >   drivers/thermal/thermal_core.c                | 643 +++++++++++++++++=
+
> >   drivers/thermal/thermal_core.h                |  14 +
> >   drivers/thermal/thermal_of.c                  |  86 ++-
> >   6 files changed, 780 insertions(+), 205 deletions(-)
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>

