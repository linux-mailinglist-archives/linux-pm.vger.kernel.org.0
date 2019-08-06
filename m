Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFC5B8322D
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 15:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfHFNFb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 09:05:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34750 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731905AbfHFNFS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2019 09:05:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so87872301wrm.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Aug 2019 06:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=60yWYtJLk0Xp9SLelz+MaI60GmV6Utt18fBkUyG2qxM=;
        b=1XsB9wyPJKfVdt0XFULvvBF/+L4sPvBzqlPsQ3/7818JIn78HG6OJumFYaHF72EZiQ
         3r+tbI6kf2XmvaBnMq6a9/lZ/5papd0jJyFpoUtVL53nadn8VtpgPDafseSrDIuOt+UT
         /EOZC41Tt9sDGPOxzi32bafjR1WXbVk/3gWg/V9UJ5Fpw2N7m9BdV4BU7JOCUi66GVAM
         vOKee9IcLeW4v9gjgMpfseHvCaSfgaOf7oL/xhk/+EpuMxjYaBdClEpCYIIj567dUUTK
         4YsjCLeXbhoLlybPpGffo8skD2wRjyHpahZ2KL35fD/n7RtMFVdx4ePceqC4B4/n3Ofy
         U67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=60yWYtJLk0Xp9SLelz+MaI60GmV6Utt18fBkUyG2qxM=;
        b=pVA7rXY+uD6cAWjPVjqDEVk79p2XkKhVPil7HiJwkk88ibZbEkFV/cf2lfrCoe/g9r
         lvrLGAbtjGRyhCHDCXvOYrh3EUN+QltFpcL1J2z7WZIAJ+HpxylcoOEHHMvcy7WeOQU8
         IYfkevqxlFEdTStvsWP4QdW7ki83SUyaUkIpsjzP/SSQySyyGbRW1gqL3nXZDwX06PwR
         ovJndCTMmXJXBLl0QBBb9R4A1GKGBHywzCdZvOGqa5wpQiq9oHzSAbyn7RAqroDOhE8N
         4mO8ctCg/6FWuNoQzUKck5B71Emt15eC7AmcQxH8DaB+agub93tQ51ikvdvDwOGh2iUc
         oX/g==
X-Gm-Message-State: APjAAAWwY0V7ReNPiYA1RFCdhxxJ2zK2a7eyKpiZJft6KhLi1MP8F4Fh
        DVxcwhQSaaTOKJOeX+p3sy8iYg==
X-Google-Smtp-Source: APXvYqxe8+FVvkyz0LH3/p+5jXQjRtCu1JfWNK+8gB5Jwg7o9KmjpX18AjkaFMctc3YE7l8bagEx+Q==
X-Received: by 2002:adf:dcc6:: with SMTP id x6mr4927209wrm.322.1565096716745;
        Tue, 06 Aug 2019 06:05:16 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j33sm201888738wre.42.2019.08.06.06.05.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 06:05:16 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 6/6] MAINTAINERS: add entry for Amlogic Thermal driver
Date:   Tue,  6 Aug 2019 15:05:06 +0200
Message-Id: <20190806130506.8753-7-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190806130506.8753-1-glaroque@baylibre.com>
References: <20190806130506.8753-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add myself as maintainer for Amlogic Thermal driver.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb2b12f75c37..299f27d11058 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15910,6 +15910,15 @@ F:	Documentation/driver-api/thermal/cpu-cooling-api.rst
 F:	drivers/thermal/cpu_cooling.c
 F:	include/linux/cpu_cooling.h
 
+THERMAL DRIVER FOR AMLOGIC SOCS
+M:	Guillaume La Roque <glaroque@baylibre.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-amlogic@lists.infradead.org
+W:	http://linux-meson.com/
+S:	Supported
+F:	drivers/thermal/amlogic_thermal.c
+F:	Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+
 THINKPAD ACPI EXTRAS DRIVER
 M:	Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>
 L:	ibm-acpi-devel@lists.sourceforge.net
-- 
2.17.1

