Return-Path: <linux-pm+bounces-33454-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F021B3C84C
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 07:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16051C80195
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 05:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879052C21EB;
	Sat, 30 Aug 2025 05:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JQD9o7gX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789351DE8B3
	for <linux-pm@vger.kernel.org>; Sat, 30 Aug 2025 05:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756532077; cv=none; b=WNAnkjUWzLbIJphz8yeePLzU0X+g06+X8KtVVAEGhAKscRwuEjAhqzY7IqOU28EuoZ2A2/a6yxB3B3Xw56wnGY5Wq+Y8xdkxsTz2eXvS1B7vbG6Hv8J+tbgJ/xLMTTsALAkXE6b6LB7vQT0tr7WCeqIr14LD8c2CUiHqj69tMUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756532077; c=relaxed/simple;
	bh=uO/ODjE/zYZVgbm1CU9iXym5pNf0yiWRr0Jb7Ejew9o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OEepORzkp/F282+M4vMxh2RtblstyjwRLU3TWFpJZfTAncYYDv9VZeh7uvfic2wad8PpSjf1wrgd/DIrE9UEdu+b2tldNRn8RyZ4uB7NBF/q68UU9NinA65/qcYTi0DuMg6cHCSOTRxoN77y12bFz9rExPEhuXeIaG8B7k8R8EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JQD9o7gX; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-61d2d2b792aso71956a12.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 22:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756532073; x=1757136873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yg7CRJ0dQKyS1GOrInJ1XjZDl9JOndiYGx9QvzOWypY=;
        b=JQD9o7gXpMWrnz1CQE2zJMTvayxDEvs9QKNoFxY7eUCLXYZL0IyhoW611ZEqdHn3SF
         Y8rq10tI56GNavGlaeFPPwwhto6qbhaPrwV6BvRhKw6xrpxELaY4i/6z1/u0lb8IlSwo
         FdYfk2QqJHUh2xuOFxocqNc5wEalPaDWx/KmPXXN4aSLb5U3DYRxidrJoOTYtCDdu6rV
         hTz7Lo09Ag7ueRrXEL3qHdTrfFGbi2V4P26aBq6jIh1qbEArNtAGsUhSjkAKmIGGvgFT
         cMtdlgaDMI9nZ/dGyaTKgXXYE7BEgIwVuefenjLfVwiqoEBgoOp52Woc0fzZdC22xi+F
         58Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756532073; x=1757136873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yg7CRJ0dQKyS1GOrInJ1XjZDl9JOndiYGx9QvzOWypY=;
        b=RzMtnaElNjAfM1XYqoP2EEHXBUIqNGoaQNw4kgxTjLtnxsPPmb5GyEHbphJwW0WBkz
         t3h5GcCBwVtAlGseg0a1TBv9e2vK07lCYxhLx339YQw2HfCVTbQ7zZcgdD12D/1yBp1C
         i4nUKfdpwcB+8fO6KfYnPUYR8J58p4yEJnbfT9ASqYulLON4xb9kak9d1o0TFSINIbT4
         oRqlZmi8uXhDQcafA+ZG/E+URANIEeyouHlAtsi80Xz0nOsy+y/lDWe20YFkOnjDPkEs
         JC0Fp5FhONpU8pTfyVk6AAjeuxE+jotJ+UzNLF/5YUj82AXilTSLv4aPAB5fVmltZeTf
         htkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyyxgLvV2eD05rKvh14YHV0J6XBBc1ZR/fjQm22dlCPnQPaFzDZYLcMWKyWqO+/j79jzECoqoNIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxRGUwrdoUH7z8JfbZmy6FSz82xD5i3oIQtwOFYJkBcfMhJKCr
	QQc06WXrbv5AEr020FS8xt9/4jaSjyIyxSJBZGHKnMeqZ9oxzfgxLdOUNgQX1RbdsRSUUTM2U7n
	8d25vVg==
X-Google-Smtp-Source: AGHT+IEt/4Q9x3GXVaT8543rG9eCaojjztEKwpl3WFkiLwBvUvkuJUh+sjRu8HQmFq7S5jcqpBu8z9GpTn8=
X-Received: from edeg15.prod.google.com ([2002:a05:6402:564f:b0:61a:56c3:d3d2])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:27ca:b0:61c:5a8c:9a4e
 with SMTP id 4fb4d7f45d1cf-61d2699752fmr748665a12.4.1756532072715; Fri, 29
 Aug 2025 22:34:32 -0700 (PDT)
Date: Sat, 30 Aug 2025 05:34:02 +0000
In-Reply-To: <20250830053404.763995-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250830053404.763995-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250830053404.763995-11-srosek@google.com>
Subject: [PATCH v1 10/12] ACPI: DPTF: Remove not supported INT340X IDs
From: Slawomir Rosek <srosek@google.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, 
	Slawomir Rosek <srosek@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove not supported ACPI INT340X device IDs from scan handler.

Fixes: 3230bbfce8a9 ("ACPI: introduce ACPI int340x thermal scan handler")
Fixes: 9cf45756a4b9 ("ACPI: DPTF: Support for Wildcat Lake")
Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/dptf/int340x_thermal.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 26522ddfcbaa..7d1308b1f513 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -21,12 +21,6 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	ACPI_INT3406_DEVICE_IDS,
 	ACPI_INT3407_DEVICE_IDS,
 	ACPI_PCH_FIVR_DEVICE_IDS,
-	{"INT3408"},
-	{"INT3409"},
-	{"INT340A"},
-	{"INT340B"},
-	{"INTC10FF"},
-	{"INTC1102"},
 	{""},
 };
 
-- 
2.51.0.318.gd7df087d1a-goog


