Return-Path: <linux-pm+bounces-29672-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077E5AEBA57
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 16:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2198817C2E4
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 14:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123D72E7625;
	Fri, 27 Jun 2025 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2mmMnI6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA4927F00F;
	Fri, 27 Jun 2025 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035806; cv=none; b=Yvc9jOj6BUkKZsovOCHcFCWU8praUBHdy42qwfYBDQKfzTnAN0pe/H1UgcC/N8z9uuXwx5lZyIOT5w6pNzG9EK3QdvQ6OAtjs06fhE4PZCRmQMin6wwkEJWOG+ifX+iAZi/4yDrX7SAtTy/EAvqlnl9LQv+BYQxbJs5Qu8r+Qmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035806; c=relaxed/simple;
	bh=azHHeXfhNZdcGMpuROaZijRlH/fb/S19enbMkZXA6PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfG2TPNc621klyrQn1W9GsE7/Kg9ayvNleraTKbPSX4AUwZkRUvadkXbufYv4PLFEhwPEkXkjWc2zHvV8Eupk6CUbOlZ3t3OWYbX56JpL5H5PVrNi+HLy4laYcwi1sVbFyztFX2fKZJWjS+WssCIMvjj1+zCg0XQIGIR5DqrAtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2mmMnI6; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d3900f90f6so218915485a.1;
        Fri, 27 Jun 2025 07:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751035802; x=1751640602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S6PoA3nqPOfL5m3FPUgvFlM9WYiufmmjsQSygs6h2ec=;
        b=P2mmMnI6vJ8W08M0GPE8jJyo2ywOG/xwhU1779DmiYJW2pBizx2po8YeFTo6Wpid3D
         85CGG6EGo232KgEUwua8pZEuEaGgAei834JUkx1WtqpgUYxJaF8YB2kCro/wkLEY1tT/
         J2P7ZCO81l05P0IXmY5lw9kQjSH3fGjXMc0uOD2QKahYKSvWd35kwDysQfo45SfoEwAu
         h1jUo7n+eN/i5bCnKMdJejLeAupvtjZ0j6mldmKtndPzt5/c6AODR0LGi4/PcYc7NZGO
         EtPPvYqofpNXPIS0KAR3vt3XmEAbH6v/j5tGDtzsbIEtqtlnercxNwLPI3/orqw07l0t
         APfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751035802; x=1751640602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6PoA3nqPOfL5m3FPUgvFlM9WYiufmmjsQSygs6h2ec=;
        b=GOHkkspK6k5uJq3F84ZZA4w7TOWnbqjB9io7wEDJec9p1XOEtxKDp3EifPzLe5pszi
         b/Bv5DxVlCBRjkYXoLzujC/UmWFqHaVTzrPyUkvcBJ1F1q0L4Ph4BAEhWc4CyIo2yEY5
         a/8qFwNzE2OL3LxWPlZ+dwnUIFbrhszYHPFrNx2LJoC12Vd1+VXd9Qd1Ze5USYrtkPe/
         Y0qKpQYEgPdy2zBgLEdcc49jL8Tpuee8+GAP3MBtyNGqvQk173Cg4+V9xtN5kxWUR9+x
         saRyvhVSTVvcp6Pfd2tfVu9rh98mnl56GYVPqXPsXUUXm263NqgkpoZX5wI3DEIDka2U
         iWaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+/3dvDTwpR3RP/MNXhCLj5lblM0jUqTCDDTG1GFtT/owfOgkN4Avq083m0OZ3iYCqyHANuU3X4VYhsys=@vger.kernel.org, AJvYcCWI3fMZhJGFELGajqN9UBXIdYawJLiwYNFPv61WdejfNFw+pnI2J9PjMNcJ+qrnNoDvWoiqUsPFEN0=@vger.kernel.org, AJvYcCXqJESJ58Z7PiLr70d6h2zG2aR3WO918d2Q2HWCjUP+pYvSfMBnXh6KM9ZcEAAJkE91B0KAee9PQYyqM2Vx/+nx3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+yevIDL5i1r1HdsFxz2ihi+WcRmwb/5sSE1uWtxH/ygca079R
	2r817JZM21k9pLALHArdYpHvDqB4yTSOQjkeM7gor5twmPIAMb8+HOJv
X-Gm-Gg: ASbGnctCu0ecETjSjbmMwRRBnQs2z/aDnaQSMZ1BXwAW4u4BfoA6eCmYqUMGTyHZgNb
	E4PIzcTNmW9g8sQpclgGiFPtJKdUi8N5tmW7QVpiDPSal0Iu9USCDHWE3OLZONfSR4M/sJIP3Ii
	09XOCm+ebE1R9JeBSKMZ4XhwwxDb0zn0z8kMnJeWggZnclu1BLll5ZhN7whnfIHqFdXxGyDINMq
	Y70jIV7Eqn1NcWHxCKWq+ZpherBC33ZlREKQ8+3/r4ChWQ2o4LpR514+dN2pTgozNLrcO7t3VBA
	3e1oPKX1cB4YgoWuMqPMl9gJe/fmJSCBJX8qD89YN5w50oGVTD/+tfC3E8Dn
