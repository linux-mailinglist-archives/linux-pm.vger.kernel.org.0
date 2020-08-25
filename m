Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35DE251679
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 12:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgHYKSd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 06:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbgHYKSZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 06:18:25 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C515CC061574;
        Tue, 25 Aug 2020 03:18:24 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id k18so6961182pfp.7;
        Tue, 25 Aug 2020 03:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HGcOqNhZLhnAwiVvDmN/ctXcgXqADodUT+Mo4Ml8vjI=;
        b=IuopKSXiM81mdVx2zqo1INWZi4EBaHhGIClt8zZMDCtmf3Gx6wOkxUZl6CE8sh7zZj
         0qJrlRmAAlMrfZMkmW+Vsk6R8PnPMg+c6eKhh9hsphZa1+SKvbrmOs4qFqlw0cuV6sIA
         9GfSzRGrPU2Kg2JtmFgCjAGaNtatM6iUgK+l9cUkSXFhHcpDtNWTaacwI9K739paB5Go
         RbOn/3CHi+ZERlRw7lDC9mWDLbNrVrtJuvj3wcigtgQCQ8ntR23B19TzNoVmUfCqdilk
         1ua9Ez3ihTGK4q8GcFxr84nT3vWnDHh5n1fxN4OYxPMfnViIsq6GAkZPYRsNfDWyv0ws
         csWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HGcOqNhZLhnAwiVvDmN/ctXcgXqADodUT+Mo4Ml8vjI=;
        b=WFOenVruYhSAMxuuBVKgxwBnBBnKCAv7szsPIXvqjUqSbTmGfkHFDwEH3mGpqi6PZ6
         u7N1RFL1kXoeYoyMGOXim9XrVpQ/z7KigMrgp5wEHKTH8VNiKLfdMRzrwkfNYR5MfGSc
         YEZXA3tMEPUYBMLB+xgvndMHB7u7g0ZaWB7wGd2vjZ1hBnjEbRdpO5zRHXIGYE43bTid
         cBNU6yi7+HOL7SbZOKbRIPFKsMfOLEKZvrxo3dvBftW+CccU0pzjVHJnnMbghDyuIDrK
         0TLkggrBbSN0GzQUJTmWjz6QrYXFzJF5PU1HyMilXSsSQf0AtlfEfK5O3vfnb9gFIVR/
         9dBw==
X-Gm-Message-State: AOAM5309jqk2E7AGnhasH9uOxzME0Uk+2IkYwG1+oSdfyHoa+MBqz7mS
        5Zt83xKyLlgGmsRKxW9I3mQ=
X-Google-Smtp-Source: ABdhPJyySJ+X/YpxtMb92YjOn1n+OGKqbaPkneHV8VsE2B5wvSSt0Csfxyf0Ai/itkpKJQc9sDypKw==
X-Received: by 2002:aa7:9427:: with SMTP id y7mr7379937pfo.12.1598350703143;
        Tue, 25 Aug 2020 03:18:23 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id 19sm1788911pjk.28.2020.08.25.03.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 03:18:22 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v10 0/4]  add some power supply properties about wireless/wired charging
Date:   Tue, 25 Aug 2020 18:16:13 +0800
Message-Id: <cover.1598349907.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

This patchset aims to provide power supply properties about wireless/wired charging.
"quick_charge_type" reports different types of quick charge based on the charging power;
"tx_adapter" shows" the type of wireless charging adapter;
"signal_strength" shows the coupling level between TX and RX;
"reverse_chg_mode" provides the interface of enabling/disabling wireless reverse charging.

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

Qiwu Huang (4):
  power: supply: core: add quick charge type property
  power: supply: core: add wireless charger adapter type property
  power: supply: core: add wireless signal strength property
  power: supply: core: property to control reverse charge

 Documentation/ABI/testing/sysfs-class-power | 85 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  4 +
 drivers/power/supply/qcom_smbb.c            | 81 +++++++++++++++++++-
 include/linux/power_supply.h                | 35 +++++++++
 4 files changed, 204 insertions(+), 1 deletion(-)


base-commit: 6a9dc5fd6170d0a41c8a14eb19e63d94bea5705a
-- 
2.28.0

