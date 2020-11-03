Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2402A4355
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 11:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgKCKlk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 05:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgKCKlk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 05:41:40 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E95C0613D1;
        Tue,  3 Nov 2020 02:41:40 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y14so13811810pfp.13;
        Tue, 03 Nov 2020 02:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YNLb4i+gXcastlq1jUldc6IN2Il0nxtDvvRsKq+pC4g=;
        b=ZURDZYxaPRFuO/+TNnsVT8GVNiJf8TjmZYdhyR1a4swJiVM6QPUuPVcFRStJ9MZuX/
         pBklaDat2D2RA1jlg5sK8YNJbDfyMY3R+6jiHfxSvlP/BkhouYjBVN5OU2KBZypOCluF
         4iBC2VHIbwzs6Ft9xIPyzwXOb9Va8GMW4euEzjWasBApmHzKBIdnTE4bQbFMe00yCZw8
         MrEt0hoOuvRsqIk5/qG7syetMfC0zNPpzrivNsCcuyn7bvuPrWpWNzNklkgg16xTiqTk
         JKnfVn8SvZFvYvAT1UAZxzgJpTZFr+nbu9HqcSTnpLKmIq9CU2eo93jb+tBUdpD/kx1Z
         n8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YNLb4i+gXcastlq1jUldc6IN2Il0nxtDvvRsKq+pC4g=;
        b=dtxj19iRBgrzn3OcKElyrADwHldNMkxB59SZQczRPs7081IQ680mulbG4rHBMz6R1G
         kfY0kzzdkInXhBLblzk2F+9r/qTdk4GI38vkK6MzZVyoZtEVUt4y6dilwezdldyKvZEP
         dhvGBHSqEmY9SGmQlY8BczFcIz8iqu8bJVifYExyPWFeZ1UGVE/xa6jFq/5RFQwggOIT
         QATvPH87N2+Hqqc/ylWUTOW7ze6kUEClnjIkmlpcS+jxz8zW/i1ZwCt/IpuloYihwwVu
         TspmXV1N7jVL9jTs8YGimBMWVPqCV1jSEi9nApRTAH8yzbfCY0UUXB3GGWHU6LHUcfPA
         s0AQ==
X-Gm-Message-State: AOAM533PQGd6aT82d4dD5XejHOdCvGPnOYbBWKrd5DoW6werXBYEfAR7
        2B6dxss/yP0bwQfwK/rhx78=
X-Google-Smtp-Source: ABdhPJzZ3nqKgtxz8KXjJX2tus8vdo7/M6zz86MOLrnlkiSXnv22tTvO9BV7QM3dBawj2W93445Zyw==
X-Received: by 2002:a17:90a:7c0c:: with SMTP id v12mr3120612pjf.71.1604400099731;
        Tue, 03 Nov 2020 02:41:39 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:57a:6823:8ab3:4b5d:4c53:f39b])
        by smtp.gmail.com with ESMTPSA id 26sm5235537pgm.92.2020.11.03.02.41.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 02:41:39 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v2 0/2] power: supply: mt6360_charger: add MT6360 charger support
Date:   Tue,  3 Nov 2020 18:41:29 +0800
Message-Id: <1604400091-14618-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch series add MT6360 Charger support contains driver and binding
document

Gene Chen (2)
 dt-bindings: power: Add bindings document for Charger support on MT6360 PMIC
 power: supply: mt6360_charger: add MT6360 charger support

 Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml |   48 
 drivers/power/supply/Kconfig                                       |   10 
 drivers/power/supply/Makefile                                      |    1 
 drivers/power/supply/mt6360_charger.c                              | 1022 ++++++++++
 4 files changed, 1081 insertions(+)

changelogs between v1 & v2
 - Add binding property with unit and custom name prefix
 - Remove extcon device, redundant brackets and interrupts
 - Fix power supply prop "charger type"

