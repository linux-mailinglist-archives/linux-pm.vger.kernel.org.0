Return-Path: <linux-pm+bounces-24031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0BCA6101E
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 12:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A386F7A6C1D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 11:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781701FF1B9;
	Fri, 14 Mar 2025 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0WnNX0b"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0DB1DF963;
	Fri, 14 Mar 2025 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952216; cv=none; b=V+kh1I4p2J9giGDD+pF3vlxO4ZBHRYCi1KkvC/DucIYmtIrJA027Y3fKm9/IDQNO4PwSERBvZ69OCHDlCYnhcbJEVpBZFC4N+/gQiG7XFzFvGVHtWEIR+tYIqGjPjpxpsV/AUNqG3y/F4VhDpvTAGFR1BC+t4EhdvL/A5nxtFhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952216; c=relaxed/simple;
	bh=5jbzIcEu7rwa00GINfO3vvUggjO6E96rtOU63PwyPi4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H4QpAWBgFT4hiuCO/BIqCUfAEK2jTh6en3AT7batD7LFlsQGnKjP5ofsI673Y/OY1m2Vt9oS5dmr5Ax1pCkIgPZso5gBAd/zrySMp9jn/LGuf1r5+hvQJw1V4utxp0E9i5qPwKE1QkpOhOZUhOLUynBIuHj1ZcgZUYibx0w17J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0WnNX0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB385C4CEEB;
	Fri, 14 Mar 2025 11:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741952215;
	bh=5jbzIcEu7rwa00GINfO3vvUggjO6E96rtOU63PwyPi4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=V0WnNX0bpdne7Oo1Vrr2fMv+OrFpEA/37KemBFxHsSPz5TI3wC8GPeFO163Tgof98
	 rmhHEndV9+n2gQ4Z2qVnWDrKyZh0sA8qzXaY1Tjm1mp8VW9DU24zXaUheG+FEC0k0c
	 tlwblQjPzdXvlsgUku9P/NKtVXWqznEe1+a9PujHoXItR/pxaUgpA0++3mdYp4xSza
	 nDQQBF/dpmSJcVgdlm+pKvKwzmxRXWWv36T0znSxjlvgg8w9sAXOg6Ou36Ks7h9iVb
	 YJVT9eXa4Yt96SfVsHe1O1po5Oc9oDs2Pijl7bub2ta8Vn+s6xaujUuTC4GNxaNXvD
	 WaSp2fEyAdp2g==
From: Lee Jones <lee@kernel.org>
To: arnd@arndb.de, lee@kernel.org, dmitry.torokhov@gmail.com, 
 sre@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, 
 alexandre.belloni@bootlin.com, danielt@kernel.org, jingoohan1@gmail.com, 
 deller@gmx.de, linus.walleij@linaro.org, brgl@bgdev.pl, 
 tsbogend@alpha.franken.de, linux@treblig.org
Cc: linux-mips@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250311014959.743322-8-linux@treblig.org>
References: <20250311014959.743322-1-linux@treblig.org>
 <20250311014959.743322-8-linux@treblig.org>
Subject: Re: (subset) [PATCH v2 7/9] backlight: pcf50633-backlight: Remove
Message-Id: <174195221155.4008217.14149921373468540055.b4-ty@kernel.org>
Date: Fri, 14 Mar 2025 11:36:51 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Tue, 11 Mar 2025 01:49:57 +0000, linux@treblig.org wrote:
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

[7/9] backlight: pcf50633-backlight: Remove
      commit: dfc034a0494b8fb8ea881aeb41a0c4e2619ff1e4

--
Lee Jones [李琼斯]


