Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572865255FF
	for <lists+linux-pm@lfdr.de>; Thu, 12 May 2022 21:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358179AbiELTqk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 May 2022 15:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358162AbiELTqj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2022 15:46:39 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5EA4B430
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 12:46:39 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fv2so6136273pjb.4
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 12:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ljl52lAc6qvxuD277hapTPohMD5af1qmCuGkyF0+AzM=;
        b=BnuXrEZ3eoQlkpUAUsuJ7w1LNnhlLo3DHmoYrhz+yWoS3DdrPSyRZqTwBYuQKXyiP6
         V+bwxbsfVS1tqYb9+aOd+URIXEH8ds7ti4xByFqswiJaYzp+Adshvx2HIoZ8zpi45XDh
         aO6Ke2hfvwb2LP7h81OexUsHYttcEVpXvAoul5HXurdFFjOhuJgpbCsgK5EhDUkU/fkW
         y+QI6mGlTc7POV/Cg0XNvhBvj0UZYH2Y4QNtDJ57NpqZEq2W9ZJc8t1dv6pieseN0wL6
         JHMpvOf2QvA9MNdr+XICBY5aDDc6NJNpl9Siz7hspkoWu9UuXGciLQZZDDGeicEoz6fW
         nILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ljl52lAc6qvxuD277hapTPohMD5af1qmCuGkyF0+AzM=;
        b=K+vqJgesznpTC5BZR4YiHmH5SrfgouK3LDtwvlbIfIzgFUuIuBz6Gv109XbSS+4fej
         soO+oue7EhIhrlD9mfqGCTwhzA9UrjxsR3oiU8XAdrOszNwIYbJcQEdTrV+crT327aLl
         urKScNBHoLcbq9KCoL53vPb5jFMIuWjieGOZzioR1oxPGPAq1LCPez7dkL9X79v00JEj
         aj7U6/3Pb2EIHuVStb5mFT9+5GSbukXyKZvz4cGdNGmW2aypMWKAeRWTT4qwaKQ+uK5D
         gAWE1Enjp3jxvAdHKEKQ5GY6DcKBM9kkjGPX/XXnO7gkgZgGq1vxqUHKDyrJUfZCdacM
         fcUg==
X-Gm-Message-State: AOAM532Uf7vX7yVfFgOCsejiEMoGQqot5rG+0cMZoCGeDWNbkeBQ1nzZ
        hNiiUkfRB5utL4T1GBKYlkucJQ==
X-Google-Smtp-Source: ABdhPJxSH87q65JaL1CmssOD2xp3Quq6jgVud9ZqXyPqSOJDvO2xefKKAMxi+nNDv5vPvgV5y8YXkQ==
X-Received: by 2002:a17:902:f684:b0:15e:8c4a:c54b with SMTP id l4-20020a170902f68400b0015e8c4ac54bmr1239755plg.21.1652384798539;
        Thu, 12 May 2022 12:46:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902650200b0015e8d4eb264sm273345plk.174.2022.05.12.12.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 12:46:38 -0700 (PDT)
Message-ID: <627d641e.1c69fb81.4f993.0dff@mx.google.com>
Date:   Thu, 12 May 2022 12:46:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.18-rc6-123-g84d13b694ebbe
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.18-rc6-123-g84d13b694ebbe)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.18-rc6-123-g8=
4d13b694ebbe)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
18-rc6-123-g84d13b694ebbe/

Tree: pm
Branch: testing
Git Describe: v5.18-rc6-123-g84d13b694ebbe
Git Commit: 84d13b694ebbec55680970534f686d321bed8ae8
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
