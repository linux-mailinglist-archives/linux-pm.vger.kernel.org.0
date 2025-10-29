Return-Path: <linux-pm+bounces-37032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A49BC1AE93
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 14:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467901A2222F
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 13:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE27523FC54;
	Wed, 29 Oct 2025 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JB6FDNwu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045AE19992C
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744816; cv=none; b=nD6gxsuYsE9CPXd/vyOYuW2xg589ZUPpafpZTY9f0L++owavBFEKzYHYzmzYaX6UvxzouhFAIkn5Oe92bAUGU0ISbv2bq0s3gBA9doLQwQnEbYML6Vv7DU17hqvdEiki+XKebWH5vxHUUSujDq950E/m5EX3rnUvNJejvMvQlk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744816; c=relaxed/simple;
	bh=nsjttZq8PuEoDQMx1bwWfoY1j5ZCVlCBFQu8V8UWH+M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NGrmjVVjNBFutCqHkeoxc6p7Be4lCGYp+hZUSNcILyf0Yr/LfZrycIYm+hgWoxXbczLgt8/jPeA5vEkw3Cyb16dEfHWckjcoEccZq/qOHNouJq1X5z6dcVPzc+AihnVIedMPLz8iRLH205v3abRmGQ2KtJetTGPiHrkpgAFWTBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JB6FDNwu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47114a40161so81861155e9.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 06:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761744813; x=1762349613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WF7nqrj2THb4vlhOESgpe7tcZwa84JrbSuJCtvoqqIc=;
        b=JB6FDNwuXCx0TpgMywH0OPZx9zz5uJmQipNj2JloxT2sHFCDAKvfxQP2fTm8wuk2jt
         0dlkrAHs9wEzYQ8dnjyGRAXigIfF0TBJW93o/tui4CcyouUlAokHH1Xr/1Ogs21cj+in
         QzX+ogujvTF330RfPosjmJ8TuRisFQcTrleBUXH3Zrh/uB4VTacrlHeVT1uX2l/TvSeC
         juuaQiP0z6c9nBFWLU6MrVnhzCY1Gk0K+J5V5Fcb49WZLbVvrSFhlNjuMFIRTpFmtzKx
         VsUEoQPJZTfPQLbWS+AEWT+lfuRVv2SuPti3iizrCvv8yVWNYw749MEFNO1/UBB1h8PX
         F0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761744813; x=1762349613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WF7nqrj2THb4vlhOESgpe7tcZwa84JrbSuJCtvoqqIc=;
        b=nWAZtGQieSrXzpEUdpRQUkzjafZWlsEVZaBpvG/th6ViDJ2qFfphIrFDbc0YHGCz4/
         d0jOu9nMVbP8Dh3FiH3ESHIUDTLD+33jTfVYGOj6Dx+okw4uQK8OuxbJXeqNfSvWvJYq
         chnonpVw0zL/ty4+snIdKC4rEZO7opSBBX5CRuHty17Z6mF+Tgv6SkImLwvavTAN5slZ
         PnghALmRGAosI4/xbFDcHaQJ+GMX6slIdtL8C6gVHHdsVSudX+4Z3X/Qh40qZy1/XSXx
         cV22xp2t6JyMkIN71Z1HmDQU8wP7W3on6jC2vrR9JCJwNV9y4s1SowZj66vB9hnEclrk
         hBiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCCoidNpEoVa/u/i/7ECcclsduSIRxo44NHeOodkhcLje8SoQgF+oogu3pDGgGcpyflHq1Gg7hrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc5I/2xCV/31cngOtD6CBv43rvCb8BKlY1e5fZBk+84PvS/HFa
	Wh0j+xHnHTbTL4b/0tlD0mQwLmJtFCboCcRvbmH+lwBxsqSSbXICeQ8A
X-Gm-Gg: ASbGnctJlShOfOGLkTlqHc6r6k/nXWFs+Xjppn8kltlRCMkgO2drrzHik7tmp+TVKC3
	AGugEzjo4qUQlp4zGNyQRl1VC/Dk5CJzcPdqS6UxPA9WnWf7Hu7dI3wThZJCsQmYYjHZsA8b7GD
	eq6Vk/5bD1JY/Wtt+CpCJKrxSWIYkHNMsbPMh4JnaW9BFNuSvFjTBpLUQUIAn6mdwZ50YUWp0RT
	FzpR1SPzX0B0NZzdGVs7Kcuh/pUJ6ydPjXJrkJpv6c6SXj8qloXwJ0CTdzEBjKWZmTwg1ItWqA+
	Kf7S82iWm5hahgoX0wrliz9tj5cGKdNjsiYP0gB/l6EvGDp5NiNveSYZpgUKbsPT44JgTlQjLYe
	fFK/je1jVvAKWj6gAom1mMMwaO3sh6/drVxcsEu3drxpxc3BY8Az0TASjlHmFhLjh9P+F3aqxQU
	SAn9ceT+T3uBftE8SK5YVYzd/Ye0uKwQ==
X-Google-Smtp-Source: AGHT+IH1wnB+c+Tv3QvNjludDqom86fj/5j7GLlptXYKIF9eMEqcj/69GJzxgHdIDmKX/xBciiwWGw==
X-Received: by 2002:a05:600c:37cd:b0:46e:1fb9:5497 with SMTP id 5b1f17b1804b1-4771e360859mr25948655e9.18.1761744813034;
        Wed, 29 Oct 2025 06:33:33 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4771e387a14sm47955195e9.3.2025.10.29.06.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:33:32 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] err.h: add ERR_PTR_CONST macro
Date: Wed, 29 Oct 2025 14:33:19 +0100
Message-ID: <20251029133323.24565-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ERR_PTR_CONST macro to initialize global variables with error
pointers. This might be useful for specific case where there is a global
variables initialized to an error condition and then later set to the
real handle once probe finish/completes.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/err.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/err.h b/include/linux/err.h
index 1d60aa86db53..a38071881b20 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -41,6 +41,14 @@ static inline void * __must_check ERR_PTR(long error)
 	return (void *) error;
 }
 
+/**
+ * ERR_PTR_CONST - define a const error pointer.
+ * @error: A negative error code.
+ *
+ * Like ERR_PTR(), but usable to initialize global variables.
+ */
+#define ERR_PTR_CONST(error) ((void *)(error))
+
 /* Return the pointer in the percpu address space. */
 #define ERR_PTR_PCPU(error) ((void __percpu *)(unsigned long)ERR_PTR(error))
 
-- 
2.51.0


