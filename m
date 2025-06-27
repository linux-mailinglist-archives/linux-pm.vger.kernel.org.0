Return-Path: <linux-pm+bounces-29666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1747AAEB835
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 14:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0381518997B2
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 12:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F102D8796;
	Fri, 27 Jun 2025 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zd/tD2VO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264162206A6;
	Fri, 27 Jun 2025 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751028843; cv=none; b=BlhX0YyrBTcZtPOL2OeQCz7yo+F7tEvuO1qWvodVEmwD+SaTP7YKuLKqzBuUh33NzoB3CYU2xu8qee0pnXH0y0y2EURC3XZmXoyxLsjv47F4gocJGXOUHeyZQ77oOo49jkDeaNY9sgqLKZtI22o8AfPaptq9nm7VsdEagdZRtVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751028843; c=relaxed/simple;
	bh=saqz6BlFQr0m4M/mU7Qnz/3rJIYjIiNg+AsFwW3PpIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7TTGB05vBGeEJQBR6y3X6S1jz3CFrF3416opl4lCQOy2ADHlRUOtEi/Ii6RjTA1yJM0GRYRxJd7UJCycx02301V8Zm7iO1e8qtefDIFCCI7ggPNuCrFbD5GfCmuqGal0BLxvjyx95dIsmTuajamrjf9RfzsqwvSyRujjYz20g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zd/tD2VO; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a77ea7ed49so33039131cf.0;
        Fri, 27 Jun 2025 05:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751028841; x=1751633641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0+gbguBFKXfSpjf/gN8iCO7iVT7YM1v5J/bh+qAGVa0=;
        b=Zd/tD2VOgI5gjyhQzR/9Te6fH7eFMp+dG8inZ8umO2nVVlthiu6Qbxqzgs2p1hx0N3
         vuXz3X4270w25HQm5Np3KkLdbKXnuZhKEF7SE5FGtIOiK10uGZX9l2lZ4/2fsvyWxdAZ
         QBBpWOu/laQGJPvOlCtKI15iQWBafAuSf30FKFFMHcEOB8Co34GB/F880w6lDU9+RTBx
         HR375q6MrS3M8ckT1xGsNrZq4qEbHK2Gghy36UNX7LK8Xgu4h1vRvi8ABQdtWhsZONMr
         PVgOdlwJLCuV1eOLkqX9fAzcCTKAPoyVVsz8rJdQufO2UHXNIO0gZyBdZMGbtfuBguQp
         YfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751028841; x=1751633641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+gbguBFKXfSpjf/gN8iCO7iVT7YM1v5J/bh+qAGVa0=;
        b=T0dMQFJ9k+3pha4rB8HvlrWfLreqrxED91UrLvYcIGwFhSoKZE1TWuwGuekPpNYGah
         e62Qu5OJ0MzhiulwK+Li7Cb3GTOLrnVupa5Z7cIrFNU8P4VMa9BzQk98BVfzw35fTckk
         NdU8hljcoZGhTAgYyamXi4QhRYH/6wwZbnc9Q2ksIsz1r2njVL/KEFBCZaBUA5E87Epa
         oAGMqwlu8rXyGBf5IEFeV0+GXLhtyCrAnTW2WymYIC7nNsVNbCkqkthyyQUKInLIRUCA
         qyaaj+gBJVNJRWogzc0/+/eZYY2yibTDKFTad0rSvronM1A3usaHUz8WiKVYr5/clfNd
         bF/w==
X-Forwarded-Encrypted: i=1; AJvYcCVCIILbF6EBuHIK0ZSnDJ3+UYx0mwfXM/ms6NNAeU3Zi/O+oszFbU/n1U8BN9gu7a4GEiztGqe+oqmqUIv7rp5bFA==@vger.kernel.org, AJvYcCWZX6iAh3jmxGIwaRejZFcac/M8fhQVHbdKmWOeKzuIYwuL26QwwJ4m0J6Riebl8cHEsxpCCX3ayJ0=@vger.kernel.org, AJvYcCWifSjKjfEXWUSe5epHcUCL/a4AM3qmFWM0BF/W/64wbY54aI/0zYfgzeeAiG5UWtXyiCQJbuWbaw11u84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnGOIiiVB3gbTuP7gj2HLjOWeh4rkEaXzwIB8o9AQTWfSFB6Zg
	RsQaVe+jYHOvLWw1Oq0AaG8O87BrfVDy6s+QYGHhB3RyYiPN49g2NVnn
