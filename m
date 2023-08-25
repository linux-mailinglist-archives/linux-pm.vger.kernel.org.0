Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9167884E2
	for <lists+linux-pm@lfdr.de>; Fri, 25 Aug 2023 12:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbjHYK02 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Aug 2023 06:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244443AbjHYK0A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Aug 2023 06:26:00 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CC4133;
        Fri, 25 Aug 2023 03:25:58 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b9cd6876bbso206469a34.1;
        Fri, 25 Aug 2023 03:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692959157; x=1693563957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntf6JA+P5dpC/3bqOCAKPhfBurn0ifYQdRA9x9uRYg0=;
        b=ietbD9kxagmUtMnNbFI5lWai+oO/kM6n021A+7tdwSjWIamoYORmgKO+xNYCuV6r0B
         hUI0GeatdKemWWhXVa9paaaHpYBpkABbKeiIdlxAob9Uc7ZXoktcyaY7g9YbCoWmfb0H
         ZuCAUCukKmDWt9hT0ZjJ9RUBODIXhwivIvjdlAfhfJGh4OX0hlK+RitX8797HsTgllsh
         9pTVmUuTv0Uc1eH8rLs4Jc18Q/OFK9p40AAvQg/kiuCBWyVYuzZhq+xDVJ33DRrhDmTL
         K3ktYpqEDIeVRKUOyhVHzsaDhgKbflMuK+5F6SeVxqN7RcJh2QsZ0usjDZRQn8FyYZA+
         6rHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692959157; x=1693563957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntf6JA+P5dpC/3bqOCAKPhfBurn0ifYQdRA9x9uRYg0=;
        b=cS5UKe9LsTevT14KvWHZBh8xhme+O9/gMIWpVgJeBGbwbQsHoVSXZ9RpWOT4MNGhJu
         axCy65IE9zIjpIfCoEJkoL0RaXbVYES11kSCFnSXB828TnUkqPwSBgrL9fUMw5JxD07n
         PbqaafNeNFZAerCLgwyKkHAEyaL+bKcwim3Wp3Sa3JLr9BlYkqWCL4kXFcI5VFnnQRkP
         VGlcfXpoU9dfI+oLlULzliTwTQQPZsYfjKslzJtEeXVG7QsYXAEsiBnb14O/QrolWO0t
         SXfupl9DKJ60sRb6odn5KO/Ad5Fi7B5fKKY4k973azPfd8CIXfCd5TuxMJ5XahUtGbh9
         SzXQ==
X-Gm-Message-State: AOJu0YxDD+OsUxQ+nDdyJYIxCmqhPSRFu6A0QfqOjaLvr0YEUGk42u4l
        zB3Q/H+F0ythfuBcuJkXJLY=
X-Google-Smtp-Source: AGHT+IFEPFQvXpJrczk9dQqXOB4grI+8VhmvADJ0rNgOY96aEWTQCNaPJ4zglYJdJnqTH6ho0F6drQ==
X-Received: by 2002:a05:6870:5688:b0:1a7:f79c:2fbc with SMTP id p8-20020a056870568800b001a7f79c2fbcmr19860993oao.0.1692959157411;
        Fri, 25 Aug 2023 03:25:57 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3d89:37d3:ba11:1a82])
        by smtp.gmail.com with ESMTPSA id eb37-20020a056870a8a500b001bf3942ea12sm835916oab.1.2023.08.25.03.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 03:25:57 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/4] dt-bindings: thermal: Document the values for the 'critical-action'
Date:   Fri, 25 Aug 2023 07:24:51 -0300
Message-Id: <20230825102453.836627-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825102453.836627-1-festevam@gmail.com>
References: <20230825102453.836627-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

Document the possible values for the 'critical-action' property to make
it more readable in the devicetree.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 include/dt-bindings/thermal/thermal.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/thermal/thermal.h b/include/dt-bindings/thermal/thermal.h
index bc7babb1a67c..f433b6b0ffb7 100644
--- a/include/dt-bindings/thermal/thermal.h
+++ b/include/dt-bindings/thermal/thermal.h
@@ -12,5 +12,9 @@
 /* On cooling devices upper and lower limits */
 #define THERMAL_NO_LIMIT		(~0)
 
+/* Possible values for the 'critical-action' property */
+#define THERMAL_CRITICAL_ACTION_SHUTDOWN	0
+#define THERMAL_CRITICAL_ACTION_REBOOT		1
+
 #endif
 
-- 
2.34.1

