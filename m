Return-Path: <linux-pm+bounces-13644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBFD96CC8B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 04:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 463C4B2395D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 02:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08591422D4;
	Thu,  5 Sep 2024 02:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsYwnRSj"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4788313B2A2
	for <linux-pm@vger.kernel.org>; Thu,  5 Sep 2024 02:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725502782; cv=none; b=WM53BE/XWzCPYuKqd5Iy3X2smYTNQxkPeCs2sByYJ9lDXoFGg/XRxHNRyLC58nXPkpHIJVAvEzGHjl03fz5etZJJqwFTePp9QMM6UGX6ZLl5HxvNk1wPLiT2cs+R3QX1CcD3O7hML3mOtCHAhOF1qZquATOwhxg1qq17LUPdDbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725502782; c=relaxed/simple;
	bh=58AAUu3zLBYneqXHjleXP+5dU4Eip6Z0sKnVnDK/33E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oblP+VKHpJeINdF7a4WMaJbPz4d5VcDs7fbwz6szKfSDtd34Zw3pJ1PhtNVcnaHlcMk3SUTl4l+4gn9tR4osEKGagm476oCVxKJio+AC2pCXHt9RI2hIa3yAAu4LRuwj8qx3+1S5vI0z/ZGz7sp0wH/l+LRaROSt9OAODIZyrMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XsYwnRSj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725502780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MFBqQdy5a6XuM/Adgjobnf2AgZQzbSd8x2uLCg7mMw=;
	b=XsYwnRSj/ySb7HLeowduorrDKTeXQ9HMn3I7H9LvdXJNN8qGauvPGAXoB2uJcCakyRhYf0
	u3xY8sBD2YBcpyd0Rp5kP1Q6/nPCRZE18r008Kao0VujGaLZX5MKvRlewNNcl9mPW7iPDW
	v+rwTtk6FW0EJdp3ttfk+jcK1xnuuAs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-k4598A0VP2q1g5gnbWOzhg-1; Wed, 04 Sep 2024 22:19:39 -0400
X-MC-Unique: k4598A0VP2q1g5gnbWOzhg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-45683a483e1so3030401cf.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2024 19:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725502778; x=1726107578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MFBqQdy5a6XuM/Adgjobnf2AgZQzbSd8x2uLCg7mMw=;
        b=awfIj4Vm/69Vj7J8swkV6dTW6d0LUF87dOErXbYJncgGqdNcJkoZK8C/DbbNXu6qCf
         IdMmYt5pbLSwUzF3cUtEz0HBno1SS+GKbjw/IGLzPXMsHSriegZJHlqonCL1LiI4bLjK
         fHxAAxHxeEbBJVoB1d3/JNUhkFvmxIeK7edJNbOnON/YX4/b3OsPdcaysCDx3GLk5HKl
         5Di7rENRbY8KaUM4avJixJSg+bvQmlwJRAENgTRLUOMRoH3n8KqtE60Wxy2w64bJ4NQ3
         QFsucE4XiyFjdHlO35N1+3ybEhc8M0hiNlxedtKlkqe1J3RdOyIj0sjTzOdFua/qkBl9
         UAqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUXbcYBdrebNUGL1qfI8h3Z01AtjHVaYJ3UzsXntXE+n/02iZspte7+Q8BvhazZzceeMWy+LR8Sw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwS7b/lz9fV5w9vlwisZUpaiFc7LlW2am6ELTteyYCXzyEiuJXo
	NCZABnpXHIo9GtGCDUueMjrHOD+S7PYLYpJvk9wuo/ZPN5bwsGU39gqDOwVL9/wsEke28KZLJIv
	RyZD+6URHCFdLK/tccHBL2Fs15QDEOImmKFeYAi0+O5Eymt0bJG/TjipM
X-Received: by 2002:a05:622a:5588:b0:456:7cc9:af0e with SMTP id d75a77b69052e-456966802b5mr249894101cf.50.1725502778609;
        Wed, 04 Sep 2024 19:19:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn9YkJ4WCWDspPOUrJpuM6yCNEI2Xex29jY5uZPJ90kTU/Agzmk8L3e6RGqn2gru1XRZ1aLQ==
X-Received: by 2002:a05:622a:5588:b0:456:7cc9:af0e with SMTP id d75a77b69052e-456966802b5mr249893701cf.50.1725502778122;
        Wed, 04 Sep 2024 19:19:38 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.47.229])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801db22b5sm3531181cf.72.2024.09.04.19.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 19:19:37 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v3 3/4] pm:cpupower: Include test_raw_pylibcpupower.py
Date: Wed,  4 Sep 2024 22:19:10 -0400
Message-ID: <20240905021916.15938-4-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905021916.15938-1-jwyatt@redhat.com>
References: <20240905021916.15938-1-jwyatt@redhat.com>
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

Changes in v3:
	- Small puncations below fixed.
	- Reordered patch series for cpupower stub implementation to be
	  first.
	- Added pm:cpupower prefix to header and Rafael to Cc.

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


