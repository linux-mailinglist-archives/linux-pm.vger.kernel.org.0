Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67C4D55DAC
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFZBfJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:35:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46767 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfFZBfI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 21:35:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id z15so337846lfh.13;
        Tue, 25 Jun 2019 18:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hh+SuljLT/v5QlJa+5yRN2BFHrXujvc9GV7nQoXJXYE=;
        b=rrYWm0l2KI8Reu+pzKhzQ6HczTjd11xjaGFjRxe1YYbxW/imhDtPF26V72RLcotdTY
         /VK72yuG+yElhPJ/cVnyNxZXVuh1UDDmsbV48jXGh2kK1Fa5OYa8Xk6YRWhTWWhe8m2W
         VtdEdCuA11hyokZ0bpwqYfFP7dHd7CKl+xlOVLZsu9aT87V2uEbjLbHEWzn6sMDM8HPl
         PSjC5XOihYCOPumKFw5ZpmL18w2iJfcf6z0SDZFURaxsPd6TQBPktSMJPX0olrpEGiN0
         BtlO4QwIa6iuUcVUojJgQddSttvwOhB/+hY4dttXMC5AylyzPY/71cdrm/vqBCjuMLIs
         /RZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hh+SuljLT/v5QlJa+5yRN2BFHrXujvc9GV7nQoXJXYE=;
        b=hDMQbfuu4YQbejflZy7wTQUD2jS3aN2qavSlBeABCLJV9XTGQJBxPyCnPbFSJN5bUw
         yGzR5SZne8DFrQJTKe8rU2n4QJokB/9ltE7QTxTcrUfkn9OrhPYiF8BQcuD8iwmjOvhy
         A+21exzhHI0OpLc3XWI84hocAq+n24fjD9buJeeCGRazOsey73q8tuRzRvPbtht0sxwE
         wu/buCTqIx1gLmkYbtNqDOd/1pYjF8ZxSJlYjRvD9P0NF+kHmTU4jD8TbiQt9Q0lnNia
         HEtI4mCzA1FMSBNPmnbSMJDDEX9wpstfJ+NhF5uecghnOt2l6fn/XhCjGXqCC9UB+DUf
         bcoQ==
X-Gm-Message-State: APjAAAUkp3HX3eSOESqYBdNiQExWy3zpLvbbm3EWovamlnA8CFB7tyBj
        5p3UOISgj+jM6LQ0ph/pDgI=
X-Google-Smtp-Source: APXvYqzptMlmHRCdPW5e6i2cUb3i/6SUt3o+QCn8vUXK93Wcf4VMY8ma+L3LcecBpKDyA0OtdGHBEQ==
X-Received: by 2002:ac2:5b0c:: with SMTP id v12mr982808lfn.184.1561512906822;
        Tue, 25 Jun 2019 18:35:06 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id 199sm2549581ljf.44.2019.06.25.18.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 18:35:06 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/17] PM / devfreq: tegra30: Don't enable consecutive-down interrupt on startup
Date:   Wed, 26 Jun 2019 04:32:44 +0300
Message-Id: <20190626013252.30470-11-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190626013252.30470-1-digetx@gmail.com>
References: <20190626013252.30470-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The consecutive-down event tells that we should perform frequency
de-boosting, but boosting is in a reset state on start and hence the
event won't do anything useful for us and it will be just a dummy
interrupt request.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index b36d5d644c6e..1e704289c129 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -556,7 +556,6 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 		<< ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_NUM_SHIFT;
 	val |= ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
-	val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_ENB;
 
-- 
2.22.0

