Return-Path: <linux-pm+bounces-9596-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63A390F15A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 16:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73BCC28A9CE
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 14:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA5420DE8;
	Wed, 19 Jun 2024 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifaID5j0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C421CF9B;
	Wed, 19 Jun 2024 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808853; cv=none; b=SbtCF9mbxFlzfiP6u1r6mrny8OSY+JWl8bxEwdmo13g002nhz0HPFScwFQSrGBX9ZThxzzhRhbLczXKl0nWtKvspJkHy7iE+KgzwnTdDw18g3lCPgnP0oojP5aL4CMNT+2pSnlTzXDFiGbiY5/qPIDSVAWCtC6SVDaypj0C2PcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808853; c=relaxed/simple;
	bh=XbXaUpzEm8QjQUNcIf8lan5DUpHIQJlQli0eGY0V0CQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btWGtafo/YSRkeYruOBcxmMXC3bssla6cjkGatnikfW8tQ0fGd0Yp+jic5MWh27msAgPCGH9wEmawwaY/c8DrXeZwmYBxwEFrtsW9sSOopcfvj+KybdRpKtwDPvaAMqo/FMsrFdLKdiZvF/XoCIPOfLMO+CAItJ+ReK5i4D+ReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifaID5j0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58822C2BBFC;
	Wed, 19 Jun 2024 14:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718808853;
	bh=XbXaUpzEm8QjQUNcIf8lan5DUpHIQJlQli0eGY0V0CQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ifaID5j03Lxbk4BssybtHY/cbVCNlzvfVSNGrkHXnIXg1qqLnHQLJg146B9NSvkm9
	 lYJHquRF/Yoc5rh7VDvIM0j9evxI1ArN2Y9zdk1KmgWbmImB3sonqKRNVsBerEpLRu
	 sFPX/7zwoHCodXKqj8rVH+dFMa6KX4UM6GQOfLQ4wjoijwNgJCcHu+bt5qo0zdmAiw
	 xmzwVVM54fHRQYL3Ovy8mYWw/fGAz6mFO2jJMN9gZbDUHtddzPj84dGcoBNHX67Ut7
	 RMFsDu/JDcx2UKjtZlGR3VuqRLq+rFbkUQOcoS1lPKQiWGe0F2WOacnsV7hFOoCQoQ
	 YP1yZl+P1dV9A==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5c1b75d6bebso53765eaf.2;
        Wed, 19 Jun 2024 07:54:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdjL6+oSdpo2bsNK+u6xI8mYX0zEcPodWGyM8w0bsj3YRObySAPo2UoD6Y+d7xflHGdCxQxHC2bS3tpBvmQDB+A/wb3HEXdhEfLKC3eRePgmubljfMVPDrT//3toB5TOv0vJzt/n86jD+gZjUV2rCQiLJnoISJs1fnow5ZLv4=
X-Gm-Message-State: AOJu0Yy8eOFdZ+oIzJ1HfyrdIdxhSxMVwkqScpD38biKxoPxQVCa1J6S
	MDpxjVw7egCyK1xpRvCeH+69tnIEoz8iDGG7lPxpLB08+bFv5PWO1O//zdRKsLgx+qYsSJuM02d
	sTxeEFI3xoHOo8Yu4h0CGEVdVnOY=
X-Google-Smtp-Source: AGHT+IHG8OXygjQcxoiDOtJORBPBrNq/rJhVkj9CFI+xoel0iARyBn85fHD6SQOJOnsTsfshf8zH/srcJj1MamwhPR4=
X-Received: by 2002:a05:6820:162c:b0:5ba:ca86:a025 with SMTP id
 006d021491bc7-5c1ad88a98fmr3763859eaf.0.1718808852691; Wed, 19 Jun 2024
 07:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619044424.481239-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20240619044424.481239-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 19 Jun 2024 16:54:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gncg-jUqeQG3hPgi5c+uQmmQqvwLSwp8H7j2kw08zzZg@mail.gmail.com>
Message-ID: <CAJZ5v0gncg-jUqeQG3hPgi5c+uQmmQqvwLSwp8H7j2kw08zzZg@mail.gmail.com>
Subject: Re: [PATCH] thermal: int340x: processor_thermal: Support shared interrupts
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 6:44=E2=80=AFAM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On some systems the processor thermal device interrupt is shared with
> other PCI devices. In this case return IRQ_NONE from the interrupt
> handler when the interrupt is not for the processor thermal device.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Fixes: f0658708e863 ("thermal: int340x: processor_thermal: Use non MSI in=
terrupts by default")
> Cc: <stable@vger.kernel.org> # v6.7+
> ---
> This was only observed on a non production system. So not urgent.
>
>  .../intel/int340x_thermal/processor_thermal_device_pci.c       | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_p=
ci.c
> index 14e34eabc419..4a1bfebb1b8e 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> @@ -150,7 +150,7 @@ static irqreturn_t proc_thermal_irq_handler(int irq, =
void *devid)
>  {
>         struct proc_thermal_pci *pci_info =3D devid;
>         struct proc_thermal_device *proc_priv;
> -       int ret =3D IRQ_HANDLED;
> +       int ret =3D IRQ_NONE;
>         u32 status;
>
>         proc_priv =3D pci_info->proc_priv;
> @@ -175,6 +175,7 @@ static irqreturn_t proc_thermal_irq_handler(int irq, =
void *devid)
>                 /* Disable enable interrupt flag */
>                 proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_E=
NABLE_0, 0);
>                 pkg_thermal_schedule_work(&pci_info->work);
> +               ret =3D IRQ_HANDLED;
>         }
>
>         pci_write_config_byte(pci_info->pdev, 0xdc, 0x01);
> --

Applied as 6.10-rc material, thanks!

