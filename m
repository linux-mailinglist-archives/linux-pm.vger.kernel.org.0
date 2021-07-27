Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783413D71DD
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jul 2021 11:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbhG0J0I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jul 2021 05:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbhG0J0I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jul 2021 05:26:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AB0C061757;
        Tue, 27 Jul 2021 02:26:07 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id n2so14443532eda.10;
        Tue, 27 Jul 2021 02:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xHWSK2tc3IOr1iy+M8bgv8eKBmME6SgNYXmp9ttzvlU=;
        b=lxDvXpG7lMyMTYZPhAZjfpc6h7RREPbuCpThDFxvF8lefgSOfB2UTYAk4TNgB0GRar
         UB/dAVnxOiIVMlkAgGfuSuOV9C7igefg38w1e/j81DVtp+qEooK4TuETimrarUKSMvVT
         o+r/fZAIHiD+g6dSNdLd7l0Z7s98746WbBjFk0o9rlN3ZNdbc2t8lHdzrttJXVsjG0mU
         RSpFocBxJ2/tsnfXBuB5aKBv10HAgVYyArz0LqRodd/Vi/DfBHAf4WD2bsT1cZ17vLx3
         mT72GFuson6H+On5M+b1EP10bpJUMCfwBV+G3HKjbcBVWIEhVUvMt9v1g8qIpeJxyd3A
         gF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=xHWSK2tc3IOr1iy+M8bgv8eKBmME6SgNYXmp9ttzvlU=;
        b=MqdnDhdN8UiyiTHGfWO8d1WNMS8fBr1pL8NizGfBSvEbUn48cdlm9lXSzYNwSv2Nrh
         UbvesguIKf93+dn0XtSkjEloGwSCfv8pbEPOuM02n82YH1SimLrqZNba1Ubl9cQK0FvO
         ZAwionJPWaYp/LbTv8oC1YYkRDyzJUp1fq8OzhN7MbhGLwyWQU7B9ncnJJljqKjp132n
         kSl+DLbqeO5GGg9ApzJtd3Wf+1RWX80XPTigQHy3dfo6eWBXSoG2LnRN4WUYkS8NUgJc
         4LV4FuUSSoTh/RJkn/KwzqZxtvKn1kY7mP+x+9DABpyqr754b4c47D8eF41tMhOetBC3
         18oA==
X-Gm-Message-State: AOAM530ORGsA0KJUb5YxgcE4uYr9xE9SD0JQTMBToBimpcUjyvOPbl33
        wpoImVOUCHe3bbcpvwdOkaw64c8V1WMtRC9M
X-Google-Smtp-Source: ABdhPJw+0KyN73exnuGiqYvoAZb44BQ1o/ALw/bDnqlaOF1s4RguKyUdz26T/ck61XM0QaE6KZ+Upw==
X-Received: by 2002:aa7:cc83:: with SMTP id p3mr22745797edt.365.1627377966153;
        Tue, 27 Jul 2021 02:26:06 -0700 (PDT)
Received: from stitch.. ([82.192.166.82])
        by smtp.gmail.com with ESMTPSA id g3sm692369ejp.2.2021.07.27.02.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 02:26:05 -0700 (PDT)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] BeagleV Starlight reset support
Date:   Tue, 27 Jul 2021 11:25:50 +0200
Message-Id: <20210727092554.1059305-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds reset support to the BeagleV Starlight board[1], and
converts the TPS65086 PMIC device tree binding to YAML while at it.

Support for the StarFive JH7100 RISC-V SoC on the board is not yet
upstreamed, but is actively worked on so it should only be a matter of
time before that happens.

v2:
- Use generic node name in dt example, tps65086@5e -> pmic@5e.
- Andrew F. Davis' email address no longer works and noone else has
  stepped up, so add myself as dt binding maintainer since I at least
  care that it isn't removed.
- Change the mfd cell name from tps65086-restart to tps65086-reset.
- Split adding the mfd cell name to the mfd driver into its own patch.
- Add Rob and Sebastian's acks to the relevant patches.

[1] https://github.com/beagleboard/beaglev-starlight

Emil Renner Berthing (4):
  dt-bindings: mfd: convert tps65086.txt to YAML
  mfd: tps65086: Make interrupt line optional
  power: reset: Add TPS65086 restart driver
  mfd: tps65086: Add cell entry for reset driver

 .../devicetree/bindings/mfd/ti,tps65086.yaml  | 124 ++++++++++++++++++
 .../devicetree/bindings/mfd/tps65086.txt      |  54 --------
 drivers/mfd/tps65086.c                        |  22 ++--
 drivers/power/reset/Kconfig                   |   6 +
 drivers/power/reset/Makefile                  |   1 +
 drivers/power/reset/tps65086-restart.c        |  98 ++++++++++++++
 6 files changed, 241 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/tps65086.txt
 create mode 100644 drivers/power/reset/tps65086-restart.c

-- 
2.32.0

