Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF861D9A39
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 16:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgESOmZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 May 2020 10:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgESOmX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2020 10:42:23 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE628C08C5C0
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2020 07:42:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id z15so1281336pjb.0
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2020 07:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=1YPND3Jc9Njwr0x15O/YhVqSycIa2wq3TrSHXv1Lu2Q=;
        b=yGop49S27X8a5xkkcdv/+OFTXD0EhttyBFdn3NfqrxEvOOydnnPZWDqufjTAZkNS92
         SDGrq3hzybn3Wn9z/KdjDIPD5CfOmIBKENgUp1frm2mt8CYgGfj4AdN841qVe+AGjidX
         Jcbe/baN9Pkx9q/ZexOtCY0EMMveGkHXY9toCJYa3TMS7WZTWFpDlUEPkfoLjUdiQSDs
         0ZVBrQzLi517ajcr7l+q6FtbU+HRlzjUlZgMmCg25HFFS0jHIeit4+ssfgOj8v9XedKF
         FQIqb6+fo1pVD1BeshSWyLUDq836YWHbHDPUxh/MwQymkXoStMYKEjo8+F+pdzl4/vRJ
         5kyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=1YPND3Jc9Njwr0x15O/YhVqSycIa2wq3TrSHXv1Lu2Q=;
        b=ePLG97HnXeT6Qu35LOC+7IvK8QPNqejq+JmFEdi2GG3U0l9o65L2V1R1B667luNxsn
         CqyadmWANPj9yg27Q/jbj7hnJFqd36iIIisELAEfMnlzl8XM/5TSPLLlL6Qf35wqfwwY
         ap2JuibiJFBOUR2LWqXTJNISTs6pGPqRZgoehff4aTuUxto1bIcUAqFlJa42EmUfHFk2
         mKsh2zklDAYYcBTY7d03k8dAcWDz2HZEEvLdMu/c04HlJNKE7I6IREGGQ9JCXtxL0kvI
         m/9WQAIZOxnpOut68M20lwFE4SryqdhLinK2Yr9ZKkhY4YAQNwgG+6mp4z6cO3AwjbE2
         ZEww==
X-Gm-Message-State: AOAM53396nQ8ZDLqU78qQCMZt1Z9t5pXun8S+CjUO+sy/0zY8NtT83yB
        wCVI0iCB5fpaEKqG3S8NAuo3JA==
X-Google-Smtp-Source: ABdhPJzvxUGTtub1lKMzDo0tjmylgazy/XPihFJ4KSE0TVpsrnSo1nrZa5Q+4K8NYfpg0zPdgZfrzA==
X-Received: by 2002:a17:90a:3563:: with SMTP id q90mr2028458pjb.0.1589899341202;
        Tue, 19 May 2020 07:42:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t20sm11241961pfe.24.2020.05.19.07.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 07:42:20 -0700 (PDT)
Message-ID: <5ec3f04c.1c69fb81.89096.3b6a@mx.google.com>
Date:   Tue, 19 May 2020 07:42:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc6-64-gbb7ba30bf960
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: testing
Subject: pm/testing boot: 1 boot: 0 failed,
 1 passed (v5.7-rc6-64-gbb7ba30bf960)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

******************************************
* WARNING: Boot tests are now deprecated *
******************************************

As kernelci.org is expanding its functional testing capabilities, the conce=
pt
of boot testing is now deprecated.  Boot results are scheduled to be droppe=
d on
*5th June 2020*.  The full schedule for boot tests deprecation is available=
 on
this GitHub issue: https://github.com/kernelci/kernelci-backend/issues/238

The new equivalent is the *baseline* test suite which also runs sanity chec=
ks
using dmesg and bootrr: https://github.com/kernelci/bootrr

See the *baseline results for this kernel revision* on this page:
https://kernelci.org/test/job/pm/branch/testing/kernel/v5.7-rc6-64-gbb7ba30=
bf960/plan/baseline/

---------------------------------------------------------------------------=
----

pm/testing boot: 1 boot: 0 failed, 1 passed (v5.7-rc6-64-gbb7ba30bf960)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.7-rc6-64-gbb7ba30bf960/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
7-rc6-64-gbb7ba30bf960/

Tree: pm
Branch: testing
Git Describe: v5.7-rc6-64-gbb7ba30bf960
Git Commit: bb7ba30bf96014ae2ff2284d0b6ca70068b706f0
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 1 unique board, 1 SoC family, 1 build out of 6

---
For more info write to <info@kernelci.org>
