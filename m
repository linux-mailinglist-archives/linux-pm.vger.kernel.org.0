Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9740010F703
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 06:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfLCFXw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 00:23:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34100 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfLCFXw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 00:23:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id n13so1257429pff.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2019 21:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dPgz2TLGaXm8AZ5IU/e4WWLoSFiMiQO40kFKZ/olifE=;
        b=RlW/Wke8DNfq5+TindW3a7DNLR09DVaesqF1xwIrlU7rF0EUhASXBKcdEv9gChCMzZ
         XYOazRvnQp5BEKikwNaDgdpOXqIZGn3q6lanaKG0VVk49ZOEbdZeDfoipfCq5ELIMQj1
         l+zmNmnCi30CeiFDdCpZFNLjVkhEZwrSF5TTeCJsP86nGSsRgQFi17NQBUwsLWN3lPG4
         XYVktpX4JahsUhum0NFi75QXwlGDhJzOsawFqpujLOvLJB5PyoyN6ODaS4V7T8uSFZTh
         //laIC4A0qj7KfbwbD+XBv++Ues5+BnYRmsODvf/kbCaKBOLc+fIzic6drSvmxvM7SDf
         z2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dPgz2TLGaXm8AZ5IU/e4WWLoSFiMiQO40kFKZ/olifE=;
        b=RTj2g5GHQC7RkKx9tLhSv4Jne3rHZ3sQuWZyBPhaUm12g2X9bU7W7asTm05oEit39d
         IMUP3XPmQKDrlgXnKaeqmhyCuKxGUQmUkS7npWrPnqy4lhymmDxLHkX80g30qderqH2V
         RltF6pJOyKhTveZ1iBe5xwaF34Rulk/XmI9grfdhYokSetNHOAydeeOL1h1oxN1aP+t/
         5oNWG0dJPHGE52x3bkwa6yLdoV+R6138yIub6i3V5cTSSYFgp27BROXlijsMF47oKRpe
         w4+GFbsVt5vOx7rKWAwtqloGFY66wOGOJQhl6Zb6q1gqo7JgHQl2lgBrhJywOm9vnRfB
         tADA==
X-Gm-Message-State: APjAAAUvJgdRd9+Z/1zZURrNdf2H+9MygXNKP8fgF56N5Nbx7lbUjG0w
        23+VX8DQM8W7+Nmv9CiKHRJCFg==
X-Google-Smtp-Source: APXvYqylmspoWJ46AcNlcJaiTcm8u1XOhBNgM1Yg5iDosjeRJVqyvHVAbi4h9+HiQGANGd2ojEB1+A==
X-Received: by 2002:a63:f006:: with SMTP id k6mr3420716pgh.380.1575350631471;
        Mon, 02 Dec 2019 21:23:51 -0800 (PST)
Received: from localhost ([14.96.109.134])
        by smtp.gmail.com with ESMTPSA id f10sm1388888pfd.28.2019.12.02.21.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 21:23:51 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 4/9] drivers: thermal: tsens: Release device in success path
Date:   Tue,  3 Dec 2019 10:53:25 +0530
Message-Id: <b8a2349eb80a4992d386b05fcde9a7a32bf9850b.1575349416.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1575349416.git.amit.kucheria@linaro.org>
References: <cover.1575349416.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1575349416.git.amit.kucheria@linaro.org>
References: <cover.1575349416.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We don't currently call put_device in case of successfully initialising
the device.

Allow control to fall thru so we can use same code to put_device and
return error.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 1cbc5a6e5b4fd..e84e94a6f1a73 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -687,8 +687,6 @@ int __init init_common(struct tsens_priv *priv)
 	tsens_enable_irq(priv);
 	tsens_debug_init(op);
 
-	return 0;
-
 err_put_device:
 	put_device(&op->dev);
 	return ret;
-- 
2.17.1

