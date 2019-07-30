Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B98C7B1B7
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 20:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfG3SQI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 14:16:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47032 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbfG3SQH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 14:16:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id k189so11432373pgk.13
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2019 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aSRdspc9UmTVqUtM/LVhQfTdfVvsFdhNYRk7pu3nDM4=;
        b=LtjcNupM/HRKM4JoaldcQRTyS2bM2yL9wvKeOG/reX4s7oliVrhZ3wp4wzfzbR4jpA
         A1CKU4sjWJkHVuwwi/hdtmK5ZPXBxh2NJotGUASyjHj8HoyAh2bkC1ois2SudhmvMElY
         Y3kLvEzuSI7mA8c4hRjPsl+5oO787lm80ulgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aSRdspc9UmTVqUtM/LVhQfTdfVvsFdhNYRk7pu3nDM4=;
        b=Iiy9ihvujUpwpbTQnsETMJxmtAtOHWfcZnYuMT2akOiwgmqa7sdkq+cGEhmRRR64ng
         M+O//wNFbbmvS/9mzs5WzoqUB37rsifI+Iwkm+DjypbCfU3gJz58nUo9wOrrDrFV5hZ1
         qLOl74xYsnlSJG04PkpE64XQWEImycww51/elfSmtwgKNd5PvXPNR/8QnwjioUPtNWUo
         mQyvzQdMNNq/6FSsyuvvm/E9MdOnfA7Vv/8FWh6ZuzhH8aTOOLehAXYKdaz0dhBwq1NJ
         CwB1HXjISvoO0GGPBFKGg/qN3AjAoJ6R8CEUq9E5/EVxpxTzBQNWr+flDcY/NDPTQQM2
         EB2A==
X-Gm-Message-State: APjAAAW4G1Lzq/3gwmy0cuACeCNg+mQfWZ7E159iKzJbHMnf3Qz8/sGo
        WO88A0HTJNSdC3Bh8haRnR1LMw==
X-Google-Smtp-Source: APXvYqzl9TiZn1sx5mDRdicXU56NYnmqpjlBsgZoexEMD31JECB2BpobzlnsLFpDz+nGfBgNtl06Yw==
X-Received: by 2002:a65:57ca:: with SMTP id q10mr113397707pgr.52.1564510566934;
        Tue, 30 Jul 2019 11:16:06 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:06 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 09/57] devfreq: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:09 -0700
Message-Id: <20190730181557.90391-10-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/devfreq/tegra-devfreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 35c38aad8b4f..ffd17aba7533 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -674,10 +674,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	platform_set_drvdata(pdev, tegra);
 
-- 
Sent by a computer through tubes

