Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B5E410FE3
	for <lists+linux-pm@lfdr.de>; Mon, 20 Sep 2021 09:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhITHRV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Sep 2021 03:17:21 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53720
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234692AbhITHRV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Sep 2021 03:17:21 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B97D540261
        for <linux-pm@vger.kernel.org>; Mon, 20 Sep 2021 07:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632122151;
        bh=Wx09CSLf2BUcoT4i99Nl9tot/C6qmojAMi1r7QcpgsQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=F88/hhCqft4SjmFIrnn8SUkG3Rp4QL9B7zzk/rBk4YB1D+eJlpnGO2UQCy4V0iDEu
         MTWIV2UzYQ8K68r+oyWauJ+LYR0pEqepu1y7pLCKEz7fxTAovmF2zGOrXXTzRgebwj
         W9tErtYhb/tnyJOjge1sFE6NHQX/2t5EgnIhhMhwA9c8l2Z0XemyQTGiAgOL2snWRc
         75RrCETwdgEq+ApOaYSmwZ6xTBs1pHmZBMZMPbhAWu/L+runVSp8vgJsf6vyGTowD7
         m4PuEw3qyDEVCErD6g74M2ddX61nKWNY1STHNpGBfL2SzPOg0uVDXW1uWEpfUSkWV6
         u739zyFpjt4gA==
Received: by mail-wr1-f70.google.com with SMTP id v15-20020adff68f000000b0015df51efa18so5460686wrp.16
        for <linux-pm@vger.kernel.org>; Mon, 20 Sep 2021 00:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wx09CSLf2BUcoT4i99Nl9tot/C6qmojAMi1r7QcpgsQ=;
        b=umlORV2eCkUNWCzWT7X2LkSIkeTTLVp/9K6fX0AI/66Q/1m0f3pmIR7MehZAZDTo9v
         EhIGVAOwdX86WGMcj2UHvO3RHili6XkDi9ZvK2934VB79iP8JcLFHxXwm/d6CzrhJHWR
         FTaoiono63D0TlJBfkX5+9QSu1tVoYx3iK2ZeN5+V+PZV4buEj6T9bAUDZMRopWD2fVE
         OjNCMetYAKEIknFF3BEUwWbAZlXnSdskvgnoPY8YXxRRS4SkAEpfJumqUU3kDku6t6nk
         vPcgcEWOJe5IrU28CXoaybAbHWbocoNdWWYlThcBT87L+kbbzUH7iu7YcxHA7McvQGZy
         hgMA==
X-Gm-Message-State: AOAM530tMbnJBv5Bk8rnq2v9ZDG+Zb312NDqU5D3IVuMzghPKl1pHAMk
        oS5MqHoT7CNWgKNJkoSiD9MvoastWBv/CWNPvgHrpiczaiEkzjRBSMyIqvtje1bfC3c6xwuiXkg
        VqgroXYs1FOoQ0szU9YK8/Ut52yKzl0O12FeQ
X-Received: by 2002:a1c:7e55:: with SMTP id z82mr262578wmc.95.1632122149444;
        Mon, 20 Sep 2021 00:15:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+/JWO4KawW9KMTN5QacKUh4LzdTsDtHGOI8eupCw/ohf4m9JVuD9eePbgGFUp8uXDjI5x6g==
X-Received: by 2002:a1c:7e55:: with SMTP id z82mr262553wmc.95.1632122149216;
        Mon, 20 Sep 2021 00:15:49 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id x5sm17456153wmk.32.2021.09.20.00.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 00:15:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 0/3] devfreq: exynos-ppmu: conform to dt naming convention
Date:   Mon, 20 Sep 2021 09:15:37 +0200
Message-Id: <20210920071540.38337-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

My previous patch 3/3 (ARM: dts: exynos: align PPMU event node names
with dtschema) caused issues reported by Marek [1].

Tested on Exynos5422. Testing on Exynso5433 board would be very useful.

Changes since v1:
1. New patches 1/3 and 2/3.
2. Patch 3/3: rename event-name to match node name.

[1] https://lore.kernel.org/linux-samsung-soc/0212a402-1490-0f8f-005e-32bb6f636a13@canonical.com/T/#m570c0257204af553fe11f9122551311beb56c15e

Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  devfreq: exynos-ppmu: use node names with hyphens
  devfreq: exynos-ppmu: simplify parsing event-type from DT
  ARM: dts: exynos: align PPMU event node names with dtschema

 arch/arm/boot/dts/exynos5420.dtsi   | 16 ++++++++--------
 drivers/devfreq/event/exynos-ppmu.c | 12 +++++++-----
 2 files changed, 15 insertions(+), 13 deletions(-)

-- 
2.30.2

