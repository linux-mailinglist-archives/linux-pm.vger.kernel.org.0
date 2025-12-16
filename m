Return-Path: <linux-pm+bounces-39623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EC3CC189D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 09:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C8B030358EA
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 08:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA7534A774;
	Tue, 16 Dec 2025 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AN0SQ3BA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59372337113
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872263; cv=none; b=MbtrM5mtY0YnkwZDIhlNSC9zrKgAlvAiWmR55j2fc0ASrOMdPMoNbyhe9OwUMz+SwdfyqX2juRM/i2YLzAgZma2LKZ/cgCyXHqkEiFhhuD3Z+o5UZa+SlvFdkmw/pCjEXPe+xCQBHwWLta5Sx22bpIaCMe2P9Iz9JoSnXsFK3CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872263; c=relaxed/simple;
	bh=pQOu/CzqzcR7GGaU7MOKT7UOkKMi+/TDnPZn3RlhLFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbyJkz4AsbU21rYfm5njifB8+AqmuBHugQ2aRzYaY0iRDGkxW/fprSXsmfJC8kd9T5WZ6YTUE4u2v7gBHiFmG5bry8WavtA4RLlxnzqRc07ysE5JkShe8v+ZQJBFYhOm6MVYwAQYmcNbDsxH0QOLFkd46Ni/5RfTDAXYQY3SWcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AN0SQ3BA; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-597d57d8bb3so3749903e87.3
        for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 00:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765872259; x=1766477059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuQo6ii1YWdpxq81EXNiLoC7H2wzc7ZhDW9Pv0mDqDI=;
        b=AN0SQ3BAfHarVjYjix4Xq39FAt6Un4oeuYZBAqk0wydmwNSJ72hTUXMPE1TuMZMmA/
         bnD1+4RajdTuPDGW7C+HnTOIMsOrkMMh+33j2Rc0Xs8Y3eZ7+jHACKWYOf8S7fpCMJPK
         bpIkF70jQGFcDRw04GLJyWaI5h9H9VPbc5Mij+Sh4MsiOOZ38h59nNrrFtHA+Bp43C/W
         gNbpSj/DkW5BKbDuVVzR4NM+8EOMsFKGtL2ZkKBOZnf1PUIANU9uE2DxFg06o37y72Tj
         18VwvJb0R5ApzV2TDUP45DFEaBnB4cGvsV1laBnlVDRhFogxQT9bTTekB72C002BXT2I
         ePdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765872259; x=1766477059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TuQo6ii1YWdpxq81EXNiLoC7H2wzc7ZhDW9Pv0mDqDI=;
        b=Lmaqbm4Oj2l59MHBcsbQOa1Rd4569ayxrajnGkdnYOCbhKdcyBu6zHiJsyypXw9D2q
         4jsjHhJzOWf5xqmo2IOrGLz/eWPw/P/QEPnxw4qG1hxWLnHQYDg1aMGzu3n2NXYuMn8E
         5tKDEPCywBGS2jucBOClYiDKwtefU79H0GNQP0gYUED5WB6bR2Gbj85NJauz6dW+gdZq
         1s1SHs82p7FdX7TD0VmacdrpCOof7C/e8xWME4KHDxO62vmS11GRwFAzezS/kEMwdndv
         yRRDJXA+Dl+IcbsE7zt5KJ9iHIZ44YT8RMzynflDafjWLdqGUxqvA76vHeNUEmCCMZgL
         7cMw==
X-Gm-Message-State: AOJu0Yy+Fsj5GSDf8lWb6jjVUFXtBm79/6pga1f2INLGd/f7rOGkRJtG
	tf9OMMYZRt/LahUM7A17bDyBQK0bF82hNb9uJsvA/P2+Q7E8LOfqeqxZ
X-Gm-Gg: AY/fxX6iMLMdqWOjSFpEuh9V9MHTwXJoi5UBnyzeiEz86EXoaHpnERXdfrjPEPFpgCj
	vKE4YBJGztk909aPQXefhSpt//+M7hUvxcPxAYFNO6YB0zENl24lli0Pj3GDmtCNZcItMMA280+
	BFr3RYaclG8STP5xLO1hHzfMaJmPxfD3D/4IPCj1rwbohBxG0y0cNuU9ZO5skuLVNDD7hRQWh2s
	4Y49CXebXe+fPhglA71cyhoc5NU1c8SAxjTNO0pO0QVHvjQZ4VmfRu0+MA3n52noaMdaCpm2z9c
	Pu5IuJSkJB3M4i/EyjWsuJPI2uuYwjW0D4b5mh5K9P/7pWiCdvzKQ+acvnHvVpIKZad/XBwZEVq
	cQy1KdowO1E/1ZDmygNJcRyNtHjrlF+UB2n+r5ETaED+Tvmzyu1Tx0GEjmvM81XK5zwhmamMUJp
	kHbjOnI/uDaV7+ifJk2MJwVCVbGbFQo41BnCKTkZiKE3P3xukbsofrhgYyWgJuNlUPXgYOLd2Uq
	UdG/Zc=
X-Google-Smtp-Source: AGHT+IFnlu3FeGtRN9E3ZH3Tm1gdaGckwZFau0870jGOutE+9ZIUf4QwIqzp1Wm5wK1sg5YzH2VTPA==
X-Received: by 2002:a05:6512:23a6:b0:594:2f38:4604 with SMTP id 2adb3069b0e04-598faa82310mr4480055e87.41.1765872259023;
        Tue, 16 Dec 2025 00:04:19 -0800 (PST)
Received: from abityuts-desk (2001-14bb-ab-c176-62a0-4b37-648c-102.rev.dnainternet.fi. [2001:14bb:ab:c176:62a0:4b37:648c:102])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5990da5dc09sm657426e87.75.2025.12.16.00.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 00:04:18 -0800 (PST)
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH 1/3] intel_idle: Initialize sysfs after cpuidle driver initialization
Date: Tue, 16 Dec 2025 10:04:00 +0200
Message-ID: <20251216080402.156988-2-dedekind1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216080402.156988-1-dedekind1@gmail.com>
References: <20251216080402.156988-1-dedekind1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Reorder initialization calls to initialize the internal driver data before
sysfs:

Was:
intel_idle_sysfs_init();
intel_idle_cpuidle_driver_init();

Now:
intel_idle_cpuidle_driver_init();
intel_idle_sysfs_init();

Follow the general principle that drivers should initialize internal state
before registering external interfaces like sysfs, avoiding potential usage
before full initialization.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 9ba83954c2555..45903685fe680 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -2485,12 +2485,12 @@ static int __init intel_idle_init(void)
 	if (!intel_idle_cpuidle_devices)
 		return -ENOMEM;
 
+	intel_idle_cpuidle_driver_init(&intel_idle_driver);
+
 	retval = intel_idle_sysfs_init();
 	if (retval)
 		pr_warn("failed to initialized sysfs");
 
-	intel_idle_cpuidle_driver_init(&intel_idle_driver);
-
 	retval = cpuidle_register_driver(&intel_idle_driver);
 	if (retval) {
 		struct cpuidle_driver *drv = cpuidle_get_driver();
-- 
2.52.0


