Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964924364A9
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 16:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhJUOtV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 10:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUOtV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 10:49:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B4DC0613B9
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 07:47:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r7so1464603wrc.10
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 07:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=is8+swaqrmvRkUqnwjGLeiataGEx//BFQGkRpZB+O54=;
        b=M2THfA2Hllc5CJruh3LOMiNrTcf1owB5bKvVNtI7fAhIFeAgjvDJpxUdRfweBIdyMy
         xR3DEnMbEq6d+uuPoOcOLRhUi1WmuEz7oHZYcz4sp2bzP8+HnY5jdcE7g6ZjSgC6nGBQ
         2go/Gq8gupd38Q1MiCiXjHyX/mMLzDoL7KppTX/eBCUp8Ii4KC4hwzrxNIRUQ6NkWR/+
         rd0QsqRJw9JxD+Wc/tjdYZKR6bIMNiigetZoHl7srwGWT7TJP7HPNbvfA+yEcGnLtcwp
         i1nLCrsIzbLdy2ng8GdM67JK31iNCnaSniCllZ+95NKAWyQ5nGavfO9gFR4v0OOSD7ye
         asYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=is8+swaqrmvRkUqnwjGLeiataGEx//BFQGkRpZB+O54=;
        b=rmGWI/nTY3eQ06//u3rZPICSyoB2uyIlM2PH/QC/C1Kh91goZo01omI4hDqbvvizc+
         WHhaIWrTgcHxw+g0iPOC4mfhcn4bUQ6SGT6Rb6NuKrQ51UvQQzsDxFb3dPWKbSvWi/om
         l/whjNIjq83NPYAAlsjVisnJ6gpO+9ugpiCpv5Ucwe3sKA6AE93tvkJht591WsfCGWdt
         xEHLib89XlR5Pal6E35DP3YizvFybC9Lo+Kd3XRQqsoA7arYYEr7orKqwrYG76iSvG8e
         RwynFXv26Rr8z7yya6WvyQuP0sWdcjY5YIjCZqAooc8fmr6X6oPOptegSSQZD0T+zbxO
         pIBg==
X-Gm-Message-State: AOAM530Ghs3A9cUkdkv9XzWyp+Irkrs5DVd0xzXyLzSQ2KnuOrDP1A7y
        2FMR9B+HBzGvdjL3aG4V3sd7QHzuQHFxdjXb
X-Google-Smtp-Source: ABdhPJwhlZf4eeU28NMr+4ntEVrUmwLww5Nc3hZprJoM6ytCejTYhtMMY7kK1hfa4WaWT7wYqZlvyw==
X-Received: by 2002:adf:e689:: with SMTP id r9mr7904305wrm.426.1634827623585;
        Thu, 21 Oct 2021 07:47:03 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:4116:c86c:e3ac:c3c0? ([2a01:e34:ed2f:f020:4116:c86c:e3ac:c3c0])
        by smtp.googlemail.com with ESMTPSA id l5sm5229247wru.24.2021.10.21.07.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 07:47:03 -0700 (PDT)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lukasz Luba <Lukasz.Luba@arm.com>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] dtpm for v5.16
Message-ID: <9c7709b1-c5df-a87e-d9d4-e83a749fa488@linaro.org>
Date:   Thu, 21 Oct 2021 16:47:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rafael,

please consider the changes for v5.16 for the dtpm framework.

Thanks

 -- Daniel


The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git tags/dtpm-v5.16

for you to fetch changes up to 5d8cb8db9f791252ef5b7951b6d8cc6281de60a6:

  powercap/drivers/dtpm: Fix power limit initialization (2021-10-21
16:03:31 +0200)

----------------------------------------------------------------
- Simplify and make the code more self-encapsulate by dealing with the
  dtpm structure only (Daniel Lezcano)

- Fix the power intialization (Daniel Lezcano)

- Add the CPU load ponderation when estimating the instaneous power
  consumption (Daniel Lezcano)

----------------------------------------------------------------
Daniel Lezcano (5):
      powercap/drivers/dtpm: Encapsulate even more the code
      powercap/drivers/dtpm: Simplify the dtpm table
      powercap/drivers/dtpm: Use container_of instead of a private data
field
      powercap/drivers/dtpm: Scale the power with the load
      powercap/drivers/dtpm: Fix power limit initialization

 drivers/powercap/dtpm.c     |  78
+++++++++++++++++++++++++++++++++++++-----------------------------------------
 drivers/powercap/dtpm_cpu.c | 228
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------------------------------------------------------
 include/linux/cpuhotplug.h  |   2 +-
 include/linux/dtpm.h        |  26 ++++++++++++--------------
 4 files changed, 173 insertions(+), 161 deletions(-)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
