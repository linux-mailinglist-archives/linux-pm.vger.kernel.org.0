Return-Path: <linux-pm+bounces-35711-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB06CBB83A1
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 23:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4CF4A00C7
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 21:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4222226B742;
	Fri,  3 Oct 2025 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCtGk1XC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9101325F7A7
	for <linux-pm@vger.kernel.org>; Fri,  3 Oct 2025 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527755; cv=none; b=fkXtEuaVOVOUIwEDdu0JjiuueppmdFmyQYX4rUJ8q5uB2FDW08nR5uabwJ5s+MwQ0sR2zcwXFTiBu4QztkftAdFIBVMDtfjTEX9kmkYmYdirUqd3lsqj896hvM5PRhil6zLUzqY6ZH5BC6iA0DTg+ORT2hXGyLeZsc2WE3v9t3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527755; c=relaxed/simple;
	bh=Qb4Wu82O8H4woRuNaXSp6qi7XmoH0H5VI5tHbH7Spug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcftctINVpWC+umO9c1d/Kn/8XadsaboKFqfO9RCjbB+ncLLogB38k7DYFb1Kz22wcQR5hHgNtKHbCz6hyE/C+F4yYPk/KCNvJe9GNlChYBAUGcLZPJDNKLz/Nra9Ea856ss+y2zOkdWJs/70zueyeH8eNhKi87BuNNohDcg6go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCtGk1XC; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-637dc2292cfso3078927d50.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Oct 2025 14:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759527752; x=1760132552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qb4Wu82O8H4woRuNaXSp6qi7XmoH0H5VI5tHbH7Spug=;
        b=aCtGk1XC8rRSai9BmOGOVAJin6qeyYLkH35lv2ujQWg0huQq7vywCssunW/EbXOZO8
         1wVda4MHZbI0KNHHW0YQBQOubZnVfuT/JPAhIMmi8OUamRQCTFrxDnLbWtYoaPsylkGr
         kwdyu9TjvWi2cFUcR7uWv46N5lIaf0rgQ6Z1gbZqXYZwAJcShlua+BgqWkAvIq3bqbic
         2hntgmIKwgHfKdMBZIM6pk1HuFnnIlv2EvyHAzxCMJk3aEFhy7q7UJyiRtvZnlXlw1YD
         Zx/b86ghRw206/wy6+JEzzYipnSgA8OjHIA2zFfNkKICjPI8T5hiUmH8oBq7QtRBs8Wy
         KjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759527752; x=1760132552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qb4Wu82O8H4woRuNaXSp6qi7XmoH0H5VI5tHbH7Spug=;
        b=ZtBdfP0nadmpmBy5v1nw3y6CeHWiUYEZs8nvvctTApOGtsi5fdmdBqWFghZiqRu5Zj
         jFp0Hsc6z1j7gUhYdbNePAx77/PcXylA7Ex3WHpPlvVMDREA5uWPbJQwbzHoGw/lpvlP
         QhSqcnxWqesu6P0H0Z4VE7Ltzyn0RasgmKoXp/eyC4GnaRn5k/nOb0a2lJGJQJQEVhb0
         ukR2FZWktiNea3FnOEQ569eU2wjFCzWMebNViAl5BRtHRm/Vp4YKkmnYqyChbHlPkCQV
         UPvTeqEU/KztVsTZ74idg/SggkrqF5DRMg0PNBRIMWCeIJt7EKnw1sim1QnQI2nfarro
         byGg==
X-Forwarded-Encrypted: i=1; AJvYcCXSnwOX2rgJ4q/EhmpkpK+MxNPJKFP1IvnfLXwb3Plq2hNBY29EYg94eW7mp6XshX1XATViiwKjgw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Q38eC0RDllINpHhHJM7yfCsjr6cnVnEdranjrLFSWzdOg9HX
	UU+gTBR7UyaxMT5L+jMJrTJejbnZNY03H+3LWWosW1B+CK5QOuPinu1plMVqiaSNmn3+FNO2CZW
	dwkjtZ689mh0aTRleXBT22q9nGFFHzB4=
X-Gm-Gg: ASbGncsfqd+3f3JHtBQL728fHQgZ1BMwrHydEpQx0rvgmkL5oPIcfV1Ucttazj43Dxp
	wzs9kDKjbKwBYpE+yyT0sVlsycsUY1vtY0Mcp+MptrD3LwrcEew5mA0GR2Op0VB083cH6udZcOU
	Apz/8FYMcXTK2noXQ8GkpnGyBVURT5m+GF5y2juv02V3g07qBORQxXq6s1DhL+GAjK+lMpRfzSV
	fm+mOqRgvppa4X3omlz+MqqD9m+aje8Kk+8DEfnS6wvM2jS6ErY0vDaW0TjzZR9a1MT2lBubLGF
	ZHmdJ6F4SASBqiTUG/bR1g==
X-Google-Smtp-Source: AGHT+IFpa62J3F001fD6gEmxASZM+7hprfmJdW+U2IPWM14bwbGqXpUXslnfVMopKEr/h/JVkCYbZZaxq7ZVg2GVzCI=
X-Received: by 2002:a05:690c:6085:b0:726:37ae:95a0 with SMTP id
 00721157ae682-77f947377dbmr63264647b3.47.1759527752486; Fri, 03 Oct 2025
 14:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003-mt8196-gpufreq-v6-0-76498ad61d9e@collabora.com>
 <20251003-mt8196-gpufreq-v6-7-76498ad61d9e@collabora.com> <CAPaKu7QWBShwr+YhFi+nUFo0kJ06k4PK3zggcCefWGjqUmTx5w@mail.gmail.com>
In-Reply-To: <CAPaKu7QWBShwr+YhFi+nUFo0kJ06k4PK3zggcCefWGjqUmTx5w@mail.gmail.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 3 Oct 2025 14:42:21 -0700
X-Gm-Features: AS18NWBXV7Dg7kjMsva2cG1ZX6ySiRudcCipxqw2a3pxKBvNUjFKzkOnT-TXcr4
Message-ID: <CAPaKu7SK=st9FkU+i25MOwBnBPQYpiBxS7-1nnerdBCiPnHy3A@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] pmdomain: mediatek: Add support for MFlexGraphics
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 2:41=E2=80=AFPM Chia-I Wu <olvaffe@gmail.com> wrote:
>
> On Fri, Oct 3, 2025 at 1:16=E2=80=AFPM Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com> wrote:
> >
> > Various MediaTek SoCs use GPU integration silicon named "MFlexGraphics"
> > by MediaTek. On the MT8196 and MT6991 SoCs, interacting with this
> > integration silicon is required to power on the GPU.
> >
> > This glue silicon is in the form of an embedded microcontroller running
> > special-purpose firmware, which autonomously adjusts clocks and
> > regulators.
> >
> > Implement a driver, modelled as a pmdomain driver with a
> > set_performance_state operation, to support these SoCs.
> I like this model a lot. Thanks!
>
> panthor might potentially need to interact with this driver beyond
> what pmdomain provides. I am thinking about querying
> GF_REG_SHADER_PRESENT. Not sure if we've heard back from the vendor.
> Have you considered moving this to drivers/soc/mediatek such that we
> can provide include/linux/mtk-mfg.h to panthor?
I meant to say include/linux/soc/mediatek/mtk-mfg.h.

