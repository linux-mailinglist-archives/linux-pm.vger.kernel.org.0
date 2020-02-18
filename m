Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8873016206C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 06:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgBRFao (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 00:30:44 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:54103 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgBRFam (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 00:30:42 -0500
Received: by mail-wm1-f54.google.com with SMTP id s10so1426344wmh.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2020 21:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=xwAAryIBOhVnlM3Xd/zFlwBj7/AWfasXLCJDF+2ZH2E=;
        b=RQHQKmkJJxw+c6XJW/iAl5tllzhn/pqBys30d9vzRId++eRLoLF6VDYWfTD5sfyOWZ
         WRAurulznYvMhA7WOeKj95WaYyrq5MNN0F4UOQRzd3173RYPQUIxBMnaSmsibxRlSmB1
         9Rm254iE1XdNHJhCEyBq3naKeD3Rc2BUMP4hVFJ92rGrs03QEH6jAuRzZM0t5qpjfJrg
         q8cbf37T4iVJgKQT6WWqGme0dNdgtZO0jC1NfXyj1FNxcxJrqaTz6jVbIBmOZNyYUdQ1
         L5FgpH1GsFq0pBeaVa/s34jvmx1RV+/NhI8aQynJWNafs8oOixtj0Z9xuDAUw/pEdbci
         g8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=xwAAryIBOhVnlM3Xd/zFlwBj7/AWfasXLCJDF+2ZH2E=;
        b=rn7Q3o7Vl1PcdbKiwvNCdU8xF6DcPCMrFUZ/6Yrqnz1VGE9cBrj0POEvR/zWboURW5
         gxAzt2ncqfoCTXGFgRVMafVfmupLeBV3Yo0REVaIFXfA5Y0K11PSqrT/ZWHK8sjI2BHF
         lwT0LVzuM5PGDvToj/q/AYlhOVxOdWAUDGSZQk0IEeG7g9A/GAs+DBpGDv3dIQQvg9mg
         K1eSOYF1WHaRxxRqcGUPx5GiYBLESNBoQt3LI4hCRFIcSUj9nagw8nyfF0c74eWVRGBP
         7xkfNvpGSOkYAhASQDEt9TM1FwmroilT6DyrB1yengin3iZH9bypqz23AbHp6C04CZn4
         vjXw==
X-Gm-Message-State: APjAAAWaR1pyXVpiDBkLEDZD6q3ah4ds4ps6BqXrrWSC2lN9Vxv69VNo
        JpCRyjlQEBByfz/DK8WpgDAgFm+fNg3lCQ==
X-Google-Smtp-Source: APXvYqw/u/7f86CdhiK+QW3Y3iFq6NQjnzdbrgEoshwlA79+U6TZRzKpUauv2oDPmaW7Vx1kIySpfQ==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr795204wmi.112.1582003840363;
        Mon, 17 Feb 2020 21:30:40 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id x10sm4222786wrp.58.2020.02.17.21.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 21:30:39 -0800 (PST)
Message-ID: <5e4b767f.1c69fb81.7401.20cd@mx.google.com>
Date:   Mon, 17 Feb 2020 21:30:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: pm-5.6-rc2-146-g00b838d60ec4
Subject: pm/testing build: 5 builds: 0 failed,
 5 passed (pm-5.6-rc2-146-g00b838d60ec4)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 5 builds: 0 failed, 5 passed (pm-5.6-rc2-146-g00b838d60ec=
4)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
5.6-rc2-146-g00b838d60ec4/

Tree: pm
Branch: testing
Git Describe: pm-5.6-rc2-146-g00b838d60ec4
Git Commit: 00b838d60ec480d931f6209868e69e0d251000c2
Git URL: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 5 unique architectures

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
