Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFDD34152C
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 06:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbhCSFzQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 01:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbhCSFyt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 01:54:49 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654C2C06174A;
        Thu, 18 Mar 2021 22:54:49 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id g8so4499117qvx.1;
        Thu, 18 Mar 2021 22:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VwMX9qHyqe/3hUjRFKiWWLVIki618AhoFOWNw//mTuU=;
        b=i8Oa8K6OkSLHA5g4XHVYLkSXo1rvydNaumjG832FTk9rT7QxxWnCyM5d7hUTR9oytr
         jcbvjab+bcArWV97qk+iDiBM6lGFmVOgDlzYpG5jW9AJ/617Kak0EVAbUQEMceX0cn8V
         yRRdB6NkSFKPH+XtpprzGLLYpkOwIF3eO4E4qdL8ECwUwagXt9Ys5Dd/C/xtLDimLsa2
         cttVQIxLYgETUKoKZlhfua236om3uhGtlpm8muinS2acyvwVDS46jJf/8T7fM5Aa0GUD
         sGJh9NyeeOnU1imiqD9VUMQAdeSblMsEIOLHWorcS/tnC9EsNgMxVX9YUCQlPyJy4fE3
         pLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VwMX9qHyqe/3hUjRFKiWWLVIki618AhoFOWNw//mTuU=;
        b=tHvBjZDN6gg927EYVswlWLrFExxE03Jk6sM3BcpgVXvj7if1V7T8vzH4cUHjEv9R2E
         zqkEWPj6nrVBrfdW8Cw5ic+p17q2Z7rkp5rnaJmDjJnorLkPZ/jJf7+3wQNYhLBybBWy
         /s83vHe9stZlW9UKPhUXIcvzSXjfz+zbDb5EODF3z1fSRn3/NhoBAKR7bsiwogbgFA6n
         DfoZvOM2A/F6uQT73K+rxtLzo0JaCDBeOcDeDWpB/un6jGuIbOk+YOFGk4+fLygzdkQy
         yiXxlVqj22J4DxJNUnUhONH9KK7SyDBGPv3QCTkt/sfMbSCfxMufTHVt21AQ+AP1C8zQ
         2f9w==
X-Gm-Message-State: AOAM532Do3VBwk45agVx6QVGR2tCnKkFqxnK9OwwcRnK1q/BeBMU12P7
        hfVhGkvq6QtILb7817lSFJg=
X-Google-Smtp-Source: ABdhPJyVk2NfJGiE3UidpHCIsCQuQ6TT446AV4nBhLZcfTyp4noUMUAtxrZWyWv/ByP09JKGDmSlEA==
X-Received: by 2002:ad4:5c87:: with SMTP id o7mr7802073qvh.31.1616133288750;
        Thu, 18 Mar 2021 22:54:48 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.87])
        by smtp.gmail.com with ESMTPSA id j3sm3631294qki.84.2021.03.18.22.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 22:54:48 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] power: supply: charger-manager: Fix a typo
Date:   Fri, 19 Mar 2021 11:22:30 +0530
Message-Id: <20210319055230.32220-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

s/systme/system/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/power/supply/charger-manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 4dea8ecd70bc..45da870aecca 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1604,7 +1604,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 	mutex_unlock(&cm_list_mtx);

 	/*
-	 * Charger-manager is capable of waking up the systme from sleep
+	 * Charger-manager is capable of waking up the system from sleep
 	 * when event is happened through cm_notify_event()
 	 */
 	device_init_wakeup(&pdev->dev, true);
--
2.26.2

