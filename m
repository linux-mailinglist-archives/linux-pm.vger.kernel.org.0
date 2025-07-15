Return-Path: <linux-pm+bounces-30873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CA0B06323
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 17:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F3418998C5
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 15:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455D81FA178;
	Tue, 15 Jul 2025 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQ7wW0d2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4112566
	for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2025 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593875; cv=none; b=lANqFgRIUQFfiWipGIW7Ku+WXd/lLjdc1BiVuMX4qgkzyfciPq5tH17o4hovPexabXNJSuPZAeXLs+YkVy9qIbsZHNT37jn1om6aiADu9D+HAPaQIT16my7aAGiwHvfsDXoNRFzd6MYU4gga+R9A2MWo7HG7qHvZMnwzfB2m0no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593875; c=relaxed/simple;
	bh=MNjWM8Z0QuCnshVnQ1bsNB+5oVUx8sdzUpPC+lIh8FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3+Kf4D3jfu87Z4lh7ug/SFLUnphdu+JNwypj2k5o03xoAwRHQduhi+6EJP9RFnhhdLfJIhEyykpWoA/EcAbK9N5LEDIir3aGAPXaqw2rrhXcosMsxtWVhn0bsLCXRNf0Z4a266L1Z2MqF3iVLmKQAtIGMSBPD4HyDoWxgk8/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XQ7wW0d2; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c7a52e97so4622013b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2025 08:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752593873; x=1753198673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FzNEH5LOAV7uVf2fuNEUyq4fxGqo7XGg0gkJqBbGqwk=;
        b=XQ7wW0d2v+neIPi0veYQojVA7KkWBWU9Awufi7ABVD1y83PBYucam/qmACaAyfrvn9
         Ga0bHG3ypDJqdEvT7i9OaNvt7WZRUAOzZHSL4Fqhbnf4m/fxbXsrP1StAA84LU6EDulq
         F+JGKwgHvp60VWhvFvDbGjuM1q6MWnyU40d4sE7k8J4s0hSBVQTE8U3c6O/YEcfXzBXS
         LuT8juLJzyl4Z4Yw6JOqImqP+1hjcThkyM8EhVr5U+05qq47GDHTcLIO69xB2Rsx3cPV
         t0fKygRAP9p8psm2EQjwumfgpa1cF1QB4qnYJIPNB5g24bZJTappwJ9ec7fLWqiy4HM3
         fgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752593873; x=1753198673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzNEH5LOAV7uVf2fuNEUyq4fxGqo7XGg0gkJqBbGqwk=;
        b=F3ha/8ua8RTsd7wVvR2Feqq+L2ow9/xcct4FcGEhqt53HBXm0Prfinq/4DOzfbQGHL
         EiGvXfl4ZY6hvP40DzhSGFhOFLV1jae7c171rLfYIOkvPxDlF0VfRozUfpT85E5bDAW5
         qM53QhBj5N3KBTS4XFs5HwqgqVstBEt2C8rwAGyDZzaZw/Pt4Ec+2oH5/d/h2dhsXBFN
         K0Ectw1Xrp9phNsieWVGw/8OC8vJOIyqLT93lT/sDSo23M8FMe4CIVwKJ8nqD0aqfRzs
         V4m139cin06TfiOSpRjvWTJZXfQV0gko58gjtl0e68uBFbxOvujqOwSR53R1/n+0dfZ3
         W+LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQMgpulo5F6DbLE9Kriji3tFq5zqfCamgmYQJZX73PtCYrEGZOVC8s8c7XnGpT0Et0aW+4X4x6qw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMke5mK3nwqrP1jemhCWI63e1T89rqMhg0Jn2Jht+roDVw77WV
	4AriDB0ewGDNKfAS/A9fTxIaJgirsz4S3l5dZV9IkTHqQta1Je7Nf1pRExVOHGOJVnU=
X-Gm-Gg: ASbGncvIbBY+bN7AUaxHD697RaIXl65Im30+tkCxPgBaD7dHzfKTLN7Ke0+Cbw6MEbz
	YRx+bEGD9UUT8xSlSkKBumJRX7mZ5ZkFlzBYaI+tQ5sK3Uw8+/liTBH9zcv/1fONH9dKMCiaxdJ
	N2DLSJs/Vo/WEoomOyShp+awd8qfe4QaHbb4ZWgKGPSAkxje5sQK233FvNW975PwpvkHZ+RKPRV
	fbObtQs/yNMVKEIoDuFGCIoN9P8XMO3k5dquLOYgskK3iyZoTQqDywOHL3xShQ3FgwzbgVzxalD
	u++PoRs1k4fG0CMih3GaFKw+SXQhqUnX6L59p3vJElXiTzFFTDxp10PyVKVvR8ExYzybBnuMWdM
	kHSYYZp+jS0xpnZJJdBM/gIYS
