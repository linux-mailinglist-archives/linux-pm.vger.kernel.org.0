Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A45B179DF1
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2020 03:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgCEChU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 21:37:20 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:34688 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCEChU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 21:37:20 -0500
Received: by mail-pl1-f182.google.com with SMTP id j7so1963003plt.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2020 18:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=lLDavdix50srCAmnrFlrZgsl+8+n4YlRA6GQM2LKbz8=;
        b=NGtzLUIgslO23TYTLa0YB7trbhnoTPk3DX7wdXMhVHZwT0PV89Fw2NHI3ki3Ke0vSS
         1ky1UHN2XC8uoAw05GRfYz02hmWI/ZEBSLuET+w89cx1KgPEx39m+Dhm0hJMItbKTMxY
         mHYcBD+Wg/746+Ih8UkVpPZmRijfcX+9lD/kzZ4NqyxWW94kbUXGItP2xQ3NNPeH+gm6
         zPURWih4Cc3+kJsmsdiUdiM2GOulqgB8YbC++z57/WlvhWsZWRe3wUu8SClJa041VLKw
         nI9MyA8SkHrVc31hr7oJFK8RiKldwGVCn9HAEfFeTPyoXGdXMIkwDUe4HLn36hEQccbO
         hREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=lLDavdix50srCAmnrFlrZgsl+8+n4YlRA6GQM2LKbz8=;
        b=Tl0LyLGz5L+yQEwfzaOMbgQQU1PD9G6D725hS+QOcSHbKJgwrztNqF3YP5hQNXiahf
         3sQL96tSowjky66NAy5Zno7N6cfQLiClgvz2dpKZIuD2xD4brpmWH8mD0X0GkKx1YlBw
         Mo3XNtEwe0dSKkeK5ha3yFBSCfDYxYO+SzAOq/D2OnxAIywKJhL2OFINFWg/DiNhBE8g
         t2jrUdlioEw0FhnPSRCYwJvX4z+zxGFgErkySG+OxGqzcRGjW98vh8/GVEun8mAOWfCf
         GZjbBDfkV427SHiXE/+pPqFD80VF1eyfss5fPDHTxnsYrWOPUe4wKC+twQpZFvh4Cnb0
         IpgQ==
X-Gm-Message-State: ANhLgQ2SIBWGqA3ygciXoHD6SElo7HK+TbijqN744VUlzlSYu3e2bA2f
        Oir/lVJBbKZvItd0Ri0+1MOtWw==
X-Google-Smtp-Source: ADFU+vvxqliv+dDWac/kad10CcStJaawW2caGY1L2FyFTbkk99DG6LJgacqiWdrZ8Je94FoON0Qinw==
X-Received: by 2002:a17:90a:9ee:: with SMTP id 101mr6200241pjo.74.1583375838894;
        Wed, 04 Mar 2020 18:37:18 -0800 (PST)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k24sm26763904pgm.61.2020.03.04.18.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 18:37:18 -0800 (PST)
Message-ID: <5e6065de.1c69fb81.5ebe0.7355@mx.google.com>
Date:   Wed, 04 Mar 2020 18:37:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.6-rc4-67-ga76a126302eb
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 6 builds: 0 failed,
 6 passed (v5.6-rc4-67-ga76a126302eb)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed (v5.6-rc4-67-ga76a126302eb)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc4-67-ga76a126302eb/

Tree: pm
Branch: testing
Git Describe: v5.6-rc4-67-ga76a126302eb
Git Commit: a76a126302eb84e78d7d3fc9c7e69487fb97e8e4
Git URL: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

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
haps_hs_smp_defconfig (arc, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

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
