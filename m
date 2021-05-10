Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F312537987C
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 22:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhEJUmf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 16:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhEJUmf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 16:42:35 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0BAC061574
        for <linux-pm@vger.kernel.org>; Mon, 10 May 2021 13:41:30 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id h16so1698398pfk.0
        for <linux-pm@vger.kernel.org>; Mon, 10 May 2021 13:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=UqmuBiqsgQ1VcFB4F+MDJu1qSs0KDVGzsLWn05BYyiE=;
        b=xzG7z9Gcb4SZO7NG5ubHC5Yhza0g8W8MFnakmFhKbMMm0orA5niSVVu/iEy9qKNq9D
         UC7zkFLAWYn4p2sdyWkRuYHislZ3u7+H71YyPRCWbagIT3kgX4AA9q7WTLBcVSrP/Mr2
         N9snvhWuAzZHmNuFdyRdvlgWKzz1g/JTfVEGPE3iahdPsJPLP0Hx/1FQZAO9IJSUyK16
         DOXbwfZUNyoNlk4OVwpqpHXsPuXoT844cXHZBog6ieNcBU1V/b2+/pjxoIE3gC7PCYWn
         NN/lmN1UdpaVuNe6hpYHxYVJycL2/3LVE87QJ7eUqWzdAd7++SdgEhuYa1sfauVCGl4Z
         +llA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=UqmuBiqsgQ1VcFB4F+MDJu1qSs0KDVGzsLWn05BYyiE=;
        b=HE7mrbw/7QP7e3OQswBWI9s0OexBk7k6iyECln8bJD7RfjMEWhIYOmsgT0CXtwu9bX
         BlFZLqjRsNk0UIDk0TQ3IM9iqQ4E3/ZqI4LU1WW7kVKgYTmUMKUH9UUEEE0clJgD98jN
         qO6lxcE6RHslTK3tuxdRTCP+QWe4nNTCWKKukODOv3qzNf4QJl88l0AbeYFs0nxAigqR
         aC1ueMtF4iptbu6JnubDp+BRm73piyJiFG4sjjJtFdTKBWsCQgvXPD8oknhaEQE31mdT
         PbjIh5WlEUNiq1avL3G3r1ucN/PS+yOdoV1M2i1FvBWTSUV6YpC8Y74kB7wW7KLafgBv
         /svA==
X-Gm-Message-State: AOAM530v3qyDQOziRBvePpBSF76++/hcXc5KA8iJgbh1o0WgacRPQ+uX
        AvKhR/YSNp/UIzgin07XkPkhmMr/0tLPzbkH
X-Google-Smtp-Source: ABdhPJwELCoBixJZk4ZLkUgKEjamjSeCHVRLukF9OXJ3kKfS186PLvw5TJLfss2IFXFxUx42es+rBQ==
X-Received: by 2002:a05:6a00:1c63:b029:2a8:b80a:1244 with SMTP id s35-20020a056a001c63b02902a8b80a1244mr19343039pfw.72.1620679290308;
        Mon, 10 May 2021 13:41:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d12sm280160pfv.190.2021.05.10.13.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 13:41:30 -0700 (PDT)
Message-ID: <60999a7a.1c69fb81.fecc8.1449@mx.google.com>
Date:   Mon, 10 May 2021 13:41:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc1-4-gdc9d574fa82fc
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.13-rc1-4-gdc9d574fa82fc)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.13-rc1-4-gdc9d574fa82fc)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
13-rc1-4-gdc9d574fa82fc/

Tree: pm
Branch: testing
Git Describe: v5.13-rc1-4-gdc9d574fa82fc
Git Commit: dc9d574fa82fc39db81cb09a99c09c865d03f98b
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
