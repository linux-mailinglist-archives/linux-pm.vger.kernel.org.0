Return-Path: <linux-pm+bounces-40448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A37D03BC6
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 16:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0B713019DC2
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 15:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA72B4BDEBC;
	Thu,  8 Jan 2026 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy5+++A8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A904BDE8E
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874527; cv=none; b=txACAzLFKtNA+4uyqQL931ew9EgQle9FQ1PhrMaegrWEIU4SUrxwaWmlWKuCeW6ShdIYgOzf2seWwTMPZqy/j4KihJ0zttQUTcs+EkPXMf3NZ2fqTFOLyMlhJz1poNlqfPVhTkkZw87nW+1fcgVkIg06fupdTSosKZufP3nSByg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874527; c=relaxed/simple;
	bh=oN3VJ81TR92t72IorUOGx+yYKZ6zgxZk9xFRV4q/Jvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPD8L17Ccf7qUycGM9mIQv8krT5wY+E4008AExuwIQKWUzhsXm7xT3APxpcZdnFeXwHCAwBwHcyGzCUKWH0SIijRuiBlJhbouIiRTNqHbYI40vQrA2fcac+OXCHSqYID/Ul5w/H/qsnBU+5mmXfDh9PXPCABqvJOV6kuGTyuvAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy5+++A8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49810C2BC9E
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 12:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767874527;
	bh=oN3VJ81TR92t72IorUOGx+yYKZ6zgxZk9xFRV4q/Jvs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iy5+++A86Sd4Opbng5Cpq18bXVkT5o3GMVfzsGGk+tSkDWzJntj1FB6j6rsTmvDV7
	 htk5tpeZs7QIUTy1l81V0iwHwd+ld3bzRnlSLulPMLJgS5+BHEXo2cQsyv09Gs87c1
	 6U6WuD9E4fHh9FTyCDiwOvTsfJCfMABaKvIEh/hxlznf66fal6a5ELJKAz+QYDHowm
	 RSYmfVWwSOTYlMrwmhNGfnhOg87uRQ2rCIdg4Z746axEcP2smmEWDVmqa/Kjm2JKzd
	 cTRPrW2m084iD5VJcJnB63d5nGR5SkqGE+jzjgNUCjYJgR3S/74C1Exn+71ksFN4o/
	 YNS2z15g0sydA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59b6d5bd575so2287338e87.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 04:15:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUONdDXjverSLPUHLYEzAHs2/4b3crWSITSzBTveTGHDQ1Q43nG2g2OjaHPCBUTvWJYKUhM36P37A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywks+fOvWtEJjjqHIB0sGIhW0oManfvXfkWBKoI+lDzTG/qyj1X
	B9GxkzvUZvN7H8GrI+sz8MF3mbBIuWJAgbVdZoaRryH4jzH73llzzVxEk6caRYYDIJfZr+fvjit
	Z4yIjMiaCG1Spx1G1UkRen24Hcjtd2MdBvikA4cHrCg==
X-Google-Smtp-Source: AGHT+IF/4koG/MN6sfNsURUrtRSXZrXyRHd0bqi6p5mzExxZBo2GY4yvcJpb3YE7lL2MK6UqIWbaGQBDGlnCB4B6bas=
X-Received: by 2002:a05:6512:68f:b0:594:35c4:fed1 with SMTP id
 2adb3069b0e04-59b6ef03a2dmr1813240e87.13.1767874525775; Thu, 08 Jan 2026
 04:15:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com> <20260107-pci-m2-v5-5-8173d8a72641@oss.qualcomm.com>
In-Reply-To: <20260107-pci-m2-v5-5-8173d8a72641@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 8 Jan 2026 13:15:12 +0100
X-Gmail-Original-Message-ID: <CAMRc=Md9TQiSX-gFa5q--JgaGyQ2ky4mOwjSpdxHhvHAj-X5Qw@mail.gmail.com>
X-Gm-Features: AQt7F2puNlVWjbhiRoX8QQnOlbAAs4UdjLNY6ZTbm-vEXEFSeur6kT9w8kO5QSk
Message-ID: <CAMRc=Md9TQiSX-gFa5q--JgaGyQ2ky4mOwjSpdxHhvHAj-X5Qw@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] power: sequencing: Add the Power Sequencing driver
 for the PCIe M.2 connectors
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 3:11=E2=80=AFPM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> This driver is used to control the PCIe M.2 connectors of different
> Mechanical Keys attached to the host machines and supporting different
> interfaces like PCIe/SATA, USB/UART etc...
>
> Currently, this driver supports only the Mechanical Key M connectors with
> PCIe interface. The driver also only supports driving the mandatory 3.3v
> and optional 1.8v power supplies. The optional signals of the Key M
> connectors are not currently supported.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>

This looks good to me, though there are some nits I may fix when applying.

I'll pick it up for v7.0 once the bindings are reviewed.

> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com=
>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_graph.h>
> +#include <linux/of_platform.h>

It looks like this is a leftover from previous versions and you no
longer need it?

> +
> +static void pwrseq_pcie_free_resources(void *data)
> +{
> +       struct pwrseq_pcie_m2_ctx *ctx =3D data;
> +
> +       regulator_bulk_free(ctx->num_vregs, ctx->regs);
> +}

I would call it pwrseq_pcie_m2_free_regulators() if you don't mind.

Bart

