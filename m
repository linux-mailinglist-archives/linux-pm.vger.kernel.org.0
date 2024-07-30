Return-Path: <linux-pm+bounces-11666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C66D941324
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 15:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8211F24A90
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 13:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E3B194098;
	Tue, 30 Jul 2024 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfZhJT6D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDDD63D;
	Tue, 30 Jul 2024 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346337; cv=none; b=Yz2JHPI3jpNBlUBSADvu/gTfqs5K8ux10KBiIBBdZ7g3bip+9ipm7PqPg09jujqrzM2cdN4O7+loxHmyD1tmjTTGUPjhJlBf0WN6VnQHJheXrcSnfu+tOc+l521uvldcsjIeqXopRSZd4JiqDF1bdV6pNJDYc94ieFi4a7Mscaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346337; c=relaxed/simple;
	bh=/SYPq5kzaJCWlXFJH/J2536byhSWwshx5r1swTz714g=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=d9AAkzCBM7iu/ozK7OXkD50NtvtCcOlJQk+YnVIkXRscg5VMd3I9pEFwxCrtsNx6to40eX8UP47dcJVe5aXD8PNfN3U45YZQAZm4St1YFmUp5b9GQoGVjqxtSplNyErpQUXTESjRVDp/m4YfTw0eUiocUhUl5oSzpulpUl1tuXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfZhJT6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E01C32782;
	Tue, 30 Jul 2024 13:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722346336;
	bh=/SYPq5kzaJCWlXFJH/J2536byhSWwshx5r1swTz714g=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=tfZhJT6D/wUZ0ckLDQgQWKQkkP7BhnjJqAlRf4eGkUi+geNzdkfMyFOs/4d/hJXNY
	 ORwgcKkMvCW3HDV1Av0afni2CHFZFM6gUySKQJBzP9BB6+wHTDzBihy08+LEvz8hRk
	 AojUASUHCPbx9PH0q1lu4xUVjhSchsjLFd6bsp4Ip+jMwxGkUa0Ja5Bq0e+AWjsU/r
	 75z4hOaHj0Ss38RHwsRPbYHQIW5So0LuKDWUkDq0bhcRo5aLmaCyG+KZVY1iTe0VxE
	 gIkrj3BNHae4nUkP5gEN9ilVGMFESRZDsZXOLEYhc7l4EYtoC/QMyFnRlkeLiVp+Ai
	 HukSuAMey4nEw==
Message-ID: <0dd8ca7c0c0800b21120bbf3cf177d1e@kernel.org>
Date: Tue, 30 Jul 2024 13:32:14 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Stefan Wahren" <wahrenst@gmx.net>
Subject: Re: [PATCH V2 06/16] drm/vc4: hdmi: Handle error case of
 pm_runtime_resume_and_get
In-Reply-To: <20240728114200.75559-7-wahrenst@gmx.net>
References: <20240728114200.75559-7-wahrenst@gmx.net>
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

On Sun, 28 Jul 2024 13:41:50 +0200, Stefan Wahren wrote:
> The commit 0f5251339eda ("drm/vc4: hdmi: Make sure the controller is
> powered in detect") introduced the necessary power management handling
> to avoid register access while controller is powered down.
> Unfortunately it just print a warning if pm_runtime_resume_and_get()
> fails and proceed anyway.
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

