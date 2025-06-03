Return-Path: <linux-pm+bounces-28027-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1F3ACC8FC
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 16:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192CA1886222
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 14:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D102356CF;
	Tue,  3 Jun 2025 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQClKZgk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63388224B1F;
	Tue,  3 Jun 2025 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748960523; cv=none; b=sjvl4gfPb0iZikGxCxdnL7A7CAcG/4SFUZME1yjc+q1VD6athVFxvHYx++FURHmYpYncgdrzSY/qq9Jy10i7il3PHlpjh7sZH88ox33KufmUGGyIsuECY/bRuxTiqzhsCDmeBeeaMoMX/D/YZXPNdCoD+5tTen6Ba67SBGKhoqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748960523; c=relaxed/simple;
	bh=LJ+KewoxG7r/WeJ8eTGCl/7+HpY8ip3l8VhsVeTJHSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZg7jz6C6DwfrSPU/8LPb/3ZAkzkvrUAPXk/Tdx5LtWShMK+b/g82+hcendxZX8cG73il5rHJFWHPJ/UXc4th/eb4HFemLucN57qgHZyR77OZA7P4BmTa9LXfYf13oLS29wy33g5c+Q3sY5zPmWJTVyrECj49qgZ2YjEIP9KgDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQClKZgk; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-735a9e65471so3388089a34.1;
        Tue, 03 Jun 2025 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748960520; x=1749565320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2uRLCXdLzb4exE9EX3UwPPfJOF++R02ZMsB9cLfhyoQ=;
        b=gQClKZgk0Y3k+ag9usG7dTK++Q9jOvl3+FJCP8DsG3pX3jTD7VuwUxi+ZzhDW0pX1o
         mlxrHkmSyWWIqBYde1E+w6ohRdjfTb7cy4aVXjRv4ckOa1tC14qroxeHprEkdtfDZyDE
         miHa57J3r4OtdUZod7o39BoT+qiXcCoHP9AKuTIGP1k4ZHU012ULhPIp/5zZSZhFu9h0
         pMl0TgzImQPZ6DsTJgq8XsvfViAsRnHGmu4Dmmt9yLIIjJvXSvTyZGN5fW1HVicBqf3F
         lhrV4fTMTcDrSEYbWyXFYUCLOGNq3XMOMXhjgq13/eBQ2v1p8hoBqUD407z5U/hBjNsA
         4lDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748960520; x=1749565320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uRLCXdLzb4exE9EX3UwPPfJOF++R02ZMsB9cLfhyoQ=;
        b=cwiPJHVY1bA5b+X/YP8A+gJ4ycHY3dv6e9PBTtgvR2K+fiYuy6kdGxCk5C3jjSFZaz
         4cL0pK9uK0fUUH1GrbliLWeS7BAyhmIB6yiWhwPO/5eDjc/I++kxuykWrgnlR9eSgyJD
         jr2bKHlRA6iuJ3G6GQ2mkSVuIga/oGSTIH8wPu42KaXbCVJI+x/1dJA2ETdBfwvCoiAm
         jb8ysMU9DnyAapZguwbFCcWbQWd9WNo00NiHqaMYr+Nys1M5UccR7l9fpqKymom2/DZM
         4/0hNsLijnmZUH5ioURNATj3IXLQgoGsTmHZnFFzU+J2gUCeOXdWu6SAHY9FwPF+5wmV
         t/GA==
X-Forwarded-Encrypted: i=1; AJvYcCUgo6apmjTt+Cwtq6hjYdEUT+tSPVfbe3FG0YVh8v2B2eHS/k57qRPyUE1CywkY4bRenQx6ZmvoN7s=@vger.kernel.org, AJvYcCW6Hks5cBQfOfyPGvcwoU2Xz/5oqzNKKq75PVr8kf6zeRGFfgylqRr6thDGO6lialt/IDvuGBB+FNNo4Y8=@vger.kernel.org, AJvYcCWe/Tgxr5DW8z+Ey/b/HdrNoDGm6UnmbkCvWCpuvv0oLJQItePZ9rxGQbfafAvyNz0A2ytAhKfWTgEsJ47RLXmrQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeClDd137jYMolK45EbUhFxjH2dbq8kt0UAxK2LHqd712LdWoa
	s2cZunHX1x43ZS+2gx2v7ENKzRjcUEAi74RWAmioDE4+RqCDK/fpyA/S