X-Google-Smtp-Source: AGHT+IGfUd3Wq8tKCUsCK6+tRCHhWda76Q4+cIiZSoc97uhXtJTnyEkJT/SdNOXKgCueM3T97WS1Aw==
X-Received: by 2002:aa7:8887:0:b0:74d:247f:fae4 with SMTP id d2e1a72fcca58-74ee0bb5748mr26983642b3a.4.1752593872779;
        Tue, 15 Jul 2025 08:37:52 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:3f17:6d67:cf82:708])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd605dsm12780538b3a.18.2025.07.15.08.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 08:37:52 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:37:49 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hiago De Franco <hiagofranco@gmail.com>, linux-pm@vger.kernel.org,
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
Message-ID: <aHZ1zRiAuX2PVYcU@p14s>
References: <20250629172512.14857-1-hiagofranco@gmail.com>
 <aGazjaJQXl03HUJE@p14s>
 <CAPDyKFpUF+S8EqVsHct7TFZGupq71Bu7eL3t2Sr=ibhZ518nsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpUF+S8EqVsHct7TFZGupq71Bu7eL3t2Sr=ibhZ518nsQ@mail.gmail.com>

Hi,

On Tue, Jul 15, 2025 at 01:49:42PM +0200, Ulf Hansson wrote:
> Hi Mathieu,
> 
> On Thu, 3 Jul 2025 at 18:45, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> >
> > Hi Hiago,
> >
> > Many thanks for re-working the changelog and comments in this patchset, things
> > are much clearer now.
> >
> > Thanks,
> > Mathieu
> >
> > On Sun, Jun 29, 2025 at 02:25:09PM -0300, Hiago De Franco wrote:
> > > From: Hiago De Franco <hiago.franco@toradex.com>
> > >
> > > This patch series depends on Ulf's patches that are currently under
> > > review, "pmdomain: Add generic ->sync_state() support to genpd" [1].
> > > Without them, this series is not going to work.
> 
> The series above have been queued for v6.17 in my pmdomain tree.
> 
> Do I have your ack to pick $subject series via my pmdomain tree for
> v6.17 too or do you think it's better to postpone to v6.18?
> 

I may have spotted an error condition that is not handled properly in 3/3 of
this series.  Given that we are already at rc6, it is probably better to way
for the next cycle.

Thanks for sheperding this work.

> Kind regards
> Uffe
> 
> > >
> > > For the i.MX8X and i.MX8 family SoCs, currently when the remotecore is
> > > started by the bootloader and the M core and A core are in the same
> > > partition, the driver is not capable to detect the remote core and
> > > report the correct state of it.
> > >
> > > This patch series implement a new function, dev_pm_genpd_is_on(), which
> > > returns the power status of a given power domain (M core power domains
> > > IMX_SC_R_M4_0_PID0 and IMX_SC_R_M4_0_MU_1A in this case). If it is
> > > already powered on, the driver will attach to it.
> > >
> > > Finally, the imx_rproc_clk_enable() function was also changed to make it
> > > return before dev_clk_get() is called, as it currently generates an SCU
> > > fault reset if the remote core is already running and the kernel tries
> > > to enable the clock again. These changes are a follow up from a v1 sent
> > > to imx_rproc [2] and from a reported regression [3].
> > >
> > > [1] https://lore.kernel.org/all/20250523134025.75130-1-ulf.hansson@linaro.org/
> > > [2] https://lore.kernel.org/lkml/20250423155131.101473-1-hiagofranco@gmail.com/
> > > [3] https://lore.kernel.org/lkml/20250404141713.ac2ntcsjsf7epdfa@hiago-nb/
> > >
> > > v7:
> > > - Added Peng reviewed-by.
> > > v6:
> > > - https://lore.kernel.org/all/20250626215911.5992-1-hiagofranco@gmail.com/
> > > v5:
> > > - https://lore.kernel.org/all/20250617193450.183889-1-hiagofranco@gmail.com/
> > > v4:
> > > - https://lore.kernel.org/lkml/20250602131906.25751-1-hiagofranco@gmail.com/
> > > v3:
> > > - https://lore.kernel.org/all/20250519171514.61974-1-hiagofranco@gmail.com/
> > > v2:
> > > - https://lore.kernel.org/lkml/20250507160056.11876-1-hiagofranco@gmail.com/
> > > v1:
> > > - https://lore.kernel.org/lkml/20250505154849.64889-1-hiagofranco@gmail.com/
> > >
> > > Hiago De Franco (3):
> > >   pmdomain: core: introduce dev_pm_genpd_is_on()
> > >   remoteproc: imx_rproc: skip clock enable when M-core is managed by the
> > >     SCU
> > >   remoteproc: imx_rproc: detect and attach to pre-booted remote cores
> > >
> > >  drivers/pmdomain/core.c        | 33 +++++++++++++++++++++++++++
> > >  drivers/remoteproc/imx_rproc.c | 41 ++++++++++++++++++++++++++++------
> > >  include/linux/pm_domain.h      |  6 +++++
> > >  3 files changed, 73 insertions(+), 7 deletions(-)
> > >
> > > --
> > > 2.39.5
> > >

