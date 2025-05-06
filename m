Return-Path: <linux-pm+bounces-26736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 754D4AAC452
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 14:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B883B32CD
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 12:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAAC27FB37;
	Tue,  6 May 2025 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew3AERqh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120D227FB04;
	Tue,  6 May 2025 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746534988; cv=none; b=o4KCttzLGaLve9m56ZMdLAwNAW1aD853kDJOWCQYlS7AiH/gjS7pY+jWAthlAZ0I+TjXs186FftyUqipVtq+1G3+FDjy0GjE2w6ans0HjsEAhQWD9VYOisa8piJY0xM9AHIh7b3clQjSeNAcB/D8JgXqcdnvbDejGEjR5Wn6578=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746534988; c=relaxed/simple;
	bh=X4Yh3JtCRkiQP87Dxdyse/UwWkT9JwNjx0Xs4dHDkSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MX+Zck0xKFYWXoyf21wrG53sO9m2FhN++ZBT7TNNywL9SZIkE0eZnQXq7b4zTqK563vJm0P2jZv33QVwyjetv1B1NPFJJbipUsW6IU0WMDw/rxLt02sFFNA3saIaLPJXL74mvG+iV0QybC8FJ107Tamg+mTpi2yoY/7eU8bbjEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ew3AERqh; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736b98acaadso5295856b3a.1;
        Tue, 06 May 2025 05:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746534986; x=1747139786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fw+usroP3NgOGNx1hpYdeiF4dmvyltKLfFB52iURL84=;
        b=ew3AERqhF7qd+wjilcoLGF1yTXLyhBBnlRd+LhH3PvIhxZM2JIdRbDcyqman4saEC+
         EKDPWlG3TYn4AfjWPuhotd+vwly0fK1cJF5/LZCJYd67pdV2xZpq9+B1d9FYQq3eFyif
         v439qXglun+N1g/AxgRRshd3+j3C7ajK2Xp15CNvk9vEyE3DCHHmyzhk2UeRg3h/PECB
         F0zq2DVs16B/K7KyiAsc4PSFg+fr5cZJTv/MK68DV8+IFO6clFqWcyfAsOchEMOhk5is
         pA8VDz3h41GAmV94r7j3cL4tB938kEeHQuwVbqkqAIxH3rwlZLecRJCmCBRiGhumblDj
         20gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746534986; x=1747139786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw+usroP3NgOGNx1hpYdeiF4dmvyltKLfFB52iURL84=;
        b=tx5IYtvrWxMODoT41Oap0IlWZUngXColaWx//0r+ZcJlXuEAXQXp9P9LqV8hEIGd0Q
         XJcHpbMPXClmXBcPkLKZ52IhlygyShm8fUQ/fYyGvh/QWWY5l/gf4rZjiRCUY8aohQl4
         hAj7sB3atiBrGLGxbKeYy1HrFMtfisgsnyTTLC4tKLqW+0qAdFREL8sEwo5p+6x+qJlY
         AMJehMIhy5IIOeWWoD1qV195agWhy1y221VCNoK+PlFBvCNcS9PG8A0GOiYFgzV8vj+Z
         8110vqlR5SKQcxJ0Wwq1XyVyTKmAqQi46oyWuxKGroTmhtii6kC5oqyaQcK0QFeGbmlx
         tLhw==
X-Forwarded-Encrypted: i=1; AJvYcCUIrFJdFEzRoejmVhHukUIf4uu5kwahUIQcMrltsBcvhV2C81NlE4OmmYbLu6cVJjQY5I+LWbMhW0rEQQv13CLxhQ==@vger.kernel.org, AJvYcCWoxOWtpVOVE08MizVIo00/dv52S/6sPaHrpssS2BtmET5bCuFD5Z6k4u6b5S8XI7tf9uupG0ebb7FY5b8=@vger.kernel.org, AJvYcCXkO1XIFnMu1j7mGvLJkJSGfvthTwsiZCMB+6nNAT0+PWML+ofXaMzR0GKNuJ5NYZfnJZb0XsRuK/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKhRR6ng+j+ZblDmpMofyhLRuWALRZubOQSHVwBeIrHSgJsmQc
	ZjtjWCmlJjUyy6GJzkUaTSqEPhuWph0L2277ncylF0gypa5z0nvk
