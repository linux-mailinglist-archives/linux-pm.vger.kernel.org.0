Return-Path: <linux-pm+bounces-20180-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F324DA0870E
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 06:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85D6A7A02A2
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 05:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855D01C5F2E;
	Fri, 10 Jan 2025 05:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mlOrp77s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74BD746E
	for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2025 05:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488400; cv=none; b=sd3DUryjRWn0Bw4jRLgVCuHS+3dPY5ck3wMicTrjufsZegci2YrM1F6qp7H+l/RcX5DJBcV/8ehNx0cK0MG+XBazwmfe8xbwIF3Ds77xweNNp61kaThDkM82wJpGcT9KxZ5rBhPZsdXroFsAoZlF31oSW8Z+u1jqwokkXEJsqVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488400; c=relaxed/simple;
	bh=vK2RLZhJyKtrTMZpgv3qzR6kVBDayiHTjBgtdxoLPGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DNBFxv4F0PcAQ5KrZ6rJZnVWfXs/xLl8TES57qXXjLLgxkXkEZnhQy/32grja2xo5jKqnQydl9bBrPF27IeinCpJ/1WJHDi7dqk60JVooaCrDDErDLdm9rrDa7PZT7xwCaq0x8diavQb3Kbm3agwmKzZ4/LQWJQ0ijVwF000Zzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mlOrp77s; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21636268e43so34460435ad.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2025 21:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736488398; x=1737093198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RpfUvJ823AF7nAQv9Z8sBjt31QXeF2qFeXHe4EIpNfk=;
        b=mlOrp77sTOFgZaFS3J6BKwYiAvZH0TSL37LYb4sCfV88Zo+DLlz1po1Wg0jur+5Yva
         W6SZlaHGU1uEb0ISZvbAQLtX1j/KClfRjVgS4CrU7Y0yMRf0lkEunJ10tMiR2GcTH1VJ
         4ETGZLK+J1v2M1klHOyEXMZHFQvWefA1uXezOjZ5lHVQWnBAAEgTknrQK9/neavGlWMI
         TGdULjRg5qvivzKZdJD4IBwzQS+re1302TXohcVqilO5S/UH8ExxNrlG9czSEz9GiEg1
         X0gDK2GodvZCbA04ZubHrnC0i3smv6qrAzgOVImDenqcGxUN1Ko14upqKPMYJfO6D/GJ
         S6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736488398; x=1737093198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpfUvJ823AF7nAQv9Z8sBjt31QXeF2qFeXHe4EIpNfk=;
        b=DKUn8nfzxekvYgmUaJe95GGgP9moWHiRVWUSGfrL040tKQKrVzWIB8jqal0ZVyNEVW
         Jvzw2ouIMjdofvypvBEXMDICJoXursEiZj/a9IifkjiUAohzDoksxxl0sAGt2tbH0vJX
         Pm7lgekbhjjs9p/RGFHft1ZW+qzWJPyRYgvcT+yibmqmw/x3qynnPd/92CHJPiTuKxtJ
         cEy6BPJKwzlqW4irkzp8eh2BSjo42JmTaUQxbBOo3ehi2Uxy7YtOXx6P+MS75WiZSwcd
         HPUhEsR6W7/TjIi+9Nr780kooP9HNcWzDGfOvIWnSTg4wLzMhhrjINUVJujRY7+W5YiZ
         J2NQ==
X-Gm-Message-State: AOJu0YyQ5k2Pg306R3O4KoFeub27Faimx93tSCGq+utur1tqRRuVhKdn
	DSvYOoy1kLr8BHJjUxJm0GgT4uXG+0sxok0DTgRa3R71VXOFPj8X56v3i6FobhU=
X-Gm-Gg: ASbGnctfXvA1UFa86DlI0aAmccA3c+pGlw4f7A3ruYy8W7hRhd2bFvC8FwEpLEu/dQ+
	VfOmMR/zy4YElZstjn6cCd0AcGoiD7iyp3iRhz3J169cvztljZ+AcLC3GuwTPVH67Ybn5SIiKON
	+n4OSwfYWZW32P8ffMmKN/O+xhSahLQXHbZI4cAV3RlYrAK/5LaQaFVy1Z0FU39JyyefI/9LFbs
	wSV2UXQZe6bcmuNx+clBLr8P976akZY+qaQEd45pSPPSrBRpWXA1kgEFg0=
X-Google-Smtp-Source: AGHT+IEu3js0Vlx3w+BW55oTn3Hv5RbgFT9xzgGHMv8KvQJ/D+0rGJN+k5S8z+pXaDZZoM7c0YXs4Q==
X-Received: by 2002:a05:6a21:350d:b0:1e1:b105:87b with SMTP id adf61e73a8af0-1e88cfdc0f5mr16073913637.23.1736488398198;
        Thu, 09 Jan 2025 21:53:18 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40658db6sm817092b3a.104.2025.01.09.21.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 21:53:17 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Move endif to the end of Kconfig file
Date: Fri, 10 Jan 2025 11:23:10 +0530
Message-Id: <84ac7a8fa72a8fe20487bb0a350a758bce060965.1736488384.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible to enable few cpufreq drivers, without the framework
being enabled. This happened due to a bug while moving the entries
earlier. Fix it.

Fixes: 7ee1378736f0 ("cpufreq: Move CPPC configs to common Kconfig and add RISC-V")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index ea9afdc119fb..d64b07ec48e5 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -325,8 +325,6 @@ config QORIQ_CPUFREQ
 	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
 	  which are capable of changing the CPU's frequency dynamically.
 
-endif
-
 config ACPI_CPPC_CPUFREQ
 	tristate "CPUFreq driver based on the ACPI CPPC spec"
 	depends on ACPI_PROCESSOR
@@ -355,4 +353,6 @@ config ACPI_CPPC_CPUFREQ_FIE
 
 	  If in doubt, say N.
 
+endif
+
 endmenu
-- 
2.31.1.272.g89b43f80a514


