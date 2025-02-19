Return-Path: <linux-pm+bounces-22416-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C35F9A3BD89
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 12:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A092D3AB06E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 11:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EE31DF977;
	Wed, 19 Feb 2025 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="ZnGEtjMO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IzobVLZJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483F21DE4F1;
	Wed, 19 Feb 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739966263; cv=none; b=hpRtMW5zGEV0FGPrPzLhbBydj6eTE+9bQBUHewNnTrmZc8PtWL2AhaHX2Hmsw8Nt/KSOOHWjUiQ1J6i63TMEd+yCQpDFxVjC1xCKw2FoxWvIG/xHVGBILPpeyO+GqjeH9LxgaI2TIpYDknxcE6M7Gj8l3iPlhIMCHeQgF19Bp9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739966263; c=relaxed/simple;
	bh=4k1po3JFC/xg27AWImd+emnF0oRfoeOXjB0dtgrtVAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lW89LfIfM36R9D+7GM046jQDQqNkhsebXYOKrwozMAVYrSIUupybZzzFF+U93vXFxTIxTiaSfYtWs5SQT965fhpjqbyhnXVTRfcTv3J+9jGAZQtBvIfDwWOmOg/M5bYvjXoDxsqAFXhZIF4QuwAi/gxmqrUA5Qx7G38qWt0Z/YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=ZnGEtjMO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IzobVLZJ; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 16F85201789;
	Wed, 19 Feb 2025 06:57:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Feb 2025 06:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739966260; x=1739973460; bh=I0Vr7zjYe+
	LzROidf2KdAM0FeJYDrHAhTGLGwi7YtgU=; b=ZnGEtjMO7AINmHlgXsViick38g
	sED8BBGIc4vzI41aYcZkvTv7tMmAl2CYypqi/XpBgIOnw4FeODoyNg6k/Nwozko6
	FG1C9nOXlX0m7D/o+o+W5E7qYe8GZUiThYWscNV56K5BEsjhrgg4vLd1bafjQacS
	HyFLGOCBOnCPUVRs/3YHXR1CmSfZCNHiSswIzMN+kl9ksfrq6QVL3nRi5UUztm4N
	vf4nTRNkGlb4c46UEZShn+nUkeTKRR1ZL3bagN91houWTDWm6pF5AVBvqYV2BvYA
	EH+B2ru4qHb9l1SjjB8fPHes6nJdDEp5P6v/uLHQdQKMiCshRC6JA4MIR2NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739966260; x=1739973460; bh=I0Vr7zjYe+LzROidf2KdAM0FeJYDrHAhTGL
	Gwi7YtgU=; b=IzobVLZJfukFykt4i6eVYyGagYUSdLzrJ+kKgK1Myd6dRmFXfUE
	YA+IeAxWbmpKjDFOihiqLar4F+Be478YgB9W8Wn9sGt3nSNpuQXAiDk35OuntrbP
	WJqmHKBbx2YNN96srbSNwih0n02nvIs8oho4ZOOFwfh5/ot4ZVEc6BPygetHlkfV
	5UaKeDhUeaSkXBKcs2mpXUynscIBmhwnCmXy6LlECjHYN9qoPd+VzeQTRy1FG4JO
	0jSeggenWwrBLkldkYL5Hg+9Gu31FG4kMOAFrMhw/d3y+x36QV+2UO6ckEGf4PmW
	N8m1RdbNcjl95Tp0/FTxBXNQemWNZYwMYGA==
X-ME-Sender: <xms:M8e1Zxc4nEkIU6aRDFmOLJEnMwle1yw3vBQokwHqBww3xJX-FLtoiQ>
    <xme:M8e1Z_OnEqGXRTGc7gJV2j_IKi5pFbtScK2_pHqmtWbprCq_rz9LYJndYi1PWTQPl
    sMlBM-8LXj90ANfRqc>
X-ME-Received: <xmr:M8e1Z6gsOt17SienMM3DX3KO-YnyORDYQlR6NaUsKnVEWjNAKA6aAjvroxOA-vLR6Bap90M129j1yS7EvkdVM61jb56rNs71--0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
    cuggftrfgrthhtvghrnhepgfdvffevleegudejfeefheehkeehleehfefgjefffeetudeg
    tefhuedufeehfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopedvvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheplhgruhhrvghnthdrphhinhgthhgrrhhtsehiug
    gvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehfnhhklhdrkhgvrhhnvghlsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepkhhriihksehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdprhgtphhtthhopegrlhihshhs
    rgesrhhoshgvnhiifigvihhgrdhiohdprhgtphhtthhopehrohgshheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrtggrnh
    esmhgrrhgtrghnrdhsth
