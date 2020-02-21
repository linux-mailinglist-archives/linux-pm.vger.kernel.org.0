Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 446D3166E48
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 05:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgBUEPE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 23:15:04 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:41925 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgBUEPE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 23:15:04 -0500
Received: by mail-pg1-f178.google.com with SMTP id 70so319763pgf.8
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 20:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Ogg+a/F0Lrc51OMt1CYuzlqbL9hkl4DkeLG6jXmXpt8=;
        b=ZpWlJ2S58xt10h69eF4xD5GyQKCsaSvrbkNcIP6QjroRvKPGl543ZeQUrnF7KaLFwD
         dz+NH3mEL4dblczZlp+v3BkegQOb31cuZA28rjXtFgEM6sKvRRlJWmgiuGd8jh6c+5yn
         7F1NXVT72ipR9oJECEXof+RARtn1+/JPULcXDEiCYWlxZFe/0C1qj3B/beuH3CxyZQQ8
         Ij3gi3UPBsRv1G9cvuB6+wqAdLeBgBv75MAUjMIbP0j0Pea/50aOJBCOfZ5BH+/7LPJL
         mMIcVyEOs4ru/w0aywj41nJyNbXKO/Lnuk98pKv8KfhAQ4KKDph58fUpUwpRopuJDtiS
         H35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Ogg+a/F0Lrc51OMt1CYuzlqbL9hkl4DkeLG6jXmXpt8=;
        b=HfKNJiu3ySVlKffNKrXsTj4YQAW0gIYaIu1oZ8FDLFxheQnKQ1N8/qV1V4PBSA+byZ
         t43qQwgoiNoVzx1V9QCgKJQHqz9ow/LOHSioTHix9xLOuNBD+ns+K6yRBay6LI2xQI75
         BWLrLCMi6Jv3m240RakxWOhLZ0PDHl0S2x8Y/vwZ5oK+dM/mzxUYnk3HVzhiEoULdZl2
         lVz3rCYIJxNzd6v82DTDFuSMRQgiXV59KGMrz8DWlsYazngH1uYeHxSfV1vP6cSKlf7l
         2ODyqHzlmRw6keZj2+ScqdsaqYiEdcWsUVacdrEr5hyaJsIqJDRLldP8k0u4IGSHjFsr
         ryHw==
X-Gm-Message-State: APjAAAUiv7KRJDOdFKKtWZjBjbR4f9UtKYHji1tEv14UcopDTC79T2Y2
        XjstHMDj3smiBeGpEXbPapO7mg==
X-Google-Smtp-Source: APXvYqzI9Cnd+t6O9m76cJudSLQl9ivhwwTE83UTE88L+Bu7nzaYcTV96lyPbXeHXK0tkQTu5a8COg==
X-Received: by 2002:a63:f103:: with SMTP id f3mr35331024pgi.394.1582258503327;
        Thu, 20 Feb 2020 20:15:03 -0800 (PST)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d22sm1043328pfo.187.2020.02.20.20.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 20:15:02 -0800 (PST)
Message-ID: <5e4f5946.1c69fb81.26c76.49ee@mx.google.com>
Date:   Thu, 20 Feb 2020 20:15:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.6-rc2-54-gc6cef55cdff7
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing boot: 59 boots: 1 failed,
 58 passed (v5.6-rc2-54-gc6cef55cdff7)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 59 boots: 1 failed, 58 passed (v5.6-rc2-54-gc6cef55cdff7)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.6-rc2-54-gc6cef55cdff7/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc2-54-gc6cef55cdff7/

Tree: pm
Branch: testing
Git Describe: v5.6-rc2-54-gc6cef55cdff7
Git Commit: c6cef55cdff715472903e65bda7182f1f254ef6e
Git URL: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 52 unique boards, 15 SoC families, 3 builds out of 6

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

---
For more info write to <info@kernelci.org>
