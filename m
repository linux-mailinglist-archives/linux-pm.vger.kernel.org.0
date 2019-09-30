Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A354FC2126
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 15:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfI3NDQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 09:03:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53276 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731112AbfI3NDH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 09:03:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so13323128wmd.3
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2019 06:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HrIq4ZVm8xkVZyO8f5Owi3O1Tv53HlREs0EWWL4v/q4=;
        b=w1gNg8prgUP3BwyEHY0icT829DCXzmLYUhxFKoVjRtdaNyQitXh4veJvCPRIsJ1yAa
         EjV8yIaLqywn2OLOjIE1Qiqqlwb35juSylLnUYlGzVFdhIGmVX6UEhYTQ2fTS2s550ug
         +rEmahuc8qfCuv0k9jUnqAVP71g8ErK+jQyWeSZNqOb3wtPyKoNwQ4LtlLVaO2/icP9e
         Y0flzj/3RcC8NaIT8OrfJpYtb1l/UrnuoZrpD0UUN6UBwnj5EAiAAVFjgXjhHLSzMgMA
         nxidQ6CioHKdgup5Do1f2UZjKGdcLsijRVhzgFl1CPphyS5x76IeMjkY9mnL4zLR3avD
         dmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HrIq4ZVm8xkVZyO8f5Owi3O1Tv53HlREs0EWWL4v/q4=;
        b=NKrQ88s2VQk61Iq87RRN5EEKLHRCKwmTAKM/nJltE6hN6DrE/WGXb503Jf/l/r/Zxw
         URNd8ZmqcwFiI94YcbLPtTtxMOk+5ESQaVV3e6Ko00n8J0UI8M8x+IZnb71EviI2+Vxq
         wg2gXpJKxj9arCwcPz8wRwqOaBHI02lXD8WAwMzG0nzscFC4TJMZpSN2mE2jxCuikUlg
         R1uTG9ETQ8zUkXRMhe+0By54ay/6xcpIg2Z5Hx8xl0eLauk5NfOhKRunmqyfsykmdY8/
         5/unK3kRCwmTzDA9Vr6bP19mER2OTflgjFZlwo1F4jntHzBTn91dV6NC9d1yiVrTussJ
         juHA==
X-Gm-Message-State: APjAAAUKXvQBeetWc8hVi4vT3poXrpsR5oU40yRLLMIxWVqwE4aMa86a
        T4DR1etT4Jz+fWk7OWo/cUk4wQ==
X-Google-Smtp-Source: APXvYqzN6+yvym0aDjApdak2rnKhCxj3WgNHI4XeHwFPAGwC+jP/VsGclRBJNsmG4KVSjtE79Djsrg==
X-Received: by 2002:a1c:544e:: with SMTP id p14mr16383235wmi.72.1569848584419;
        Mon, 30 Sep 2019 06:03:04 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id e6sm10654756wrp.91.2019.09.30.06.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 06:03:03 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 6/6] MAINTAINERS: update the list of maintained files for max77650
Date:   Mon, 30 Sep 2019 15:02:46 +0200
Message-Id: <20190930130246.4860-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190930130246.4860-1-brgl@bgdev.pl>
References: <20190930130246.4860-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The DT bindings for max77650 MFD have now been converted to yaml.
Update the MAINTAINERS entry for this set of drivers.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 296de2b51c83..d60dd3729437 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9902,8 +9902,8 @@ MAXIM MAX77650 PMIC MFD DRIVER
 M:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/*/*max77650.txt
-F:	Documentation/devicetree/bindings/*/max77650*.txt
+F:	Documentation/devicetree/bindings/*/*max77650.yaml
+F:	Documentation/devicetree/bindings/*/max77650*.yaml
 F:	include/linux/mfd/max77650.h
 F:	drivers/mfd/max77650.c
 F:	drivers/regulator/max77650-regulator.c
-- 
2.23.0

