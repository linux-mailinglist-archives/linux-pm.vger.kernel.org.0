Return-Path: <linux-pm+bounces-39874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EE271CD9F77
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 17:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78D413018C56
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 16:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F517238C1A;
	Tue, 23 Dec 2025 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rPvMJI8J"
X-Original-To: linux-pm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED0A34CDD;
	Tue, 23 Dec 2025 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766507436; cv=none; b=VsTJy4CsMtpSW9r0E9SWUzjXQxXX8WKR7vErtT45f/ML0+OAQodCVx06QbzJ53Xj0Ionyd1kM4oKUXYbd2ShqRuGCLc3EyTcnclMdB788A1lk/blXCPgLQaI0fBpPEHZ2348FJm/51a0aDq4DGw8ItnOSl1ZxAsFYroPKCWZu2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766507436; c=relaxed/simple;
	bh=EssmU79hIAIBvgwSq9QzBKNjzESzJNuoxUB6MD1ZQGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpZjOisYtHSOuQHetjs0ztSUYaVpUOwfVO2nSMt6VRSdjTcJ0/n3/v3GgC7vsRPIBR8YRMlCka63RBOG01ooAXzIuYFE17KsBBJXTwjp+ohO3pAQKa/Ok3pQnoghJOIiOb4SS/lsEIIogl/fF8YZNlBJjjjdKLiBZxXl+COxuv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=rPvMJI8J; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-152.bb.dnainternet.fi [81.175.209.152])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 722AF833;
	Tue, 23 Dec 2025 17:30:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1766507417;
	bh=EssmU79hIAIBvgwSq9QzBKNjzESzJNuoxUB6MD1ZQGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPvMJI8J+fn/vctuWtoIqAQRVV1gFno+Rr9dMoYJNGwJ7Xf72efjcoH+cnDB2lKvD
	 y4hu1abpiq1up1Pad+/EhQIbC23w9kbr+O6FFF20xNa0OFZ38mJnj1b2p68EP7szHw
	 jRE4BHEYVRm+3/Ac/iHl+knxbSj7mYEDvezfw7nM=
Date: Tue, 23 Dec 2025 18:30:10 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Brian Norris <briannorris@chromium.org>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v1 05/23] media: rkisp1: Discard pm_runtime_put() return
 value
Message-ID: <20251223163010.GJ9817@pendragon.ideasonboard.com>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
 <2356323.iZASKD2KPV@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2356323.iZASKD2KPV@rafael.j.wysocki>

Hi Rafael,

Thank you for the patch.

On Mon, Dec 22, 2025 at 09:01:55PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Printing error messages on pm_runtime_put() returning negative values
> is not particularly useful.
>  
> Returning an error code from pm_runtime_put() merely means that it has
> not queued up a work item to check whether or not the device can be
> suspended and there are many perfectly valid situations in which that
> can happen, like after writing "on" to the devices' runtime PM "control"
> attribute in sysfs for one example.
> 
> Accordingly, update rkisp1_vb2_stop_streaming() to simply discard the
> return value of pm_runtime_put().
> 
> This will facilitate a planned change of the pm_runtime_put() return
> type to void in the future.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> This patch is part of a series, but it doesn't depend on anything else
> in that series.  The last patch in the series depends on it.
> 
> It can be applied by itself and if you decide to do so, please let me
> know.

I've applied the patch to my tree for v6.20.

> Otherwise, an ACK or equivalent will be appreciated, but also the lack
> of specific criticism will be eventually regarded as consent.
> 
> ---
>  drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> @@ -1123,7 +1123,6 @@ static void rkisp1_vb2_stop_streaming(st
>  	struct rkisp1_capture *cap = queue->drv_priv;
>  	struct rkisp1_vdev_node *node = &cap->vnode;
>  	struct rkisp1_device *rkisp1 = cap->rkisp1;
> -	int ret;
>  
>  	mutex_lock(&cap->rkisp1->stream_lock);
>  
> @@ -1132,9 +1131,7 @@ static void rkisp1_vb2_stop_streaming(st
>  	rkisp1_return_all_buffers(cap, VB2_BUF_STATE_ERROR);
>  
>  	v4l2_pipeline_pm_put(&node->vdev.entity);
> -	ret = pm_runtime_put(rkisp1->dev);
> -	if (ret < 0)
> -		dev_err(rkisp1->dev, "power down failed error:%d\n", ret);
> +	pm_runtime_put(rkisp1->dev);
>  
>  	rkisp1_dummy_buf_destroy(cap);
>  

-- 
Regards,

Laurent Pinchart

