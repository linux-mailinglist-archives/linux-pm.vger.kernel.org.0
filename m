Return-Path: <linux-pm+bounces-23901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6071A5D6C1
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 08:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4B8188F12B
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 07:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885491E8847;
	Wed, 12 Mar 2025 07:00:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512801E51F2;
	Wed, 12 Mar 2025 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762814; cv=none; b=QN3BoIyc7Oy9GoDmArtH34XntsQayavv/TqzQgA3nu6uTLCUhz2pWdb9QvctrUovwbjDPdfpZANkrLo60+0bPRKil9oezj6YGupUo9OHuYEnIS6pa/bWFB9woD3iji0OTRr2KJhjGbaPEaqZ6Xvn62i4CTF0fwo3GtY3EyaG9NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762814; c=relaxed/simple;
	bh=1CJTcYCwsRFZ+O5NMSrgDfguy72KHW9i2ywGHIEpo7E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rZgB1Fspi8XFz2u3myjcZaRIoSEZksILwEMt3OdLYBMCKC0RT0+SAB8jG7ug/2V7ss76MEOEoB5Azh4bijYNTfAsuFWZfAkQwipVet7hvODzziTgr3GFnCrkdiCcSip4ctg7kA7vXwRrZajd/S8V2mcO4Uesp78YCkX8iujRHx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6DAC4CEE3;
	Wed, 12 Mar 2025 07:00:13 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 334031806F4; Wed, 12 Mar 2025 08:00:05 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: arnd@arndb.de, lee@kernel.org, dmitry.torokhov@gmail.com, 
 sre@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, 
 alexandre.belloni@bootlin.com, danielt@kernel.org, jingoohan1@gmail.com, 
 deller@gmx.de, linus.walleij@linaro.org, brgl@bgdev.pl, 
 tsbogend@alpha.franken.de, linux@treblig.org
Cc: linux-mips@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250311014959.743322-7-linux@treblig.org>
References: <20250311014959.743322-1-linux@treblig.org>
 <20250311014959.743322-7-linux@treblig.org>
Subject: Re: [PATCH v2 6/9] power: supply: pcf50633: Remove charger
Message-Id: <174176280519.183324.14039063530250449155.b4-ty@collabora.com>
Date: Wed, 12 Mar 2025 08:00:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 11 Mar 2025 01:49:56 +0000, linux@treblig.org wrote:
> The pcf50633 was used as part of the OpenMoko devices but
> the support for its main chip was recently removed in:
> commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")
> 
> See https://lore.kernel.org/all/Z8z236h4B5A6Ki3D@gallifrey/
> 
> Remove it.
> 
> [...]

Applied, thanks!

[6/9] power: supply: pcf50633: Remove charger
      commit: aae075a93f7705e29c599d101abc7e467125d871

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


