Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9C6501F2D
	for <lists+linux-pm@lfdr.de>; Fri, 15 Apr 2022 01:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347719AbiDNXjZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Apr 2022 19:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347721AbiDNXjY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Apr 2022 19:39:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E953BBB912
        for <linux-pm@vger.kernel.org>; Thu, 14 Apr 2022 16:36:56 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q3so5949161plg.3
        for <linux-pm@vger.kernel.org>; Thu, 14 Apr 2022 16:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=vkA/2Tskuwywt2NDoPhPI2WTMPzsASIC1XyVW37wmlQ=;
        b=PT805/bpEYQkyXM3lPrdHMPNA9mapGjrsAzBhVCZRxb7bqMI4yBKmKcL1wEOPDcAvo
         wlCchc2MBN+u9k69RY1OOoogz87NS4SDO36m7nzWY+chw6TqgeIcIcQuHsuLsPeWJ/Fl
         SSdThuc1prBVnZ0g58AHsoqrxu1k+SGY2CaGRvhRWhZLzgedRLT69Md6RXMFzWWd3C7v
         rzbgT5lRezUrkSDuDztp35R5ZsPuKF4AMreBq7Qeiw/BPuz3y4Dv551ei0dpCiPmPKlX
         i0YaL3+dOhAa6T3hhMw7ouC4SacP+O8HQ6QigGtOsee9BFkpCMQGWhhGAcJTtzmfTykp
         r83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=vkA/2Tskuwywt2NDoPhPI2WTMPzsASIC1XyVW37wmlQ=;
        b=JeI5HVnViwLiNSOcutaYcaVIzqOMon2L2Io69Qczcy118I0vDEkdJ7Qu5ESI/9oSBO
         DevUKjA5j+68uA+66Ycy7vM3jQkCEkg7zzEvZdpXXvdxFlOeAM0bwymTaUw6NDHQwET3
         nfr5sRNRyox2GOfZZsXf9j7oRJJP1iF2MIpsQaAYifPz1FBr1jaUgmeAcbdnsxrMFyO6
         MnrXJZ+Ge3J2WApCGSn23P9f+loxpRjWBtw62GsNSIXtyidbfAzQ2awy5sXhGYoZT0gX
         RuestYIf8gevJZH5iMbVf3aX46NYtr3YXUT6q50oVXO5sIGrVUKd9S2MksiWSEnbv9vP
         3t3w==
X-Gm-Message-State: AOAM532I/5doce4umrLvxGeTttfMLJET410V4+vEF2YNSAjre9JaQMfC
        ofYBGHo6aC8lecvuP6OOLFbL1TJh7D6u1x5U
X-Google-Smtp-Source: ABdhPJyI5bnRX104SwroW8bQ+njHjH6oYA5t9y4znrXinq/e2kM7xUlmQuDj+YNuvDq0JxPjr+Ae/A==
X-Received: by 2002:a17:90a:4749:b0:1be:ea64:4348 with SMTP id y9-20020a17090a474900b001beea644348mr1038584pjg.231.1649979416281;
        Thu, 14 Apr 2022 16:36:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090a1c0200b001c994db1960sm3204507pjs.10.2022.04.14.16.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 16:36:55 -0700 (PDT)
Message-ID: <6258b017.1c69fb81.13c32.93ff@mx.google.com>
Date:   Thu, 14 Apr 2022 16:36:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.18-rc2-76-g5675fd487f2b2
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.18-rc2-76-g5675fd487f2b2)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.18-rc2-76-g56=
75fd487f2b2)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
18-rc2-76-g5675fd487f2b2/

Tree: pm
Branch: testing
Git Describe: v5.18-rc2-76-g5675fd487f2b2
Git Commit: 5675fd487f2b221a27a44f6ac78bdb2e5f235052
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

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
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
