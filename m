Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A38E3CF417
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 07:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbhGTFHM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jul 2021 01:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbhGTFHC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jul 2021 01:07:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07764C061574
        for <linux-pm@vger.kernel.org>; Mon, 19 Jul 2021 22:47:36 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d9so7461900pfv.4
        for <linux-pm@vger.kernel.org>; Mon, 19 Jul 2021 22:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=1kXH1OGM98CyD0TC3hJKKXj9qoUqzAbuIihBr082nMs=;
        b=ClqUu66lT5Z8i5mPrTTAiN8/UM4gFDKW2JwR0nT+t2f9RQPtoSdInSubi821AUBUGK
         O1/h6OKyopK7UyJw+UUgN1gV6KoA0a/QCta22qO3HqbrDwkVCBBHLrDrpXGHfaF0VD03
         X1Apo2p4PDqXQ4jaZWf1lOunFoVrsAXOy+DJ9Ro6IGoAQrSP20Rq2ECMpHaph8yHB0U+
         G3/RX37dYoit9xhVYPUx+vXMicC3VZgf1f5izh14mVA6HE60RXR97NBlT5Kz7J34C7oT
         5zchbw0iPMaLeJD+QhTKfs6Jjh+meNbgzLN+iW83YZpgz5bjWv3WE5FQNrgin5LB+BG9
         fIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=1kXH1OGM98CyD0TC3hJKKXj9qoUqzAbuIihBr082nMs=;
        b=ms5D6LIjmoXUay2n2g63DBudE7SkmTmdI9+jD8zBpv6HfyF50l8QYJ7aYU4o5VuAoG
         5pZOLNPZLmuxjh4zEN+fHNme5KQSV+AkaA5w1upRzi39ECwHeUZQpRL5KsEPKJPnvo7q
         hHhJE77Hin3Ge/iVvZuFlHhr0R7aFRsXfIhfu/Q94EwbcQiykxDwmhu4nKzMdCFrLZkE
         mXvVNDN2vo3Zs8dvJgWh4P+rTkRbZhiFazGHcFWK2b0M+AyKZUdHfgr7gUlahrIRrHO2
         O8Ry/bQ/paTatRt1afyyRtZt5Ep7Le8J+Sip7a4f7DCh040RN7VrXnDGxg0mHMN6QaQD
         9+Fw==
X-Gm-Message-State: AOAM5309yPaZDlsh+KDfOa3qy0TXrGB4Jg5gmxFh2XgXnrS9Yy5PqlWh
        /HBYoJ7Yh4taTezBVlZrafTXzw==
X-Google-Smtp-Source: ABdhPJyUGZeZwavlre5eggNAU5MxFg4ww8SAG2FNNbtABHED9vEU+VPVAqmjn2Al1App2hpiBa2wgg==
X-Received: by 2002:a62:be18:0:b029:2aa:db3a:4c1d with SMTP id l24-20020a62be180000b02902aadb3a4c1dmr29657918pff.58.1626760055415;
        Mon, 19 Jul 2021 22:47:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d1sm13028473pfj.24.2021.07.19.22.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 22:47:34 -0700 (PDT)
Message-ID: <60f66376.1c69fb81.4a610.5861@mx.google.com>
Date:   Mon, 19 Jul 2021 22:47:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.14-rc2-17-gd713e0c833987
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.14-rc2-17-gd713e0c833987)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.14-rc2-17-gd713e0c833987)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
14-rc2-17-gd713e0c833987/

Tree: pm
Branch: testing
Git Describe: v5.14-rc2-17-gd713e0c833987
Git Commit: d713e0c8339876fb5070b53cb1bec248c37fbf38
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
