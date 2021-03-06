Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4AA32FAD8
	for <lists+linux-pm@lfdr.de>; Sat,  6 Mar 2021 14:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhCFN3b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Mar 2021 08:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhCFN33 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 6 Mar 2021 08:29:29 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E96AC06174A;
        Sat,  6 Mar 2021 05:29:29 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id m6so4164514pfk.1;
        Sat, 06 Mar 2021 05:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ax5gKdgKGbpA9ARYQFz+0Uz3IYFdiqoNAF//dqc3ZNs=;
        b=DE8WpP8lqtbYyqNjtGXWVIGDhJtd2MdX5E/mcHLjLmjYwOJ9exD/zLb7shoCoCeX2+
         yfDwRX6PmgoOMqqi25dHj84kTZryFfvzjeb6oO9ihj1c4pIOao5thqaFi9PUiyWDT63z
         lxUeAN9OPAduSaGaJJkXaheOkcyt6p3jPs0MRDmEvKhdKi7i2c2YxqReZ2PiSFUmlKDD
         7AXVX2kjz4Z/G02Qjuq/j3/nh3AVoqNShfdNZ1/FXo8Oy+as7tNKUb1D7beoq7haWYEK
         6kckM1zHsJBJLvOPpuo/FZ1R3uICwPSN+Qbpk4M4Iiu7WTxMGJnpKjRPW+EfoBu4yU/G
         Ngzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ax5gKdgKGbpA9ARYQFz+0Uz3IYFdiqoNAF//dqc3ZNs=;
        b=Bk3JxTG9s2boWnu37oU4j879HXDLq6Uo2KQJGT1p6Id+eNR0T+Q5KTGEU9qtYh+4+j
         nRfc/lLTjRGYPFNJLFFEdMgvB+1Ci7I9zYbxYaf6H3daN2se8Pf5FjGjrH7TNfp3Z3or
         2joKxwONnJ7HT4FNuoOdWRs2C52UbMGnztW6F6kxOV0p3MAd6LrtMq+7gMaBS5fjE7R6
         v4xw1LE/n5gogo4g0VAw6TE9yBd00Wx9OYvJAvqajXwnB/dpeCd0cGngvgJzdqgTtwU0
         rgG33+8PcF7CqBYrE+FKlKIWwHq9aI2+YBTJprEFYgeHnBr2/NZLQXByIKWqB/98ZpP4
         VaVw==
X-Gm-Message-State: AOAM533PkQ3EkmC0dB1WJWbOghY3ceuItyN1GoR7OOeeWQV548Cwwkvp
        C6yPDt8+YDU/wtJ5MJEmUaI2oM4b1aMKHg==
X-Google-Smtp-Source: ABdhPJwKZHgMDW8YVo3p5gJ5I33Q+dui73J+CrFYI6yUAu3cJbFQRhdm5wvbxf5B4iusYBdbELORBQ==
X-Received: by 2002:aa7:8b59:0:b029:1e9:8229:c100 with SMTP id i25-20020aa78b590000b02901e98229c100mr14049356pfd.19.1615037368873;
        Sat, 06 Mar 2021 05:29:28 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.66])
        by smtp.gmail.com with ESMTPSA id t23sm5222284pgv.34.2021.03.06.05.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 05:29:28 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     djakov@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] interconnect: core: fix error return code of icc_link_destroy()
Date:   Sat,  6 Mar 2021 05:28:57 -0800
Message-Id: <20210306132857.17020-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When krealloc() fails and new is NULL, no error return code of
icc_link_destroy() is assigned.
To fix this bug, ret is assigned with -ENOMEM hen new is NULL.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/interconnect/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 5ad519c9f239..8a1e70e00876 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -942,6 +942,8 @@ int icc_link_destroy(struct icc_node *src, struct icc_node *dst)
 		       GFP_KERNEL);
 	if (new)
 		src->links = new;
+	else
+		ret = -ENOMEM;
 
 out:
 	mutex_unlock(&icc_lock);
-- 
2.17.1

