Return-Path: <linux-pm+bounces-23981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0D8A5F63E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 14:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8AF61889AD3
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 13:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5B92676E1;
	Thu, 13 Mar 2025 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n2AgJNyB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE011FBCBF
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873599; cv=none; b=ZrrqgJMkqeyCWGSzFBnjvdf2RHJ1odevFj/kmG0vpY9MRqSa2ubcpAvp0UkQ6FccJZiJ2MirLp68Qn8Vou/LDjLJTCZyQn5lPLeYjG5n8mAdF8hOBKnzc0ABUdiIhj0WNYjx/ZCNiJbJwpFPWe+4Tg6LVPMv7MnNPf9kH7ysKLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873599; c=relaxed/simple;
	bh=ujEBQPB0scKMY7JC/wQHlyV+8N9T4tQgeMBzcI+87rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJFDw9c6QzOp2c3UXQUtycAK2JPIWQe1sDXb+j3Gb3ZZEi/3ZWk2lfwXevXj2aCWVw78C6qefgNGdYZblbkPhNfsxGFjFzRO7isx9gwMNRxg9N0i5iFM9VJKyWlWs4Ah1qD0bDH+nMwavck+jtPqeQA8Nlqa7vjBMh2GAHK1als=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n2AgJNyB; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6f7031ea11cso9986717b3.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 06:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741873597; x=1742478397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3pruppk4STwGuRQ4gOsQ41gA9jN4GcpyPa2+9qAli4c=;
        b=n2AgJNyBVwyOuZoofwzLpO4Vj+DoBCE6dhY4hwSivLC7kT5aEE5XhIFNZqh1ZI/OwK
         FDoTQYtPq+OxQ730rr90Plyu+/7e6e6BPhlG9xjkT4kjjYr2BTYIACzppWrzwvODO6ig
         qCgHKaHPbALQrjn6Pnp2nJBZA3+xq/p2vu/Bg0aOGtFVqQxIwyaBVWDcUFaAt0Qu/cqF
         6KoOEqMW+NJ+GvehsUGCz0OKvDD8OK5V615TrlaYaMwKygRJupoCuZJVdNpkzTbH/O8+
         yctT5UyhpHS+Dnb8egHP34q2kW8PvtfmuFppCmog3xXJk0IYE1fWHiYfRi8zem5CEP5E
         cpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741873597; x=1742478397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pruppk4STwGuRQ4gOsQ41gA9jN4GcpyPa2+9qAli4c=;
        b=wt9wsO7zwTCm2YnURlsN66psnfMYsQbLol6WucQn0gADUYelkKP8zhQLvyPrLiL5T5
         YAUNdJ+DnGSaYt4HtfpDpwvS3KxFepGSo46EO+vdIRzEu+6wEzkZ8L3wuIkuCjt8bERR
         31NB16AJBtDK/R/Q/84mk4QbaivTXpc1ZGIPUN+cR8XgQVRKlu6Gz+IvoTUt7ZyUh7DB
         KZDdCnF/cII9gCfn0KoAypOiYY/PfzE+L0E2M+RyyHDSHD14Nj8st+luj19mk7OP6iby
         8VSWlqqsg55aorUtUkZr6g4dXlZ2I37+WScFyX6M8olKaOUk5khMe8+EGYw0L+kjylZA
         IX9w==
X-Forwarded-Encrypted: i=1; AJvYcCX6j4Mmq7Z6Mm3/EzBuR8Wm4kGKlR52nbjZJ+WUHeeAAA8nk5LK0LbnUUTDEzK0y3mndJX33kthUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSWAUMNfb0GhZQhT7ux5/MqxwNzI4i601BLqcqK8w5OC90I3G3
	l9aEJDk4Bfj7RWMpamKLNVoUs2SS1aGxywA4+jNp+HUse2hybsqVTOuL9I811uicxGg4LbjTv1C
	XpuwBSrPSKcubYMt7+7XdMtJ2CnU2OORT4JP+qw==
X-Gm-Gg: ASbGncv5jtaagggjQZVVs17VaNVZx2VUeofPoKODJPBl+twZ9pUQgDwH1TcIyw+HA27
	TzqFq1QSp5FovacAMxz0QRrSjtsMTWN40xFvmAEvDVSyN1G80bepjOlQWomrJ/DnCGrn2fIiTSp
	EZMSPCa7RYBydgaIyMrh9h6ytT870=
X-Google-Smtp-Source: AGHT+IG7vBn4URXM8J2dFID1L7Pg4fVMsep6yAv6gvLGLKB/Q06ncJU71pTeAeJFVFPXcY3eqoO5qEZ7cJRZ/u07cAs=
X-Received: by 2002:a81:fe0a:0:b0:6fe:bf9c:8e7a with SMTP id
 00721157ae682-6febf9c9506mr280796267b3.0.1741873596783; Thu, 13 Mar 2025
 06:46:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250311172030eucas1p12dda42760f751174e774b8d1a3d3f4cd@eucas1p1.samsung.com>
 <20250311171900.1549916-1-m.wilczynski@samsung.com> <Z9KPvig0dPRO0cX1@x1>
