Return-Path: <linux-pm+bounces-2389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD6D832D83
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 17:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12CCA28452A
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 16:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49B455779;
	Fri, 19 Jan 2024 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EBYraM/G";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="DE/ZRybo"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53CB3222
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705683227; cv=none; b=OSDlZk/o11x1R43K/nFk71VVtOsUDaslX2JHY9isvvZyLx44k4A/riUzAHSLGOjxIJQRdNnieUQuGBr2+dVPJRGjtHm0sm0xKx0yOwb6CP+TMaPdADji3LCeW4jPdiJ9SZwpHmrKByQatJtOGdnZ84UJiB/jbfuwqokl1Gd65wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705683227; c=relaxed/simple;
	bh=be34292gcijG4YTCfRacUui6Df28x+dYSL/rByDZ55w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JK5ZP8veo6TiOw0yCmHAEIXtP9kBSUR85mCtJ9bCt0AsItgIBPWObCXFukQv5UqH5vIi/MTHullcl3OQ15NQ0j/c5swUhvNm30d8Cg3Aw5CVU1O5R1nTmeIYEvRr7byCs+NppSU6yxEvoyawhIE9iQtPg7GXFVS4K4gCXyE3nvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EBYraM/G; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=DE/ZRybo; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D628D1F2B5;
	Fri, 19 Jan 2024 11:53:44 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=be34292gcijG4YTCfRacUui6Df28x+dYSL/rBy
	DZ55w=; b=EBYraM/GPslnpA4EgTOooYg00P0QJ7VLy6uff9m/lQQAwd9Loo9vmf
	Sa2h/eIdGYef1au2qXxao+k1AgJ2DaacURhFxvmTAgWRoqb1D2fAgZNqatl1QlnE
	0+d17CMVE0gdgJCTynDnmHqllB9b8ROjMXgUJ3kupvM2XcZhjCUWs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CD3501F2B4;
	Fri, 19 Jan 2024 11:53:44 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=be34292gcijG4YTCfRacUui6Df28x+dYSL/rByDZ55w=; b=DE/ZRyboe4rBATOUErGw52zNMhlEH5De9FomhKCJiUl8OOnDXgM/CrkqporK8aZ0VjkSHL0usmPjwxBN/XuxyY0GZZmbByj4Wc78IxJeMyxgG8ik8HokF3GmeQIO9gTewvk65idqZwelbHtXDuVDa8s8SIHPHV1RL0rqXT7UaZs=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A88EB1F2AE;
	Fri, 19 Jan 2024 11:53:39 -0500 (EST)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 6BCD0AEB001;
	Fri, 19 Jan 2024 11:53:37 -0500 (EST)
Date: Fri, 19 Jan 2024 11:53:37 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
cc: linux-pm@vger.kernel.org
Subject: Re: [PATCH 8/9] thermal/drivers/mediatek/lvts_thermal: allow early
 empty sensor slots
In-Reply-To: <9d8100dd-11a8-482f-83a1-85bfc34f1746@linaro.org>
Message-ID: <3047p728-p0pp-9qs5-qnn4-95s23qo2735n@syhkavp.arg>
References: <20240111223020.3593558-1-nico@fluxnic.net> <20240111223020.3593558-9-nico@fluxnic.net> <9d8100dd-11a8-482f-83a1-85bfc34f1746@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 4B9A48BC-B6EB-11EE-9550-F515D2CDFF5E-78420484!pb-smtp20.pobox.com

On Fri, 19 Jan 2024, Daniel Lezcano wrote:

> 
> Hi Nico,
> 
> On 11/01/2024 23:30, Nicolas Pitre wrote:
> > From: Nicolas Pitre <npitre@baylibre.com>
> > 
> > Some systems don't always populate sensor controller slots starting
> > at slot 0.
> > 
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > ---
> >   drivers/thermal/mediatek/lvts_thermal.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/thermal/mediatek/lvts_thermal.c
> > b/drivers/thermal/mediatek/lvts_thermal.c
> > index b20b70fd36..473ef91ea3 100644
> > --- a/drivers/thermal/mediatek/lvts_thermal.c
> > +++ b/drivers/thermal/mediatek/lvts_thermal.c
> > @@ -112,6 +112,7 @@ struct lvts_ctrl_data {
> >    struct lvts_sensor_data lvts_sensor[LVTS_SENSOR_MAX];
> >    int hw_tshut_temp;
> >    int num_lvts_sensor;
> > +	int skipped_sensors;
> >    int offset;
> >    int mode;
> >   };
> > @@ -555,6 +556,7 @@ static int lvts_sensor_init(struct device *dev, struct
> > @@ lvts_ctrl *lvts_ctrl,
> >   					const struct lvts_ctrl_data
> >   *lvts_ctrl_data)
> >   {
> >   	struct lvts_sensor *lvts_sensor = lvts_ctrl->sensors;
> > +
> >    void __iomem *msr_regs[] = {
> >     LVTS_MSR0(lvts_ctrl->base),
> >     LVTS_MSR1(lvts_ctrl->base),
> > @@ -569,7 +571,7 @@ static int lvts_sensor_init(struct device *dev, struct
> > @@ lvts_ctrl *lvts_ctrl,
> >    	LVTS_IMMD3(lvts_ctrl->base)
> >    };
> >   -	int i;
> > +	int i, skip;
> >   
> >    for (i = 0; i < lvts_ctrl_data->num_lvts_sensor; i++) {
> >   
> > @@ -604,8 +606,9 @@ static int lvts_sensor_init(struct device *dev, struct
> > @@ lvts_ctrl *lvts_ctrl,
> >     /*
> >      * Each sensor has its own register address to read from.
> >      */
> > +		skip = lvts_ctrl_data->skipped_sensors;
> >   		lvts_sensor[i].msr = lvts_ctrl_data->mode ==
> > LVTS_MSR_IMMEDIATE_MODE ?
> > -			imm_regs[i] : msr_regs[i];
> > +			imm_regs[i + skip] : msr_regs[i + skip];
> 
> Overall the series look ok but this changes is hard to understand.
> 
> Could you propose a different approach to have the resulting code easier to
> understand ?

I'm not sure how I could make it simpler. Maybe a comment is in order 
though?

The sensor controller has 4 slots. Those slots are accessible either 
through imm_regs[<slot_number>] oe msr_regs[<slot_number>].  If, say, 
slot 0 is unpopulated then sensor 0 (i = 0) needs to address slot 1 (i = 
0, skip = 1), sensor 1 is in slot 2 (i = 1, skip = 1), etc. Does this 
make sense?


Nicolas

