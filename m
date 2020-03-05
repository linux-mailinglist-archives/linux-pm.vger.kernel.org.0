Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3F5179E4A
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2020 04:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgCEDgQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 22:36:16 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:41194 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgCEDgQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 22:36:16 -0500
Received: by mail-pf1-f174.google.com with SMTP id z65so1558177pfz.8
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2020 19:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=rRJKrlBzP0EbQs9P4zGCM7CwADxAkqgF7137+PF1zgc=;
        b=xCSsAfTByNZf/ufzn3gjUTfWksehvyWuxndz1H/lLxmkeUerJpExfxpZKsxJXhOiUU
         SNHkGi4HTk165JkfyYR/KmxxkkyxovDfqcdT/gU6/RpELURCeryxZ4KYuleQlw4lNGha
         8YqjWW3pz+xszIWVhiXteh/ZieVw2azr/781lbPunr8HuQ3C2Wt0fTJ20G1t8PC5yDvz
         gFXU/Ou+bT13gTvsra9TIkLcdntRZZRhRb2nBhW/sfl/P19OWxpQ/sI5DTuTrMyck5W3
         a8zV5dmKzEG4nV2Vwsq2dMjcEkhxpgPUq6GXePX2yVBD2sZ4ZLAAAfvi0kue1ZGa1xGK
         F8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=rRJKrlBzP0EbQs9P4zGCM7CwADxAkqgF7137+PF1zgc=;
        b=iVf9Uju0QTxeM7qyzsFvjxC2wg22tbehX31/SJm9BNy1rd7F9mz4/I7wWIOyochA7o
         jYI4KNg5raPVp/aUMK4m+9BVUIrqy9g705g+PzL/aM+51EIWTDPoPwJO1R+oq6O/zkxq
         WwAnU8nCSlkZZ5jicpMM28Q08Q9qEfqwbGsxwrjMgLdMcZGaPGgsf0WYctLxbE2hSZ4K
         320UzJDpnS3h4ghKdvaHP0gY0oY8NjtY5Fs8G1AoF1rVG6S1Gq6WBrdu7lPK4QjRwZVJ
         4nIL7HTMa/6P/pYK1M9yZBXoxLyMyJ8nWWFlGz7seDprtGTdEXDuPDSGqpBUXMQMcVEK
         f18A==
X-Gm-Message-State: ANhLgQ0ZT76Yekn+47HO7f8U7zu90Uw9bKqCJZ6UwaEXIp3v4z8+zY02
        LkaS4vK4ARREKVs7j5p5rbu/KGDMjoY=
X-Google-Smtp-Source: ADFU+vt/qyK7p3F+r+cqK2AeVbGaHD1ejYTl64UxxNdW9cr8aeEl8NFfLtuT/J0SOVRAF5RsRTUrvQ==
X-Received: by 2002:a63:7f09:: with SMTP id a9mr5379154pgd.375.1583379373514;
        Wed, 04 Mar 2020 19:36:13 -0800 (PST)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r13sm4040241pjp.14.2020.03.04.19.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 19:36:12 -0800 (PST)
Message-ID: <5e6073ac.1c69fb81.fb0c5.be7c@mx.google.com>
Date:   Wed, 04 Mar 2020 19:36:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.6-rc4-67-ga76a126302eb
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 1 runs, 0 regressions (v5.6-rc4-67-ga76a126302eb)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 1 runs, 0 regressions (v5.6-rc4-67-ga76a126302eb)

Test results summary
--------------------

run | platform         | arch  | lab           | compiler | defconfig | res=
ults
----+------------------+-------+---------------+----------+-----------+----=
----
1   | rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 11/=
11  =



  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.6-rc4-67-ga76a126302eb
  URL:      git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it
  SHA:      a76a126302eb84e78d7d3fc9c7e69487fb97e8e4=20
