Return-Path: <linux-pm+bounces-42075-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OecMyo/g2kPkQMAu9opvQ
	(envelope-from <linux-pm+bounces-42075-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 13:44:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 772DBE5F49
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 13:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE157300613B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 12:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C2A3F23AF;
	Wed,  4 Feb 2026 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYVLeejA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142F33F23A0
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770209061; cv=none; b=Vry/5XjFU8+IMsgX50NqbKd9XlULfL/ycdSP89xCkDwfbFDQ+AkX504fNEVlV024Xd/emU5R5VYslDFMdp9IHaAi7aX3TpPm7lqRRHhb72vInQ7UN3PI2cuvDWl478tQ/lU368WHFbNbSa1V6OzDOziJ/YKe8T+tUuGwEM0ckus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770209061; c=relaxed/simple;
	bh=2ccQeih6irYO5XzSFtymX8LSiL0DW7BGri+FxKdFDR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hV2Nls9t9wW7mAhzTJwvWT6w2uRHJb60mbBuvkQxv5MH3I8XJdvJKj8u9C5BLnY2+YL7mmFV+D6vffn0KmzPTrkBf7Vwt8I9pljPJUtyGWHmKYY9xDmdxdD+GpSBsHmvH8LG8W88ctHu2w6NXThdEj9GMfQsFNcsGjtTvuBLSfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYVLeejA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-435a517be33so4103966f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 04:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770209059; x=1770813859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HdeWbr93zk7sz3NtKAzxThy4aGeFCJLtK1+LR0Bzdck=;
        b=NYVLeejASjOK53lwlOzxLANcaoH9vubIJNtZxO6/TjzGJc+qkfYIEFtucOYzu2T7Iy
         tGpVQy0XFNf0r438iOZRWdAw6rnAiXI9z9f39jkdRXeLyckWdKSJHzyGIVgQe0Z5t4Fg
         TGPCNkrse4xVMHYfL/qRKkq1WvvHcj1MahqBbC+IPZ4Va+WNUHM/cITzyGdLRQl3DHsW
         WD56APQofcq/5FyR2D9TmavUgROtySZjjmyEUJgJ9nwAn69AzRWwsWzQufJOWJkWmy+T
         tssNBIi8F+/dtZv8LM/T6lGrFEM3un0+NGf5EuiT8oNabtuSENSzG6F+6cCH+3txonGy
         RQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770209059; x=1770813859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdeWbr93zk7sz3NtKAzxThy4aGeFCJLtK1+LR0Bzdck=;
        b=J8TTDTO4gdcl+ImvhGJ3xUh2OhZ7C5XJEEVg0gWe9FeMGtRa0JsuUCBJNZx3dYlxca
         SbMcE9sVzU+Ndnqhc+OQuPgKnkQkl2nYL2ixzv2srt8srA0kLkc+dXbbWWJ62OOs2XjO
         VfESkaEYLZmpytsN2fRnCGX3Ful3s4r/uERSGgdwkazaU5XlTzjOKOJ0YxfVA86kYR2l
         mBGOGEcRUIV8loXU2oyodIb9BjPy/4ajnWwXtZrRz69yqPZv3sSg9WuG9jAWhQ9NLytE
         4ypsinuEDzdCZV/hDAR38dhtZ6j30lSKMSTQPBvOMt7ajLpI0mYE20hThPm3CytZ8hko
         IOhg==
X-Forwarded-Encrypted: i=1; AJvYcCVgynLas54UIFZtIMXrptdebzZoiYUO5FgVp971GLp1ePfhFdRMbmPY4Z6JX9WTBy05o4FXkXzNqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9wMRFrOiEnXEdh4oN7KwQp+2LUyUzlFZtg4y4xe56VyeRBmNo
	ZEKN3Jy2f+qRiwfGA3vM2t1DevvsvPaq5WqnmffuWow0UH82/YfLlZxj
X-Gm-Gg: AZuq6aJvprw1tedczLPtNCkSpMcirYUaGscBVIDe8FOpnynjN6r/3Y0uEIwgt7aQ9fR
	vILCcCOd8FTORWfNuYnmGdMnyN/lKwlIpERRl+qQultdKsWdJMVukdIEt8VV/CYN/tIs2SG6FBU
	HAtn6DcXaNyJDSCfIX5ITPkRArPYlWtQ0M5un9s5lmDc+1QRogXZtxZlM22TR4v6T9fg9G3lfiu
	G/i6i3tND/VKsgfN1jsdOQ75oI+hsbblCidI4uEz1mwTSNcyrV5w7t16dvzRWg0iRRBaGQt6XQe
	1k8OqlFlHp1h92CT9W0GoIJB10DoQpvc6wuVpSUAqVeiKo4zZscY7WkmaiMPKlht/DqyTwkeoEy
	7FkmXw+ata5I3caV1FVVTX/Aq3IqFdlnJkIY4ok8n2gamPPtl0ilNPvsTzPIXlavJG3JTUdXZiv
	ca3+9ta3w=
X-Received: by 2002:a05:6000:2086:b0:435:ad52:31d9 with SMTP id ffacd0b85a97d-436180321b0mr4035154f8f.28.1770209059152;
        Wed, 04 Feb 2026 04:44:19 -0800 (PST)
Received: from legfed1 ([2a00:79c0:684:8900:e22:b7ee:dcfc:b04a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43618058473sm6521891f8f.22.2026.02.04.04.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:44:18 -0800 (PST)
Date: Wed, 4 Feb 2026 13:44:16 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: dimitri.fedrau@liebherr.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] power: supply: gpio-charger: add support for
 fast-charge timer
Message-ID: <20260204124416.GA3066@legfed1>
References: <20260109-gpio-charger-timer-v2-0-63fd1ba75830@liebherr.com>
 <20260109-gpio-charger-timer-v2-2-63fd1ba75830@liebherr.com>
 <aX0tJLqfY7b9oNAi@venus>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aX0tJLqfY7b9oNAi@venus>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42075-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dimafedrau@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[liebherr.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 772DBE5F49
X-Rspamd-Action: no action

Am Fri, Jan 30, 2026 at 11:19:44PM +0100 schrieb Sebastian Reichel:
> Hi,
> 
> On Fri, Jan 09, 2026 at 07:41:20PM +0100, Dimitri Fedrau via B4 Relay wrote:
> > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > 
> > On some devices like TIs BQ24081 battery charger it is possible to activate
> > or deactivate a fast-charge timer that provides a backup safety for charge
> > termination. In case of the BQ24081 it is a fixed 7-hour timer. Add support
> > for enabling/disabling the fast-charge timer via GPIO.
> > 
> > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > ---
> 
> The documentation is missing _a lot of information_. What happens
> when the fast-charge timer is disabled? What happens when it is
> enabled and times out? What do you expect users to do with this
> control knob?
>

Yes, you are right. Will add the missing information for the BQ24081.
When the timer is enabled and 7-hours are passed the device will enter
state "Timer fault" where charging is disabled and cannot be enabled
without powering the device down and up again.

Disabling the timer will just deactive the mechanism above but charging
is not affected by it.

It's just a safety feature that can be turned on/off.

Will add this information, am I missing anything else ?

Best regards,
Dimitri Fedrau

[...]