In-Reply-To: <Z9KPvig0dPRO0cX1@x1>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 13 Mar 2025 14:46:01 +0100
X-Gm-Features: AQ5f1Jr2C0RzgSrdaklEVa_RV8h0CZizF651FuL4N37mJLMsiwagGMmTnahMvkg
Message-ID: <CAPDyKFrCFURcTpwZnx4bs71Kw_JrRKLiuDh7954xD2k+rCDN_A@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] TH1520 SoC: Add AON firmware & power-domain support
To: Michal Wilczynski <m.wilczynski@samsung.com>, Drew Fustini <drew@pdp7.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, jszhang@kernel.org, 
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Mar 2025 at 08:56, Drew Fustini <drew@pdp7.com> wrote:
>
> On Tue, Mar 11, 2025 at 06:18:55PM +0100, Michal Wilczynski wrote:
> > This patch series introduces and documents power management (PM) support and
> > the AON firmware driver for the T-Head TH1520 SoC, as used on the LicheePi 4A
> > board. While part of a larger effort to enable the Imagination BXM-4-64 GPU
> > upstream, these patches can merge independently.
> >
> > Bigger series cover letter:
> > https://lore.kernel.org/all/20250219140239.1378758-1-m.wilczynski@samsung.com/
> >
> > This series is versioned to maintain continuity with the bigger patchset it is
> > a subseries of. Please find below a changelog for the AON & power-domain:
> >
> > v8:
> > - add proper cleanup in the th1520_pd_probe()
> > - add "suppress_bind_attrs = true", since there is no need to unbound the driver
> >   during runtime. This simplifies the code by eliminating the remove function
> >
> > v7:
> > - add '#include <linux/slab.h", due to kernel robot issue
> >
> > v6:
> > - split the firmware & power-domain patches into a separate series
> >
> > v5:
> > - changed the AON driver to be a set of library functions rather than a
> >   standalone driver
> >
> > v4:
> > - added workaround to disable AUDIO power domain to prevent firmware crashes
> >
> > v3:
> >  - consolidated device tree representation by merging aon and power-domain nodes
> >    while maintaining separate drivers internally
> >  - power-domain driver is now instantiated from within the aon driver
> >  - fixed optional module dependencies in Kconfig
> >  - added kernel-doc comments for all exported functions
> >  - implemented th1520_aon_remove() to properly clean up mailbox channel
> >    resources
> >
> > v2:
> >  - introduced a new firmware driver to manage power-related operations.
> >  - rewrote the power-domain driver to function alongside the firmware driver.
> >    These nodes in the device tree lack direct address spaces, despite
> >    representing HW blocks. Control is achieved via firmware protocol messages
> >    transmitted through a mailbox to the E902 core.
> >  - added new dt-bindings for power and firmware nodes.
> >  - ran dtbs_check and dt_binding_check to ensure compliance.
> >
> > Michal Wilczynski (5):
> >   dt-bindings: firmware: thead,th1520: Add support for firmware node
> >   firmware: thead: Add AON firmware protocol driver
> >   dt-bindings: power: Add TH1520 SoC power domains
> >   pmdomain: thead: Add power-domain driver for TH1520
> >   riscv: Enable PM_GENERIC_DOMAINS for T-Head SoCs
> >
> >  .../bindings/firmware/thead,th1520-aon.yaml   |  53 ++++
> >  MAINTAINERS                                   |   5 +
> >  arch/riscv/Kconfig.socs                       |   1 +
> >  drivers/firmware/Kconfig                      |   9 +
> >  drivers/firmware/Makefile                     |   1 +
> >  drivers/firmware/thead,th1520-aon.c           | 248 ++++++++++++++++++
> >  drivers/pmdomain/Kconfig                      |   1 +
> >  drivers/pmdomain/Makefile                     |   1 +
> >  drivers/pmdomain/thead/Kconfig                |  12 +
> >  drivers/pmdomain/thead/Makefile               |   2 +
> >  drivers/pmdomain/thead/th1520-pm-domains.c    | 218 +++++++++++++++
> >  .../dt-bindings/power/thead,th1520-power.h    |  19 ++
> >  .../linux/firmware/thead/thead,th1520-aon.h   | 200 ++++++++++++++
> >  13 files changed, 770 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
> >  create mode 100644 drivers/firmware/thead,th1520-aon.c
> >  create mode 100644 drivers/pmdomain/thead/Kconfig
> >  create mode 100644 drivers/pmdomain/thead/Makefile
> >  create mode 100644 drivers/pmdomain/thead/th1520-pm-domains.c
> >  create mode 100644 include/dt-bindings/power/thead,th1520-power.h
> >  create mode 100644 include/linux/firmware/thead/thead,th1520-aon.h
> >
> > --
> > 2.34.1
>
> For the series:
>
> Acked-by: Drew Fustini <drew@pdp7.com>

Okay, patch 1 -> patch 4 applied for next, thanks!

I am leaving patch5 for now.

Kind regards
Uffe

