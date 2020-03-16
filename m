Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B13B186B53
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 13:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbgCPMqv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 08:46:51 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:52712 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730970AbgCPMqv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Mar 2020 08:46:51 -0400
Received: by mail-pj1-f49.google.com with SMTP id ng8so1285554pjb.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2020 05:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=hILQNduLUdAGyed+hBqv8l4rX6m86wmpE6Ydv2xsBz0=;
        b=zwXG4Y550EfpuIi5pcfix1gtF6PlOfqhZbYWLTXqIlDJYVVzdLa4UQJkBRT3F3YKbF
         dx6hUO5J80B2Td/z6LwwGQc4CX/D+cJc7IQ8HiwHZT+pLB1yMmGBYGlpCebAp3skMnBp
         P6oGosABGE3puls2+o25vP/Jg5rSrT+x4yl3aAmDHRnw7Uxeq7kYcVZ+OPs/IgpFqUjI
         2A6BaR3xM9PbjiLP/agZMJo67YBO34KLYWBJpNDVJX+m6Kh9+1E1qk1orcKMvjyeXFtb
         p44kY/ib1B/TQC8rbUg3XLBILiDhyNP+QEa/INTnsTK4/GI6q2YQsBzm6TNWVJciVCUJ
         wf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=hILQNduLUdAGyed+hBqv8l4rX6m86wmpE6Ydv2xsBz0=;
        b=kzPCqxBKHggfpwUeRjy1zpBTDsvyoe37tSGduHcpcKuLZJb0qLQz22c3K86y6iDaA+
         hU/9phVwG5bvfXE5LC3ARSsD7UbTgr2iwUKyRUR4mjV4Prx6JWYqZ4bCXhI5FioVK33q
         QoPAcK3D5VKEZzWsNYCFCGkaB/bSsBwZ1f73yIG504TzNWeiiTkgTMs/SI7Wujsc+T15
         C7xDsN7bmiuP5SEUCnXCWinZ8VQ3Q2RSq7l4li1kxHYJUM4T17XFKzZHWqMNmA3zHMv7
         jwptODRnyFw+my47rjdr8c1ao1dy81+sg6Yh6xUrNggclXPJ5ByTmY18rwfPQnNruA4W
         bvaA==
X-Gm-Message-State: ANhLgQ0UkdQKO4+LRJiBRjXJydfqxzQDlmd16LofzLbzdzTJOPJroGpX
        JIWDtod3ZdOnaXj5vE0pQ4eYRnjqD+4=
X-Google-Smtp-Source: ADFU+vsNgzi22ARNUl7F2ErD5tptJhqQPj+aP/oJffpusvgxV4jIwHlaZwM1BwBW0jCtfJnJeS4NNw==
X-Received: by 2002:a17:90b:14c2:: with SMTP id jz2mr25175587pjb.152.1584362810689;
        Mon, 16 Mar 2020 05:46:50 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y4sm37785549pfe.31.2020.03.16.05.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 05:46:50 -0700 (PDT)
Message-ID: <5e6f753a.1c69fb81.d311b.72eb@mx.google.com>
Date:   Mon, 16 Mar 2020 05:46:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc6-99-g90f425b95754
X-Kernelci-Report-Type: build
Subject: pm/testing build: 6 builds: 0 failed,
 6 passed (v5.6-rc6-99-g90f425b95754)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed (v5.6-rc6-99-g90f425b95754)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc6-99-g90f425b95754/

Tree: pm
Branch: testing
Git Describe: v5.6-rc6-99-g90f425b95754
Git Commit: 90f425b95754aa7c6e93f239ae73e7d250a58e98
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
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
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
