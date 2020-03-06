Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEAE617B354
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 02:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCFBAT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Mar 2020 20:00:19 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:46359 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFBAS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Mar 2020 20:00:18 -0500
Received: by mail-pf1-f176.google.com with SMTP id o24so216529pfp.13
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2020 17:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=JgXNWcC9AGN89dMdIG+O652ZyVDAbJgPYLcotf54upo=;
        b=LpiGt/K3AKsIMuDK+a+M22IWRd4sXBYZ5RGWBGjQWKj2EsQrH2zViLx8++6kWHstDp
         ddgwb3iG7irUbFXoenDfM4LyS0VN/Dr7NixXvbJMdITXjqTKRZl1eRiR0EQmnX8/JJgG
         LwCENq4zmLg/UwjrH8oZ1hvMLugFIeh/vfVoWcgv0kWif9S27xgbjMqsJaywjXy40BCQ
         yZX69nmdTOn1JYrUf5bXS5byfq7ksrRCCBiEqMudH9r75c5KeB3+lUf1YmI1iQYpjNSt
         iUPFGJ0O5l+NNF9pyxEe+tBn9f0o/RSvNwQ+Kg2hTVgC2LV5h01IvDuNxb6H+zkz3lv0
         nQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=JgXNWcC9AGN89dMdIG+O652ZyVDAbJgPYLcotf54upo=;
        b=Vv3T99JH6j/UNFMOWW0vJ+I6qAyVTesevqAgOG9JiMMZTz9GrxWMTwSP/uAt6DZu4k
         mvk6An9j7USVDKNoyobrq2e+mgxwR3NKnA0sSYJhrd9oQdpsmAlamq2SKtql9DluadKk
         sP8zoWvmm4QU6roaIZEK8ovvlmvjon36zuYQVUSBXOJnm8Hs5FNm/AwznWT7n5BB48d7
         7QxmSokyE05Sw8MM3OzPhot3gSswvrXKvgmH7tZQm2RxCeYW2/6cWzkshfbYe4ArwxD2
         rfkC6yYJCUixeIcmnq8/OlleHT3HBmMRIQBv3RBYd0n9T0W63SP5x89IRtvS0PDNIEqS
         EMMg==
X-Gm-Message-State: ANhLgQ3WMx7mdfTZWI6w168B4NPmxBq71H+zw4dgLI1ZseNrnTk+WaNe
        TC53RaifctTym+zrdsXPHimQCuU2xp0=
X-Google-Smtp-Source: ADFU+vtThzJpH/S6Crcrb3S1DbvcLYNA5OKrICBe/qxfrh+a52WAd1FZ033iYthe2BmlxJB+OK14sw==
X-Received: by 2002:aa7:983b:: with SMTP id q27mr1120476pfl.9.1583456417340;
        Thu, 05 Mar 2020 17:00:17 -0800 (PST)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l1sm7376588pjb.15.2020.03.05.17.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 17:00:16 -0800 (PST)
Message-ID: <5e61a0a0.1c69fb81.10887.4131@mx.google.com>
Date:   Thu, 05 Mar 2020 17:00:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.6-rc4-78-ge63a6b3d7d38
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 6 builds: 0 failed,
 6 passed (v5.6-rc4-78-ge63a6b3d7d38)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed (v5.6-rc4-78-ge63a6b3d7d38)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc4-78-ge63a6b3d7d38/

Tree: pm
Branch: testing
Git Describe: v5.6-rc4-78-ge63a6b3d7d38
Git Commit: e63a6b3d7d38c359b20aded5ec6964ffdf61ca96
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
