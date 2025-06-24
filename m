Return-Path: <linux-pm+bounces-29449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313DBAE6C39
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 18:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6915C7A9065
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 16:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0D52D660C;
	Tue, 24 Jun 2025 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bedy3yV8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891F42405EB;
	Tue, 24 Jun 2025 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781709; cv=none; b=HLx/4rPlQ7YQgq03oeZ+ltvk7oVqeZFDaWEOy3okzNbpwtCJM9h1ZsPbGrl3zIe/4uNfCiy9qT1x3vaI3mv4zFPrGefqRcR3HAiekHgTTrJQqXktLXnfGq20ByvQogNIu9RgPsjG/4bpPGArqnLYgmQU2+5JEyt8DUGTIUDwiYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781709; c=relaxed/simple;
	bh=lvGwQAAObMcMpnGSVKYiVQnRJ15AOjLbSCae8dPzrUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8StAmCtOIYqMmuLbaqRA5ef6GMQGhHJmLF9UCUXjlhr9lO8HP8LIWAZTR1vkphUbYy6yvPYqJDZ8zv/wd2so6xi6cyOqG/6mOL1XLjFqKvlxVt03SQic7976lIhR9clKLXQvokuj3E+gbOO56G1+Y2YynUj1ksE9/Ij6WyAKbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bedy3yV8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23602481460so7816575ad.0;
        Tue, 24 Jun 2025 09:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750781707; x=1751386507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NOFa14hzPvC6t+oIp0DexT1UxNfRS4Cl15Pgd6Dy9Oc=;
        b=bedy3yV8ASaKB6pPQpywKeazSqLRtPBDK1ZD257lN+Fy86jw7SEEM7lDAtRciw8ntj
         YaY/d83k4zy7Jabc/TSYaY7UZNBIu5SCmGclUvZoYXnczuNhadDf11oTW4VQz+xDtfQG
         q0fNgJYUx7/2AGp3gDIVr7GHeK/fnSOEAfFP32mQgijB1GKjjFfV3CkWwpdiVfadaLwJ
         5d/mdqXb++yDUUvfCbUjHF8N7b32DxvHlasJADgsQfoS1TSgx+Guf1+wRXBiM3KG1Vn6
         ceR4RPMRLaM/KrEwCW4ncw5KhOQNRX05JC4OQu060/8BPtDcdKnNUsRaUerTd2/oz+Bw
         q7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750781707; x=1751386507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOFa14hzPvC6t+oIp0DexT1UxNfRS4Cl15Pgd6Dy9Oc=;
        b=NHUhA0n9xsRy4pr3nLB6qPMaBtfG9gXZ2kAwdQV+X6DNO/p1NxWuefiTtHZQEnsDXP
         JjvA4Sshm+FzAOLBs9O1rjfDgPNmf91uNeaOwlhURnXzSqT02SB9fbYSKClrqKWCgTS7
         cM4FCISfP7me6EEwkegXAAZxt2OxhuYhAzyPUSkrStg0YV0d36GuA4xreJTmZvz90i6+
         keA9rWDC0Bnwo2tX8OrnXSaetYjnnH4HOwDeWX2xbz3yv2q3B5ODixcl7k4eamUNGsFG
         pFMk+UXdTw96+3RVDMAVRbFlvPQdGIDwujwU38blu1VxTxMjHyn4BDd9yfODHZFKYyqm
         e0Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUDOsEI/NagvGvFUeAZGBiyvtLgD+bWbLROPUAvjlh984HtkzLDo4EuwjessB6S88g6V9dxuHDxtfE=@vger.kernel.org, AJvYcCUwKSoY0HqV6YhtgMXRLakBmBa4NxQ+6Swa435h8sm5h1OF1VlMWYfCQFKc3x5F88Vvb2zzRUpJYz2YEA4=@vger.kernel.org, AJvYcCV7mY8J5LU/ivXHRX7FWxblj0v2S5ncq2sEtNJqxwv6iqY4dffV7u/KaGsJl/i1ft3il1yx6qkxLd4DiQPZRM+Igw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVH7CbR+574UC3fJb2VQVZXzSpJV0D8PpYFatCWmlc1lUwp/G/
	GJZcU2PqpkAKwFNSTKFbkkTdZim3pUY4izDTIFhKjlJrVN3AbPLxApXv
