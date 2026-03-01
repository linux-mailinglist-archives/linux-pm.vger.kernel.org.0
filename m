Return-Path: <linux-pm+bounces-43374-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD7jNcVmpGlcfgUAu9opvQ
	(envelope-from <linux-pm+bounces-43374-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Mar 2026 17:18:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6363E1D0943
	for <lists+linux-pm@lfdr.de>; Sun, 01 Mar 2026 17:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09F703015484
	for <lists+linux-pm@lfdr.de>; Sun,  1 Mar 2026 16:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62822311957;
	Sun,  1 Mar 2026 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ZC26qWxq"
X-Original-To: linux-pm@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988B1E7C12;
	Sun,  1 Mar 2026 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772381863; cv=none; b=r6dVsXaVwKKp1xSOlFu01KWX4bbCZNMIKo4ghvSvS1Ntcc+3nyVn9/xjmRUvL6CvIInS0fZgdWvj85IrymoTV45wIfWZs3SjUv+4e0/vBY6ztqhLAkkrod0bdtF3nKs7QLZ8cus/wsPxWcgYgPsJAAdhxmOfbh70ySv51/1nMtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772381863; c=relaxed/simple;
	bh=hO3F7V+pajHlafGe+JZx8T5s2NE3zx6ZLjrHQQLSG80=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=LL57b4SxMqsjvPhF/ACCdoMkqEEXi46zQK7bqFtGT0A8n72rGPka+3nSPoLczlZtZkp0e6kDTwX2XR+AF2kKGW+OwO8utupqqU8ReuKJPM/0Dr5t0YitJzTJtVPG6EJp15YRyEwxgxAvaOrL03Umayh6J/4W39AYV1+xOkegAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ZC26qWxq; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1772381849; bh=S50L8cT6wxHBpcg/9MaX3fy6nS/2u11G4uzUiVplbUM=;
	h=From:To:Cc:Subject:Date;
	b=ZC26qWxqZv1kDXHT1uqHor1dMlJhUtrvsPH7ZD9c1ZRMJKWR2SxBu1U1COBf0mePF
	 7zBZhJwhmzp6HDJBDJQIuKNWYrHoygKB0tBWwNzm+WCZ+TP/hBJd7XGO8lixVxsVye
	 d1m1s4TowwxR70hc70sSeMKO8YKjnsNvWfkEGQe8=
Received: from admin.. ([2001:da8:205:20a0:6eeb:b6ff:fe15:94a7])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 3823EEEC; Mon, 02 Mar 2026 00:14:02 +0800
X-QQ-mid: xmsmtpt1772381642tdrkszb33
Message-ID: <tencent_C19B1765612DBEFFF60D3E45E29BA3150905@qq.com>
X-QQ-XMAILINFO: OKoAQJjbfIk1xrdfJctB4P7ThA3V/LeKRqo6TtaSd0KuOdhfOuc5xqlKli55Ob
	 wkNsXIujW6KNmxDvsUZr0H1pr8X9d00QeYvorSUwgLKVzleRfsES3u8R+RmNj8Yqz2xn3NJvtltj
	 wcNdk77OeO2IJbUIJRU37+MGN3tMgwcYm97boBgnusP+MF/IMt9kfNWu7WF21LXkFHcMgfyULfH/
	 ANi6ZJO6rgD7A5cU9YS/RF5l7PaMRqQs24sU15ovW3JvhSmaqeO57tb+stLnRGFP7+lAtrJWRflS
	 3Zc43DONUe1h/ltBF8Afmmki2w/wG+pxQEK4jqhyTOVHS2tskp9EegYUavz6dU51RyQ//7xRshW6
	 RMaZSeOja8hiBapir8GAEnpZSxNc9n8uolzEGWdBPPIl7XJIui8tJjxYE8tHetz4imPgfHW9CzUb
	 Km01U1G31AS/3r9QgRcalgQXQnduKUp9yGfYT64PJ+Pf1GP1kmUB3jF3NqPu8sw4n2Ns5UPA0kKt
	 n0om5X6bd6zG56pslZQlJ5+CrEv+iNsm0nplQ/CVUm5nlpHeldHxpfPEaMWO/7ycd2HzBPCzbTpi
	 VuH56qds1tUUtSuNCT/s+V6/X7G/S4Etyr/3JUf3q5ajx0c1cyB9sCia5aGp7oZ617shz9tJDDTT
	 dP4N2Df9dpvnwFSC+3S6QoZ2mIlxxhk/bWrMa6m8gKK5IMZribGCDg3p53TU3IdFQQ/sypwT8Y7P
	 EYdePWgHHQfjNgv7IZbzSQ3cKAzNAt33UyutHSNY3rrXQbUrLp4kTyZ0BPPIPMzMkmLj7NqbZ0IP
	 ihBTPLFPGlGpV2qqYuYUktRErfFpxrU2DmE9Jdl6b35i2d4xpx4grsKpIHGpoiHSg2Yo5qH+tGso
	 H4Bq9J7O2AsZ2FGeNfjWc8sHvzCoX0jE6mLF3wgvgi7Hg4rxcVeYmhwTgEcYkxABMxbIt2FOiBQT
	 94PrvyfcXBkXMxiIhAbgoktXgiLBJv7A1xbtZZHDqQZU7nr8ikNLyfmAvOz3NZ7MkHKnWrIYHr3D
	 KLLjY346zL457nMeer/YXezEY5kHAm/W0frNkoJWy3yQs/Svua1rDbrEVcbqE=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Zhaoyang Yu <2426767509@qq.com>
To: edubezval@gmail.com
Cc: j-keerthy@ti.com,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Yu <2426767509@qq.com>
Subject: [PATCH] clk: Check clk_enable return in bandgap CPU notifier
Date: Sun,  1 Mar 2026 16:13:58 +0000
X-OQ-MSGID: <20260301161358.265639-1-2426767509@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-43374-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ti.com,kernel.org,linaro.org,intel.com,arm.com,vger.kernel.org,qq.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[2426767509@qq.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qq.com:mid,qq.com:dkim,qq.com:email]
X-Rspamd-Queue-Id: 6363E1D0943
X-Rspamd-Action: no action

In bandgap_omap_cpu_notifier(), clk_enable() was called without
checking its return value. If the clock fails to enable, accessing
bandgap registers could hang the system.

This patch checks the return value of clk_enable(), logs an error,
releases the spinlock, and returns NOTIFY_BAD to prevent further
access.

Signed-off-by: Zhaoyang Yu <2426767509@qq.com>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index ba43399d0b38..04158df104f3 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1206,8 +1206,15 @@ static int bandgap_omap_cpu_notifier(struct notifier_block *nb,
 	case CPU_CLUSTER_PM_EXIT:
 		if (bgp->is_suspended)
 			break;
-		if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
-			clk_enable(bgp->fclock);
+		if (TI_BANDGAP_HAS(bgp, CLK_CTRL)) {
+			int ret = clk_enable(bgp->fclock);
+
+			if (ret) {
+				dev_err(bgp->dev, "Failed to enable clock on PM exit: %d\n", ret);
+				spin_unlock(&bgp->lock);
+				return NOTIFY_BAD;
+			}
+		}
 		ti_bandgap_power(bgp, true);
 		ti_bandgap_restore_ctxt(bgp);
 		break;
-- 
2.34.1


