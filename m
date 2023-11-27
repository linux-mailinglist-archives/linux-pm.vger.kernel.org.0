Return-Path: <linux-pm+bounces-314-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7841F7FAC7E
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 22:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB641C20F18
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 21:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7486145BE2;
	Mon, 27 Nov 2023 21:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CfiNcizt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E743A1A1
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 13:22:53 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1f9decb7446so2356032fac.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 13:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701120172; x=1701724972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pm/kMep9njZjxl+Bq2GOnT8kjtkMlwSLLZmKqM0eDCk=;
        b=CfiNciztm4wcvW+INUWl8axmRto7oFLFUaOcxWCqsC069OB3vOlngrY3H+qX3PqAK2
         r3DM1LrFTBL1t5gA2NvvrJp0XVZcdP2XiixQOPMWpoNZELJ/3zS5H4UJV0KkA3H70QBB
         Kf8lqT6c+RS0XhqEEmqYbtGkIH6la6ha0lsou6CsQ3gncxWe9LoqLzU1+I4tkRR8FOEj
         TWVcFSFHOLyPXTBAWm0gXfLC06IDIhqRK9VT2t2AioO6MzRN4EXdqgefiWouBGTDlg/9
         nyBu2GZMEuuV7YPcPeCSTlyV7jlu6enP0VyRXX5ak14blTK759sVYzlpR3Dmzm84Xowf
         9pTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701120172; x=1701724972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pm/kMep9njZjxl+Bq2GOnT8kjtkMlwSLLZmKqM0eDCk=;
        b=CLAXaHYye2XrTPP+yCV/fJl1plYBN1gpLGywlKrbjou/7xYvaNssHY1VK70mEl2j5w
         OhThsqzmiFSTvZ4Vd+4I4RxxRKkhbvyv6GPcbGm/Gm/9WtCFmRLv76XIgsGBIyoGmh9h
         6bYTWx9sEIoUJxGC6RQudB9dwU2svltdKsLXYeT8fbKZqAxpTqhf06wRBMCUN8El3pIS
         F9wzRejAZYpQH6b//9JiUAxy3CQp3BKzU7wduQaaD4mLR0bZ1LtA+k6l46JjYI45j8Hn
         WFiIIrzQJtRwePAkvlGI9jTOrJCPQ0zsGpp9aqgMYf8yZWzvTS9wenFVUZjxsqPmetSO
         rzPg==
X-Gm-Message-State: AOJu0YwWgZE3gcW+mSPFSd+lTOv4wf9EAkxPlo7UQ4602JtZushAIO8E
	HUzjhsfS5YvHnsBEb39lgJOAdWvTxqZUA2IPLpubPw==
X-Google-Smtp-Source: AGHT+IFn9ut0+wXHavrWe/+fqYS4omXMegJmOQRWKeJvW3yK1z53dv6HcoK1946rO65k6lUhMGldSA==
X-Received: by 2002:a05:6870:9a14:b0:1fa:ca1:1f1c with SMTP id fo20-20020a0568709a1400b001fa0ca11f1cmr16696833oab.44.1701120172233;
        Mon, 27 Nov 2023 13:22:52 -0800 (PST)
Received: from 6VQ5VV3.attlocal.net ([2600:1700:19e0:a90:9595:6582:b5ef:e730])
        by smtp.googlemail.com with ESMTPSA id op12-20020a0568702dcc00b001f93d190984sm2484770oab.19.2023.11.27.13.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 13:22:51 -0800 (PST)
From: Stanley Chan <schan@cloudflare.com>
To: linux-pm@vger.kernel.org
Cc: kernel-team <kernel-team@cloudflare.com>,
	Stanley Chan <schan@cloudflare.com>,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tools cpupower bench: Override CFLAGS assignments
Date: Mon, 27 Nov 2023 15:20:48 -0600
Message-Id: <20231127212049.455008-1-schan@cloudflare.com>
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

Fixes: dbc4ca339c8d ("tools cpupower: Override CFLAGS assignments")

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


