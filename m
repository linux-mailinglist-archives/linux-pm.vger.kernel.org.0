Return-Path: <linux-pm+bounces-14980-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA2E98B0C4
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 01:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDC81C22705
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 23:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543A018CBEF;
	Mon, 30 Sep 2024 23:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnJs0RSd"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89C7188A17
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738551; cv=none; b=ZIV2pPTFn1DBSfEv9PkCEcym0gRi5osOgYtdh3PX4PNRkRUddVdtBpYzYjD9/ladIRGsY8nUrTOKQ4/g0Cd2B/ukza0inu4X0DVTxkeopP0Pj6Muao1MkkfHy9hOXlN4To75/vQRR46X+VrmBc2eIFt9txBjP0wz83PwVzJL4r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738551; c=relaxed/simple;
	bh=5+AiJaX4UtDbmRH5GAq9t1hjYK48PdL8+bwdm8fCAv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlLY7YF/8oQ7/8wBrfsAxZgZrEfxbQbLt2cH4fIXDaXOnV+gT/4w966dy49bG1aosgEZYbvcz0FGUGOrZndWn1ovJhe2je5a5Kq3gzMgx4ONRjy0KI450t7A2ugg4LFYWMOJICjQeU7a8JT397Sn3laOltEe+lpuaCF6fvDsa1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HnJs0RSd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727738548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKQ5wXzAVJ56Zv2qJN0G0ZqtK5sCYXvmcnZQ07OdvaQ=;
	b=HnJs0RSdDzms0iWh+eMOCDdUVqS/WY7/HSHb8jPx33AzkMAKTt1X1GhaEmtlX7MkUl6ZUl
	WGnlaI4aBYS6OUBmiBPbTOv0NWVbMH81inoKnBEIU3c1+QpkDD3Pca8lyJW6LkMIaZH6ny
	neLyUtpTziCJPnDQw+tNwAtmJHcQe+E=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-yURhVHjHOx6FuynfMYy_Fg-1; Mon, 30 Sep 2024 19:22:25 -0400
X-MC-Unique: yURhVHjHOx6FuynfMYy_Fg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2e08735ed9dso6758961a91.3
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 16:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727738544; x=1728343344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKQ5wXzAVJ56Zv2qJN0G0ZqtK5sCYXvmcnZQ07OdvaQ=;
        b=Bwnw9xVcas+37nxZeVX8gbqpZ/7RJTB/5ugRf/q8DYurDqLmAnhaEz9CWmcjWzM0CH
         D9w7BA2UUCbh4rmM0h5K4NqJteuIS54ce/6nUL2MdpjP4N7OyVKfNeK1afLxfQ3MpLO3
         cCZM9uVe13RJAwsP8v8GwzH87Bxrs8vA0+gpYA/Ri3d4CWcGIjF63e8EQDM1opXmdFiG
         kLE+huj2MeMCna6GkRXogvQMDAKa7ucHl/YhjlCabWWn2p3iAxm7ra+Cmxxt7NQZJLFa
         TT7jL8dTb47kYAZFoJSL8to2YxWPgNmOYZKOniO/QUEc6KawAXcbBNIyZjrpsv2erLxm
         997w==
X-Forwarded-Encrypted: i=1; AJvYcCVXJU3XpSMIhcnoeIc2V/PIqgrkOtJvWAexmCYtYhIW5hcotIwLATS9QAIlNAvUe5W0G+enQMcFRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj7DEHjpObZFOv0DZk9WhD1yO7o1XBSMaS8v6bv8BivqNwC2ii
	7n9AH4m5N62ti1uMUQUCPwV9Q7jIh84ZrJciMyLTzkmOM98GHzqNCSCWgYH92SpuNvL/tzrFI3Q
	s+/cZh2FWXYOOwPzMzleKk5RdBNktM3DdLMwoxmPUjtfJreJeq59CfKDd
X-Received: by 2002:a17:90a:e147:b0:2d8:a672:186d with SMTP id 98e67ed59e1d1-2e0b8b1bd0amr16498895a91.20.1727738544625;
        Mon, 30 Sep 2024 16:22:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpAD8gHdyuAIdyq8RdFdxD2qGC+R38kuvpPw+3wL6J/iRUtGseYVtWexsa41Ea35x3KpeH3Q==
X-Received: by 2002:a17:90a:e147:b0:2d8:a672:186d with SMTP id 98e67ed59e1d1-2e0b8b1bd0amr16498876a91.20.1727738544307;
        Mon, 30 Sep 2024 16:22:24 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d685b9sm59241985ad.54.2024.09.30.16.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 16:22:24 -0700 (PDT)
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
Subject: [PATCH 1/2] pm: cpupower: bindings: Improve disable c_state block
Date: Mon, 30 Sep 2024 19:21:54 -0400
Message-ID: <20240930232158.29024-2-jwyatt@redhat.com>
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

This commit fixes a bad comment, removes an unneeded code block, and
catches a few more states that cpuidle_state_disable with the test
script. Part of the motivation for this commit was I kept forgetting to
use sudo.

Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
---
 .../bindings/python/test_raw_pylibcpupower.py        | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py b/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py
index 3d6f62b9556a..bb2b26db8b10 100755
--- a/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py
+++ b/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py
@@ -15,21 +15,21 @@ else:
     print(f"cstate count error: return code: {cpu_cstates_count}")
 
 """
-Disable cstate (will fail if the above is 0, ex: a virtual machine)
+Disable cstate (will fail if the above returns is under 1, ex: a virtual machine)
 """
 cstate_disabled = p.cpuidle_state_disable(0, 0, 1)
-if cpu_cstates_count == 0:
-    print(f"CPU 0 has {cpu_cstates_count} c-states")
-else:
-    print(f"cstate count error: return code: {cpu_cstates_count}")
 
 match cstate_disabled:
     case 0:
         print(f"CPU state disabled")
     case -1:
         print(f"Idlestate not available")
+    case -2:
+        print(f"Disabling is not supported by the kernel")
+    case -3:
+        print(f"No write access to disable/enable C-states: try using sudo")
     case _:
-        print(f"Not documented")
+        print(f"Not documented: {cstate_disabled}")
 
 
 # Pointer example
-- 
2.46.2


