Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 934F389435
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 23:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfHKVYw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 17:24:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33097 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfHKVYw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 17:24:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id z17so8177943ljz.0;
        Sun, 11 Aug 2019 14:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=etmyJ8NDuEkpkehamLf+URJIlzZFEVYkuu77P3IBsfM=;
        b=XR7JXM2tRUkthQ97FN4JN2D4mChDkusaiD6wyobi9XCGIboYJrAxbszWX9mRFkzY6J
         OMykSerGSKhj8iwqymUuJI0mP5ZS+qhga8iwXBkgT7ZQks5733bBQw71S5p+lJHJJt9r
         y1UbRWghmhb+yUJDt6BJAeGkIzQj2OXUlcIkZj6Afn4bYbTa7IrZPaApCgKFSR4/7jU4
         JbORS/aCiWYMDqqa+8n8mn9NtFm5H8FSfRiHBVZ09QSm9qOd0JRbVCFRTs0xpm7gx52o
         9Ukge/2J3zB92w6+8WH3+5uQqbxfrTGYgeDI83XKFnb2WLpKf8h68T3BOxL7XrvYNjeX
         3CAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=etmyJ8NDuEkpkehamLf+URJIlzZFEVYkuu77P3IBsfM=;
        b=c3EIWqLPl3hcx9Jikn8ecig+91sbfOI2QtTVNUgoqxc7VFIKnTnf+xVDclUhLc4Te6
         Oi9D5kKPjYZHzkW4ReCWwfAEOUiW99s4C9NYii6sf/Qibi81ny89ufsfVY5NBKTy0wx9
         y7d+MaZnflLr5uNqChJfn8qvaRdbQfgTNxFu+LUEGu/gR6IA7Atm2jhiomIIePurbSUn
         l25coB71nfLjA3CNk820g6KUOT+Aek0ib7b6TMdW7b9HLDbWPivlHzgQ/+zMdyvHkKZA
         1AJbO/NkJOUlL/Vdfu8w4y0nzz1yAloKD78MPMNCQskaSxYhji6nMo5fpmyA+N9zm/fL
         k+xQ==
X-Gm-Message-State: APjAAAX3KY4Jd4xfHpYGbeFra2pt0rzi4oXG2Ux815oWR3Z4zhjtrDwo
        ztOV0SAlUUYVx1mGybR9YVU=
X-Google-Smtp-Source: APXvYqzir4uH/KRi6sERHQmP+keyTASgopDNK32wn+9dLri0OfqfQanJ5f5Xu4Hgs627HgAVszizAw==
X-Received: by 2002:a2e:6e0c:: with SMTP id j12mr17251875ljc.123.1565558689810;
        Sun, 11 Aug 2019 14:24:49 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id f1sm20470806ljk.86.2019.08.11.14.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:24:49 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 17/19] PM / devfreq: tegra30: Increase sampling period to 16ms
Date:   Mon, 12 Aug 2019 00:23:13 +0300
Message-Id: <20190811212315.12689-18-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811212315.12689-1-digetx@gmail.com>
References: <20190811212315.12689-1-digetx@gmail.com>
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
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 9753985c9131..8adc0ff48b45 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -69,7 +69,7 @@
  * translates to 2 ^ (K_VAL + 1). ex: 2 ^ (6 + 1) = 128
  */
 #define ACTMON_AVERAGE_WINDOW_LOG2				6
-#define ACTMON_SAMPLING_PERIOD					12 /* ms */
+#define ACTMON_SAMPLING_PERIOD					16 /* ms */
 
 #define KHZ							1000
 
-- 
2.22.0

