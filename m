Return-Path: <linux-pm+bounces-7823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4D88C4F69
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF871C211BF
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEF013E404;
	Tue, 14 May 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vxCqEhj1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yQ9p1cBD"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6C986252
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681943; cv=none; b=OIo+p4Kmnteu94J9/NbsFR3iNnqV+97WSjUuRwzrt7IzFyxRsvwVgA/fS7jjuOVfdQOP/YrVuPyMNiUfJhjCZrM7bFycD8oncmxsDl+o6RfwUw1Bx+oEw0vnp0M0blJpsG/TwDnnK27Crxa49Ic+qKGMR47Bgx0Wy0suubZd60Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681943; c=relaxed/simple;
	bh=e3pkUqW+y9iM2xDtXxefQZcrAEQGRbXOKqYFFrc+AAQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kBcF8hYX4HkTEF7jhihlnjeCyJAJyXPMYxxEpaf+YijcKiiZTmp0xWLOv2vLE5N8rdhR7+F0aFOD7ee/Rtm9A7om3guTm+Y3yWUufZ87q4+wS42iyu0B0ewQSbdLux3w2I6qOUX2GeqwNY3/oTyCgGHg5pWg2bVHHjZw36QP3pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vxCqEhj1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yQ9p1cBD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FRlaFW4YRpDw+nQfQtPKLo2nDCwa5aBmAApKz5YPkvY=;
	b=vxCqEhj1ONc1osHAdc5OjquLVeO5vhlI3ElWmpUY68Sam1U6ViTvIGV3RN4RubG2xKGuL7
	vlPPkwkFcQIwAASuwfrF1LooEh2cw2s+9UujI11cQMWqbD88SBzCFJ/RSyj4K1K4/TgLMv
	AeGO6rHHePRP/H6mOsF/a2yiT4ejv8K0WJpEVyP03iU5PfF5igWA6sHd5Tm1aGVFKgGV8U
	CnPv2Ra/5YZKk1w0yA4+yM1ERTEDGRtyMloh0GYRyuL69WVf6kf1Rynr1ZuqyeNF1QkKt8
	QLhvVorfBF8CMN+EY4AwC4Hc2mnzKDGQJTaz8KQA8pFK7S/NajM0E2fXLA2BUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FRlaFW4YRpDw+nQfQtPKLo2nDCwa5aBmAApKz5YPkvY=;
	b=yQ9p1cBD9rYNNtBdX/1ljAH3YspGZtZWfFklgL5xN0FC0WuKaDc2MN0nf0YOt6XB3VuvQt
	qGFynAOSNx2j50Cw==
From: "thermal-bot for Aleksandr Mishin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject:
 [thermal: thermal/fixes] thermal/drivers/tsens: Fix null pointer dereference
Cc: Aleksandr Mishin <amishin@t-argos.ru>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240411114021.12203-1-amishin@t-argos.ru>
References: <20240411114021.12203-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193478.10875.18119058876006595938.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     d998ddc86a27c92140b9f7984ff41e3d1d07a48f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//d998ddc86a27c92140b9f7984ff41e3d1d07a48f
Author:        Aleksandr Mishin <amishin@t-argos.ru>
AuthorDate:    Thu, 11 Apr 2024 14:40:21 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:29 +02:00

thermal/drivers/tsens: Fix null pointer dereference

compute_intercept_slope() is called from calibrate_8960() (in tsens-8960.c)
as compute_intercept_slope(priv, p1, NULL, ONE_PT_CALIB) which lead to null
pointer dereference (if DEBUG or DYNAMIC_DEBUG set).
Fix this bug by adding null pointer check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: dfc1193d4dbd ("thermal/drivers/tsens: Replace custom 8960 apis with generic apis")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240411114021.12203-1-amishin@t-argos.ru
---
 drivers/thermal/qcom/tsens.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 1c9df4f..e76e230 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -265,7 +265,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 	for (i = 0; i < priv->num_sensors; i++) {
 		dev_dbg(priv->dev,
 			"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
-			__func__, i, p1[i], p2[i]);
+			__func__, i, p1[i], p2 ? p2[i] : 0);
 
 		if (!priv->sensor[i].slope)
 			priv->sensor[i].slope = SLOPE_DEFAULT;

