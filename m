Return-Path: <linux-pm+bounces-28795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0CBADAB88
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 11:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2E6188EF74
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 09:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10510270EAB;
	Mon, 16 Jun 2025 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QeTLjma9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488BD27056B
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750065047; cv=none; b=Q5qGw/ZcApMoVf/0Z/fx1HwiFwKguDVXjwy+vFOTTID1Iny+4pPmXrpEZ9ttlGgQOYPZlwc1JveogXLU8DSbe7TnDUqpwnxteA4/4DqZXF4VxVdl1VJip3vg49iR5lcznXymY6mhtl5GWSPamYJiBDaFf/h+KxMoXcKvLcCmaHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750065047; c=relaxed/simple;
	bh=SwWEvDaGj1H3eOVuukiaSaEPHd7lZiuo8sRHZvD7nY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbQ7/TGYJHJEIqnaHt/JTkWivuxnUtxs5LTwyWFJVYPCKPHv+vZbrk7BYacZrzTlmiZT3TFcSw/340ixfeuBAjBvJuQLrXZKNL9mTYcb32NFeGaGBNCCwyuBUVFFtK6U1M5zHr84gd8vy3+12+rcmxhuAgfzySQJO26JppX4HSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QeTLjma9; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55394ee39dfso4144324e87.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 02:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750065043; x=1750669843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmDMMMFI5G4DNwFWGn674MZ5D9eFoURbFcL3QvAF4Ig=;
        b=QeTLjma9gn5dGBch89jyBaqcj8KgX5NiNqQwcHs8G5cvaw06cb9bZkpJ8STzi5kSdG
         JVW2+7wpHPSn9w3hB2AJyf6wuSExYzSMtGO6o/1p7yfcJi6KsbnvPa40Xcu2H7UtlUE/
         29K7pR9ROGGDBVW74OXhCtAGTtk7EQ0PX8/NDFD9QUWP0vZiZtCXC2d75gNELPwxmXbh
         YQxJeSXNTnEEkYDS+wNgOYfV2rteAbB0sAo3rHdv2pCU0jIX57QIjCDT6rFyxnzVrh4I
         VaebVZgyoM4Q7ngwBnV0le0DQ7NbZvVeTyFnEWCMxhQ8I7xbMVl0rlYfNH8/jVwTqQcY
         jhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750065043; x=1750669843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmDMMMFI5G4DNwFWGn674MZ5D9eFoURbFcL3QvAF4Ig=;
        b=rD7Nb7bitSk0mA3Xfy+lkQTo9Rspy3RXci92sJL2fQ+VccGtCH58S/V3cEvt1u8aAs
         CGkdyvz5m2pbOgOVQrB+uUdlveRyi4DmHPJYkNUZrQH/EzKBRiqqIxMyvKt+m157wY7m
         uieYuDKGBEZpuL9BPEj3TSZEqOkbsM6U5QeKBdozFLAPlNeeC5qcSGT6GNWHITLglbEr
         4qTJjm+ZZ1FdPnxV3/zkvOTxscrRC1m2dfmOfxlAe75sVQX7denapYgVBXFEbSVNJBnR
         ++2X2C7ca6g94e2ttJ13puNlge36Y/l5QnvXrD5ERIxO5x5h7BTJpqnDZs5uXf4aC3AB
         6r2g==
X-Forwarded-Encrypted: i=1; AJvYcCVF63CjayiCQtJom3bcxV3Fu/0lw3+kt7WM7uej3l2h2BfYb13F2VHAlWMjL037yApCPxV+/wTL5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0dq14IlRm8kLLb6eMxW6Cl01/bsffhfw5ajJT0mOgY4w+hc8o
	xE1OFVpYc/4trZeXTTrcqHhX8e378bS5v2hM6IcxfWQc/+ag8EFacZlBdw6D1CIPclaHtkbxo9U
	NYCTCMn9ljmkp3ShSQcSsXy4nC7eBY9G29fqEWcLxig==
X-Gm-Gg: ASbGncsuIRvsC9HDFM/HUvSfz7rs03hH8HFR47omklFcn5HdDB3ijjPv39MwO8BJ8is
	zxE8fMVjr4XrmTeAW+cyjP4PBGEn1bH6u3vXHjrmounlef23OMzpEakDjjRpTotD3Y9gVX/H2z7
	xjCjLg0qLr7b0fDfxndQLYzk0pADgt2X8X2ENYn10Vn9xpd5rfYs7YYJVkxSuM8JpOwCPFpfxRy
	O4=
X-Google-Smtp-Source: AGHT+IHuGL7ppu54TT/M3Hxiz/E57PX/ijwwJDHxeHuWrcclls/KmfWg30WiaNhrMMlcrNDHFrl4pCAUL311IM7bJx0=
X-Received: by 2002:a05:6512:1053:b0:553:29cc:c49c with SMTP id
 2adb3069b0e04-553b6810d6bmr2008050e87.7.1750065043405; Mon, 16 Jun 2025
 02:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250614180909eucas1p2a34e3242fb42f7fd25e4038c291276ff@eucas1p2.samsung.com>
 <20250614-apr_14_for_sending-v4-0-8e3945c819cd@samsung.com> <20250614-apr_14_for_sending-v4-3-8e3945c819cd@samsung.com>
In-Reply-To: <20250614-apr_14_for_sending-v4-3-8e3945c819cd@samsung.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 16 Jun 2025 11:10:31 +0200
X-Gm-Features: AX0GCFundfu1_DbYfr4amG4ZmgyhqyYCcYsn5RbDrpDylY7Och28dfv5wtCxrQQ
Message-ID: <CAMRc=MdrvZ0_3aWcmhYZP4CxOVbuYjL66iLPHKkDt=vCP7VN-Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] pmdomain: thead: Instantiate GPU power sequencer
 via auxiliary bus
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 8:09=E2=80=AFPM Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
>
> In order to support the complex power sequencing required by the TH1520
> GPU, the AON power domain driver must be responsible for initiating the
> corresponding sequencer driver. This functionality is specific to
> platforms where the GPU power sequencing hardware is controlled by the
> AON block.
>
> Extend the AON power domain driver to check for the presence of the
> "gpu-clkgen" reset in its own device tree node.
>
> If the property is found, create and register a new auxiliary device.
> This device acts as a proxy that allows the dedicated `pwrseq-thead-gpu`
> auxiliary driver to bind and take control of the sequencing logic.
>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---

[snip]

> +
> +static int th1520_pd_pwrseq_gpu_init(struct device *dev)
> +{
> +       struct auxiliary_device *adev;
> +       int ret;
> +
> +       /*
> +        * Correctly check only for the property's existence in the DT no=
de.
> +        * We don't need to get/claim the reset here; that is the job of
> +        * the auxiliary driver that we are about to spawn.
> +        */
> +       if (of_property_match_string(dev->of_node, "reset-names",
> +                                    "gpu-clkgen") < 0)

If you use device_property_match_string() here, you don't need to pull
in of.h. It's typically preferred to use the top-level abstraction
unless not possible.

[snip]

Thanks,
Bartosz

