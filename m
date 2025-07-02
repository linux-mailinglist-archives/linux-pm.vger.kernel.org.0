Return-Path: <linux-pm+bounces-29959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A51AF0CA9
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 09:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55830484AA6
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 07:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A64022F39B;
	Wed,  2 Jul 2025 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E/a6/TsN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0837422DF9E;
	Wed,  2 Jul 2025 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751441655; cv=none; b=BSBnrdype8E/ASZYCGczKSlEa829enFEyTkieEiZ2+wVWd4W0+ordN7irsQJFlNvwfCX1od3E0Suivq88UQkxKh//Epb44HZ+xuC0NQLft7bNhHitw9iwP40vgtcdrNn0ol3t6ODRgzG/4z6elegOwt5mV+sQRe68VUEHRVALJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751441655; c=relaxed/simple;
	bh=hP4hON7E7oXvPH0f+fMbPL2IxVBYqXaro2alxaWbcoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyKYLi2h+EPZNSsfwEFnMd9vAOIcRJJbxp7UPqJd8FJ9GXrsSYqNNgKKqhnkU4SzdX2V9xn2faC+LSRZ5uI8MhPcVKSrCfWzgmmHhKkuGhhs5+gQ9gJBQFE1Bomf7y8QnZv+hPy1HUejN5lhmNEwKfT1ekJn0A6RMvRZzQrYErY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E/a6/TsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4068C4CEEE;
	Wed,  2 Jul 2025 07:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751441654;
	bh=hP4hON7E7oXvPH0f+fMbPL2IxVBYqXaro2alxaWbcoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/a6/TsNsNnMYUxaIXN827neJHzWqgazQ3TV8Ous25tztEpY6hR3c7mBETYq0TyL4
	 vuemE43LrGprxUXhuRxN0m3dudlWn8yjnciyTEBVayDdM6690odTKiqJahl3NRQPJg
	 kS5zlbBr74aXYyq4tOj3Xc7Bq3A/vuzl89M4UlAI=
Date: Wed, 2 Jul 2025 09:34:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/24] driver core: Export get_dev_from_fwnode()
Message-ID: <2025070205-ignore-passive-17b4@gregkh>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <20250701114733.636510-18-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701114733.636510-18-ulf.hansson@linaro.org>

On Tue, Jul 01, 2025 at 01:47:19PM +0200, Ulf Hansson wrote:
> It has turned out get_dev_from_fwnode() is useful at a few other places
> outside of the driver core, as in gpiolib.c for example. Therefore let's
> make it available as a common helper function.
> 
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
> Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/core.c    | 8 ++++++--
>  include/linux/device.h | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

