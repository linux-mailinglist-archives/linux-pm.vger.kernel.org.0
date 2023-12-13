Return-Path: <linux-pm+bounces-1056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0112981100F
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 12:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A141C20A96
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 11:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FEF24203;
	Wed, 13 Dec 2023 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IoLGYe6K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFD8116
	for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 03:33:10 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c9f7fe6623so85968551fa.3
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 03:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702467189; x=1703071989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=htZ0z29JSHaeYwcbtg65xi6QGYr+mWu8yuJLXo0qg0Q=;
        b=IoLGYe6KP+b9LGA1FczNmeVY4HD+Dx7R3PSP5fAMjc4EjROy12r8QCCGNmCKTyjQ4W
         Z2z+hpQnjysSWA+aefCWLEOP4rC15S2VwU5K4ZMjwWHu0JJ+JItXHfd+9JnBSyYLwchc
         rFHfirWWB7Mo2M4DTdQqSR4BBlKmVmNN+I0CFLV9eWDI44pl3Z8872DB2Xk8ACveo0LN
         eRTN6K8A5HLW6Gnqylzg5DNcpUwQZ0YDF8kCCIoxT1IUREjv7j49hJqQK/3fymF0mvY1
         0m37VEXKGebJlEDy2vz71bZ3lbPFTQu1kSN7CR1dsB5F37HotBaiFnxwE08lrVdA2+sM
         bV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702467189; x=1703071989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htZ0z29JSHaeYwcbtg65xi6QGYr+mWu8yuJLXo0qg0Q=;
        b=p+DtKjTzr0EX6sINRWQHKA6SC2LGwXhIMxZ5EbAuvnYUIkxmx3WtSDkbQRSJS8Vryz
         88UWP0RW50MXe4c7PpHufspKIynaZksV9wfTXoQE9ilhSWYAbF6JLe8wUyunb4t9bTRM
         KdU8/YtST6hTmslcHOxXzlN/QiKU24mNDoxYEvzwj2zU7/3YNxy6+mgCeuyH4WUJ4MgM
         HPtMINxF8DzyZZDhOc/MG4+vMbCdxKXPAAS0jATJyJJxcGunJzv5OaNc5QrahtJpKab4
         I514UAooAmZyZrc2rRxO2OJYLsp09pm+nC0/x7fh1dHPfHBTUbdXPKfOBW+WoGlMersN
         w8Lg==
X-Gm-Message-State: AOJu0YwamWQfqyOv+KlZgCE9x/C942/H5oS26+p4r/z4IDfkuLGUkq+N
	JxgxzAaa10dKTCy+2ZpCnKG/fA==
X-Google-Smtp-Source: AGHT+IEYU8QnX1qYGV0hcMy23DhWt+J8l2mgG2U1R7ZB+WwMmxmp0UT250v/mB4bMySh4QlUHetkoA==
X-Received: by 2002:a05:6512:368d:b0:50b:ec26:7c56 with SMTP id d13-20020a056512368d00b0050bec267c56mr2054856lfs.50.1702467188879;
        Wed, 13 Dec 2023 03:33:08 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id fc18-20020a056512139200b0050bda0f8835sm1594955lfb.119.2023.12.13.03.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 03:33:08 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PM: domains: Move genpd and its governor to the pmdomain subsystem
Date: Wed, 13 Dec 2023 12:33:05 +0100
Message-Id: <20231213113305.29098-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems reasonable to collect the core parts for the generic PM domain,
along with its corresponding provider drivers. Therefore let's move the
files from drivers/base/power/ to drivers/pmdomain/ and while at it, let's
also rename the files accordingly.

Moreover, let's also update MAINTAINERS to reflect the update.

Cc: Kevin Hilman <khilman@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                                            | 10 +---------
 drivers/base/power/Makefile                            |  1 -
 drivers/pmdomain/Makefile                              |  1 +
 drivers/{base/power/domain.c => pmdomain/core.c}       |  0
 .../power/domain_governor.c => pmdomain/governor.c}    |  0
 5 files changed, 2 insertions(+), 10 deletions(-)
 rename drivers/{base/power/domain.c => pmdomain/core.c} (100%)
 rename drivers/{base/power/domain_governor.c => pmdomain/governor.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea790149af79..ab4b0aed34f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8878,21 +8878,13 @@ F:	Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.yaml
 F:	drivers/i2c/muxes/i2c-demux-pinctrl.c
 
 GENERIC PM DOMAINS
-M:	"Rafael J. Wysocki" <rafael@kernel.org>
-M:	Kevin Hilman <khilman@kernel.org>
 M:	Ulf Hansson <ulf.hansson@linaro.org>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/power/power?domain*
-F:	drivers/base/power/domain*.c
-F:	include/linux/pm_domain.h
-
-GENERIC PM DOMAIN PROVIDERS
-M:	Ulf Hansson <ulf.hansson@linaro.org>
-L:	linux-pm@vger.kernel.org
-S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git
 F:	drivers/pmdomain/
+F:	include/linux/pm_domain.h
 
 GENERIC RADIX TREE
 M:	Kent Overstreet <kent.overstreet@linux.dev>
diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index 8fdd0073eeeb..01f11629d241 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -2,7 +2,6 @@
 obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
 obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o wakeup_stats.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
-obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
 obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
 obj-$(CONFIG_PM_QOS_KUNIT_TEST) += qos-test.o
 
diff --git a/drivers/pmdomain/Makefile b/drivers/pmdomain/Makefile
index f0326b27b30b..a68ece2f4c68 100644
--- a/drivers/pmdomain/Makefile
+++ b/drivers/pmdomain/Makefile
@@ -16,3 +16,4 @@ obj-y					+= sunxi/
 obj-y					+= tegra/
 obj-y					+= ti/
 obj-y					+= xilinx/
+obj-y					+= core.o governor.o
diff --git a/drivers/base/power/domain.c b/drivers/pmdomain/core.c
similarity index 100%
rename from drivers/base/power/domain.c
rename to drivers/pmdomain/core.c
diff --git a/drivers/base/power/domain_governor.c b/drivers/pmdomain/governor.c
similarity index 100%
rename from drivers/base/power/domain_governor.c
rename to drivers/pmdomain/governor.c
-- 
2.34.1


