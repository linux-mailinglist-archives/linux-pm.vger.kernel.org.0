Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8B4146FB1
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 18:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgAWRaI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jan 2020 12:30:08 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44838 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgAWRaI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2020 12:30:08 -0500
Received: by mail-lf1-f66.google.com with SMTP id v201so2897786lfa.11;
        Thu, 23 Jan 2020 09:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=biNgWadq5TqNu1DhgNYk+76jxCQnnKZxQCgzQcvk4WE=;
        b=ho+cihvvm5qGd6cjf/bQfza0S/NPQnWeisIquDz2V5IYXaByfiEr1ppYLo1ABhYrKQ
         Dtk61QxO8gdmUKuN6MJ1LrK5WcRp1pRm/iLklK7H+NwzlUlU/QbQqZvIFaR8Wxrds9/A
         xatkgomlGvtSwJj+L0JBKoFG1CyQXdQw75N/SkdYw0CAjwPZzpHpAD9ELNNP4kZxl/I7
         844zNpQidde5KD9VQaKM3UvJ7RbKxw1f0ootpKo8PYtnkALnraiH3aWrV+y3f7Nx7sh3
         pwsU67k1CgOFiMNaTiAsPDoBx0GBKSGMQbU/jjwPQjwFPyHglrJnZUyx6RizfuKR3WO3
         WoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=biNgWadq5TqNu1DhgNYk+76jxCQnnKZxQCgzQcvk4WE=;
        b=YJ/HvN9Qj19fGHKFsHAYHKeX6bIDvoluJpWkVMgNyBjLVxh1O6jNkLuczcPOwgOt57
         2vCI2ZGhOxGnVXziiwZdCQCCROftISfx915RrEVQD2wTa/KqohxbURin4kvOJEywWg0H
         kvmJ3qaZ+++GqQ/qTNP1AYP0W73o/LfpjPayMpapZW+8OkfrCr/gvMTeMgG9nASI5W5y
         7WoJbVLAZz/tVmYUMgL/lER00eGgQO48f9MWVPzi4G/rgA+vCrddhOwIgfCT9Nnuojku
         W5vejLG+030NnMLnaqGTmnXqgeaOxGWdI8uhSvlaIcoX3WJhivvCVx0THxDNK5C2fdQr
         rsIA==
X-Gm-Message-State: APjAAAXedRwK5WMT2Vm1qYNbmn/ei4NNiQUJ+gYXfuK94gTF921th2bW
        n9a/pL69HFhiN5Qpmgor5rA=
X-Google-Smtp-Source: APXvYqyjvoR3stvPeCsW0baWBvB7O0BZozH/ovWybts0IXpKTrVH9LTL/4U8blSxm34xEpLH1MoepA==
X-Received: by 2002:ac2:5f59:: with SMTP id 25mr5144118lfz.193.1579800605911;
        Thu, 23 Jan 2020 09:30:05 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id l8sm1609332ljh.65.2020.01.23.09.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 09:30:05 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] PM / devfreq: Replace strncpy with strscpy
Date:   Thu, 23 Jan 2020 20:28:08 +0300
Message-Id: <20200123172808.5316-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

GCC produces this warning when kernel compiled using `make W=1`:

  warning: ‘strncpy’ specified bound 16 equals destination size [-Wstringop-truncation]
  772 |  strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);

The strncpy doesn't take care of NULL-termination of the destination
buffer, while the strscpy does.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index cceee8bc3c2f..f24d226f65c6 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -769,7 +769,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->dev.release = devfreq_dev_release;
 	INIT_LIST_HEAD(&devfreq->node);
 	devfreq->profile = profile;
-	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
+	strscpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
 	devfreq->previous_freq = profile->initial_freq;
 	devfreq->last_status.current_frequency = profile->initial_freq;
 	devfreq->data = data;
-- 
2.24.0

