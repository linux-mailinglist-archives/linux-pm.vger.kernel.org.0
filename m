Return-Path: <linux-pm+bounces-24032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC30A6103C
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 12:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1641887BCE
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 11:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4531FDE08;
	Fri, 14 Mar 2025 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUqIMvDk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F034C1FC7CD;
	Fri, 14 Mar 2025 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952606; cv=none; b=bFqN23fnunXroPvOzlY00hNIjgnAtbZRPwBXh0L+Tm3TJGbH8fJai6V6f4TVKCRjwtpnkI7oZSU1Za2/C73LQyDN4w1tJmORNb7R9ZfZkCLC//nzjLLjOavYmB0t29Tk/c8k8iI6D4C/B/esBNv3CmOnASQ56/YVf4zwJpic6yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952606; c=relaxed/simple;
	bh=HhnRgeIRMl8/ytxbRB5L7HJeFXLaGEfrKsFgITuJCvI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sMyDhzxCsi80pPeluV4fMN1Eim9fmCV3iA/Rgn6l4AICqZNUqGt05CkxXrgGANqPiEz3U0k9kD7O9v5fh0cbYITlSSPBukhpfM713t1HaTh4zblEgx6TE8CIgPGkQBx4vjwQ5zn4O9nUl2jXt47dk2hr2r9YbrKIlJfg4Q1A4kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUqIMvDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9191EC4CEE3;
	Fri, 14 Mar 2025 11:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741952605;
	bh=HhnRgeIRMl8/ytxbRB5L7HJeFXLaGEfrKsFgITuJCvI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rUqIMvDkJPFPCIq8jp3YHiYV3Gkj0ISBfNfEhyGb/UYdeNZ9wvPqnfLIeTOkKFmYV
	 dFNxLMNyjlpZZgoLlmVRwNAvDXLl+UYC1i5hq6DBp6/Im/fXKy+DukkMRx5nJmMupM
	 LjNMv+Y0nvOFd9gjlJidoByXiu2ub1uT5UW/KW5Xvvama+/3ffoD72FyGdBom6UsQY
	 h6h3ReIQtoB/BqwnOgT4gfBoUp0sTLFs7JlDIhBses8n7h+fsiqHNHPgbqAK+e6L0h
	 CaX0FIPH5AWPOKRsb+OOJxnXh+HkCy4HvK+lWQz4dKqVe6gt7eCFW+fNvtTWh3H6RH
	 I1lEigMyHyA+g==
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
In-Reply-To: <20250311014959.743322-1-linux@treblig.org>
References: <20250311014959.743322-1-linux@treblig.org>
Subject: Re: (subset) [PATCH v2 0/9] Remove pcf50633
Message-Id: <174195260130.4016186.12257329269298391220.b4-ty@kernel.org>
Date: Fri, 14 Mar 2025 11:43:21 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Tue, 11 Mar 2025 01:49:50 +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The pcf50633 was used as part of the OpenMoko devices but
> the support for its main chip was recently removed in:
> commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")
> 
> See https://lore.kernel.org/all/Z8z236h4B5A6Ki3D@gallifrey/
> 
> [...]

Applied, thanks!

[1/9] mfd: pcf50633-adc: Remove
      commit: 0d0e54953805af76f0022df39602f5668145f747
[3/9] mfd: pcF50633-gpio: Remove
      commit: 8559602247d0d054451c7a755942588d2c0de85d
[8/9] mfd: pcf50633: Remove irq code
      commit: 786ad21f4350601c9d118ddbd19b7b830c04ece6
[9/9] mfd: pcf50633: Remove remains
      commit: 44356090d59efd8db152e9eecb8e7f843be319f0

--
Lee Jones [李琼斯]


