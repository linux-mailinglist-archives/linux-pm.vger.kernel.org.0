Return-Path: <linux-pm+bounces-43927-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIkMFOptrmnCEAIAu9opvQ
	(envelope-from <linux-pm+bounces-43927-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 07:51:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9E6234655
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 07:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9895300C833
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 06:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DB5353EF3;
	Mon,  9 Mar 2026 06:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="RV6blo0E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C72B28851F;
	Mon,  9 Mar 2026 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773039078; cv=none; b=qbdW83LFqMva9lp2yUcHTnfxEHT/bY3gQZbyK4L1ew9EhNX25V12TcjvAPwxwaTofsmNmtxVlZEdCoSoa4TXTkeZVXAeDwpWNXgBWrPEq6eFueFSc+Ho9+zw9fjVGOWKQNwmlsuT1XH+HLFOYbZYtwgFbU4d/XBwZM4zyqqgSMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773039078; c=relaxed/simple;
	bh=OEXDhb+PQPHsFN5DupcwkaR3OwgVBjqGgkNyv1mVKdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q0TA8GQQv3iuSAOLSzAFeo8IWbpDUyKLNHfqUVcDij6MIcoBcTV2Ds0zw1feHFSjbAN1JWn/V5+U6mz4rQgoUu5bPcTyKlihCiCgvgc70YVRX5Amble8vJnCS6P+CSpCn/gMKICk8CwGxv1thXRhUt0gzgVuAsKLeLllqNbARW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=RV6blo0E; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout4.routing.net (Postfix) with ESMTP id A7E0C100679;
	Mon,  9 Mar 2026 06:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1773038692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cy1rET3CGr4f2fi75cHO85rqRJdUgZ3r9En6ePvjM8M=;
	b=RV6blo0EiLzHWAE+O9vkx+r9A7twIQh4e/3sNaSVRNRxX+ESBGXD70D9sDgn5kbS2NV8pF
	gPARgAOUpVhI09NgnVi2rvJNoyKPbeJ8bh9BDN4lqaVDIBtrpp/4nZlh76/z8ejUGRn5AL
	A5WN4lYYFSOgjICl3Fy1fPuIEAwqfvQ=
Received: from frank-u24.. (fttx-pool-217.61.159.26.bambit.de [217.61.159.26])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 7085B1226F2;
	Mon,  9 Mar 2026 06:44:52 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Laura Nao <laura.nao@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] thermal/drivers/mediatek/lvts: fix mt7987 thermal crash
Date: Mon,  9 Mar 2026 07:44:38 +0100
Message-ID: <20260309064439.4296-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BD9E6234655
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mailerdienst.de:s=routing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43927-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,intel.com,arm.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[public-files.de,collabora.com,makrotopia.org,vger.kernel.org,lists.infradead.org];
	DMARC_NA(0.00)[fw-web.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@fw-web.de,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailerdienst.de:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mailerdienst.de:dkim,public-files.de:email]
X-Rspamd-Action: no action

From: Frank Wunderlich <frank-w@public-files.de>

On mt7987 we see a crash due to missing ops entry.

[    1.518540] Internal error: Oops: 0000000096000005 [#1]  SMP
...
[    1.564481] pc : lvts_get_temp+0x84/0xc4
[    1.564492] lr : lvts_get_temp+0x60/0xc4
...
[    1.620900] Call trace:
[    1.631753]  lvts_get_temp+0x84/0xc4 (P)
[    1.645471]  __thermal_zone_get_temp+0x24/0x11c
[    1.656502]  __thermal_zone_device_update+0x9c/0x52c

Add the new ops member added in 7.0-rc1 for mt7987 too.

Fixes: a4c40559499f ("thermal/drivers/mediatek/lvts: Add platform ops to support alternative conversion logic")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/thermal/mediatek/lvts_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index a9617d5e0077..5671531d4c23 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -2026,6 +2026,7 @@ static const struct lvts_data mt7987_lvts_ap_data = {
 	.temp_offset	= LVTS_COEFF_B_MT7987,
 	.gt_calib_bit_offset = 32,
 	.def_calibration = 19380,
+	.ops = &lvts_platform_ops_mt7988,
 };
 
 static const struct lvts_data mt7988_lvts_ap_data = {
-- 
2.43.0


