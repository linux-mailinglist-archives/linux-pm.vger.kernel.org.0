Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4A41B930B
	for <lists+linux-pm@lfdr.de>; Sun, 26 Apr 2020 20:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgDZSkd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Apr 2020 14:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726156AbgDZSkd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Apr 2020 14:40:33 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF26C061A0F
        for <linux-pm@vger.kernel.org>; Sun, 26 Apr 2020 11:40:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fu13so5769183pjb.5
        for <linux-pm@vger.kernel.org>; Sun, 26 Apr 2020 11:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=CmvEEHs3Ok/ey/aMSNCIlhRs6aK7HNCNXspdSgL8vWg=;
        b=IYZn4QVCOQgiG0e8vq8a/6iNYNDyCP0OgM53vdUvYkaDZQhOmVFXJNZ6irIhuAKRdJ
         38pBYXUa+NO+HRDp19U704BctsMMAZDORopHUNnUdSFMGTbAWymG3FItnqp04f/s11rz
         2ab1iMlnxJo1fMNorQodVqAvNQTNWBialRwimsCWZR0Hjy06kDCKVP2f5w+W4q+qo56E
         Mxesibs3IixeOdafCbUuR6xpvGIQIzZD9xwkBaTtFpsmPRGAZiTvCXCB5iMcfTPIQds0
         u54OzBTMFR1VE1TLcWenP8/fBk4mv5udJRUKwiOA2ibGnRB9YcakqKc2xZSzGe3s4VvW
         BGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=CmvEEHs3Ok/ey/aMSNCIlhRs6aK7HNCNXspdSgL8vWg=;
        b=GmSwZLf4HhtxdWvFujZPfT+gGNY9R6hnIWBo9aZ+xJJ7AnR4rE0kTW3vB+rDDvk6i8
         z+aPpNSq2hiqhyaLiie5QOV74lPKAsPxUDpO2CozXxp6FsHi9CQgzy18okQlQpLTPOm8
         lG2TZ/0dKIXCW47uroZeJGyxuRPQdH2v4TDLG2POChGuytS/psefBbJmbVzwBHk+3NMn
         JZi54clR0VwvxILuHW9eKB/1H5mcABowQX6NUL6IETnqButgpqhKu25QvgjsjmlJiwEY
         KXmk45TuTGuLCbeOk/Q2R+PkdgdjmqQrcJUTJrbz2w3G7dDxFSUDj7a0G9Dtz2+Odv8t
         OZ7A==
X-Gm-Message-State: AGi0PuYrXntcfZqBZBj2c1MUagprWYVSroqA/v+cgfhDiRzgdKOon+k9
        9mc/LGfqJrf/AZL0g1BXI3g6h1+zmho=
X-Google-Smtp-Source: APiQypKdUh4qXJzMZua3ek8aBZsETyVHeBuk+xyV+/U2p5oib7n2ZJe/eaoar7TEJlF+cW02e2vRQA==
X-Received: by 2002:a17:90a:340c:: with SMTP id o12mr20229635pjb.22.1587926432813;
        Sun, 26 Apr 2020 11:40:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g9sm9246354pgj.89.2020.04.26.11.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 11:40:32 -0700 (PDT)
Message-ID: <5ea5d5a0.1c69fb81.df757.25df@mx.google.com>
Date:   Sun, 26 Apr 2020 11:40:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: acpi-5.7-rc3-250-g177af5b82ac5
X-Kernelci-Report-Type: boot
Subject: pm/testing boot: 49 boots: 0 failed,
 49 passed (acpi-5.7-rc3-250-g177af5b82ac5)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 49 boots: 0 failed, 49 passed (acpi-5.7-rc3-250-g177af5b82=
ac5)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/acpi-5.7-rc3-250-g177af5b82ac5/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/acp=
i-5.7-rc3-250-g177af5b82ac5/

Tree: pm
Branch: testing
Git Describe: acpi-5.7-rc3-250-g177af5b82ac5
Git Commit: 177af5b82ac567bebb27ee08d4fe5556d6fd4e8c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 49 unique boards, 13 SoC families, 3 builds out of 6

---
For more info write to <info@kernelci.org>
