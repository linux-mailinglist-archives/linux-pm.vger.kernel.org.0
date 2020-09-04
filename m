Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08F325D7CE
	for <lists+linux-pm@lfdr.de>; Fri,  4 Sep 2020 13:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgIDLs6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Sep 2020 07:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbgIDLsz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2020 07:48:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8854DC061245
        for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2020 04:48:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b79so5792210wmb.4
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2020 04:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GC+xI1v+LH6EwCCui2W/bylz3lef9qs2WP5w5Vt2gQk=;
        b=XC3+t30GNQR7ER8LucbrB4H8KErDli+kgNmGVOpcPZeTAIoh4R7GVULyA1GAefC1rA
         iYVp4aj0kXEgCzvNc+7LWpENDQwjVOndNaddaYHuZbi2UpQRnDeBcq96OLf1OlvTWRw7
         cJr9Yk6RUKUM9lpoGONtlaxxlXwQKPs0OM2e3RRfvm1GcG8NdNorGt8zdIFYfn8a0wl4
         TVxZi9T180QNkUdqKOOk3grHclUZL0oHeNSu07pvsKQ+r2IVcHktOuR/mwtr1ypxW/VJ
         RIQG4+SN82jWt4acFG4vC8r8b3iktrYkCnLNfJmwqa4UQZBK08944D78bOJ6L5+kQYO/
         Zhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GC+xI1v+LH6EwCCui2W/bylz3lef9qs2WP5w5Vt2gQk=;
        b=oN4dfk34dCGBs+IGl/7z752qVCxNpjlDNXlZ1yS4ptQ9CwSf0ZQGf0Jk1gZC7r7I3t
         3wb9hklHl+YSWgjzqobjBgsDfDfJZpJ/byRi3XMCAB7EiGsIX5XA5uuKL7fYvm68q1+4
         CJry7DUtPJDq2thti1Ylb4/2M8CcVFw/EC0yrM57W+BePBnPXP6v9cJvciDUZxZCNz3e
         KLh5iLWcF9siyy7/1tvCMmx7jBtFcmaGmVS1I52sv8mpBuPpFJ6mAucyVcKP7IEbO1X0
         y8EK82y//DG9bOFyyx9gjZYVe/BqAvW8GYr9nx39bzDtQLibJmsfCROCnfZDNhbbUShO
         5Nvg==
X-Gm-Message-State: AOAM533+pl6jp+5MyNskpcPPiiv5MyXXCBSOctoc+wSKrc6NYmG304fC
        wndSg0a++c2jTYML0IsU/lm0iA==
X-Google-Smtp-Source: ABdhPJwy4VbJBI0m+gT1IvKW1eTOd1kIDsXiLbKJ1JXltWdN7a4qJUGSVTyqx9anLYZaP8TVx8pPnw==
X-Received: by 2002:a05:600c:2f8f:: with SMTP id t15mr7509311wmn.41.1599220131751;
        Fri, 04 Sep 2020 04:48:51 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r129sm10609714wmr.40.2020.09.04.04.48.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 04:48:51 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [GIT PULL] interconnect fixes for 5.9
Date:   Fri,  4 Sep 2020 14:48:50 +0300
Message-Id: <20200904114850.4306-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Greg,

Here is a small pull request with interconnect fixes for 5.9-rc. Please
take them into char-misc-linus when possible.

Thanks,
Georgi

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.9-rc4

for you to fetch changes up to 91e045b93db79a2ef66e045ad0d1f8f9d348e1f4:

  interconnect: qcom: Fix small BW votes being truncated to zero (2020-09-04 00:07:12 +0300)

----------------------------------------------------------------
interconnect fixes for v5.9

This contains two fixes:
- Fix the core to show correctly the bandwidth for disabled paths.
- Fix a driver to make sure small values are not truncated.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

----------------------------------------------------------------
Matthias Kaehlcke (1):
      interconnect: Show bandwidth for disabled paths as zero in debugfs

Mike Tipton (1):
      interconnect: qcom: Fix small BW votes being truncated to zero

 drivers/interconnect/core.c           | 10 ++-
 drivers/interconnect/qcom/bcm-voter.c | 27 +++++---
 2 files changed, 27 insertions(+), 10 deletions(-)
