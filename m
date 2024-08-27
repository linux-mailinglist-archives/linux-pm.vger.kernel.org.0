Return-Path: <linux-pm+bounces-12930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A64CE960191
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 08:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E151C2145B
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 06:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED7C1494B5;
	Tue, 27 Aug 2024 06:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRjJaxwI"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E4155C94
	for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 06:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739949; cv=none; b=k/CB303RPrIBmb+t+JFmvdRUxF4clfe4KlcXHSi49sz8DSvSUtNKH4qurPGNV9Cu55i0O6KrJ9t1gD+wmOykRIhYI43z3mTLZnCSAcc0TibUaOKVmnCzDwqrY/Tut0MgDa2Ydpw/ORkXIkhssndA4riG14ceDho6qg5ZrnJHg3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739949; c=relaxed/simple;
	bh=U2H/nnmhKqJ1mAbFf1o4lwVgpgis69qFv/radbpXrfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDvmKhMVamaW5ooDboMDEN0TNWuF0Lm+c4sLyFT+pWrl0Pa+HNdgtpvA7sKkOCn0Cx2L390s6kzOo5M2OCh06Kfs8VNhBuOmbiVZwu/eQ3QBKAH0Wp3KKWFKkcc5cYb4XXmSiXUWoKbZUeP0aqx/RizXEhmvM3T3ebkJYVgaEfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HRjJaxwI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724739947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AhFymyY3ZzUyMaZHrWjD0+mazgbdoYhFhxFRaaHDnfA=;
	b=HRjJaxwIe0UA9GM8U6M4K6xicNB0e5SebWSRYBql2JhIUC+/wngO0fOrD1M4GMOcyKRZ2+
	fFgy7RPMMs8F8SOK44Xuo63cF/pHhzzDevdQsk9dQrPFZ/DIOx4iwUxv4LluCaTVXF94ZW
	h+KA8gT20MHQ/DGRVosvRSdik0TbWQI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-5r-LINrDNeSx18C7k08dTg-1; Tue, 27 Aug 2024 02:25:40 -0400
X-MC-Unique: 5r-LINrDNeSx18C7k08dTg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6b351a76beeso111254357b3.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 23:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724739939; x=1725344739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhFymyY3ZzUyMaZHrWjD0+mazgbdoYhFhxFRaaHDnfA=;
        b=teTJmu4N5qWTwFCmVGSdCjj7d6BVGYZAuHWTXcRqvSccabA+6s+ZCANKl3UFIQhOmM
         KWGKfSOxasn6E22qdDuWkpsgnHJ/K35dWZWkEjuslMf3uhTK7E3e9Z/b21FG0hC9gZ+j
         XfG1FHpf02u6WV2qcxTO0PPCm2Tk3kaU/YTM2C0CHSUQvsmgc84bT9NVOlCLhOg74vTm
         Rtorumw847Be++BItoB5OErYnZq6jjKXfyfZFMWTJ0AfDMN0oP+3j1BCNbXPP5FYvBGD
         xTXYjJcNOe+L/YjckDIXgDjdBcqHpclE/VKv44+nr3nxOgSTFoJ4My9lKHWWVqQOR+Nv
         kV4A==
X-Forwarded-Encrypted: i=1; AJvYcCXAE6Eq+zYHU6ij5CdEuhdYA96P+/lkfapT5dj7sDgbQjnUFdZkpxkqda7PtZFMnA4k/XVMIYeVUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5BX2r7bxlTGqyLxqb+ZLL0S0Bda2TpQj17Zjx+b69k8/uXDaJ
	6zLouOx4F2RxPCaacPrMILLyxUKYHpeGu79IxyawQ/lNSMrjAHOlwa/LJ2c01bhbK24WBfD1vF0
	UutzwygZmHnICzT3MH2hl3UZD/WzyMnUPSAo7L+taHbiAsgkUo7FOz0eD
X-Received: by 2002:a05:690c:fcf:b0:6b2:6cd4:7f92 with SMTP id 00721157ae682-6c71437c598mr132010077b3.5.1724739939593;
        Mon, 26 Aug 2024 23:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVWVMNWNr3EUR2KwhdGnL6M1EPVnmlDwDQ1kPq2zVtyZREcNg3pVJaOfG1nOyO5YCizPH52A==
X-Received: by 2002:a05:690c:fcf:b0:6b2:6cd4:7f92 with SMTP id 00721157ae682-6c71437c598mr132009897b3.5.1724739939245;
        Mon, 26 Aug 2024 23:25:39 -0700 (PDT)
Received: from rhfedora.. ([71.217.43.75])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f1fe176sm521044185a.0.2024.08.26.23.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 23:25:38 -0700 (PDT)
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
Subject: [PATCH v2 3/4] Include test_raw_pylibcpupower.py
Date: Tue, 27 Aug 2024 02:24:35 -0400
Message-ID: <20240827062438.71809-4-jwyatt@redhat.com>
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

This script demonstrates how to make use of, and tests, the bindings.

In the future, this script could become part of a larger test suite to
test the bindings and libcpupower.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---

Changes in v2:
	- None.

---
 .../bindings/python/test_raw_pylibcpupower.py | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100755 tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py

diff --git a/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py b/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py
new file mode 100755
index 000000000000..3d6f62b9556a
--- /dev/null
+++ b/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py
@@ -0,0 +1,42 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+
+import raw_pylibcpupower as p
+
+# Simple function call
+
+"""
+Get cstate count
+"""
+cpu_cstates_count = p.cpuidle_state_count(0)
+if cpu_cstates_count > -1:
+    print(f"CPU 0 has {cpu_cstates_count} c-states")
+else:
+    print(f"cstate count error: return code: {cpu_cstates_count}")
+
+"""
+Disable cstate (will fail if the above is 0, ex: a virtual machine)
+"""
+cstate_disabled = p.cpuidle_state_disable(0, 0, 1)
+if cpu_cstates_count == 0:
+    print(f"CPU 0 has {cpu_cstates_count} c-states")
+else:
+    print(f"cstate count error: return code: {cpu_cstates_count}")
+
+match cstate_disabled:
+    case 0:
+        print(f"CPU state disabled")
+    case -1:
+        print(f"Idlestate not available")
+    case _:
+        print(f"Not documented")
+
+
+# Pointer example
+
+topo = p.cpupower_topology()
+total_cpus = p.get_cpu_topology(topo)
+if total_cpus > 0:
+    print(f"Number of total cpus: {total_cpus} and number of cores: {topo.cores}")
+else:
+    print(f"Error: could not get cpu topology")
-- 
2.46.0


