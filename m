Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0E42FFA66
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 03:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbhAVCeu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 21:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbhAVCet (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 21:34:49 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1317DC0613D6
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 18:34:09 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id o18so3147484qtp.10
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 18:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3eXUz0FJHPsxXVok5Mi9le7B1OegMg7jEkFlgOt9P20=;
        b=NAU1rovHipp9jQS+UwplK2LJIgr3LwJA0xUu3RwGWdyAD9UIronXjdEZceEuEo6E4o
         /iu0psHsA0Y6udLcJW/tF/vriVqBPo9xa995cMjHJL7ezXQiUhhI3VEtv/h/o9bCcx2W
         Dwx2zJiT9OmWh9pnjv5HAaaLpd8Snf+hyG/G8c6awaLVwDoVXiIPzL+s3JXyeBdX486I
         Y2A9g7JBdhT7Z1RtWPibk5ZL5XRKbKkdwMkOLoFrtGH//xk50pj+Sftd1140P04MJqrV
         WKm0hmEr/DjncN2KJPZRBED/QB7+9Y7OLXf0OIrpHZXvL1r76/Bi1Jet5JN/cRL3KctW
         sC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3eXUz0FJHPsxXVok5Mi9le7B1OegMg7jEkFlgOt9P20=;
        b=BrxYxCLP3zd8zsf/LG6/VfsDSakOH51TPd0JRsOLFlQTxo4KmR71O7nRwGoEV9af8S
         Io8JYIXQsep7wJQyrZ7xaNkHsclP4GxJ31bSroh4xNBV2IFr+Aj9GrplwhESYIz7NfAp
         Z22mn+XukD/RDjMt9OepScW6+jaOKIk4wqaB5LTnMmUK/ewjCKOjGufmSrOtK3THoQID
         xA3DLI+NBFenAjpqL4K5OZADD6dQVBC+t0ucP40ymcrxB7n2wTYFbOWJr18aY3pAutU0
         pFM96CexF+A20NA+EJ3Sw2lSbxFxbElEGS28zgtX9aULC/InGqNET+VAYf5aJMjdI6Xp
         V13Q==
X-Gm-Message-State: AOAM5329DrEKkB35FczUM00Mx9MPoAMv2Y52aG2Z9QC27NPf2/dn6Twq
        eNo3xEg8lbCU/f8A3klcbVMBCQ==
X-Google-Smtp-Source: ABdhPJxnqEx4qz1AWdxzajdteuEgbByB4SbNXo7KMUUQiENdstnL0zVNkCqy5M2FZBnR9Q1mBexuEg==
X-Received: by 2002:ac8:4894:: with SMTP id i20mr2595500qtq.244.1611282848213;
        Thu, 21 Jan 2021 18:34:08 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id m13sm4846025qtu.93.2021.01.21.18.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 18:34:07 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        davem@davemloft.net, kuba@kernel.org, luciano.coelho@intel.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org, amitk@kernel.org,
        nathan.errera@intel.com
Subject: [PATCH v2 0/3] thermal: Replace thermal_notify_framework with thermal_zone_device_update
Date:   Thu, 21 Jan 2021 21:34:03 -0500
Message-Id: <20210122023406.3500424-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

thermal_notify_framework just updates for a single trip point where as
thermal_zone_device_update does other bookkeeping like updating the
temperature of the thermal zone, running through the list of trip points
and setting the next trip point etc. Since  the later is a more thorough
version of former, replace thermal_notify_framework with
thermal_zone_device_update.

v1->v2:
	- Removed net: wireless: intel: from subject header of Patch 1
	  in the series as per Kalle Valo and added his Acked-by.
	- Introduced Patch 3 removing thermal_notify_framework from
	  thermal documentation.

Thara Gopinath (3):
  net: wireless: intel: iwlwifi: mvm: tt: Replace
    thermal_notify_framework
  drivers: thermal: Remove thermal_notify_framework
  Documentation: driver-api: thermal: Remove thermal_notify_framework
    from documentation

 Documentation/driver-api/thermal/sysfs-api.rst | 12 +-----------
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c    |  4 ++--
 drivers/thermal/thermal_core.c                 | 18 ------------------
 include/linux/thermal.h                        |  4 ----
 4 files changed, 3 insertions(+), 35 deletions(-)

-- 
2.25.1

