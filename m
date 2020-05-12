Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651A11CF5AF
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 15:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgELN03 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 09:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbgELN00 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 09:26:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C83FC061A0C
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 06:26:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h17so6487672wrc.8
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OOA2tjrCMzpEGVQ4wsZGsx+qQve4HNZ307qi+80/974=;
        b=tFn1g6VnvjqXPa5wWer0AZBSgCntLE7a3TDJber7TVz1ksZz0vw9pfhNaKabsusts3
         Q4u3+Y5oY5lvmSGLH9CJQ6iSHnMcGwSbDi5N3mV6iaXU3iwtcRge+GOCgHJTPwx0Dunt
         2WFUIUd54IjSQ9oSGEb5gWVJfC/jZJ4qc9HgNV0GYgD+1BXgina5rNgxqjWB/aEYVW5+
         7le4q61yeaatKEThlrAGb+ERtdyhtKTxWq8CMOPXoSKqAyWd9kFZ6ufh5iuxUIRomUzA
         PmDi5o+TmXmttNyl87E1DKIAW4CJtNXTrTnaFSIGPzR94ZZjgoBRGo+8WdBKfJvQHsR5
         byRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OOA2tjrCMzpEGVQ4wsZGsx+qQve4HNZ307qi+80/974=;
        b=O9y49Jd0tCp40wHOjTQuUBlDx7ttesXZbEL09HXUY/YOyYRI2gk0yvc16CgNtNUIBs
         mT5T7q871rwUWZKXuM7fx6S3kA9KVRptN12sVQxSBdUu4pJyO8npbhAxZNvoElFwdXKK
         lUwE14ply48Mfkbuc2IbPFmYgFt82tjVjDslhkyj4HF4lecBzFtDpO7DDP8XEJw9EL/b
         54Vt2fq3O+qg2h+FLd+yTeJvxBXLBDU/rCfosUn8SpCGw9QMfFAZ3Q99hnYfKDOkgBut
         CfroAk3q7IbRv+7EKFXX6ZMEvWtKgaKh7KhOEArqbr6hq09ACmJYpSWqZF13Goy3f+BU
         A2NA==
X-Gm-Message-State: AGi0PuZjllOrNaxYm8UQWoSoGIuqcRau5uNbxD2RRuUYGjNjuyHQKso5
        NAp5Su0HiIsQZ/rfxbKzCnKiPQBLSa/4EQ==
X-Google-Smtp-Source: APiQypLPHEVWduy/3LzWWOhygupngnUuDQ/k1GFsn734lHfe0CkKPw+iJ6B+0gL3o0nrI8H96uujxg==
X-Received: by 2002:a5d:400f:: with SMTP id n15mr13811365wrp.419.1589289984995;
        Tue, 12 May 2020 06:26:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:4460:3fd3:382:4a71])
        by smtp.gmail.com with ESMTPSA id g15sm14441844wro.71.2020.05.12.06.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 06:26:24 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     lee.jones@linaro.org, srinivas.kandagatla@linaro.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] MAINTAINERS: add myself as maintainer for Khadas MCU drivers
Date:   Tue, 12 May 2020 15:26:12 +0200
Message-Id: <20200512132613.31507-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200512132613.31507-1-narmstrong@baylibre.com>
References: <20200512132613.31507-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the HWMON and NVMEM drivers along the MFD drivers and header
as Maintained by myself.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b816a453b10e..609baa78d810 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9431,6 +9431,16 @@ F:	include/linux/kdb.h
 F:	include/linux/kgdb.h
 F:	kernel/debug/
 
+KHADAS MCU MFD DRIVER
+M:	Neil Armstrong <narmstrong@baylibre.com>
+L:	linux-amlogic@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
+F:	drivers/mfd/khadas-mcu.c
+F:	include/linux/mfd/khadas-mcu.h
+F:	drivers/hwmon/khadas-mcu-fan.c
+F:	drivers/nvmem/khadas-mcu-user-mem.c
+
 KMEMLEAK
 M:	Catalin Marinas <catalin.marinas@arm.com>
 S:	Maintained
-- 
2.22.0

