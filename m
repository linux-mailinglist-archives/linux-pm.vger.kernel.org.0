Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25975194B84
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 23:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgCZW2P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 18:28:15 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:34547 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgCZW2O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 18:28:14 -0400
Received: by mail-pl1-f173.google.com with SMTP id a23so2712489plm.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2020 15:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=MnB8G6zT4My/FtGX+h5sbemfJUiXQbKKI8srhVUxCbE=;
        b=STDgf4TNecr4kJinqbydeB3lNot4UdR1UU3IMwpytMX6CzJtAAgs3X33yjVe58ZlR2
         yzQxIo9A43pxwWg9ZO2k766Lyxp6imsRJ1vzDXD6+O+vjrc5oByUZkEiL4EI+F91tHbQ
         f8Lk+7yIq+7bP+3D3+0rW6wgXrRg5GI/5QYaG9bdgaKJh4Qam+zXqZLiGJEh/b6tVYH9
         MkYW9Go4FMGmXKZMlvGFB0DjXI4HmkC8/Vwk0/wn3gmfunvfw8wDT93QC8rzHJEzNr1C
         G7sxa3rPWTjSsg5JTWu9XkvghPkdKeyzxjVaeNxIQMzgDAXZDqxoYBL7q2i+mJmXk+TO
         iyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=MnB8G6zT4My/FtGX+h5sbemfJUiXQbKKI8srhVUxCbE=;
        b=DDQte4FTtS0w1gY0HhR8YhJRLAYV+V+4l+6LdkKibkc4DtLy2uSTO7xi/xwO+ZpMRt
         w8/K/KBh7XSijuygJSgGbR6bST1AFPGI0PTTeAmNOTeS5aCnz6g/rwCknAnA2Yql86xu
         LRHjTzwMNoznFC1N3fZ/HzudYjqJbUzvMvFiKQdYFDZTKWFefYtBI92FC5HV3Wr4mxwH
         93Fvz/MUhfTS/mM2NvM4rPNcdmAEDxK9zgDninND7HnC/KOD/PtM73CLSYHBXnuc5CUW
         WaRiG4tJhCx2RIVmUoiriug0afbuP4hCMOnUhkSlL/zGzYZ2kByM1Pgm3q0xFV4lgQOu
         S7dg==
X-Gm-Message-State: ANhLgQ1AlHtQr0Oq7DyMGiy/RY9KH5djG/1YHhXkw5NoQ0YB5vMOMJ66
        W6BqEng1u/bxpOAIM2S54uW0pQ==
X-Google-Smtp-Source: ADFU+vt7NQicAsEj1myNiTCbyGgmlzsuTJxKJezsR/GL6IrbhUNrLyOqUX2bZQ8D7l9LCO8qW1wd8Q==
X-Received: by 2002:a17:902:a701:: with SMTP id w1mr9393579plq.165.1585261693434;
        Thu, 26 Mar 2020 15:28:13 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z17sm2534513pff.12.2020.03.26.15.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 15:28:12 -0700 (PDT)
Message-ID: <5e7d2c7c.1c69fb81.b4f9d.96ae@mx.google.com>
Date:   Thu, 26 Mar 2020 15:28:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.6-rc7-129-g8b4ddf47b7b4
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing boot: 61 boots: 1 failed,
 59 passed with 1 untried/unknown (v5.6-rc7-129-g8b4ddf47b7b4)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 61 boots: 1 failed, 59 passed with 1 untried/unknown (v5.6=
-rc7-129-g8b4ddf47b7b4)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.6-rc7-129-g8b4ddf47b7b4/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc7-129-g8b4ddf47b7b4/

Tree: pm
Branch: testing
Git Describe: v5.6-rc7-129-g8b4ddf47b7b4
Git Commit: 8b4ddf47b7b4dd54539f1821c95a8dee3295fb0b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 53 unique boards, 15 SoC families, 3 builds out of 6

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        gcc-8:
          sun8i-h2-plus-orangepi-r1:
              lab-baylibre: new failure (last pass: v5.6-rc7-121-ga4c3e5efd=
caf)

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

---
For more info write to <info@kernelci.org>
