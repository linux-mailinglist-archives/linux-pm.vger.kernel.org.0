Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760B676B561
	for <lists+linux-pm@lfdr.de>; Tue,  1 Aug 2023 15:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjHANEF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Aug 2023 09:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjHANEE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2023 09:04:04 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3F5E6
        for <linux-pm@vger.kernel.org>; Tue,  1 Aug 2023 06:04:03 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bbff6b2679so17227855ad.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Aug 2023 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690895043; x=1691499843;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hvhpTUk/JRtUY+N5qYQkgvwpooY/V54upUMhIP4I4bk=;
        b=fPSOuIA2fVBPE0HhGWXTQnIFaBBjabnUuu6YejmZor2OWkfYjIqp8WArCOI94nUtfX
         WHPOulSEuYojgghEUlxVXTLnkDx4vX+q+BQjBUR2WIUueegGPLRFZXsEDOE2pPWojnUm
         hjNDE/zpoAtF9AG5e1M2JaYf7ss2TqHwYm+4xnIJTyoA3D7EDFR673Z4kcGJb/J2xzyH
         3el0mnB3cnRaWii7p31L61dQvKbkSwDDdMoqBk3fiMVFA4SNxmZgV/8SK/xtbTN8AlQv
         rZ2iOnSbP7VFEd6c9paGbShT85gcfYz40dJwQm+CgyHcSkHJtZuKR0lcvRuSTyz7/SVM
         AXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690895043; x=1691499843;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvhpTUk/JRtUY+N5qYQkgvwpooY/V54upUMhIP4I4bk=;
        b=XHdeiwORqzzMARg5CPUSQHG65qhzBtWSCfa7kcsza3vLFW4aRepvU7CM48A9T8oOJA
         rFUnZkkZNujmLbYZ5Tp+BsJhV7MdtSUCCbMikwa+6Cevlw4KI2+VApIo4lN/J+dOfIwG
         68wPc34gnqRhEC3u0R5YYN54vdiYMjOgxB/jjmSDcteOIUoWwoftSY951nD4b3RIlrvd
         JsCYoHC/PEurzFG7IvDRJAGwBz9YpaZ9KMI1xsuWgmsBGd282uJskQUyOHf81PJ1wAFF
         EMmQjGfPYxVnjIECiEfkqxfTHWXNqvkf5vL6KM739W0yoNSCOmve2PoSeb6OGJVSBpSM
         ACRQ==
X-Gm-Message-State: ABy/qLbDu2TMCQOCJqzS7f7u8F71xI9zbdQY7YuouQkHbiYQyTznXLcW
        /lxuGfTdSq6ZmNb5TdbIgAqQkw==
X-Google-Smtp-Source: APBJJlHyvqXllyc2C+YQBOMD7FF1Suv4ZP0g8UA6E5r6kcRFcqIKFN6nc9+oa1217inUHTQwwSCMQQ==
X-Received: by 2002:a17:902:c94e:b0:1bb:32de:95c5 with SMTP id i14-20020a170902c94e00b001bb32de95c5mr11838900pla.65.1690895043212;
        Tue, 01 Aug 2023 06:04:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e81000b001bc05774004sm5050732plg.236.2023.08.01.06.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 06:03:59 -0700 (PDT)
Message-ID: <64c902bf.170a0220.e7d90.9d90@mx.google.com>
Date:   Tue, 01 Aug 2023 06:03:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.5-rc4-58-g7e5258db49000
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.5-rc4-58-g7e5258db49000)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.5-rc4-58-g7e=
5258db49000)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
5-rc4-58-g7e5258db49000/

Tree: pm
Branch: testing
Git Describe: v6.5-rc4-58-g7e5258db49000
Git Commit: 7e5258db49000c4ff5c1b3bc596c2d92e40d6edc
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

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
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
