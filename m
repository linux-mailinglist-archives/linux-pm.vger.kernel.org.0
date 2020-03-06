Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDFED17B3E4
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 02:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgCFBoM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Mar 2020 20:44:12 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:46942 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFBoM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Mar 2020 20:44:12 -0500
Received: by mail-pl1-f172.google.com with SMTP id w12so164235pll.13
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2020 17:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=TMQ35gZO54bkiMQ88+YOXMwO6N/OAOPXnEgNTDjqcVM=;
        b=bD0M8uwAC2a81eFMYQ7AikFggVWtSRxLlo2Gw7U6qXN1Tc0vv9P3b0fM0BYq8KIdfL
         Ie415UdpD9U7YMs2FCDMpB/jT0VBxTse5LpDpQxxgPdYnjlR9s4ZgmyYmhvygr+htmUl
         ErGtnkkGre0lyb4EwDlePkf3MLVROE3pV1DZBwx1GaoDIN8FN6xM+HhStnXvAr8ThSOk
         w7vunBha2EUP7OJ3/jW++MkX85KCJkSqVfW/1LyO/lQCfTAh7GNpSWv9CRWJv0vcjgt2
         ZXdKS8cOqsEvKUzku/NscxRXgwrRZM1yyxiFkalyT5iip7+n2eDwiNYABdVsvVHvWnKy
         iydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=TMQ35gZO54bkiMQ88+YOXMwO6N/OAOPXnEgNTDjqcVM=;
        b=D9z4mosAT+a5TjelUaWr4o8tQymF7/5IDZbA4hZFsvWJJ233I1HOKBxIFZ/6lRLL58
         IfTpLFPxQxIKgeEJV0/zhdSqyLErU9rxZ5XJvakcjQBDSI0gyhwkqczjjM12WdSiBx8n
         QSl9halm26IUVGh1NZ/wPBoyNa37bdMt5830Ztv89wOnZzPEiifePclsyXtSjsAEhNZA
         +EPJYLUxI3EU9ms4y8+a4xan7Ygmua6QcAwshk1OWX80JfOT+z9uaQ9n7aHXMO/I+x3H
         kD1XaLCl0+FokWiw/1GyuEs4k/cuF2D6x8WDiw/RQxjOZgXhzArpukjbULlaX5vUlNc1
         K5Qw==
X-Gm-Message-State: ANhLgQ01RXLTX6QCLs8tQcEfKjktGL/YdBPb1TKqyjDM3mzsvR5Y1uVI
        XE/hf7WX/1/eIsKQrxgfuynAbQ==
X-Google-Smtp-Source: ADFU+vuDy7g7LJbBackeSomFQgjqfY/SU+pyepHPqBzDP59jToB5nlqRfCkCQxicMEGCb9pi7chNjQ==
X-Received: by 2002:a17:902:c086:: with SMTP id j6mr692637pld.46.1583459050866;
        Thu, 05 Mar 2020 17:44:10 -0800 (PST)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b21sm34900071pfp.0.2020.03.05.17.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 17:44:10 -0800 (PST)
Message-ID: <5e61aaea.1c69fb81.45a63.d6d9@mx.google.com>
Date:   Thu, 05 Mar 2020 17:44:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.6-rc4-78-ge63a6b3d7d38
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: pm
Subject: pm/testing boot: 30 boots: 0 failed,
 30 passed (v5.6-rc4-78-ge63a6b3d7d38)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 30 boots: 0 failed, 30 passed (v5.6-rc4-78-ge63a6b3d7d38)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.6-rc4-78-ge63a6b3d7d38/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc4-78-ge63a6b3d7d38/

Tree: pm
Branch: testing
Git Describe: v5.6-rc4-78-ge63a6b3d7d38
Git Commit: e63a6b3d7d38c359b20aded5ec6964ffdf61ca96
Git URL: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 27 unique boards, 9 SoC families, 2 builds out of 6

---
For more info write to <info@kernelci.org>
