Return-Path: <linux-pm+bounces-19991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27582A02BAA
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 16:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830EC1655DA
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 15:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A289142E77;
	Mon,  6 Jan 2025 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrzkGED6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C31607AA;
	Mon,  6 Jan 2025 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178296; cv=none; b=Wwuttli9TFTt+VrLp/Tm03vj0yqktqJsEZ97xC21HuHuWlzHa5SgnW0d5uNktww9VU9OkQih9weobr/XZyx1GqGDWCaE01br0rHwHckS2zFTsO2o8/g6OgU2c9hXgiU76SusaWDCOWRn2ETEzIbWH6FuIDyz0W8OYuFDj/rD4aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178296; c=relaxed/simple;
	bh=AT6oQtVPwN+ST2vWBMd7vRvvwob7zkorTG0PQgHeZoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gN0QxBPpidJFNN2ajds0g5V4i95cmRWMXNgxIWAQzQ4yvoeh1G0JvZc5+DivhXh8WNe4G6kSJH7nkbpck0GU3lPNoeqjcGWHt0qxSnfXAxz54bqhD/t8uFmzObMpirCAQBDdLS3v9/703mHMu07KPWEb/L+jJ97L62p2i07cPno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrzkGED6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72631C4CEDF;
	Mon,  6 Jan 2025 15:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736178296;
	bh=AT6oQtVPwN+ST2vWBMd7vRvvwob7zkorTG0PQgHeZoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FrzkGED6cMx6zGdUp2+YltU52tpSUVO2Nozbgtxm+Fx9MFJD78Nnp8rxmR8JPxSAt
	 eIAmyD80/O21MZ40jamWzM8+/ItBimmi9ON/Jr3av0/6ycXBI9gAsVkx3N00XtlyVy
	 dXckjw+xH9xs2Z+E3F/KcToU9y0yVWgK+aSRcNxrpA/G7e7lIji9teaS+85o+OlRO/
	 Yya/A9BW6HqXqRrw1znzl03vyNaoDHSGW6E1TjDclWDBgtYie+iszzEPjmjazCw89J
	 XdtBaWQ7ifZMNxLA6of9JWjQScsc/GjqeB4egY/rGoGjHkRnU/AQdRpulWXafS72BI
	 GHkuQxeEFT6sg==
Date: Mon, 6 Jan 2025 15:44:51 +0000
From: Lee Jones <lee@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
	Chris Morgan <macroalpha82@gmail.com>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "mfd: axp20x: Allow multiple regulators"
Message-ID: <20250106154451.GB6763@google.com>
References: <20241231165103.800752-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241231165103.800752-1-andre.przywara@arm.com>

On Tue, 31 Dec 2024, Andre Przywara wrote:

> As Chris and Vasily reported, the attempt to support multiple AXP PMICs
> in one system [1] breaks some of the battery and charging functionality
> on devices with AXP PMICs. The reason is that the drivers now fail to get
> the correct IIO channel for the ADC component, as the current code seems
> to rely on the zero-based enumeration of the regulator devices.
> A fix is possible, but not trivial, as it requires some rework in the AXP
> MFD driver, which cannot be fully reviewed or tested in time for the
> 6.13 release.
> 
> So revert this patch for now, to avoid regressions on battery powered
> devices. This patch was really only necessary for devices with two
> PMICs, support for which is not mainline yet anyway, so we don't lose
> any functionality.
> 
> This reverts commit e37ec32188701efa01455b9be42a392adab06ce4.
> 
> [1] https://lore.kernel.org/linux-sunxi/20241007001408.27249-4-andre.przywara@arm.com/
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/mfd/axp20x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 251465a656d09..5b8e88341a305 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -1445,7 +1445,7 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
>  		}
>  	}
>  
> -	ret = mfd_add_devices(axp20x->dev, PLATFORM_DEVID_AUTO, axp20x->cells,
> +	ret = mfd_add_devices(axp20x->dev, -1, axp20x->cells,
>  			      axp20x->nr_cells, NULL, 0, NULL);

Please submit a new patch and use PLATFORM_DEVID_NONE instead.

-- 
Lee Jones [李琼斯]

