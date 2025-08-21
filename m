Return-Path: <linux-pm+bounces-32784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F36B2F1A7
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 10:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999F4188A612
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 08:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A42C286426;
	Thu, 21 Aug 2025 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/lNz6/m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1498713A265;
	Thu, 21 Aug 2025 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764412; cv=none; b=tkHIICkJ4aKKSic9zSN4h7mbBQyHL905eiYrkv+RxMfrdDvJFOvExA2sYprPeuikDvW5FC1gr1Y6UdsJNBH6dcTsKnfrvex4xYHRc2D0WQ8WWq1dqQuVVDDwye9OhzgwBO4n6i4sEUMj2woZy1+IFhku6r+xHBzkl+DVRn/b89o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764412; c=relaxed/simple;
	bh=6MENWqVkYHicMICVfnmxJMVEP/jU0tYMGNb6mI3yHBI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VasRojN2wuwIXNDCTCTK050G+59tlqvcbGW0J0VaauV0F4HdnWQwFzX+KKSTNdL7Ba4kB9KU+AxSZKdssEJHsqDAMcyodzH/BgryZbvxm6trRw4XxLVZX/Z0eusVp5czIm36Kih0mOS2RiyFGl5TTf1/lw0uwyKaJbSkTXl2Nvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/lNz6/m; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24456f3f669so8059455ad.1;
        Thu, 21 Aug 2025 01:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755764410; x=1756369210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VVdyfb1owiUrSj5mrUpAZzb1V0r+oMDnI+RfgrzmLmQ=;
        b=d/lNz6/m1wwJd4skJUB3o4OqZh0AR4SLQLxqoFMQcu9Gj8Hd94Px2052VihilFAJ0G
         chBQbajl++t/kkr1SxR0QrNdG+NnU6YJ1OGr/X1t0d+YHnfQLEPd4iU3ikbcv9f3IcoF
         UTCp+fLbME8yt9PRGXnpwYu7POJTPtTBj6AIFt2X4gEjBwpt3Bk6yN2BrT1bNDatgb7m
         CMYNQXnuej9aBNvbZ7yq/dwbslzxv7H4gZVlg7yWxaGNd7EY4r+x7WQfotF9g5otAJNN
         FC/wnj17zQL1iInIq0XfsfbOYDM7ohtHKDfUXicaa6Hi7KvvV75HS44b5m6jXrzR64hp
         QHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764410; x=1756369210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVdyfb1owiUrSj5mrUpAZzb1V0r+oMDnI+RfgrzmLmQ=;
        b=ngAPj837g7xUnOt6gwr4msfzdXzJtDeu1VCoquQL2tVbUl+r+zlCoRB9hE3733cpV+
         UcXrrqiAyMUKs0gRYdzsVJOtZiWi9jUc+lJYUsEW1g1I808HjYzGkAKYi7zTCPTidWQt
         aviEI8j7SDUqnkpe7siEqd4i3emOo869fYxtgAfZNJSCqlhS7YT+wQGOi/i4bqUiVnJ8
         45Cx64ayMJklF28JfhpCteO7lnLPjMZNfawz4XmSIlJIeMz/EJj3GJ/FBy8Kss7vylaH
         rdy3D+RbqhE8bvfhviJySRYyxNtH0XQJy5HxKA9uhBLXJyzHaTq6EfH+wLY80HUSchPl
         MZmg==
X-Forwarded-Encrypted: i=1; AJvYcCX/antHdlfTBQzor0uQ/ScE5RKCJcTg5H3Ef+gt2gIfdf2AQsUdhLxBgks23LwzO6i3VJ9Dj1UM9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4u+qr4XGnY4CEIFmPVy3/GD1OhRGZIKVnGa8HgfeIwZdehIMC
	eXunfWi8mRoFuILaHw4pE8ZnuBWV8R2mdS6Dt4KCNAgglCXY+/zn9oM+
X-Gm-Gg: ASbGncug82OVbyVKHy6BUDu88lQOMhrCyOwx90nLmV9uu50nS5aOo9CEWrPDFWU18/D
	9KqjPTqEQ1jMW/BCal1gXMGV5hOrSQw1Tnon/VnHeJ+2o2WANp/I4cnVRhvQz18JlmAtGQotSUU
	Af6MQxgDaYYv8zlH/cmzf0Q+ySGmD7U9PAdKUL0ZsU4s0+R2QSTt/EId4yhUsjpMyw/1u4CEQlX
	0Z/q7DtOoslc+PXe2L6SxQpzVXyIz2vR7C93IWt9XttBX4LIvCaTQwz6l8IQEGlkOpnpANaQ+6K
	AxXUuIXkhGMjTCkCMqdmw2Du0Km7W7AzNirabkf8IMSLIL/qG80n1M+rN4wWfxcSdml6A+TGn5m
	vaTLGzKWcZDIPxvyopO1YiiuoTZib39FkCZIBvtQ8VaU2+oQFW8sGKY4=
X-Google-Smtp-Source: AGHT+IGKdPlIQ1dw7VT4HwkMn1t5FdLrHQzSs3zBpSEXsX9SbKEry0EQVRbHiJ09vLI6a1TtMRq0Pw==
X-Received: by 2002:a17:903:2448:b0:234:325:500b with SMTP id d9443c01a7336-246062d1978mr17963555ad.22.1755764410137;
        Thu, 21 Aug 2025 01:20:10 -0700 (PDT)
Received: from ti-am64x-sdk.. ([14.98.178.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed377de7sm48259875ad.62.2025.08.21.01.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:20:09 -0700 (PDT)
From: bhanuseshukumar <bhanuseshukumar@gmail.com>
To: skhan@linuxfoundation.org,
	bhanuseshukumar@gmail.com,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] docs:Fixed typo. Specifically enabeld is changed to enabled
Date: Thu, 21 Aug 2025 13:50:01 +0530
Message-Id: <20250821082001.6082-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: bhanuseshukumar <bhanuseshukumar@gmail.com>
---
 drivers/devfreq/devfreq-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 70219099c604..020fe30ed5d9 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -100,7 +100,7 @@ EXPORT_SYMBOL_GPL(devfreq_event_disable_edev);
  * @edev	: the devfreq-event device
  *
  * Note that this function check whether devfreq-event dev is enabled or not.
- * If return true, the devfreq-event dev is enabeld. If return false, the
+ * If return true, the devfreq-event dev is enabled. If return false, the
  * devfreq-event dev is disabled.
  */
 bool devfreq_event_is_enabled(struct devfreq_event_dev *edev)
-- 
2.34.1


