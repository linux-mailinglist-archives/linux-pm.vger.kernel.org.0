Return-Path: <linux-pm+bounces-13007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEE19618C3
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 22:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCAD3B22E5C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 20:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720451D2F61;
	Tue, 27 Aug 2024 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="K7i3sjQz"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551DE1D2780;
	Tue, 27 Aug 2024 20:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791824; cv=none; b=AHYXQlgO718GdOGnP1wY8o2jlOQ1VUMY65el0GAX1SnFBovUU6PgEltBuQKcT2yVVBPFhSQL1dlq+4CCnjYHuQsnL+c1/gy7e0AtGN3Pvk+Avm5Zf+UWGbKvzIluLRUEaE35IrUsziWISMyGrpkI39y84inUK1wac4zS8Z08Zog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791824; c=relaxed/simple;
	bh=DaPpDOLdDNnDk2vHazhnfHvX+dF1HCoUgrtWN0SMHqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLKkNKY1eVkuTMb9piSaqHYhxGgVs7Yi2SJQo69MtpwekrOzMHGQuZYm1/UgSQACDssnC7HLgWW7TZC72CxRCb+oR7hLbVkLNlJWWWjPYgAzo1Y/uayAb5ZuZMmJI1HGRH2uMf04Gyj6xc+tbMRYzxHX00/pKkJBRhpM+b1mNGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=K7i3sjQz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1724791818;
	bh=DaPpDOLdDNnDk2vHazhnfHvX+dF1HCoUgrtWN0SMHqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K7i3sjQz5cC6N+KfqehyCPJR0KmOO3Db+kmx+Q1hmThUSH4crkPs7rdCmcmhehpMi
	 yAQwvmKEzq7EJUDDSoMi2k2xwAxLlkm6+RHynsAHbuwfYr3HgzXzQ2zNn2WMYtYHym
	 hZTN89pTKrqo1w1VT17UkVetELBECoWnLMsds/Fo=
Date: Tue, 27 Aug 2024 22:50:17 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andres Salomon <dilinger@queued.net>, linux-kernel@vger.kernel.org, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, platform-driver-x86@vger.kernel.org, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Sebastian Reichel <sre@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v4 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
Message-ID: <260a3e55-7072-4298-8fff-b5c2c674c65b@t-8ch.de>
References: <20240820033005.09e03af1@5400>
 <04d48a7c-cad1-4490-bbcd-ceb332c740bd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04d48a7c-cad1-4490-bbcd-ceb332c740bd@redhat.com>

On 2024-08-26 16:44:35+0000, Hans de Goede wrote:
> [..]

> Yes not being able to see the supported values is annoying I actually
> wrote an email about that earlier today:
> 
> https://lore.kernel.org/linux-pm/49993a42-aa91-46bf-acef-4a089db4c2db@redhat.com/
> 
> but we need to make sure that the output is consistent between drivers otherwise
> userspace can never know how to use the API, so for charge_type the dell
> driver should only output the active type, not all the options.
> 
> This reminds me that there was a patch-series to allow battery extension drivers
> like this one to actually use the power-supply core code for show()/store()
> Thomas IIRC that series was done by you ?  What is the status of that ?

Yes, that is from me, [0].
At least I'll need to implement the feedback from Sebastian and a proper
locking scheme.
I still intend to work on it, but if there are other people waiting for
it, I'll try to get on with it.

In the meantime maybe the psy core could export a helper function for
formatting and parsing? Similar to the charge_behaviour helpers.

[0] https://lore.kernel.org/lkml/20240608-power-supply-extensions-v2-0-2dcd35b012ad@weissschuh.net/

