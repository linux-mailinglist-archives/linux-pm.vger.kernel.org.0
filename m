Return-Path: <linux-pm+bounces-4635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3315C86FA9B
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 08:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2268281440
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 07:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901B8134AE;
	Mon,  4 Mar 2024 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PkDCOzX8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4CB12E73
	for <linux-pm@vger.kernel.org>; Mon,  4 Mar 2024 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709536857; cv=none; b=l/gw06009OfsSYdb0zsGJLoX83zGtR7cXav0YhQTu9PZSFHYIJwVPJ56jGuZ6BWmVGyJRfDR+iaEfv7x/ZNKmpY11cHhD/UEVIQKFb2/vNml4rf6fwjVoJyayrSHLjyBQB2mgxi5uslXWPz0ACkcNX9ES8FZq0iAZhwEAVZYUcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709536857; c=relaxed/simple;
	bh=5hqiPwoVJKj8ISdmfSbD73jyVkhgdqtuBQYeN7WhxaU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kJAKxDtrVg8k2/vm78tQirVjHLUwKvAxUP1ZJpwe6+D0T5sp7erobNAoyWt7yAeyR9SlYrPucjVX1Gc7SOypYu4hhe/Z6bZylCibtzj+uPFuII3wdkKksrute4jTXw1jL1NjwWWqM5+bA4K3szzvXCCgK3sXmiLaE9D7LBnxZKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PkDCOzX8; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e58a984ea1so2629805b3a.2
        for <linux-pm@vger.kernel.org>; Sun, 03 Mar 2024 23:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709536855; x=1710141655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ut2KpnnZ5CESsPKC15Vq3psWgxNiIKdUmLqL7tGXlBk=;
        b=PkDCOzX8L5ZFn9XTHFCJHpVxRMhoHCRil0zbqxzOhEaqgimYoywNQmKp5/OgVxr53B
         PrUGlNZfwu4AvbdjGP24kX7nFRESn2GCBYMuRTLtu+uEaTC5i8M2xAf7+KMT8VbMmHUD
         0ngQYCxgFqnAvryiNvidM3An5PvqdPnhq2UUVogJLLeh744uUO11oStNpogXay/kYCYn
         RhiERuyr++N+32pNH6Qy+Qe5T+K1IcxhZdu5wIxXXEyajpGLBpNcwevjMDkIkDWiWY+z
         mZfsN0T5Wt+hwJqeDbBCmsJaKGzhwayNYnxSwElo5+mvh7CBHJzSKM5QYWEARqj/2QGP
         sFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709536855; x=1710141655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ut2KpnnZ5CESsPKC15Vq3psWgxNiIKdUmLqL7tGXlBk=;
        b=gi+eYI5oPWWqTY83QBGzNrEofmFQdu2cg7pGxLnj3kT7oHbHk4Y/q7zpuSXfPxhUxh
         uvHAQw458N3icoyxJcVEzEcD3g89D6ZKjw8jGToweFTjPPzFjmAXiLpUExBwFa3QWOo1
         xGZCpHwlNI5wHQbZJZet+eUCLjLoPqP/FfKlwIRyU900+tAm2kdqZOHToNhZTfPI2sPV
         v+7j9oZG+FC7wP35jkY1mmYPOI4NdQ/0r4aesSCnd176jT4DUjsn19vl36aYnG03csJt
         9OIawD5Kwp8LMafKGmKbgkC1t8XGa1kGhCUeqOsoK1JERLWAwtcUS2ZH2v2MmP4mCIYv
         HcXw==
X-Forwarded-Encrypted: i=1; AJvYcCU5uxZCPLgRUckWnE/0r0sl3+Z03nWWEvs0WFVu0IEk1ruvnrAapcHqoCjw1mBGjAtGLHFlOavylDmyfwXERsW2l700H3OGqcw=
X-Gm-Message-State: AOJu0Ywn1lKJ5yzWmljNA9gTlGz58yB27aUMnqonl4EwK/VaIhj6zAb9
	CKFfYV3MfjqcNDJajaJQ4bIU1NyKOQQp9Jq3nOIaicW/8BhHUCilTeGo80cV3H4=
X-Google-Smtp-Source: AGHT+IEo/kqEecuJ+N+Eqn1OkDYNKTzsDBfk7bsL48hDikMQN22iTV0gQ5UbhgUIKIV5hKsgJxeb8g==
X-Received: by 2002:a05:6a20:144b:b0:1a1:476b:818e with SMTP id a11-20020a056a20144b00b001a1476b818emr3125377pzi.25.1709536855331;
        Sun, 03 Mar 2024 23:20:55 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id l3-20020a170902e2c300b001db82fdc89asm7798615plc.305.2024.03.03.23.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 23:20:54 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] OPP: debugfs: Fix warning with W=1 builds
Date: Mon,  4 Mar 2024 12:50:50 +0530
Message-Id: <50a1a0f23efdc261844a306f5e611051843b4e52.1709536847.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently get the following warning:

debugfs.c:105:54: error: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Werror=format-truncation=]
                 snprintf(name, sizeof(name), "supply-%d", i);
                                                      ^~
debugfs.c:105:46: note: directive argument in the range [-2147483644, 2147483646]
                 snprintf(name, sizeof(name), "supply-%d", i);
                                              ^~~~~~~~~~~
debugfs.c:105:17: note: 'snprintf' output between 9 and 19 bytes into a destination of size 15
                 snprintf(name, sizeof(name), "supply-%d", i);

Fix this and another potential issue it by increasing size of the arrays.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402141313.81ltVF5g-lkp@intel.com/
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index ec030b19164a..96313aa55db6 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -78,7 +78,7 @@ static void opp_debug_create_clks(struct dev_pm_opp *opp,
 				  struct opp_table *opp_table,
 				  struct dentry *pdentry)
 {
-	char name[12];
+	char name[19];
 	int i;
 
 	if (opp_table->clk_count == 1) {
@@ -100,7 +100,7 @@ static void opp_debug_create_supplies(struct dev_pm_opp *opp,
 	int i;
 
 	for (i = 0; i < opp_table->regulator_count; i++) {
-		char name[15];
+		char name[19];
 
 		snprintf(name, sizeof(name), "supply-%d", i);
 
-- 
2.31.1.272.g89b43f80a514


