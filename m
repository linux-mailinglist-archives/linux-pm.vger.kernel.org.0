Return-Path: <linux-pm+bounces-42653-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMUEGQq9kGntcgEAu9opvQ
	(envelope-from <linux-pm+bounces-42653-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:20:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EB113CD2F
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE9F5301FCBF
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 18:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A249F3112AD;
	Sat, 14 Feb 2026 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0f2/QQV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B29310764
	for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093201; cv=none; b=qP9Wz69mId9IO4XnypVmw+T1vGdNmw3YztD6CXjgCAy2VYO3VHR2RuZsWZ3jnlOI3mYkaEHz+fL2Z2s9p/PgI+vNd1CcI8O04B0a+jH21E0AZ7pYAcKlY7w5x1tcuOJwpT3QBrSfcfvms3JxYgn1e7PjTEoYkc/mziA5ffMpJQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093201; c=relaxed/simple;
	bh=PfOygATA+OcMrjg0RKh13yWvltWb+BH/5KX/xERXXEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gp+c1EBNqZCCjEf+6ZE04c8o6qFsZpzmAcnVvj9u5cLyU7g5tqwQHFvQSRctWaIoiFogiJoVwvRPMpD8i93op3vEFzD+69GNNcvsM73M/4FN6LnG8XiSDqMyG80hT/MqpD1D1E8SE2VmS9CHrcohAsUmxG+/S/gPJ8MN2wyb0Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0f2/QQV; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2aaf43014d0so13636455ad.2
        for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 10:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771093200; x=1771698000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aN6kFZ271/Vjt9LuqJxvnwus9JIfHbc3XvmUWyOckqs=;
        b=R0f2/QQVFZTGJj4H1FmLzqu1IkLe9gxNYzR5+WFZWeOOEJ5XRcGlc99gC9+abkefeU
         byoSOpwjRTO0zKUfmBUQrxUaahEEM3DRJ0YeYdT+jIbynFY5jrPeUaVXGzxSn5froMtP
         AiXMwAmJNsIjpDX77ZF8KOi0kBsqjBzey0uWweJun3HEheZatndnFwQ2cSK4ISy0izQW
         dmMxJznMCgUP6v1orknIxx+khZCRrENRki9ynwtE/quIB/RnBu7XK/IsyD2urTI0QDkj
         8WZdNuOPZEQkhdsV1J8wEYGErTVQwiQ2y1pxN1rHhpNbakeFxNMmo/HXtP8o1weWnf57
         rmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771093200; x=1771698000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aN6kFZ271/Vjt9LuqJxvnwus9JIfHbc3XvmUWyOckqs=;
        b=DYq7Yz8nOrMOuix5q0S7vnzEGmqYyKBBenETpVx+VuZiDK42+0jgbrKJ9diCRyS4FH
         LdzvfcGMy8suZVQI7/twq1tcvNGW0pIm998lVP6578IKNTWJy5I3Ryf9phQ+z/mBJu+H
         Wndxuyqwsy9kGnOGdhevoqAuvwKYpd4lyifTEOpOIs5uOF8J9TUIutuwQNyQaTW+UuJi
         u3VgPeq0KfHsesArAdGRC6k6zlRyPVbKrKX4tWfd6o1tCk90wttHOVplqyC+K8ppQ2k/
         BWN6KISL7JhLLjrUAPot1m2BVmEPQMHYCU9iGG7k2tJNcCm5YQ3c+CtQZNvG82BHgoZJ
         37rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXunsoCW/OcS2U2wIj+SWnaQbaQOuX31K0yEB0bWSPY3wWXqPOtIlVpcI89fnUTq8sKakgZwzlkkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC21cALMWORBwWzG7l+Pg8WUZYgU9/n6hWQSh6FfjdOnqkQqYt
	+GJK0cXYKW2sOFHQaz4ks7PxA4xbpIGO1jJuqYSSsYbx7B5n0DjBg9tT
X-Gm-Gg: AZuq6aKKqiwsBdQN3ldVttYIkn/eTjTVVxHHYhNswYoA9qzFzJdCY03iYVw1qJRYyqE
	3DKKj11Sx2BDQVFWbpo8tQvsJQ2f4W2LB1HDdtgJcxGRLwKM1vSXuft7h3sdRXeO+lOf8LR3rTA
	R+oyeNiIck+Oxf3DNd7vnD89E8hfwYsr2Ps1NRHSk0ql1Jj6NBcXNEmdWHRYj+Z9bb15AOAxw6q
	yCKKqEt2snTD4QFyOuLo5+tNHsT+ZxgbFaP9YFF7c9DrczrvbAs7ql4ySL4XUDdJ17kmDq5Hq+C
	Rt/naNLKHtBsAI3z/S/zWFdEWSiigBpDUcfp9k6S7G7t1HbCJcslZrXX3XfAOyN8lQHhJ1+Zd2B
	0e7bf0y1sVbJehVxH2ryDTI7maAZcOKbdrhIRwcATFWyVu/vms0qHTtH1BJLi9QtItdLK+TmaNe
	IrUg9mlLJ2e+7BOXZhrOE=
X-Received: by 2002:a17:902:dacd:b0:2aa:f2f3:bca1 with SMTP id d9443c01a7336-2ab4cf4f72amr54134195ad.9.1771093199695;
        Sat, 14 Feb 2026 10:19:59 -0800 (PST)
Received: from rockpi-5b ([45.112.0.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5e06sm28406615ad.50.2026.02.14.10.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 10:19:58 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pm@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v8 3/9] thermal/drivers/exynos: Remove redundant IS_ERR() checks for clk_sec clock
Date: Sat, 14 Feb 2026 23:49:00 +0530
Message-ID: <20260214181930.238981-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260214181930.238981-1-linux.amoon@gmail.com>
References: <20260214181930.238981-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42653-lists,linux-pm=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linaro.org,intel.com,arm.com,samsung.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxamoon@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: 19EB113CD2F
X-Rspamd-Action: no action

Remove unnecessary IS_ERR() checks for the clk_sec clock,
the clk_enable() and clk_disable() functions can handle NULL clock
pointers, so the additional checks are redundant and have been removed
to simplify the code.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v8: None
v7: None
v6: Add Rb - Lukasz and Fix the typo in the subject
v5: None
v4: drop IE_ERR() for clk_unprepare() as its handle in earlier code.
v3: improve the commit message.
---
 drivers/thermal/samsung/exynos_tmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index aa0726b33c84..5f017a78f437 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -258,8 +258,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
-	if (!IS_ERR(data->clk_sec))
-		clk_enable(data->clk_sec);
+	clk_enable(data->clk_sec);
 
 	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
 	if (!status) {
@@ -269,8 +268,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		data->tmu_clear_irqs(data);
 	}
 
-	if (!IS_ERR(data->clk_sec))
-		clk_disable(data->clk_sec);
+	clk_disable(data->clk_sec);
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 
-- 
2.50.1


