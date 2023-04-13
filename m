Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62D56E0CF6
	for <lists+linux-pm@lfdr.de>; Thu, 13 Apr 2023 13:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjDMLrQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Apr 2023 07:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjDMLrO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2023 07:47:14 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A569E9771
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 04:47:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k36-20020a05600c1ca400b003f0a7c483feso914313wms.4
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 04:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681386419; x=1683978419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgd1bKrI7tjr//X7ubfNjfbEbuKleNxuvfM0dDIe1Gc=;
        b=fOZw2vqXmpMsIvnANbpE6Yf0UWMjh2+up+0Wd8okyz6mfc2Bl9M7WildNt1NGyW0JT
         qSPskNbOIEslrEeROi/kg/eh7FGlagAmjJmCor9ZbZ/wkzTEvAKJGJ0tI1k9/TmkoXSH
         he/jtW3euAItBayzBXMvBhuIpd4/HQ+9d9AH4QbTbjT+jWq4Z4TcydkuOjps/4yDFZuE
         eJmAlbo6cEFE0H2ob+b6ftMp4lbR6F49Whzq+vvW5O83Fi6h2HKb5bcHGFYuIqi70vhP
         0Afg4Z2E8+JYUCLS2UX6DibdUYyLZKG6OPrvoHxNvSiE083G3lxsVDmGb+J7c4eaWH1G
         03KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681386419; x=1683978419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgd1bKrI7tjr//X7ubfNjfbEbuKleNxuvfM0dDIe1Gc=;
        b=BfdTguMGBlBJzJEnOfiOtICT5rWsWohXnVl5PinMFXpZphU77FDopv0EiMi8KfpYM8
         WAXxNwmlYOLiKyLo8FSuAHRxHXrljKYeSiPu3sZrJNZJzN0i1oX1g6LsUiwlw6o6jhb4
         /Pepo87HQCK58n9WLpxbLy4dD3CALDQYV+WOyftLrhB8EEorBGWulW6XSX00dvLQayTG
         HXzctjJtSEkFRM/C3ELkzSRcPiXpIoAP2nxPkNzmst0uOeCROJwHstSyTakmN9n0oGuf
         IXIJ/5tTikYsmTF7idToJXRiXeDC4CwLGqZ8rILMzKF5BEyhzP/bzDvMq0+0NsOCFmqr
         2GKg==
X-Gm-Message-State: AAQBX9fJE6eOnNmUvF66SJyYcTkiHCnIWNse5ZJxQW4S8VVX6ptKDEYJ
        bgSBnwN+//AFIAnulFb55HBVMw==
X-Google-Smtp-Source: AKy350bTPiuIJ0i8zSXeUqnj7IbwFV93lyOjz6TbBVxB+THSMry1udKD8Mb5YuFclDDP83+MpZkaFA==
X-Received: by 2002:a7b:c8c7:0:b0:3ed:301c:375c with SMTP id f7-20020a7bc8c7000000b003ed301c375cmr1532709wml.21.1681386418943;
        Thu, 13 Apr 2023 04:46:58 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6418:c878:b0e:d11b])
        by smtp.gmail.com with ESMTPSA id iz11-20020a05600c554b00b003f09aaf547asm6730590wmb.1.2023.04.13.04.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:46:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 6/6] thermal/drivers/intel_menlow: Make additionnal sysfs information optional
Date:   Thu, 13 Apr 2023 13:46:47 +0200
Message-Id: <20230413114647.3878792-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413114647.3878792-1-daniel.lezcano@linaro.org>
References: <20230413114647.3878792-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Menlon thermal driver creates specific files in the thermal zone
sysfs class. It is specific to Menlon and these entries look debug
code. It is probable these are not needed.

Let's make the code optional and disable it by default.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/intel/Kconfig        | 11 +++++++++++
 drivers/thermal/intel/intel_menlow.c |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index cb7e7697cf1e..1405d9cd2bab 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -112,6 +112,17 @@ config INTEL_MENLOW
 
 	  If unsure, say N.
 
+config INTEL_MENLOW_SYSFS_ADDON
+       bool "Enable thermal sysfs addon"
+       depends on INTEL_MENLOW
+       def_bool n
+       help
+	 Enable sysfs extra information added in the thermal
+	 zone. This is specific to this driver. By default those are
+	 disabled and are candidate for removal, if you need these
+	 information anyway, enable the option or upgrade the
+	 userspace program using them.
+
 config INTEL_HFI_THERMAL
 	bool "Intel Hardware Feedback Interface"
 	depends on NET
diff --git a/drivers/thermal/intel/intel_menlow.c b/drivers/thermal/intel/intel_menlow.c
index d720add918ff..a169d7e4f537 100644
--- a/drivers/thermal/intel/intel_menlow.c
+++ b/drivers/thermal/intel/intel_menlow.c
@@ -374,6 +374,9 @@ static int intel_menlow_add_one_attribute(char *name, umode_t mode, void *show,
 	struct intel_menlow_attribute *attr;
 	int result;
 
+	if (!IS_ENABLED(CONFIG_INTEL_MENLOW_SYSFS_ADDON))
+		return 0;
+	
 	attr = kzalloc(sizeof(struct intel_menlow_attribute), GFP_KERNEL);
 	if (!attr)
 		return -ENOMEM;
-- 
2.34.1