X-ME-Proxy: <xmx:M8e1Z69fp5UtCDSgtdHbRJOaO6ofWHA2pUkPtu7-mXVd_uPZq9m01g>
    <xmx:M8e1Z9u70kv0LcFER15ThwwD-6Leqc-OUjgUeztpCvcFeRjPRXN89A>
    <xmx:M8e1Z5FaSzYMQq6TOOLDR414dl66AOYDTbo4t-79vgvVpzp10ilNBw>
    <xmx:M8e1Z0NnvX9Z8_L15P1RSf9-_AVkLw7jf1ETZNCsoqK7vgkwZhbNvw>
    <xmx:NMe1ZxSGnD2ua2i_owXFtXWucBE25DO8kebyhgs0H0RDLv74zlzz5HC2>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 06:57:38 -0500 (EST)
Date: Wed, 19 Feb 2025 12:57:37 +0100
From: Janne Grunau <j@jannau.net>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Message-ID: <20250219115737.GB26386@robin.jannau.net>
References: <20250219-isp-v1-0-6d3e89b67c31@gmail.com>
 <20250219-isp-v1-3-6d3e89b67c31@gmail.com>
 <16f6d4a2-2102-48b9-a0ae-b8c6595975b8@kernel.org>
 <CAMT+MTR7dhtt3SOMg0K3UakJQftqnc2S-rV41HdHtA+o9aSPug@mail.gmail.com>
 <20250219105326.GA31383@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219105326.GA31383@pendragon.ideasonboard.com>

On Wed, Feb 19, 2025 at 12:53:26PM +0200, Laurent Pinchart wrote:
> On Wed, Feb 19, 2025 at 10:54:31AM +0100, Sasha Finkelstein wrote:
> > On Wed, 19 Feb 2025 at 10:37, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > +
> > > > +  apple,platform-id:
> > > > +    description: Platform id for firmware
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > >
> > >
> > > No, use firmware-name.
> > 
> > Not sure how is firmware-name an appropriate field, fw-name is a string
> > that references a firmware file, while this field is an id that is sent to the
> > coprocessor firmware in order to identify the platform.
> > 
> > > > +  apple,temporal-filter:
> > > > +    description: Whether temporal filter should be enabled in firmware
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > >
> > > And why is this not enabled always? Why this is board specific?
> > 
> > Not every board has support for this feature.
> > 
> > > You miss here ports or port. ISP usually gets signal from some camera or
> > > other block.
> > 
> > For complex cameras - yes, but this is closer to a UVC camera connected
> > via a bespoke protocol. We do not need to deal with the sensor access,
> > all of it is managed by the coprocessor firmware.
> > 
> > > > +        properties:
> > > > +          apple,config-index:
> > > > +            description: Firmware config index
> > > > +            $ref: /schemas/types.yaml#/definitions/uint32
> > >
> > >
> > > No duplicated indices. You have reg for this, assuming this is index.
> > 
> > There are duplicated indices, see isp-imx248.dtsi in patch 5 for an example.
> > 
> > > All these do not look like hardware properties but rather configuration
> > > of sensor which should be done runtime by OS, not by DT.
> > 
> > Those are board-specific and not discoverable via the ISP protocol.
> 
> But they are settable through the ISP protocol, aren't they ? For
> instance, looking at isp-imx248.dtsi, the first four entries are
> 
> 	/* 1280x720 */
> 	preset0 {
> 		apple,config-index = <0>;
> 		apple,input-size = <1296 736>;
> 		apple,output-size = <1280 720>;
> 		apple,crop = <8 8 1280 720>;
> 	};
> 
> 	/* 960x720 (4:3) */
> 	preset1 {
> 		apple,config-index = <0>;
> 		apple,input-size = <1296 736>;
> 		apple,output-size = <960 720>;
> 		apple,crop = <168 8 960 720>;
> 	};
> 
> 	/* 960x540 (16:9) */
> 	preset2 {
> 		apple,config-index = <0>;
> 		apple,input-size = <1296 736>;
> 		apple,output-size = <960 540>;
> 		apple,crop = <8 8 1280 720>;
> 	};
> 
> 	/* 640x480 (4:3) */
> 	preset3 {
> 		apple,config-index = <0>;
> 		apple,input-size = <1296 736>;
> 		apple,output-size = <640 480>;
> 		apple,crop = <168 8 960 720>;
> 	};
> 
> But I may be interested in capturing a 640x480 frame with cropping only
> and without scaling, with
> 
> input-size = 1296x736
> output-size = 640x480
> crop = (328,128)/640x480
> 
> Or I may want my cropped frame to be located in the upper-left corner:
> 
> input-size = 1296x736
> output-size = 640x480
> crop = (8,8)/640x480
> 
> If I set those parameters through the ISP protocol, won't it work ?

If my memory serves me right the presets wre added as workaround for
userspace not handling V4L2_FRMSIZE_TYPE_STEPWISE well (or at all) and
the added complexity of handling the qadratic sensor with partially
occluded or outside of the usable lens diameter corners.

It is a simplified description of the hardware to make it useable for
most software which is expected simple uvc cameras.

There are still two common issues in user space software related to this
driver:
- software expects width == linesize
- resolution selection is based frame height, i.e. it prefers 1080x1920
  over 1920x1080 on devices with quadratic sensor.

ciao Janne

