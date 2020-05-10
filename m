Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F325D1CCB31
	for <lists+linux-pm@lfdr.de>; Sun, 10 May 2020 14:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgEJMvD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 May 2020 08:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726863AbgEJMvD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2020 08:51:03 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E009C061A0C
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2020 05:50:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id e6so6388173pjt.4
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2020 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=E6VOb3CpiTpBmH85DNhDZ9KxbLlufHJSBFW9fYF7ANE=;
        b=kCrJFRPi9XTEVyDtJurpsTJBqpaTZF4745nlNJtCKppNwsr9J6qBLSHnTuFPTwyZNM
         UYl2rCH9ezrA9kPJaQGNSGOHVrVXDTOBruBuODXc+AgJ7uTkTofhhbQ9EQc5CM0WlP1l
         z5I37KD0ICIrt5f/fh7dCrgIGzRoct80d2jqDf0AF+XDfSPSCd2fWUEjgHW4Nh9x7x8B
         uhI+27Z+eFpr9QHmNXamkBMURLBPoWVwtcVmBKt76dY9krfet9wZ+IruwW4+6K/4E2h8
         Jx2W3n/Tbw+ZfoB4QCTJv1d3sKT60+o8BxYGDHY3JvRLXOWmAUtMLvHQzPk4z3axIo0F
         umSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=E6VOb3CpiTpBmH85DNhDZ9KxbLlufHJSBFW9fYF7ANE=;
        b=YmArg6G+XMstkAz8Ep9jrI5i7PytarC7FZYYVZ2WmC9jmOEraj8duUTzu8/ervtsFB
         oCW4ZZIMA8Hl/xfUh9gAeQf7S9tlZ/rG7F8inodg+r+PY3iTmEICJsXfURJjzOzUgQBZ
         VKCL1M7shpZCZV944QOnaiA9vw/lyRrREfd06zuDAZRVg8Jf+WR5kE53eFp+3p5C5pP3
         aUGk3bbNLiE+RLukWBK/5Sz0rhlN/3TqpG4Qi4kqKYciwhT5V7Eg/FThdBXmh0TXMI3/
         mNlemBnOhdI6l5IuOW9Y5BEKiytCZhKLr64m3OKjyl1ltBq3f91caZvVOZoGrpOLBPIG
         G5uA==
X-Gm-Message-State: AGi0PuZXxHhoiHH1aY8MVf8nGElfGFapmMyW5z7rc2MROsV5op30YFVP
        dw3JPH+0Tsw3XgZrOQPxxzQyDw==
X-Google-Smtp-Source: APiQypJpwLnzSNWLARBBmzeZqXUA2IxS5hCibKPlEEHPkxV6tXvHn5h2QvgBb466rjpvfYW16fwt4g==
X-Received: by 2002:a17:90a:fb4e:: with SMTP id iq14mr17273280pjb.146.1589115057480;
        Sun, 10 May 2020 05:50:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i21sm1921414pgn.20.2020.05.10.05.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 05:50:56 -0700 (PDT)
Message-ID: <5eb7f8b0.1c69fb81.d6599.6029@mx.google.com>
Date:   Sun, 10 May 2020 05:50:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc4-41-g277a1722e66d
X-Kernelci-Report-Type: boot
Subject: pm/testing boot: 60 boots: 0 failed,
 60 passed (v5.7-rc4-41-g277a1722e66d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 60 boots: 0 failed, 60 passed (v5.7-rc4-41-g277a1722e66d)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.7-rc4-41-g277a1722e66d/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
7-rc4-41-g277a1722e66d/

Tree: pm
Branch: testing
Git Describe: v5.7-rc4-41-g277a1722e66d
Git Commit: 277a1722e66d47e6fc8b63834273f83631e33562
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 53 unique boards, 14 SoC families, 3 builds out of 6

---
For more info write to <info@kernelci.org>
