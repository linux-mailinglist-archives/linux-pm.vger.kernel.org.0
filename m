Return-Path: <linux-pm+bounces-36227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ABCBE212A
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 10:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 849CC3527EF
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 08:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33F02641D8;
	Thu, 16 Oct 2025 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="gEhAl96T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D83288515
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601706; cv=none; b=QkExB1ar5hVbBbvsDP4kI13voNJqscFz+wjFJQ7Qmvh9RoPMHzBM6udfS3qCL9D9GevcrViMXk/5q9b0IGNNeZnZfzWhUMIGCKKRLDk1VeVNGq7bgb0ObjQ05wkT7kp60LR4xRyLbvxXXKfJ2EXDN6bVbXgFo8lHQ0CtshcNeBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601706; c=relaxed/simple;
	bh=ua3pqrz+jWQC1IsyYn6xel+EbNBYCSK2YqeOPRApC3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqJ5oRfNh4EPwbd1cM969nXo35rTzZ99Iw+yqp3aSbI3XJgx5IEcVmUBeDH6Hvt92u4KnyipWn3P+Xlv/xKNq2l8niOZHTNVKgQMEZ/IjdFs4xYMuxRKz6sCJHVdgZK17j79rAz97QPTJGi6CbAD+2XNLXzJLYW7SPSpcKpXQRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=gEhAl96T; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=KaQl
	fOLQxAbgj+NhEIrNg1dhz5+ieYrTAINZg1rmjh8=; b=gEhAl96Thq6ifvpiapx3
	gVlGfr72Akr/W8tKGsh8WGEcimWzR6dpM9uoXzRKOE9HyT+eUArLlqqVxkQT8YBg
	opSkPRumvZLvau/ztt42WSkRgWIh3i/h9HBY6RSUbJumWF6K/M2RUYSSMM+Zj9E0
	IIiD3MgWFZMx6qudOh8lMt7kBaT641LJPuG3dtPA55VPfcGfqOtAnN33G1QpJ55L
	eaUiYfNjACn5q2kp/qPj3AQEK6enpkL+KhniwTUnoGSuBGxZpiLRYMqQh5zZARbu
	v0tzHRvwOMhF6evHH3uMFtALiLn2ObVIxjSW3w8wAK0LJqzrTae0jrIE8tUn4cdt
	2Q==
Received: (qmail 3717946 invoked from network); 16 Oct 2025 10:01:42 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Oct 2025 10:01:42 +0200
X-UD-Smtp-Session: l3s3148p1@WoERB0JBeKkgAwDPXwQHAL/S9V79e5yL
Date: Thu, 16 Oct 2025 10:01:42 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pm@vger.kernel.org,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] thermal/drivers/rcar_gen3: Document R-Car Gen4 and
 RZ/G2 support in driver comment
Message-ID: <aPCmZp8sM5oV2jPa@shikoro>
References: <20251015155905.186612-1-marek.vasut+renesas@mailbox.org>
 <aO_eLEFLAnjc8n4G@shikoro>
 <62670d89-56f2-419e-8f80-0536858415f3@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62670d89-56f2-419e-8f80-0536858415f3@mailbox.org>


> > I am not opposed to the patch. Just want to mention that such
> > information gets stale all the time, so I would suggest:
> > 
> > + R-Car Gen3 THS and compatible thermal sensor driver
> This won't cover RZ/G2 which something else, and Gen5 seems like it will be
> also a bit different, so maybe the list is now exhaustive?

Sorry, I don't understand: If RZ/xx THS is compatible with R-Car Gen3
THS, why is this not covered?


