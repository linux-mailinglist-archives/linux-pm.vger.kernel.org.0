Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0AA9D922E
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 15:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfJPNQa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 09:16:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40216 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfJPNQa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 09:16:30 -0400
Received: by mail-lj1-f193.google.com with SMTP id 7so23985688ljw.7
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 06:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zwcPtwWQF6liVN+zYzdJWAttHhAVvs66PzaVZNVn+cw=;
        b=Dvr+4U2iGye8PwQvS9auZPByIhigKBPwgqTMaVL25rrzhMnxujo74IWXzkz9PvOnrT
         kvZST1KOBOXRVVvfcdQfLqr4zgVA0OGd397GOX6LE93ttKv7Y8TCpf70xk7yCpMUaLOB
         tyUFO6tUmWi9i1drghLKs2arwRbpV6HjcZdKmiq1v0zn2h/sB9RLnC5B/SH8Vr0SYG9V
         p2ziDUB0e3n+wReOMDubHRKJlLSMPz6HZWVaP1Y6UEDLbTKpj45/OkT7GTby3zlilY2j
         I2lGoV5HOVaH+EioMIxr5e5saj2W1f1kPMl566SBDeUCbu44Cel69n1pIdUOJVBOfY/x
         Sl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zwcPtwWQF6liVN+zYzdJWAttHhAVvs66PzaVZNVn+cw=;
        b=YKctAJb4tXkSLj2Yu5BkA4+nzjXioEVnR4wn07TlQdw3uaUlery8KF4qoqNfNX5Be+
         adE0PnYO7NcZ7snlrvQcDuGFGfN98MYV83Onla4jIJZc1BNv/tT7aEsc4n/fkvkMvCtq
         Yhbl/vguBfCsBAGzbZT996bh8+0Prifx+6dc/vf/nnwl7khanQAaMfKCw5H8vusTd0XT
         P/2xjBbtKdXJe9adLYFdvE9ltze8xP3nU8Ul70DnMOZEroyfXwyAsGeKHr1hgX1oc86Z
         6c0FWjfSLFhUzxe3OBd+CsPGbLhUXXnwwT+Y3pxn8sEyKGd1EX8DhuFZm4W/UwPTYz6m
         grqQ==
X-Gm-Message-State: APjAAAVk0zYJ4RME+Ys5XKbd1eDP7mKOjYzdEs2dE6/nwMP/FLO4Qojs
        kxWnAsm7evehWyaTUVm6zP/JnQ==
X-Google-Smtp-Source: APXvYqyoH9MQbW8BVPPDIOi4iBgbLqiYtqm6XR1J9gGq8SXdHH51QB1ilbfdS+SKrh56ecUB0gzTKw==
X-Received: by 2002:a2e:9ec2:: with SMTP id h2mr22570726ljk.85.1571231787847;
        Wed, 16 Oct 2019 06:16:27 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id q19sm10215746lfj.9.2019.10.16.06.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 06:16:27 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>
Subject: [PATCH 2/3] PM / Domains: Implement the ->start() callback for genpd
Date:   Wed, 16 Oct 2019 15:16:24 +0200
Message-Id: <20191016131624.15832-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To allow a subsystem/driver to explicitly start its device from genpd's
point view, let's implement the ->start() callback in the struct
dev_pm_domain that corresponds to the genpd.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index cc85e87eaf05..2adf0661fa3e 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -634,6 +634,13 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 	return ret;
 }
 
+static int genpd_dev_pm_start(struct device *dev)
+{
+	struct generic_pm_domain *genpd = dev_to_genpd(dev);
+
+	return genpd_start_dev(genpd, dev);
+}
+
 static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 				     unsigned long val, void *ptr)
 {
@@ -1805,6 +1812,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->domain.ops.poweroff_noirq = genpd_poweroff_noirq;
 	genpd->domain.ops.restore_noirq = genpd_restore_noirq;
 	genpd->domain.ops.complete = genpd_complete;
+	genpd->domain.start = genpd_dev_pm_start;
 
 	if (genpd->flags & GENPD_FLAG_PM_CLK) {
 		genpd->dev_ops.stop = pm_clk_suspend;
-- 
2.17.1

