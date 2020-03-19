Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C894B18B20A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 12:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgCSLFy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 07:05:54 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:54488 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSLFy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 07:05:54 -0400
Received: by mail-pj1-f45.google.com with SMTP id np9so872797pjb.4
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 04:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=h9WPdXgFPHM+Ll3qU2mnc4TYYGsWiNrFz3/A+4Oun/Q=;
        b=tOIIYUpzqz1l/5pXa1Ty+XfWJ7a3XebEwLJpkRpBhdBZFKmVaWG0ihjDCvPmigtf92
         HjBy9Y47P7xMa8CSoMME/poCjOIrRszy7X7vyFR1VUAIpjb8BTjE1nx+t+u+gwjnJlDp
         kDDFjiwk990svJZHXpfbNa1rkEtoKpCGJx4A1jjlseDa64ZJj1w5y6v0bSxIerU4vzxw
         o0P1VpcrPJXWhkMD1VdOAmYHYsqpKhlgsaZFdKbYE6eysUPE4a8W7HcJNiZKNW5vg7dl
         CAix565V/jGs5TVq4aID3fXPS2cNuYVOJYPddyCFHsG/X/CrcMv6afh51wKtlHV1MY7W
         Y1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=h9WPdXgFPHM+Ll3qU2mnc4TYYGsWiNrFz3/A+4Oun/Q=;
        b=lKNBdOGEXiPrBOpJ+TpyYJiP3DcIHmztDhNllzHvsXKQlpyPxjgcpDlJKXHykb12Z2
         noE8hLsq2ZauRCA/LgNLP75Qm6/lBpWk0I+EqEOn1+0C01YlE3TJf5y/xj1FDOKTAigi
         tiZfkCE7gfyNk4idbRraLsv1f23jbte0rDo8KmiOBKdba+SlRh3MUkJMBeZMyI9yCUXF
         YJPGCBSWBQ+PIaExFn619UkKavla3PMB5gUluTT2nvLJ+TUc4IkEX8bZUKT6FuRZUCeT
         DgaJMH0p6d6SFgP/BPw8fRgO9EXL8qdDNS/J/gTD+gEEfcmvu2nkzNvY+BQr8cDWnJDd
         /N2A==
X-Gm-Message-State: ANhLgQ1x6GNXrRckPiVNUfRjujCEwbD4yhQmi4naBuaWfdrMc4aGsdvO
        SWd4VD/9aABMU6uwyOiiib8xBgpmahA=
X-Google-Smtp-Source: ADFU+vsCk8HOYCUg5O/67nsg678w1lC1JNEpab0XH/xjc9jM3DvpAxJ0yHRXFrAQh/TxMK0+GcXLKg==
X-Received: by 2002:a17:90a:bd0e:: with SMTP id y14mr3286903pjr.11.1584615952401;
        Thu, 19 Mar 2020 04:05:52 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y18sm2176937pge.73.2020.03.19.04.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 04:05:51 -0700 (PDT)
Message-ID: <5e73520f.1c69fb81.ae9e1.83d9@mx.google.com>
Date:   Thu, 19 Mar 2020 04:05:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc6-100-g37da629c357d
X-Kernelci-Report-Type: build
Subject: pm/testing build: 6 builds: 0 failed,
 6 passed (v5.6-rc6-100-g37da629c357d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed (v5.6-rc6-100-g37da629c357d)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc6-100-g37da629c357d/

Tree: pm
Branch: testing
Git Describe: v5.6-rc6-100-g37da629c357d
Git Commit: 37da629c357d0ce08072f1532fae2091e467ae42
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
