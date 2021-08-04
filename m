Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290BA3DFFC3
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 13:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbhHDLCi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 07:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbhHDLCh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 07:02:37 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FFCC0613D5;
        Wed,  4 Aug 2021 04:02:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so8140158pjb.2;
        Wed, 04 Aug 2021 04:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MixGOiwjneRWBHsuEyNmvLTVjhrLJIi0gqcvTneDn8M=;
        b=tVDMjn9HiY5yVq9v/qXXsf+Ox07ybeNfdhXpLulTQtnEUP6K9nlvXkiHqqQkMmdQX/
         WpX/FbnsLtZ0XbtIDwt/uwiQINLnNvtDVVZf3JIEVcn/m/+MNJj5ryR24THnYqmMmuQZ
         7hEEIYdwjFyCmjepz2w7oRM1xBwkH35yCsVZBEiMj0+dw42IrL3wQTPaBegD1R4kvTHK
         gBaDgBCLkt/bFLiASSr/4QJ/yq3EXq/wafAuA/oPBHtqml9YFr1bqOj5farVNdlEPG1A
         pIfmTAbZKhKqXPvkX2lmMX9/yr4WKKNbTMAfzWpM2oR8ZEc+VP6mVJMH5aPPkfk6zHO/
         Kr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MixGOiwjneRWBHsuEyNmvLTVjhrLJIi0gqcvTneDn8M=;
        b=a9OZzG+Knm0OIBtf1w5cLtha4qYEzrCFQYd1l9FRUsdSXrDd2uMJ0IIWHOv/PSSCNt
         /v7G5fMYRTiAFqaqxmfjRlt6FlCEplU9Vihah+wk7WksSikjOBcnrYhHcIKIyhT6QHDm
         VibB6l6OE8AnEJwwxtwUzSvIeAHYZJQngBPFlHr0eucTTCCRgoJCm8YxCok71CEWDnWc
         p/IJMgilkJtOL6qgtNipQ+Ul1aNicNyZmGG09g5uzqJbFpUSQdy5tFMJWLd1V0OgdFAt
         QYgbIs0PvNVEEO0p9zJ9ZzMnBKnL6P4/l39JMKkRL1V3UI80UWBC0Dbb41KzBf8f5yD7
         dFTw==
X-Gm-Message-State: AOAM5303NUWHZxmHzDlEBWcBWWEwXrhYy2SAaLtRv/5AXL/9tTSAhHyi
        MQ4j/k+oMC+9w13l2I+s3P8=
X-Google-Smtp-Source: ABdhPJwRa2TNIEFDGLTULngorf48urSf1Z1g7o2BiHGMZAq1mEnZDF7fRkDc7xsp9EeKHxob8geS+Q==
X-Received: by 2002:a17:90a:fef:: with SMTP id 102mr9107963pjz.148.1628074945184;
        Wed, 04 Aug 2021 04:02:25 -0700 (PDT)
Received: from wangting-OptiPlex-7050.mioffice.cn ([2408:8607:1b00:7:529a:4cff:fe0e:1dd3])
        by smtp.gmail.com with ESMTPSA id f6sm2306220pfv.69.2021.08.04.04.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 04:02:24 -0700 (PDT)
From:   Ting Wang <zxc52fgh@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, wangting11 <wangting11@xiaomi.com>
Subject: [PATCH v11 0/4] add some power supply properties about wireless/wired charging
Date:   Wed,  4 Aug 2021 19:01:57 +0800
Message-Id: <cover.1627992564.git.wangting11@xiaomi.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: wangting11 <wangting11@xiaomi.com>

This patchset aims to provide power supply properties about wireless/wired charging.
"quick_charge_type" reports different types of quick charge based on the charging power;
"tx_adapter" shows" the type of wireless charging adapter;
"signal_strength" shows the coupling level between TX and RX;
"reverse_chg_mode" provides the interface of enabling/disabling wireless reverse charging.

Changes in V11
 - Fix build error on linus/master 
 - Fix build error on power-supply/for-next
 - Fix conflict

Changes in V10
 - Fix build error on linus/master v5.9-rc2 next-20200824 Reported-by: kernel test robot <lkp@intel.com>
 - Fix build error on power-supply/for-next Reported-by: kernel test robot <lkp@intel.com>

Changes in v9
 - Set bat_imax When get quick charger type

Changes in v8
 - Add quick charge type driver in qcom_smbb suggested by GregKH

Changes in v7
 - Fix PATCH version error in 0/X email

Changes in v6
 - Replace "phones" with "devices" suggested by GregKH
 - Add permission statement for "reverse_chg_mode"
 - Update description for "reverse_chg_mode" in ABI suggested by GregKH
 - Update description for "PING phase" in ABI suggested by GregKH

Changes in v5
 - Add details in 0/X email

Changes in v4
 - Exclude the patch of "power: supply: supply battery soc with decimal form"
 - Fix some typo

Changes in v3
 - Add enumederated for quick charge type
 - Add enumederated for tx adapter type
 - Update the return type and description in ABI

Changes in v2
 - modify to capital letters for "power_supply_attrs"
 - Update the return type and description in ABI

wangting11 (4):
  power: supply: core: add quick charge type property
  power: supply: core: add wireless charger adapter type property
  power: supply: core: add wireless signal strength property
  power: supply: core: property to control reverse charge

 Documentation/ABI/testing/sysfs-class-power | 85 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  4 +
 drivers/power/supply/qcom_smbb.c            | 81 +++++++++++++++++++-
 include/linux/power_supply.h                | 35 +++++++++
 4 files changed, 204 insertions(+), 1 deletion(-)

-- 
2.17.1

