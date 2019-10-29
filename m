Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1DD1E92B0
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfJ2WHD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:07:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44381 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbfJ2WGY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 18:06:24 -0400
Received: by mail-lf1-f67.google.com with SMTP id v4so8292003lfd.11;
        Tue, 29 Oct 2019 15:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5qAiDuX2tr8Je8Vo0BM4vOmpULUVfESd21buoKSOXDQ=;
        b=Ol7lmEfcLPW59ep9bb3Oq2znELvwbgViUyz/FAgHdp9AHFltLwSXrUN7XlWNuZcwkw
         sKnEJj2DhsYQJjMXNBIK0ZpwQLhB1n+/01XEW0uKAPN/1j6yMKntsnLMee9dQSppDER1
         9wihrn8Fs6UQP3yEVKEoMGrbQgK1jgaA0Y2WOU686G0du63pD1JyfeRktIoKrF9ajnss
         iJcmlnl+Qiqc1gdoqziAp7CYkT4a3OaotNLaka/8HUG2KX03hudLDHFF08IEoHt7R26P
         +6smiW+Pm4ur3bPF+QtVgciwSYJsQDUQgPaneH+vWyxGcOeYpzs6xxpvRIelzYN+3shO
         g9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5qAiDuX2tr8Je8Vo0BM4vOmpULUVfESd21buoKSOXDQ=;
        b=gKngIwM9Aa2VjtVxyiO3dPzMkcqoQ+f5023TGa4MhpVwvCAogh4VVYptzmztIOunJj
         UfseD0HI9QmE1bH+etoApcOX5OjRFGKGST+PLjVeA0YycTl3CIVC8gvbAj8m19wc+luK
         ULuR9NUwnlR0bbBmMIK9BjlEpyHRd5x4T4Hdjuml5QO5MlXI35wBrns7zmpf21eZarj7
         hwwreiOtRFdfdkKjShlqwIVafBkFIFbYJGcv87IOKHNkZ3oO8px9luTvRpOwTjLq9CXL
         v58WHVH+WQtL0f75t3sp1fKr2I34F1fDk+H7AICq6czCmGP5Ed1HXIgTBt67AI9NYN0n
         xBqQ==
X-Gm-Message-State: APjAAAVEJUdOmPTa8w4vzlIhiGNkomxeGboAj3dxggUH7N5CS+o/iv6+
        X2zsEWuNjod8PvFRJLd/NUs=
X-Google-Smtp-Source: APXvYqxkJCdL+P1WvBWJ5HU7cH4v8GOUnak3AKeag1L6SH34bgoN7jzTGQooONnXlvZMICPvFfBkzw==
X-Received: by 2002:a19:651b:: with SMTP id z27mr3781047lfb.117.1572386782566;
        Tue, 29 Oct 2019 15:06:22 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 12sm51536lje.92.2019.10.29.15.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:06:22 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 13/19] PM / devfreq: tegra30: Increase sampling period to 16ms
Date:   Wed, 30 Oct 2019 01:00:13 +0300
Message-Id: <20191029220019.26773-14-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029220019.26773-1-digetx@gmail.com>
References: <20191029220019.26773-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Increase sampling period by 4ms to get a nicer pow2 value, converting
diving into shifts in the code. That's more preferable for Tegra30 that
doesn't have hardware divider instructions because of older Cortex-A9 CPU.
In a result boosting events are delayed by 4ms, which is not sensible in
practice at all.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 9da62f695859..9cbee82880ff 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -67,7 +67,7 @@
  * translates to 2 ^ (K_VAL + 1). ex: 2 ^ (6 + 1) = 128
  */
 #define ACTMON_AVERAGE_WINDOW_LOG2			6
-#define ACTMON_SAMPLING_PERIOD				12 /* ms */
+#define ACTMON_SAMPLING_PERIOD				16 /* ms */
 #define ACTMON_DEFAULT_AVG_BAND				6  /* 1/10 of % */
 
 #define KHZ							1000
-- 
2.23.0

