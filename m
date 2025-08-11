Return-Path: <linux-pm+bounces-32125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D36FB1FFC2
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 09:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189C43B82B1
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 07:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E530C2DA751;
	Mon, 11 Aug 2025 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QwKMp+JE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424792D9EC5
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895615; cv=none; b=eU8x/j36EabSrTjt/JprssxHY/IgEy0GL1ktEJxu5VE7Kgf3/nYhEVfRJ0+9K9D0/WmEOiou0d6r46qxWtP5PUWl54GlDqy//A6lBUZZxeg8D1ltGvXxqxasxVNyNSATmx2I889uGJhhUIWGxHclJk4Wh9YEYf+3QlVItMETSHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895615; c=relaxed/simple;
	bh=5OKV3YFVx9AV+VrVYyDRsVXxPu+Il1+rJhjHmNszp7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBSQNbF6MXySAz9iT8dd0+A4ZRv/X/9ed3qSdJaG8mQSc2j8cBfHMV9law8+3OqqYhZH7NFo8Q/ME6Pl0d0R5kCnKulwaQ+QcFYNrMdf378hNSZEQLbfoZlweK1rhgAZTnKWQwy628ilaCply23jiXOxv0YAQ02aLxSrae7ac98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QwKMp+JE; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so761485066b.3
        for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 00:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895602; x=1755500402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6cSDcWJHXC805rmzke8t+NltGzFkInjNHEHN1KN3O4=;
        b=QwKMp+JEC/rzLrqw7jqG2U0M2vWR/9rlbJ4JPpfMO0OHcbhB0YtqpPuPJjcTDSpuIQ
         v0SD3llARKuP6NCkF4yRV+qQbkMUYgdw/9AAEPBC2DMKqdD6Pms9Eq132AVL9MvUIYCO
         XYRv1E8HtD75Q5qz3w1UKk0qCh1VPaENSHfz2KrpaGaSnAxtnpZQEk/HHsw7pStvJLat
         /WcLTWvilb1VOrGNrXUsYFzrot1e3Dx5khXoQnD6H/Nq6uRExczhVJFcnj8y9WpKiMPf
         uyIxhDC9wfLhDjlcbV5KDhmQd2Qi3vaGIgeusqf/m1GYzc+Ve+Cjy/Ao1rQAvRMohJcO
         xlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895602; x=1755500402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6cSDcWJHXC805rmzke8t+NltGzFkInjNHEHN1KN3O4=;
        b=rji0qYfdRw10zfrthEoQt2BXZWaY4ObmjylUhRYwG5UBs0u/J7bZpgOjC9kII5KW3W
         Fz6Vkmcija86X2XxS4PVhJeaZmDicnmfCD9rRWj1HkEwzOUWHr/NzeE5e+U4dh/oYEdQ
         ZfrsbPu2fYrMwFUoCGDLfOc+miPBRlUe6rPqznK5BbyVVC7vuyOCor9GRG4VDKa7EggG
         Fgc8WfzMjpkzNNzcJXccOIVsyLPvCPVK/m/oElesO1xvJOeyR57V1go1ZTxkW8EMHSL+
         M9bAdLkKBzcn1E9Y/iHW1kzQoq6cZGLNyzHUw7n5Mvc5FxGlwSnEeKXXi8S/Rm91r6LB
         FsJw==
X-Forwarded-Encrypted: i=1; AJvYcCV3/NYG1i/xLGa7ZqsC/48D/44Kr8fj2WY5QhlnWFBiYmhzIrh5co7KjowvrqmUMCedeBVdE84S4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDxYFtx/acXXa3xgiZiuvmJJHOLJc4rECYk1TidCfsUgz7s57A
	STQWJo0tVShGKUqB/PplO+NXBqLnReCjTMQY5x0vGGc4LNQW3ViEMM+Ww8lcypuVHi4=
X-Gm-Gg: ASbGncvAOrYlbcKjd2Px14PHJIEzVWT7dGPiPCkL//zGtjub+Dtr7yBHrQwTVmy022F
	OYrdiN+Gl3b8uqTjd3tfoX/TkaGIXztdaoKS2B4hQwjpGpsRIiIhY7Q7lTCmBXBoOYKsFe2qCwy
	tvdK8ErO6n72J0CmZcDVk2vVlSgK0rEfwm+KX5+Ja4zVFnplG4CLWpOgDkv2EzowMsvjrPCJDdd
	21aAiXMn8b8mpggW+dJ6a0mm2ub57BRD7BCDeDWH6q4gU3p4WoA0AAr4QxE5eZLk5cebsm4WBu3
	SQuGiB7T6VMf5wuXi3iDJdJ54HA5pG4ZB8/tg0NnaWu1HmgPrY9CYIoZRIIeXQelYF/X5XF5Xqz
	N81N4SH2GpPDOaBuTw02RNMmgRLTjc1h96VCGXbRqXg==
