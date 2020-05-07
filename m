Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8931C9DD8
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 23:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgEGVs2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 17:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgEGVs1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 17:48:27 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05CEC05BD43
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 14:48:27 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k19so2614520pll.9
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 14:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=OiiMErayrk7pRttgMlz3KapfelXoMLv5r9gaVUkPpyQ=;
        b=fC2iINLc9ZqjdGlC7VImAaEDmHP7mmrZac3Bd25cayhCwXpxq7yaklOZFyMLexmyYE
         r3Ld4PibBtWHHP1fAa4jx7wWOFAc4NV8WoBvge1sJ7qTsIQefYNJXw/jsaDGKOqaR7WJ
         4gEgbzLuYCoJ0HBApVOBAl/LzPN7hoCpOpVH+VL47rgQcpo+8WxTvoMuy7o+KnZk0K4z
         VKrWm/stIazIbGGOvP3u+j/CNHuSYcr1qZwMWafxsgDKMbcIkoSItPzbxOYMITVP9ezI
         5SUr8W35PUc9GHT3lSsUR9uiAlB7uXL0K8qj8z0eFAoK1Wjq7G6ECaNwqqehdr3O7sBc
         lerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=OiiMErayrk7pRttgMlz3KapfelXoMLv5r9gaVUkPpyQ=;
        b=SVz2k9vkd3xYO5YCiCcHKneOxY8lRSxSQeV3UC3IsLzKfHnOrTBh7VwFOPp1gPZvwa
         apt4tmlzC763tUZSCpjD1yjt8j3Wlv1YktdxkfqVhQ75Cd/WvfEkisZw/GwplxnigSc3
         u9LqK5pn7P+zFcaheRIhdS7YGDS6/L96z9RhB5rmsJe5RUd0iy53kqqPqwKSBZnOn/ZP
         N9dpazZ4sgnTWc6Jg2uQn+P9S1wd5pOe+kA978eI7nj3Kp+ye2Ur828DHWEIb9dGmEvs
         0GiN/XjzlevSTbV4J1Qj7Wq6MTZQaXbH9W2WRNVDrXyskYYIOnI5YCsX6xxUrkMKYBSO
         knig==
X-Gm-Message-State: AGi0PuaLVUMBmlNjl3fvK/iXQP9yreDXKcsZ6Ukf8j+n5BnnhPS5ZCLD
        KqUeKxIMoD3wia9DKa3lS335CI1IZM0=
X-Google-Smtp-Source: APiQypKDTdcOSyc7m6vgH4hrACj20AcOUFcduO8gsgK04G9nf/OS4zCJW1YaYwso1RhBHNSgvlJcAA==
X-Received: by 2002:a17:90b:885:: with SMTP id bj5mr2201471pjb.5.1588888107260;
        Thu, 07 May 2020 14:48:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w3sm5650757pfn.115.2020.05.07.14.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:48:26 -0700 (PDT)
Message-ID: <5eb4822a.1c69fb81.7bd62.30e1@mx.google.com>
Date:   Thu, 07 May 2020 14:48:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc4-21-g5b45c277ddc3
X-Kernelci-Report-Type: boot
Subject: pm/testing boot: 58 boots: 1 failed,
 55 passed with 2 untried/unknown (v5.7-rc4-21-g5b45c277ddc3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 58 boots: 1 failed, 55 passed with 2 untried/unknown (v5.7=
-rc4-21-g5b45c277ddc3)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.7-rc4-21-g5b45c277ddc3/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
7-rc4-21-g5b45c277ddc3/

Tree: pm
Branch: testing
Git Describe: v5.7-rc4-21-g5b45c277ddc3
Git Commit: 5b45c277ddc338e5236f44f9be4a64ff904ec9b5
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 50 unique boards, 13 SoC families, 3 builds out of 6

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        gcc-8:
          am335x-boneblack:
              lab-baylibre: new failure (last pass: v5.7-rc3-24-g1985b45de0=
14)

arm64:

    defconfig:
        gcc-8:
          sun50i-h5-libretech-all-h3-cc:
              lab-baylibre: new failure (last pass: v5.7-rc3-24-g1985b45de0=
14)

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

---
For more info write to <info@kernelci.org>
