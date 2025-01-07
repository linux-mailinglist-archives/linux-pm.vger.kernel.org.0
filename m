Return-Path: <linux-pm+bounces-19998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1256FA03776
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 06:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A733A5232
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 05:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B5C1D515B;
	Tue,  7 Jan 2025 05:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="rX45xbGc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3938F198823
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 05:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736228713; cv=none; b=jWyJ2aRrz/IeRF1TX0aBlH3G0FH5N7275Mu6q43BUGwWNfMnB9dn/0RFvBnRLXlSIfIT37qQkJ3Ta26yoMEicc/tLaNbJWuKyTA8nxA+2HbP5cqOODRWsH4ELoMv1OaRooibVZllywh8S3j1+cooLmuS/zK5NKNNbn3LhZwQhwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736228713; c=relaxed/simple;
	bh=SoOVWSrKrBUiDcLHdUgdPs/DroRi9xVYQlcy9o56N0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NVYLxhI0TT0XG1O0WghqpJvgJoa+2Ujo2IA5dzXldhp9170AJDTSZwl7a43p719VvPhuaZFukrgbs5pEw1RKZYLzGH5t29PBsBILP1mgeK0yxyVOcmSbXB6ls6lLpTdqsBB4exqOELqv7ZPASF2wqfOXaleqTPH48dlSJWrHIQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=rX45xbGc; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f441904a42so22436832a91.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Jan 2025 21:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1736228708; x=1736833508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uSJEYaUm876n95DvO8TpN+9sXkMSwEme5aT4WU4OnsM=;
        b=rX45xbGcRMfdAmDBlZHXG9tUbC2fWde2ocEWHPUVdoEo1FQ5I/ofutrlbsCM7OfJOh
         EBf3moJXP9fRA0bAnQoG8oqgXmco5ekeut+ZCVAziSefr7onkUsCIL8LLYwZp9vQ5QQ2
         IqI98KPaNUSO1h9flFuoNeaV6CXLnh30q0+sDwp9SulUv74K2bG+21b+PP+Y2Q1Ezpbl
         1K3vzW0ntgYCGbHYJfucLfRsYGk4zKyGsN4jrouJThD35E391ilAup6bYv+ywSPZhRTn
         ewgJbgilMe3DetYcz9gFbgSujgAcvzUdcMt5CoUIHccMhO6pOlYLFYMIDs5ZyicxpEEi
         IDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736228708; x=1736833508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSJEYaUm876n95DvO8TpN+9sXkMSwEme5aT4WU4OnsM=;
        b=aFrWCTmsS8ERqLQO11cPXEfPsC6s41FWd4m0HziyCrmlusK2iGe4c8aaU91DiCZRe3
         ocPzBKLlpGvmVgMGDFI/ww0g0MUPZteFyd2dRQh1T/52jSzUUJvk42uWD9Y6erglFUnx
         +lJmXja+bJVjKG7/4AdzVaoMDYOyJ0k4hvbArMfSA3YwFfbnTiLg8Kf9Byhs5D59+ly8
         8u/ii6uqWHTs5Npt7qLXLlKAqKunZzCD0iqvv5kz22+j4ZV2QuUHyHiYiMEZq7iFusIZ
         ysCQHAfgbqq4O3N5AFAn5T5C/4uGYEqsAlt0ePnoYQQqZcyXJdQTKXXhe3tuQ2LhqsZ5
         JJMQ==
X-Gm-Message-State: AOJu0Yy8sOEqjBlz4p7Z7aeDKNAW6+OoioHI1oXbLorwuhdOX9dadh1g
	K+tMex6ng4BYoqfPo/aTFPjGLwy8c+HFL9DaR9uxle+AQ1UE8diA95STnydOxQsDaD8KagpfaY+
	e
X-Gm-Gg: ASbGncuHyznidSHWDAgfGySLny0P+6x9NXrvmT5x9Ta9IigFHu12O+w10SKRxcBrev8
	p3/1Tp7yfAHd+AbsrDlauPZ8aP0871HTlQjGthVDtn3WmfUGcFXfJ7bk6IokfNI6t5nqYcSVW/L
	hA5MG0ckALTu4R/a2N/Qd64EjtgtwlUL7mX9G8zkLLL1ksGt2Wz8GWA4lhD2NhAKEGF1Y8xdMlJ
	SwKF7MKdZnI/SR9az0S4m6JU580G6XJTeuLclSbkkL4Q/Rr0NrO1dF3aKJSFQTSF/NY9GQNAGjT
	C9A0sGbMH/Qa8KrxkZQiIrjqRmD3k60XrgCHlHyRx88=
X-Google-Smtp-Source: AGHT+IHtFl7uqq5++6ZGF1ADWTH+K5af4RSlPiHiN+RkyYWLrv5NKIWMVLOQhnQ/VYhneLvzZetlYA==
X-Received: by 2002:a05:6a00:3d0c:b0:725:973f:9d53 with SMTP id d2e1a72fcca58-72abde3bcd1mr83315228b3a.15.1736228708213;
        Mon, 06 Jan 2025 21:45:08 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad816279sm32346447b3a.35.2025.01.06.21.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 21:45:07 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: vireshk@kernel.org,
	nm@ti.com,
	sboyd@kernel.org
Cc: linux-pm@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] OPP: OF: Fix an OF node leak in _opp_add_static_v2()
Date: Tue,  7 Jan 2025 14:44:53 +0900
Message-Id: <20250107054453.2889332-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_opp_add_static_v2() leaks the obtained OF node reference when
_of_opp_alloc_required_opps() fails. Add an of_node_put() call in the
error path.

Fixes: 3466ea2cd6b6 ("OPP: Don't drop opp->np reference while it is still in use")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/opp/of.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index fd5ed2858258..a24f76f5fd01 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -926,7 +926,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 
 	ret = _of_opp_alloc_required_opps(opp_table, new_opp);
 	if (ret)
-		goto free_opp;
+		goto put_node;
 
 	if (!of_property_read_u32(np, "clock-latency-ns", &val))
 		new_opp->clock_latency_ns = val;
@@ -976,6 +976,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 
 free_required_opps:
 	_of_opp_free_required_opps(opp_table, new_opp);
+put_node:
+	of_node_put(np);
 free_opp:
 	_opp_free(new_opp);
 
-- 
2.34.1


