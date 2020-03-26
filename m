Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFCA4193510
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 01:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgCZAoe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 20:44:34 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:36370 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbgCZAoe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 20:44:34 -0400
Received: by mail-pl1-f171.google.com with SMTP id g2so1492103plo.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2020 17:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=J4cQB2AnaUfSLx7/bI4NtJr0ljNU33LLDdd+ELyLaWA=;
        b=onfZXu7bZ5jvGodibUMn4ciO5kQqYXVOtt1tRPOScd9wLxrGg9m85rcMu4Sd4pDbnM
         9rtspjUkZpqgx7YXYTIgyK9QkdgeI6Z4LmxMhyM9ESUl7w1me8TQlNz1juR85dAGllU7
         fvY/TM9lc+OluDauMA+wX0JKtufqQS+uXRoiqP/gm6DM8Up3mZJTAk2O3UfyP/sWb1m8
         egqkDdPVo2UcpR2ueSqnNFU5wA0bFYZf2Renmy8sbSmV0uPAYb3cE4bCzWWONyTsJsLF
         +RMgbufqc8GXpXk2O0CqPe7Mc+PtuZxZfS3NlaJKcaAM203S2CPqpYKU4zozyPhkkd9O
         Rv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=J4cQB2AnaUfSLx7/bI4NtJr0ljNU33LLDdd+ELyLaWA=;
        b=OFI4XiXX9MlEUzNbIfIAs06wEiinXScyI7C53QF5Y6v167Q5LrS38I/mrxvPiS04OM
         /cHVsWLzJQTmAhTQRAKeUJUmhqRQ+lua8TImuFKjSWjdeRBl0aWHyL3NRC5PjhkXCyXI
         bpnGX0zg3MYL558Aao2oysPWpU/5r7+Sy4CMashoZC3RiNSnn0C4Ey9Ba4/2fUIqWoY+
         2dwxMjh+jr2bzFRiWqOFzDUVmGUx2tQWJtsqsM7K1gsHXM+1HsRj1QbO7Dy4zbXEHYew
         h5GmLIuq7WuDHQeRFxtRwXAf8VwIDuuaJKQaLhem9FX0I8qZ3IioxLN3Sa6wcCI2f1Ht
         AEfg==
X-Gm-Message-State: ANhLgQ0o6jbcgL7FLwhlsJhuhKY0BXde9laat21RKvwPboOMvgwqSRND
        F21ZHFrniibodJW/1XU6+SPCCA==
X-Google-Smtp-Source: ADFU+vvZZCquSeJaJjjacH7WUu9j/NJqDN9RHPqyzt6295OVuoKYX1hGdYW9sPzJyDfdS47PFsIstA==
X-Received: by 2002:a17:902:34f:: with SMTP id 73mr5446510pld.50.1585183473289;
        Wed, 25 Mar 2020 17:44:33 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e9sm266416pfl.179.2020.03.25.17.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 17:44:32 -0700 (PDT)
Message-ID: <5e7bfaf0.1c69fb81.263b.17b9@mx.google.com>
Date:   Wed, 25 Mar 2020 17:44:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.6-rc7-121-ga4c3e5efdcaf
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 6 builds: 0 failed,
 6 passed (v5.6-rc7-121-ga4c3e5efdcaf)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed (v5.6-rc7-121-ga4c3e5efdcaf)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc7-121-ga4c3e5efdcaf/

Tree: pm
Branch: testing
Git Describe: v5.6-rc7-121-ga4c3e5efdcaf
Git Commit: a4c3e5efdcaf10511f1f8e03f59133fa32bddff1
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

---
For more info write to <info@kernelci.org>
