Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1EC284B83
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 14:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgJFMUq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 08:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgJFMUq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 08:20:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E020EC0613D1
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 05:20:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e18so7312467wrw.9
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 05:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jHqlJlKyK3t+BplWZMVjP0HJb12amo5gWYHD/Aa8e9s=;
        b=fB7+dnIdkE+utP0B/DtZDwiIRlCjrN+H3ocJF3Kg7TpO8uliOFUsHs0nCFJEtu0z9F
         Q30VL7TfftLQawwmbVq6URRycNI2U6ymvN5r3ssthQWYhxxOMR6uDwwx0csrjUWsugcA
         PnxUifmMqz16gCqUpSj7ePV6H+Tepnrg4QrSqGfkYudLBOi52MSWEfjBTZqi4ygvWx5R
         JgDZbi7WNI/wKqXtS6kv93sdmGnjSOwsIHr+ELxQCtYl5TG7bnvfwrjDVTxFwtwpXTYq
         024D9ccCJTIPWHTAjoamaaUTreonc3WYsdmKK5J1DMALErGonc/Y6/7KtNdsFFiM46mM
         ueMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jHqlJlKyK3t+BplWZMVjP0HJb12amo5gWYHD/Aa8e9s=;
        b=OJrtam/WeqzYGAp5QmVlxrvzDo9YPdsgbjfe5VO9fKclPp0jA5NItPshsJvxC8FYPV
         eQCng1VKGBGuSRDD7xyYcwXNt24OAZpWD5XnhERU8DsYe6CXizpj08QP4J7W0JnE51u8
         Wwrm0qqKQn+0UuC/GTdKmPdV0JRQBiNlwvowBvveZDvRj1pDu6sGOpsQVsaK16eCHXS9
         qOMQ8RDwJnf0EfRMhXkEMKDsNRF1WLTPkbcRTn5bVk1OllA6IMMPXwBJC8AYAN+y6K92
         KaB7l90nrQq+y3lpM6W+FmAPhuAZgqpxizot6XzprV1DC1kLszVnduimUhkye9uZeWeN
         BPbQ==
X-Gm-Message-State: AOAM533q3MXBYaP3wvzzwTPBgASgAIcMOgj+o11NvHpVd91xpNxqcAwd
        Qp+avn13Z66vTrwabHhdh2MzuA==
X-Google-Smtp-Source: ABdhPJxC22IO37gpc3nCTUf4QVKu5O5/BfhzkqDY75+/hntvPjceH3AhCEQMht+nQSLUH68LbDfjnQ==
X-Received: by 2002:a5d:540e:: with SMTP id g14mr4828784wrv.148.1601986844293;
        Tue, 06 Oct 2020 05:20:44 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-130-8.adsl.proxad.net. [82.252.130.8])
        by smtp.gmail.com with ESMTPSA id s19sm3742521wmc.41.2020.10.06.05.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 05:20:43 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com
Subject: [PATCH 0/4] powercap/dtpm: Add the DTPM framework
Date:   Tue,  6 Oct 2020 14:20:20 +0200
Message-Id: <20201006122024.14539-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The density of components greatly increased the last decade bringing a
numerous number of heating sources which are monitored by more than 20
sensors on recent SoC. The skin temperature, which is the case
temperature of the device, must stay below approximately 45°C in order
to comply with the legal requirements.

The skin temperature is managed as a whole by an user space daemon,
which is catching the current application profile, to allocate a power
budget to the different components where the resulting heating effect
will comply with the skin temperature constraint.

This technique is called the Dynamic Thermal Power Management.

The Linux kernel does not provide any unified interface to act on the
power of the different devices. Currently, the thermal framework is
changed to export artificially the performance states of different
devices via the cooling device software component with opaque values.
This change is done regardless of the in-kernel logic to mitigate the
temperature. The user space daemon uses all the available knobs to act
on the power limit and those differ from one platform to another.

This series provides a Dynamic Thermal Power Management framework to
provide an unified way to act on the power of the devices.

Daniel Lezcano (4):
  units: Add Watt units
  Documentation/powercap/dtpm: Add documentation for dtpm
  powercap/drivers/dtpm: Add API for dynamic thermal power management
  powercap/drivers/dtpm: Add CPU energy model based support

 Documentation/power/powercap/dtpm.rst | 222 +++++++++++++
 drivers/powercap/Kconfig              |  14 +
 drivers/powercap/Makefile             |   2 +
 drivers/powercap/dtpm.c               | 430 ++++++++++++++++++++++++++
 drivers/powercap/dtpm_cpu.c           | 242 +++++++++++++++
 include/asm-generic/vmlinux.lds.h     |  11 +
 include/linux/cpuhotplug.h            |   1 +
 include/linux/dtpm.h                  |  76 +++++
 include/linux/units.h                 |   4 +
 9 files changed, 1002 insertions(+)
 create mode 100644 Documentation/power/powercap/dtpm.rst
 create mode 100644 drivers/powercap/dtpm.c
 create mode 100644 drivers/powercap/dtpm_cpu.c
 create mode 100644 include/linux/dtpm.h

--
2.17.1