X-Gm-Gg: ASbGncsJyTGq/ilwPf28i5VDQN6Jw90zkxJU2ijbOqGWwzLKdJ+IGwojC5e7dhgWtL+
	iQ3GGKMlh9s2f/+fwuYBtaw86cRargmEa/LupzSRyHAGEgcsgl2jwa1S0/ybod1D1F5WlTcocAd
	sJD3qOO3kqX98cFkv8OwgYN2cYm5JuKEie5GFavGYAuHL0QM7Equ+HbChfK7S7WIFy6IOpNJ7Qw
	hbU6lCJQTNN6R/xMS73LwMrzi673EAu5LC1/Q3WAMMM4FcAmQ3mzElUmu2g53iSMUeyAaMk0LHa
	D5uvqh/Y9lkFdQ3oscmjQaNdqQafNpkjnySoKfjLUFtEsiBgExQ4tCazBbys
X-Google-Smtp-Source: AGHT+IETveSWoXC/08GsXfLK3MH9fUuvjqdK0l7+CppsFqhkxU9gg79wiKfc6Glf1WTlwpf/BCm4jg==
X-Received: by 2002:a05:622a:4112:b0:494:7043:8a2 with SMTP id d75a77b69052e-4a7f2e86617mr128632811cf.16.1751028840824;
        Fri, 27 Jun 2025 05:54:00 -0700 (PDT)
Received: from hiagonb ([2804:1b3:a7c3:c88d:6da3:af6d:a237:3289])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc5a3b92sm11378121cf.76.2025.06.27.05.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 05:53:59 -0700 (PDT)
Date: Fri, 27 Jun 2025 09:53:53 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@oss.nxp.com>, daniel.baluta@nxp.com,
	iuliana.prodan@oss.nxp.com,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 0/3] remoteproc: imx_rproc: allow attaching to running
 core kicked by the bootloader
Message-ID: <20250627125353.2wuozc5in2ijnbi3@hiagonb>
References: <20250626215911.5992-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626215911.5992-1-hiagofranco@gmail.com>

On Thu, Jun 26, 2025 at 06:59:08PM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> This patch series depends on Ulf's patches that are currently under
> review, "pmdomain: Add generic ->sync_state() support to genpd" [1].
> Without them, this series is not going to work.
> 
> For the i.MX8X and i.MX8 family SoCs, currently when the remotecore is
> started by the bootloader and the M core and A core are in the same
> partition, the driver is not capable to detect the remote core and
> report the correct state of it.
> 
> This patch series implement a new function, dev_pm_genpd_is_on(), which
> returns the power status of a given power domain (M core power domains
> IMX_SC_R_M4_0_PID0 and IMX_SC_R_M4_0_MU_1A in this case). If it is
> already powered on, the driver will attach to it.
> 
> Finally, the imx_rproc_clk_enable() function was also changed to make it
> return before dev_clk_get() is called, as it currently generates an SCU
> fault reset if the remote core is already running and the kernel tries
> to enable the clock again. These changes are a follow up from a v1 sent
> to imx_rproc [2] and from a reported regression [3].
> 
> [1] https://lore.kernel.org/all/20250523134025.75130-1-ulf.hansson@linaro.org/
> [2] https://lore.kernel.org/lkml/20250423155131.101473-1-hiagofranco@gmail.com/
> [3] https://lore.kernel.org/lkml/20250404141713.ac2ntcsjsf7epdfa@hiago-nb/

Sorry I missed the reviewed by from Peng, I will be fixing this in the
next revision today.

Best regards,
Hiago.

> 
> v6:
> - Added "reviewed by" from Ulf and Bjorn.
> - Fixed and improved commit descriptions of patches 2 and 3.
> - Improved the comment inside imx_rproc.c file.
> v5:
> - https://lore.kernel.org/all/20250617193450.183889-1-hiagofranco@gmail.com/
> v4:
> - https://lore.kernel.org/lkml/20250602131906.25751-1-hiagofranco@gmail.com/
> v3:
> - https://lore.kernel.org/all/20250519171514.61974-1-hiagofranco@gmail.com/
> v2:
> - https://lore.kernel.org/lkml/20250507160056.11876-1-hiagofranco@gmail.com/
> v1:
> - https://lore.kernel.org/lkml/20250505154849.64889-1-hiagofranco@gmail.com/
> 
> Hiago De Franco (3):
>   pmdomain: core: introduce dev_pm_genpd_is_on()
>   remoteproc: imx_rproc: skip clock enable when M-core is managed by the
>     SCU
>   remoteproc: imx_rproc: detect and attach to pre-booted remote cores
> 
>  drivers/pmdomain/core.c        | 33 +++++++++++++++++++++++++++
>  drivers/remoteproc/imx_rproc.c | 41 ++++++++++++++++++++++++++++------
>  include/linux/pm_domain.h      |  6 +++++
>  3 files changed, 73 insertions(+), 7 deletions(-)
> 
> -- 
> 2.39.5
> 

