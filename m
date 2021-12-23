Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F1C47E61F
	for <lists+linux-pm@lfdr.de>; Thu, 23 Dec 2021 17:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhLWQC0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Dec 2021 11:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhLWQC0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Dec 2021 11:02:26 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C786C061756
        for <linux-pm@vger.kernel.org>; Thu, 23 Dec 2021 08:02:25 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s1so12352412wra.6
        for <linux-pm@vger.kernel.org>; Thu, 23 Dec 2021 08:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Gmz+I9YOWUFBoJ3b8t5RcyDp1oBXQrMfwOu7m1+e4oc=;
        b=kCpiZ4Yxxr+HJMxmCAWeXSKoTq1bqZHJRB5MOqMrJDjJAXMKbgZkNezFgrT1Gx7z7V
         wYHjGQYjFA/Y9tzZ7dbqd12HQWp/vHPtCISZoM/A8kQkdCucYVbeMm3a7dvc775VrtEV
         FW+JhCBaQdvKJGUCC5xqOfrQm1bYkmvQwpNigFK1cDyBWg7AEfABJmQDiNR7StE3xzSk
         XrdAshoSqivvKTB5zH7RDhSn3OqvzqJ1R64JKh6op6L/d+suqqXHPNRV0IFBSK8uHCXI
         ZG5H+MGhNS84wqwksvH1W0rgktA8++8OjEvUHZ8foFBi9iufpSGCnXE8jBpxtxIAclAu
         s0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Gmz+I9YOWUFBoJ3b8t5RcyDp1oBXQrMfwOu7m1+e4oc=;
        b=YGzAUw4X2wdlyjQ8D1V88klx/oo4h4lZ53GVv/7AIg4q1VRrtwIDyT2bIExKhIOkT7
         AYReI36eZ4GLYWUbl9ukE45nwenrBDwd1zk6G+NtJbReC0hBT9QnImDwZ/IW0t+8S0D/
         y84U6WklNrKHCS8EdE2jh3dwBGj/yw0F3Oh5NqPSfcMS9UaxGaQU3n0+38vYqJieKXXL
         FIMtVJIzU+/dtD7jXfjxFgXdDNG8RGba/y//UKIpxyrV+gCLiU8xskGK2Afh4CT6CdP1
         Fr/NzShj3PiNRa/pP7y19b7EytlmdHFX41Bm1U1ot4P25QEjk8T+W7U3t0kBoyKXqMm8
         0EtQ==
X-Gm-Message-State: AOAM533qHr4DKj9BTKdSUYFC4tfUYwPH4AqdpJ2RweQicXsHhS3oa6Jz
        JrqP3Y0Rr/nUmaA/0TzuKYU7u6kfu2A7NiIz
X-Google-Smtp-Source: ABdhPJynqNZQq5iIVvl9LNrEkjZokX6G2VkRE1WFIeLkjjKnEeMKchCyO6nXP2vIrfsIcpERCuY5YA==
X-Received: by 2002:adf:d226:: with SMTP id k6mr2074178wrh.243.1640275343827;
        Thu, 23 Dec 2021 08:02:23 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:34ca:f67b:b782:1949? ([2a01:e34:ed2f:f020:34ca:f67b:b782:1949])
        by smtp.googlemail.com with ESMTPSA id n9sm9545318wmq.37.2021.12.23.08.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 08:02:21 -0800 (PST)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] dtpm for v5.17
Message-ID: <ffbefd9a-5dff-5c3d-8a24-2d42b3aa42ca@linaro.org>
Date:   Thu, 23 Dec 2021 17:02:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rafael,

please consider pulling this little changes for DTPM

Thanks

  -- Daniel

The following changes since commit a7904a538933c525096ca2ccde1e60d0ee62c08e:

  Linux 5.16-rc6 (2021-12-19 14:14:33 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git tags/dtpm-v5.17

for you to fetch changes up to c1af85e442278fe120974358cf71c41bc48e0580:

  powercap/drivers/dtpm: Reduce trace verbosity (2021-12-23 16:57:36 +0100)

----------------------------------------------------------------
- Cleanup and reduce trace verbosity (Daniel Lezcano)

----------------------------------------------------------------
Daniel Lezcano (2):
      powercap/drivers/dtpm: Remove unused function definition
      powercap/drivers/dtpm: Reduce trace verbosity

 drivers/powercap/dtpm.c | 6 +++---
 include/linux/dtpm.h    | 2 --
 2 files changed, 3 insertions(+), 5 deletions(-)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
