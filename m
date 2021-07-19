Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC363CCCBE
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jul 2021 05:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbhGSDpq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Jul 2021 23:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbhGSDpp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Jul 2021 23:45:45 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79BDC061762;
        Sun, 18 Jul 2021 20:42:45 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u3so8880724plf.5;
        Sun, 18 Jul 2021 20:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OQVU1jW7tgwMUWUTvKR/4fnb70smUlYCRCV/O5UNBA4=;
        b=bypd+XTola0WoE+ijdpSmaLCA39u/8xbQz26TW0ZCatgyEPUTam2akTxt3aJqccl9T
         c6LWkWeA86oB5Tf9cwDe1s4HCEjvnNptrWPdfbTD8DxoeMtaIslzZNZs595QMHxR58IF
         +BtnZ1HZ5cvgfJGodihPWcr3uAdcBJqUkRqci/3XIjFwWGYlxDaFxDNZZ9Hversr8SlR
         cKgipU29jfSteHjWp9wXbnbaqUr668P72pIRlpNBTKp0r3LUTXSqx6U8dgp/ZQ5VSjnV
         eJUAq54CB3cmW13+dzFfz6pypl/RA6TWz2y+QpmnD4L05SHjKW7r91A+3nPMq3JhShMf
         J/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OQVU1jW7tgwMUWUTvKR/4fnb70smUlYCRCV/O5UNBA4=;
        b=H36ZuMd+05ryHeFoBML2JHAOcB4ag3dIzg47wHqni7uzAQ8A3d9Ud8mAXUKyr27qXB
         VC0D5APVNNEv6KE0qnSQLy48skC0a0/rHQiAibgQle4wCYekJh4NDuKZEjcTRH8LDeSq
         z1VodvM2RkFa+8H7X4xDdNgKQPQJCKiFKhG8znAr+dCSJiK+4HIiJ0W3nOp7ISNvAGUe
         tn3pnPlcdXsvohIYerNkSjLo3d5vXpO2+P5zQuTqCx8QkKHjv+V+qtZ+YzuAo+nwPPub
         4y7supgujbLeblev9i/yahrOa5SnP95ABdaJQLwXm9oCnX6Ltu+WT3C+Z8hOAXfg9tI6
         JmQA==
X-Gm-Message-State: AOAM5330+sdMyY9Dv475WtnOBN/OxFYZrMaYui0i87eBLDV8zSEzI9rr
        ykk9IGBG2qt3+YkoqKUd0ds=
X-Google-Smtp-Source: ABdhPJwzpWGYTvuIEfVwqx+DEO9vz+n2VwvSdbzUV8Zlzg5jnQSyrViByrmFrkn0tB8UODko183a2w==
X-Received: by 2002:a17:90a:bd06:: with SMTP id y6mr22805443pjr.6.1626666165225;
        Sun, 18 Jul 2021 20:42:45 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:58d:ffe9:427:42b0:88c7:1ff9])
        by smtp.gmail.com with ESMTPSA id c12sm17949448pfl.27.2021.07.18.20.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 20:42:44 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com,
        matti.vaittinen@fi.rohmeurope.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, gene_chen@richtek.com,
        Wilma.Wu@mediatek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com, sebastian.reichel@collabora.com
Subject: [PATCH resend v6 0/3] power: supply: mt6360_charger: add MT6360 charger support
Date:   Mon, 19 Jul 2021 11:39:11 +0800
Message-Id: <20210719033914.16990-1-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


This patch series add MT6360 Charger support contains driver and binding
document

Gene Chen (3)
 lib: add linear range get selector within
 dt-bindings: power: Add bindings document for Charger support on MT6360 PMIC
 power: supply: mt6360_charger: add MT6360 charger support

 Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml |   48 
 drivers/power/supply/Kconfig                                       |   11 
 drivers/power/supply/Makefile                                      |    1 
 drivers/power/supply/mt6360_charger.c                              |  867 ++++++++++
 include/linux/linear_range.h                                       |    2 
 lib/linear_ranges.c                                                |   31 
 6 files changed, 960 insertions(+)

changelogs between v1 & v2
 - Add binding property with unit and custom name prefix
 - Remove extcon device, redundant brackets and interrupts
 - Fix power supply prop "charger type"

changelogs between v2 & v3
 - Add register selector to value mapping

changelogs between v3 & v4
 - move pdata vinovp to mt6360_chg_info
 - remove unuse sysfs attribute
 - refactor debug log and warning
 - add power supply prop input voltage limit

changelogs between v4 & v5
 - add linear range selector mapping
 - use linear range to map charger setting

changelogs between v5 & v6
 - use REGULATOR_LINEAR_RANGE
 - use devm_work_autocancel
 - fix Kconfig description


