Return-Path: <linux-pm+bounces-29509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8F7AE84DC
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 15:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26EED7A1C28
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 13:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E7025A2A3;
	Wed, 25 Jun 2025 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDWtQE+9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC3B25DCE3;
	Wed, 25 Jun 2025 13:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858486; cv=none; b=NReFEy5dZKW5MAyf1mKagcod2snQy9xba6LuZDAuCf+9bjjwS16wT718cC40SY9HrYrBfSsxZnqVJ2gaf8LmQdmVDmsNMBmXcNEUh3SOp11n5wb575C71M+TqisWchf64lj7JJ/lLYE7euOSJnK9pzRmD5e0k8Bj1NpgFoXg7SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858486; c=relaxed/simple;
	bh=XNNKqCNks8fpJ2GsjlmUlsFeRfSZsFtwkKxp5R5Ds1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iqsU9BOnuszPysf+fiTH9+mVKD2dvmRWI3mywHNgif1U5mbcL2zDzw9J/4m3sMMSXzwhnLYmUwaNi2s1OpMGYv8hDRcK2AkI/7z9VkMOi8Miisj1RM8u85XIXTuMvqj7BxdpOhr+D8dAyTXGmnp760saVyvkut25Kih72GJ9s7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDWtQE+9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-450cfb79177so9114435e9.0;
        Wed, 25 Jun 2025 06:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750858482; x=1751463282; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sSmidhmKnlvzWCstUxmWvNTNqMZf2JeflouF2xNxjyE=;
        b=hDWtQE+9dVcdAhHn8lewTIz+HqPuLMo2ki1e5sUkltzzzM6+ClklLFuY3+wLBQ9pFj
         OrLADdfnKVSFdZK5jt/J2lx4n028hfWzj/mKlLskyQnyNWdS8O6otSG1Y9/tCgGa+JR3
         EI/NtCzKlsH9V9ecm5l5ZAJcAwnAtpgWnvgoTMXOljeboCDwTeBJalppMLJ3ZAsUg2Rc
         CxWnRD6nw70Gc+qdSQVyJLgZ2Sz5mUvT5qJirMzCJeApiY5Ak4dacfm4y+zkLW7QE3QS
         Msn56Mhp57jcWMND406aD52cwor28uRTct6GikSegrTsinZMhzAHP6XMq98xiCxOyWam
         uvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750858482; x=1751463282;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSmidhmKnlvzWCstUxmWvNTNqMZf2JeflouF2xNxjyE=;
        b=rXPPe8Ofd2pLIJN5tJPsXRx6RZ4cNziW7IOjA0Owr1EorRZzcTt70ADt2ldU4s7KTk
         I8hHzlFmxeeOe9U5XBF1EVLVPRBIFWF9IpYxyO1B77hovLdNJqE2v8/U+jt55s9kOGME
         XV+pESDaagZEa9g5m0SCOi1P7QtIh2ffaTexaZmKcWfIEavjpqIAm7dIUv2zokNFAEx5
         9OXLxBvW44w34WnZfapwYWePSjn+5lRvZWoOY2Gn93hNmG+QWDkFi/dIDiWfE8Ov3foI
         onokb+0wHw8aVg8LgNpwRzrLiqZQ4pog0i1rdhoJestjPJ/YSHOfo8d5nxll1PCltREo
         RKvA==
X-Forwarded-Encrypted: i=1; AJvYcCWjXqlaL0H0ZwmubMR8A2jc2u1fSXDz9/GX28HN+EzpjVSuDkhfV8y/mTWDNM/NM1MCP63c4bqPwg6WfdGd@vger.kernel.org, AJvYcCWnxSCjhiMNpGTSbDeqnDCWQM/E7sJncpsJ02ITyaMjJicAKZSispuLI5C8AkZqn7C3mjTc/fqHXu6VaEzL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8zT7dt38E2PxwfngXn93O993UZznuh59WNZ7my3EzbnkPh5sF
	u7cGCnGUJ0KNgKI+QwpPUreSyS93G//KRYv8Y9PWlSmZskmNbLGrW05y
