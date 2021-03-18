Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32257340A43
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 17:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhCRQeZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 12:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhCRQeT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 12:34:19 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE63C06175F
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 09:34:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k128so1552564wmk.4
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 09:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kViLPayIzTbxglQkxL371XN0XhcsIJnA2OLRA2xSKnE=;
        b=k8s4iMxWWRFOfhW0T5O/8rmbCTxT57UNEWI8YEXdTWfFwYtjCqx/kADhDFBRtoVzxH
         H/+fj6wzaxDlhYLFHZPxbiAIPR58r6Gm8G/ggq7Trl7uX0lAHOXTVKNUofCkUYtAsbVP
         N/C4SmnqqqgGotEBvoRbViXt4FOIlA7xOTxAlqwseynIWNT7NPEqVEmlgX3olRXY197u
         OxxXPV4FcJu/c0/epYFjxMpwU5X1QkSjxytMBEt8+v99+BlE5KbDPOdJB6BFf3N5YCe+
         vYM++6hAVPuC0ZIWPr20bhkK+Ppg8jWWUspyIC7hTqEIpTijRJaocXwPy4IWxEjpVJBq
         KLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kViLPayIzTbxglQkxL371XN0XhcsIJnA2OLRA2xSKnE=;
        b=ZNoK0wKhmzr88U9Dd14ESK/EhXvbf/HuE9VgkjGkPxrZdnKWYdC5np3x9CCPzvxmhm
         Jsq09uOUrj5BZqRKMG98a8eiwnOGralqvABnRSeGfiK7wjPehuPX1wlqz+NKochzD4NA
         v2CxN3NSZgLDkEcGYJQBqdbdJWuIrPB19a0SWswGsuyqELibOQxWDvCYk9pdismWyFQu
         /Tdszt5vveDWYOXMUJFAK/gPnnz2Qauo4BcIanTb2KMIqx0wUq//7OWjLvy/K5Oe4CiX
         8XPjxz92ixLeMeVyIWnGkJGVBU48w2ZkJ1HUJMbauyEAjC9axX87hg5r+pycjhBoMDfo
         SIYQ==
X-Gm-Message-State: AOAM531+/jpM2WJvNBM2NqFEm5oHa0McO5Zd4OLPMlmTn9OnPXpUtDt5
        uIragneyRvl1Fv6hw2wRaRKfUg==
X-Google-Smtp-Source: ABdhPJyqwihllcRbhA+X2mREzMhvfig1gcAECK0o04HRGm/xV1WNpYVzZ+vhGQspE/0FUCpU1zRy0A==
X-Received: by 2002:a1c:bd55:: with SMTP id n82mr30110wmf.3.1616085257360;
        Thu, 18 Mar 2021 09:34:17 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id b15sm3391834wmd.41.2021.03.18.09.34.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Mar 2021 09:34:16 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     djakov@kernel.org
Cc:     linux-pm@vger.kernel.org, georgi.djakov@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: Fix kerneldoc warning
Date:   Thu, 18 Mar 2021 18:34:15 +0200
Message-Id: <20210318163415.30941-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following warning:
drivers/interconnect/bulk.c:63: warning: expecting prototype for
icc_bulk_set(). Prototype was for icc_bulk_set_bw() instead

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/bulk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/bulk.c b/drivers/interconnect/bulk.c
index 73e2c8d0a412..448cc536aa79 100644
--- a/drivers/interconnect/bulk.c
+++ b/drivers/interconnect/bulk.c
@@ -53,7 +53,7 @@ void icc_bulk_put(int num_paths, struct icc_bulk_data *paths)
 EXPORT_SYMBOL_GPL(icc_bulk_put);
 
 /**
- * icc_bulk_set() - set bandwidth to a set of paths
+ * icc_bulk_set_bw() - set bandwidth to a set of paths
  * @num_paths: the number of icc_bulk_data
  * @paths: the icc_bulk_data table containing the paths and bandwidth
  *
