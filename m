Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B457B175B0B
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 13:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgCBM6a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 07:58:30 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:33022 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgCBM6a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2020 07:58:30 -0500
Received: by mail-pl1-f181.google.com with SMTP id ay11so4181671plb.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2020 04:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=hx5S7hM1RH2EiXzzY3ptGx1eLOWouBM8er+Nb2Nwwzg=;
        b=hbJWf1A63AWIC4F/V3bGDWXrCGuhlDoY1XCHBBo26V62AlM4Ok1DRd20Re7eQNulcn
         J53or8TeKH2VV3a05268vR6oE5MJcRk+IVBbBZcj4Tjy0hKBtf95qZJgLzcu0BIAeE7V
         zE0iWOjOGCALlNjdDV4JxRUgsFYL8MfR/f/giG3JhMpYpgGXLHzBcZlgDQ7/Y+vRDitq
         zD9M4kfa48Js8+eV/vyri+LXWzfPgPROo6mKcQwx72Uo+MUmrVeGhzgrfDVVQSDzjSor
         N5l+OEzPAiFML5o7xE24mO35/DJDpElxPwsOk/WwloCLSKT2VEPgRpSHVzT0zTV3jKt5
         NiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=hx5S7hM1RH2EiXzzY3ptGx1eLOWouBM8er+Nb2Nwwzg=;
        b=sXd8Hir4omr5AAijnZnXaEVD1OkKY7dEiqw33Z4aLojjyk/AKwvPjRbsDRq1iLbeV1
         DSYgO3XKZ6BuiYLq6ovURLF5x8jYzdztFJa/xrQ/4CTO+Ut8x4LLf4vEvBggvIjzKItX
         Dm2eUMeK1ap5VtnupHzYt/tTu/5gmdDytfcwSTVI8zOhq7B5ui/YB0zYxou03/QT6qQx
         nFieBfQMjPSyIGAA4MR4J/8Ma1EUDl53U2ZV+0gkg+O4uNOusSGUwS8VkryjD1pV0rzm
         HzIIfnqaor9kPAgZNbbcvSzR4RFPoijQtGPia26O8qeiXSj7GC3f7pac5FBn5VGf6TCQ
         GJiA==
X-Gm-Message-State: ANhLgQ0Wm8YV5mBgMYQvkUQ6ib0AbecMlmr4vTkCeeUNmnK+Ip0XN+tb
        YoPq4ekiq2lmga4xatUoRJEr4A==
X-Google-Smtp-Source: ADFU+vuurZlhgF69pSEYzpwePV82AED3wJ+wx+Xicg8urkjUULAryEJcO3dvfVO1nQgO2NCisjh9/w==
X-Received: by 2002:a17:90a:b38e:: with SMTP id e14mr12446496pjr.35.1583153907283;
        Mon, 02 Mar 2020 04:58:27 -0800 (PST)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 7sm9480615pfg.12.2020.03.02.04.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 04:58:26 -0800 (PST)
Message-ID: <5e5d02f2.1c69fb81.cc3ec.9381@mx.google.com>
Date:   Mon, 02 Mar 2020 04:58:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.6-rc4-56-gf99f4dfcc7da
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: pm
Subject: pm/testing boot: 24 boots: 0 failed,
 24 passed (v5.6-rc4-56-gf99f4dfcc7da)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 24 boots: 0 failed, 24 passed (v5.6-rc4-56-gf99f4dfcc7da)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.6-rc4-56-gf99f4dfcc7da/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc4-56-gf99f4dfcc7da/

Tree: pm
Branch: testing
Git Describe: v5.6-rc4-56-gf99f4dfcc7da
Git Commit: f99f4dfcc7da2a275bf6c1c864a829afab018816
Git URL: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 24 unique boards, 6 SoC families, 2 builds out of 6

---
For more info write to <info@kernelci.org>
