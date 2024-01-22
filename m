Return-Path: <linux-pm+bounces-2496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47C8836CE5
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 18:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8E31C26DC9
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 17:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719543F8E1;
	Mon, 22 Jan 2024 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BZr22Qnf";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="xEkHQKlL"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE014D590
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940019; cv=none; b=oQHdOclZxRmEElSqNRLsLBw295Sp6qBaJTFjisECCSbL2ZUgxmfywPEwH4TZN47DB2FFKsTVgykoINCOXaEszT/XbejG3sFNpDDmsa4/l26IrbGSF8pBqXqhFKrJe/2HYmNgTrNtJlDtuFc4Uk80MTWB+2PtFVjQxED/lP+FpDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940019; c=relaxed/simple;
	bh=vVFbQAZQaCV1Nt2m+xFmWWvr4pQM73xG49Al6bRM/Qk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c4oNTYz2gQM9pVhYLlvKsIfHsqD9+FvYLoru/o1M36ogyTEAk03IDvAF3ONOP1oJucbD+C2Fiob70GN9hTCiJ6wFcC0i6VhKs+PMXVBPMm3p6qFHARm3J/pyiRKGsrAq4cI0VlO02wSndCR27zvr7b20einyjcXFjm2cZmzofkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BZr22Qnf; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=xEkHQKlL; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 39E79291B2;
	Mon, 22 Jan 2024 11:13:37 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=vVFbQAZQaCV1Nt2m+xFmWWvr4pQM73xG49Al6b
	RM/Qk=; b=BZr22QnfYPKhRKm8YZwP/qabCDa9tI51LKkb1ah1kdgxiwjhFZbh8s
	rF7D/amev0Q2h6E4He25tlsHdb0HzGyI+X84zR6k7JqjJdsqcHRnRxuwvms34jSM
	vPGW4l7LJ/3Cx+xJw2WtbZAOV6TQexkiBcDhIoRW6lMh1JwRqnneI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 33D2F291B1;
	Mon, 22 Jan 2024 11:13:37 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=vVFbQAZQaCV1Nt2m+xFmWWvr4pQM73xG49Al6bRM/Qk=; b=xEkHQKlL0cmZY7u5wTfQK9xWwlTGQvdZiTHr2SZbmxtEjE5N7LiISk6RDg9LLudyQf2EDmlb9RMoy6XF99Rh0YybydGArC+YJ27iwEmMd9t9ezA2+i8FR2VIEbFbuqiTp4dXGh8WnB7nYXk7/a9nz5tjUqP2170Uq1I3H8cEYbA=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 238F1291AA;
	Mon, 22 Jan 2024 11:13:32 -0500 (EST)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id D6749AF577D;
	Mon, 22 Jan 2024 11:13:29 -0500 (EST)
Date: Mon, 22 Jan 2024 11:13:29 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
cc: linux-pm@vger.kernel.org
Subject: Re: [PATCH 8/9] thermal/drivers/mediatek/lvts_thermal: allow early
 empty sensor slots
In-Reply-To: <152d56e7-9d98-4d7e-b3f8-d29c8dae0a8a@linaro.org>
Message-ID: <637r7n03-9o9p-97r2-s92o-o015860n66n9@syhkavp.arg>
References: <20240111223020.3593558-1-nico@fluxnic.net> <20240111223020.3593558-9-nico@fluxnic.net> <9d8100dd-11a8-482f-83a1-85bfc34f1746@linaro.org> <3047p728-p0pp-9qs5-qnn4-95s23qo2735n@syhkavp.arg> <f0805135-6b4b-4691-ae97-d3f995e52e88@linaro.org>
 <36665522-1225-n119-6ns4-2n3p0086orp7@syhkavp.arg> <152d56e7-9d98-4d7e-b3f8-d29c8dae0a8a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 2FD54B06-B941-11EE-88A4-A19503B9AAD1-78420484!pb-smtp21.pobox.com

On Mon, 22 Jan 2024, Daniel Lezcano wrote:

> On 22/01/2024 16:23, Nicolas Pitre wrote:
> > On Mon, 22 Jan 2024, Daniel Lezcano wrote:
> > 
> >>
> >> Hi Nico,
> >>
> >> On 19/01/2024 17:53, Nicolas Pitre wrote:
> >>
> >> [ ... ]
> >>
> >>>>> +		skip = lvts_ctrl_data->skipped_sensors;
> >>>>>     		lvts_sensor[i].msr = lvts_ctrl_data->mode ==
> >>>>> LVTS_MSR_IMMEDIATE_MODE ?
> >>>>> -			imm_regs[i] : msr_regs[i];
> >>>>> +			imm_regs[i + skip] : msr_regs[i + skip];
> >>>>
> >>>> Overall the series look ok but this changes is hard to understand.
> >>>>
> >>>> Could you propose a different approach to have the resulting code easier
> >>>> to
> >>>> understand ?
> >>>
> >>> I'm not sure how I could make it simpler. Maybe a comment is in order
> >>> though?
> >>>
> >>> The sensor controller has 4 slots. Those slots are accessible either
> >>> through imm_regs[<slot_number>] oe msr_regs[<slot_number>].  If, say,
> >>> slot 0 is unpopulated then sensor 0 (i = 0) needs to address slot 1 (i =
> >>> 0, skip = 1), sensor 1 is in slot 2 (i = 1, skip = 1), etc. Does this
> >>> make sense?
> >>
> >> Why not keep the sensor id = slot id and declare the ones which are
> >> disabled
> >> with a mask?
> > 
> > Then what do you do with the empty sensor 0? Do we want to present dead
> > sensor IDs to users?
> 
> You can skip it somehow in lvts_ctrl_start(), right?

I see what you mean. Indeed that would be better.


Nicolas

