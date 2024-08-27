Return-Path: <linux-pm+bounces-12929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ED796018F
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 08:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A54B21B88
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 06:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C358115350B;
	Tue, 27 Aug 2024 06:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlRPL94n"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E9B1487F4
	for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 06:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739945; cv=none; b=Y+icyIce0IRqKDX5DK3j/KHOWbh2sc/a3gZ+vVzRW+4XWz7SHG408bPxMu8UGd4hO9MnXz54MfLi452zruYDCDTrFWJeIJtwxaWXv9zdhkUY2V+kr+sw3gy70m5Tg6Kpbhhdi0otOsJNZxB3VNJDKUTB33aW+B+n6W2/Np8PElA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739945; c=relaxed/simple;
	bh=WmB0wo2kGM2nwplrjypHlZtd9IRU7iJe1X+JRXxRYVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMK9FvjLdd7O1NUU503ZaJK3mqbhVctRq1CsTZdFEkxAoHuiN/Ior68LGxgVXfSPCDYC4NDnfhJEL6W9YfbryOwFWSzI1wslnnmXg52Rptd56mV0zUOe8ouwThpvipnlH4lhlmZA70KmpKzJa323qU5nTP5WuvsqsVoX1rHJ9UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FlRPL94n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724739943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tChrxO1HuAIgDg5Agw3TuPA4TMpEaBjY2k6lF8kLxg0=;
	b=FlRPL94nDZ3p4ZCc+5K7BbtUxzqJY/Kge9c8cwcjpMQNpAmkyUvPJlysxDI+CeoHUWUmPT
	MEDjHGOxFZHw9da3O5afF0Yid8QZS7IWuwsGbQTmiR6/+lpcoy57XYtFG++zbgU8dIkOYq
	ECqMc0Ro2+vCX3hXGpDfP418OK6ZTvs=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-CH5qacNoM8KqPLEXo4kU4g-1; Tue, 27 Aug 2024 02:25:41 -0400
X-MC-Unique: CH5qacNoM8KqPLEXo4kU4g-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-498cdceda97so2119341137.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 23:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724739941; x=1725344741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tChrxO1HuAIgDg5Agw3TuPA4TMpEaBjY2k6lF8kLxg0=;
        b=vE5brpqn9Xpi/Ke8X3xFZxKSZTPmSkYw5+nlPWIpO/XFfxtNaAOAAVoeEyVwfd1oin
         xJGjch2AMVeQVnzZ3cnUVbXo+N/F7h0PUQ9P8gWXFZFaE7B1P6vLFPjLcP9S9/6PInuH
         pnzxwq9Olq3RM2VNcbN4u/MfdnDs+4wC3c1KLVqrJPPiNdnuHfLd1SU0WATaZnUqcrMp
         OvbHoAEnygEMqLFpnUmj8GY4vRWVMZwSM1J8k88pLzIAIipltXNnsSBBevIrcTPAdJtz
         klzUW9E+mWcT7Zew7QmSJT93DX4FLVCWwQvlG3HO9Lhkm8IdvJ5GuI1YMmoRIQTz/RUZ
         VOxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBzQht0oxfm5qyR9+Eg32LAZLms4b0fXeRmNZ5/DbF9MfAPg1RJt1njj5MxP8vZx9p/J14XZCCCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrA3LNaPQaoOzjfw4hf3ZgOcl715DGU+1qEewbPbgVhF/uEO/Q
	ZVRWz3jMSNBZ/cnRY5nFl2D1HV/3rD8L9sYnLMi9+czlYrUTRAxf703i4d6mf/X5SlHj1MN4dbW
	cgqa/Jni533Ig7ALwYUms8K7Rf++ks6sN5GkdWvAMA8UKxRyR4XZC5U9b
X-Received: by 2002:a05:6102:2ac3:b0:497:6360:6454 with SMTP id ada2fe7eead31-498f4527b10mr10077643137.1.1724739940805;
        Mon, 26 Aug 2024 23:25:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKJOfa1bnLznhnu8Wk2lq1SZIINHqonjeWtxA62MU4NC0rheKOcp5i9yqAIel7fXo9kfvaag==
X-Received: by 2002:a05:6102:2ac3:b0:497:6360:6454 with SMTP id ada2fe7eead31-498f4527b10mr10077631137.1.1724739940420;
        Mon, 26 Aug 2024 23:25:40 -0700 (PDT)
Received: from rhfedora.. ([71.217.43.75])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f1fe176sm521044185a.0.2024.08.26.23.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 23:25:39 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v2 4/4] MAINTAINERS: Add Maintainers for SWIG Python bindings
Date: Tue, 27 Aug 2024 02:24:36 -0400
Message-ID: <20240827062438.71809-5-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827062438.71809-1-jwyatt@redhat.com>
References: <20240827062438.71809-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding myself as the primary maintainer and John Kacur as the backup
maintainer for the libcpupower SWIG generated Python bindings.

Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---

Changes in v2:
	- Added as requested.

---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f328373463b0..80d5475c943b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5819,6 +5819,9 @@ CPU POWER MONITORING SUBSYSTEM
 M:	Thomas Renninger <trenn@suse.com>
 M:	Shuah Khan <shuah@kernel.org>
 M:	Shuah Khan <skhan@linuxfoundation.org>
+M:	John B. Wyatt IV <jwyatt@redhat.com>
+M:	John B. Wyatt IV <sageofredondo@gmail.com>
+M:	John Kacur <jkacur@redhat.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	tools/power/cpupower/
-- 
2.46.0


