Return-Path: <linux-pm+bounces-11631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B44940864
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 08:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960552843AD
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 06:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6625915B0E3;
	Tue, 30 Jul 2024 06:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2gzYx6r"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F723524C;
	Tue, 30 Jul 2024 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321061; cv=none; b=Lbe1mJRn7hRAKHZVW7liA0tGe8UOLRwli5mUJwZeLmGR7IwK9VGU2CLWVT6MfUEkkZXj8G/3Q5VPyDoiSDHeqv9UlGVoh6IgkBCBprQaocQBAv7YeZzSuuPM3ZZZu/ddq68StYi4sE7Yr0k4QCGnEw0PpRBbV032AhoAW1DbJto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321061; c=relaxed/simple;
	bh=113zHcxOpsbcwW11a7aMT7BENgNTSv1ngvCERVMP0f8=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=eONhWcoJczqPXU+hv08/U4T/Ng+QKvWVtxXqYDAtzfROCrtLvqzC+2qwWEtr6PZBAOwqINQk4TrsHNNDhgxUFLQvbGGKTZGxe6RsXeLDETLh8TNkffTKlggInOMWZ4oxi8E9p/l6U8CLn37CWOloPlAQQZy+A9ab8q3SB7tx07A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2gzYx6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FB7C32782;
	Tue, 30 Jul 2024 06:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722321060;
	bh=113zHcxOpsbcwW11a7aMT7BENgNTSv1ngvCERVMP0f8=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=D2gzYx6r0P05HsmdpYls3H21fhknAGjIqhHcv06vvRN3LHZT/jZgS/E2dxjcBRE3j
	 gu1CK+c8wLLxC+g71k0vt5byDFs49n2+2eV6zlXoNMd9+bzeVmSdjFPV87oNJFlQQ1
	 nVpZYlmHZoxoS9aaMQu8KU7BMPm2lTlOwse71KTO5rqolHCFrE0/SyMMg1cpf6G5RZ
	 PnMWPcBdZD3AJuEr1UvTT8Lx9nSjekrTnI/9TKyWIMqvrK5YCuNLifqZYvLGGIfQxA
	 qRedOyhRbBOSqdEODBBRdYnNAe0XBuQBp2N8tCBJ4uvZE8P3nck4XUmf2lZd0d7q6Y
	 wlG/GTJwF52/w==
Message-ID: <91f9c77f71fb1bce513a02d5e2800f04@kernel.org>
Date: Tue, 30 Jul 2024 06:30:58 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Stefan Wahren" <wahrenst@gmx.net>
Subject: Re: [PATCH V2 07/16] drm/vc4: Get the rid of DRM_ERROR()
In-Reply-To: <20240728114200.75559-8-wahrenst@gmx.net>
References: <20240728114200.75559-8-wahrenst@gmx.net>
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

On Sun, 28 Jul 2024 13:41:51 +0200, Stefan Wahren wrote:
> DRM_ERROR() has been deprecated in favor of pr_err(). However, we
> should prefer to use drm_err() whenever possible so we get device-
> specific output with the error message. In error case of kcalloc,
> we can simply drop DRM_ERROR(), because kcalloc already logs errors.
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

