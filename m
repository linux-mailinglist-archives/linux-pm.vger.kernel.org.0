Return-Path: <linux-pm+bounces-42190-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OOtIDduhWnqBQQAu9opvQ
	(envelope-from <linux-pm+bounces-42190-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 05:29:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D44FA14B
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 05:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D13723058D42
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 04:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDE22E0401;
	Fri,  6 Feb 2026 04:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="DauKu45s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED472DB79C;
	Fri,  6 Feb 2026 04:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770351896; cv=none; b=bw3UpjdPtmkOs91Stwtcwd77IODOkZf7S0cXUAMM3++RB/jMxFV8C2MG5VfvuQMrSu5svcMUtV3Maj/5QTFw8Xq9glerZujcVzVzEdvYeUWKX6IKABH2guCOk8a1nT3yffkffm+inyFqpYRqPdGoD0QA7daFO/Jzmvxa6yXKFqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770351896; c=relaxed/simple;
	bh=oCAKsvXt8uZY203fBKI3gjJz6X6a7pHd3R1zvMeozgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NC1cOHUyYDyBnqZFHDNpi+qNPnJlvKCWGwPMLKdCatJ4qGyttq5mq56aCrLG95E40H5k4hlMjTtA+uQFZNk2zQsc/T8YU2/lY9Bp96AfmTo87nvXHHjMhNjY0tPEkFpXbDtashXa+zbnu9iAswxycW4YVhqBJTTDnYQkupSJFCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=DauKu45s; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (84-231-56-127.elisa-mobile.fi [84.231.56.127])
	by mail5.25mail.st (Postfix) with ESMTPSA id 32A1260B1A;
	Fri,  6 Feb 2026 04:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1770351895;
	bh=oCAKsvXt8uZY203fBKI3gjJz6X6a7pHd3R1zvMeozgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DauKu45sll2ojZjepiJH9Jenf680K86qCh5AFSyUA4sUZyRnUoKAB431+OkS4NO7/
	 jL6zSyrKHc5eC/GdbN9Bv4aDPAYq7Indzrz604fGEUylt6yVBfbIhXfCCVbFyOBr5i
	 VpUe0N7Lfg+335tBuwLyPIyIKijA7PZvCSJjVViNjrZb5ahtD/kDB64VlZaABdo6Ge
	 dBeI8m5qY4RJ2qolwD+T/qeZ1dVjyaUaL250mqZpM6iwz7iY9YFDE88O6UGBYfcrXJ
	 D49B15Pg1Ia1J6ySImAXTskkm48VfqUV2C7uw7QaPt3cibEJ+Vfy37r6s3C/OmkNUO
	 clocgXunw+wYw==
Date: Fri, 6 Feb 2026 06:24:36 +0200
From: Tony Lindgren <tony@atomide.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] power: supply: cpcap-battery: pass static battery
 cell data from device tree
Message-ID: <20260206042436.GB5376@atomide.com>
References: <20260130134021.353688-1-clamor95@gmail.com>
 <20260130134021.353688-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130134021.353688-3-clamor95@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[atomide.com:s=25mailst];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[atomide.com];
	TAGGED_FROM(0.00)[bounces-42190-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[atomide.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tony@atomide.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,atomide.com:email,atomide.com:dkim,atomide.com:mid]
X-Rspamd-Queue-Id: 49D44FA14B
X-Rspamd-Action: no action

* Svyatoslav Ryhel <clamor95@gmail.com> [260130 13:40]:
> Add an option to populate battery cell properties from the device tree if
> the driver cannot access the battery's NVMEM.

Makes sense to me:

Reviewed-by: Tony Lindgren <tony@atomide.com>