X-Google-Smtp-Source: AGHT+IFbou1xMk6JMnADPBUd4fd5n/7zRvglAq2fEyrggZQzPKVtz6a6tLxCnjDbX4s4r2fLBp1xBA==
X-Received: by 2002:a05:620a:38e:b0:7d3:b5ff:fb22 with SMTP id af79cd13be357-7d443994d26mr429693385a.32.1751035802120;
        Fri, 27 Jun 2025 07:50:02 -0700 (PDT)
Received: from hiagonb ([2804:1b3:a7c3:c88d:6da3:af6d:a237:3289])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44321a706sm139134585a.81.2025.06.27.07.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 07:50:01 -0700 (PDT)
Date: Fri, 27 Jun 2025 11:49:55 -0300
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
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 0/3] remoteproc: imx_rproc: allow attaching to running
 core kicked by the bootloader
Message-ID: <20250627144955.tbmk6ako3rgv3djo@hiagonb>
References: <20250626215911.5992-1-hiagofranco@gmail.com>
 <CANLsYkzo32BHkxRzSLY1U_PcidMPOaz7xZjDs8HKtTCQ0ZpF=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkzo32BHkxRzSLY1U_PcidMPOaz7xZjDs8HKtTCQ0ZpF=g@mail.gmail.com>

On Fri, Jun 27, 2025 at 08:31:20AM -0600, Mathieu Poirier wrote:
> On Thu, 26 Jun 2025 at 15:59, Hiago De Franco <hiagofranco@gmail.com> wrote:
> >
> > From: Hiago De Franco <hiago.franco@toradex.com>
> >
> > This patch series depends on Ulf's patches that are currently under
> > review, "pmdomain: Add generic ->sync_state() support to genpd" [1].
> > Without them, this series is not going to work.
> >
> 
> I thought we agreed to repost when the feature referred to above and
> the work in drivers/pmdomain/core.c will be merge.  I'm not sure what
> to do with this patchset.

Sorry Mathieu, my goal was to update the whole patch series with your
reviews from v5 so you could take a look and then I would resend
everything again once the others have been merged.

If you prefer I can wait for the other patches to be merged and then
send the next v7 corrected.

Best regards,
Hiago.

> 
> > For the i.MX8X and i.MX8 family SoCs, currently when the remotecore is
> > started by the bootloader and the M core and A core are in the same
> > partition, the driver is not capable to detect the remote core and
> > report the correct state of it.
> >
> > This patch series implement a new function, dev_pm_genpd_is_on(), which
> > returns the power status of a given power domain (M core power domains
> > IMX_SC_R_M4_0_PID0 and IMX_SC_R_M4_0_MU_1A in this case). If it is
> > already powered on, the driver will attach to it.
> >
> > Finally, the imx_rproc_clk_enable() function was also changed to make it
> > return before dev_clk_get() is called, as it currently generates an SCU
> > fault reset if the remote core is already running and the kernel tries
> > to enable the clock again. These changes are a follow up from a v1 sent
> > to imx_rproc [2] and from a reported regression [3].
> >
> > [1] https://lore.kernel.org/all/20250523134025.75130-1-ulf.hansson@linaro.org/
> > [2] https://lore.kernel.org/lkml/20250423155131.101473-1-hiagofranco@gmail.com/
> > [3] https://lore.kernel.org/lkml/20250404141713.ac2ntcsjsf7epdfa@hiago-nb/
> >
> > v6:
> > - Added "reviewed by" from Ulf and Bjorn.
> > - Fixed and improved commit descriptions of patches 2 and 3.
> > - Improved the comment inside imx_rproc.c file.
> > v5:
> > - https://lore.kernel.org/all/20250617193450.183889-1-hiagofranco@gmail.com/
> > v4:
> > - https://lore.kernel.org/lkml/20250602131906.25751-1-hiagofranco@gmail.com/
> > v3:
> > - https://lore.kernel.org/all/20250519171514.61974-1-hiagofranco@gmail.com/
> > v2:
> > - https://lore.kernel.org/lkml/20250507160056.11876-1-hiagofranco@gmail.com/
> > v1:
> > - https://lore.kernel.org/lkml/20250505154849.64889-1-hiagofranco@gmail.com/
> >
> > Hiago De Franco (3):
> >   pmdomain: core: introduce dev_pm_genpd_is_on()
> >   remoteproc: imx_rproc: skip clock enable when M-core is managed by the
> >     SCU
> >   remoteproc: imx_rproc: detect and attach to pre-booted remote cores
> >
> >  drivers/pmdomain/core.c        | 33 +++++++++++++++++++++++++++
> >  drivers/remoteproc/imx_rproc.c | 41 ++++++++++++++++++++++++++++------
> >  include/linux/pm_domain.h      |  6 +++++
> >  3 files changed, 73 insertions(+), 7 deletions(-)
> >
> > --
> > 2.39.5
> >

