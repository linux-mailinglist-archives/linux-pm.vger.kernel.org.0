Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A68C317F504
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 11:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgCJK10 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 06:27:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38436 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgCJK10 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 06:27:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so1395041pfn.5
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2020 03:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=UVxjDbJ8yG3WbrAvw48nY6/lmV1Vt18fzd7yy2pI2bk=;
        b=ETQhc7K9vKkN5Q91wE7nOAB5omcJBCGYt3axAyhwtII2UsT6CLk+o7eaH/cz8GRk9v
         pvXTf9MszeGwU56cOjDABAJ3m/bNF4AoIsgN+thhWb/c+2vqRiNjyYV9OhtbaH6nswse
         EtG6DtU8InHx0exYjqPb5ztupXDSzad+qxdkvCYHIxI2nGCtuVjKlLRVEK7amL4wEX1J
         zXo4dyODP3rWRHmbAkWgEDOSjvbYUJjmHJmLPkq3etgfvVFQcNsDlkNhphrLYpi9ha+A
         o45mP3XskU0+uFWR4vSjmAcOsTnQ86z6gec+t6rQipq85Mq5wjeVEWh3RZ4tc/8TESp7
         pHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=UVxjDbJ8yG3WbrAvw48nY6/lmV1Vt18fzd7yy2pI2bk=;
        b=laj/7z9wVmyRqOgiE1CdwnKXzJC725Wrxa/5aZINNMLOwf6//w7KZZQZpuQdP7nvUb
         R0r3p7nIynHW4vBL5KR66/Rau30nD1lXEh7XzHO1CWCfTuiYClwEImVXeCUNTSWqpo2Y
         wTP8SVVgReAeIWGecnC1CfkLUf1XjR+SVuqCzvlJa130QSplCTI58fKdlAi8b3craTXt
         2GqafM5PpGa/k+VG8KBq9LHHWMzfjRwd2Q52qCJLPpn87MsUT9twfPrrnJSg8YasdsZJ
         wgngOf1xuYU8FoAvzWQACTLZeKuTfuRtq0yvfNhbzrE3KQ/fnWnlVioHf7R6RpePJPCS
         We7A==
X-Gm-Message-State: ANhLgQ0TAesLB1X/m970KG+eU8HnheyehlG6+JdQIsdegM852yZDKEMM
        xVkNtwcmvduIYGREmRD/JUnQUw==
X-Google-Smtp-Source: ADFU+vvy7XsorDvH8Rj4cQbMNDnaeA3kylo+pPg9Z/bQGJVfX/NSC1p0DjZvvIM11anPSJdlXOfa3g==
X-Received: by 2002:a63:441e:: with SMTP id r30mr19913058pga.51.1583836044146;
        Tue, 10 Mar 2020 03:27:24 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k6sm1382563pje.8.2020.03.10.03.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 03:27:23 -0700 (PDT)
Message-ID: <5e676b8b.1c69fb81.c359f.40db@mx.google.com>
Date:   Tue, 10 Mar 2020 03:27:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc5-83-gabcd59902c64
X-Kernelci-Report-Type: boot
Subject: pm/testing boot: 25 boots: 0 failed,
 24 passed with 1 untried/unknown (v5.6-rc5-83-gabcd59902c64)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 25 boots: 0 failed, 24 passed with 1 untried/unknown (v5.6=
-rc5-83-gabcd59902c64)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.6-rc5-83-gabcd59902c64/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc5-83-gabcd59902c64/

Tree: pm
Branch: testing
Git Describe: v5.6-rc5-83-gabcd59902c64
Git Commit: abcd59902c6467999041971af4ab14f30a2b3780
Git URL: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 25 unique boards, 7 SoC families, 2 builds out of 6

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-8:
          sun50i-a64-pine64-plus:
              lab-baylibre: new failure (last pass: v5.6-rc4-78-ge63a6b3d7d=
38)

---
For more info write to <info@kernelci.org>
