Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD9E19719D
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgC3BJr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:09:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33862 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbgC3BJr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id p10so16076837ljn.1;
        Sun, 29 Mar 2020 18:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EkjouEeBk5eg2E7LoRsCY9DiuMbRBnrdHMJNPQxQEMg=;
        b=uoReP5o1Wpc4sXErhiwwYzGLqIZG8/HPTnwU7/VbcpDBs0yAOXD5zAtYc5xDmZL1ct
         UuKYJpRsNORBwC3dD+X3wBa1m8tFRMzhZmWJ4z3Rc0eBrZhJ12T25VLwdECwkkKTHpTP
         t35MNKIgHpLxPZAP0v8t9xEval1hNjGLep9oSnUp+WEsTqo3QWL+3qc1rn/tvGRi9IUO
         0ShuXp9UEK8Dn0YFEW+wn5CZLvlkkxtD6nr09356ror89nA8ngq22tQkpAR/48R88sY6
         rDYWrkNZbCJVkZbcjZ42l3Yka9hlLd33sO+pONmsjcbbEBT+NyCKwDos3/c5Tae10v3v
         gZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EkjouEeBk5eg2E7LoRsCY9DiuMbRBnrdHMJNPQxQEMg=;
        b=i6hdEVukkGSZCiQ28xbB5e2ycqBPgDsTN448w9DiPUOslo7Ox1VRXUJRC/Wxr5BtAJ
         MeDBNEeSSR3UwkTjPjuzzIUDOFsISfnjrytt45neob7d/mnsHe9EzyouekxVJ5S0erHz
         bcIxld1e7VTo/HxqvmGwsCZhzqJQZdOowggeY2BIiJBf1L2EmYWCoDvw9reKIWv9VTvE
         Hy1kNZoHSsPKcih686vqS5x0eWa6tn9v/wOtZtIW7k1eN+xWGDIW3emRiL3H85bEVmwA
         /ObevN9tHJsyEIlsfmyR+YaXc33T1uHExYNIgmUqJtkhcqj/kMG2/zlNhZ+CVnvJPgQv
         NSUA==
X-Gm-Message-State: AGi0PuajMxTSMmju7pKzspM58s6wRdT/35T6htxl6zDCM/k+MtdEHdNn
        bKI4AriSfOlPtbjMVfdBh8nPGt5O
X-Google-Smtp-Source: APiQypIZbS8q+NVKU2VHe5+16UUjZNBYbRLaViehODNF6YSe90cPCBqkF1gsWjim+Yl2LvdHvEowig==
X-Received: by 2002:a2e:a412:: with SMTP id p18mr5826456ljn.39.1585530584794;
        Sun, 29 Mar 2020 18:09:44 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 10/22] interconnect: Relax requirement in of_icc_get_from_provider()
Date:   Mon, 30 Mar 2020 04:08:52 +0300
Message-Id: <20200330010904.27643-11-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330010904.27643-1-digetx@gmail.com>
References: <20200330010904.27643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artur Świgoń <a.swigon@samsung.com>

This patch relaxes the condition in of_icc_get_from_provider() so that it
is no longer required to set #interconnect-cells = <1> in the DT. In case
of the devfreq driver for exynos-bus, #interconnect-cells is always zero.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
[digetx@gmail.com: added cells_num checking for of_icc_xlate_onecell()]
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/interconnect/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 2c6515e3ecf1..7d09656734c1 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -335,7 +335,7 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
 	struct icc_provider *provider;
 
-	if (!spec || spec->args_count != 1)
+	if (!spec)
 		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&icc_lock);
@@ -851,6 +851,15 @@ EXPORT_SYMBOL_GPL(icc_nodes_remove);
  */
 int icc_provider_add(struct icc_provider *provider)
 {
+	struct device_node *np = provider->dev->of_node;
+	u32 cells_num;
+	int err;
+
+	err = of_property_read_u32(np, "#interconnect-cells", &cells_num);
+	if (WARN_ON(err))
+		return err;
+	if (WARN_ON(provider->xlate == of_icc_xlate_onecell && cells_num != 1))
+		return -EINVAL;
 	if (WARN_ON(!provider->set))
 		return -EINVAL;
 	if (WARN_ON(!provider->xlate))
-- 
2.25.1

