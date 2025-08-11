Return-Path: <linux-pm+bounces-32166-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC88B20C83
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 16:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343F53BC040
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 14:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BC32D3A65;
	Mon, 11 Aug 2025 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHP2Znzq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6352D3746;
	Mon, 11 Aug 2025 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923284; cv=none; b=nCtgoWO9HdYvBeALqpip7ZYXLML63y/3lL4x/9HEwCgTscN0vXDW6nxvpcJW50r2TqlQz9GVOPOrELnmvoPrbASsaLoCWDK0rLb3mfU3xaB6rYYY5rs1Oa8jwNbMEYN11zBjU82zlN8M5SCnN6FK5bmaB/ZJEhIlIO3mH6/FtYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923284; c=relaxed/simple;
	bh=VF9Jg/d06Tv2Fxwyy2A+qPAfpKUy+coGW86+nNaqWx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vl3eBoTOTD1MkLGp3hBZPQc+MvoI5oNJA8iV7JjmuOFuv5/MzAOCmS+PVOFuBYV1sT3d8jNOpiIajABWdj/2v/RDgIw2bu6MLjiMOSiJ/LGwsnxDq9Bk5GZ4lurd6+FDvbYOyJsiHIXF6Z+tF8Q1zznQKGUj6EyLv4WNqnUv1vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHP2Znzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E19BC4CEF7;
	Mon, 11 Aug 2025 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754923284;
	bh=VF9Jg/d06Tv2Fxwyy2A+qPAfpKUy+coGW86+nNaqWx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SHP2ZnzqwGefFOspnDgoWnd7qsFIty1fQU0NW4gMEnAQEa5MwhV5r602FioBzcoTK
	 fR4RJ8Af9jPnTdYJ1yNBfOvZ6u6el9QErUCC3Nbv8g7BjkwGR0dLz341gHCny10qGX
	 bFRepz/5peyfdCKUM+GpNzWd9tAgnnx/R/pSeVx3lxCIu9mCoP+3IyMA7yPASK6nyR
	 d4mcGasvAiFy8WU2oZk9ybmzEDVT6pVRhOP2IRgnxDF6o6XDo9Wc70KfJfNbWF3hfE
	 bCGxQxkM50liFaTNkSs+lLKH7qZ1KBBU8Ac9y/k/1jxLziytL/wt2qlhs8QGTwn/Ll
	 4sBnoRWrhSQxg==
Date: Mon, 11 Aug 2025 09:41:22 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: chris.ruehl@gtsys.com.hk
Cc: sre@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ruehlchr@gmail.com
Subject: Re: [PATCH] msm: arm: qcom battery manager add OOI chemistry
Message-ID: <wq7yuqborkkup6mhipf6pnarsc5p7t4fivwoi2pxmrin3wlzpe@apkeapewo6fq>
References: <20250811111026.24292-1-chris.ruehl@gtsys.com.hk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811111026.24292-1-chris.ruehl@gtsys.com.hk>

On Mon, Aug 11, 2025 at 01:10:26PM +0200, chris.ruehl@gtsys.com.hk wrote:
> From: Christopher Ruehl <chris.ruehl@gtsys.com.hk>
> 

The subject prefix should be "power: supply: qcom_battmgr: " to match
other changes in this driver. (see git log --oneline)

Regards,
Bjorn

> The ASUS S15 xElite model report the Li-ion battery with an OOI, hence this
> update the detection and return the appropriate type.
> 
> Signed-off-by: Christopher Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  drivers/power/supply/qcom_battmgr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index 99808ea9851f..fdb2d1b883fc 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -982,7 +982,8 @@ static void qcom_battmgr_sc8280xp_strcpy(char *dest, const char *src)
>  
>  static unsigned int qcom_battmgr_sc8280xp_parse_technology(const char *chemistry)
>  {
> -	if (!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN))
> +	if ((!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN)) ||
> +	    (!strncmp(chemistry, "OOI", BATTMGR_CHEMISTRY_LEN)))
>  		return POWER_SUPPLY_TECHNOLOGY_LION;
>  	if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN))
>  		return POWER_SUPPLY_TECHNOLOGY_LIPO;
> -- 
> 2.47.2
> 

