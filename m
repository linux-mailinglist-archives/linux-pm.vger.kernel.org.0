Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC51F2B492E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 16:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbgKPP1K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 10:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgKPP1K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 10:27:10 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C081C0613CF
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 07:27:10 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id k2so19162586wrx.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 07:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/nUNOFLN6IikzihRcWpgoGdh6TnItZX1uNVpsszzMXQ=;
        b=XpH8iEeu08Fe9sEZDYnOcbXjab9a1kGi0+K3Vf7ZkwPegpg9qLfQKOhYvbxG/EvDeO
         /KvmOdIW/ZJpRWDinTXXRTpi7ZyVTUzq/8Oui6wJ3RwUSpzPhNEpUPyrwcbaBdFyTue1
         LKlXJEZCq5kY552c8gYHd3zYadmq0gn7oiWmCrBDRnTDcGhPyuUpG4QctH9AGLFLm3YO
         14Xv7zIDRvds0IJuR2W4WYlrXs/o73DgDOh1Py54MHup2GdE+i33X68ygR0taw//kaiu
         xej+e7UfwlbvBer88QzQStJ0+YPd1HC6OQu0qg+6ti8nDabxTqLnHacev3oGtuJaHryW
         ivMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/nUNOFLN6IikzihRcWpgoGdh6TnItZX1uNVpsszzMXQ=;
        b=eTuBWspPV9Nw7Ydltr+KS86AUBKRkBjNbxEfXxWNAcF6USNymNDuVJTG+dIB/fqDVa
         Kt4WaM+HY4hVoTuJZp9gBzlEeICfPp4JUvkSUUMt4Kyli1pdW9s6qm2FgIGwQ3Fw5lWz
         vqJ3/iypTis4w4bx6c7CKmKnUBwdGjJFv515joW5nhusJkq2oudeMVe0fh0G/h47Q8hD
         AFq3MXmVnLc05lTaPA1ebt29MmzmKJE79vnIOlpJ4gthZYUxdaCPooAUR83GnpSWNgbT
         ZzP1nE4ZL5EACXY4AzhtMqwFoIho3jI+HQQHDKeXQbmI0wZrWeIJarEVF2l3G0Vu5DTO
         8ABg==
X-Gm-Message-State: AOAM5331Nf60e4cUKrcx9QlDGmGuXwjccBYZ/M3C/ziWNPLZlEq99psV
        UCfCzTEGpHJIpkvyCn9B9BKxcA==
X-Google-Smtp-Source: ABdhPJxAprY9OOmw66oSB+iId6DIhrCa8bWI+rKVkdeNdwJQavoObh/EzTKd0o2MtdyprhVHKeQ6Yg==
X-Received: by 2002:adf:a343:: with SMTP id d3mr19990822wrb.91.1605540428664;
        Mon, 16 Nov 2020 07:27:08 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-240.adsl.proxad.net. [82.252.135.240])
        by smtp.gmail.com with ESMTPSA id k20sm19930453wmi.15.2020.11.16.07.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:27:07 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     ilina@codeaurora.org, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rkumbako@codeaurora.org, rui.zhang@intel.com
Subject: [PATCH V2 0/4] powercap/dtpm: Add the DTPM framework
Date:   Mon, 16 Nov 2020 16:26:45 +0100
Message-Id: <20201116152649.11482-1-daniel.lezcano@linaro.org>
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

Changelog:
 V2:
  - Fixed indentation
  - Fixed typos in comments
  - Fixed missing kfree for dtpm_cpu
  - Capitalize letters in the Kconfig description
  - Reduced name description
  - Stringified section name
  - Added more debug traces in the code
  - Removed duplicate initialization in the dtpm cpu

Daniel Lezcano (4):
  units: Add Watt units
  Documentation/powercap/dtpm: Add documentation for dtpm
  powercap/drivers/dtpm: Add API for dynamic thermal power management
  powercap/drivers/dtpm: Add CPU energy model based support

 Documentation/power/powercap/dtpm.rst | 222 +++++++++++++
 drivers/powercap/Kconfig              |  13 +
 drivers/powercap/Makefile             |   2 +
 drivers/powercap/dtpm.c               | 436 ++++++++++++++++++++++++++
 drivers/powercap/dtpm_cpu.c           | 282 +++++++++++++++++
 include/asm-generic/vmlinux.lds.h     |  11 +
 include/linux/cpuhotplug.h            |   1 +
 include/linux/dtpm.h                  |  75 +++++
 include/linux/units.h                 |   4 +
 9 files changed, 1046 insertions(+)
 create mode 100644 Documentation/power/powercap/dtpm.rst
 create mode 100644 drivers/powercap/dtpm.c
 create mode 100644 drivers/powercap/dtpm_cpu.c
 create mode 100644 include/linux/dtpm.h

-- 
2.17.1

