Return-Path: <linux-pm+bounces-22426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7135FA3C07C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 14:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA3317508B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 13:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54F41EF0A5;
	Wed, 19 Feb 2025 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bwaGPcOm"
X-Original-To: linux-pm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020C1EDA3B;
	Wed, 19 Feb 2025 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972659; cv=none; b=IRacQdE0Xn1IHcSFFHE5Hjjgb3SzyYqOjIR5niElh67nFtCFDsekHUTCKuRaQjV645HilH9DznhcuQJFTlycJVYDOXiWnwnYHQbZoBLJtob908DhIwwA1tckgkqS6zqKyKsfPc/o7Cx2CL2Bbr5AURN50sAHUPvxHntjwHOQ5fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972659; c=relaxed/simple;
	bh=f9Zc5VG8pt57R7Xvh+xsVJ/ay+lEmys3EP79pZtRUO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLNfkBiOVshAZjWjcKL7/9vxRWlzI2BGUm2B8SXoAEwSIBwK5fu0OuPr8+H3+CM78dXcZMitpA2Xxg6zeN4ydMEBEa8yO4eLBPYce1WOREPej0rsPA1lrhWG6ar4sJD0N7VnLmw4OsF8awv7dZ3tBKgcbALIz8zg8qllY93DTd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bwaGPcOm; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0413D169;
	Wed, 19 Feb 2025 14:42:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1739972573;
	bh=f9Zc5VG8pt57R7Xvh+xsVJ/ay+lEmys3EP79pZtRUO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwaGPcOm7pnNqi+CQD8qLP4ToxnVHXV10hly/kI1aDNTwG60yEFhQhehRuyOIlQ9F
	 jBMwh0bfCjSJPotc9w+hrrMebIT0m2aRkPzhI6Ltu8PBo7Kz2IvmLFWV+DEBHT8IGS
	 zayOXFdn5BasZk2mMIjOQ/MMSFzZxut1XfJGEmjU=
Date: Wed, 19 Feb 2025 15:44:00 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Janne Grunau <j@jannau.net>
Cc: Sasha Finkelstein <fnkl.kernel@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sven Peter <sven@svenpeter.dev>,
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
Message-ID: <20250219134400.GC15114@pendragon.ideasonboard.com>
References: <20250219-isp-v1-0-6d3e89b67c31@gmail.com>
 <20250219-isp-v1-3-6d3e89b67c31@gmail.com>
 <16f6d4a2-2102-48b9-a0ae-b8c6595975b8@kernel.org>
 <CAMT+MTR7dhtt3SOMg0K3UakJQftqnc2S-rV41HdHtA+o9aSPug@mail.gmail.com>
 <20250219105326.GA31383@pendragon.ideasonboard.com>
 <20250219115737.GB26386@robin.jannau.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219115737.GB26386@robin.jannau.net>

On Wed, Feb 19, 2025 at 12:57:37PM +0100, Janne Grunau wrote:
> On Wed, Feb 19, 2025 at 12:53:26PM +0200, Laurent Pinchart wrote:
> > On Wed, Feb 19, 2025 at 10:54:31AM +0100, Sasha Finkelstein wrote:
> > > On Wed, 19 Feb 2025 at 10:37, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > > +
> > > > > +  apple,platform-id:
> > > > > +    description: Platform id for firmware
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > >
> > > >
> > > > No, use firmware-name.
> > > 
> > > Not sure how is firmware-name an appropriate field, fw-name is a string
> > > that references a firmware file, while this field is an id that is sent to the
> > > coprocessor firmware in order to identify the platform.
> > > 
> > > > > +  apple,temporal-filter:
> > > > > +    description: Whether temporal filter should be enabled in firmware
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > >
> > > > And why is this not enabled always? Why this is board specific?
> > > 
> > > Not every board has support for this feature.
> > > 
> > > > You miss here ports or port. ISP usually gets signal from some camera or
> > > > other block.
> > > 
> > > For complex cameras - yes, but this is closer to a UVC camera connected
> > > via a bespoke protocol. We do not need to deal with the sensor access,
> > > all of it is managed by the coprocessor firmware.
> > > 
> > > > > +        properties:
> > > > > +          apple,config-index:
> > > > > +            description: Firmware config index
> > > > > +            $ref: /schemas/types.yaml#/definitions/uint32
> > > >
> > > >
> > > > No duplicated indices. You have reg for this, assuming this is index.
> > > 
> > > There are duplicated indices, see isp-imx248.dtsi in patch 5 for an example.
> > > 
> > > > All these do not look like hardware properties but rather configuration
> > > > of sensor which should be done runtime by OS, not by DT.
> > > 
> > > Those are board-specific and not discoverable via the ISP protocol.
> > 
> > But they are settable through the ISP protocol, aren't they ? For
> > instance, looking at isp-imx248.dtsi, the first four entries are
> > 
> > 	/* 1280x720 */
> > 	preset0 {
> > 		apple,config-index = <0>;
> > 		apple,input-size = <1296 736>;
> > 		apple,output-size = <1280 720>;
> > 		apple,crop = <8 8 1280 720>;
> > 	};
> > 
> > 	/* 960x720 (4:3) */
> > 	preset1 {
> > 		apple,config-index = <0>;
> > 		apple,input-size = <1296 736>;
> > 		apple,output-size = <960 720>;
> > 		apple,crop = <168 8 960 720>;
> > 	};
> > 
> > 	/* 960x540 (16:9) */
> > 	preset2 {
> > 		apple,config-index = <0>;
> > 		apple,input-size = <1296 736>;
> > 		apple,output-size = <960 540>;
> > 		apple,crop = <8 8 1280 720>;
> > 	};
> > 
> > 	/* 640x480 (4:3) */
> > 	preset3 {
> > 		apple,config-index = <0>;
> > 		apple,input-size = <1296 736>;
> > 		apple,output-size = <640 480>;
> > 		apple,crop = <168 8 960 720>;
> > 	};
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
> If my memory serves me right the presets wre added as workaround for
> userspace not handling V4L2_FRMSIZE_TYPE_STEPWISE well (or at all) and
> the added complexity of handling the qadratic sensor with partially
> occluded or outside of the usable lens diameter corners.
> 
> It is a simplified description of the hardware to make it useable for
> most software which is expected simple uvc cameras.

I understand that. Ideally userspace should be fixed, but in the
meantime, I'm fine with the driver exposing a set of presets. They
should however not be listed in DT, but computed by the driver based on
properties that describe the device (such as, for instance, the full
sensor resolution, or the visible area). Those properties could come
from DT, or be hardcoded in the driver on a per-compatible basis.

> There are still two common issues in user space software related to this
> driver:
> - software expects width == linesize
> - resolution selection is based frame height, i.e. it prefers 1080x1920
>   over 1920x1080 on devices with quadratic sensor.

I share your pain, having to fix userspace when doing kernel work isn't
always fun :-)

-- 
Regards,

Laurent Pinchart

