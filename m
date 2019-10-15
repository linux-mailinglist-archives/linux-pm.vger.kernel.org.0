Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB62D7B38
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 18:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387965AbfJOQXT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 12:23:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55796 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387951AbfJOQXR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 12:23:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id a6so21529426wma.5
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2019 09:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=02ptUi820rtgb1rVywdXHHVh+A6FBo6gb2V5cVn00l4=;
        b=MtpXMuoLIGOHdIDmPktqqAnPBBGdTjagnzKbds+7qPmfpcLGCESELR2gYmKw+dAlsH
         GALZyOdhrfBMu5kJ+9Xdwc10r7YixnzgTtoEN+sXwjbniUhbJe7QvOO/aAIzGpPEh7wf
         tfCJUfOOWUzVdJeNCG6CFQB8dEnEzKFW+8j2U5xtaG1G3ZhP43Ie0qhZ8IVGsF0AXBnv
         DMOWQaRx3fOEAAcptWX7okOpspg4CH1Ta5qXiMV2qqrxphCM/NqNvepzLTjUnEvCyNA1
         1AfGvqLU5KqSe4tJuDyCVpvjoNHpQNhZx5ieCd6JnQGy7BJrhwx+i3RBcBCT1IEoLoes
         Zqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=02ptUi820rtgb1rVywdXHHVh+A6FBo6gb2V5cVn00l4=;
        b=Gn9tUVNBM0KG5JcR5G4gBTAp1DPgbOKO2358VdV/+Teuqd6YiQkSnlOTnR2K81eTV2
         mdYuUxCt722qH519H7WMr+aCVgkpjvU3PQtrUcdSMAbQmmtTHs2yNXN/clz6Whk1Qdvu
         McJCPyQu0bumgspw14r35azaVRQ4/KEFc0+uRUPxjUU85hAzbYz+tAkSNjBKH3qGayP4
         ERuHbOgdmUBmWiMhNtrmOaFw6k49IAWx45FokpuUHu0s5tEIIpzs7lgd3curjrGkn7Cu
         JbkJhTKiOacZ7YcSGOXhUwxTw5V6Ti5k4H7kPCY3x5o5Y2fycPVXeGAvH8DtcsoYs2i1
         oz8g==
X-Gm-Message-State: APjAAAX8FbB05QsZIeNwvDdFhOJDo/zLrDhYadQD0VZgtQFg7P8k0uX7
        cXft53Lufir/u2Z6hsIE/HXwow==
X-Google-Smtp-Source: APXvYqyezfzjgdEUemMJTrQBNb59P7iN2VRfn6C43WnRKbQCCmslDGhSYjUP8u7dsDPSEr9csaBvYw==
X-Received: by 2002:a1c:e08a:: with SMTP id x132mr19703933wmg.155.1571156593871;
        Tue, 15 Oct 2019 09:23:13 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id x129sm41427605wmg.8.2019.10.15.09.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 09:23:13 -0700 (PDT)
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
Subject: [PATCH v2 6/6] MAINTAINERS: update the list of maintained files for max77650
Date:   Tue, 15 Oct 2019 18:23:00 +0200
Message-Id: <20191015162300.22024-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015162300.22024-1-brgl@bgdev.pl>
References: <20191015162300.22024-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The DT bindings for MAX77650 MFD have now been converted to YAML.
Update the MAINTAINERS entry for this set of drivers.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a69e6db80c79..c05e6fd6aedb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9903,8 +9903,8 @@ MAXIM MAX77650 PMIC MFD DRIVER
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

