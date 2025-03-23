Return-Path: <linux-pm+bounces-24437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1789AA6CFBF
	for <lists+linux-pm@lfdr.de>; Sun, 23 Mar 2025 15:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD26188DE7B
	for <lists+linux-pm@lfdr.de>; Sun, 23 Mar 2025 14:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2613A8C1;
	Sun, 23 Mar 2025 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdBSEeBv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFE86ADD;
	Sun, 23 Mar 2025 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742740279; cv=none; b=HMJ9/fAt7BdlZPvmygD8DT/mTYeMYxhUohHkyfoUnVfBCYxHVZX6q9JDPQq53t8ftBZv21L4TX3b9fCA9foFQP9Y2tcLCbXM8WDdJBh3PytgIPcH8lut5dfkqj6AnAJUZa71ZM1LLSgsigm07Kf0jhF/L+YgLK57rypHDBRuz8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742740279; c=relaxed/simple;
	bh=YtZNCx20UFkJV4E3LyfleA9XyUWhTkdQ7uT5cV/wZTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MsG0ngPYmFm7bSVmgPwfZ4bCvViItNowvOn1byt6HAwEFgVmbqYc2/S61H/Ef/6x1PBcDdv0IcoHehTE5GdWCZlpEeYuRijy8Nwe5Z6JId0m7IRBzJelKt/PK8qWBqJQw5AIEpfmD1fCkRqGVRNG3cS2t23E05FpO2pE/6NjNzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdBSEeBv; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6feafc707d3so30846007b3.1;
        Sun, 23 Mar 2025 07:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742740277; x=1743345077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OwhPzibW/0lFOIn8jrj1EKhaVT3olcHCJQYIQSwSsTQ=;
        b=TdBSEeBvBgY8OQS6fj5Wzpm8NR6lqcp+NPPF8FHiYMZ+n3mqjDYJ9vq9lqm51Cpzh6
         USBWOlSHE2+l0YT2EXfTedVO1GoQuNRCqsoBxuky8VFlL5sZLXLszhKiXAa2pQ2YorIz
         bRBDYI64OtWb3SP8CZ5mWXByxvGYVS9TL86SGGWVrbATl6H3ZA5kZXKZbmEesK5ogT9R
         019QpuwTZPMsXCw7VT1BecTUmoxmdUgx9Lc/M2lCNwwdM9k+DYOck9ydfmbI1F4PNG07
         Nk9pVPtfeE/da0F+hFnn13HYgNUcpuZ/dQg1gkHfixZJOZFa0XDWy8Gw3sVvZiK4EPzx
         fjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742740277; x=1743345077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OwhPzibW/0lFOIn8jrj1EKhaVT3olcHCJQYIQSwSsTQ=;
        b=tIa4L9jCcHNmQEuWEMLMM8Dh2Bm/hDy/f9FK8boVfEMdDm6LCfkv49DxdRx89Y3P4r
         ceoyky7ZDrpVNZnSajo8+efAV8DuxRmVNaNDsgfJvGwVVzwY9SXGBg9gOVlaaYjSwkZy
         sqByQuGRER4Nn+WyTuNggDdoihU2fsFmMO5s/X3qhvALX8wlgnUnowBGdZ3aTa7/corp
         bTFvxntQtyYJuk93/jM4iyIGJiWKS+cjRDymdNKSyMH9HT6iYymR6RMu4jq1Znu0w4s8
         Le/USFi30PdjXV9u01rXefFe6OCTTkXInAmnmwS6JWaEf66nI8L9aok+g0ImwoLvVyfk
         otxA==
X-Forwarded-Encrypted: i=1; AJvYcCW+ZpCjA9NrpFpqMys4sj/VtdWCx99+6LAYAalbt6Y3MlGiEochxFwtuyQKqGUQCM5RYp7dCwNcbqXvuJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4sNPmH/0J7Gr0YUVzqAVa/UT87vtmiUF7usBRUwzHENC2rNpx
	OJj5eFqcU73QP1YjVzyaOkLq98E4OQfQ+Q36QTiA5ZlgjulYaebbXJjh0g==
X-Gm-Gg: ASbGnctRUct396o7GPkZsc73q33nk4rti1vn/zanLhlmV88s1KqfM0w4nERenmBfeNr
	a8FlZKcRERwJt2QHbeTSxMUFgfrKFMNSTA7UkJrm9IW9I8GBgXcvs189Tbg/hB7imZjEKoW+b/G
	RfMWgNFOqeVvkvMrIO/21KmgXVSAxQTCpXeF5N8zUy4+qGrjL1BSQKW4UXqRwwjMEKBu4csRaF2
	fQSI3H88WeejM1N4DrIwhIh/umqlgGrl6GKyCITYMUkfil3w//hF1ed9ZDczkelQvV9IJA26wR7
	N6SiFmhiezMqp6PtIT8oSAwHlK2lZQlHRQ2olkDTLaMxlostlUAOPH3Qbm2fdXY=
X-Google-Smtp-Source: AGHT+IFRvr4hm2z2D9ZBuYN0ijqS9RopqxklrqSwifTjVMR0JdghmeXmwrRSkSsh+ZzcWINa7J2LBw==
X-Received: by 2002:a05:690c:dc7:b0:6fe:b88e:4d94 with SMTP id 00721157ae682-700bac6f9bbmr138344887b3.19.1742740276596;
        Sun, 23 Mar 2025 07:31:16 -0700 (PDT)
Received: from localhost ([64.234.79.138])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-700ba73b9b8sm11361287b3.11.2025.03.23.07.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 07:31:16 -0700 (PDT)
From: kendrajmoore <kendra.j.moore3443@gmail.com>
To: linux-pm@vger.kernel.org
Cc: lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	Kendra Moore <kendra.j.moore3443@gmail.com>
Subject: [PATCH] Replace strncpy with strscpy to ensure null-termination
Date: Sun, 23 Mar 2025 10:31:11 -0400
Message-Id: <20250323143111.79886-1-kendra.j.moore3443@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kendra Moore <kendra.j.moore3443@gmail.com>

The field pcounter->name is used as a null-terminated string.
Using strncpy() with ARRAY_SIZE - 1 does not guarantee
null-termination and can lead to undefined behavior if the source
is too long.

This patch replaces it with strscpy() which ensures
null-termination and returns an error code if truncation occurs.

Signed-off-by: Kendra Moore <kendra.j.moore3443@gmail.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8d5011a0bf60..8f24e18d3de0 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -9345,7 +9345,7 @@ int pmt_add_counter(unsigned int guid, unsigned int seq, const char *name, enum
 	}
 
 	if (new_counter) {
-		strncpy(pcounter->name, name, ARRAY_SIZE(pcounter->name) - 1);
+		strscpy(pcounter->name, name, ARRAY_SIZE(pcounter->name));
 		pcounter->type = type;
 		pcounter->scope = scope;
 		pcounter->lsb = lsb;
-- 
2.39.5


