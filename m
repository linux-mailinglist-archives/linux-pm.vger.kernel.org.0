Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB96B4DAFCC
	for <lists+linux-pm@lfdr.de>; Wed, 16 Mar 2022 13:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239389AbiCPMcZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Mar 2022 08:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiCPMcZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2022 08:32:25 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5798457A5
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2022 05:31:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id z3so1667083plg.8
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2022 05:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=WOT8qaaO/crm7BT2j7enTu6vJsve9vNW2Kvw9DzeE8E=;
        b=Q+FDx7qUFDNXAMMyzMXETA2XtFbNuMiT2gvlNKU+Vrc2tqc73H+utiJ2GKHT/3zPm5
         cvx7SLENfBx4uKlDlNtEYxIh+wIdbxqFJ4cL5xCI2e+ezvKeA6irD9l1BRXH+zkgVPxr
         YYdFySHwGzT5wQKv6Bo4ae0DXDO1hj8Kdz/SjMUWz3u8f/GhXyUG84qh9vJTJFji4y2O
         6unWnmVzRH1kyAl302rf8ZxSYcnbYwKAv9qx7vk3kIbSVebZtjeznofzKlLrpylhLYNR
         2E1dKUOuzEtAsGTnjq1W2fIoBuGnGarPEs/5mXOHkwzMPO3gNleUp+Z1Q1O/pJ3oiD5L
         cLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=WOT8qaaO/crm7BT2j7enTu6vJsve9vNW2Kvw9DzeE8E=;
        b=Lr6cxpXaZqStq9D9asOUAJdlDmtdNfmLoFDYsQamxoZ0Dn2U1P3ywUCv+WqqDgM1Hf
         uYP0/qKTRdqlZff7JVzyKFuKzUa17LOzORHKXDaVGdsJP1sg4SBVPl/P1/5YRKL4EW35
         e92WeO8xjjRaqKDC6XiVZK+cH1b+M2s6XqlYr9sbJdTo8ns2g4ahK01t6LvIquC482UQ
         pogJqVUgtqJtexaBftxZqwgVlcTbMlomUxTciIDnhTzH9u7dXBF4ckc8SYK4XduOLPv6
         flPr+J5tyJoHd8sIUSUsMG6gKjU8sOaJmO7hgNgf+Vk04hWxSQ4C0lu6T3rX0stgyGRF
         /PiA==
X-Gm-Message-State: AOAM533TjKtT/WXS0UJa4DPYlubshpk2sHltw332gIkKZhl9vcQs1FfP
        tabycnffh2yelZw0Xbahf4Gj5A==
X-Google-Smtp-Source: ABdhPJxfOYy5a4zNrMN3qZpYZdnlMkPu+q5EKBdJ3P2bWQQd7IZhGV6b17zQ8mpEsXzuRLAf3a5IFg==
X-Received: by 2002:a17:902:a50c:b0:153:b18a:ff75 with SMTP id s12-20020a170902a50c00b00153b18aff75mr4054850plq.142.1647433867101;
        Wed, 16 Mar 2022 05:31:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a20-20020a056a000c9400b004f7ab5a44ebsm3408442pfv.18.2022.03.16.05.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 05:31:06 -0700 (PDT)
Message-ID: <6231d88a.1c69fb81.eea0f.7730@mx.google.com>
Date:   Wed, 16 Mar 2022 05:31:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc8-157-gad2ced059eef
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.17-rc8-157-gad2ced059eef)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.17-rc8-157-ga=
d2ced059eef)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
17-rc8-157-gad2ced059eef/

Tree: pm
Branch: testing
Git Describe: v5.17-rc8-157-gad2ced059eef
Git Commit: ad2ced059eefe51ab94f02bd67ab6fbffb499d9e
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

    2    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
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
