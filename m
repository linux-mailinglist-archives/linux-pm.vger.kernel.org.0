Return-Path: <linux-pm+bounces-43149-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK2/L/S6nWklRgQAu9opvQ
	(envelope-from <linux-pm+bounces-43149-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 15:51:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EC513188AF4
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 15:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71F8F300C559
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 14:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517ED3A0E82;
	Tue, 24 Feb 2026 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N/q1N07Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FAB3A0B22
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944688; cv=none; b=oASaIaxC0LA5kR+UC934nv9tUE7C2oCCAilgVwXBrTdFfA50Qz1PE5HHFfQxspc6wbVlG7c3PT+mNKLP2s824MU6/Oe4D2Npa0q+RZLsaMIQ2U6pw741G/PJeLwEY5V6bsZQotgKvjdsW4LQNk6pWuEJXLakDDsdsayVOwjoSYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944688; c=relaxed/simple;
	bh=zeRYwHDFga5XDAtn2Mh6+61unaagIljzBvZ+FU4zhT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oIX8ZOOEsJ7v0sZ5ZNLtmchz+ez6e2irYB9HejmVu7ZFrqVM6vaf0+QHZmji2y0Pepuy6UfJvJsu6UeaPa0gNqvMU8Ew2akUYr8C1T7OM6nxezU6sH6FguM3qX707DZQy/LqMiRbcU6j7XL/1Wea/PZOMrtzOVSOOaAWTCq8k5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N/q1N07Y; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771944684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/+VZMh4GEF8Zz3re4kwGvvFRb4CIYeGeUY9ZbG3g6Cw=;
	b=N/q1N07YQ21jUvXkYtgTnWz2e5nKN2nQoB7wWRfIIq2TRlHf/C4x/mI03OdN7GFMgcj2rQ
	sX6KC0uNBgHc3sUqCrgFmo+0RPM0gxqXSHF5YzJTQsDnUCPwHCuSmHtT3WcW5HdMk3inP8
	LF52t6XEvWsj2XKl3+2AdCjTs81MGTc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] thermal: sprd: Use min instead of clamp in sprd_thm_temp_to_rawdata
Date: Tue, 24 Feb 2026 15:51:07 +0100
Message-ID: <20260224145107.585892-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,intel.com,arm.com,gmail.com,linux.alibaba.com];
	TAGGED_FROM(0.00)[bounces-43149-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: EC513188AF4
X-Rspamd-Action: no action

Clamping 'val' to itself is unnecessary and the expression can be
simplified by using min() instead. Casting SPRD_THM_RAW_DATA_HIGH to u32
is also redundant and can be removed.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/thermal/sprd_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index e546067c9621..511f1e7959b6 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -201,7 +201,7 @@ static int sprd_thm_temp_to_rawdata(int temp, struct sprd_thermal_sensor *sen)
 	 */
 	val = (temp + sen->cal_offset) / sen->cal_slope;
 
-	return clamp(val, val, (u32)(SPRD_THM_RAW_DATA_HIGH - 1));
+	return min(val, SPRD_THM_RAW_DATA_HIGH - 1);
 }
 
 static int sprd_thm_read_temp(struct thermal_zone_device *tz, int *temp)
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


