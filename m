Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7256C17B
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 21:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfGQT2o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 15:28:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43468 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfGQT2n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 15:28:43 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so47571209ios.10;
        Wed, 17 Jul 2019 12:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WHgmdNdTahHJLMVtZuPGqZpMg+t7cvLI9kSEgTL6Hoc=;
        b=C2Pmx6IniMXlfmCpO6ZSNlEZ/p7i68e11dMcX7VD9qbaYXTebPPCoMYa2c4xILK+MO
         4sGJ27M43TBIzp6u+9MXQk3wputYlYjwPyzD89qF9CkNZvykAGp5kjUsnPILvL0bXLur
         el0YS578T+Zxp/4OeyXvOAFxuKgdMQrn3L3ZBcLsyU2Nx5AA0aQcm74uoQ92Co2wnjr1
         yTjvEBLjtJycmc3i41aMqDCZvI6XhnOmQ2gUNGn28gNfv8jAf8BVN+CmGP7x+4qfPF+h
         K8zL4RDa50bW4D2pZksmMvSko1Ug7JcNt7YcUoZ+bPWClRw2djvQoARF1B/dxOG7N57n
         hmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WHgmdNdTahHJLMVtZuPGqZpMg+t7cvLI9kSEgTL6Hoc=;
        b=XPJsCrYPv9V0MjafztU/YhKFNOT46PREY4JOt9TlmArc5BNA9tyCW7kZeePXniSz8t
         bR+DHF7yIt4MG2bAeY4613OvKd9Ptq6KeBy8/AcR/RlL4aGcvlrD4LTARBzwV/RKJlHS
         Afe7RrpxRdRDPLZtYG8lp9tTIzzxUAm7zaJ2n9w0JBRFURwPIOgxxAQQCDFl/KZGMOV7
         UKVHTQeGEY6gzX/qXapW28bfWRC9/4uDJiXllFgcAXltnDGHXL8EaMIhCgQO6/Z4+k5m
         fk3ui8d7ZAE7GRaIyfzrmh/QQqgdwxInUDfz//wDPBt0hFHF6sjqT0dxTkOQug+1AU56
         6k8Q==
X-Gm-Message-State: APjAAAVX4qH0gjUEroPSbPd7s8gjbCEG5yfGjwyqEPh9ZR+/VtKuezPt
        c7VY9RXja9vyj3FZevZljXs=
X-Google-Smtp-Source: APXvYqx+y7HdX4W/yTvbrWPLGTYpFO+4CtEITlD1gV1KgXOQoOcSgbqo6i06bk9TshbYf//fNRogqw==
X-Received: by 2002:a6b:f203:: with SMTP id q3mr39191375ioh.208.1563391723106;
        Wed, 17 Jul 2019 12:28:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id n7sm18927080ioo.79.2019.07.17.12.28.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 12:28:41 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skunberg.kelsey@gmail.com, bjorn@helgaas.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org, rjw@rjwysocki.net
Subject: [PATCH] thermal: intel: int340x_thermal: Remove unnecessary acpi_has_method() uses
Date:   Wed, 17 Jul 2019 13:26:39 -0600
Message-Id: <20190717192639.90092-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

acpi_evaluate_object() will already return in error if the method does not
exist. Checking if the method is absent before the acpi_evaluate_object()
call is not needed. Remove acpi_has_method() calls to avoid additional
work.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
index 9716bc3abaf9..7130e90773ed 100644
--- a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
+++ b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
@@ -77,9 +77,6 @@ int acpi_parse_trt(acpi_handle handle, int *trt_count, struct trt **trtp,
 	struct acpi_buffer element = { 0, NULL };
 	struct acpi_buffer trt_format = { sizeof("RRNNNNNN"), "RRNNNNNN" };
 
-	if (!acpi_has_method(handle, "_TRT"))
-		return -ENODEV;
-
 	status = acpi_evaluate_object(handle, "_TRT", NULL, &buffer);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
@@ -158,9 +155,6 @@ int acpi_parse_art(acpi_handle handle, int *art_count, struct art **artp,
 	struct acpi_buffer art_format =	{
 		sizeof("RRNNNNNNNNNNN"), "RRNNNNNNNNNNN" };
 
-	if (!acpi_has_method(handle, "_ART"))
-		return -ENODEV;
-
 	status = acpi_evaluate_object(handle, "_ART", NULL, &buffer);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
-- 
2.20.1

