Return-Path: <linux-pm+bounces-190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3917F80F9
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 19:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA461C2164C
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 18:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9A4321AD;
	Fri, 24 Nov 2023 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UcTYqK4J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8F21BDD
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 10:50:52 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d7e67c169cso1318137a34.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 10:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1700851851; x=1701456651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GN2VkgC7Ox1NKiEC9HCdwkrrRrCW+s3lIxVSHnTzVKU=;
        b=UcTYqK4Jjwn8vgjOlshR6k5n5qTBhMiWVqTgJQIzHwQydGYEs9Qj1+WymB8+QqN9zQ
         ljBe0NTP9cGykOHz5tHr9xD5L8v4GW+hWWlZgJvdGE9UyI023zhJnbAT5eRjg7Yw749w
         +IuHmefov1p8+uItZsC3MOPt5+wZFE2zlc8+FpiJmw6QT1JodieZcMRKU493wdDhPEmI
         X1X2CavVyz6pvqORllHFOIr/n7fBiNAyOElwCRXqQW0S7NZXRQ3TLPtWXW/vqH9wT/5u
         ZuYxVp8by2XVlaX4mibgiDQ3KaRXx6B5QygeLYCqOfHL8FphQ5U2cipwBNHOjD30EbjM
         bTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700851851; x=1701456651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GN2VkgC7Ox1NKiEC9HCdwkrrRrCW+s3lIxVSHnTzVKU=;
        b=UW+JaEyJL+jpMgKf16Yyb8fkB9us/HVSeZ9PvpgqwKC54NiAD3n9V0dvalRoq4s4g9
         BoecTpolreYCrCQPvmUN/YMfI0NGza46XW3KpynrkkwLidaLeMbM3VXv+dOM1tipJR2k
         I58vOcpFdgPD6g2tJ2bWw0nfLtW/up5lxBuDuC/TSrcs0QdivhPa9hH8d7H6rPWRq1bj
         2h3JBBKzWSaRscsbwWzrbVVYziaWLgeFDHOn7iDSenMMsRezXzCPSbSUDahzbqo1/d13
         MQm9zt4a49WyJ+3aMAQ04KGBNTXSpsKHUVOM+1SF3eqWFdvXiMYfqmnZ/0tDA74NBYnj
         tnrg==
X-Gm-Message-State: AOJu0YwI2E9Ga8Ha0uAWdD1ddN2PfsGUCgMzr3KxCzKx66WeqjyvLxEB
	Wgx3DfUR3rP2uRqXiocF8eT9E9kDxRqLzs0gMtgWvA==
X-Google-Smtp-Source: AGHT+IGSlMbH/Ck5ElefEgjBJPgaupOZ0YPj68+cSBsnSg8DNXRhAre6QsKPuSm5nqrDd40GTTUtRQ==
X-Received: by 2002:a9d:7553:0:b0:6d6:567a:c83d with SMTP id b19-20020a9d7553000000b006d6567ac83dmr4211966otl.9.1700851851133;
        Fri, 24 Nov 2023 10:50:51 -0800 (PST)
Received: from 6VQ5VV3.attlocal.net ([2600:1700:19e0:a90:c242:2a26:eb7d:4205])
        by smtp.googlemail.com with ESMTPSA id p2-20020a056830130200b006d7e99c4bfesm584696otq.57.2023.11.24.10.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 10:50:50 -0800 (PST)
From: Stanley Chan <schan@cloudflare.com>
To: linux-pm@vger.kernel.org
Cc: kernel-team <kernel-team@cloudflare.com>,
	Stanley Chan <schan@cloudflare.com>,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools cpupower bench: Override CFLAGS assignments
Date: Fri, 24 Nov 2023 12:50:41 -0600
Message-Id: <20231124185042.315148-1-schan@cloudflare.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow user to specify outside CFLAGS values as make argument

Corrects an issue where CFLAGS is passed as a make argument for
cpupower, but bench's makefile does not inherit and append to them.

see also:
commit dbc4ca339c8d ("tools cpupower: Override CFLAGS assignments")

Signed-off-by: Stanley Chan <schan@cloudflare.com>
---
 tools/power/cpupower/bench/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/bench/Makefile b/tools/power/cpupower/bench/Makefile
index d9d9923af85c..a4b902f9e1c4 100644
--- a/tools/power/cpupower/bench/Makefile
+++ b/tools/power/cpupower/bench/Makefile
@@ -15,7 +15,7 @@ LIBS = -L../ -L$(OUTPUT) -lm -lcpupower
 OBJS = $(OUTPUT)main.o $(OUTPUT)parse.o $(OUTPUT)system.o $(OUTPUT)benchmark.o
 endif
 
-CFLAGS += -D_GNU_SOURCE -I../lib -DDEFAULT_CONFIG_FILE=\"$(confdir)/cpufreq-bench.conf\"
+override CFLAGS += -D_GNU_SOURCE -I../lib -DDEFAULT_CONFIG_FILE=\"$(confdir)/cpufreq-bench.conf\"
 
 $(OUTPUT)%.o : %.c
 	$(ECHO) "  CC      " $@
-- 
2.34.1


