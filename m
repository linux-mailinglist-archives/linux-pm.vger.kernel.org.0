Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0669116F00A
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 21:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbgBYU1d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 15:27:33 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:45246 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731685AbgBYU1d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 15:27:33 -0500
Received: by mail-pl1-f169.google.com with SMTP id b22so259995pls.12
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2020 12:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=S5oUMpsF6Uny5QKssNaEDMFWEUqiksVIXKR0Nwhan2Y=;
        b=Gk3roYzxXGZJLjgpGHEYSH5JLIMEOm8y0T9LSQRWuaye55UmdIuMbiYwkStLJk9MKv
         2wAudrXrKtp/nqOcMRWI1Aw55vun3hDLEPQ2I6D3ipxLleJOC3jEoTKNRaiz8MMC+Keo
         dQvCpI9lS5ldfUsA4rfilbbOfYT6b4QMmEY65ICkIV9hTFGPtRZnWnbN7J2SyKwlBqKi
         5cpMhFokWZ+h07MfXDF0hYOQNwBCqs08puB/rM7pVBOoMSlBQjoMQHrgjQLXfKX8/FcN
         fALKVyLXzVRGv29UvYelOluqA2DFvfrjkePyKH14KkgVggoc/f/ZOtxYhMDENc+tOhBP
         RmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=S5oUMpsF6Uny5QKssNaEDMFWEUqiksVIXKR0Nwhan2Y=;
        b=FWz55HtFR9UzQh+1l8OO1h8K+rb8bOH8o6aCvJNJFv1lKJecOaBhvCC7fyCnMd+41h
         qs+j1LCKKhDM4oLHVixwUE/poXVmpBmuXOzTMFHZJ2DZ2+k29ybsaKegXBsG+08Ittls
         OmHc+7Czb045QXSsBLAW7eCSF9+heMYch2qZsEq/mpBOHzyEFkPpURStR12Q+/StWaY+
         QHYX7bMOuElma3ToNIiSgLJt9a5n3hOWL1d4szTlXm3sBcKMF01CMZq9BtOWtTxXk+7K
         n7Bww2SMUTTiPRJ6hNmH/iYdCPCCaqy/A/I90klNAEhvHioa9ENpYQrIp9HlKhhw2P3o
         /QeA==
X-Gm-Message-State: APjAAAXxcRjqh9eBW2MGSL/Os6z/IOuzZRZWmhTxq+o0J5Xq9d1kbzff
        6dril4yvoCyhNNGhQXWDRCFJM52SK5k=
X-Google-Smtp-Source: APXvYqzZgp4id+umWsoTZv7WY47djDJRMyjhKQIzhL4Y+4k4iHh+aGlG0zz930+srl808RFbQLWIBg==
X-Received: by 2002:a17:90a:8008:: with SMTP id b8mr877171pjn.37.1582662452683;
        Tue, 25 Feb 2020 12:27:32 -0800 (PST)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e6sm17818146pfh.32.2020.02.25.12.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:27:32 -0800 (PST)
Message-ID: <5e558334.1c69fb81.25a22.ec4a@mx.google.com>
Date:   Tue, 25 Feb 2020 12:27:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.6-rc3-52-g49d2c63e171c
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing boot: 58 boots: 1 failed,
 57 passed (v5.6-rc3-52-g49d2c63e171c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 58 boots: 1 failed, 57 passed (v5.6-rc3-52-g49d2c63e171c)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.6-rc3-52-g49d2c63e171c/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc3-52-g49d2c63e171c/

Tree: pm
Branch: testing
Git Describe: v5.6-rc3-52-g49d2c63e171c
Git Commit: 49d2c63e171c150bb9683c6660121e596e9e1a39
Git URL: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 51 unique boards, 14 SoC families, 3 builds out of 6

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

---
For more info write to <info@kernelci.org>
