Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A293C19002D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 22:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCWVTZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 17:19:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41996 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgCWVTY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2020 17:19:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8so7851985pgs.9
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2020 14:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=nFFq1NJ+zuCWICzbnMUATikCUkOp4SrSQIe/H28va1w=;
        b=BsRs9+jbTUtNxbnpFkcWScy78n0Kvnkr2KBOTELS7bvyu0qQGB5BoqOWbXC9FNyUQB
         LN6rR57B6Eo6XszGvYdBljMek7AvR5WWTCSjGdSU7IyQ1nAU02pVFEkMDMR2sa3IvvMj
         kWtayJDiffFCnsPbIR4CRJOsRzZ1sbDkjS9phOF+kYlgBCmWJ9ZdMi4lDLad7onnFt0X
         FRu990WIa0BUs9se2UWUAJF0gtk1tTI7NV48U5O0N7fnG6RccJaubM+pHMZD6vQ8hJzw
         8a8tKIpkn86jxV+YKCVi5p/C6rvsD5xq+8zsDawP2E14QNZHgWNGuonyw0QZxOjgPm2n
         9iaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=nFFq1NJ+zuCWICzbnMUATikCUkOp4SrSQIe/H28va1w=;
        b=MQRmnY+fDurz/6iPU7bSxHdQEO6p5Bn+VNK5Z25hqty9QoRnpeBySnkHv96DeCx/6s
         6auVgVTpqI6MbrXbATi9MvDkw2JdpHbNVG86P5GYPUldgRQ9R24YVgVKg5VZVj3PN+RN
         CBLMpDzBm242T70W0c2H2TiM0s0xh+l8kjwaP64p7vPYC02ncTg6RTK5J7rs9PFVwoHQ
         6/kmFutOck5G4Qv2v7l15wKA4c/C7juIMccIUHa3mArjpgAjwhCeHTeS9zOyZNDdDq8Z
         4y4wRaMbn0dZ3laN+/OfjVJfAQIxn2Awa9d0GYzn06rbgzqCsPICh6lGCRQVx5ZtYIzv
         7ogw==
X-Gm-Message-State: ANhLgQ1zJU4nCF/aRHdVLMdO4fsRy8kKvYk/wR+uMmBgot8T9LuT7M09
        lcYtK8Ysoiq8LTz9haoCpY7DC29KfsA=
X-Google-Smtp-Source: ADFU+vs6w8kct1tcThb+jzogdABq0ciYSYoD+UF6ChWt7nEGXWVeMVQCXScb1CQ8JPgAQJE9oCbx1g==
X-Received: by 2002:a65:4806:: with SMTP id h6mr21853952pgs.295.1584998361963;
        Mon, 23 Mar 2020 14:19:21 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a19sm14495739pfk.110.2020.03.23.14.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 14:19:21 -0700 (PDT)
Message-ID: <5e7927d9.1c69fb81.46ad8.4de1@mx.google.com>
Date:   Mon, 23 Mar 2020 14:19:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc7-113-gc6e2eb7ccc3d
X-Kernelci-Report-Type: boot
Subject: pm/testing boot: 63 boots: 1 failed,
 60 passed with 2 untried/unknown (v5.6-rc7-113-gc6e2eb7ccc3d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 63 boots: 1 failed, 60 passed with 2 untried/unknown (v5.6=
-rc7-113-gc6e2eb7ccc3d)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.6-rc7-113-gc6e2eb7ccc3d/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc7-113-gc6e2eb7ccc3d/

Tree: pm
Branch: testing
Git Describe: v5.6-rc7-113-gc6e2eb7ccc3d
Git Commit: c6e2eb7ccc3d252115a7d8cba393770ec7366063
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 55 unique boards, 14 SoC families, 3 builds out of 6

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-8:
          meson-g12b-a311d-khadas-vim3:
              lab-baylibre: new failure (last pass: v5.6-rc6-104-g5e3ada361=
a7a)
          meson-gxl-s805x-p241:
              lab-baylibre: new failure (last pass: v5.6-rc6-104-g5e3ada361=
a7a)

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

---
For more info write to <info@kernelci.org>
