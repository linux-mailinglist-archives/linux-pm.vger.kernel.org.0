Return-Path: <linux-pm+bounces-35676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62398BB3C43
	for <lists+linux-pm@lfdr.de>; Thu, 02 Oct 2025 13:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3AC33A9257
	for <lists+linux-pm@lfdr.de>; Thu,  2 Oct 2025 11:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BA73101BD;
	Thu,  2 Oct 2025 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zfIP2mpK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7DC30FF02
	for <linux-pm@vger.kernel.org>; Thu,  2 Oct 2025 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404853; cv=none; b=E2+aYCMKuQe1PtX0GN6AaFoBydGIjvrbDiJL++4YgrgQQcDEpT/AJd3fwgpGgX9pqr4esvLFG+FITxZe/U0LwNaN4512LccWXKmLaLwBpJ8YTtbm5CqEe5xuNCeROFnY/5nyetGe9pCMyldv18LE3ree6fH/rZUzYlhYwLLLtuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404853; c=relaxed/simple;
	bh=jfsm2ihec0Ij6D1XgluxMV8iWwWlkJpjGypCPVRhAc4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eoc7+2n1l26vmDLMZ04ssoEtgG1b5CTAvAWOKx+7Mpe2k37g1S5mY09IJC7eG6sSQ1wU3PRjDmR7EUN1vBnuGlwvCve5VQYnnrFY+76rQJ1zRf2uaaxgymTrKr2MRlCcHtFGiaDfAwsMTxIaKWlP2NwVPj3oukgXRz837m7vEvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zfIP2mpK; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b07c2924d53so99845866b.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Oct 2025 04:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759404850; x=1760009650; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nsF74hIKs6vv4bMpoGjNhgbv1OkZNlvSZ0wfNAU9kvo=;
        b=zfIP2mpK2sWVGEV82fHhUhvz34cNDeXGN4XUjXTpCyMcvCI/k5TH9GVma8pEhsd+Dp
         /0/heT8RNHbnpC6grX5LzrI9ni1qgBOrSHdq9L6VWf2iHsyz14/irHY9Fq7nij4kTMgD
         FgM/u4iitWrdyyyUbduxbr69buo2MIFHME0/KZ05SKxSVfihLNsf9mPZUAWr+0IhvmMh
         7whvpBd6rKEcCHgqXlIlyivZbinew4N4rKLGUK43Eboae8iMF7JX5ks8lE9GxxtH3J/S
         ahvuMDmLxR4jrrcYb15WHyrSxaJubD+67T+32lq0c9jnZIudrIjhKcHsGN5cxJmT5a1o
         EnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759404850; x=1760009650;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nsF74hIKs6vv4bMpoGjNhgbv1OkZNlvSZ0wfNAU9kvo=;
        b=AzTPGxMaHeo/w7VBvppAARNrIQtSxHNNp48ovbaffb8uhxpGe7d+BYWEecYzfd3OA5
         s+rZPMsaitebL454PxRtJEN6THTrbduWMxyavfZgJpos+j2IzSR/OeXUxv5asNC8+fhC
         uBHUAB7ztyvQ1C7oua/7RVhOOOBe0KGILtO0sNaTfuc7R6rb5cBDTufpLRgUFWiI51ny
         TBjYKMH3p8tTh+1FNbephZt6ysgXUqOmTEfsMP7vCn3jss4w641d0eTVwtDn6+HnyHER
         BTySoPCr6ppgwVRh5DB+k6zdZqeHwPbqo6GHOb1imNKZJz5frUq04tNttp29otczn29k
         n6kA==
X-Forwarded-Encrypted: i=1; AJvYcCUoQJyfLn2wI3l86t+mmM79uvr+FN60rBf9Z73SP8ElKhIIJVnZv4ZFOwaipoVmeY2EhSRmDen7bQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCB/HXY9vyDzA1OOcYfeNQG9r+gM7c/6dUMootkGrRn9ZOwo2r
	HKH1tk0qsVtNU149rFT+zVwczmcJUGI14smsSM0wkUTqUM8jCiq4ApRbkgaOreDpeeXgJDl/IFg
	iWzqqeA==
X-Google-Smtp-Source: AGHT+IHCAit/8YQcXIsfYzBnBeg8HNIVckd9DveCqqDF2kk0znWLWbMaqekiVc5odCp6J9aT9G9xhrXUKSA=
X-Received: from ejcqa31.prod.google.com ([2002:a17:907:869f:b0:b3b:66f0:451b])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:2683:b0:b3c:a161:684c
 with SMTP id a640c23a62f3a-b46e4b8f4d0mr817414866b.2.1759404849866; Thu, 02
 Oct 2025 04:34:09 -0700 (PDT)
Date: Thu,  2 Oct 2025 11:34:01 +0000
In-Reply-To: <20251002113404.3117429-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251002113404.3117429-4-srosek@google.com>
Subject: [PATCH v3 3/6] ACPI: DPTF: Move PCH FIVR device IDs to header
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

The ACPI PCH FIVR device IDs are shared between the DPTF core
and PCH FIVR driver, thus they are moved to the common header.

Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/dptf/dptf_pch_fivr.c   | 8 ++------
 drivers/acpi/dptf/int340x_thermal.c | 7 +------
 drivers/acpi/int340x_thermal.h      | 8 ++++++++
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
index 952216c67d58..cb81636a5d63 100644
--- a/drivers/acpi/dptf/dptf_pch_fivr.c
+++ b/drivers/acpi/dptf/dptf_pch_fivr.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include "../int340x_thermal.h"
 
 struct pch_fivr_resp {
 	u64 status;
@@ -147,12 +148,7 @@ static void pch_fivr_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id pch_fivr_device_ids[] = {
-	{"INTC1045", 0},
-	{"INTC1049", 0},
-	{"INTC1064", 0},
-	{"INTC106B", 0},
-	{"INTC10A3", 0},
-	{"INTC10D7", 0},
+	ACPI_PCH_FIVR_DEVICE_IDS,
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, pch_fivr_device_ids);
diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 43afb6141b98..26522ddfcbaa 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -20,16 +20,11 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	ACPI_INT3404_DEVICE_IDS,
 	ACPI_INT3406_DEVICE_IDS,
 	ACPI_INT3407_DEVICE_IDS,
+	ACPI_PCH_FIVR_DEVICE_IDS,
 	{"INT3408"},
 	{"INT3409"},
 	{"INT340A"},
 	{"INT340B"},
-	{"INTC1045"},
-	{"INTC1049"},
-	{"INTC1064"},
-	{"INTC106B"},
-	{"INTC10A3"},
-	{"INTC10D7"},
 	{"INTC10FF"},
 	{"INTC1102"},
 	{""},
diff --git a/drivers/acpi/int340x_thermal.h b/drivers/acpi/int340x_thermal.h
index 854e4d3bb739..dee53c444a32 100644
--- a/drivers/acpi/int340x_thermal.h
+++ b/drivers/acpi/int340x_thermal.h
@@ -65,4 +65,12 @@
 	{"INTC1100"},	\
 	{"INTC1101"}
 
+#define ACPI_PCH_FIVR_DEVICE_IDS	\
+	{"INTC1045"},	\
+	{"INTC1049"},	\
+	{"INTC1064"},	\
+	{"INTC106B"},	\
+	{"INTC10A3"},	\
+	{"INTC10D7"}
+
 #endif
-- 
2.51.0.618.g983fd99d29-goog


