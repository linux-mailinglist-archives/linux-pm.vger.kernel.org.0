Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A763A19F3
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 17:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhFIPkb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 11:40:31 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:36580 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhFIPk3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 11:40:29 -0400
Received: by mail-pl1-f173.google.com with SMTP id x10so12729114plg.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Jun 2021 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=6TwU8MusV6YgwVvu2FmvP9h/CBaxK2tbKiVqiD39Wzw=;
        b=OtRcvMxcj1PeYTFqMpFDjFgi157CZtvY8aXjOqZMg/QNGZIxQMGTNAhnRC1YIrNzgD
         of5Y7h8iGf+HC+hHW6XFUICLhfechflTcP7nirZZR7G7itkXrfhZC/AsWEPPNFHIRFYe
         3ruRcDLS94rnoaO7ZNe4MpXoSm+y0pDx6kEFDfrHhz+20HnZ3l2L6JDxXHYF+kf3Ru6w
         qKmHPUISijukg8aMHOPCnR+7BuY9x3G+e82pIz6F59yju7qX5bj0eN26gHN2kmFEpyus
         C/g+VfzH5Ib8SL4Cw6oNqfKcuyGNil/eoAudd+4CcMKSuaJdu0VFKX3xOM3SUElIb3DM
         Cqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=6TwU8MusV6YgwVvu2FmvP9h/CBaxK2tbKiVqiD39Wzw=;
        b=SPVt/sGZFesWiBXsnk3csdMeIFB6kkNEXjlYwHFdrvKhVN07ZRMibfzuzml/1Z17K3
         8uO9r8+aRZP061HPr2E3B4DjZThuJ6KnaprHrv0aPEkUVibGGUyQse1t4C+S619vXaIM
         SrvfOcGDaEEoxdsC3ozxDX89lv0ntwOzXfg4g3XklTpNzrQcysaaT8LzWYh0zZhyvCB5
         5OQ5rMQf5izsun9CpVbsgF7ym4YdSYYf4g/tapGo2lRCpcCNGdn9shEcAzcKwqgQ8BAA
         RW2+KfUE/ljiakre7lkFOnnOCSH4HHvp1Y9FzBEue1cSZdMDeh0GPpmRNIj55gRQLP6X
         u2Yg==
X-Gm-Message-State: AOAM532M9ABIhbh3MYAPsM4rPoVnOIY4F5ZxZaRN6qV5m4xdul2u/XnR
        27BLngB8k0DD1FRWkJ6jp1LrHg==
X-Google-Smtp-Source: ABdhPJxVXO5BdGUpXqxKvZ/pC4RyKhckyX9WBfiewjFNuNV80aBMya9KGuamDQeGUx/s4KxIRuw7nA==
X-Received: by 2002:a17:902:eaca:b029:109:7460:cc41 with SMTP id p10-20020a170902eacab02901097460cc41mr349220pld.4.1623253052815;
        Wed, 09 Jun 2021 08:37:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w2sm128908pjq.5.2021.06.09.08.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 08:37:32 -0700 (PDT)
Message-ID: <60c0e03c.1c69fb81.231b8.079c@mx.google.com>
Date:   Wed, 09 Jun 2021 08:37:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.13-rc5-97-g6d0b2a5677ed
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.13-rc5-97-g6d0b2a5677ed)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.13-rc5-97-g6d0b2a5677ed)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
13-rc5-97-g6d0b2a5677ed/

Tree: pm
Branch: testing
Git Describe: v5.13-rc5-97-g6d0b2a5677ed
Git Commit: 6d0b2a5677ed15cfa1b6ebe8206ddc621d078190
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
