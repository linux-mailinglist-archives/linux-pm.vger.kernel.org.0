Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B476619353E
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 02:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbgCZB23 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 21:28:29 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:54830 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgCZB23 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 21:28:29 -0400
Received: by mail-pj1-f47.google.com with SMTP id np9so1790670pjb.4
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2020 18:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Os3I/j7hPLGSP+WU8EePny9ffFvqu1GiqThLVUiaIJo=;
        b=cQ4mkPMiaijRXc4CYB4tpisZNgEyd6Y1hp1spYhroZ6UGfZ9ZfC5RGosjmXHvOFLe3
         rbuE6M+fechFP/00dgok3gyvw1ZgU+FfD6ihYIRAi8IW/yHXQihpLqwWqmlMzvE3OLPq
         k64IjbQtXw2rIN7dRRDGTLkVdwIgzU4B34O3T+jTullWWIZeppTX2tw8Wmlz6dujKe0Z
         M9oPY3oFsqTmM7frAhTO30AT8P2ERtKv8rFQGxdTvZU0fDoiyaV4kQ95tPdHi3Y/2Ddg
         zqF5TnbXt89xPqYYniZVXwopAwfQLhR4aQqXpoo8qLE7pSgcSCO0ORWi8S1GXxRDyx/Y
         Ocnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Os3I/j7hPLGSP+WU8EePny9ffFvqu1GiqThLVUiaIJo=;
        b=eUSZdDKaByK14Jg1Qg88xjeJR2uVR3mHerDVbA1IbjcGWxY1KoIkT4TrbBXV3HWGia
         Q4qk0Y7Ic8IOaM6VEir2Y0cClyqO7uDN0t7HNcQ+yv7H+QJazj9uBT8ZkgoQ5ribgBun
         EBo0VgKURzt7xZZpD1si78/uUtR5nUkdJU7skebYMmBOntpdZ00KS1EdCOlBBnPtg5KB
         eACjSsCAtAd7TMXBgWlEG5HeOCkjuuWk8UI64VQRvoSMFFEDFIpYYOYcdRE9xaW8oyey
         GuoWfWDpwa/rEKERLv9U2CY3vQY6MHu0pGPwy7USlFNVxWQHT8wx7M7t1PKfVQlo1Vlh
         1kSw==
X-Gm-Message-State: ANhLgQ0cts1dWlWy2RecXnYyVvDEQ0gFZuE9QcbvMOBTXm4i8mKODLEv
        ZveuKdUr6rbYaGsNrNrP/EZP5OfH5+4=
X-Google-Smtp-Source: ADFU+vswrXsU3HlQytgfXs+mecu7RhdCn66gp43PsLMFqbUpwEqyXJ1CJ0QZ3vbSpgrAXT0gwo02Qw==
X-Received: by 2002:a17:902:d201:: with SMTP id t1mr5871500ply.312.1585186108604;
        Wed, 25 Mar 2020 18:28:28 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k3sm304194pgh.34.2020.03.25.18.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 18:28:27 -0700 (PDT)
Message-ID: <5e7c053b.1c69fb81.d0b18.1c77@mx.google.com>
Date:   Wed, 25 Mar 2020 18:28:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.6-rc7-121-ga4c3e5efdcaf
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing boot: 61 boots: 2 failed,
 58 passed with 1 untried/unknown (v5.6-rc7-121-ga4c3e5efdcaf)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 61 boots: 2 failed, 58 passed with 1 untried/unknown (v5.6=
-rc7-121-ga4c3e5efdcaf)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.6-rc7-121-ga4c3e5efdcaf/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc7-121-ga4c3e5efdcaf/

Tree: pm
Branch: testing
Git Describe: v5.6-rc7-121-ga4c3e5efdcaf
Git Commit: a4c3e5efdcaf10511f1f8e03f59133fa32bddff1
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 53 unique boards, 15 SoC families, 3 builds out of 6

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-8:
          meson-g12b-a311d-khadas-vim3:
              lab-baylibre: failing since 2 days (last pass: v5.6-rc6-104-g=
5e3ada361a7a - first fail: v5.6-rc7-113-gc6e2eb7ccc3d)

riscv:

    defconfig:
        gcc-8:
          hifive-unleashed-a00:
              lab-baylibre: new failure (last pass: v5.6-rc7-113-gc6e2eb7cc=
c3d)

Boot Failures Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

arm64:
    defconfig:
        gcc-8:
            meson-g12b-a311d-khadas-vim3: 1 failed lab

---
For more info write to <info@kernelci.org>
