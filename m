Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7724CC44B
	for <lists+linux-pm@lfdr.de>; Thu,  3 Mar 2022 18:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiCCRt1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Mar 2022 12:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiCCRtT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2022 12:49:19 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA4E5643C
        for <linux-pm@vger.kernel.org>; Thu,  3 Mar 2022 09:48:34 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id c1so5142120pgk.11
        for <linux-pm@vger.kernel.org>; Thu, 03 Mar 2022 09:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=3m3kAnC5yVE0thF2/DdfFMvxjXwoPEFsln4f+FEMc90=;
        b=aYkpLLcwTHErVgKVX6glyj54CVXIxUc8lkwnarAOkeFPlY6SvgIQQrunjhUqur34U4
         OTDIRnCcYXOhl6QDpSjuZmJqdzkZ77ODIY6sD0D25T3JNa0QrESz5IBS56SFLm3WfqYS
         XZ5O28iKfQ8BCsQPfbse5oAnViot4RRDo99iygbrZbbBv5JihClXPLvY3Uo+InPAxJyK
         UCbQNMbUUQiTBuMfQtUR4TqSTNIicicp4Z3gjDZ3joYRVTMvxlS7+ecyKGpxXA4GgruH
         2iPRelV3a3niwsYax6xY8y8+R7ffPhVYZZpTyBBCXZpQCRM5s1eeMsIwdO27GPCBVPfG
         SZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=3m3kAnC5yVE0thF2/DdfFMvxjXwoPEFsln4f+FEMc90=;
        b=kL6SmbNSrBvVksm5j4D8hoaT9pau4JeVkQ1sJGfyotknS+xSUBE+THjyhEfPdxY0tj
         3Gic4ocupIz3q1L5hTDgwIl1K+9vjmbMfaykw6FszAMkotqlDUf25pY3INSgCo7FpWbV
         s+/JQpYdpdrO4l4vxGeE8cwaWUvEZTg3Uf+a+5I2jcg++u00491brUcAtSjwHbeyNB9G
         s7IkprB5AGeXhLnkBRJ4OawgIOSbzpeG6r2MCe5uvnCQsih1oibgaA3yR4D5PrW0/61O
         UWRXWoxflO5+F8DUpifyGJQf7wweyJBUVK4g9ytc9unbnw72PeB9Bwat021bGxII3HVX
         pxVA==
X-Gm-Message-State: AOAM532q3PvLb+N2aXnA1/5Rxq/ODjV4ed1KHFzX41kGLNWM07nnIDYP
        NfVJcfXJgyw+8+S8q7vmGP3hm6/bEUHuQAveuAU=
X-Google-Smtp-Source: ABdhPJyEATzZ/c34YFpbY6Xe5MYIegcBxfFWruhYun+xzKKTxgtzDs8625BsRcG5yoU81dJFeuAveQ==
X-Received: by 2002:a65:6d87:0:b0:374:2525:dcb0 with SMTP id bc7-20020a656d87000000b003742525dcb0mr31693327pgb.248.1646329713646;
        Thu, 03 Mar 2022 09:48:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u11-20020a056a00124b00b004e11307f8cdsm2928991pfi.86.2022.03.03.09.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 09:48:33 -0800 (PST)
Message-ID: <6220ff71.1c69fb81.ad015.791b@mx.google.com>
Date:   Thu, 03 Mar 2022 09:48:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc6-111-g8953254f5daa
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.17-rc6-111-g8953254f5daa)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.17-rc6-111-g8=
953254f5daa)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
17-rc6-111-g8953254f5daa/

Tree: pm
Branch: testing
Git Describe: v5.17-rc6-111-g8953254f5daa
Git Commit: 8953254f5daafa82f800ae05279658770fc9dbd6
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