X-Gm-Gg: ASbGncvjmG0QFH7+2VN3tNZSrSuqqAEA+bmZl59x0fxrdWXZAWBKhEH0HM52ezzryS+
	j8rqX+PfFavTC5z6MFNTz1TbCJFzNhC+abxARObmetWqRaLpyx0/5pJ61V3Upw03k4VxASBKPGC
	pA0Kpuk84pguYowkfJlPIRPAo91hRb+tkYY+cdw19XmWOOcDnuoOvhwqY6ThrbGkcx0+7bBQvpJ
	Cqn4dwrpWruBVnq0JIQtTaLtZlaDVx+eSfoSPF+2igEPGYiiPBN6J3OMt1StpZTnTrgygcFrW/3
	2aPX7XbpoyF50q87FrTZBO4Wm1yQiQdiZWxl1XYdQbAHU+8EsHMXpdyD3PMl80u/xjRTrTeuugA
	/f0iZeoynUz3yXD3ygnQjHKMEiA==
X-Google-Smtp-Source: AGHT+IFZlH16b09EMB+Pjhh0jpiWFmAOwz0K+m0zYhm8+lkZeTOoaanMtMTS1OpTavjWUdQN/5sX5A==
X-Received: by 2002:a05:6000:1acd:b0:3a0:aed9:e34 with SMTP id ffacd0b85a97d-3a6ed66e377mr2851453f8f.48.1750858482317;
        Wed, 25 Jun 2025 06:34:42 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-453823ad247sm21281905e9.26.2025.06.25.06.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:34:41 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Wed, 25 Jun 2025 15:34:23 +0200
Subject: [PATCH] interconnect: increase ICC_DYN_ID_START
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-icc-dyn-id-fix-v1-1-127cb5498449@gmail.com>
X-B4-Tracking: v=1; b=H4sIAN76W2gC/x2MQQqAIBAAvyJ7bkGFhO0r0SF0rb1YKEQh/b2l4
 wzMdGhchRtMpkPlS5ocRcENBuK+lo1RkjJ460cbHKHEiOkpqjHLjSllF4gyRXag0VlZ9T+cl/f
 9ADx9OgdgAAAA
X-Change-ID: 20250619-icc-dyn-id-fix-ddf1699f9ce1
To: Georgi Djakov <djakov@kernel.org>, 
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

Since commit d30f83d278a9 ("interconnect: core: Add dynamic id allocation
support"), interconnect node ids greater than or equal to ICC_DYN_ID_START
are reserved for dynamic id allocation. Yet the icc_node_create_nolock()
function allows to directly use such ids for creating nodes. This can
cause problems by executing dynamic id related codepaths even for nodes
intended to use static ids.

For example, the 'nsscc-ipq9574' driver creates interconnect nodes with
static ids starting from 19148. Because these ids belongs to the dynamic
id range, the icc_node_add() function replaces the node names
unexpectedly.

The node names looked like this before the change:

  # grep nss_cc /sys/kernel/debug/interconnect/interconnect_summary
  nss_cc_nssnoc_ppe_clk_master                          0            0
  nss_cc_nssnoc_ppe_clk_slave                           0            0
  nss_cc_nssnoc_ppe_cfg_clk_master                      0            0
  ...

And those have an unexpected suffix now:

  # grep nss_cc /sys/kernel/debug/interconnect/interconnect_summary
  nss_cc_nssnoc_ppe_clk_master@39b00000.clock-controller            0            0
  nss_cc_nssnoc_ppe_clk_slave@39b00000.clock-controller            0            0
  nss_cc_nssnoc_ppe_cfg_clk_master@39b00000.clock-controller            0            0
  ...

Increase the value of ICC_DYN_ID_START to avoid this.

Also, add sanity check to the icc_node_create_nolock() function to prevent
directly creating nodes with ids reserved for dynamic allocation in order
to detect these kind of problems.

Fixes: d30f83d278a9 ("interconnect: core: Add dynamic id allocation support")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/interconnect/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 1a41e59c77f85a811f78986e98401625f4cadfa3..3a41b2717edd995d0fb864bbea005a827a33c87a 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -20,7 +20,7 @@
 
 #include "internal.h"
 
-#define ICC_DYN_ID_START 10000
+#define ICC_DYN_ID_START 100000
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -819,6 +819,9 @@ static struct icc_node *icc_node_create_nolock(int id)
 {
 	struct icc_node *node;
 
+	if (id >= ICC_DYN_ID_START)
+		return ERR_PTR(-EINVAL);
+
 	/* check if node already exists */
 	node = node_find(id);
 	if (node)

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250619-icc-dyn-id-fix-ddf1699f9ce1

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


