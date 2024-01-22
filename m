Return-Path: <linux-pm+bounces-2487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D20836C1D
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 17:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A53B27D5D
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 16:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7AA3E462;
	Mon, 22 Jan 2024 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OPMpQeVF";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="0CJSnUAg"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF4B3D962
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937032; cv=none; b=Ri3xtRVJvvfXQCGEteWPtUgh/vuIoXHYXxP2TPMXZSkhd3CX3D9hWGQCtCjzZlFWAfzRUdV453TVUM7Gv/0Yre7Lxn7/Gy4oxftYDKdQwhjV4xZ+15HH20FIw3JToQ1EuHYDooNPx1p/UD7ileGG03oFLzHvgdl/1NBiCWQiVCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937032; c=relaxed/simple;
	bh=DiDcHX2Hy4aaB32E/xKAww08AHRwWkpWn2PRJbAixSo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rTLhEgG5Wksm19CSfTXiB4ENXkjut5huOw20VSYLuWIy7beIk0k8eQaOgxtfIzVHqN3EcCkayXz/epWaKzWEbfikgtiaSyE00DL4YvGJ/xLTEEYtwzR4Aq0dAI2YgN2NFm8T+buDGmRAWgsVFilbeRkavFB/EF4MYN8vC+0Gr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OPMpQeVF; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=0CJSnUAg; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CB6B628B96;
	Mon, 22 Jan 2024 10:23:44 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=DiDcHX2Hy4aaB32E/xKAww08AHRwWkpWn2PRJb
	AixSo=; b=OPMpQeVFtUp5umn8hFHclWevRHdvBtkqJfFn92lfhHVqv+RwWrpr4C
	uyYfio9eBTjkFkCieEX+4oLdSqBx0a/Y2GRFChiVNWNqApRz2rdC2cI6vphyPoDE
	8q1FQ8Ez4mHie4t2D/g2Z6My0nPPHxEivfIvkAQN+rqm11eQHLTrs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C50F328B95;
	Mon, 22 Jan 2024 10:23:44 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=DiDcHX2Hy4aaB32E/xKAww08AHRwWkpWn2PRJbAixSo=; b=0CJSnUAgL6pDRUkg+3OAgXm3F12MQvq0CuKCHfqd0n+/LlBo5OznOv8VdwCz4hSl4vISXANj/FRrhJGZQI+LNb7RQ8wm9EfT++t1H6PhMAzE+6Heh7qOJN/sBSxfGuL4gfzBZkzZphPeMoPXaXTagHBhJ6DElPj7XMK7sT4UPQs=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 20A6328B91;
	Mon, 22 Jan 2024 10:23:37 -0500 (EST)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id D14AAAF5650;
	Mon, 22 Jan 2024 10:23:34 -0500 (EST)
Date: Mon, 22 Jan 2024 10:23:34 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
cc: linux-pm@vger.kernel.org
Subject: Re: [PATCH 8/9] thermal/drivers/mediatek/lvts_thermal: allow early
 empty sensor slots
In-Reply-To: <f0805135-6b4b-4691-ae97-d3f995e52e88@linaro.org>
Message-ID: <36665522-1225-n119-6ns4-2n3p0086orp7@syhkavp.arg>
References: <20240111223020.3593558-1-nico@fluxnic.net> <20240111223020.3593558-9-nico@fluxnic.net> <9d8100dd-11a8-482f-83a1-85bfc34f1746@linaro.org> <3047p728-p0pp-9qs5-qnn4-95s23qo2735n@syhkavp.arg> <f0805135-6b4b-4691-ae97-d3f995e52e88@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 36AB419E-B93A-11EE-ADAA-A19503B9AAD1-78420484!pb-smtp21.pobox.com

On Mon, 22 Jan 2024, Daniel Lezcano wrote:

> 
> Hi Nico,
> 
> On 19/01/2024 17:53, Nicolas Pitre wrote:
> 
> [ ... ]
> 
> >>> +		skip = lvts_ctrl_data->skipped_sensors;
> >>>    		lvts_sensor[i].msr = lvts_ctrl_data->mode ==
> >>> LVTS_MSR_IMMEDIATE_MODE ?
> >>> -			imm_regs[i] : msr_regs[i];
> >>> +			imm_regs[i + skip] : msr_regs[i + skip];
> >>
> >> Overall the series look ok but this changes is hard to understand.
> >>
> >> Could you propose a different approach to have the resulting code easier to
> >> understand ?
> > 
> > I'm not sure how I could make it simpler. Maybe a comment is in order
> > though?
> > 
> > The sensor controller has 4 slots. Those slots are accessible either
> > through imm_regs[<slot_number>] oe msr_regs[<slot_number>].  If, say,
> > slot 0 is unpopulated then sensor 0 (i = 0) needs to address slot 1 (i =
> > 0, skip = 1), sensor 1 is in slot 2 (i = 1, skip = 1), etc. Does this
> > make sense?
> 
> Why not keep the sensor id = slot id and declare the ones which are disabled
> with a mask?

Then what do you do with the empty sensor 0? Do we want to present dead 
sensor IDs to users?


Nicolas

