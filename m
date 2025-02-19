Return-Path: <linux-pm+bounces-22425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AD3A3C02B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 14:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1741887608
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 13:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421971E7C25;
	Wed, 19 Feb 2025 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="F5ePZKWQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D06A1E834B;
	Wed, 19 Feb 2025 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972460; cv=none; b=nNHlbAukNYFtpiZMTi52jCMZoEipi9fIm4SOHXmsukgNlvRGporDO+i3IdYsq6lcy+fhkwGr1lQqfQjSLIuxh3M1Z4ciP8GTcaeqQtErNQJkvr6gxMjcVAAKMuFMLXnI0aIP9y70ks8zng42wKEKgrexKp3Ettc15YrdiXszw/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972460; c=relaxed/simple;
	bh=Tvl7NLuxa/MhrFZ6wDutYPLFjwy69UYMZuxI97W8IBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh3cgCF4qxXwUd1Vw8ef1+TyGMjXM3gShEaJgm5N1p3FREwBDmzMWJw0ugSZLamdECoNzk++UM0ckg80McL5TtcJNsUzv7MHlshmoSdF59vmGAqHZU9Qh5p/PXructiAFt67HMcbFy4PufMyojztlHwolNzOf+u3nQm2Y7/+1wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=F5ePZKWQ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7A3D9169;
	Wed, 19 Feb 2025 14:39:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1739972373;
	bh=Tvl7NLuxa/MhrFZ6wDutYPLFjwy69UYMZuxI97W8IBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F5ePZKWQD+C14wb+wfDzgmEopigfymY0uMlT9W7U6DMhFq52QTFgmFW8ZGgZ0EPTA
	 7HLdLnru62xznpFBYRF3NcQiuDJmNKSo91SN7nFxCGG5NkADaY9JT2tHLOOjqe61yu
	 HEDR73x7nnav2J0ued+XM5lGzCBm5sGAM3Mg2l9k=
Date: Wed, 19 Feb 2025 15:40:41 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-media@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 3/5] media: dt-bindings: Add Apple ISP
Message-ID: <20250219134041.GB15114@pendragon.ideasonboard.com>
References: <20250219-isp-v1-0-6d3e89b67c31@gmail.com>
 <20250219-isp-v1-3-6d3e89b67c31@gmail.com>
 <16f6d4a2-2102-48b9-a0ae-b8c6595975b8@kernel.org>
 <CAMT+MTR7dhtt3SOMg0K3UakJQftqnc2S-rV41HdHtA+o9aSPug@mail.gmail.com>
 <20250219105326.GA31383@pendragon.ideasonboard.com>
 <CAMT+MTToVdm72ovNZ8ySySYe5fT99a0Y6bv02NKxADCBCe+pMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMT+MTToVdm72ovNZ8ySySYe5fT99a0Y6bv02NKxADCBCe+pMQ@mail.gmail.com>

On Wed, Feb 19, 2025 at 12:05:29PM +0100, Sasha Finkelstein wrote:
> On Wed, 19 Feb 2025 at 11:53, Laurent Pinchart wrote:
> > >
> > > Those are board-specific and not discoverable via the ISP protocol.
> >
> > But they are settable through the ISP protocol, aren't they ? For
> > instance, looking at isp-imx248.dtsi, the first four entries are
> >
> >         /* 1280x720 */
> >         preset0 {
> >                 apple,config-index = <0>;
> >                 apple,input-size = <1296 736>;
> >                 apple,output-size = <1280 720>;
> >                 apple,crop = <8 8 1280 720>;
> >         };
> >
> >         /* 960x720 (4:3) */
> >         preset1 {
> >                 apple,config-index = <0>;
> >                 apple,input-size = <1296 736>;
> >                 apple,output-size = <960 720>;
> >                 apple,crop = <168 8 960 720>;
> >         };
> >
> >         /* 960x540 (16:9) */
> >         preset2 {
> >                 apple,config-index = <0>;
> >                 apple,input-size = <1296 736>;
> >                 apple,output-size = <960 540>;
> >                 apple,crop = <8 8 1280 720>;
> >         };
> >
> >         /* 640x480 (4:3) */
> >         preset3 {
> >                 apple,config-index = <0>;
> >                 apple,input-size = <1296 736>;
> >                 apple,output-size = <640 480>;
> >                 apple,crop = <168 8 960 720>;
> >         };
> >
> > But I may be interested in capturing a 640x480 frame with cropping only
> > and without scaling, with
> >
> > input-size = 1296x736
> > output-size = 640x480
> > crop = (328,128)/640x480
> >
> > Or I may want my cropped frame to be located in the upper-left corner:
> >
> > input-size = 1296x736
> > output-size = 640x480
> > crop = (8,8)/640x480
> >
> > If I set those parameters through the ISP protocol, won't it work ?
> 
> For cropping - you do not want to change those parameters, the sensor
> is partially occluded, and the crop area is specified in such a way
> to not expose those pixels.

Surely cropping *more* wouldn't be an issue from that point of view ?
The visible area is a device-specific property, so that could be
specified in DT, instead of presets. The problem isn't limited to this
device, so ideally the DT binding for this feature should be
standardized.

In general, I'd say that even occluded pixels should be exposed to
userspace, should an application want to capture them. If you think of
fisheye lenses, for instance, it's common to have a round image captured
from a rectangular sensor, and use a dewarping engine (it could just be
GPU shaders) to un-distord it. Restricting capture to rectangles of
fully visible pixels would result in loss of information. For this
particular device I don't think that would really be a use case, so I'm
not opposed to the driver setting restrictions on crop rectangles.

> As for scaling - we can expose only the 1:1
> scale and let userspace deal with it, but it appears that it expects
> the other common output sizes to exist.

Can the driver synthesize the list of scaled-down resolutions, instead
of specifying them in DT ?

-- 
Regards,

Laurent Pinchart