X-Gm-Gg: ASbGncupjfVMfz9qe5/LkWqHDvn/gmqLAQQSiPbwP9OUghXAz2akZAWf5WtNSEINjII
	LyFkTpP7Y0XNkYjZpcrtW2YWvwdIXG7XxOLPNtaIVU2w8vs0iN6UzTN9q2oV37e6blKDNYE9NUB
	zEiToDohcQhDRuelTcxZKvAxhROtphOp3rtlW5+EVwf6Pb7dgEdT/KL8zejxvz8wTuxS6reC7Rv
	ZsB+vsvbqHw0INUOMUylXP2xVvhfY54vbgHB59SrJ08+I+JJZrMgIhBlXlHzjYMWLGUDLVumoaO
	qyU9BYNZVBIoU7nbUURdiju+7E/ntxm3UAd0NUrq8tR4MF3uf6Rfo00Rjas=
X-Google-Smtp-Source: AGHT+IHG7rYkinFLRzsG4MwI6gkoEJZsqgBi83L3LCSzHE9voyWIDchNPTp5X+xH8/2vrw7ovBDS3g==
X-Received: by 2002:a17:902:f54f:b0:235:ea0d:ae23 with SMTP id d9443c01a7336-2381ddd180dmr3846685ad.6.1750781706256;
        Tue, 24 Jun 2025 09:15:06 -0700 (PDT)
Received: from hiagonb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d839618esm115515765ad.33.2025.06.24.09.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:15:05 -0700 (PDT)
Date: Tue, 24 Jun 2025 13:15:00 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@oss.nxp.com>, daniel.baluta@nxp.com,
	iuliana.prodan@oss.nxp.com,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v5 2/3] remoteproc: imx_rproc: skip clock enable when
 M-core is managed by the SCU
Message-ID: <20250624161500.odnopjv5jqvyyus2@hiagonb>
References: <20250617193450.183889-1-hiagofranco@gmail.com>
 <20250617193450.183889-3-hiagofranco@gmail.com>
 <aFlvqK6SHvWHIpMn@p14s>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFlvqK6SHvWHIpMn@p14s>

Hi Mathieu,

On Mon, Jun 23, 2025 at 09:15:52AM -0600, Mathieu Poirier wrote:
> Hi Hiago,
> 
> On Tue, Jun 17, 2025 at 04:34:49PM -0300, Hiago De Franco wrote:
> > From: Hiago De Franco <hiago.franco@toradex.com>
> > 
> > For the i.MX8X and i.MX8 family SoCs, when the M-core is powered up
> > by the bootloader, M-core and Linux are in same SCFW (System Controller
> > Firmware) partition, so linux has permission to control M-core.
> 
> Ok
> 
> > 
> > But when M-core is started, the SCFW will automatically enable the clock
> 
> I find the "But when M-core is started" part confusing.  Started by who?  And
> are you making a distinction between "powered up" and "started"?  It is not
> possible for someone that doesn't have HW documentation to understand what is
> going on.

Ok, understood, I will improve this in the next revision. Just to make
clear, I am talking about Cortex-A bootloader starting Cortex-M (U-Boot
bootaux command in this case). This means powered up, started and
running.

> 
> > and configure the rate, and any users that want to enable the clock will
> > get error 'LOCKED' from SCFW. So current imx_rproc.c probe function
> > fails because clk_prepare_enable also fails. With that, the M-core power
> > domain is powered off when it is still running, causing a SCU (System
> > Controller Unit) fault reset, and the system restarts.
> > 
> > To address the issue, ignore handling the clk for i.MX8X and i.MX8 M-core,
> > because SCFW will automatically enable and configure the clock.
> > 
> > Suggested-by: Peng Fan <peng.fan@nxp.com>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> > ---
> > v4 -> v5:
> >  - Unchanged.
> > v3 -> v4:
> >  - Unchanged.
> > v2 -> v3:
> >  - Unchanged.
> > v1 -> v2:
> >  - Commit description updated, as suggested. Fixed Peng Fan email.
> > ---
> >  drivers/remoteproc/imx_rproc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> > index 74299af1d7f1..627e57a88db2 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -1029,8 +1029,8 @@ static int imx_rproc_clk_enable(struct imx_rproc *priv)
> >  	struct device *dev = priv->dev;
> >  	int ret;
> >  
> > -	/* Remote core is not under control of Linux */
> > -	if (dcfg->method == IMX_RPROC_NONE)
> > +	/* Remote core is not under control of Linux or it is managed by SCU API */
> > +	if (dcfg->method == IMX_RPROC_NONE || dcfg->method == IMX_RPROC_SCU_API)
> >  		return 0;
> >  
> >  	priv->clk = devm_clk_get(dev, NULL);
> > -- 
> > 2.39.5
> > 

