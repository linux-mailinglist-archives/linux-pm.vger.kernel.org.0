Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAABB3C653D
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 23:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhGLVD0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 17:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhGLVD0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 17:03:26 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D039C0613DD
        for <linux-pm@vger.kernel.org>; Mon, 12 Jul 2021 14:00:36 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p22so4637476pfh.8
        for <linux-pm@vger.kernel.org>; Mon, 12 Jul 2021 14:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=mKVYQ6K/sHmv2ZUNAfztYfnGRYbFwe28Au4UJpQtHPI=;
        b=nNyr0i7C5jXlT9cxzkoGhgtb/VUq88Jgg2IzT55MK8J4GXR24sUbWP6FBWVb2hKlyk
         JUSWefM4FUxsi5+84C1q2qyKBgOuoSk6zHOg1Mg9XZk/5Vsa3vsbiKcq5awGavJ5dUWp
         W5zlI4rKsbBQf361zuw8pnJKHLXKBA9n7SfSnH0yzu4la6z5EWHughq+WCbtf8MQUhCm
         DxN+qhhJr0XmsvbQ8pEG0MznaGgn/8wdZhSrYcZXRDv49qN8Eh2ZXU4BO5msycpkkmg1
         bOwFhhqMIB01WoNVpoioNkzkvNA60Xm7YAWdzEMEEZv8jp7hfgHdlZDhGpBcGQNB+QnS
         UZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=mKVYQ6K/sHmv2ZUNAfztYfnGRYbFwe28Au4UJpQtHPI=;
        b=M5D6KnUGewsViTHVDEizXmmvq6yZe3S7nHrLUdH99PF5LWCSC4aYzjgpPNCD6z3Rfp
         Ajs5kdGgW+8Q/DwYrZTgsIMH/sBDw+yc7UFCF1cz/3oeU94Q6CX3tBWJO7MurdH5HxPm
         iWTKoBnyXsQocWN5eh04eU4je0NAM8MDopBbUypTklV0GND0iV6Jht6dowPPQVZh2zyp
         5ZTx0Alji0WaID96+ESjPNXbd4RX4WtExEd5zycQb10PISc+/bTyIz1voz6l9FbNEjnZ
         nj9ZU1qlWIyDweVkf+FRIaOw1tC3HOBmXejtPAeBai4Lay92/mcwVLV0bmLmK0N7DYd2
         Vflw==
X-Gm-Message-State: AOAM5330uDQLfCii756ssaD3LrOmtgLmrisxVsJQ6pntZB/Q7cKJT7wY
        TWgGOuHBMns9C4lXRSM2hG1RlCg3vCVx4A==
X-Google-Smtp-Source: ABdhPJwCEFT2e1soKcJaLKVZXew2lsj84vm/F4Qe7koBOvbAfI496Nm9x8xSM3ONp6swNJ/0h5i6Sw==
X-Received: by 2002:a62:bd15:0:b029:31c:a584:5f97 with SMTP id a21-20020a62bd150000b029031ca5845f97mr1082655pff.33.1626123635933;
        Mon, 12 Jul 2021 14:00:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w6sm19518159pgh.56.2021.07.12.14.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 14:00:35 -0700 (PDT)
Message-ID: <60ecad73.1c69fb81.96aba.a0bb@mx.google.com>
Date:   Mon, 12 Jul 2021 14:00:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.14-rc1
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed (v5.14-rc1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.14-rc1)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
14-rc1/

Tree: pm
Branch: testing
Git Describe: v5.14-rc1
Git Commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

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
