Return-Path: <linux-pm+bounces-41866-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wa8tBwE2f2nDlgIAu9opvQ
	(envelope-from <linux-pm+bounces-41866-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 12:16:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2342C5B6A
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 12:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2013430022EA
	for <lists+linux-pm@lfdr.de>; Sun,  1 Feb 2026 11:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAC727FB3E;
	Sun,  1 Feb 2026 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="IAFO/5ia"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A114F3EBF22;
	Sun,  1 Feb 2026 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769944572; cv=pass; b=lkbr2e8CytACNsdQXVFZowNasyX6QcLMjxF56QxAN4YLcXTYEHC6qwT3l7qzeze5WyQSwGSo/BParx1IpAm8owpfVdP+peD7y6M4lwZKVvKwm6p5DvmMM0bm+nbsr7fyIW3bMrNjonFD2KozejRDxkWcsaluAbnvRAR2I5Yy3j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769944572; c=relaxed/simple;
	bh=n/uBuw0drGPJJyQB+HxpY+41UIP2wuvAa+CcA2vk5rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKfk65ygtu4UOIBi7FuLHl+ACVa/KeukYIhclbaBvlxU2FzC6xN2NBDO5wBOgFD/0JzqJ0foxsfrENngF3EA4EEqKXZtiVPg+0sL7GlHr+slmaNY5QPI/0P35H4N/AGey/V43nHM8JFrc6VGQtp2oNupRQ177Hg9xit4+SXbfAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=IAFO/5ia; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1769944558; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NZ3kXzRHA5V1kaGR6EMp2tl7Jfk0bYCQN2Iew0NTrc/GjioIfXcB0GoJ8gp4C6b7DckQym/AOmUp7tgaoTvNKODsPVx5Rut4y29pODiFAXLINNbaHVl1hbsiLjPSWfJYRR+XVrQFC3TceFdB8ipMNByxVscpQP9oqbHKs0Apl6I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769944558; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Lln9T+9WYFEENfA8Q5OoZDMyLhXrk9yxE0MH9+RRXfw=; 
	b=QykMyTUij10MdV5OS7Hhip+MgENSYhRq5ioY3MgxZvui7OWNVe1r0F4SJNSFKrMVLEiPopmSvENazphoyPYQpURHo7iYY27OW66wqgmO2hTrhWKjxvHHLf9q2SiKamBuObuJ/Qi9ZEDKdW9yD2A2CbVVIffPgS05zWBZVhysOuo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769944558;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=Lln9T+9WYFEENfA8Q5OoZDMyLhXrk9yxE0MH9+RRXfw=;
	b=IAFO/5iaJOXkcHkUAqRp54cN3QLNEmYSpuRe+N3IE9Q/ERL1KXTaRyUjobGERENM
	IKQ8OrRj+REJa+Ob4BirljPVISV/MCH+g+Ch9YeL8JrYsBhh8zXGq9LRjzyySEKXl87
	PRvNeckDpDxxHLQGj2CJ3fqMQo2E4VQU9vn5QUDc=
Received: by mx.zohomail.com with SMTPS id 1769944556287768.3176811007377;
	Sun, 1 Feb 2026 03:15:56 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 303EA18090E; Sun, 01 Feb 2026 12:14:58 +0100 (CET)
Date: Sun, 1 Feb 2026 12:14:58 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: add support for S2MU005 battery fuel
 gauge device
Message-ID: <aX8yPp2JVubxHNFJ@venus>
References: <20260126-s2mu005-fuelgauge-v1-0-68a146ed0819@disroot.org>
 <20260126-s2mu005-fuelgauge-v1-2-68a146ed0819@disroot.org>
 <aXq7NohfIy3c5AWL@venus>
 <DG2QBROWWMLI.2EE3CBLLPAJHR@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG2QBROWWMLI.2EE3CBLLPAJHR@disroot.org>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[protonmail.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41866-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,collabora.com:dkim]
X-Rspamd-Queue-Id: C2342C5B6A
X-Rspamd-Action: no action

Hi,

On Sat, Jan 31, 2026 at 04:44:36PM +0530, Kaustabh Chakraborty wrote:
> On 2026-01-29 02:59 +01:00, Sebastian Reichel wrote:
> >> +static int s2mu005_fg_get_status(struct s2mu005_fg *priv, int *value)
> >> +{
> >> +	int current_now;
> >> +	int capacity;
> >> +	int ret;
> >> +
> >> +	ret = s2mu005_fg_get_current_now(priv, &current_now);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (current_now <= 0) {
> >> +		*value = POWER_SUPPLY_STATUS_DISCHARGING;
> >> +		return 0;
> >> +	}
> >> +
> >> +	ret = s2mu005_fg_get_capacity(priv, &capacity);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (capacity < 90)
> >> +		*value = POWER_SUPPLY_STATUS_CHARGING;
> >> +	else
> >> +		*value = POWER_SUPPLY_STATUS_FULL;
> >
> > Usually there is some kind of hysteresis that stops charging
> > when the battery is full and then restarts charging once the
> > battery drops under a certain capacity. As this code first
> > checks the current to determine if the battery is discharging
> > and only then checks if the battery is full - does your code
> > toggle between FULL and DISCHARGING?
> 
> (Perhaps I misunderstood your query, let me know if I did)
> 
> It has been a while since I last tested this - but as far as I can
> recall, after a certain threshold, the current would constantly bounce
> between -ve and +ve. I believe it was somewhere around 90% to 95% and
> above. If that's what 'hysteresis' is, then yes.

A typical charging setup is:

1. charge to 100%
2. stop charging
3. wait for charge to drop under 95% (or some other treshold)
4. restart charging
5. go to 1

> An older revision of this driver (I don't have it anymore) used to add
> up the consecutive values of current in order to reduce the effect of
> this inconsistency, but it was still unreliable.
> 
> Moreover, I do not possess any documentation for this device, so it's
> not possible for me to know what or how.

For the setup I described above, you consider everything above the
treshold as POWER_SUPPLY_STATUS_FULL independent of the current
direction. So you need to reorder:

if (capacity >= 90)
    return POWER_SUPPLY_STATUS_FULL;

if (current_now < 0)
    return POWER_SUPPLY_STATUS_DISCHARGING;
else if (current_now == 0)
    return POWER_SUPPLY_STATUS_NOT_CHARGING;
else
    return POWER_SUPPLY_STATUS_CHARGING;

Greetings,

-- Sebastian

