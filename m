Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B184E422EB5
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 19:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhJERIv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 13:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbhJERIu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 13:08:50 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E675CC06174E
        for <linux-pm@vger.kernel.org>; Tue,  5 Oct 2021 10:06:59 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s11so20358736pgr.11
        for <linux-pm@vger.kernel.org>; Tue, 05 Oct 2021 10:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=zONIJ7ZOeOqmkJQh2GZRx4O2LKB30dUUGWDxxKf0nlk=;
        b=FaEsJeNULLnoKCDQ6DA5jlJi5QuI16D04bqsr5L9ev7w3rHoMlDKVOJ5YK3P0UJoCu
         dvUJGMzSQQmvZVLYRwl9jTHoWn+mumCKRURGdFL94yn2vmj80Bmkgzt2QzgArzL+Qnr1
         8th28l80AlFdLu0bVQPaZHH3hqfjMEQxdPuREa+u/FwLWvXSe8pjKpQY1UXyccJ1KHBk
         LPy4QwIsIqSQz7IckOxN3jfXMI2ARhWMG3ykNcZarVlYU4TuZXcMAsZ8/FvJ/KvvFZPi
         x13OqLXMS0ppkwmyPJywwR+qGjXeWtbM755uV56nPjhLZ398YIjmS1pr8IfdYkmOUVLm
         BqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=zONIJ7ZOeOqmkJQh2GZRx4O2LKB30dUUGWDxxKf0nlk=;
        b=ISzl7TxLHIBjbmaDzwsYdXK+FhdEUIX0cQ035OQpv4dUBVKe4m7AuLMX5jvIaAlrwD
         c5ORWeu/GMvgjBeNmCBWgw0UOjI7fMgGK2NAl/NEpd8cQDT/jI2U9yqibSC74DSG0b+E
         MGcaNyEqKN3aG2jIs09tzeFHJYsDY6M5DwmYTVfIt6XAsAshBG3d/VmPkP7NrXEV1thg
         wHFi9TY+bAsn94JnBjfI5Njd4Ba/5e536Xyv3RRprC2S6bj2XckT6zSjWuZcTKfRTKV5
         ECTI8F+Ov3LURxdd/o4T/omIeMsTSsoQCsV2S2ikz4UUpkKePwIl5CgavI/acgm5X5Xz
         Hurg==
X-Gm-Message-State: AOAM533+ah9KWY5nPI53SP3+xYuH9jM9oKd1LjUjP5sZ3SF7ZAuOiFEB
        vkXJvYjW40ix+LaBNrROI5FvSeip484vNzrb
X-Google-Smtp-Source: ABdhPJyztD/R4ygpBLwdDAF7rLHmAKDum9bP0qhWWGTs2C6JFfRYHEnxfNNuOa4TU7hHIjPECJtQxA==
X-Received: by 2002:a62:9215:0:b0:44c:4de1:f777 with SMTP id o21-20020a629215000000b0044c4de1f777mr16420242pfd.31.1633453619416;
        Tue, 05 Oct 2021 10:06:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z9sm18523883pfr.124.2021.10.05.10.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 10:06:59 -0700 (PDT)
Message-ID: <615c8633.1c69fb81.d147.8610@mx.google.com>
Date:   Tue, 05 Oct 2021 10:06:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc4-24-g8e0efc215fb1
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.15-rc4-24-g8e0efc215fb1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.15-rc4-24-g8e=
0efc215fb1)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
15-rc4-24-g8e0efc215fb1/

Tree: pm
Branch: testing
Git Describe: v5.15-rc4-24-g8e0efc215fb1
Git Commit: 8e0efc215fb15481ac2c12c7e11ce2d7d2803691
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-8): 1 warning

riscv:

x86_64:


Warnings summary:

    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

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
i386_defconfig (i386, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

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
