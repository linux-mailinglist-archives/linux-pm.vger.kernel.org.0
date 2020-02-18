Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B241620B1
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 07:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgBRGOg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 01:14:36 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:39081 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgBRGOg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 01:14:36 -0500
Received: by mail-wm1-f42.google.com with SMTP id c84so1524385wme.4
        for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2020 22:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=o7+mPUtWkvMAcZo6X8o4Tr1W9/R/DA4wX6AmvYHjIbo=;
        b=NELpYC9kOKWZjKIZ2AvtlgMWOPmMCNj/HdTw5SNxjLuY9mLXbCRzJ87UBC+Y/L2xxN
         9qr2TKgqtfx9FjwELcgkMpKkVT5f1rVExb+sGReE5OGrBa52wk9sy7eODPNW6NIRrz6f
         x3f1pGezWuvGXBjh6IBiFOQLsCNy5Z2N8cwGDyEEt/0bQFtMZkf0iceo3QL2F6T8KHkG
         t+SefYZQ1VMWjg6+7edksOeMoWw+tNFcb1Al1SkG37wB2B3L0k2h9U46fd0vjTSb1SXB
         PdzDHjAAgKsudS8W7vXQOQtUWKnyWh0pP2zBw3m61KQiLbkg3+4z0lP6YGxccRFqrKrm
         998w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=o7+mPUtWkvMAcZo6X8o4Tr1W9/R/DA4wX6AmvYHjIbo=;
        b=sQtzZYBc7huodqWLZA8tD9FRkvOLONaGcroHyrje50dG6/nAa0Bf8NLJMIj5gYiMB9
         5xM7FW9KAwcmXxv3rPZX7omfzSKoH3a7UhoZgbcaPA60SVKvEjI0a2c84qVmQyTOzkHi
         5MqRC3jGW9PoqCW5GWB2InZNVHXdyg3SxiJEiU7dfjcTs2YyWXGR/KgUEwgJxBnDovxN
         eIcnY852URoHc+RnlCh+oRfGQkV/sL92jJesvCfur7Odo1aJoXdWdtIcXkZIYXrQ6P9W
         WQsWpjxJ7WW8hqI7yaTM4QWbmk282q+neYHQdnwt4M71NoxPFTThsiu7erdhsNudXqwr
         ++Ow==
X-Gm-Message-State: APjAAAVxirG3SPIvOM3fyeYIhYLP4Ncq7sWSZyGBqDDhqaPWtJ3CIOfn
        TMhe9YWIVi+gYIeZ3+AcXgHzSYWzPNPZ/Q==
X-Google-Smtp-Source: APXvYqyIFbND+0lHcokOSWOJkJ39E6tXNz/oDOh8SxYKsfBSqVUGeKRVGsW+6f+3MqmZXXR2tNn9DQ==
X-Received: by 2002:a7b:c249:: with SMTP id b9mr1028349wmj.74.1582006474889;
        Mon, 17 Feb 2020 22:14:34 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id s139sm2175535wme.35.2020.02.17.22.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 22:14:34 -0800 (PST)
Message-ID: <5e4b80ca.1c69fb81.341ba.814d@mx.google.com>
Date:   Mon, 17 Feb 2020 22:14:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: pm-5.6-rc2-146-g00b838d60ec4
Subject: pm/testing boot: 57 boots: 3 failed,
 54 passed (pm-5.6-rc2-146-g00b838d60ec4)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 57 boots: 3 failed, 54 passed (pm-5.6-rc2-146-g00b838d60ec=
4)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/pm-5.6-rc2-146-g00b838d60ec4/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
5.6-rc2-146-g00b838d60ec4/

Tree: pm
Branch: testing
Git Describe: pm-5.6-rc2-146-g00b838d60ec4
Git Commit: 00b838d60ec480d931f6209868e69e0d251000c2
Git URL: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 50 unique boards, 14 SoC families, 3 builds out of 5

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        gcc-8:
          omap3-beagle-xm:
              lab-baylibre: new failure (last pass: v5.6-rc1-10-g55fe2ef33c=
65)

arm64:

    defconfig:
        gcc-8:
          bcm2837-rpi-3-b:
              lab-baylibre: new failure (last pass: v5.5-rc7-146-g4529d29bc=
6a6)

Boot Failures Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab
            omap3-beagle-xm: 1 failed lab

arm64:
    defconfig:
        gcc-8:
            bcm2837-rpi-3-b: 1 failed lab

---
For more info write to <info@kernelci.org>
