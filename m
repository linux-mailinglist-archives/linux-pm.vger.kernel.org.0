Return-Path: <linux-pm+bounces-35923-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4322EBCDC52
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 17:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427124240FB
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB692F99AD;
	Fri, 10 Oct 2025 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRGmmmwy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D922F90DC
	for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109309; cv=none; b=iIDvB8DZOJJi2/qzdQIanrAYE5fnybY3Q+tsJxwSIOCG+1znLgFuwipjAHhEZPwPe8IveJgdMAM6lsuxyfqVvKtaq2C0RkbDrwjvTNrnpSYV6U1XTGaIekwDHKlurGRW9qOwyN1kwXSIP1ZGQ11VwMUNgA+EswPX9iYUNNMfHQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109309; c=relaxed/simple;
	bh=rODvI7V59ljrj50mNeNRchQt/hB8lmPZOaakB/PpIO8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r35gqB2+jUNMyL+N8Hi2zzg2Kc0V61dsxpONg/WXoxUF8rux25AKFi0vdGSjpxqTpjW4ctFMnkgcgcjTNAsLaFRz3fEhoq/zJq/GReYy1Bb7wH/cNjJE9DZvXIkUGYeqVH6APanBVUSU+UypC37UJ7dMOZ/P926vjBe291Qdow0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRGmmmwy; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781db5068b8so1866725b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760109307; x=1760714107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ku7ytx/v2Q4TA+VLykkrqqJQyrV884GCo3tZKDi5IH8=;
        b=VRGmmmwyE1henoUTeLWhWGJG+3sbxhproDR2pWEzQN4DZcDlIcJQJmFw02oicoLFdu
         wK2jBg2R2w8kFGzB2IzgZaErfyfoo9JBUFZPH5MM5RFR3S7jmlpcbZwmmsISNqhJmblt
         JnnU+947yE+mhsDNnAkC+AkV9/gl2mOSiPis9h4gQBCOid185h82lnEKBA7xwngPhIC6
         qmqK+c1UOcY4HiKr5LqvO72yZ4EE58pOPoscW7XDy4jGQwKkuZ9MGcZK47kacV6iw32q
         JQzF9J2ksK7Gb4OFuWCH+AzP/xciY9aal6ojxZ/xLsJin58mEpAifJ5hSjbWpNX70C92
         L7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760109307; x=1760714107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ku7ytx/v2Q4TA+VLykkrqqJQyrV884GCo3tZKDi5IH8=;
        b=Lf/uwV5RoPQNedh5t6A6NWNSCcMEYaUtcJ6wJQYCOYUCe0PLp62OamrxNx8HLQMp/B
         HDjhhxE7kYT8N8bIQXS8N9LX4N25rQFLQmbcWwgP7OMbN/k1qTaQdBbTeE16wQ7qYn53
         2qssgFxgiZHwMIhIjkEN+nbFUKSb+b74JiFAw4RscLEhh8L4Ez+jzpDifjXMvnyOer0R
         4YoWKRZjAzQ6NrEM3b+27voCDInACpP28T718kptMorSZ9euleN8QFYinMnD6Nbp4h5N
         c8RkPJjuAUvIdMuQg0zEiD6REMa/MehX+ekGfwMVdWYcUeJ7lOICEFioN1aurKGOAAkP
         CMMg==
X-Forwarded-Encrypted: i=1; AJvYcCXywAQXDYNuLoNQZ4ThoNg8r56XNyoV3t9Z3Oy3/r/VS4GjwI/ww3ehwrXG0ihXt4uvKzmi1cIF/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1w5zD/k4VypGxA9Zi2jrO8lcOHh1MFqTjPjl6UYcbQeWXycLb
	VhvIOrkaxYbZliOIB/8relh4OOS0gRmlSCY5Ad6iEIOU+7Kl/Wd8Qa3+
X-Gm-Gg: ASbGncsku55ILszroRlsQiak5mA8Ei5FKNo6D9fF+BsNFX5Xp77Ptvsp7ZdxNSHsx+i
	fKna+K5RlmjgVhvViOh3kZz9uGOK61Hl4rdadey3mvKVLq+Htm3AWFmoT3ZF3d0QM0YaCyA4cDh
	EQZQ4lt6DY5v3+NPjHsFLwa2co5XALcfcCgiNz26WiJ8iJKq1RTT0epifRRfAywBSWsBndJL2n2
	36kyUktZqa6d/wZzh8N/Ncaro+5ODg3ihUSnGimnic/Yt1eyZg0q9sft/SLaCo4x28JFEijuiIz
	M/SelBr/b6OO+wtk8xrirXfH/66cAIUoY64Pq+mxK/Yl2bZHpSGpIrUl68GPyn0V+Nz+E2t2Fbm
	v0XKxXVKFIRQrxc1tuQpoh0JZhpS5AOKQBy3WryIkovcb1TlEMhnSMk16cMfC/kV+MXa6OQs87U
	AX8BfQUjAJKlJTlMwG
X-Google-Smtp-Source: AGHT+IF+CkE3KtT6ionDkSipExdfGDISvekrXKi2WT6S/RtLOjkVq23qdW0ISl/zTZg3zmduaAV6eQ==
X-Received: by 2002:a05:6a00:2e92:b0:77f:1ef8:8acb with SMTP id d2e1a72fcca58-79385ed596bmr15180309b3a.13.1760109306603;
        Fri, 10 Oct 2025 08:15:06 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e134fsm3270685b3a.58.2025.10.10.08.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:15:06 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: djakov@kernel.org
Cc: quic_mdtipton@quicinc.com,
	jserv@ccns.ncku.edu.tw,
	marscheng@google.com,
	wllee@google.com,
	aarontian@google.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] interconnect: debugfs: Fix incorrect error handling for NULL path
Date: Fri, 10 Oct 2025 23:14:47 +0800
Message-Id: <20251010151447.2289779-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The icc_commit_set() function, used by the debugfs interface, checks
the validity of the global cur_path pointer using IS_ERR_OR_NULL().
However, in the specific case where cur_path is NULL, while
IS_ERR_OR_NULL(NULL) correctly evaluates to true, the subsequent call
to PTR_ERR(NULL) returns 0.

This causes the function to return a success code (0) instead of an
error, misleading the user into believing their bandwidth request was
successfully committed when, in fact, no operation was performed.

Fix this by adding an explicit check to return -EINVAL if cur_path is
NULL. This prevents silent failures and ensures that an invalid
operational sequence is immediately and clearly reported as an error.

Fixes: 770c69f037c1 ("interconnect: Add debugfs test client")
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/interconnect/debugfs-client.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/debugfs-client.c b/drivers/interconnect/debugfs-client.c
index bc3fd8a7b9eb..778deeb4a7e8 100644
--- a/drivers/interconnect/debugfs-client.c
+++ b/drivers/interconnect/debugfs-client.c
@@ -117,7 +117,12 @@ static int icc_commit_set(void *data, u64 val)
 
 	mutex_lock(&debugfs_lock);
 
-	if (IS_ERR_OR_NULL(cur_path)) {
+	if (!cur_path) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (IS_ERR(cur_path)) {
 		ret = PTR_ERR(cur_path);
 		goto out;
 	}
-- 
2.34.1