X-Google-Smtp-Source: AGHT+IFRZfmnNAudk0i8fMFKOOnhnp75F3E/Nb1oPrto+I24ExyKtbRZtnEWr0MjZ5tCu9kYF/fTWw==
X-Received: by 2002:a17:907:d23:b0:ae3:635c:53c1 with SMTP id a640c23a62f3a-af9c6518c68mr1144071966b.54.1754895602457;
        Mon, 11 Aug 2025 00:00:02 -0700 (PDT)
Received: from eugen-station.. ([82.79.215.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af99604e648sm971793266b.6.2025.08.11.00.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:00:01 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 6/6] tools/thermal/thermal-engine: Add cross compile support
Date: Mon, 11 Aug 2025 09:59:15 +0300
Message-ID: <20250811065915.3333142-7-eugen.hristev@linaro.org>
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

Adapt the Makefile for cross compilation.
Took tmon as reference, and adapted the Makefile for thermal-engine.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 tools/thermal/thermal-engine/Makefile | 60 ++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 15 deletions(-)

diff --git a/tools/thermal/thermal-engine/Makefile b/tools/thermal/thermal-engine/Makefile
index 6bd05ff89485..539c643804fb 100644
--- a/tools/thermal/thermal-engine/Makefile
+++ b/tools/thermal/thermal-engine/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-# Makefile for thermal tools
+# Makefile for thermal engine
+include ../../build/Build.include
+
+VERSION = 0.0.1
 
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
@@ -8,21 +11,48 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 # $(info Determined 'srctree' to be $(srctree))
 endif
 
-CFLAGS = -Wall -Wextra
-CFLAGS += -I$(srctree)/tools/thermal/lib
-CFLAGS += -I$(srctree)/tools/lib/thermal/include
+BINDIR=usr/bin
+WARNFLAGS=-Wall -Wshadow -W -Wformat -Wimplicit-function-declaration -Wimplicit-int
+override CFLAGS+= $(call cc-option,-O3,-O1) ${WARNFLAGS}
+# Add "-fstack-protector" only if toolchain supports it.
+override CFLAGS+= $(call cc-option,-fstack-protector-strong)
+CC?= $(CROSS_COMPILE)gcc
+PKG_CONFIG?= $(CROSS_COMPILE)pkg-config
 
-LDFLAGS = -L$(srctree)/tools/thermal/lib
-LDFLAGS += -L$(srctree)/tools/lib/thermal
-LDFLAGS += -lthermal_tools
-LDFLAGS += -lthermal
-LDFLAGS += -lconfig
-LDFLAGS += -lnl-genl-3 -lnl-3
+override CFLAGS+=-D VERSION=\"$(VERSION)\"
+TARGET=thermal-engine
 
-VERSION = 0.0.1
+override CFLAGS += -I$(srctree)/tools/thermal/lib
+override CFLAGS += -I$(srctree)/tools/lib/thermal/include
+
+override LDFLAGS += -L$(srctree)/tools/thermal/lib
+override LDFLAGS += -L$(srctree)/tools/lib/thermal
+
+INSTALL_PROGRAM=install -m 755 -p
+DEL_FILE=rm -f
+
+# Static builds might require -ltinfo, for instance
+ifneq ($(findstring -static, $(LDFLAGS)),)
+STATIC := --static
+endif
+
+THERMAL_ENGINE_LIBS=-lconfig -lnl-genl-3 -lnl-3 -lthermal -lthermal_tools
+
+OBJS = thermal-engine.o
+
+thermal-engine: $(OBJS) Makefile
+	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS)  -o $(TARGET) $(THERMAL_ENGINE_LIBS)
+
+install:
+	- $(INSTALL_PROGRAM) -D "$(TARGET)" "$(INSTALL_ROOT)/$(BINDIR)/$(TARGET)"
+
+uninstall:
+	$(DEL_FILE) "$(INSTALL_ROOT)/$(BINDIR)/$(TARGET)"
 
-all: thermal-engine
-%: %.c
-	$(CC) $(CFLAGS) -D VERSION=\"$(VERSION)\" -o $@ $^ $(LDFLAGS)
 clean:
-	$(RM) thermal-engine
+	rm -f $(TARGET) $(OBJS)
+
+dist:
+	git tag v$(VERSION)
+	git archive --format=tar --prefix="$(TARGET)-$(VERSION)/" v$(VERSION) | \
+		gzip > $(TARGET)-$(VERSION).tar.gz
-- 
2.43.0


