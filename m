Return-Path: <linux-pm+bounces-11667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D7F94132A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 15:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4272F28607C
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 13:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB5B19E826;
	Tue, 30 Jul 2024 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKkNToPS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A9563D;
	Tue, 30 Jul 2024 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346352; cv=none; b=qDvhtLRQw1Oyugk5RW52ZgtT5NGSQn3FqmRhC3bhWqd+HYL4/SZlFZStj9h9QljQb58aPZRUjXODQCotmJf5afdS5rqeYZ7hUrnFObrwE6FmsbjXYj/4iiJc2GBxUCmm2Zmhgu7FDN3Zo6T3emBDgvK6mfkRLpGhLBmfEkNMMUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346352; c=relaxed/simple;
	bh=Ww/3YfXLpMTtcse++NJb5y4ZU/aN97sPUvyeSo23DdI=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=T0CUJY3T0VhGarIXBOaB/bUQCpSVVcQ84y9ZIM1OSgNtyfNZ/oxPRlP7irWjRIRS2PBG4aTHv4z8654KqOw3aleB0VTjisEyZPPZ1J81TGR7xOPdFORnRx85ZMGjyjXc+sbX0LCjKiOUuj3o2HodBONJiRRPanOSHnF4eSdIr7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKkNToPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F77C4AF0A;
	Tue, 30 Jul 2024 13:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722346350;
	bh=Ww/3YfXLpMTtcse++NJb5y4ZU/aN97sPUvyeSo23DdI=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=DKkNToPSLS8T7sk+M5aux4vSCiJUoWztVWWYIqp+bn2ZSH/grzDx9NoII3CBNmiPd
	 gkG2/N0kGhTZBnrTKmECYFTu2VE4hgFB/njzoBXrMcFA6HM3zqTALjphMSd+1fnNPF
	 o7MjFhJSf9EiXy9e9RN9TuhHm2aWw8BbScyDsBTZhG04tlgL3vf34kE0cuaq2kYdqz
	 zcVsVEg1vdJ/pKlr7KKD4IaIbEmXEfLGT8kMMHPV12bynt3HCrcyaYg48fWgrkjjg5
	 g+9UEuYesyoBplAznq+bhkoORpx26BiZcwTYanfY6Lwa5o0E9QSp8NdY3MV9KrD2vA
	 ynz8GyBkqogcQ==
Message-ID: <218e3904b3f78d72cdbb7c9bf17db4ac@kernel.org>
Date: Tue, 30 Jul 2024 13:32:28 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Stefan Wahren" <wahrenst@gmx.net>
Subject: Re: [PATCH V2 08/16] drm/vc4: hdmi: add PM suspend/resume support
In-Reply-To: <20240728114200.75559-9-wahrenst@gmx.net>
References: <20240728114200.75559-9-wahrenst@gmx.net>
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org, kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, "Artur
 Petrosyan" <Arthur.Petrosyan@synopsys.com>, "Daniel Vetter" <daniel@ffwll.ch>, "Dave
 Stevenson" <dave.stevenson@raspberrypi.com>, "David Airlie" <airlied@gmail.com>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jassi
 Brar" <jassisinghbrar@gmail.com>, "Jiri Slaby" <jirislaby@kernel.org>, "Lukas
 Wunner" <lukas@wunner.de>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, "Minas
 Harutyunyan" <hminas@synopsys.com>, "Peter Robinson" <pbrobinson@gmail.com>, "Ray
 Jui" <rjui@broadcom.com>, "Scott Branden" <sbranden@broadcom.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "Ulf Hansson" <ulf.hansson@linaro.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

On Sun, 28 Jul 2024 13:41:52 +0200, Stefan Wahren wrote:
> Add suspend/resume support for the VC4 HDMI component in order
> to handle suspend to idle properly. Since the HDMI power domain
> is powered down during suspend, this makes connector status polling
> pointless.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

