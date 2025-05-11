Return-Path: <linux-pm+bounces-26998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90023AB272D
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 10:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7263B987D
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 08:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62BE1BE871;
	Sun, 11 May 2025 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APBZo7dv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73791A0BFE;
	Sun, 11 May 2025 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746951549; cv=none; b=Fh3pPRhD8yGqYIn9JC229VFR+01SgojqM5Io0+eVxtcBjIpd6mCXTUZeMvQwW+7TkBGQCCvrxHo2EVDw3wwue7RhLQN3MKFPU/kLDfgKkvxsSEVQ/GGMCLXLKpzEQM7sIb6HKIFOuurOBXq/4tdMawMnaiY2aQsrHBY3+JK6Oe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746951549; c=relaxed/simple;
	bh=fyoSR2vLCkN9Of3j5viNH1hbR1jgKe6RpyBqQH/Is+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ShKeXKwZoWyHNbK9zhxnAxMX8MbUBpFgIZphDaijQaIiN8GloLwFARGaeaC/7NEIjVmPZkC0gwP7/3vnZHlXi86+/FwuYaXQT8crWWCENpHYN+9wCLJ8/acACCAH77iBLPCPbkH4xD3hUEGapUVSLR38Ab9PhX+YBlqZBi+8iSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APBZo7dv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D297C4CEF3;
	Sun, 11 May 2025 08:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746951549;
	bh=fyoSR2vLCkN9Of3j5viNH1hbR1jgKe6RpyBqQH/Is+0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=APBZo7dv5F2VZKeWmWhRDizhpN9GcxSb22TGPlLJeaVLaUK5ZD9eVDeNc5JSz63ww
	 b4uA4VK00OmmjgEEGqAIWDk/KKFxfLATKrEH219fbgwADwN1Wcq08hlc274mjprjB0
	 l/35jM+7H+DbeKlb3PdcCEaxAT5Nqirw7FOsMfbtzPpdU/81XAApoQOPdPwuy+Egig
	 LTjI9CFewESbBJ1MMRispKbJA/6I+ASIkPM/W6AHS21x+ShthdzBku54v+dTlKvikt
	 0Cj1Fwr+tu3HD/s7qYwQH6jcmN+1tiVcKNjD66LDLlezDC8T7kzvBbA1wY9sN90M4E
	 14fpLxazoBfQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336E4C3ABC5;
	Sun, 11 May 2025 08:19:09 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Sun, 11 May 2025 08:18:39 +0000
Subject: [PATCH v5 04/10] soc: apple: rtkit: Make shmem_destroy optional
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250511-smc-6-15-v5-4-f5980bdb18bd@svenpeter.dev>
References: <20250511-smc-6-15-v5-0-f5980bdb18bd@svenpeter.dev>
In-Reply-To: <20250511-smc-6-15-v5-0-f5980bdb18bd@svenpeter.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=891; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=d7cJ/m6HJgQ6SMj9oocBKxe7pX9DRz2PYGSqdwBEGoU=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4ZCbMlNLpf7W188qZ/+d8/jton7lh5fVXLgW0fBjmuvD
 r+V5GHy6yhlYRDjYJAVU2TZvt/e9MnDN4JLN116DzOHlQlkCAMXpwBM5M1mRoa1QlM3bq+e5qDL
 G6b4bxOTd3tB9OkZyh6bwpdv2BEobS/B8D9S4kFF3xpvRb7/28U9J/FmGfq/+tgpGtd5vGHvsRv
 b9nIBAA==
X-Developer-Key: i=sven@svenpeter.dev; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/default with
 auth_id=167
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: Sven Peter <sven@svenpeter.dev>

shmem_destroy isn't always required for coprocessor-managed buffers but we
still enforce that it exists. Just relax the check.

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



