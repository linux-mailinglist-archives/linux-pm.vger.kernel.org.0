Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F16441715E
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 13:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244742AbhIXL6c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 07:58:32 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56516
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230238AbhIXL6b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Sep 2021 07:58:31 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2074040783
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 11:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632484618;
        bh=ARyvKwpOwSuiUpVOkf7zpHxJ+2c4Kjgdb/Wzd5PouHw=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=l2gs4VrNMHFhKxiZf+GMstyEsu4hDr9cuVdxOU9a+I4m4Xn5uAEsMpyQFwaW6ivpv
         9ssVE6rO7AoxrNOK9CjV+cYjlqEuBapoTqIyr2y+69NzqrC+A892aPWarOjNdbeK4p
         Q91sT1mXlrN5fGUnO7PcB11wBF+djCAgiwF8/bbCRCyc+QNRnQb8365Iqj20gI4pd4
         Y5/VAWbrlC0Wd0aGg9LV8kyGVxE+TxZthjV7eBGk8xNOb1JigguCeIw3fhZ23zesrz
         g/EmOusn5Yz4WVonztXHCdLAXQBSyVH3prz1y9WqpGWvKMFX7ygrNsxWkwoewn1lve
         R+TVB7B7+GN3Q==
Received: by mail-wr1-f69.google.com with SMTP id l9-20020adfc789000000b00160111fd4e8so7833536wrg.17
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 04:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ARyvKwpOwSuiUpVOkf7zpHxJ+2c4Kjgdb/Wzd5PouHw=;
        b=00h5VbyxpvyAfeUW0l5CFLFy8YVHGqcYe2kH+8ndeDScH0DbdMeWPigVCs0HuCzE/h
         +3nHnbYVSdHfjLOOFKNV+cxzoVQ5R1EoI2vBcwMwsymzTLkNgWjYeCSR//o4bkfC9osP
         nysCSr+rHsSTyWZCfc96vwlCOcbpC6oLRQY7mUG9dJOAZZ2uo9gz3yzdLzVxiYd3wUex
         VQcbq2nkmLC3aCRDiQKV+rtFp0Lh8eLET6slTLQmleaxLglw+KXzXTDMvJGQ3231u5fe
         Cs/Dh5eruI/ltohjFokJBCg5KRW1fbusghnJxvYkCpT3IhtWp1jI7tQmrkrSMNemv3xQ
         AxmA==
X-Gm-Message-State: AOAM531luIUTLlwJP9JqqOcHoxVKzU6zpfTKUR89MRFz5hsVGTuVCnzq
        c7cymylKJZluz3XM2QAABHRv8CLYOZ9bKUUTdgdo3kz9ZDq6IAMFLH0KrbiAJvCWTBW7+7EkgTA
        nYZm7ix3LLpj9YTz8WOhF1h7ExgDGFs5v5NQ0
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr1678068wme.76.1632484617868;
        Fri, 24 Sep 2021 04:56:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAP9ST6zQ1L5728PFPK87ArxIRKDMZ9f48OHvhZiFhPWivfsZH1BiFhMn7AFYmkPN+KMGgIw==
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr1678058wme.76.1632484617722;
        Fri, 24 Sep 2021 04:56:57 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id z17sm8076664wrr.49.2021.09.24.04.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 04:56:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] MAINTAINERS: power: supply: max17042: add entry with reviewers
Date:   Fri, 24 Sep 2021 13:56:18 +0200
Message-Id: <20210924115619.52927-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Maxim max17042 fuel gauge driver supports several devices used on
multiple different boards - both devicetree and ACPI based.  The driver
is incomplete and has few known issues.  Fixing these might break other
platforms so mention recent contributors who can provide feedback.  This
way most of interested parties might help reviewing the patches.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 329d3a0a9fdb..da9d5383af04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11429,6 +11429,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml
 F:	drivers/iio/proximity/mb1232.c
 
+MAXIM MAX17042 FAMILY FUEL GAUGE DRIVERS
+R:	Hans de Goede <hdegoede@redhat.com>
+R:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+R:	Marek Szyprowski <m.szyprowski@samsung.com>
+R:	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+F:	drivers/power/supply/max17042_battery.c
+
 MAXIM MAX77650 PMIC MFD DRIVER
 M:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.30.2

