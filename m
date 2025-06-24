Return-Path: <linux-pm+bounces-29451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AACAE6C53
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 18:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627D216A46F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 16:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D141FDA94;
	Tue, 24 Jun 2025 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gL/GEXpQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EE78462;
	Tue, 24 Jun 2025 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781902; cv=none; b=QEvdJK5YVcPpNOzFp/H5BhWCDnBnQE021WrdBIE6XrWB/8V+MswV3ExsGRNq2QUVKlXblBG0/YoP4zqbCsAe0tCQGN0KTILg8tqB8/vsgZW4pDQY9H+10ZbXTqobT+CZXL0TNmrdZti0VRNuSWhcuC9L0IQQB19hTGdo38Wd5Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781902; c=relaxed/simple;
	bh=jEHkfNRoxG08BgsTmrEHrIPbT5Ga85US2KlZCNdzJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNatCni3JPgzxRzOBAKtWkvM3JGTbAhh/2BVXirynLHO/QY/lnCWQuevxVdzOmFW2g8rBMxztRGGe+jv3Ukh3mung/WwtXp/owRG/pdZjNw8crG2VoYRjGr6ECMQuX9BlU8gpXwbQ6jyuXBo+mYmt+HB8SKyKz+iE+Qmt9qVIaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gL/GEXpQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-236192f8770so484175ad.0;
        Tue, 24 Jun 2025 09:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750781899; x=1751386699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KaSirUQP1y7nt53v45U75QfDYbaR7g+CaXyRQ+R4zaQ=;
        b=gL/GEXpQ5KmMtkI9y8cla4dIRQN+Rszk2b8js2vmdnWFWXo6xEspnIqkSP7TmJlvPA
         X0g3Xjcef1t6ABmPyplUieqXWV+HX2kyeT0GUoRnNcDXrezMHP1W3kAE4iNOx+FBfOwX
         9wNAIkvSFNj4JoarhSI3OFm3l7IUT9v1NDd2OdBf+GA7QopFo9WCTGs03BSdQy3uT5ih
         p5ax8gMrGmSumGySlfK1x9ZeKxwO6GO+bu8AiTqa1uMsgOWVkxDWps4ca6C/P+KtQZXS
         BDhcwQUzYwKCBCoDFJKxgrI5JnS0C9hrd7L9lD6UFULreoz+M1SRYJ9FdxxsMx+Ioaa+
         k0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750781899; x=1751386699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaSirUQP1y7nt53v45U75QfDYbaR7g+CaXyRQ+R4zaQ=;
        b=l9QRrm+SZiFBpkNrzFAH7mpW+SwT0GdzX1jMyznluIT7t5YsO7z1KoyfkqOZ2HDNoh
         78kxK9lOxZT7I44/TvJtlOUQW3P7OzTrJj3jhMYmQ+QRIhTGvucmtM4UK3V3B+xYsWej
         q8xOcgXlSR31uB6aHt+rFbjaQJnK7CuAH35viXer4cPGn9bH3YXmkm8lyvbvMFfhYZH6
         7MpRpysqL9DutvMMOwK9SBcnUmJkkt09oYAIRAphXN4ysWLH66sCP428e3QuHGuTefMK
         BQjD6g4so63K8e67A3DhdD/PtsHFbYEijjPtEQvfiMjxzG1o6WwLGJHa5tySRu1myCBG
         2YiA==
X-Forwarded-Encrypted: i=1; AJvYcCVuDCxnWfbFi/Z+Fo4jQEQFWkCmUriwVBhHPLFZc/lElRUCgKsnHu78qrJslN0WfXvqa5gWL/mh0DD/Tx4=@vger.kernel.org, AJvYcCWGVTOfxSPnPvRXWB261FkPx8PO4oJsfGwtuhcDd/382Hb5uhZaZHn0IKqFe0JjDYGyCHpK3+tbHIQ=@vger.kernel.org, AJvYcCXLJw4k4jVFLhyGleolKGDEMiULi9CuhC2fM+vqGYsKNKY3V+h+Z98y+0YYlsI0NkMSOY7r6MJEOCWI946UtX2vsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWWsQnV1x65E98+gUyYyEUA7v7IUMPS7ovXGynz6t+/93bLFSx
	Kdx5eEog0g75vISFSsnMvm47zxeohO187OT1HmeN1UN2JglMaGi5Xo4z
X-Gm-Gg: ASbGncsxW50HV9U3Dxf2/lbqaS0wv9nGGEveAtRhc0wAKO3eScDTeWu0KiEgKEB1j11
	dFwfrVz9Rww+11Quz0pg1ccGD4URM9WkgdM/cxBhiYKwi4uqW1GvLrvsatAC7kRO5ONmU0defAU
	Iw7N+qJaTzNRd9tsWn99PusE/uu9NE0tIHeehtbeRf64RoJS3vkYypDVQZDcfwsTwehL4Hx9Ut6
	o2X4jMfGyVKfwRqm+uV79Zt25Q8SRZ5Alsg80O+ibRsCbebSgd/VZb8dQyHllShv8LvP9ghH3T6
	tRFpGGJMsLWPe1RRQ/v3hTMUvexVU0nHOsz4xxpgpc0gXJl5C1Y611MK4jvBiP0Yt3vICQ==
X-Google-Smtp-Source: AGHT+IGY9jDpDk2r2dCyM4JVgT9EfvwZiTIAPDobHHlnMbHmIZb819DFvehZFOYNen2Nr3/FdN/vzA==
X-Received: by 2002:a17:902:9a09:b0:232:59b:5923 with SMTP id d9443c01a7336-238024b7fe7mr64735195ad.23.1750781898702;
        Tue, 24 Jun 2025 09:18:18 -0700 (PDT)
Received: from hiagonb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83955a3sm110681625ad.36.2025.06.24.09.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:18:17 -0700 (PDT)
Date: Tue, 24 Jun 2025 13:18:12 -0300
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
Subject: Re: [PATCH v5 0/3] remoteproc: imx_rproc: allow attaching to running
 core kicked by the bootloader
Message-ID: <20250624161812.c4p26zkd37awixpr@hiagonb>
References: <20250617193450.183889-1-hiagofranco@gmail.com>
 <aFlzpnT1yNGdWWkH@p14s>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFlzpnT1yNGdWWkH@p14s>

On Mon, Jun 23, 2025 at 09:32:54AM -0600, Mathieu Poirier wrote:
> On Tue, Jun 17, 2025 at 04:34:47PM -0300, Hiago De Franco wrote:
> > From: Hiago De Franco <hiago.franco@toradex.com>
> > 
> > This patch series depends on Ulf's patches that are currently under
> > review, "pmdomain: Add generic ->sync_state() support to genpd" [1].
> > Without them, this series is not going to work.
> 
> Please resend this patchset when [1] and the work in patch 1/3 have been merged.

All right, I will send the v6 with the corrections you mentioned and
resend it when the other patches have been merged.

Best regards,
Hiago.

> 
> Thanks,
> Mathieu
> 
> > 
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
> > v5:
> > - pm_runtime_get_sync() removed in favor of pm_runtime_resume_and_get(),
> >   checking the return value of it.
> > - Added pm_runtime_disable() and pm_runtime_put() to imx_rproc_remove().
> > - Fixed missing "()" in dev_pm_genpd_is_on description.
> > - Updated dev_pm_genpd_is_on() function description to be explicit the
> >   function reflects the current power status of the device and that this
> >   might change after the function returns, especially if the genpd is
> >   shared.
> > 
> > v4:
> > - https://lore.kernel.org/lkml/20250602131906.25751-1-hiagofranco@gmail.com/
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

