Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A08A3EDB18
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 18:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhHPQmU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 12:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhHPQmT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 12:42:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF56C061764
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 09:41:47 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q11so24519115wrr.9
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 09:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VaH1mb4YJaNfLIoBKAGqOfF1CidyUq6GE8UUo9yf+IA=;
        b=0FL71FFEFYgZAt/2TDNCQRJcLZD2MkQLLdGdsGCqZYWqpra+iVRmwzXSODwQZtO7gt
         QU9YZW3WRnh50AlUz/MsVFLpME9SsElyFHsUnbwad24NUpGtq74VMBZ1Kopr161ovvQk
         A+yVSlk26gYm/FmroNM/RifBzC6zfHcaqzlotstlTYmgMBjE85WzFkOhkpfJpB0TyfDF
         vnNeX9EVBOPkURpdcjsTZNDlsyMWPhtVf35FqOJCUZd7nki3E+uMHMtuhUIqqn46g+e5
         aT7sw8vOMx1QLx3vhhdbE3Z8VBKk4SVr+zpvaqjAFRFmsGKEq3OuP8BFoY/yfj40jTXg
         KM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VaH1mb4YJaNfLIoBKAGqOfF1CidyUq6GE8UUo9yf+IA=;
        b=g9mS1o87nBQg9I/XvmY7zTVRmZ3MrIkXUDn5Tfp9tRrybfDoFX/QcqAS/HeVyxZ3xF
         voJmLc06HVHpEGHVQ2H1iEvo6in8z73UHlAOI045uiz3IVvL7feu5Fv0bSiUtJBQTmpX
         hp/poFyeYqqmVmi5UhmkBP+krSUAEwl+3NWj3z2zMtX0CA/mIMidp8ns4IA1BG4NX3/6
         S20BacVPPoizqLLAoHcDjoLooxYUyBWRO2YehOenTWvcE/a7EPAhKIad1syj3hy8ArAA
         TTCu3ywevMVc0HwAPPqxZGyDf1EEZXt+dJzS01CVTroUV8DStHrT/PjGgm4800ltgIuk
         pNcw==
X-Gm-Message-State: AOAM533ULeXAqcDrT6XHl2tWIN3vvxHqZD75N1K40YhxfcvfjOM12Eni
        aqb/X9q52M/1figoHQWv934GbA==
X-Google-Smtp-Source: ABdhPJxQMWnKzZ0ECLs1a7IEhF2g+rE7+74yku7t8LzXIre6H3dSFys3LS0NMgoW5aqYBTJQ3z4dqg==
X-Received: by 2002:a05:6000:184a:: with SMTP id c10mr19924577wri.26.1629132106459;
        Mon, 16 Aug 2021 09:41:46 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3a81:3690:b885:8dcf:f8c6:7841])
        by smtp.gmail.com with ESMTPSA id m10sm15211730wro.63.2021.08.16.09.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 09:41:45 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     ben.tseng@mediatek.com, michael.kao@mediatek.com,
        ethan.chang@mediatek.com, fparent@baylibre.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 0/3] Add support of thermal for mt8195
Date:   Mon, 16 Aug 2021 18:43:04 +0200
Message-Id: <20210816164307.557315-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds thermal support for mt8195.
Depends on https://patchwork.kernel.org/project/linux-mediatek/list/?series=502403

The changes required to support the mt8195 look very similar to those for
the mt6873 but the differences make code factorisation difficult.

Alexandre Bailon (1):
  dt-bindings: thermal: Add binding document for mt8195 thermal
    controller

Michael Kao (1):
  thermal: mediatek: Add thermal zone settings for mt8195

Tinghan Shen (1):
  arm64: dts: mt8195: Add thermal zone and thermal policy

 .../thermal/mediatek-thermal-lvts.yaml        |   6 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 164 ++++++++++++++
 drivers/thermal/mediatek/soc_temp_lvts.c      | 209 ++++++++++++++++--
 3 files changed, 361 insertions(+), 18 deletions(-)

-- 
2.31.1