X-Gm-Gg: ASbGncvLbPNxu7p8glgSx55G8vNzIXxJGKvHvOddwMg4lqjnVX3qjQBFWqjZZ96F+25
	pX/IIQ6lkH9OrmzXXBYDcX7o5O6COfqlFI+P6kjJEi+/BFSL0jhPc81gBoQmBxWmWyi2vHA4nKS
	R62K85O83riGjOH/ElBYle6ujc7vvPVULOPR/HQZ/nPVkxenxvkQ1hGjTQwQBJOehw7Ra+OfkJX
	MT+DhfVRzm1CUiSxnFgnqyRWC5Iqm9fozzeCWCNZ9NTKaOPPz9BA/9cH0enUoNmoEdp/Ze7I0VK
	ZbR9tJyoFLt9+cLJno0B/WZUMSr2UXB8xxsXckMbcs3jsiAidZAcZzCXs6EK
X-Google-Smtp-Source: AGHT+IFkCT6KXDiNwC9LZ8x7mvQVq5dsUSOwWeNt5tI1w1w2MQsYARI+9tl0cuB6j+Q1q13EXmEjPQ==
X-Received: by 2002:a05:6830:6687:b0:72b:94d8:9466 with SMTP id 46e09a7af769-73676b969aemr12031524a34.28.1748960520043;
        Tue, 03 Jun 2025 07:22:00 -0700 (PDT)
Received: from hiago-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87e2a38f77dsm7670028241.22.2025.06.03.07.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 07:21:59 -0700 (PDT)
Date: Tue, 3 Jun 2025 11:21:54 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@oss.nxp.com>, daniel.baluta@nxp.com,
	iuliana.prodan@oss.nxp.com,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 0/3] remoteproc: imx_rproc: allow attaching to running
 core kicked by the bootloader
Message-ID: <20250603142154.6xa3q7gd3kxk4kxo@hiago-nb>
References: <20250602131906.25751-1-hiagofranco@gmail.com>
 <CAPDyKFrUAF5oWkyc3mLf0+R9VAypBotNyR4B5Chr3KQFYJOjbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrUAF5oWkyc3mLf0+R9VAypBotNyR4B5Chr3KQFYJOjbw@mail.gmail.com>

On Tue, Jun 03, 2025 at 02:09:14PM +0200, Ulf Hansson wrote:
> On Mon, 2 Jun 2025 at 15:19, Hiago De Franco <hiagofranco@gmail.com> wrote:
> >
> > From: Hiago De Franco <hiago.franco@toradex.com>
> >
> > This patch series depends on Ulf's patches that are currently under review,
> > "pmdomain: Add generic ->sync_state() support to genpd" [1]. Without them,
> > this series is not going to work.
> >
> > For the i.MX8X and i.MX8 family SoCs, currently when the remotecore is
> > started by the bootloader and the M core and A core are in the same
> > partition, the driver is not capable to detect the remote core and
> > report the correct state of it.
> >
> > This patch series implement a new function, dev_pm_genpd_is_on(), which
> > returns the power status of a given power domain (M core power domains
> > IMX_SC_R_M4_0_PID0 and IMX_SC_R_M4_0_MU_1A in this case). If it is already
> > powered on, the driver will attach to it.
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
> > v4:
> > - dev_pm_genpd_is_on() introduced to drivers/pmdomain/core.c
> > - imx_rproc.c updated to use the generic power domains instead of the
> >   SCU API call, which depends on Ulf's patch series.
> >
> > v3:
> > - https://lore.kernel.org/all/20250519171514.61974-1-hiagofranco@gmail.com/
> >
> > v2:
> > - https://lore.kernel.org/lkml/20250507160056.11876-1-hiagofranco@gmail.com/
> >
> > v1:
> > - https://lore.kernel.org/lkml/20250505154849.64889-1-hiagofranco@gmail.com/
> >
> > Hiago De Franco (3):
> >   pmdomain: core: introduce dev_pm_genpd_is_on
> >   remoteproc: imx_rproc: skip clock enable when M-core is managed by the
> >     SCU
> >   remoteproc: imx_rproc: detect and attach to pre-booted remote cores
> >
> >  drivers/pmdomain/core.c        | 27 +++++++++++++++++++++++++++
> >  drivers/remoteproc/imx_rproc.c | 33 ++++++++++++++++++++++++++-------
> >  include/linux/pm_domain.h      |  6 ++++++
> >  3 files changed, 59 insertions(+), 7 deletions(-)
> >
> 
> We are awaiting further feedback on the other series [1]. As you have
> tested it, may I add your tested-by tag for it? Or perhaps if you can
> send a reply to the cover-letter for it?
> 
> Anyway, for $subject series:
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Sure, I replied there with my Tested-by. Thanks for the review.

> 
> Kind regards
> Uffe
> 

Best Regards,
Hiago.

