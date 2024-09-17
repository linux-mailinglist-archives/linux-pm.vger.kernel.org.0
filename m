Return-Path: <linux-pm+bounces-14371-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D3F97B0E3
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 15:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172EE1C24080
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 13:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42A4176AD8;
	Tue, 17 Sep 2024 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+ykqwX/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7F82905;
	Tue, 17 Sep 2024 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726580610; cv=none; b=CeP2ZMzMCAlyuE5u6fiupOhmiv3bqxTVfljCLnP9GWKEdB6xqrV1GryQV+O33I+dH4nauoO6y3RTFmYBN3svTgnhJV7qdA6AGQneLTF7UJDmgkzWnLGw530pKQyx45WCCGMHATqXdsQNzKnWt+zEPg/4TSre9VS360o+EFUDth8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726580610; c=relaxed/simple;
	bh=/TveRk5a9mwo3YWee1GIejkOV8p5P0JdODs1giQprpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mSUUzKW1CTr3RlDqSiYnoC+xamtJugKhxyhZgAXJQjC4oqPFLeMzWGHCqNe3G9cl3TbrYYOoriEy0pcbluT4wSDneCcb7XkIChKD0c8qLngCYejbjvWdKY7hAUdZ0TOrmWP28PlKo590SM5zdZ32uD/cxTGZXEsV5u0J8zUNDlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+ykqwX/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cc8782869so55134815e9.2;
        Tue, 17 Sep 2024 06:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726580607; x=1727185407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bbb2mbO8AMTdwv/45h50v0aXu65v+xvFa2gHtGlfMuU=;
        b=M+ykqwX/LcTIJWPjLPLJu9SyFqXnuKjxtmODzrCr1Nzm+aJlUO/scYZZzYNRwWCrwz
         cEu6S9J5edtcoFvqPHrCNaUOrOm3vuBD1XQPXTwD0MAZ4GrnlQePAy8msXdmw8YycTXe
         pvvml8LB7YVMVWjwi+Bop3xUK/Hjc5o0rhi7e1bIt8XnVb1Q+mPg7B++hesGW6REJzFE
         E2PSDJK85Xe9G7krsa9vIaYQBeyEcphIipBXCPsbjaznJpAE79vxFe2zKSkIpEPPdlE1
         gqU/6KmErcu772kYXUZ3MvuMlnnYIQneIFnYL9+IbOHmD1xRR8ZGv0q6RZL25kt0Lvvm
         FtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726580607; x=1727185407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bbb2mbO8AMTdwv/45h50v0aXu65v+xvFa2gHtGlfMuU=;
        b=lQiTROg9SSUCiEu+Bxw1Vt7sO6WUXKKTcDvgKw4iEJvHFjjYypVUOk4TIzNLCSw/ZG
         S2CgWu9ILh9ETxgBooFx+rfLpOyiSIvpQh/1qHrsMcdbO6C7YOWHxNQDHPgPG6HcL303
         nYzNu7+lxPvod4GHvuXzH6JvE5WbTuAeL3r+woRAwUy/ROqqrG21on9FHRKXXtLQewlr
         RuPCD8gXEbOiJQ3haZB7SFsW9SV0HjZgPJoa8IVz7adTT9PgQcMgcK5glE/MAHLbpIqY
         25NPKIpz+OXHbpQX4NhhcCKjTtUAsqg7GDxgIUr7xlr2wb/cdziGbsqPqn+fmCkJUxLB
         E1aw==
X-Forwarded-Encrypted: i=1; AJvYcCU+hX+tSUWRmwQy/N3p0v3/kyDs8HlXSQXnIu5y9h2Wz+Qf9Ed+mRNn5cuL8TAqHjJ+DGtr2Q+mppA=@vger.kernel.org, AJvYcCW+i7IpWRHshtYb6s+cWmi9JJ0BzRdFBytIxg7F9VB0PISzsPoAB/zRt7R5OPmEjKL02ay/O1mOasJXcgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD6tg21w6hOIEuvq/QG6ynljAg7RXcs46winAjGpfu9MqkpKUb
	ua0DASCE23J8d78u1vCTC4wUQKwR3YVgLH1xdi6g0+FlF+eoZbM8
X-Google-Smtp-Source: AGHT+IF7jeBYtmOFXU6REeO5iUKQgDfXwRXsUA/x3Dj8962mQpX85hKXti71qD+hXlrL37TPw9KEqA==
X-Received: by 2002:a05:600c:1c29:b0:42c:bd27:4be4 with SMTP id 5b1f17b1804b1-42cdb531e7emr131668535e9.8.1726580607110;
        Tue, 17 Sep 2024 06:43:27 -0700 (PDT)
Received: from localhost.localdomain ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f06a4sm9506530f8f.23.2024.09.17.06.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 06:43:26 -0700 (PDT)
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>
To: rafael@kernel.org
Cc: viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>
Subject: [PATCH] cpufreq: Avoid a bad reference count on CPU node
Date: Tue, 17 Sep 2024 15:42:46 +0200
Message-ID: <20240917134246.584026-1-mikisabate@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the parse_perf_domain function, if the call to
of_parse_phandle_with_args returns an error, then the reference to the
CPU device node that was acquired at the start of the function would not
be properly decremented.

Address this by declaring the variable with the __free(device_node)
cleanup attribute.

Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>
---
 include/linux/cpufreq.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d4d2f4d1d7cb..aabec598f79a 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1113,10 +1113,9 @@ static inline int parse_perf_domain(int cpu, const char *list_name,
 				    const char *cell_name,
 				    struct of_phandle_args *args)
 {
-	struct device_node *cpu_np;
 	int ret;
 
-	cpu_np = of_cpu_device_node_get(cpu);
+	struct device_node *cpu_np __free(device_node) = of_cpu_device_node_get(cpu);
 	if (!cpu_np)
 		return -ENODEV;
 
@@ -1124,9 +1123,6 @@ static inline int parse_perf_domain(int cpu, const char *list_name,
 					 args);
 	if (ret < 0)
 		return ret;
-
-	of_node_put(cpu_np);
-
 	return 0;
 }
 
-- 
2.46.0


