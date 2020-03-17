Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91933188E1D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Mar 2020 20:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgCQTjL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Mar 2020 15:39:11 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:45319 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQTjL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2020 15:39:11 -0400
Received: by mail-pl1-f176.google.com with SMTP id b9so126100pls.12
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2020 12:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=yzzphVN+OG2bTYbpsigsRgH0EUcGN/STuyvAGNbsG+E=;
        b=E+cWf83I+CoShfapw64AipnJ1LSHxWr/5VkF9XoeCATUatzZHoR1Q4lhYNh40a5247
         lWBsNESoHz2Dz6hkT1HSwhof6B/9w3606UKsiOCl9rhgcUvspmiw/CpEsEGOA86FMWSN
         gRjnqqlmS8dtWzh844wtSagyqa2sZWBFYee1p16SLaCA5agX5DDI3oRvxPNi24aJBghK
         PQ+LAAT0Qya8opaOZQzy2kNMNAHK+tEMwlvuWjNwWDn96Q333P3lk868DJQ4GPYr9r0m
         yynQGKhSvhftxkpRlmzonAGu7NmHufanzxQmuXHi1SuMEgWNWIeouGmHXF7Ig0UqOm4a
         HzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=yzzphVN+OG2bTYbpsigsRgH0EUcGN/STuyvAGNbsG+E=;
        b=HvVn+gT8PmTI4yPHLlSy7sSqBxAxZTzUAdzoTlOiuAnjC3VdRvxwSbtdVCkaP4xohB
         GMUGi/1cbZpVEK/F6/pn0RqxtAurV8lX16uIQ/sOWNGxRWVlhPB8G4CYNJDI+5vdFoT+
         2DbYUBMvnyAsoABznXN8jWVXOXIbPEMKBXdmwCYSjDXQKTZ5IQDkr7W+BtnVjqjXFycW
         Oy3rtk2DBDK85Mm0MzlkMM/s9FWuRx26UjzJ/8MtpjhdXXDg0+dPMyccHcIlHNl3wWvU
         UVKB9/3km7Ofaja/d8/2rqiIqTiT1Mi9sPgUKFWSVsDtvrPH2AF1drospdnRaeU2WsbI
         4Y6w==
X-Gm-Message-State: ANhLgQ2XTgRqOEU6BeclAF5d8J1bjgjRhNK68cDPwxn3jyAshJD/veRW
        chjl4IRTdXmBeQhQEIAHTxtod/W3zFk=
X-Google-Smtp-Source: ADFU+vvPNdUQDTLbcYVlYQ9gEOcQOK3o+YobZ2jeHPQxx1Q+u0FEbpJxb45UYvDJcqncB+haY/gzkw==
X-Received: by 2002:a17:90a:a417:: with SMTP id y23mr823307pjp.184.1584473949769;
        Tue, 17 Mar 2020 12:39:09 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z11sm3787633pfa.149.2020.03.17.12.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 12:39:09 -0700 (PDT)
Message-ID: <5e71275d.1c69fb81.22a5e.e2f0@mx.google.com>
Date:   Tue, 17 Mar 2020 12:39:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc6-99-g4a13723c325c
X-Kernelci-Report-Type: build
Subject: pm/testing build: 6 builds: 0 failed,
 6 passed (v5.6-rc6-99-g4a13723c325c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed (v5.6-rc6-99-g4a13723c325c)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc6-99-g4a13723c325c/

Tree: pm
Branch: testing
Git Describe: v5.6-rc6-99-g4a13723c325c
Git Commit: 4a13723c325ce2b444bec3aa5836854cc1f48390
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
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
