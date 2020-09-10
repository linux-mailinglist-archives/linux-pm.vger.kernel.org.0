Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389FE264FAA
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 21:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgIJTst (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 15:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgIJTso (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 15:48:44 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B061C0613ED
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2020 12:48:43 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id w186so4833809pgb.8
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2020 12:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=N5LBAHdiBxctQmBSfa30J5V4vBysdqmIn/TRftWnmcc=;
        b=mlDkMnbRQVYtAUhAo6xZOyy4XNQqrj6IFFYyHzgM45S/9EuVKokaF0VmOHwKCBJWgN
         6PguhDrCe+369YY7/MaDiKKPnkPvzBqGIq0qC+iZ5upzrOvYVjC8skYioMm9vli42kSc
         0RhUMensgE2glUDqU5UOQX1QcziNCBzRDlIAPLTpIMgXrYIwQAjgSDIcxMVUz8E6cR80
         Ch4MkWv5pKizPHatPUccasfB3IntGXg0vU1cANwYObzgGmCNBAQOhVbYsmhdKxbLbVlx
         A6+/TtFQbw0LiSogbwT47cL4zkynraikpfCYEAlDdtWVnBZ+JAvnBjFl78ncbzWYiL0x
         lf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=N5LBAHdiBxctQmBSfa30J5V4vBysdqmIn/TRftWnmcc=;
        b=oF/fAQk9vmEUIEeR7122yTKYKGam/JQOWajllZWreqX66T+rx+Hw4OIgsZAS1nex8h
         APbzBzbQa62+r532SpHKgze5YyHHLI9+d2NNitlTUOt1hDM1idehjRyH/IC4G3wRme73
         cHqhLkdxG0xdF5pVEru5qvgRAXdm1U4Pv1OKWrMnK4zktCkQedBhAU0b4U7EuDr+pi3L
         zrURBwK0NfmF/l8jh9FHgl0xXI7/qcZhWMsHLc0VUpRsFXW67vPX1eNf2K0LW4Ojzm5n
         xeMmpx0ympyw/Kqz18H+l+1vu9Lqb7IeQgXTHkC1USd29+sCaq9CD6ZoBiAhYK8USJKN
         my6Q==
X-Gm-Message-State: AOAM533PMQQLWNCwwnue8LKTyx3BSapsGp50xk9nQxv/aNZFEnI08GgI
        hO1iOF8XqZ7THWchijWAEqYolA==
X-Google-Smtp-Source: ABdhPJwEpqxgA9dxc3OLhLmLfb8q5IcFv3oQjG9YFHzXv4M0gKbnFP9oWdE4jz8i6MJpxTA7qbx7JA==
X-Received: by 2002:aa7:81c4:: with SMTP id c4mr7137859pfn.70.1599767323098;
        Thu, 10 Sep 2020 12:48:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h35sm5900489pgl.31.2020.09.10.12.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 12:48:42 -0700 (PDT)
Message-ID: <5f5a831a.1c69fb81.8057e.f470@mx.google.com>
Date:   Thu, 10 Sep 2020 12:48:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc4-6-g23818c154bae
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 99 runs, 1 regressions (v5.9-rc4-6-g23818c154bae)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 99 runs, 1 regressions (v5.9-rc4-6-g23818c154bae)

Regressions Summary
-------------------

platform | arch | lab           | compiler | defconfig          | results
---------+------+---------------+----------+--------------------+--------
panda    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | 4/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc4=
-6-g23818c154bae/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc4-6-g23818c154bae
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      23818c154baeeb4bb6a8de39cdb9b1e589b6416a =



Test Regressions
---------------- =



platform | arch | lab           | compiler | defconfig          | results
---------+------+---------------+----------+--------------------+--------
panda    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5f5a7917d01d8b6575d35370

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc4-6-g23818c1=
54bae/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc4-6-g23818c1=
54bae/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f5a7917d01d8b6=
575d35374
      failing since 22 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)
      60 lines

    2020-09-10 19:05:52.846000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c802
    2020-09-10 19:05:52.852000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c803
    2020-09-10 19:05:52.858000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c804
    2020-09-10 19:05:52.864000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c805
    2020-09-10 19:05:52.870000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c806
    2020-09-10 19:05:52.876000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c807
    2020-09-10 19:05:52.882000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c808
    2020-09-10 19:05:52.888000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c809
    2020-09-10 19:05:52.893000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80a
    2020-09-10 19:05:52.900000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80b
    ... (49 line(s) more)
      =20
