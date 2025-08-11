Return-Path: <linux-pm+bounces-32121-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13173B1FFB9
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 09:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD143B7F33
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 07:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3B02D949A;
	Mon, 11 Aug 2025 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8ZpoHVe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A362D8DC3
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895601; cv=none; b=qCAJchdN97iTgF/Sa+fA6kWAxV2iX5rgQQx2XOSUznM5JHii7cR9zYOEFTr/F/fmtPqBCgVJq7yRHAg9Z9FpJ0YvnrE+GoX7MOpXCM/ZBsXsGMHRoUKuu794Ot96sowCVcQL5vvgRUsoKVsSkCl9zT8C0U9D9EmA9vwNfNDgvc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895601; c=relaxed/simple;
	bh=3yZG1w4E8aqqoqQW5zLOvh3uvnyaBxVEiamqN5NZMSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9OI+a54JOCtq+RelY7NRSaVa1X5Z1XHOtyxKLZGb7wNsNtYDASnTVtO1M2KrOwCvoddGjiLsT/jQ8lT+hjvloGYhWmn9GkUoBMyvJ0nU0fyj7ccj+gWshjytcX82DRcuRJ/PNw3f8cnYDhuGU5dhXop4gHd1n6tOuA//FsUDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c8ZpoHVe; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af94e75445dso717022666b.0
        for <linux-pm@vger.kernel.org>; Sun, 10 Aug 2025 23:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895598; x=1755500398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSWS63dgKn7kFeQEdpGLXWVaoXQGy0K+bkkJl1msO+c=;
        b=c8ZpoHVe6+yDJLWGzQcJ0DcVril5cFSaGzxOOqRtxVyzGgBlKi1b8H3sJMCJbKCs7A
         yVtGrc9ZuSns0CB6tjemLv0PUoy74g5RAR5gLgEKvK5yZjv5QpbL1X5MzHjnfDV482ez
         0K3L+RlZRsTb4gZxbSInOf5CsCND3vSZg1flTdlOp6j2djw42ZBfLkHi7O0ufIQnT085
         XIj+1aADYKySmCMI7rN0vc7CZOYdVVy3e2McTSCPvpIB98V4zC8wNoGeaCtvJsJAnVWq
         seC5nHaMkvrcbEXjoOgndTSOOUN2gS6mEAVRu6tdDGWhFmzxwV12K+b6G+xeHAR18W8l
         SgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895598; x=1755500398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSWS63dgKn7kFeQEdpGLXWVaoXQGy0K+bkkJl1msO+c=;
        b=vnWtDgSLyES5QhnHC8K0Lem5NYw7ET9Em6xc5K+an/WaqVoi8Bt5IpG3XJfRPj5d5P
         RlVEkP/SnXLKNJgzvH4oyJ1c/zbnNQ03w203B+vcA2+LiJDA0ZOsGORwDlpBhQ3Z5fa3
         uaGQUC2rNx2n9LFQqFXRjcy5eudHuKkasqOpW6ls7qa5qMVQrxcRH8g3yVxjp6cV/Gea
         up3rClH210LYJtMU+TC6da9IuyH/W2jdNyFn8+rTx18ADj3IOwUyhLWslC7U62e89lc8
         m1EAiImfYQib+ax1dNEgUT26flTDDeHlX7nuzou8qbKngsBtrvZodMm+vaNsnoYy+Uqz
         ISkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXELLMhN0ZZxdCj0s6qgFnRRA7BvbL+hVA9tLFh3C5cHbDDQtrqAqjNzB+aaysXHFkruDO8LHdV/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwywiHiVvOvUdXiIVsoUXMKntMCRoHEp0WYs13ga3nQI/ux++E6
	Svr4xZNJDHSO+JSBG5l6W04IgBeQmiOhH4kRMmF5gtyYuU2jHJoi6L3CIsv2iEYYmL8=
X-Gm-Gg: ASbGnctJiMImTB+b0ptXkVEsMR7jgfpcQ/1MF4RbecYFvgHqom6GC8JRgBLPddn4bvn
	Bm9/oqZNtxIAaKYlZHLTbH8iEQF1IA05z6voqc2VqnMBzWLkmmZa0+YViKxiKMovecO8pVD1XGy
	r6uarYHnlkBvou6Xv7LD5Su/bo3uDJJDsXiCwgAUcPOnX5SKGnCWPCryWDZCBtVwDpCPaLyvYwW
	s7HGDWS0hqkY97guvnilaJ0N49zElrF3tGnh5lpEBXsqtgwv0QSs/7vK1D0OxWU5zVbYCL+yIwY
	0+WRnwWAO2mhlMPsRbV3czEh18Z+aG5xpx4sirw6vNQPjBKQhAjE0+Qv6AC4YVb8J5zR8Oj1EbU
	mz39WiY1rvjtgFnQuDSl7ECLITGcFCTg=
X-Google-Smtp-Source: AGHT+IFA5uwA/OJXYyO9fAVmjzSH1NeaCu1TKHlEdpmXOJBGeW8JH3l9EsOujXZG+RsuHLVxaosWXA==
X-Received: by 2002:a17:906:eecd:b0:ae6:f564:18b5 with SMTP id a640c23a62f3a-af9c64525famr1132639966b.19.1754895598260;
        Sun, 10 Aug 2025 23:59:58 -0700 (PDT)
Received: from eugen-station.. ([82.79.215.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af99604e648sm971793266b.6.2025.08.10.23.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:59:57 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 2/6] tools/lib/thermal: Fix dependency to host libnl
Date: Mon, 11 Aug 2025 09:59:11 +0300
Message-ID: <20250811065915.3333142-3-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811065915.3333142-1-eugen.hristev@linaro.org>
References: <20250811065915.3333142-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The include path should be created according to host pkg-config
especially when building with a different sysroot or cross compiling.
Thus, call the pkg-config to obtain the correct path instead of
accessing directly from root host file system, which is incorrect.

Fixes: 47c4b0de080a ("tools/lib/thermal: Add a thermal library")
Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 tools/lib/thermal/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/lib/thermal/Makefile b/tools/lib/thermal/Makefile
index a1f5e388644d..ea56b55c9fcb 100644
--- a/tools/lib/thermal/Makefile
+++ b/tools/lib/thermal/Makefile
@@ -47,7 +47,6 @@ else
 endif
 
 INCLUDES = \
--I/usr/include/libnl3 \
 -I$(srctree)/tools/lib/thermal/include \
 -I$(srctree)/tools/lib/ \
 -I$(srctree)/tools/include \
@@ -55,6 +54,12 @@ INCLUDES = \
 -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi \
 -I$(srctree)/tools/include/uapi
 
+VAR_INCLUDES = $(shell pkg-config --cflags libnl-3.0 libnl-genl-3.0 2>/dev/null)
+ifeq ($(VAR_INCLUDES),)
+VAR_INCLUDES = -I/usr/include/libnl3
+endif
+override CFLAGS += $(VAR_INCLUDES)
+
 # Append required CFLAGS
 override CFLAGS += $(EXTRA_WARNINGS)
 override CFLAGS += -Werror -Wall
-- 
2.43.0


