Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDCB15D2A2
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2019 17:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfGBPUd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 11:20:33 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:56150 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfGBPUd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 11:20:33 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 83D8C255;
        Tue,  2 Jul 2019 17:20:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1562080830;
        bh=MQPbS86dIXLIzRT7cKc2d+ifqWU4LvOkgbT4PqUtUs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AjyAX71LRoe8eRV+OuUkmQlR9YQO/vf1ZVwhHDHWiea63RF+ToCjI1skAe8BqYFZ/
         PmWK4A7hGuqGDfDm0bX9JeknSYfL9JDtJjYykDHFVlViecPn3Xsmu1jZJpC4V4Uonz
         xTA1y9MKIbsTw5Dc5U5MuggGLuy54MMFTBhSYe+g=
Date:   Tue, 2 Jul 2019 18:20:11 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, aarch64-laptops@lists.linaro.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] drm/bridge: ti-sn65dsi86: support booloader enabled
 display
Message-ID: <20190702152011.GE5033@pendragon.ideasonboard.com>
References: <20190630150230.7878-1-robdclark@gmail.com>
 <20190630150230.7878-6-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190630150230.7878-6-robdclark@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Sun, Jun 30, 2019 at 08:01:43AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Request the enable gpio ASIS to avoid disabling bridge during probe, if
> already enabled.  And if already enabled, defer enabling runpm until
> attach to avoid cutting off the power to the bridge.
> 
> Once we get to attach, we know panel and drm driver are probed
> successfully, so at this point it i s safe to enable runpm and reset the
> bridge.  If we do it earlier, we kill efifb (in the case that panel or
> drm driver do not probe successfully, giving the user no way to see what
> is going on.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 7a046bcdd81b..8bdc33576992 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -257,6 +257,12 @@ static int ti_sn_bridge_attach(struct drm_bridge *bridge)
>  						   .node = NULL,
>  						 };
>  
> +	if (gpiod_get_value(pdata->enable_gpio)) {
> +		pm_runtime_enable(pdata->dev);

Does this need to be balanced with a pm_runtime_disable() call ? Bridges
can be attached and detached at runtime when reloading the display
controller drivers, so you need to ensure that detach/re-attach cycles
work.

> +		ti_sn_bridge_resume(pdata->dev);
> +		ti_sn_bridge_suspend(pdata->dev);
> +	}
> +
>  	ret = drm_connector_init(bridge->dev, &pdata->connector,
>  				 &ti_sn_bridge_connector_funcs,
>  				 DRM_MODE_CONNECTOR_eDP);
> @@ -813,7 +819,7 @@ static int ti_sn_bridge_probe(struct i2c_client *client,
>  	dev_set_drvdata(&client->dev, pdata);
>  
>  	pdata->enable_gpio = devm_gpiod_get(pdata->dev, "enable",
> -					    GPIOD_OUT_LOW);
> +					    GPIOD_ASIS);
>  	if (IS_ERR(pdata->enable_gpio)) {
>  		DRM_ERROR("failed to get enable gpio from DT\n");
>  		ret = PTR_ERR(pdata->enable_gpio);
> @@ -843,7 +849,9 @@ static int ti_sn_bridge_probe(struct i2c_client *client,
>  	if (ret)
>  		return ret;
>  
> -	pm_runtime_enable(pdata->dev);
> +	if (!gpiod_get_value(pdata->enable_gpio)) {
> +		pm_runtime_enable(pdata->dev);
> +	}

If I understand the issue correctly, this is part of an effort to avoid
disabling a potentially display output until we get as close as possible
to display handover, right ? Is there a drawback in always enabling
runtime PM when the bridge is attached instead of at probe time ? I
think we need to come up with a set of rules for bridge driver authors,
otherwise we'll end up with incompatible expectations of bridge drivers
and display controller drivers.

>  
>  	i2c_set_clientdata(client, pdata);
>  

-- 
Regards,

Laurent Pinchart
