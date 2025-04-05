Return-Path: <linux-pm+bounces-24839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21264A7C7CD
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 08:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7C017C4D5
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 06:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1815419F495;
	Sat,  5 Apr 2025 06:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FM3CBNEt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B75C20322;
	Sat,  5 Apr 2025 06:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743833358; cv=none; b=cJWwrWx2YZT3RtsTfHjE0Oohie3b6rk+UvWhVP+BbzKww4eClGYS0fommh+sjDxlXYLDDTg0GWz8w9rgHcWzFN48pzGOX+/ofGMyUjm4aRVxTwCYwtR3xkr/JyAWwFAmaoBLGnoesCleWCBFNdbSGSoWqYenI1XOkidaSxjk+mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743833358; c=relaxed/simple;
	bh=B+BGBh9/ZyqwuxfNp8Q+TqOH/E+o6f7iwTQX3pqY2Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M1l0HNVoAHGScY/rM4Y6aVhnMdf/k78YpE9k6Rdo3pC8DtrSgGxHZCPC019OivkIA5XsiNW3OQkUlX5nmD5UUMFhHSz3+SoTlwhM86O4L/uMUY7RlhLOl1BVkNuNmxtJo97cBKqn7LSRTE/tQTNF4BDj56n7/IIy/QbCWC5m68Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FM3CBNEt; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-301493f461eso2005396a91.3;
        Fri, 04 Apr 2025 23:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743833356; x=1744438156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fNWhRR/ovxm0M4uhjynvurYQ9eBz0J7kRxtKIE6QrzQ=;
        b=FM3CBNEtlVMifoBcWsqZM2FbFFnIS+PfASjevuUdhYTkKhGbMlVM9lHThtLVnuDtMq
         mn3iqnUc4YwOoH3Gbi/WN8o+TcjqiD/adWnzNFbAr9LkB6LVuzTg5iihfKhlQ9nCFVvK
         9RKAlkKEpj0eZ/Jwo/BEpNjeHOn1tjSknMaH2G84CF7+79qJTnXxTAvH1otTYbkdjBbv
         aEn3Yzu8Sx4PNz7GQdgu6p1E+J/UhQj0oMxsIBtI7rF1PNfqC/A60FrDt3xTwWKY6z6m
         MHKPgqzvMVRBqnsmRiJpIqt4eQLnqSdnmfPWwE65ggyR6hP+vAQyLtGQoKgBsslcUp4J
         bQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743833356; x=1744438156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNWhRR/ovxm0M4uhjynvurYQ9eBz0J7kRxtKIE6QrzQ=;
        b=lEA//hl3mSV413kYwNMQkozTqdYUOkGMzm8dFyHt1iTMmNjaYv3/3gn6/VuPzZBSE9
         XEXPT8heep+1VI2tgAiLNYPwoGSVT2wv+qjcxsqGTDqXl0eK8qc6oi07KtSd3nxcBQ0q
         c7vkiG13MfvU19LIhCDrfDww3URUiWbuut7achKYtqgpBTmntIUNgDRMjEYD1mN+KxrP
         0NZUUJpOMnXoSgxDRgFag1N8KqTTdFW3ChzBNRd1eNhSNqW0FLQKWTn+oYdk78KI4haD
         6jhTDKBKrbHgS1xzgDcfEGnHN+srQu7TMAadbhUS4gPcncbWxexiNpINRZORiUTfZL5h
         w20g==
X-Forwarded-Encrypted: i=1; AJvYcCXLhH3uDo0zIWvxG7HAYHfEuLVWBxmgR6qLuSVVEOzG6Da/3pYMM4xdqEwPbim+Verkt98yUwsGdpEVACc=@vger.kernel.org, AJvYcCXYOENmU4DLb+pm4EtfbxAhwOu8lMm6P1jIoz8sYCSiWaOjKR8V5Yy/AuP1xS0WIKFq6NMxVB2hLV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGpazPuYArNgkptISQtYCM2lR5yZoRE7ApcFRA4P6nggDv4oKb
	nO7apV7SHxHsBRtSlj7g5alHZS3YIdXrb/McmBGEfgIt3Pt69hGO
X-Gm-Gg: ASbGncs+AXkmg1ptnC0MnD2GTOcKGhOJx9PQSJhrTWtr5s9yN1KvDS3zvm5Ie4m971t
	UjtubLFzJ7c/DVzibT33nMk4Kp6jL95VNtFCn1Jv0naokVHqwVWCfBzR/AUpcRnPNJO+abEhrdP
	Ds+FMECNxexfFh4Ax2uhRLE+nKxP7Y7mUTjkZJqXksmyPW+qp5Lje/Y3ZIYzuY+qU0kCOfzq3RS
	xmsI/Fcn/ftNEPwz4GScFJDbZvgtTBkr4fq8QoZ4m/inHe2ouHzHJYiu4sqiSz/CCAxqpiMJ3dr
	mHeIt/j/GNkWGZPU02mSHW3wo6jVPrQ5+enmhtw7WtkC8t76N1pe
X-Google-Smtp-Source: AGHT+IG0jOTHi4vKNz27jWmJ2UN0YXn3x15yY0/5g8HEvMONRPU4e1aBfqd8QNWb8WuXfEN4R0vuuQ==
X-Received: by 2002:a17:90b:2e4f:b0:2ef:67c2:4030 with SMTP id 98e67ed59e1d1-306a62134b3mr6048851a91.27.1743833355770;
        Fri, 04 Apr 2025 23:09:15 -0700 (PDT)
Received: from atom0118.. ([2405:201:c009:5aac:bedd:ad5f:bc75:2674])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-305983d7f19sm4608016a91.40.2025.04.04.23.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 23:09:15 -0700 (PDT)
From: Atul Kumar Pant <atulpant.linux@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: Atul Kumar Pant <atulpant.linux@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle: governors: Fixes typos in comments
Date: Sat,  5 Apr 2025 11:39:09 +0530
Message-Id: <20250405060909.2026332-1-atulpant.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes typos and corrects spelling in the comments.

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---
 drivers/cpuidle/governors/teo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 8fe5e1b47..bfa55c1ea 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -19,7 +19,7 @@
  *
  * Of course, non-timer wakeup sources are more important in some use cases,
  * but even then it is generally unnecessary to consider idle duration values
- * greater than the time time till the next timer event, referred as the sleep
+ * greater than the time till the next timer event, referred as the sleep
  * length in what follows, because the closest timer will ultimately wake up the
  * CPU anyway unless it is woken up earlier.
  *
@@ -311,7 +311,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		struct cpuidle_state *s = &drv->states[i];
 
 		/*
-		 * Update the sums of idle state mertics for all of the states
+		 * Update the sums of idle state metrics for all of the states
 		 * shallower than the current one.
 		 */
 		intercept_sum += prev_bin->intercepts;
-- 
2.34.1


