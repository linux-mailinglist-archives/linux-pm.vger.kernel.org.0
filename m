Return-Path: <linux-pm+bounces-28398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C22BEAD3E71
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 18:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8FE189BD76
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BACA24166F;
	Tue, 10 Jun 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRy7mozZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1010823F26A;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571840; cv=none; b=fXC8lwdkI93TWFAszQEvrEWNGPOBMeG6vmgFUIVmTSftC8QeEELljtq6g1aNOLRuR8rePs0TKILbhnmWNxB5mEB8VU0iY5HlWTdhASjEKlRY/l3fJRvWGb5Lmkrv90ZlzY4TcC0BdPVQqdeyZcvNLLz4lVu8PSl43wIb7dkDbzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571840; c=relaxed/simple;
	bh=8AHayrsdUhbqQMcspAGbazKi3nWfZBzVE3Bi2u++Vts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S9syw6E16DGLavTcuRWKIrRL7IigE0Nhg3W/UQqBVHxkkUQdcL97aTic3gEaAHWW+v9LrdQKVOjlXwHrQa5NqvuAgPLlW/jFLUChR5XWnVYYr49a+WSCHIgLiQiMd+AUK5GJOkWnOiiULRoMSZf2hE6cskDnxkmucsHqrnKagEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRy7mozZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81EF5C4CEFA;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749571839;
	bh=8AHayrsdUhbqQMcspAGbazKi3nWfZBzVE3Bi2u++Vts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZRy7mozZmTZtMXeg5kTY8XxSdQNQ8J4sjPhHeZI+koSVcL2WMvUppih5TRtunv13n
	 574/jhpTEAvnkL2ZcuJvpNNQJuVrnpVI8j0DTz9WzBSzJM7jnc48fYqTu4hRhOk/OJ
	 iT2kLT/brZGg1/j1mN2vdCc2mt7gUhUUKVTZXqdH3jkLRl+ZT7O3VOcUHgXY4sL1zU
	 y5qfJJrSY684CgknFYjqGRESPGCHmf5J7wP2V9gCMDqlsjOa9m/dIrEK9ghjoN/6L+
	 2ZfTA49DW0d1fFnp3buPNO5yVmlAMx0cuzpryDVZZ0aGDXs3dCXoksU68jy64d2cZc
	 CGrWPlVgbMInA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B67C71131;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Tue, 10 Jun 2025 15:29:45 +0000
Subject: [PATCH v7 04/10] soc: apple: rtkit: Make shmem_destroy optional
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-smc-6-15-v7-4-556cafd771d3@kernel.org>
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
In-Reply-To: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=985; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=8AHayrsdUhbqQMcspAGbazKi3nWfZBzVE3Bi2u++Vts=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4aHf6lPwZLfTr37rzZuMXQr0dpkvWbLfuZE+Svuj3t+2
 f2/5dLbUcrCIMbBICumyLJ9v73pk4dvBJduuvQeZg4rE8gQBi5OAZhInBnDP7XK0ExmQdffcXVM
 M9RMPdfsesw44UyPqY7Zo7pL3xbLqzAyTJ5+ULtCpehDnRsHV35Xy+puxf+3u76KLbmkPHtT4Za
 JLAA=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

shmem_destroy isn't always required for coprocessor-managed buffers but we
still enforce that it exists. Just relax the check.

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Sven Peter <sven@kernel.org>
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



