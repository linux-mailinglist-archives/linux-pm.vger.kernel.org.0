Return-Path: <linux-pm+bounces-7544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3F18BD3FA
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 19:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC80D1C21879
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 17:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA0915749B;
	Mon,  6 May 2024 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="H2AsBzTH"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FDC1F19A;
	Mon,  6 May 2024 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017414; cv=none; b=ShjB850D+kS5TH96hQ/mFG/3dY7i/eKbR7uYRKLkpIq0b9FFzK8XKCMHymmS6zmxa22b9MPD1vhNkPSho500octTomuEMroGMEfQcRpeqaOIKTU2RkD2fFFwmsQSWKtINAbac8u3foDBMjPSI7m2Nvbe/qdew+Jf7i50hvcwOYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017414; c=relaxed/simple;
	bh=i3HUuCZX9m/2gBCCOy4OI5YZMvQOTnUrERxRlGeDnbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow3mZj70BPeZb+6UsvhZ6nZ9AlCGuHKrv+CRGHN9y3s3TfAEYugUftb4jFskFk8IDHACSAuV0Vmko3TMu85r3rIlV+r7H3HpMbtQzrb4XuV2evNBhwFqBWlLyw0RmHMdry/DEVVKOCvaaCAVXOE0Z6V4qyZ2s9vrZdA3IR0mrho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=H2AsBzTH; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715017410;
	bh=i3HUuCZX9m/2gBCCOy4OI5YZMvQOTnUrERxRlGeDnbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H2AsBzTHkaZcXzgt/JDQfmrsQAjTfV7J5THSVYd4VDTan9vQQlPM/Vf/aCVQHyQCz
	 V6blYP+LSUQ3pHyp/rOhQVHCYz/5bdFQPr3XjSIkj4s5UBT3XyCk+CQKvoFce9okmQ
	 xwqQTIzmKXuS5CQfHEOLLL9v2w5Z74eprETEX2rg=
Date: Mon, 6 May 2024 19:43:30 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev, "Dustin L. Howett" <dustin@howett.net>, 
	Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/2] platform/chrome: cros_ec_framework_laptop: new driver
Message-ID: <e716716e-87fe-46f5-8ea9-5f649f1da11b@t-8ch.de>
References: <20240505-cros_ec-framework-v1-0-402662d6276b@weissschuh.net>
 <613369f9-42c5-4a59-b83f-45bd1773ffe4@t-8ch.de>
 <a7ae8fc0-5e53-487a-86c6-f49dc6623688@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7ae8fc0-5e53-487a-86c6-f49dc6623688@amd.com>

On 2024-05-06 08:09:07+0000, Limonciello, Mario wrote:
> 
> 
> On 5/6/2024 1:09 AM, Thomas Weißschuh wrote:
> > On 2024-05-05 22:56:33+0000, Thomas Weißschuh wrote:
> > > Framework Laptops are using embedded controller firmware based on the
> > > ChromeOS EC project.
> > > In addition to the standard upstream commands some vendor-specific
> > > commands are implemented.
> > > 
> > > Add a driver that implements battery charge thresholds using these
> > > custom commands.
> > 
> > It turns out that standard ChromesOS EC defines EC_CMD_CHARGE_CONTROL.
> > The kernel headers however only define v1 of the protocol, which is very
> > limited.
> > 
> > But in the upstream firmware repo there is a v3 which is much better.
> > 
> > The Framework laptop only implements v2 which is also fine.
> > Given that v3 was only introduced late last year, it seems better to
> > stick to v2 anyways for now.
> > 
> > So please disregard Patch 2, I'll see on how to use this via a normal
> > cros_ec driver.
> > 
> > There are some other Framework-only features that will use Patch 1,
> > so feedback for that would still be good.
> 
> What other kinds of features do you have in mind?

There are at least fan and privacy switch reporting in which im interested.
But fan reporting also has a standard command which I'll try to use first.

And then there are many others I'm personally not interested in:
Fingerprint LED configuration, Intrusion Detection, "Standalone mode",
some diagnostics, etc.

Especially as they can also be handled from userspace.

> Considering your above finding I think it's better to put patch 1 into the
> series of "other framework only features" that will use it so it's clearer
> if it's the best way or not.

Agreed, that is what I tried to express.

> [..]

Thomas

