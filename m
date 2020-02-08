Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7036F1562CA
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2020 04:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgBHDXm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Feb 2020 22:23:42 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:38141 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgBHDXm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Feb 2020 22:23:42 -0500
Received: by mail-wm1-f54.google.com with SMTP id a9so4831917wmj.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Feb 2020 19:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ZVJXwhmHYxzF4fj4VhbcpOSthvYLGLZyFEfnOtV1yPs=;
        b=ww744CSgsblAm4uzcond6r3VsbyGIYfgnXG82beNFjNKRzPRRyK3lGDLR+K63WNS7E
         u4SdifmQyVqa1pWiYwAZORwl4l6fvTaT7QUxgDIXl71COGZ0lsJrMrI2QobpMktqpA3r
         Jo1TMiOlscUa3b2+pgYj2LetkUGrC88Jg9loNzopXqDpMOLbj7ejujVWRuDzqXIwsO/9
         Je2xa/sax1eJ3eXLuyFsSk5LMz02gJOWq7qsv/0ss2hSUVcX5ZYET4bgsUlCcxrtnCoU
         BD1GvEpdvFOAKF/q+rSEdIlnKk5jiDZXFbpj1IB6EqI1AUYHCLYThH6+S2v+m9wB1Qey
         WjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ZVJXwhmHYxzF4fj4VhbcpOSthvYLGLZyFEfnOtV1yPs=;
        b=kKdyzgwUSUdjF0vabYBMQi8ZmtFcc9q06jY/LNJJWOPxZtdukTaXZwkNMO48XSiUhY
         WS4KJ89gp/k9Wnxa83gK+/Jmmi7q1euRk3ncz1SP2f3ZXUXf3BrA1+4/HqmN/3X9+nQA
         1Ct+Mz0di7cg6bC8FFWYDivM0QDXm4GiVe42E49PZ9ysEx6RXY5suZf5YE1Xp2GK1MLf
         V3eC5YK6EER07fRpduugp14Ucjcm4Ec70HpIoqcso7MuxY0F0ERhFSvejJ5l1FA+sykF
         SgUGwDTXTpfwSsiTv8lMM/MnBsirZTQgPb3y73qoNGolqqGIo8dl0Yav8/RnrPkiLVRs
         XcEw==
X-Gm-Message-State: APjAAAX10QzvaewL/AiHfCBOVcK+SsPhDmYnEaUkbluroZ5R1cfitf/T
        UQdKTQGzL/X82xomJlbOIYXhNw==
X-Google-Smtp-Source: APXvYqzQ7AtzstB2KML/cx/sou3kJr5fnzEx20zo01m5dXHqBIasqmWsYGkBrFC7zf0aj1MLppxR1A==
X-Received: by 2002:a1c:e2c3:: with SMTP id z186mr1808600wmg.70.1581132219886;
        Fri, 07 Feb 2020 19:23:39 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id m3sm5958361wrs.53.2020.02.07.19.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 19:23:39 -0800 (PST)
Message-ID: <5e3e29bb.1c69fb81.aa46.a7bc@mx.google.com>
Date:   Fri, 07 Feb 2020 19:23:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.5-rc7-146-g4529d29bc6a6
Subject: pm/testing sleep: 1 runs, 0 regressions (v5.5-rc7-146-g4529d29bc6a6)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 1 runs, 0 regressions (v5.5-rc7-146-g4529d29bc6a6)

Test results summary
--------------------

run | platform         | arch  | lab           | compiler | defconfig | res=
ults
----+------------------+-------+---------------+----------+-----------+----=
----
1   | rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 7/1=
1   =



  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.5-rc7-146-g4529d29bc6a6
  URL:      git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it
  SHA:      4529d29bc6a6f458ae731425ce4f7e3856365bbe =



Test Failures
-------------
  =


run | platform         | arch  | lab           | compiler | defconfig | res=
ults
----+------------------+-------+---------------+----------+-----------+----=
----
1   | rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 7/1=
1   =


  Results:     7 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.5-rc7-146-g4529d=
29bc6a6/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.5-rc7-146-g4529d=
29bc6a6/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0207.3/arm64/rootfs.cpio.gz  =


  11 tests: 7 PASS, 4 FAIL, 0 SKIP
    * rtcwake-mem-3:
        never passed
    * rtcwake-mem-4:
        never passed
    * rtcwake-mem-5:
        never passed
    * rtcwake-mem-6:
        never passed   =

     =20
