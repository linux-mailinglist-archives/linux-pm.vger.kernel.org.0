Return-Path: <linux-pm+bounces-4480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F97686A42C
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 01:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD181F27B8E
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 00:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED081D6AA;
	Wed, 28 Feb 2024 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JT7nXI+s"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB27F41C8B
	for <linux-pm@vger.kernel.org>; Wed, 28 Feb 2024 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078424; cv=none; b=mVyPTYQzaI79sox8mPXEoJE5hDkZE8OtMWHQJFT3O+M+cw0km4P5dyUjET3fTkIFAGtvody1n6HAxaS3A31b+dEIqC+Ow9IbzHM4vYglPzN9QynMHBu10Lu22jwYdk3gAdWH8n5lymaB31UMLU9Lo4Y/A2TniEHUhNPYB0OFDm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078424; c=relaxed/simple;
	bh=RTbudAlLPl6Dq2xCqMevfXMdWNKynhSvpt8BFgxf7Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sv9xtVL1sceMTE27tLt7zEJ3JxzVnMEp2D5DRPfuSzxKNxovscxT/7Gu/U/CgnuKWhmadIS4uIIAYAhCH8rn2w6F0HzluhTa/M0zSrqOaeXfvtuVuCW4xD2G649WFX2FZo/EaYzB80rmGN6O2Cn3Zkwap8AHx/6b2Ss4MCexaRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JT7nXI+s; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709078420;
	bh=RTbudAlLPl6Dq2xCqMevfXMdWNKynhSvpt8BFgxf7Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JT7nXI+sD9t5mDC0R5V7LbtqhgLMN0Yb8R5ro4ZgDbS9c6keJY8JaBYVm+K98svKQ
	 o6H5TQLzUvk72zCmau3LtTR/XyHqMkK6lPMQTG23zk21ikc7HXSyH5wfOIPBtqS4AH
	 2WfGoGdFUJZvXeILYcYwbDPJBHHbcByyDpWniuq4S9onA2kYltAdb7FOQvG8iG3WlI
	 v9GSKj5SIXL3jVedk2Ww2v5Qx3HUs2nAlGhpe1AyKKiDnd0W/lATsdG0akjxXI5Y1f
	 jDN40vUN9sMSy6rrZXz9RqMxa/48hf8AQuMMfmSjc+q0XVLQSauhAa8NPUsrxv8ngz
	 yeZlh4sPKf58w==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A93843780629;
	Wed, 28 Feb 2024 00:00:20 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 1299D10606FC; Wed, 28 Feb 2024 01:00:20 +0100 (CET)
Date: Wed, 28 Feb 2024 01:00:20 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sicelo <absicsz@gmail.com>
Cc: linux-pm@vger.kernel.org, maemo-leste@lists.dyne.org, pali@kernel.org
Subject: Re: [PATCH] power: supply: bq2415x_charger: report online status
Message-ID: <5l3e3bkultb24kawad4vh3j4c6lo77i6hftumo234qgtwbk4jr@z7kbnrcgbdel>
References: <20240226194432.2174095-1-absicsz@gmail.com>
 <6slfmvqmtawwjlsobcfod6ewcjjbzmylz3owsdamdi4dod55wr@iiox5rzjj5ht>
 <Zd5VflcLb3Es1xiJ@tp440p.steeds.sam>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd5VflcLb3Es1xiJ@tp440p.steeds.sam>

Hi,

On Tue, Feb 27, 2024 at 11:34:54PM +0200, Sicelo wrote:
> On Tue, Feb 27, 2024 at 09:11:36PM +0100, Sebastian Reichel wrote:
> > On Mon, Feb 26, 2024 at 09:44:32PM +0200, Sicelo A. Mhlongo wrote:
> > > Provide the Online property. This chip does not have specific flags to
> > > indicate the presence of an input voltage, but this can be inferred from
> > > the reported charging status.
> > 
> > The datasheet suggests, that you can get the status from the fault
> > bits:
> > 
> > 011 - Poor input source or VBUS < UVLO
> > 
> Absolutely, yes. This particular state, which is a fault condition, clearly
> indicates VBUS is present.

I assumed this might be set for a disconnected charger, considering
that no input source is a poor input source / 0V is < UVLO.

> However, when there are no faults at all, then those bits always read
> `000`. On a running system, one can check this by connecting and
> disconnecting a charger (Nokia N900 used in my tests) while watching
> /sys/class/power_supply/bq24150a-0/registers. Only bit 4 changes state.
> In other words, the fault bits do not appear to be enough to determine
> the presence of an input voltage.

Ok.

> However, looking at them more closely seems to suggest I should respin the
> patch to also report VBUS online if a fault is reported instead of only
> during charging and charge full states.

Right, so you can just check for BQ2415X_CHARGE_STATUS != 0.

> Please let me know if this sounds correct, or if I misunderstood your
> reply.

Greetings,

-- Sebastian

