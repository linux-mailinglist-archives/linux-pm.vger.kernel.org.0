Return-Path: <linux-pm+bounces-41060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE983D39C2B
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 03:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18DC03006F52
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 02:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517201DA628;
	Mon, 19 Jan 2026 02:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="hYM9UKyi"
X-Original-To: linux-pm@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69945F4FA;
	Mon, 19 Jan 2026 02:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768788106; cv=none; b=WBeWfneMQvmKAO5z7lo5/XCa9uEOronMhsHotxFz7DQqrDr6EJbnsVouUtvV1BDPaDUMgRoEe7E7K/xwDf0sct6uFCx+EagM8OMXtAhGeVVL/XHUt4e9eJdI3ACdr0GgIgiEsD/pTrDt5gl4ej4S4mKxkopZIEPxnzNMOr8lPCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768788106; c=relaxed/simple;
	bh=qunSLtuqe1BUYC6RkXzzLwzazaHLpM3Kekva+nq8cQ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sa6jbsAkDu+oC1zATmUCBDPOw7bdOA1Kub/yrsk+5sgU2A4OFw8MuiUq4a5Zv9vJgXCI/TALRJfzhedcNEAi7pkUtWTwh14dLEDozL/rnItwygbhjdGxeTrxKC/N83VGuZy2SCfBvzmtQwZlAP+eoyzQNK8OU1YZ3BtjeHoDH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=hYM9UKyi; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 60J1wGGb019939;
	Mon, 19 Jan 2026 09:58:16 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4dvYPK5lvyz2LxcwC;
	Mon, 19 Jan 2026 09:52:37 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 19 Jan 2026 09:58:13 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <lukasz.luba@arm.com>, <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ke.wang@unisoc.com>, <jeson.gao@unisoc.com>, <di.shen@unisoc.com>,
        <xuewen.yan94@gmail.com>
Subject: [RFC PATCH] thermal: power_allocator: Ignore cutoff when integral is less than zero
Date: Mon, 19 Jan 2026 09:58:03 +0800
Message-ID: <20260119015803.183-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 60J1wGGb019939
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1768787922;
	bh=fCu0K5cw16lqJEcQL/O5U27aUkWsXOZaAI9LJC5zYTU=;
	h=From:To:CC:Subject:Date;
	b=hYM9UKyiEOq7e/fCR6+yCTAE2zaU1+LVVQf7KWUE7FMzF+9QO9qdjPVV1IOmz7MD+
	 Y82B9R36eypg3e16tN9zPOIGYwP7RNjc6FLrMr+oNMkvd3TeKZCawFh+H9ErucaWy0
	 fhWavIowNdamfe8kevE4IKpxFToWhAgiFyR5EQfYE8Dm/m3UicyeK58dUC+FY8D1JB
	 glm4GzAAA3TfQtU+K7xCY0ZVbMFtnw2Zb+wp3qdze8Lh+PgESYTZFhcC5K9FNgOwIp
	 0IDeqtZtiH44IOsoCY6ex/BcrcUvXA9VUxnqX5+9ptbdCg7oi6gYqZZ5NV8f0ldGCo
	 AnmwTEtJlSyxw==

From: Jeson Gao <jeson.gao@unisoc.com>

The cutoff means threshold below which the error is no longer accumulated.
However, in some scenarios, this may cause performance degradation.

For example:
the control-temp is 85, the cutoff is 0 or other small value:

If the current temperature frequently exceeds the set temperature,
the negative integral will continuously accumulate.
Over an extended period, this will result in a significantly
large negative integral value, the positive integral can’t build up
because of the cutoff. This makes the power_range very low,
even if the temperature is already under the control target.

So, if the err_integral is negative, ignore the cutoff to force
add the positive integral.

Co-developed-by: Di Shen <di.shen@unisoc.com>
Signed-off-by: Di Shen <di.shen@unisoc.com>
Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 drivers/thermal/gov_power_allocator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 0d9f636c80f4..404ae1d75612 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -263,7 +263,8 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 	 */
 	i = mul_frac(tz->tzp->k_i, params->err_integral);
 
-	if (err < int_to_frac(tz->tzp->integral_cutoff)) {
+	if (err < int_to_frac(tz->tzp->integral_cutoff) ||
+	    (err > 0 && params->err_integral < 0)) {
 		s64 i_next = i + mul_frac(tz->tzp->k_i, err);
 
 		if (abs(i_next) < max_power_frac) {
-- 
2.25.1


