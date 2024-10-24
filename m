Return-Path: <linux-pm+bounces-16370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C439AE330
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20741C22248
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 10:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44D01C7617;
	Thu, 24 Oct 2024 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JFrXN/iQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1E31C07F3
	for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767590; cv=none; b=li3DQw/4LI+qVEbzuYtx2mQcwrQri+31LNXpxjxN3dFTDTicCK3NVRqkmaYxfE+vIxkZxPXHyzIDlrL3yunRoP7mWCICxCnImjc31ql6VC+rNx1oONuaXAjIHW/sA9yCvg6NN8eOaAOSv/KcJTG/KHB+n5fqm7MufboykgKZZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767590; c=relaxed/simple;
	bh=trgLPUyj48HjPRHDuMW5LN9aVZFKBkzE2kLtjunueuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o2H02QBBCobmjIsYoksg6j2SPoLZiRM2UpW3mrEFIvsdoIa4avjrBkkEXLMwT5K4uXozjX/+dtSTVMQ2PLUt3FnzbILqCLOT3C1JsYp/rcNT5xzo6utthJhCm4xKRmG0lTURgP/y1xQ0U7a8MvDefH5CdHdvIjlbvB73W+WOB/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JFrXN/iQ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d47eff9acso511939f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 03:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729767587; x=1730372387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z/5g2bXAqewg4xcxfv4LWmI3L8F/eyWEBOYOVe/AyOk=;
        b=JFrXN/iQgu/71fmQlprTKRG3g3Rd+11gn+ZAOGP5ERPyzigqD50Zd2bml4KB5otfOZ
         RxxW98LwDb47EWrFqvj8U5oRtU45/SCRa0rkldwexxTGIUM/pZq9TwCBxugDsNCu7ajE
         NPs7MBh9BZVSyjw/Vcf7EuMQCnjRpDG8ir+Pc86IXAnGiE9Fgu2YhvqqWgBDgGy0J9MO
         2fT74Q1pq3hIGcIn2Jxr7B+ouTvds/oEwwIK6UljchkosSQDUCak7ELqaPfE6pPe4zG0
         xqWwuOZ+uIxkLDcmkiT6vIWa+sFRd6vynGdBrkFl79lBNlPL90aBBJpY71KI1rOJJ5qi
         cqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729767587; x=1730372387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/5g2bXAqewg4xcxfv4LWmI3L8F/eyWEBOYOVe/AyOk=;
        b=tY0jB6eNI3zHkQqT16zFBRCPAy/YgPCv/hXYdnqES7qBr912pJYj2myIpCZAWAlKog
         j9kQ/b2RuELkCVG9IYYelr9aI3W++QzKNlkxC2hYwgLuaDNnqxaQZPgiF59XC+ZiV32M
         wipDQec/dBDpFwiDoiNLPmbYvFA+APIQuUgIwTIvv+X0SwN0p/caPoSLTRfm9FnbqLWx
         FoLiT+ko/WM7WKg0UUnujbWrC0tXwntKn6m6iZtXrEIC7isIwnyAbk+1+tlx7yWL1DzM
         3Miv4WzCW7Oc4Md6+QvtTSoFhLsdfQrRMsgoySPn/Sr2joeosg38EQv3FyLVKMN2W2cj
         Kx6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVe3SYDiNKOnu6K9I31YfpStdKEou6Pr0KH6j/aIgX+PZr7wdX0PCCHL9OrWSZyhEsXLMsgAMNhDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPjetGdFBhN6GZyyZ+mht0uhXs/wWOASFJnI/+TrGLgUtIh85w
	Qcj1+ZfQPUEM3b+sHTV7pAObqg3xFQt/DsvdFveoFHWJxR+QKTI4veRjNPeeMqQ=
X-Google-Smtp-Source: AGHT+IHhMpUEAcc2liClS9QNGx/dIO3K3IeEmcd+OIO2wwof3diLI4Oe4uptdXr/v5oOnzsdIhUNGg==
X-Received: by 2002:a5d:61d2:0:b0:37d:51bc:3229 with SMTP id ffacd0b85a97d-37efcf93111mr4104098f8f.51.1729767586875;
        Thu, 24 Oct 2024 03:59:46 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a5c529sm10984874f8f.62.2024.10.24.03.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 03:59:46 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: Lukasz Luba <lukasz.luba@arm.com>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/lib: Fix memory leak on error in thermal_genl_auto()
Date: Thu, 24 Oct 2024 12:59:38 +0200
Message-ID: <20241024105938.1095358-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function thermal_genl_auto() does not free the allocated message
in the error path. Fix that by putting a out label and jump to it
which will free the message instead of directly returning an error.

Reported-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 tools/lib/thermal/commands.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/lib/thermal/commands.c b/tools/lib/thermal/commands.c
index bcf0f14d035a..b0d4c8aca21c 100644
--- a/tools/lib/thermal/commands.c
+++ b/tools/lib/thermal/commands.c
@@ -375,27 +375,30 @@ static thermal_error_t thermal_genl_auto(struct thermal_handler *th, cmd_cb_t cm
 					 struct cmd_param *param,
 					 int cmd, int flags, void *arg)
 {
+	thermal_error_t ret = THERMAL_ERROR;
 	struct nl_msg *msg;
 	void *hdr;
 
 	msg = nlmsg_alloc();
 	if (!msg)
-		return THERMAL_ERROR;
+		goto out;
 
 	hdr = genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, thermal_cmd_ops.o_id,
 			  0, flags, cmd, THERMAL_GENL_VERSION);
 	if (!hdr)
-		return THERMAL_ERROR;
+		goto out;
 
 	if (cmd_cb && cmd_cb(msg, param))
-		return THERMAL_ERROR;
+		goto out;
 
 	if (nl_send_msg(th->sk_cmd, th->cb_cmd, msg, genl_handle_msg, arg))
-		return THERMAL_ERROR;
+		goto out;
 
+	ret = THERMAL_SUCCESS;
+out:
 	nlmsg_free(msg);
 
-	return THERMAL_SUCCESS;
+	return ret;
 }
 
 thermal_error_t thermal_cmd_get_tz(struct thermal_handler *th, struct thermal_zone **tz)
-- 
2.43.0


