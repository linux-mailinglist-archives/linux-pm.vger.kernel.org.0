Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A03AAA621B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 09:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfICHA0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Sep 2019 03:00:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42792 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfICHA0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Sep 2019 03:00:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id p3so8580233pgb.9
        for <linux-pm@vger.kernel.org>; Tue, 03 Sep 2019 00:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a26K1G4II4kSTCpPaGf8xIGxYORQ0ipUth+fFd+YiK8=;
        b=UPU7L+KPhHP8odNhmO413net+8H+PjG3HBOL/x+TlXWTBUfqXIFOLxkNVDYSLJ2XLe
         k9CtHzOGplSirS4CWcPWtl842R/pPk47Eop6wdsFo4tN1YtN3GJAZLlVR/fZYhF2EQe5
         p6tuFG2kTLwUv2RGrYI5KUNKLA2OGq9RhwJdUPsO75BHOU/1VVqp2+JHXBuFskppDtTb
         PqRtJF0EHcewXECVEwFz14qPujJgvMSCAc0VEIYb8oW8Uya94HLV3S8J2nhymFrGPd7k
         5uz187MHG68fKQRwD8q1XQEUZ0EEGwVFqS1SWgmrXpEvrSMWIbOM0dRM4rypz/N2QO+7
         fKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a26K1G4II4kSTCpPaGf8xIGxYORQ0ipUth+fFd+YiK8=;
        b=UcJDj6fb0BKOxupKQFlCVaEZOZVPxKfNUGxBuE8S4Df6sXVoA/JHJ5KjUwF/sj3dEK
         GPReosrsW7m5IeLcB0zdP6tWVTA61nn4QNYCeel+QlcnIsQAW8PBU9U3ptFK1CrXPa2i
         snxAEMIDBA5pGaxFpH/WT6AX3Hs+z35EIoWgnVvLZXBycUcYG1hFjhtVK2Zmf8saFc6v
         yLXB2stZy4OrW+KozqivWB6Gq/mDM3IF5Ky52nbO4HUF1z5Am7P3xOrTeOAWU4XbGiwT
         DDxjahzrFOKZ9pgzjzwsQwzM3eyPLULmzY13A7RgMT2kbif5eVTu7vs99fKY8BJ1TVZF
         oR4g==
X-Gm-Message-State: APjAAAXzZoiKPvlPEM3MhAnfY0Z1kzpDiozlsZ/zzT/k1IyORT8LYn+R
        0K28TgNlSmfd0nA0M2OhP+RQSg==
X-Google-Smtp-Source: APXvYqymysOYUOCz8E4NKrZC4xIqdnSdzUBf34OpeOICcOfXYKfVlxK0NwEJqCB3TAzP2fUb9Xdx0g==
X-Received: by 2002:a17:90a:32c8:: with SMTP id l66mr16676286pjb.44.1567494025517;
        Tue, 03 Sep 2019 00:00:25 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id t12sm13376138pfe.58.2019.09.03.00.00.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Sep 2019 00:00:25 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     stable@vger.kernel.org, sre@kernel.org
Cc:     david@lechnology.com, linux-pm@vger.kernel.org, arnd@arndb.de,
        baolin.wang@linaro.org, orsonzhai@gmail.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.14.y 6/8] power: supply: sysfs: ratelimit property read error message
Date:   Tue,  3 Sep 2019 14:59:59 +0800
Message-Id: <582e968f59d6ece6de33c3e4f3d65c5e4a198fa1.1567492316.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1567492316.git.baolin.wang@linaro.org>
References: <cover.1567492316.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: David Lechner <david@lechnology.com>

This adds rate limiting to the message that is printed when reading a
power supply property via sysfs returns an error. This will prevent
userspace applications from unintentionally dDOSing the system by
continuously reading a property that returns an error.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/power_supply_sysfs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index eb5dc74..2ccaf4f 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -91,7 +91,8 @@ static ssize_t power_supply_show_property(struct device *dev,
 				dev_dbg(dev, "driver has no data for `%s' property\n",
 					attr->attr.name);
 			else if (ret != -ENODEV && ret != -EAGAIN)
-				dev_err(dev, "driver failed to report `%s' property: %zd\n",
+				dev_err_ratelimited(dev,
+					"driver failed to report `%s' property: %zd\n",
 					attr->attr.name, ret);
 			return ret;
 		}
-- 
1.7.9.5

