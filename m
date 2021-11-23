Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C845A63B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 16:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhKWPLz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 10:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhKWPLy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 10:11:54 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3453C061574
        for <linux-pm@vger.kernel.org>; Tue, 23 Nov 2021 07:08:46 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id b68so19703733pfg.11
        for <linux-pm@vger.kernel.org>; Tue, 23 Nov 2021 07:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=VINVcXf8tpevnVmS5Gkwd1UClULlVZAN4QhjpXcm2WI=;
        b=23VuhVs0BSuSfRZKlKt03BhKBEfuwfLkNkfEEYs3inhQbO41WjVW0jId9l+m91njsV
         wZYYtxoYscYXe9r0UGHktJ9YqqCCrLumiMhBKKU8kxxVLlzNkPpt8Kau0VFXGRCUd5Be
         +cWHHGQ7j2FdylDlXsDbaZ2b+xccYH/zQuU5WEbfmYvCSI+tm9cBmEYZxtVQhO0ErdOC
         SOYHZRN+vVNIe38plpP/sZx0sHcps+dFGo9gLd+mFfqQA1bYz3ee/I/G6ai1uVkPd9qq
         gi2TTWa18cbCBMU1c0paFAeOSmIEKamUvx7OK8RofxygP0GsH/C7/atXXjAKjAmr2bkT
         Ddmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=VINVcXf8tpevnVmS5Gkwd1UClULlVZAN4QhjpXcm2WI=;
        b=57sMXZQncX8J4mEZCFDBbAdavoUVW5CBQhhGabY6QGNrzyKnnJ0FwMDb0j6cdsWVN2
         iSbukQjypWVIVzXOeQLvi5o7CgtT3gxtNQ0ETX7MB9P4VmH9Tx4BWJtfTVE8mAOq4kvc
         niBg9ApY+i5wGNmEMrKjPWBUxbvULCPypCJZFMxJ/hqQRfpP3vWGt8ELgyxmOfvxAEIP
         26mlHgoxpNEdZBnOAFrqkwtEWj4dnCIN7nJlECciAjAyueUowWQjUAi5p+SoQoITDL4l
         FTzkAAhp2oYZg9+SplCbiEXTkV261esJBg1XI0FUBp/LrqyKBqX0+BOyFP2kCapIPG0p
         uf3Q==
X-Gm-Message-State: AOAM533YDRMzSypNW1FzeeNxR5irieR2XBLFtoLxEt7Yp8hpjqNalPZU
        il4fJc/jUbyQxVEB1jRenOtj/Q==
X-Google-Smtp-Source: ABdhPJz9hzMBVE5xAa9CfC3pClBr7Wi+V7UglgclzTH9rVriRkCsclt4QkumcjnafDumE6yh6bN+bQ==
X-Received: by 2002:a05:6a00:170e:b0:4a4:f06f:1ccd with SMTP id h14-20020a056a00170e00b004a4f06f1ccdmr5630458pfc.51.1637680126218;
        Tue, 23 Nov 2021 07:08:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z10sm13398304pfh.106.2021.11.23.07.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:08:46 -0800 (PST)
Message-ID: <619d03fe.1c69fb81.869a4.4c48@mx.google.com>
Date:   Tue, 23 Nov 2021 07:08:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.16-rc2-9-gaf8757179e68
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 5 runs, 1 regressions (v5.16-rc2-9-gaf8757179e68)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 1 regressions (v5.16-rc2-9-gaf8757179e68)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.16-rc=
2-9-gaf8757179e68/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.16-rc2-9-gaf8757179e68
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      af8757179e68cbbc2e001e3acaddb4bdd9883cd9 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/619cf803fb96d59f9df2efe2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.16-rc2-9-gaf8757=
179e68/arm64/defconfig/gcc-10/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.16-rc2-9-gaf8757=
179e68/arm64/defconfig/gcc-10/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
1118.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/619cf803fb96d59f9df2efe3
        new failure (last pass: v5.16-rc1-14-g3b8bfff0a7ef) =

 =20
