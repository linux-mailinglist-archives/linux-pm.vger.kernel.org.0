Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F21353822
	for <lists+linux-pm@lfdr.de>; Sun,  4 Apr 2021 14:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhDDMyo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Apr 2021 08:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhDDMyn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Apr 2021 08:54:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349B5C061756;
        Sun,  4 Apr 2021 05:54:39 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s11so6583888pfm.1;
        Sun, 04 Apr 2021 05:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3oqOwhJCX0s27Ox3xrRvrMgiNViAP3JTYOAUiH/1rlk=;
        b=bPWFe9t0iinZFEw/jbZRy16fVoJDxis4esCSCSTEDH+5DSS+aYMPyYgijSBohRlIlg
         MD594GCY1K3BIQ75UUSvv1SwGPccKtLH4v4d06rcvEKtle7m2eXUcj3sIheaezGpSkma
         tLDfkrKj86t0bxdThqiJk6j5GxeZ6nd4sKCxFh4RZNz0PHkQC5ceY/00mCDeIc17k8Mr
         4LCeHJtmQlNDm6qt9/uRd9UYhGl/wOqH3UaFiDP1FVkDzw2OAsrZpmsJL0W4tQ3rBwY3
         JcTu2X9bW39Zge+Zpg+NCDMWdDxbWl3fN3GoCPRIlLnYhLPgArJ9mUvksYT4jJgajdgs
         Iixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3oqOwhJCX0s27Ox3xrRvrMgiNViAP3JTYOAUiH/1rlk=;
        b=OB0m8UuN8LuarLE4IGHBXaGutykpf3lFGCXHQ7ZR61AIjgl2V/0GayDNaFjMAu2h6b
         wmcIdXseWeCzqcziE++vKNACSNK+hIB/Fq3ApJispxvkveQJZb2PZzuTQ3AtGba20Bos
         45JkYNQKRBjf6l7aoE4pd90qR541q7Ojf9ZskhxZMkVdSurT70tuKfZavpgFt7ThL0XW
         AuEL2R5QQJqQVJD3Vhf60UDpfZH1/Ay+x1Vb/Q6hJsMkLnio3mqsmRu0Cqh0S4YHeB52
         +VJDVI4BpKMJRNvmwtWptU6lsbUH2QgieMmLdabqjwaHFOYQTHxNBLeAhpDFrmRwD9Zw
         if9A==
X-Gm-Message-State: AOAM533wLlBY4uDq4tNf0kqaPqO09Vxq2SuVwFSAFplfhtW6QRzasUaq
        /mI0BpAV4eKw/KIUBI3XIwM=
X-Google-Smtp-Source: ABdhPJx4CQlpMuKJ8oQRXZq2ZvsTW/x1ic1qPDqbBG/uCPhFCXR7h0xz9jT0lJu21Svjf0GhWuxIKA==
X-Received: by 2002:aa7:9aac:0:b029:21a:d3b4:ac with SMTP id x12-20020aa79aac0000b029021ad3b400acmr19412518pfi.12.1617540878819;
        Sun, 04 Apr 2021 05:54:38 -0700 (PDT)
Received: from localhost.localdomain ([124.108.22.4])
        by smtp.gmail.com with ESMTPSA id y189sm12938819pfy.8.2021.04.04.05.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 05:54:38 -0700 (PDT)
From:   zhuguangqing83@gmail.com
To:     Amit Kucheria <amitk@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Guangqing Zhu <zhuguangqing83@gmail.com>
Subject: [PATCH v2] thermal/drivers/tsens: fix missing put_device error
Date:   Sun,  4 Apr 2021 20:54:31 +0800
Message-Id: <20210404125431.12208-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Guangqing Zhu <zhuguangqing83@gmail.com>

Fixes coccicheck error:

drivers/thermal/qcom/tsens.c:759:4-10: ERROR: missing put_device; call
of_find_device_by_node on line 715, but without a corresponding object
release within this function.

Fixes: a7ff82976122 ("drivers: thermal: tsens: Merge tsens-common.c into
tsens.c")

Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
---
v2:
  - Fix a error(missing a bracket) in v1.

---
 drivers/thermal/qcom/tsens.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index d8ce3a687b80..3c4c0516e58a 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -755,8 +755,10 @@ int __init init_common(struct tsens_priv *priv)
 		for (i = VER_MAJOR; i <= VER_STEP; i++) {
 			priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
 							      priv->fields[i]);
-			if (IS_ERR(priv->rf[i]))
-				return PTR_ERR(priv->rf[i]);
+			if (IS_ERR(priv->rf[i])) {
+				ret = PTR_ERR(priv->rf[i]);
+				goto err_put_device;
+			}
 		}
 		ret = regmap_field_read(priv->rf[VER_MINOR], &ver_minor);
 		if (ret)
-- 
2.17.1

