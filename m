Return-Path: <linux-pm+bounces-32122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C39EB1FFBC
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 09:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6473B82CE
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 07:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C292D94B1;
	Mon, 11 Aug 2025 07:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hPuAdGfw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA942D8DDF
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 07:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895602; cv=none; b=ODwOkl9+mw6YJjb3Tz+owrm+9+8Hz4IiBH9aSVUL2X55OaiD+ZmBOhnHWW/ttRxRM+5arDjULjcJ3Cau8WzbD4OXkkv8GGP9gkncydOyJr4LUzYHwPdIcQXSPP+zQ4A2iFy8nGfXieIdsiucmkROBPh5fW2XOr1W6mYoWukkDCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895602; c=relaxed/simple;
	bh=KvFKeOUgAv5xTieNT78OQsqgL/nxGh1DVLUIu8ihqrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z32YkX76w3fVt9cpMVWULSbEwYVmWQ1kHNFWG/LIQiVkK5D4oF9bEaXYQWBkOSZuKB392wGItgtEyP8pvNuyBPUERxSP+2+OOdwtBpcFeG65EDGvpbI1U7VZyrAfdt+fAQL0qrVH6bOZnsNuIJvK4sAgxPTiGbiClRux/dL887I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hPuAdGfw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-af968aa2de4so741067166b.1
        for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 00:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895599; x=1755500399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yH1Zfwk4M7pUV4TKZjHnni/k3y7gfw5Y8QnaMyZmAI=;
        b=hPuAdGfw+qYOJnHPWV8xhrt8fF0V5ZrUirrtIoFNsUm+Q1PtU5dB9gF+LjjT9RoSCJ
         d2NP+1d8iKuKPi5m4hqCXftggn/D+qChsNG3pSxiUn6B694Xw1mOCnJjJt5rrRTNjlLa
         S6nO6Doouh8VZUjVEjnDW0ZuVBtHIybzHl0mjX4hNS1qbS7+jKF3cJBOMaOGeRldlBze
         tt+bdQDoxn8qCMdT7kLcXSVkAShBCwGC92VkW9zVdLdI6nOgdX/jzEvhOavaFrFm6M1Q
         CN4ig8XlELuy1ElSXITe2Yx/t88gO7oLhkR3+DzcqiA/XyEn+FUOSucHRw3kb5uxzEhi
         xzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895599; x=1755500399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yH1Zfwk4M7pUV4TKZjHnni/k3y7gfw5Y8QnaMyZmAI=;
        b=EsrTQsOQavmrdYjEofMViaMwFk5kb4lYcWxTolHnx5ljn6J6p9dX0Sv1lOg1miHSxo
         FsEffpm5r+6OfjIHk54GoitK1FwpL1/1TT1bUhbO+tVN9tZEqPXbgpNvOI03H2HYcsus
         cXp/nH5iXPveLMMKFI0ABCv4xBoCob6uRz34f9wkI7Z+/uO0uEYS3KhAO9sNHovVkIAe
         Tba6XZrP2azz2fIRXC6JZ6zYrhhRpVotVdvFOGKC3DTkik3UwK2qm0zq3Ooj/f1LlPab
         qW68k3gzn3KYgPjgwG8UqHBNgzuhizQeDE02voQJH8Ff8MoHCN4XdMb8zWL/NYbpEJfw
         Yl6g==
X-Forwarded-Encrypted: i=1; AJvYcCW4o4Hds17PYgQKbPPVa/uW/gs9BR4PUPx0a/q5q2XtR35GveuXiW5n9DCoJ+NvYNRIBduFHSZW1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhbTWirvdQL0Jwbr8kXKBblQVUHCLRR33RM6pnqelFHwpYdEHS
	fXE6h5lj5w3W+Kwc05QrMhpQXJjlCXkNqPIeuwTsWUVGaazpUeGpYOPCWb4h8Ga0pB8=
X-Gm-Gg: ASbGncvvR68dGb2vh1x/6m+0puXbznpUQXKxc2VJj7+BspaUBhpFN8wcpBnSshPkVAI
	HTlFrb4BsFZ43hNte7Cwp7ljaf6sa+GO+lT2vGRo+3ikLGdY3gWX6biv1wGcUcW6mqQbIOLBqdV
	+oT6MX9r7AzUWACt23Uy3zBI1qSqOyWuBB6T38Jw/hBfNaAw30o+IrTHaVg01OGm4mutncBrk+N
	6AifbpmTZ6yRUfbKDjuK9FMq2D49BfnPJvlsVEx/h9EC/IkvWBTzhGHOBw/L0DnfBdKHILY1UuN
	2kg2YmQ072hJNm6kIkv7vnG+pIDn7LDlJnK6cu2ETSsL3xLNh4Wz69oAru9Oku/XWOCAGKo2bL9
	VMdxtTV+Wqn2c3dhuc2nDND+jLHFIWGI=
X-Google-Smtp-Source: AGHT+IGN+cgo4XlhoYRFNuK+84w1+noJNCVLJZxTCxe+T8UmaEJsfGzVSe/O7t9sBEWtkuxLD8SWPA==
X-Received: by 2002:a17:907:3d55:b0:af9:613b:3055 with SMTP id a640c23a62f3a-af9c63b0941mr994855766b.2.1754895599094;
        Sun, 10 Aug 2025 23:59:59 -0700 (PDT)
Received: from eugen-station.. ([82.79.215.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af99604e648sm971793266b.6.2025.08.10.23.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:59:58 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 3/6] tools/thermal/lib: Fix header file installation
Date: Mon, 11 Aug 2025 09:59:12 +0300
Message-ID: <20250811065915.3333142-4-eugen.hristev@linaro.org>
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

The header file created by this lib is thermal-tools.h and not thermal.h
Fix it accordingly.

Fixes: 3b7c5e8adf9c ("tools/thermal: Add util library")
Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 tools/thermal/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/thermal/lib/Makefile b/tools/thermal/lib/Makefile
index 056d212f25cf..b8fded7f22b8 100644
--- a/tools/thermal/lib/Makefile
+++ b/tools/thermal/lib/Makefile
@@ -128,7 +128,7 @@ install_lib: libs
 
 install_headers:
 	$(call QUIET_INSTALL, headers) \
-		$(call do_install,include/thermal.h,$(prefix)/include/thermal,644); \
+		$(call do_install,thermal-tools.h,$(prefix)/include/thermal,644); \
 
 install_pkgconfig: $(LIBTHERMAL_TOOLS_PC)
 	$(call QUIET_INSTALL, $(LIBTHERMAL_TOOLS_PC)) \
-- 
2.43.0


