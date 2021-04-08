Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87FD3587E6
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 17:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbhDHPK1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 11:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhDHPK0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 11:10:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA496C061760
        for <linux-pm@vger.kernel.org>; Thu,  8 Apr 2021 08:10:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g18-20020a7bc4d20000b0290116042cfdd8so3139030wmk.4
        for <linux-pm@vger.kernel.org>; Thu, 08 Apr 2021 08:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bJO3m9kpFM7FzruFJ4qQ0cN3krVAmVb4P9PPJOl2Fyc=;
        b=oI5ASPtwtc6yZAQX4+FRjEYgySPWc9H+xcfFFIG+kp6YE0eDHNGnqX3l+BxlHHE3tL
         QicTstREGHPzmgX047l8rctMIN8ZYYTs1/D9yHBqCk+dIzDY9TcN8ckkadaclQPNslH0
         5+ucPAcTueRguY2IfOEn+XlxYWQPsT03O4650mSjEf6pkjMenxk7NrV4SLiRyvBO1T9R
         OW92ZclZaz9eS6F9oIv1p970ljI3mei4RJiA5Zk2cudcsjvOzeTTpp+pPPrtcEO6g+5p
         ilfF8HUO6Ku0ANak5rHUHd/ovCSXj5zGDUMrZ4Qj/Xn4KTDsQ8ywNVkIi0EE+PlHaO8L
         5r8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bJO3m9kpFM7FzruFJ4qQ0cN3krVAmVb4P9PPJOl2Fyc=;
        b=VdcyIp2focO/85xWLn7xKdxdYqvlw3hy6Bfwdjw/d/tRBns/iSmFxtDP4F+M/ZTOWY
         lqYHccL9J4MesC4EDd98IriATRilP+qauJ02NZHrW7SfUHsKJQxDu7+2q6pOIHOHGo3j
         AFe2iabP66C3aw9mmobJJHxxMOi8wPFF/7u1//evATUW+agiz7VqqXWZ5ek+wEHvlfiB
         zKVGz22gRNQ6m/tTN1GNYX9UTVqpjbUl8ZiE5pQiLfJvZp7f1It+TiahrP4pHx8CJVGz
         NyURIk/ik+woYM7ECxrgB3bOdwWeqtAqHRyzOaCWMhXl3fWmTIgauDtyFfeu8oNdrX7V
         bzBA==
X-Gm-Message-State: AOAM5318WnLzCyleRxPaTSNAGi8z+hjHfL2tHNX1G8zylDYyY+nKrTBI
        3ua/Gkbgv6d7DGa/kXHvVNWd0GTzjeF4IYKN
X-Google-Smtp-Source: ABdhPJw05yk6Np0QciLv6Xuo6fNciMVJVijaQUICwN3sn6qXk5IAofBNlFDW3jtU8gHjlmNU95KiSg==
X-Received: by 2002:a05:600c:4fc2:: with SMTP id o2mr8820195wmq.25.1617894613180;
        Thu, 08 Apr 2021 08:10:13 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9407:6619:589b:441e? ([2a01:e34:ed2f:f020:9407:6619:589b:441e])
        by smtp.googlemail.com with ESMTPSA id l13sm6211336wmj.3.2021.04.08.08.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 08:10:12 -0700 (PDT)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, He Ying <heying24@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] cpuidle for v5.13-rc1
Message-ID: <03743d3c-a3bf-066f-614c-1a49f566fdb2@linaro.org>
Date:   Thu, 8 Apr 2021 17:10:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rafael,

please consider pulling the following change for cpuidle on ARM for
v5.13-rc1

Thanks

  -- Daniel


The following changes since commit dde8740bd9b505c58ec8b2277d5d55c6951b7e42:

  Merge branch 'acpi-processor-fixes' into linux-next (2021-04-07
19:02:56 +0200)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux tags/cpuidle-v5.13-rc1

for you to fetch changes up to 0beffa4e524f3989ac31fe8563348d45a87f7314:

  cpuidle: Fix ARM_QCOM_SPM_CPUIDLE configuration (2021-04-08 16:49:19
+0200)

----------------------------------------------------------------
- Fix the C7 state on the tegra114 by setting the L2-no-flush flag
  unconditionally (Dmitry Osipenko)

- Remove the do_idle firmware call as it is not supported by the ATF
  on tegra SoC (Dmitry Osipenko)

- Add a missing dependency on CONFIG_MMU to prevent linkage error (He
  Ying)

----------------------------------------------------------------
Dmitry Osipenko (2):
      cpuidle: tegra: Fix C7 idling state on Tegra114
      cpuidle: tegra: Remove do_idle firmware call

He Ying (1):
      cpuidle: Fix ARM_QCOM_SPM_CPUIDLE configuration

 drivers/cpuidle/Kconfig.arm     |  2 +-
 drivers/cpuidle/cpuidle-tegra.c | 19 ++++---------------
 2 files changed, 5 insertions(+), 16 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
