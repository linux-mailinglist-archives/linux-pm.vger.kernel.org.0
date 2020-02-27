Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3168F17297D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 21:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgB0UfC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 15:35:02 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:38498 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbgB0UfC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 15:35:02 -0500
Received: by mail-pj1-f43.google.com with SMTP id j17so280125pjz.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2020 12:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ndi6NaIW9dgyrQq9bABIny8MS00xqMlr3q1Jp+aE9/Y=;
        b=AJ48DkWeCz/AAJ8uuzFiF+wzLYJRrWHxVkwuhLJXXW5qVmmjIDfjxGbKoTIeFd7IRI
         69NpCH8N0nV5To/oMlwYfDTREd8z4j0Q43cvEVYQzCZeEaJo/m4TI0dxXC35n4X+MObK
         gWHzhrWwuJvTl8zEu1cMjeuPlCcA04mVurJ/InkiCsXxj0n6tUQYQuX8BwK5h1l+0F/r
         15wtAODB3cT6POACe8mHnKGrKTsoipemSzsa+RJecCgQl2jKKRXWc50KBs4WzunSUq+a
         RHunUsMPxq0GDTnb7A0dS/lXOMIf0GHs+dwx5yRQy17sQ4efZ/SUZpGZn2O/4Wjpq+1o
         NVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ndi6NaIW9dgyrQq9bABIny8MS00xqMlr3q1Jp+aE9/Y=;
        b=kaW6Ly2rEPbZZANdWXMVExwPU8BeUF34/wSEt95pbsn06P1H+MsZTjjyTgAy7jn09Z
         Flq6e0Lqe7nsqcGFnUW4sjVmUW/n7zRHFk/iLo0kxXbyPHM87VafS+09jHFadtm9oDt5
         Ul1XXyyGUeWFybACHtOL8SAqKfSQCMIwp6YyUPoB7EtmSpD+yuCdpF+EokXWHmUNEB7y
         4TDVPu8LuAennK6X3UiMwL53/xBqhqeRJAQXougq2vp2KB2E4JMB0HndwWTbocgCtVbZ
         i0Oem6gI0ahhuktXkxnegLe3eQNCdAPTrx+1I51qPyaF3t3Qv3yN4PiYMHoMaUr2l0bg
         Is8Q==
X-Gm-Message-State: APjAAAX4SmSzQ8eIKyK9w9w8UasHiAxeb3Lv/Vg9HHQG73Gb6qWRFrlA
        68HDUXAKIoft43S7TcjBZAlOVQ==
X-Google-Smtp-Source: APXvYqyMI0SBTa/3bJfjR72s75rqX6+5rQpRQVvyQT1AJrtUTp/xSkPqVkbyxrxB5sF8AWH1w1JXtA==
X-Received: by 2002:a17:90a:332e:: with SMTP id m43mr760613pjb.107.1582835699475;
        Thu, 27 Feb 2020 12:34:59 -0800 (PST)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q66sm8511055pfq.27.2020.02.27.12.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 12:34:58 -0800 (PST)
Message-ID: <5e5827f2.1c69fb81.e1250.5cfa@mx.google.com>
Date:   Thu, 27 Feb 2020 12:34:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.6-rc3-67-g146605da90d7
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing boot: 58 boots: 2 failed,
 55 passed with 1 untried/unknown (v5.6-rc3-67-g146605da90d7)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 58 boots: 2 failed, 55 passed with 1 untried/unknown (v5.6=
-rc3-67-g146605da90d7)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.6-rc3-67-g146605da90d7/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc3-67-g146605da90d7/

Tree: pm
Branch: testing
Git Describe: v5.6-rc3-67-g146605da90d7
Git Commit: 146605da90d753b81f95829c7f13bfa02f46ccb1
Git URL: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 50 unique boards, 15 SoC families, 3 builds out of 6

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-8:
          meson-g12b-a311d-khadas-vim3:
              lab-baylibre: new failure (last pass: v5.6-rc3-52-g49d2c63e17=
1c)
          meson-gxl-s805x-libretech-ac:
              lab-baylibre: new failure (last pass: v5.6-rc3-52-g49d2c63e17=
1c)

Boot Failures Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

arm64:
    defconfig:
        gcc-8:
            meson-gxl-s805x-libretech-ac: 1 failed lab

---
For more info write to <info@kernelci.org>
