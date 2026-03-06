Return-Path: <linux-pm+bounces-43844-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLRWKO/uqmmOYAEAu9opvQ
	(envelope-from <linux-pm+bounces-43844-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:12:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 416322238FD
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7A2B306B78A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 15:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396DB3B4E89;
	Fri,  6 Mar 2026 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuR2+eP8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166763AEF3C;
	Fri,  6 Mar 2026 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809663; cv=none; b=cUriGf4E8+wE6+n4zs4+S/e6Mx8gXEVmziJ3XGkkMs+6SpzZZhhcpeDEdAkO2ur5BwJ20JoTsgN67pwVnKEzLXC8Am8sLLlLK4gRpqSQQDVh/XEfTflRO8KrkyrIEnrF6O3RDh6QCcq5GX34NcGPPpIWI2d0RLfDzD+O2VJGgKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809663; c=relaxed/simple;
	bh=uHgkFtyc0A066Vp1JKuaQKpuyrLE7yGX6vBEpSKsAII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XQNTCe3BYc0rBGuT8RtGfx2VzsHb1ApeWAyVx6w0XWsQ+IPTAjUo1jATed3Jk8puvLJnbRWEp1Pql4bXb8CDy2jSauJLqyt887EvRHxSb1IotSF+Hb5ziechGOrc2//3nCBPwSHyZzvm4f8zLe3QxyRDHPu1xvSVlHGu/AAS2DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuR2+eP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18445C2BC87;
	Fri,  6 Mar 2026 15:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772809662;
	bh=uHgkFtyc0A066Vp1JKuaQKpuyrLE7yGX6vBEpSKsAII=;
	h=From:To:Cc:Subject:Date:From;
	b=DuR2+eP8lRGnDMxYF9ayxRAOYk/9w3OAg59BHP4YddGwXLCRWvyIvaHXyppNLLnrf
	 DOKP5c2LGNV/ibsUcQIVHyBN7zbMaqKEfs5pSIQIfosA2y9BB6kbx/2Dj7dyjUdr0P
	 OJ/dKjtHwvBnj/PYabXrEPV4DjE4E0ZJOd/9m0vL7dPdqyOs+b9p1Gq00bApje0TZj
	 LeKW260hItWJF/7PWOcS2d2r25e15qhvQJLxOQS5uTecCrUC/YmiRo0hLMo2lfK3X0
	 VTiTMw4Ud2KTnmGsNjs4xt9tkeWf6eQOn0C2OY76xjl6JLdxo3adtVqP9UfgwmoboG
	 yN0gcR5X/UF3g==
From: Arnd Bergmann <arnd@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: reset: reboot-mode: fix -Wformat-security warning
Date: Fri,  6 Mar 2026 16:07:34 +0100
Message-Id: <20260306150738.497978-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 416322238FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43844-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.982];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arndb.de:email]
X-Rspamd-Action: no action

From: Arnd Bergmann <arnd@arndb.de>

The device_create() function expects a format string to construct a device
name, so passing a variable here introduces a possible vulnerability in
case the string can contain '%' characters:

drivers/power/reset/reboot-mode.c:148:22: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
drivers/power/reset/reboot-mode.c:148:22: note: treat the string as an argument to avoid this
  148 |                                                  (void *)priv, reboot->dev->driver->name);

Use an trivial "%s" format instead and pass the name as the string to be
included here.

Fixes: cfaf0a90789a ("power: reset: reboot-mode: Expose sysfs for registered reboot_modes")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/reset/reboot-mode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index ad239e96774b..d20e44db0532 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -145,7 +145,8 @@ static int reboot_mode_create_device(struct reboot_mode_driver *reboot)
 	}
 
 	priv->reboot_mode_device = device_create(&reboot_mode_class, NULL, 0,
-						 (void *)priv, reboot->dev->driver->name);
+						 (void *)priv, "%s",
+						 reboot->dev->driver->name);
 	if (IS_ERR(priv->reboot_mode_device)) {
 		ret = PTR_ERR(priv->reboot_mode_device);
 		goto error;
-- 
2.39.5


