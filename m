Return-Path: <linux-pm+bounces-20124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEE2A06822
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 23:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71680188701A
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 22:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8742010E5;
	Wed,  8 Jan 2025 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCGgRQY9"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2809C204C13
	for <linux-pm@vger.kernel.org>; Wed,  8 Jan 2025 22:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374749; cv=none; b=THi63yAZksLKI+CPvjeFvhNzRCB5bcYNHvinl8MCvDE8DRwv4G0yTreS8DEFa1bnJTBnZ0L7B/SNqXDXSsJeCQmbg2C6Pg7w3HuVU4bmb2h4hEXlARRuWbmbwPWDWdWAuMjA9+/lKQyvQ3uhXXhzchFzQM59Ml15/bdkaIVL/RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374749; c=relaxed/simple;
	bh=phACauq1v3hEjr/whoNrfBaMAXZ5IEpdP8W3kvIwcto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F0uJHLx3pHYI0s1kt6R/6B5K9SbqOwVJvA0OBNBjL7YYwEg/fAtxULipVPKUrbR4v4UgdrcsuXClucY2PK837MEMFHm0sQsqPEKT+iXqONix0oaBwmXfnuoxw0a7rcYszAHi+liGtF+eDQWLpynXAdxPSdXMaq5qjoVaAFn0OCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZCGgRQY9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736374743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lr2vEGvJPhwM/57d6UxiwnvqAgndkMoO9FG/My+PjHo=;
	b=ZCGgRQY9Dw/eJLA7BnYFRS/6etp/VgOsgEChpeuf6K6WNWyGnphQeGpBqKLaabrxGwRs9W
	kC3jaMtzVSLBUETozOnFVikPdGHlNZfaRvb9sQPJjnSDhzqPXROIYm0YxM7XSwEbH6iYgr
	7x0fnv0uhNfbUGPidvV5n5UmgZ1sLj4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-QolAJgArP82CvuysgYcGpQ-1; Wed, 08 Jan 2025 17:19:01 -0500
X-MC-Unique: QolAJgArP82CvuysgYcGpQ-1
X-Mimecast-MFC-AGG-ID: QolAJgArP82CvuysgYcGpQ
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6dcccc8b035so4886836d6.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2025 14:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736374740; x=1736979540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lr2vEGvJPhwM/57d6UxiwnvqAgndkMoO9FG/My+PjHo=;
        b=ccunPmMlDaLUh4upO/+ZNo3fA9pd+DOFPtiSAkm/SqkU4t0lmqeoqtnrXlePuc/rQE
         Z2zqyiuLgmK5RK0fJsLb87mTykdGm70ul7dKkZYr9L/tSXO8oKV3S3he00ZeEwd2bwtO
         T8xEfzRz58hUiusuKflEAienxv3ZaqcTtpleyYVwAlp25k71PILnly5h/a7omWGrKDf8
         2j56Mf3CcerqF51hj2hrZA4G4JDATvStQsl8eCaG6zz4M1mVDi445jj1gLIXi0eS/8Hn
         9EZgpela+7Y19/GNeGa3ixOaIT0kERgVdDR4watPeZaQNkESMz0kpkN24x6L2GkaV+Qo
         L0IA==
X-Forwarded-Encrypted: i=1; AJvYcCWcl4QIdXPwQ9gvM9S2ebjArbbiDki64oPtjDLO17dn9mNKhLLsmvuPyb4T6Ur8zRAG9LpBtMI6ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyFMhVD1HoCYeiL2MLIjOg302ClXyT/LsebONYKS7cO6ZXFXvY
	qlgcTZ3M1C0gYo/KP4D1FNYLZPd5lpR0mUodbsYnRhrjkd3C8pcJajpOsS5MlLJlOwP9j66uKTp
	wOaG/Xp+J+qoKzXHw+n2fHnC0iHjqGXUQwip3rVz2xKQkNerwitEzDqgH
X-Gm-Gg: ASbGncvDzOMbEDKwytjo3oAraKLPMM8Vqc5vPYjq/AGumHrsZx8QtqvpXjhJCYU4w3R
	nvfAbzLLJtyTpJ0B2GCvTT8jMst2vg6ws0hbDI9H38vx6vbZmm+zjDleVKzbfsxGYtw/+F5GB2z
	sf+wBh5OYPpuasvxZjREFNp4gGGSQncu+J2NUrha2rzvvVWawSjurqXB1/gYUdFdz1FiPuChUWI
	fBM0pp2DtoN6LqUCxCOJ01Xt0iW4XI4tDgRb4XtrvoyV0e5VdsqXxs7yFKcBHKBltm3
X-Received: by 2002:a05:6214:3b81:b0:6d8:f50e:8036 with SMTP id 6a1803df08f44-6dfa3ad8f91mr14857716d6.20.1736374740604;
        Wed, 08 Jan 2025 14:19:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFI09maFb66bz4gMBmOqgkOZvNDTwOWLKjXlY1eeQqpK8j4Otaa+xIOjUmtyUjsJT3xJrrmYw==
X-Received: by 2002:a05:6214:3b81:b0:6d8:f50e:8036 with SMTP id 6a1803df08f44-6dfa3ad8f91mr14857486d6.20.1736374740277;
        Wed, 08 Jan 2025 14:19:00 -0800 (PST)
Received: from thinkpad2024.redhat.com ([71.217.66.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd182070ecsm193833376d6.124.2025.01.08.14.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 14:18:59 -0800 (PST)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Renninger <trenn@suse.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH] pm: cpupower: Add missing residency header changes in cpuidle.h to SWIG
Date: Wed,  8 Jan 2025 17:18:44 -0500
Message-ID: <20250108221852.30771-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"tools/cpupower: display residency value in idle-info" added a new
function to cpuidle.h. This patch adds them to the bindings.

Link: https://lore.kernel.org/linux-pm/20240809083728.266697-1-aboorvad@linux.ibm.com/

Tested by compiling both libcpupower and the headers; running the test
script that does not use the functions as a basic sanity test.

Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
---
 tools/power/cpupower/bindings/python/raw_pylibcpupower.swg | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/cpupower/bindings/python/raw_pylibcpupower.swg b/tools/power/cpupower/bindings/python/raw_pylibcpupower.swg
index a8226c79cfea..d82af6fa93c3 100644
--- a/tools/power/cpupower/bindings/python/raw_pylibcpupower.swg
+++ b/tools/power/cpupower/bindings/python/raw_pylibcpupower.swg
@@ -163,6 +163,8 @@ int cpuidle_state_disable(unsigned int cpu, unsigned int idlestate,
 				   unsigned int disable);
 unsigned long cpuidle_state_latency(unsigned int cpu,
 						unsigned int idlestate);
+unsigned long cpuidle_state_residency(unsigned int cpu,
+						unsigned int idlestate);
 unsigned long cpuidle_state_usage(unsigned int cpu,
 					unsigned int idlestate);
 unsigned long long cpuidle_state_time(unsigned int cpu,
-- 
2.47.1


