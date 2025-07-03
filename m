Return-Path: <linux-pm+bounces-30075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD3CAF7E23
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 18:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF9554714F
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 16:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C4325A2C4;
	Thu,  3 Jul 2025 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i5Yu8J3w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AA7259CA8
	for <linux-pm@vger.kernel.org>; Thu,  3 Jul 2025 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561107; cv=none; b=GMDzwhf+6HAQHNjhNdZnTL7bLZFP19cXdUbDkJdFbDQSCOVNu7iTd0vA6ygng/1tU2Xt0/3q/zYci41eCV7RCGGf7YXInJmEIwDYyqlLoPYaKLes3AK20YMm3JqXPbNiqQ3BPF2KnEPCcUum9tRrEboFN8v9EtVnJ6IFQ1cJQOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561107; c=relaxed/simple;
	bh=K5enpRuic32S4oE82qU4ccV1Rqy8bsY8TPalBVIEb0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbEV6+JMbDgSkTKJvw/jmNUoNWmSY90olgxR8SXTrv9+2s3Nr7gn1as8LXmSfhZhT840czBwqXuBAMyvIM1uOPgt+1vcU4WCgxQnSSQeGUaBXgviF87LiNCr4meh0IGDZ31OAw9ZcnJ63vnJ8y9ryr8Gvf6+0XH/4VOD++Zaq+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i5Yu8J3w; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74ce477af25so5015b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 03 Jul 2025 09:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751561105; x=1752165905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GBHUELeShaDsr042UH3FpVBn+V9zul7LrFKtD883WnM=;
        b=i5Yu8J3wzXULnJx3FXlB7x3si55J68bodqvJ9NW1Tc/yblnglSWpz4cgD7GeCdlllw
         rpsKaIZCp4XH6S9fjzSpVjBs1hRuoPykhuPdW8TaZgN3EEol6zKMY82M60JrERF25+OY
         vBlwDmbs6GnyI6RHX59FYbQoRL6DcsEENq5t71jQtgSWHwBrIYxHgBWVAxOguP7g0nqs
         /sXPzFiT2R18w51LrjBC9NwmQ325E0gic2s3MsoSl1sfoDg9V32GE+KFiPkD/5dgv6IA
         toZKselUEtNF1WTpgZHi9RwgpqXMx1qBiw3UPsNUOZEJR5MJnjcaCY56t4JZ/hzg130y
         0E8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751561105; x=1752165905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBHUELeShaDsr042UH3FpVBn+V9zul7LrFKtD883WnM=;
        b=X4T0J0DAzVi4LGw247L7M9L1oy9oidDqlECY9gak25XvOVdU7ZE9vKbIglVmc4CS8G
         qgkHiqaFq47y0+L3opbPzP2EEnJKGjfsVDlK2dQZ9pjp7QcaU4aneadR3zjXb4ZiGICW
         g8Jlg/XVPOHDVXxpJ6QquBtp/jKu+mtzdg0S1GUn3etmgWAki16OObUPFK0ezF1aA00b
         Oo3Xj1hGVMmoeM+jQpph883wu19lb9qnVdNk+8+qH3NU4WTYG8VmqCObEY7i872hAYMX
         dz1FeSltbn4EJmF9J4tSEr2gJvthOQdWnh9t3a8HNHdaIeTZo7Gv/b9LHlaI0fpmfjAb
         QM8A==
X-Forwarded-Encrypted: i=1; AJvYcCXtGaQXkHQ3Hs/ITTjtGcpmYFkrqTyF8pxnAIKDfn2tXj+eIt0D0Tzs/ElssvOaGO4G1KCXFDVb0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyFj8S0a8LVijlt/fjXGY9+4EksBkGYRYx5HM/edcw22R2R/PO
	yXumbZFWCxfwng+d8PYpR0EkD+v4BPMSDs5wqe39yzEFa/W+Tql0KDeRSyUAOtn47AU=
X-Gm-Gg: ASbGncuKqX+TlxsP69gjniytsOih4yadrY7KitXhiErmxH5UGkULKriFe9ODZitVr1z
	5+QyG/I+km0DJn0GEW0WZUzTO0m7lfCViWpPvt2AqtvVGMXo5Ni5e4gzN4npU82TBmRgdNPSG5e
	aes1njThAQSS7q4E9Y+6nvhDqK13rUDfoep80rgJmRJaMYfh9TwV8ubMn5uA0W/8kYJhj38ocvo
	5vJCVOPCbMEKmDqjZZniszk3NKLolNUk92z4jgKH+FARQ11L/nM32M+NQlaZlKGjbjBo+KhR/2Y
	B2EFW2AagTOMuTXqh5nZFLjncoCKMfBKJ8gZNbCbBcna+27sZ6kmAulNmLC9j5TO
X-Google-Smtp-Source: AGHT+IHypldJuULZ325ar/a9F5r+ljoB/YMqxQ3fIIAWryPfaK7GDkJ6OJPyeHAhWYcOOLtHPwQMtA==
X-Received: by 2002:a05:6a21:339a:b0:220:8b24:ab97 with SMTP id adf61e73a8af0-22409d1b38cmr5899440637.16.1751561105008;
        Thu, 03 Jul 2025 09:45:05 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:5ee3:4bef:2dc:d1f7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee749366sm74601a12.74.2025.07.03.09.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 09:45:04 -0700 (PDT)
Date: Thu, 3 Jul 2025 10:45:01 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@oss.nxp.com>, daniel.baluta@nxp.com,
	iuliana.prodan@oss.nxp.com,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v7 0/3] remoteproc: imx_rproc: allow attaching to running
 core kicked by the bootloader
Message-ID: <aGazjaJQXl03HUJE@p14s>
References: <20250629172512.14857-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629172512.14857-1-hiagofranco@gmail.com>

Hi Hiago,

Many thanks for re-working the changelog and comments in this patchset, things
are much clearer now.  

Thanks,
Mathieu

On Sun, Jun 29, 2025 at 02:25:09PM -0300, Hiago De Franco wrote:
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
> 
> v7:
> - Added Peng reviewed-by.
> v6:
> - https://lore.kernel.org/all/20250626215911.5992-1-hiagofranco@gmail.com/
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

