Return-Path: <linux-pm+bounces-33427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B902B3C2CC
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 21:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BC03AFD2C
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 19:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0735720F08C;
	Fri, 29 Aug 2025 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3LN6r2r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com [209.85.221.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660291DFE26;
	Fri, 29 Aug 2025 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756494281; cv=none; b=YYhcppq7UWTBEsIl4HFw7yMktk5I+Bq6nXtVzQVPCG1O3pSMIk+k6+Y2a+w6B37/Mp9mAj8EJAegUlojrvrseERnvSF7GmxgXD3Pu4+DoWcVbsvqXcv7SGAH3YZHwH0fuNQAcii5cIhc/UHZ/dIJAc/WFsAY71Yqg/n2BvBp/R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756494281; c=relaxed/simple;
	bh=JhCHGrska4THm4pq3pOoh1c76MB5ThoIsa90tvzUeRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k8gsM+ZYwYQaRwaIiP77pzio1jFXwTiPvBkOTLAhv7uUOTkMBMxNeJ5cKrLbsZuMdnr17LBW8GMZds/rxjrlaYr1CqkBsscKcWc2oexZPbVoI/tpNcuAqAJN9T+jBtQX4Qua4im+GsXiXt7A7Kvxt/oyeeEgNQg2PUPBptntjQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3LN6r2r; arc=none smtp.client-ip=209.85.221.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f196.google.com with SMTP id 71dfb90a1353d-53b1736eae2so1695644e0c.1;
        Fri, 29 Aug 2025 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756494279; x=1757099079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v+nDa008+XeBq2KuIW65QNSIBYM69OB4YXETiL9qtzE=;
        b=H3LN6r2rwResO9RZfdSfOSo70MneDVwgQhEgAeWj4DjjfdCix4DYG4rOZMUiD/l1O7
         ahxZ6E+6Ho27v3HQJkAQVQVLlsMOZaCEcukQIvXH4AAPYSKPzKtiKBuToCb5v9GWk7Ui
         U1yje6pM6JvktB1UaXpxkfh3hiOiebNYYtI799U+yLYcLJXGXQslAloVEV0YAtkq/Rbh
         fTdYs/5959iN/pV1yTJy7kvWVVOfLOCGPCpzg7vfdYda+k5RH/TwxfYxNwqSb6L/o741
         WhzSlWTtaXGGoYWkClj6k9sMri5seJDgApd5MAvHQQMrczHUUVvpn3ikfRGkfSstxWSj
         4iWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756494279; x=1757099079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+nDa008+XeBq2KuIW65QNSIBYM69OB4YXETiL9qtzE=;
        b=aAYTuWx3BvXTwo7crKPhrDElhg3lJ3sN6jfq6qz7DtvzcGNiDxRFz89bOY1QGbEzRl
         pD6DFuMQkL7+HCgioEdefqK/igF4EEIKHXDWS7syjbxW05K8+3MWrbuBTaC07o5hohs5
         Guhvm/RaejpkoPkCNr2RTeDdCs4xwbVz/MIq1EUXye0F9mX7S1I6PYLfsdfFiaYGt7py
         ie4rP5vps9RmqOeysrv/zEhSizF3kwyhoQpax78pSIG1BG+ApgEcDsjO/N2edyJ/FvdS
         /wbnTvH9v8SwEiruVDwNi3ZyBnJOaJrQCgXpf4VhdMCBO8YFRNK/HXW2P2BNQXKG05qf
         vxGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi87CcfP6hLV10zs2kCrYmuD5+xi9nbbmMp95htCYGIklfxuL/FbZeVLkEPK+agj/su2Az4DF3cWA=@vger.kernel.org, AJvYcCXMPSs3yor/hUMEjnc7k/3khF8ES3+IsnRCVu3DpuAyzSpIJYr71DQgISVKAF9zVcaz/I6zW6hLfseNVMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP2PAuq+TB9xZBeBjhoxeij5XPzYuTg/h4j1JF1XyJiF1xyYPn
	F5pIhDzpWnoh3MRG9TgRwRrh0MglW0dAib7TeRuzoUIkSMu/uPSIpIwf5Hzacc4lCrk3gw==
X-Gm-Gg: ASbGncsXG253s9vyly8JlgOhFO5a5nTHRYxz5g3ZkpEEmIvgz/9ptCku5ES/mwTnwNZ
	7n6rRWjQqI5FSI+XeUwx0rRWyzBwATmLK7OgJTXc8ut21IMskegnHYmguV97LkSY7HbRumsAXYz
	ptJQSqzC+n4x9bh7M7foqnJGenlLP1UoMU9l7LfcpTGyU2vHGTD3XW2djZmuh8ydPcNvpcyqIem
	JgRpE5pt4QuHG2/hMzNxH/COPUD1LiHpsEWRpws1ZE7JmHBBbDojCSsqCTbEgvjdlDhHzWABWQC
	lM18eRnBEtoS0hvAHuv6EGTYncz7FOS8fr0peG4D1ZX/oBNePQ1MCJx+q7O1Mj3yfKN6MDlN/Yf
	Z8LjD5J3/rBBc/AWpvpOPO9caV5e/xPyQCKgJieNSaC2QKi9D9ZqT0s+t0jwnw3BCUSbgXAU4D/
	vy84yX0Fszgg==
X-Google-Smtp-Source: AGHT+IGx8KBShFXMBBwWnArmqIgotYFVK9bycczBOS0HpEYvdfeGf4tGJznXwzgYiwau5/7+6KHcSg==
X-Received: by 2002:a05:6122:552:b0:543:2dfa:2f30 with SMTP id 71dfb90a1353d-5432dfa5fe6mr5791933e0c.5.1756494279162;
        Fri, 29 Aug 2025 12:04:39 -0700 (PDT)
Received: from laptop (d-146-168-99-93.fl.cpe.atlanticbb.net. [146.168.99.93])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-544912fdff1sm1305874e0c.10.2025.08.29.12.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:04:38 -0700 (PDT)
From: Thalia <thaliathenerder@gmail.com>
To: rafael@kernel.org
Cc: pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thalia <thaliathenerder@gmail.com>
Subject: [PATCH] power: Handle kmalloc failure in pm_vt_switch_required()
Date: Fri, 29 Aug 2025 15:04:31 -0400
Message-ID: <20250829190431.133717-1-thaliathenerder@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit improves the robustness of the pm_vt_switch_required() function
by adding error handling for kmalloc() failure. The function now returns an
error code (-ENOMEM) and logs a message to the kernel ring buffer, making
it easier to debug memory allocation issues.
(that makes me sound so smart yay)
(this is my first commit so sorry if i did something wrong)
Signed-off-by: Thalia <thaliathenerder@gmail.com>
---
 kernel/power/console.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/kernel/power/console.c b/kernel/power/console.c
index 19c48aa5355d..0e4b8e0c480a 100644
--- a/kernel/power/console.c
+++ b/kernel/power/console.c
@@ -60,13 +60,34 @@ void pm_vt_switch_required(struct device *dev, bool required)
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
 		goto out;
-
-	entry->required = required;
-	entry->dev = dev;
-
-	list_add(&entry->head, &pm_vt_switch_list);
+int pm_vt_switch_required(struct device *dev, bool required)
+{
+    struct pm_vt_switch *entry, *tmp;
+    int ret = 0;
+
+    mutex_lock(&vt_switch_mutex);
+    list_for_each_entry(tmp, &pm_vt_switch_list, head) {
+        if (tmp->dev == dev) {
+            /* already registered, update requirement */
+            tmp->required = required;
+            goto out;
+        }
+    }
+
+    entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+    if (!entry) {
+        pr_err("Failed to allocate memory for vt_switch entry\n");
+        ret = -ENOMEM;
+        goto out;
+    }
+
+    entry->required = required;
+    entry->dev = dev;
+
+    list_add(&entry->head, &pm_vt_switch_list);
 out:
-	mutex_unlock(&vt_switch_mutex);
+    mutex_unlock(&vt_switch_mutex);
+    return ret;
 }
 EXPORT_SYMBOL(pm_vt_switch_required);
 
-- 
2.51.0


