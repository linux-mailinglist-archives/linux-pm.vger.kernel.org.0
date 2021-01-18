Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA9C2FA033
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 13:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404198AbhARMmm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 07:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404083AbhARMmg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 07:42:36 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAF9C061573;
        Mon, 18 Jan 2021 04:41:55 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id x18so8596350pln.6;
        Mon, 18 Jan 2021 04:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=j/l8cPJOJH+vqkRjd6MNCTHNYSadcinQYa6/IVKJ8QE=;
        b=VJK0JRsDuiQQDf97WzOaZ5n+rrSucOvZ6TZXUO+o5F0nD4SX7ppXGC+zdd4OV+YzqM
         jRW+F8AFgA3b5DDNUI2cZrWgHX+G8MN0skaebe2fxHyl9NV+GOdGe1YNubnD5j4127Jx
         B8aSg+jOR6pHhAwz7e7fpo6io8hzl05ShCiJr1KWQvBQyle0YOAXyGnxMqJpwpGgsXaw
         j4NjadFyfLvuSpDz0Mak1+jjqY4BFGePR8vJG431eGqByDNWNoI34tQWip4CaXW0x35M
         cJ/cZwt1urb14LbF2N6ZIo9TkZJdiQSQxuPXHwn8RcbzjZ8jNs55FQzpEJ+oYcZ2wgYA
         3V7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j/l8cPJOJH+vqkRjd6MNCTHNYSadcinQYa6/IVKJ8QE=;
        b=drt7ECsaXRinUrk8aw7i5E+0Yg4Yx3Ra8OjkmPJBctrnd2rx+jeYsIzPLYgzfPoaVc
         iktXZt6T1PkdZQsDtN9bp8uo8vV9gYm2oToVvZBUrj8D/n1kBx21vgrtqaKnTNVdEYUK
         4mf+WNHe6gG/HfTtuZdJOqNUU6ub4z3EnrWz3u38sQTKOqf4mit1+c53wsvWmy63Y84W
         EXMRh7RBSLgFQpiJkFDHn5cct2epFBkw8pnHSj0fpzgOrX+nZZ6ieBIDLsXOjgcJoNQe
         jVCrZM7pbwEIyT/5jt1rAjOn44zTDh69YhMTnq1Gsf8Xn5F+rcr/9X8aaBmej7ep7vmM
         PGng==
X-Gm-Message-State: AOAM532a405EQZXK7TdywN4v2r84NqXJhJw2460hHytM9HK26Svbzlry
        KSyd/dpSJUtmQLetsAZSf7VnMvcpDyQ=
X-Google-Smtp-Source: ABdhPJyRCa3t/Huh81DI/pMTm+4Y9hYkJTlAvaIsX5e/jn4oN1Nf87GtnTqy4s2nOttCDrMS0bAKEg==
X-Received: by 2002:a17:902:aa45:b029:de:2fb:995 with SMTP id c5-20020a170902aa45b02900de02fb0995mr26112581plr.81.1610973715075;
        Mon, 18 Jan 2021 04:41:55 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:57a:fa4f:eecf:e69a:c4f:ee4e])
        by smtp.gmail.com with ESMTPSA id np7sm15563431pjb.10.2021.01.18.04.41.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 04:41:54 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v4 0/2] power: supply: mt6360_charger: add MT6360 charger support
Date:   Mon, 18 Jan 2021 20:41:41 +0800
Message-Id: <1610973703-676-1-git-send-email-gene.chen.richtek@gmail.com>
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
 drivers/power/supply/mt6360_charger.c                              |  914 ++++++++++
 4 files changed, 973 insertions(+)

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

