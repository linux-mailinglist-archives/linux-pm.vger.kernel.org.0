Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8B2433263
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 11:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhJSJil (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 05:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbhJSJik (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 05:38:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A16EC061749
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 02:36:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id y3so46745064wrl.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 02:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pAQ3nDSi7GJKEkpq93Gk3fW3GifCTB9f+3J4xNuNsa8=;
        b=gP8nU56KZdDX/muBPZFm9b5HoHa1FEeoZNaQ2M517z2vjkHquJFNvDOJ/wxnFuRZmc
         6VEiXjBGNq4woQv9vGa6VmWMg4+aelNiIhZGvrtKs8tMVuO/F2zE7q/+GiEcS94XM2Z8
         tr3k5LODloiPk6Nmx/iMI9cKoOJH3WKCAMso2klC9XoLZ7Nrihxfs03+3KoLxzRkMNHP
         qZuUrzT9di/B3Ht8J8NWeW2s+llj+fySzAGXtW1t84ZyvjmbfyusOGnGosqJqftB2Y4T
         dlNIAEKjZpKNmEP/Tvhkr4ZvQAOlgNK2IKNTeO98tcnmXwoPa9xdhptRLpO9uOvWbOq8
         S98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pAQ3nDSi7GJKEkpq93Gk3fW3GifCTB9f+3J4xNuNsa8=;
        b=CmxZdeE8zQNMKq9UOUT1kgh2V2p5nWmq8CdcJ842Hln2uMJ33w1CWv0hNRHgaYeAhp
         TohRCKMYgRcRJx654u0EhxWD95jTRCHcBC2aL8lpr0AxWoviKaPKfZ5DcyfrFJCJJp5Y
         UW9mZz5GmqEr9Sg2fKxvWjD7WgLC891X3NPutrU2QtcIslZvtV/nCvetBK7fMZupiWbt
         O3JbHFf0hvzKgjhKcmDsF0vrDH+i7tb1VuiiWJEH7EFB2YS3I0WlyLT9a+Q20AtjEKYT
         24qQODE2IUdYOHrYvY9cXrgu7xWs4H/b41zyfadfC9FnyFckvWW8A1f3IS1mYyRxtMyA
         XiqQ==
X-Gm-Message-State: AOAM531BKv5EHEcJEU498ag0xHnV1fQKqXkf68fQkqD9bNneBFpiQFP7
        AoqEv92VvwSpCr45AdcSub1ugw==
X-Google-Smtp-Source: ABdhPJxOQXjEw6eiRtOB4dRH95sLoz/UAgvA3+DT3VX0bWePwEQwNePyd24CoSoDt1rFoxL8eXWmIA==
X-Received: by 2002:a5d:6e8d:: with SMTP id k13mr42883919wrz.295.1634636186755;
        Tue, 19 Oct 2021 02:36:26 -0700 (PDT)
Received: from blmsp.lan ([2a02:2454:3e6:c900:5142:5fbb:5821:5dc3])
        by smtp.gmail.com with ESMTPSA id o23sm1765765wms.18.2021.10.19.02.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 02:36:26 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fparent@baylibre.com,
        khilman@baylibre.com, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 0/4] thermal: mediatek: Add mt8365 support
Date:   Tue, 19 Oct 2021 11:34:00 +0200
Message-Id: <20211019093404.1913357-1-msp@baylibre.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

this series adds a compatible to the bindings and a specific part for
the thermal driver.

In v2 I added a patch to remove unnecessary (void*) casts and fixed the
comments I received.

Thanks for any feedback or comments.

Best,
Markus


Fabien Parent (1):
  thermal: mediatek: add MT8365 thermal driver support

Markus Schneider-Pargmann (3):
  dt-bindings: thermal: mediatek: Add mt8365
  thermal: mediatek: Fix apmixed error message
  thermal: mediatek: Remove data void casts

 .../bindings/thermal/mediatek-thermal.txt     |   1 +
 drivers/thermal/mtk_thermal.c                 | 102 +++++++++++++++---
 2 files changed, 91 insertions(+), 12 deletions(-)

-- 
2.33.0

