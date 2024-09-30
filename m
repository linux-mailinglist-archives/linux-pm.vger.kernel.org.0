Return-Path: <linux-pm+bounces-14981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A96A98B0C5
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 01:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD1C1F227DF
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 23:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7799618952B;
	Mon, 30 Sep 2024 23:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nc14ZOv5"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76DA188A3B
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738551; cv=none; b=MA6fcpMAkVdWTkh5fx0qpAv0ikdAZCRq6x9idXLjgHAt7MS2t+LdIGrSM7LfQDDAykuNG1fzqqzspzkRAShutkE4xsxS8gGEJ1E0ZLP3JsG6RwDUgPvBMXXOMkJCdPkUXHGvfkvX66M1TXHjNLxOIXVHOWVi/FBOBocy9NTsQ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738551; c=relaxed/simple;
	bh=clfiWsrp4dGFaYI7d55/qc7iYZnYzDRDMc8mRva9740=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apyNCDerd5SH7gMRkCJbqmblOHkMkkWAidGtRQ0nAE0ViNaNfkbBwRkHJ0heZugDMrLuxXynCHkT/R8NYlAEvA1QGnsm06JGwtQYUQDFC52cZHbYU++ryAOYmnNSl9Go/wnDbGdiZB1J90wOtB3kD7xjE64TXfFmfpivdycNu4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nc14ZOv5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727738548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hpg+FWuxwhA58ZIorLNy68eTkaxxlrOGEB+b9Y3QOMc=;
	b=Nc14ZOv5g/5FykP0Gt0GMsqlhlijtppvHumEgstKNq9YPNzO2tPNdpaf/PRV8kMbH51MBB
	WeM9SC5HqOW04Sxf5j3f9050gGSrSrBemovmwOO3JS9ugSHjcLUhQUW8C6ND+rYbaAQbch
	ffKjKatNVCJh7Cnbl73Z04CR0DSADdQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-1sJJYgsQNhufS3AKcuKGDw-1; Mon, 30 Sep 2024 19:22:27 -0400
X-MC-Unique: 1sJJYgsQNhufS3AKcuKGDw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-20b4d8b489aso26742675ad.3
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 16:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727738546; x=1728343346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hpg+FWuxwhA58ZIorLNy68eTkaxxlrOGEB+b9Y3QOMc=;
        b=mTE7GgwdYat4s3WHP+mHPcUJPhSMAx+rBfH3jRMvLTCCmQJhqylS1PpKpT8O11PoUE
         Dvblc+v2W4D2gqhIuQ/bSQigcxW2QrYnzhgNFXAiOvqcdMNsvG9LbgihopXqorfF+A4o
         n0klVoRaypT58HbNg+0DdaF4b68srQkvyij7TDMF9pXx4w+DYDNG7NhTypx1X16mrYDj
         CcsS4W9x5XoFGCwCX7BMoSb7euKbJzxK9weQbClZeh6b1Xr5NGMsll6K/VA998ctZ5rP
         8cRgbA2rwOmxeGeYHPxx/M3iA9yxu+HSn67nyyCUHpOnwwi4CTtM8pgOc9bT2TL6ApSJ
         UMAA==
X-Forwarded-Encrypted: i=1; AJvYcCWBBEECO8fSG0jtTGjeJEpWxD415ifwGbkf0m0d0Y3oOMQSJHRNZgy6fs9+cfLqmBvXmqTsLfYdXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlRYDSyzghaWoueIVAotvuZidfCq/iy1dpmyNZe2a+v3KHFNm2
	EczNYhkPuPvVvMGBG3Fhu3FYmgY5ZoaYTIQd1NXpF9wl0gT5gErxHdd4pp2bqO1IOLKwJmcjp2H
	k7KFntaBYR0KTUpT8a3aYC+iW/ZSNOd696xNPOubjwBfo/v5BrPqq5tLw
X-Received: by 2002:a17:902:cecb:b0:206:ac11:f3fd with SMTP id d9443c01a7336-20b36ec9b08mr214932935ad.30.1727738546509;
        Mon, 30 Sep 2024 16:22:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnYVM3rVsKkpiUQxEbwOG3luHyMLmr1bdJqCCYCtJdpCXHQ7vbgtwthaQeN36rNE2/HI+hAw==
X-Received: by 2002:a17:902:cecb:b0:206:ac11:f3fd with SMTP id d9443c01a7336-20b36ec9b08mr214932605ad.30.1727738546155;
        Mon, 30 Sep 2024 16:22:26 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d685b9sm59241985ad.54.2024.09.30.16.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 16:22:25 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Renninger <trenn@suse.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH 2/2] pm: cpupower: bindings: Add test to confirm cpu state is disabled
Date: Mon, 30 Sep 2024 19:21:55 -0400
Message-ID: <20240930232158.29024-3-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930232158.29024-1-jwyatt@redhat.com>
References: <20240930232158.29024-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple test to confirm and print out the cpu state.

Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
---
 .../bindings/python/test_raw_pylibcpupower.py    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py b/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py
index bb2b26db8b10..ca5aa46c9b20 100755
--- a/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py
+++ b/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py
@@ -31,6 +31,22 @@ match cstate_disabled:
     case _:
         print(f"Not documented: {cstate_disabled}")
 
+"""
+Test cstate is disabled
+"""
+is_cstate_disabled = p.cpuidle_is_state_disabled(0, 0)
+
+match is_cstate_disabled:
+    case 1:
+        print(f"CPU is disabled")
+    case 0:
+        print(f"CPU is enabled")
+    case -1:
+        print(f"Idlestate not available")
+    case -2:
+        print(f"Disabling is not supported by kernel")
+    case _:
+        print(f"Not documented: {is_cstate_disabled}")
 
 # Pointer example
 
-- 
2.46.2


