Return-Path: <linux-pm+bounces-14776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86202986D0B
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 08:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30CFC1F24335
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 06:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D7A1A4E70;
	Thu, 26 Sep 2024 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="R+wIwy0B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E11718950D
	for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333745; cv=none; b=ZwV09pgyzgRlv7sNKxKUB0ohw11D0J51ZuRxoNYcPCYNoYT7DHL6X2YiXyK+ieet9Tl28IWGYLjbtOq5vCTPbPTH72D838lH33/kZBXtEozynj5l2fEq+oDWLaA++/m4beICu/47vE5YH5B/XR9buZHlZhoT96kRiFaZEOPOdCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333745; c=relaxed/simple;
	bh=V5qAw7P+eqzi/1Duiuys4SRbwKIjG57n1EAbl6sKbjA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=bTz1OinnL35BbkMiSDDbt0mwB4r1p0wWhf9jvl4sGVhdku5zxWCfmayPll1Rhs18bJQrZS0AA8sxwRsB9uYt+1ASdCe0zWieUcts3g3YMeZhJ7v9OeTlxxqs43CaguTBcuS1qMmdWSR5Dw79IK4qNi6EeWTCetMpKW6o1Ox08eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=R+wIwy0B; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71100987d1cso364643a34.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 23:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1727333743; x=1727938543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MzHfWrObFTebylfAMReMmx0H/fNyKd6EWjjqrhs5YS8=;
        b=R+wIwy0BqFZfZ1ot5/7EyBWZ8e1cxDQ3kUYDN+jU6e1K+oKi1rKeSvnhwlcF00/C9r
         MN9hJJbxH2ETUhzUJyaoMhxTnq8N5FbaFloE6mCw7yryW3y/Vji/quSRtqNllJMIQto0
         jWWHPPLa+O3BZiyDYmxBQpz94pzIJx07LudcOy6mqkf+5T4Clk8SpFBSy1TKuKfz63v7
         7B7u+BMyS0Jq1ixTXfWuQ2+mPT6b21Xlve8XyrQmJJiYekhEA4dDNRZF3Cz949x8JdFc
         pAd8SbWYlntCM9JaWUx8imsMZSINYhYxaFzffAZqM0KFFv4lNQlQ5GyX6DjmKnyqvJOX
         S6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333743; x=1727938543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzHfWrObFTebylfAMReMmx0H/fNyKd6EWjjqrhs5YS8=;
        b=MG/8ZqcpgLtHjI5fP91LBz9nY91gAbSomCR3HJXh8eLALVNz0cHf9E2mGiduy4Q+2g
         seLeEH+ylTK3KWhcLz3fHFP6sEO20OYEBUcv2fdfEAbU2U/qHnyHPmskRjcLi2ABRm37
         fCHyjZBzcnituWcSF+SIlymLrgDYGaXNk/uyb1REt+nwmnWKl/pEfE1sJDHNk4GSrgGE
         /TA3X79vJW+PMNE9+0hZpAFvns5iCHlXW6no1JeKSPk8q5dqHPWuPQEtRNlKVaASb6Ha
         tqSxC1ATIxuWv2wppvOBpvvidfNp0a/PQKbqYXm8UoaXgNFWRH0uv4sGP+wOEX+2CC+v
         Us7w==
X-Forwarded-Encrypted: i=1; AJvYcCUexWu8uvNVzIyW5E26qV03j+XHYkzbGJTTJR7u+kbNhmCfZ/8KLv+eNXDaeTPTFuLtj+2EzH5rFw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2YcfGpDZszA/njhiVDaEzVdJ+5BNIgDD2RnNx2I+dV89+Klw
	WZxQAN4fkhSeH0p7ZITTXGwMBpKqevSutxr9/ps7fMpjpDA4hEdO4hsEywC1p8s=
X-Google-Smtp-Source: AGHT+IFJjm9aCyo95+9/VI6IL66etpFOV0OLThx3WyZZ7tnWZyAbNEO+PfCso5aAFQN+3KjsS0OA1A==
X-Received: by 2002:a05:6830:6e99:b0:711:c8:1a39 with SMTP id 46e09a7af769-713c7dc1258mr4573597a34.16.1727333743142;
        Wed, 25 Sep 2024 23:55:43 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c73120sm3592352a12.68.2024.09.25.23.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:55:42 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: greentime.hu@sifive.com,
	zong.li@sifive.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Nick Hu <nick.hu@sifive.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 0/3] Support SSTC while PM operations
Date: Thu, 26 Sep 2024 14:54:15 +0800
Message-Id: <20240926065422.226518-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the cpu is going to be hotplug, stop the stimecmp to prevent pending
interrupt.
When the cpu is going to be suspended, save the stimecmp before entering
the suspend state and restore it in the resume path.

changes in v2:
1. Add csr_read/write_hi_lo operations
2. Apply the suggestion from Anup.
link: https://lore.kernel.org/lkml/20240829033904.477200-3-nick.hu@sifive.com/T/#u

Nick Hu (3):
  riscv: Add csr_read/write_hi_lo support
  riscv: Add stimecmp save and restore
  clocksource/drivers/timer-riscv: Stop stimecmp when cpu hotplug

 arch/riscv/include/asm/csr.h      | 22 ++++++++++++++++++++++
 arch/riscv/include/asm/suspend.h  |  1 +
 arch/riscv/kernel/suspend.c       |  6 ++++++
 drivers/clocksource/timer-riscv.c |  6 ++++++
 4 files changed, 35 insertions(+)

-- 
2.34.1