X-Gm-Gg: ASbGncvA4qSRol5kXhGq+li2frafpuROw8t9HWemwPpZLfucfPzM4WljYrd+XV2r7oT
	k9PDYHudFygsl15CEOTgMUrFKagdoEZIQlUP00gA78ijAJ7VYkyq1rb4UwA+7yGNvH9kP/p3xUL
	MnoIDG5OMXgE/95mhiM6V83K6ISG773F4IBZ2DMVPxn10nJSwuK6uUTp90Ij21b1EwDTfnj8bpl
	VrNhOVGgxsAoqSe7NHn6I6k12A9dm7LIu+x5mkIOYZxpUkRM5al8JgNid1+tSV3QmV+jy8caj2k
	jnxu3cOoAom91+sR6wJFYx4WwMmNCReqRsyo9XQ=
X-Google-Smtp-Source: AGHT+IELVS4lhs43iILfpwkhJE1qzvUcBDpCZPSr8G03kGFiX1zF+uJrHmJifYxOzwmCsKQfm2eOFA==
X-Received: by 2002:a05:6a00:1d21:b0:736:32d2:aa8e with SMTP id d2e1a72fcca58-74091a1ee5emr3278160b3a.6.1746534986102;
        Tue, 06 May 2025 05:36:26 -0700 (PDT)
Received: from hiago-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7ad6csm9089557b3a.17.2025.05.06.05.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 05:36:25 -0700 (PDT)
Date: Tue, 6 May 2025 09:36:19 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] remoteproc: imx_rproc: skip clock enable when M-core
 is managed by the SCU
Message-ID: <20250506123619.egobussm6b74imso@hiago-nb>
References: <20250505154849.64889-1-hiagofranco@gmail.com>
 <20250505154849.64889-2-hiagofranco@gmail.com>
 <20250506043835.GB24259@nxa18884-linux>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506043835.GB24259@nxa18884-linux>

Hi Peng,

On Tue, May 06, 2025 at 12:38:35PM +0800, Peng Fan wrote:
> On Mon, May 05, 2025 at 12:48:47PM -0300, Hiago De Franco wrote:
> >From: Hiago De Franco <hiago.franco@toradex.com>
> >
> >For the i.MX8X and i.MX8 family SoCs, when the M-core is powered up
> >before Linux starts (e.g., by the bootloader) and it is being managed by
> >the SCU, the SCFW will not allow the kernel to enable the clock again.
> >This currently causes an SCU fault reset when the M-core is up and
> >running and the kernel boots, resetting the system.
> >
> >Therefore, add a check in the clock enable function to not execute it if
> >the M-core is being managed by the SCU.
> >
> >This change affects only the i.MX8X and i.MX8 family SoCs, as this is
> >under the IMX_RPROC_SCU_API method.
> 
> I would rewrite as below: "
> 
> For the i.MX8X and i.MX8 family SoCs, when the M-core is powered up
> by the bootloader, M-core and Linux are in same SCFW(System Controller
> Firmware) partition, so linux has permission to control M-core.
> 
> But when M-core is started, the SCFW will automatically enable the clock
> and configure the rate, and any users that wanna to enable the clock
> will get error 'LOCKED' from SCFW. So current imx_rproc.c probe function
> gets failure because clk_prepare_enable returns failure. Then
> the power domain of M-core is powered off when M-core is still running,
> SCU(System Controller Unit) will get a fault reset, and system restarts.
> 
> To address the issue, ignore handling the clk for i.MX8X and i.MX8 M-core,
> because SCFW automatically enables and configures the clock.
> "
> 
> You may update if you wanna.
> 
> >
> >Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> >Suggested-by: Peng Fan <peng.fan@oss.nxp.com>
> 
> -> peng.fan@nxp.com

Thanks for the review, I will update the suggestions on a v2. Meanwhile,
I will wait a little bit for other feedbacks.

> 
> Thanks,
> Peng
> 
> >---
> > drivers/remoteproc/imx_rproc.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> >index 74299af1d7f1..627e57a88db2 100644
> >--- a/drivers/remoteproc/imx_rproc.c
> >+++ b/drivers/remoteproc/imx_rproc.c
> >@@ -1029,8 +1029,8 @@ static int imx_rproc_clk_enable(struct imx_rproc *priv)
> > 	struct device *dev = priv->dev;
> > 	int ret;
> > 
> >-	/* Remote core is not under control of Linux */
> >-	if (dcfg->method == IMX_RPROC_NONE)
> >+	/* Remote core is not under control of Linux or it is managed by SCU API */
> >+	if (dcfg->method == IMX_RPROC_NONE || dcfg->method == IMX_RPROC_SCU_API)
> > 		return 0;
> > 
> > 	priv->clk = devm_clk_get(dev, NULL);
> >-- 
> >2.39.5
> >

Cheers,
Hiago.

