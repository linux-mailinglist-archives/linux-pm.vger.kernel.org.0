Return-Path: <linux-pm+bounces-27178-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEC9AB7DC3
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 08:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB10D4A554A
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 06:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E09296FC8;
	Thu, 15 May 2025 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmoyNGrq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D6F29291E;
	Thu, 15 May 2025 06:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747290134; cv=none; b=rKpN7VpQeeqF0DlUEHqCMKQeHXSksuPniRm9dxTFwfUH4IeU4jmfSFMhOdBFlHHj0IY57sYyAghUN9uR75/GUp+cTOMSsE6Ah+RdsscqweKrzThk7cYyoR/xC0oELHmIMuZiOfDIlak6Q2DIY4HjsSriwBgmDOEUiJ3rXudUdoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747290134; c=relaxed/simple;
	bh=ZTlgG1xJ95iorV2kQ1uOOiZAmYCxNo5uxDZJjiFp5/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uxAv77l3a8EOqpQeVKuGU+6/J96hLYuJ0JX26U+i4NpaW6R0gzU9Qrid2ZiRzXDk7+R0JTwwCbH6bvUGCLMjIIHFXAdJxybloLC33Ws9qTyTTDtlU+f1mGX4dYfQajQoaV0ZtU1R+spGE/asFlI5DZH4ZRLH9LDgMXJi8sUPbVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmoyNGrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 613F9C4CEF7;
	Thu, 15 May 2025 06:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747290134;
	bh=ZTlgG1xJ95iorV2kQ1uOOiZAmYCxNo5uxDZJjiFp5/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JmoyNGrqnlSDGeTlhHgVhPuktusa7m6uD/BoDhrcyr7mIYKime4rv8Hdkh5DvjGjx
	 e7oAI0GAzGZDP5RTwN93AGBWp1h5BGIKzvrF2B9hn9nttLktLNN185t9tT1mTbevDC
	 6e3IjDVSEKf4e76yQ2FnKkp8C1cfkTeqK1TPrG0a0ZvIXklnL2z3vKuHc6BccpofND
	 KuDbqDuuQ3TN+vKqwNcUvhr4c6gCMYufyriUor+imsAeopVX3FTbSE57bOt9CsD2g0
	 nz5x+jDefPnGtVe8ws5QL6ALyfqT0tKEC4yX0wG2wn9KdMyN+JSjIxxwfX88mNKpHC
	 MxQPTdu+8ROPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566A1C2D0CD;
	Thu, 15 May 2025 06:22:14 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Thu, 15 May 2025 06:21:16 +0000
Subject: [PATCH v6 04/10] soc: apple: rtkit: Make shmem_destroy optional
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-smc-6-15-v6-4-c47b1ef4b0ae@svenpeter.dev>
References: <20250515-smc-6-15-v6-0-c47b1ef4b0ae@svenpeter.dev>
In-Reply-To: <20250515-smc-6-15-v6-0-c47b1ef4b0ae@svenpeter.dev>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Hector Martin <marcan@marcan.st>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Lee Jones <lee@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=S6xAk2UkoAe3X4x66QooB7Xtvm6Gxfc3lvmrWufTKGQ=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4ZqBzdbfebvoIBftdcDeuLMnZ+uOBbEde78ixC3H6bOi
 WnJGk86SlkYxDgYZMUUWbbvtzd98vCN4NJNl97DzGFlAhnCwMUpABOxc2f4Hx/qcdw1LdnXgJlj
 RUuFaUmsTWDJ5ILZ81jdJhq516knMDKcca8pPqfWd9evsypv8RmPpF6jWZkzAya53OThCeYP/8w
 OAA==
X-Developer-Key: i=sven@svenpeter.dev; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/default with
 auth_id=167
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: Sven Peter <sven@svenpeter.dev>

shmem_destroy isn't always required for coprocessor-managed buffers but we
still enforce that it exists. Just relax the check.

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/soc/apple/rtkit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index 5fffd0f003dc2f4f377faf96cce0c1ce4ff0b788..b8d4da147d23f7e99e76eea314e4d976cddbd1c6 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -279,8 +279,7 @@ static int apple_rtkit_common_rx_get_buffer(struct apple_rtkit *rtk,
 	dev_dbg(rtk->dev, "RTKit: buffer request for 0x%zx bytes at %pad\n",
 		buffer->size, &buffer->iova);
 
-	if (buffer->iova &&
-	    (!rtk->ops->shmem_setup || !rtk->ops->shmem_destroy)) {
+	if (buffer->iova && !rtk->ops->shmem_setup) {
 		err = -EINVAL;
 		goto error;
 	}

-- 
2.34.1



