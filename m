Return-Path: <linux-pm+bounces-8218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8158D13E7
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 07:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CB71C209B7
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 05:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7C8182C3;
	Tue, 28 May 2024 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GicH+Ion"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE5F23C9
	for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874276; cv=none; b=kuP7trkp/oZbQvr6NOO5qNKZMrfVYh7f21nAGVuL86WhqnESPQBc9UPz/x8xtODD19n6Nqj4P30djD0RXj1NHqi9DQfpu33u3K9nEg99GVA0T09YV7HGhcuNqiN4ojsleKlOQ/zCq7257h89lxwpDJBw0I93tiVIwIwk97TjWtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874276; c=relaxed/simple;
	bh=LuplH+j+rdgbuAnCMvpduWskdsgcPKBG+yd1aJ3/a7o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lHKsJEQJzxTujc5z7WXJh4PG5UHM44IWKALE1A0JpqBzBpJVWI94N66YhVZbI1oQ4uIqcyuqzYweUl+oVdEgFAFHX1cuMxXAuwbi2jSdAipydwf2Ek4vjIHRdZrhsnPLo2iWIhv5goP7Wim20kLWafuE63YqlhYpQwx3Ztjtz8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GicH+Ion; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2bd816ecaf5so292681a91.2
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 22:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716874274; x=1717479074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5+FTMhLZZISywec5OjCyTlZLnXVqZ81FTRU8X4RIME=;
        b=GicH+IonQ4OlBoktPlpUboxNm+19EznfwMFc5iHZZGYUPRUNZOaCmJmg5qSHCWGhCq
         1kLFT17hOefhIFT5xn2IisBSU8BZ/bf89KSadg5ynHE/JJ8aj99HuXRaeJELCis8JyoZ
         y9rhk2d/L/uIskbV/5KJn+B46wNZaB8L8yj0oeoaGablcdndYUBW0UvDzotNpLYXer0C
         txvw2lqMOpX8ZtmvyRGPvYv+AqITwqc8xAdov6SjJoGNy/WqUcaVtlWfyLWFsmZIIHwz
         OzN6SGXFLCpUhHIh/fGgk21H2bL3QhCe7Cda1vDaC0KRaIU/t3l3qDrLAaRJHRR4RDk0
         PWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716874274; x=1717479074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5+FTMhLZZISywec5OjCyTlZLnXVqZ81FTRU8X4RIME=;
        b=QI4N4jlHmrFc0AzHdLbpiZpbRloPPbgbnrJIqUj2r7rt2AspL0JrW+WLAgDHDZA41O
         JAdmebaaLT2JKBDxqiPk7dsGHUtDw1DjBSxVKRs4mxQcMkRbT+wC3DlNDURgcSFynN2v
         OX24mOTyi4jKQ6bQEewx1r+qJas9Z17TIi5wDW9tX/qAqzLTPokMFr9r+Rppu7nAzXcK
         2yTb0r3MBhUP6V6gN23WImrljCFNwQzEznEsj/aSmJE1mHsPxTEX36eYLDt1yaVoDO02
         yLFdgtFXeQuJ73WhcDbvo71QFbhRUNs5E0ezDmsKgszz2XuX79oiJwxmuQTe8a6JEl1k
         TREw==
X-Forwarded-Encrypted: i=1; AJvYcCXWrg12zkFcp2p+L75ig9u2sY966RnfuNHuSnd93pFaGW3uXa3RXMwZfJ8frQA3xL4ROHVVdWG4VOL7N+8VanbArzQqXU3hBA0=
X-Gm-Message-State: AOJu0Yxl3NwNPsnODF7APA3i7IK57WmZwx25tTCPhpWCxIb2mS6SefIv
	wgmCk0GITqlEtNyH5JRduc8IJp0ytqo+20UCGw0I6OuPuq5tSRfrmf1PXL4yvnM=
X-Google-Smtp-Source: AGHT+IHdYcyh6ZysKM6c3Dy8D0ABzlGEvenJ88MD9FcJr8sFvpoi0fh+nzrgZbCmj4RYtNElGXj+Dw==
X-Received: by 2002:a17:90a:1785:b0:2bd:feb3:58b2 with SMTP id 98e67ed59e1d1-2bf5f20796dmr9449160a91.35.1716874274082;
        Mon, 27 May 2024 22:31:14 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bda3aa45aasm7104744a91.1.2024.05.27.22.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 22:31:13 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] OPP: Fix missing cleanup on error in _opp_attach_genpd()
Date: Tue, 28 May 2024 11:01:04 +0530
Message-Id: <b1378c474427edae9c17a6e84b628c1f1cc59d6c.1716874256.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 2a56c462fe5a updated the code mistakenly to return directly
on errors, without doing the required cleanups. Fix it.

Fixes: 2a56c462fe5a ("OPP: Fix required_opp_tables for multiple genpds using same table")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202405180016.4fbn86bm-lkp@intel.com/
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index cb4611fe1b5b..4e4d293bf5b1 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2443,8 +2443,10 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 		 * Cross check it again and fix if required.
 		 */
 		gdev = dev_to_genpd_dev(virt_dev);
-		if (IS_ERR(gdev))
-			return PTR_ERR(gdev);
+		if (IS_ERR(gdev)) {
+			ret = PTR_ERR(gdev);
+			goto err;
+		}
 
 		genpd_table = _find_opp_table(gdev);
 		if (!IS_ERR(genpd_table)) {
-- 
2.31.1.272.g89b43f80a514


