Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9894E3D2C87
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jul 2021 21:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhGVSeK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Jul 2021 14:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhGVSeF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jul 2021 14:34:05 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0DFC061575
        for <linux-pm@vger.kernel.org>; Thu, 22 Jul 2021 12:14:39 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id a17-20020a9d3e110000b02904ce97efee36so1001001otd.7
        for <linux-pm@vger.kernel.org>; Thu, 22 Jul 2021 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=isgGvNleCQDQ5ZdmwxZj9FzyqTxiANzYbXVOil6iZug=;
        b=odMklhiy7f9Hhe0qNbb4ZYtcPisRl4sRDuCYCq7tr+NcbNJDToHW7voaQIecnecbe6
         As7AmhKgxJqED0N/8dsuHvZe1gC8+sFQv1pQP+h9Yg3v54VSADxrkZC++GU50J3FSbUd
         oJIuqZpW2tvzpttnWB58/CND0Ie3Iuoh0hk8dQDYWYwOqGmCHwUlY6zorYcz4kVjZC32
         XwNYQAADKHKX/ERlHsaCcypmOoLMWUYwEfMQ+ANTukDrkr3Z18FhTbTlL4m6D5/bPTcX
         E95a2mVGDQy0XHgt53OPE1NPq6NJV7tLRHWO3no8bETSK7aKcmLNipnzOeRZjnlhY0xf
         JxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=isgGvNleCQDQ5ZdmwxZj9FzyqTxiANzYbXVOil6iZug=;
        b=j+svr6DLjXwIZJS5z6RNkwd8ZqrDiLZsJxksEu2VudwiYq3yqVWplppi2Opey8BQZu
         fA3Hj/DYf810KlbNNMst+kvii+PxExA3D3u19R2N4bDd4+JRQUbQWzMiScWiLKFIkB7/
         CNNQTGVF9vwGtz/GNQyOnSLn3WLtNVU5IzA753GhK/YRWshllSrI+mYw2d6bIs0uFqgl
         7SadUX5DYkn8pEGWcQl2S0mrES8nQ83bJM3Q0RCRM/EAEzbRUMMECvkK11rCuiOnre+x
         B4efeu0ZJ5Vol99PqRi7av/ZvceDV/4PxYL5ORxiGIqeNPUp1bIcWITSbJ9JvSN3efob
         zDFA==
X-Gm-Message-State: AOAM531MmIg/m4qlDsfmOib2OUQ6I1KDkStnUuNJFLaRp4WPjMO0n6XA
        hVFuhWGicUGeVynvTxw7bBo=
X-Google-Smtp-Source: ABdhPJzgWs3FZsYUB2vP3NY/Nc9Pw28lermfl60sj+okNEm3iezGfjknBRBFVyB3MvfjvcBDvAjGUw==
X-Received: by 2002:a9d:2d82:: with SMTP id g2mr924019otb.30.1626981278686;
        Thu, 22 Jul 2021 12:14:38 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id r26sm3106167ooh.32.2021.07.22.12.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 12:14:37 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        maccraft123mc@gmail.com, sre@kernel.org, heiko@sntech.de,
        robh+dt@kernel.org, lee.jones@linaro.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC 0/4] power: supply: Add Support for RK817 Charger
Date:   Thu, 22 Jul 2021 14:14:26 -0500
Message-Id: <20210722191430.28203-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

As this is my first charger driver, I'm submitting it as an RFC so I
can get input from the community on what else is needed to make the
driver consistent with the quality upstream expects.

This series is to add support for the Rockchip rk817 battery charger
which is present in all Rockchip RK817 PMICs. The driver was written
as a joint effort by Maya Matuszczyk <maccraft123mc@gmail.com> and
myself Chris Morgan <macromorgan@hotmail.com>.

The driver requires some basic parameters be described about the
battery in the devicetree such as the maximum capacity, the minimum
and maximum voltage for the battery, the maximum charge current, the
maximum charge voltage, and the value of sample resistors and sleep
currents.

Chris Morgan (4):
  dt-bindings: Add Rockchip rk817 battery charger support
  mfd: Add Rockchip rk817 battery charger support
  power: supply: Add charger driver for Rockchip RK817
  arm64: dts: rockchip: add rk817 charger to Odroid Go Advance

 .../devicetree/bindings/mfd/rk808.txt         |  35 +-
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   |  26 +
 drivers/mfd/rk808.c                           |  16 +-
 drivers/power/supply/Kconfig                  |   6 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/rk817_charger.c          | 927 ++++++++++++++++++
 include/linux/mfd/rk808.h                     |  87 ++
 7 files changed, 1095 insertions(+), 3 deletions(-)
 create mode 100644 drivers/power/supply/rk817_charger.c

-- 
2.25.1

