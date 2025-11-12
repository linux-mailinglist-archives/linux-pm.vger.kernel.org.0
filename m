Return-Path: <linux-pm+bounces-37846-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C25E9C5311B
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 16:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7FCB5402C5
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0889934DB6A;
	Wed, 12 Nov 2025 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CkseN0T6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576B133AD96
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959650; cv=none; b=nTkTeBv+tD3s04Mp2s7ipNvMP8q+iWQee9yo4vBBwEB7auPJ9Rv4Wa8lSEntlgrN1eXOEf056QGapFLj+jxmc/NfhYOMOeGwgbTH2LaVl1iRkzyHa1hWFHU+np4Z1tx9OEP++NMrZL5fga5sYcHX56mnxVd/ucqIQGtFW7Mtcw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959650; c=relaxed/simple;
	bh=6nRufZYMmMPdekb2l3DMopXSyHBxvFoDBeGjeLuuf3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twqFvc0BUv53o7KdDNrfFDyEBiBMrFRyC/mzbthvIinDrhtcZjrcsRVjMfOez1N09BYg7WnoMiGxG/KetWfCA/tuKq6WQamU/qrKmrxUic3FWkeVLfl2MFU+o2tLDDPys6zEWgp58vrxdyvLTIawDRKD1eQwwM2LedwwElEES7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CkseN0T6; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37a2dcc52aeso8783051fa.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 07:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762959647; x=1763564447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJYkmTTA8zJtnbxM6NWrgFrNZ52Y7C1R8o6kZvano1w=;
        b=CkseN0T6wByGPn3Hkvz9zZE8oL65XyzNFZ2x/b6gLQbRLuEwfGTPfl0H8O6xYoxJYA
         DPbtQCpeF+foRUu/o8fXjvV+OwpzLscFWlFXG5Hco2dJeTc2rAgUkeCetWjKTwGBXVcL
         jD/2qO8yRkfWbBFs2u/F5KoTrdfXzj8VhGaOGgk+QQYtGf9CySu5H26GPwc/QyWoT59P
         I0Ygw8tQ5kWneyPkmwTiHPV8QpJLCyyMXGJ0fBTF0L/D4lEoBadYIMsk4GT5+fUgMAYy
         O1NY8FT6ctAsrLUazJ/K+nJuJAMul4ttetAF+xKE1WiW8dXUqTdWPZ8bRxv+cEX04/B4
         jodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959647; x=1763564447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MJYkmTTA8zJtnbxM6NWrgFrNZ52Y7C1R8o6kZvano1w=;
        b=EcjWRiJ/yNGZytgCTSa/EcK5JEdSjvSIBhqj2k7bwGLb9HRty9c2IPcRm1WLVvGlsD
         1UM3FUL7qgfjnsrWj08vCoBtzOiUiZfJP9LJH8mEuOsf6h7wcmecn5reViUG4pZlUD09
         vOVmjpZCEbd2khKJNsS8XEQ3N18mL+SO8V7tFD8xr0vplgSHmYrgdyncfXmVydcHmo8n
         uiIKqF+DdNZLbn7C1rE337up4fa39H8K+7xD96kZJh/qFADkYSLirX949H4m1vSuiTZ+
         t68l721xcJXFBxZ8SWKu4mEfXI1TYdWq5qGvRWcDW0ydyX6hAwpUnjkGUAzlmm1vagH9
         l8dA==
X-Forwarded-Encrypted: i=1; AJvYcCWHN1D0zbElOxUG9HMT4cPxFeY/1zTN6LFlPLbyLGX/ZOL3pHSaE+L9qksWOSBysQn1yHP0Xe1WdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAIu1GoPnbf87kuyL3V1jX6kQdb1TqUPRYAW2lqSj15XynlXJ5
	wyck06l4rxFFoOLpVrtNNgJ6OgectOV6snYwNSNBA4z/em+6x1GVXRoucR2jakEdPZF9wnrsT6O
	xxtjavk0fJPmb79cbWPkl5Zi85HGBM9Z6yZBpyZTwXQ==
X-Gm-Gg: ASbGncsGY6eDlXKSlfws2GNE7v+ZsSIGqo1XZya3GZuInms3fjAgaivs1Rw0ks+G5EA
	byKvbipqazAUJ+Cu/3Qs4ma6ephjNxVuT/NM+e5EyBHngU4j3l4DU4lJ/FUtzMfDSdn1VrE/mZ2
	2fK/eVwb/WLxBStRuFZAAB6vpx2AaBeqUxzMRKaL4E5el0fyLFvjWsPBX5He0HL9KgSP8C4EMA2
	uaLH2wRa2xCA6h2qYeGC4wPCqj376EK/Rw1XtIAey3yGZMsc/b9MPkFbO3v2MF1iaQym5u5tRBp
	pfq5S/UKYLv6
X-Google-Smtp-Source: AGHT+IF/0lzxcENopPd7uz7maIwHNsxTmjPcBJfKsoF4Ymi/nL3fpwtDvaukn2F5jX9CEPwtr5hReZRpIgz3sULtVdE=
X-Received: by 2002:a05:651c:41d5:b0:37a:45b0:4654 with SMTP id
 38308e7fff4ca-37b8c440e36mr9499951fa.39.1762959647449; Wed, 12 Nov 2025
 07:00:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com> <20251108-pci-m2-v2-3-e8bc4d7bf42d@oss.qualcomm.com>
In-Reply-To: <20251108-pci-m2-v2-3-e8bc4d7bf42d@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Nov 2025 16:00:34 +0100
X-Gm-Features: AWmQ_bnRDrKZUl3b2_L2xXcxEgtoJqMJ2M2YBAmLBys8sYtSb3rTkaUH3Raiodk
Message-ID: <CAMRc=Md_4r74hFZ52WZxmsYchELv0B3uDzDsY1BDwGFJ=G02CA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] PCI/pwrctrl: Create pwrctrl device if the graph
 port is found
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 4:23=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
>
> The devicetree node of the PCIe Root Port/Slot could have the graph port
> to link the PCIe M.2 connector node. Since the M.2 connectors are modelle=
d
> as Power Sequencing devices, they need to be controlled by the pwrctrl
> driver as like the Root Port/Slot supplies.
>
> Hence, create the pwrctrl device if the graph port is found in the node.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  drivers/pci/probe.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index c83e75a0ec1263298aeac7f84bcf5513b003496c..9c8669e2fe72d7edbc2898d60=
ffdda5fc769d6f5 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -9,6 +9,7 @@
>  #include <linux/init.h>
>  #include <linux/pci.h>
>  #include <linux/msi.h>
> +#include <linux/of_graph.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> @@ -2555,7 +2556,7 @@ static struct platform_device *pci_pwrctrl_create_d=
evice(struct pci_bus *bus, in
>          * not. This is decided based on at least one of the power suppli=
es
>          * being defined in the devicetree node of the device.
>          */
> -       if (!of_pci_supply_present(np)) {
> +       if (!of_pci_supply_present(np) && !of_graph_is_present(np)) {
>                 pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name)=
;
>                 goto err_put_of_node;
>         }
>
> --
> 2.48.1
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

