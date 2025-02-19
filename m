Return-Path: <linux-pm+bounces-22409-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77888A3BC16
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 11:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5F3188CE8A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 10:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD351DE893;
	Wed, 19 Feb 2025 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FsDMIXgV"
X-Original-To: linux-pm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702411CD210;
	Wed, 19 Feb 2025 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962425; cv=none; b=g4wXR8HyW6tzrtYvcCrQNamTKE8yaD5m9AKadxQFpW6Ln5ABldFzPewAtB+SqNqH1LCMyKdroJ3jEoRPH/lzbLOQtux9JtIPPBcTTnUKrCCUR7BHaZnljzxKgcE+FZkXYT+LDGIWrJlnZfCz71M4ILYAT4sBGW5aK91r8fLQFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962425; c=relaxed/simple;
	bh=qkBui9Y/YZZlWr0k6NIZHQ0EzjwMCEqSGitfOdkZ31c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEgt8PKSDfquJ3T04kj1G36MEjpePgZOdxGDYR15fc0coG+IQ8ufetkkkZQSwXDnJ55zZgOO7DKWU+WUoU6R0BBQX6dPqTyK48ApREo5G/jzdBbWdyOsi66CTNH/v5ftnk3n5x7jl/4C46R5b3C9FmXlZalI4RDj8cHvNLwYCDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=FsDMIXgV; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D52E6514;
	Wed, 19 Feb 2025 11:52:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1739962339;
	bh=qkBui9Y/YZZlWr0k6NIZHQ0EzjwMCEqSGitfOdkZ31c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FsDMIXgVIj+M99QzzVl0kcdX9WO7NxyJ/LheWbkb6fESOgcDOgdar+TdAi4ZrY4Wt
	 MALRsIZcOITBQ5LteJsKTEJaa9dfdhMDVJLgN98BJ5m7m3vL9vfOVdHRtQ2I4Vb3R1
	 Qv57Rv/BaGPcLqkqd4A31YvD/CCXcn6hB0XB9yJU=
Date: Wed, 19 Feb 2025 12:53:26 +0200
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
Message-ID: <20250219105326.GA31383@pendragon.ideasonboard.com>
References: <20250219-isp-v1-0-6d3e89b67c31@gmail.com>
 <20250219-isp-v1-3-6d3e89b67c31@gmail.com>
 <16f6d4a2-2102-48b9-a0ae-b8c6595975b8@kernel.org>
 <CAMT+MTR7dhtt3SOMg0K3UakJQftqnc2S-rV41HdHtA+o9aSPug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMT+MTR7dhtt3SOMg0K3UakJQftqnc2S-rV41HdHtA+o9aSPug@mail.gmail.com>

On Wed, Feb 19, 2025 at 10:54:31AM +0100, Sasha Finkelstein wrote:
> On Wed, 19 Feb 2025 at 10:37, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > +
> > > +  apple,platform-id:
> > > +    description: Platform id for firmware
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> >
> >
> > No, use firmware-name.
> 
> Not sure how is firmware-name an appropriate field, fw-name is a string
> that references a firmware file, while this field is an id that is sent to the
> coprocessor firmware in order to identify the platform.
> 
> > > +  apple,temporal-filter:
> > > +    description: Whether temporal filter should be enabled in firmware
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> >
> > And why is this not enabled always? Why this is board specific?
> 
> Not every board has support for this feature.
> 
> > You miss here ports or port. ISP usually gets signal from some camera or
> > other block.
> 
> For complex cameras - yes, but this is closer to a UVC camera connected
> via a bespoke protocol. We do not need to deal with the sensor access,
> all of it is managed by the coprocessor firmware.
> 
> > > +        properties:
> > > +          apple,config-index:
> > > +            description: Firmware config index
> > > +            $ref: /schemas/types.yaml#/definitions/uint32
> >
> >
> > No duplicated indices. You have reg for this, assuming this is index.
> 
> There are duplicated indices, see isp-imx248.dtsi in patch 5 for an example.
> 
> > All these do not look like hardware properties but rather configuration
> > of sensor which should be done runtime by OS, not by DT.
> 
> Those are board-specific and not discoverable via the ISP protocol.

But they are settable through the ISP protocol, aren't they ? For
instance, looking at isp-imx248.dtsi, the first four entries are

	/* 1280x720 */
	preset0 {
		apple,config-index = <0>;
		apple,input-size = <1296 736>;
		apple,output-size = <1280 720>;
		apple,crop = <8 8 1280 720>;
	};

	/* 960x720 (4:3) */
	preset1 {
		apple,config-index = <0>;
		apple,input-size = <1296 736>;
		apple,output-size = <960 720>;
		apple,crop = <168 8 960 720>;
	};

	/* 960x540 (16:9) */
	preset2 {
		apple,config-index = <0>;
		apple,input-size = <1296 736>;
		apple,output-size = <960 540>;
		apple,crop = <8 8 1280 720>;
	};

	/* 640x480 (4:3) */
	preset3 {
		apple,config-index = <0>;
		apple,input-size = <1296 736>;
		apple,output-size = <640 480>;
		apple,crop = <168 8 960 720>;
	};

But I may be interested in capturing a 640x480 frame with cropping only
and without scaling, with

input-size = 1296x736
output-size = 640x480
crop = (328,128)/640x480

Or I may want my cropped frame to be located in the upper-left corner:

input-size = 1296x736
output-size = 640x480
crop = (8,8)/640x480

If I set those parameters through the ISP protocol, won't it work ?

-- 
Regards,

Laurent Pinchart

