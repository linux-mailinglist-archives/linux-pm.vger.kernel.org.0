Return-Path: <linux-pm+bounces-4216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D8485EC81
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 00:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A37A1B24064
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 23:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F68312880F;
	Wed, 21 Feb 2024 23:05:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240B73E468;
	Wed, 21 Feb 2024 23:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556741; cv=none; b=bXcMDhUU45iTmapSH3iJqVi4U5DZUlaIqmVF7umkSYZXfsAc8RHpaYurwx1KXm6ivfYMO8bsg2au9V0v5Qe0jc7xeKrxsp9omEYEBV0+DStBlGFtuDEMhHwjtCu/YRnY7W+QOoeX03bCEXreiFqT8lQWZrnbWumVcIjo5GuUJu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556741; c=relaxed/simple;
	bh=NnvRUAyFHTIEDi19k6wPNSwWy9GnJV6NSHSAwcj2IXg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HnE9AEvqI6Ihywoq6m+At4uTDydAO1+nn9eHZQ+f6roqAHqD1zp/mUXgAMOPNuek1ZUNuzm/GXZ5jAW0LmZcj7pNnIoehYbQHlHDn4YP7wUE+ty7nuyl5t/XGinsgiBK+2QfOdTnYL9s21EQHkuKlc8Yv8YjkIWez493DTQpbKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BCBC433F1;
	Wed, 21 Feb 2024 23:05:40 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id CF62F106B79E; Thu, 22 Feb 2024 00:05:37 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Andrew Davis <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <3b267fb1b303f63248934a1a77bee319e1c44879.1708458882.git.geert+renesas@glider.be>
References: <3b267fb1b303f63248934a1a77bee319e1c44879.1708458882.git.geert+renesas@glider.be>
Subject: Re: [PATCH] power: reset: rmobile-reset: Map correct MMIO resource
Message-Id: <170855673784.1674060.18055929794438307814.b4-ty@collabora.com>
Date: Thu, 22 Feb 2024 00:05:37 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Tue, 20 Feb 2024 20:55:53 +0100, Geert Uytterhoeven wrote:
> The registers related to reset generation are located in the second
> register block.  However, the conversion to device life-cycle managed
> ioremap function accidentally changed the mapping to the first register
> block.
> 
> 

Applied, thanks!

[1/1] power: reset: rmobile-reset: Map correct MMIO resource
      commit: 6f005ab7f5814bcbb58154167c282f03fc35db6a

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


