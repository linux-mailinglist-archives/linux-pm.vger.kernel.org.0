Return-Path: <linux-pm+bounces-39420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A041CB3BB9
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 19:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F00030146C4
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 18:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DC6329371;
	Wed, 10 Dec 2025 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsnAg4lU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCDF32825D
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765390479; cv=none; b=RTXfCP1JsKp/cn2/Xqo2VB6O/cuYnHljBX9VKp48ARzZHA41KPD70uDvIVcr26poHgaiTOpZ9QRjT1H80ws5AnMfy2W4tc+6eEs+7C90BaCA6MQO8PVnhUZwfF+49T1aPXhrNfwzsPJhv9NXf/MCBL9XvTr/TfYdWDPFcANKHS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765390479; c=relaxed/simple;
	bh=Amd++Koo5bPKR+N1bmWGrI9IzneDbf8uOB8ovB1BuiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cm6TQ/YcZAJRbUWSqYHr/vRpyJGJKpqmkHpHj2h2srpleJv4mLmetfY3dNZ0HuTL3FXVzwDXo75PTC8r10Dd/H5BpOzuq6uivQJkPkhGlhCfdOczwdyBO+DvdcyFMx5yJ+/nMQzV5PKJTnFe5KASS6WuQ8hTLikAX52r7djeUMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsnAg4lU; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b80fed1505so68318b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 10:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765390477; x=1765995277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b4asczVmrSc7kELcmUUyoAil7HLLpZxuBhnq4yVg+yE=;
        b=QsnAg4lUl7o8NJNGLIxeaduLWiAh8hqoDiFcu6u3Yq3ymc1pphiQXLaEvXdfe72/OM
         CrJ8te3yBCNAJll6UfR7VXt56vTcEtJfPenJBhvyCjnG8MQfZxohBvS67/AJu6i+kPCw
         T8sndjccvf1yH+pJ7VixPX9OThBtIaRqTcSnk0huGi85RHHNSqZjWNGy+N5ZygS0x53u
         ENXCMK4BFH5UEg7w8w5SlcRI788S1eLuztQqY1sHq05x171gPtrA9mIcbyeIKXrrlBNt
         gUMQzrHhl9P4sqiIxAW4p/NLdv2f4aI7Th+ZY8yd33qoTvdEGwEJsQysJogqcKD+cj/x
         sY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765390477; x=1765995277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4asczVmrSc7kELcmUUyoAil7HLLpZxuBhnq4yVg+yE=;
        b=Up/BAN5bpDcJgOxWpnp9JdN2rhSZTX/bozAM634s2fJx3q0BHUOZaXt8gts4uKW+YC
         HV1SoKHBPXcYQ+LPKG4D1oIv5GePMDtVVOHMCJC2cqb9ez7rmgUetkHxXZwZrFrD4/Ts
         0BltWV9jNJ0Sr9kZUWgyHyIVym7htqVuV4tblv1N3FCmUHoogbd3kHTuxMT4KR4Y5MOL
         LkJcjw0PFe+XZ0qCGvBa3qV3dHhP0vmMX36kUbmUxPakyJpcxzToxjOQ9IrzKthwWG6/
         xritb3YSuTHBEhFrtVdLYsZsdP8bXQwbq1PSocv6hMFJy6LLTFXa1SEatNoBqnQWyH+3
         qKpw==
X-Forwarded-Encrypted: i=1; AJvYcCXPMxjl+pXzYQHLP/GlTpZHleOpOy8fz/5SfD25rrnlFW2iW3mq3rjyuMlOMBmtdcMAqq+wOTvAXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7936DO8FYR7foCHKcaQ+3dIDYNYU1wPmg64vv1ICGy2qRWxD8
	QDW0CD16sN3wWYSItx+klVsuJEcPKq/c5EtMn3RrJTBW5VVaZUSGwbKs
X-Gm-Gg: AY/fxX75COR8rQ5Vvd+3zHNarTP6gLaIlN1AZfVyK63/UvpkP0xlL86D/BMzrS/j6lo
	bWGU4f7nzpUe7qKDTjyaqUusgwgIW1EhpSDMtax/z27oBZoK0c7gk58avEZc3TqIx0eCdR+X63k
	pvSckJJHlVe+dum5ohdT7AzM8RdBre3+erDIEkCcEG+EB9RsdJYdPFP0jif9+mABZ78AZFOjZih
	SsBuvOeuBY+Z4+7KFtO+RzTDSIjxa3hbcsRMMaoxe0BbQigH+xHnKI5X6l92yFuA+8iTPquha+i
	VarXMQ8a1BYFt42XmgB8cMmNYVmBZqWIj1lAuYDTaP+kOxOecADRZdE8eexuyDFARnHacNSLjy9
	RcIUJQgi4f7731qhVsizvXivglbdiz6jAYQqCIxs1cB1e6fTKRgk+KLmxcWcXGbmR6xCTmlFu1p
	QvvweOOYIZYm3VCxsbx0rvt+4MF3oNmbjXVkUK0su7PJUa+nocoNoTjEjzJUwi0IzsX8qRCFLv6
	QhHYxeyxLN1C8uuovuQDI83
X-Google-Smtp-Source: AGHT+IFR0g7Nx23YxKksLKns10MYHwD3joXjybG0p5G28And9qrkEa3hT0RmJfpGtAJ8eiYXuYXWEw==
X-Received: by 2002:a05:6a00:23d5:b0:7e8:4398:b353 with SMTP id d2e1a72fcca58-7f22ee58c89mr3208078b3a.38.1765390477334;
        Wed, 10 Dec 2025 10:14:37 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (14.250.194.35.bc.googleusercontent.com. [35.194.250.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c4aa9b94sm187900b3a.37.2025.12.10.10.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 10:14:36 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: djakov@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	marscheng@google.com,
	wllee@google.com,
	aarontian@google.com,
	hsuanting@google.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] MAINTAINERS: Add interconnect-clk.h to interconnect API entry
Date: Wed, 10 Dec 2025 18:14:17 +0000
Message-ID: <20251210181418.2123323-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0ac2a08f42ce ("interconnect: add clk-based icc provider
support") introduced include/linux/interconnect-clk.h but missed adding
it to MAINTAINERS.

Since the corresponding implementation drivers/interconnect/icc-clk.c
is already covered by the drivers/interconnect/ directory entry, the
header file should be listed as well.

Fixes: 0ac2a08f42ce ("interconnect: add clk-based icc provider support")
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aff3e162180d..5ea19684dcae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13153,6 +13153,7 @@ F:	Documentation/devicetree/bindings/interconnect/
 F:	Documentation/driver-api/interconnect.rst
 F:	drivers/interconnect/
 F:	include/dt-bindings/interconnect/
+F:	include/linux/interconnect-clk.h
 F:	include/linux/interconnect-provider.h
 F:	include/linux/interconnect.h
 
-- 
2.52.0.223.gf5cc29aaa4-goog


