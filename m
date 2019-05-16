Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83D720271
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 11:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfEPJXc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 05:23:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41148 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPJXc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2019 05:23:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id z3so1265124pgp.8
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2019 02:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=reAgSdPZ/Igx7TP/G4DFm5yRB5oI6NXcR4YRtQByf1A=;
        b=AabVOpc0gax5y+C34MwQA8XkHzluhPkc93PJn6cEymixXWGT8AUzl1dNJ4pU9uVb1e
         GpB82yMP99M52j2Y3rQUP6OoCY7o5ErYKmID6yVZnXfsn6IPu8VxP/fenqWHRtteWZMi
         V/2Bf6FeKafR4m81+5tNZzKmTbeBs3AQsOtixYHzFiaHD06OQLy6Lxo63jB00qGRbVFc
         fAx0TdpgM2u404lkqC5aO2sl/qL9QzVSGbo9dJK0nM2UKvvAc+cAc0b2ntQz6dICxBuu
         rGnQfWI/5ZuRroAP2vMMcyGvLK3+pxmvkI+fmWJKuGQOOal7lYdksBx/uJxR/I9nB9Xk
         6xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=reAgSdPZ/Igx7TP/G4DFm5yRB5oI6NXcR4YRtQByf1A=;
        b=pB8Fj+dZcRbDCF6jpa2G7ZrY34tuYzM3wKXUCLdoncgVaFoJvTpuC8dQE+9LEu6on1
         54wDSWJbrHyLmLlfcxyeh4s31Xdp5lxH4FamNCkwdp6jXjuCkOV6Zo82TXU2yh8QQXPd
         JFVt5TI0UIsVXbmDEvFahc58c8qaao+WMNDywWPqCBmUsAjzoItWKCDbByghqkCR2VXl
         juhK0JXzGwDSf8jmBCxZY1JBACs4uJbmYX8HIqz+6YGXjm8K8nXpCo1QVPKI5JbNgqFL
         rNQxjzJkQWDsOYrZmx6FB5vY2L8NoG+5awxWrQE3FJzUAw8HSR8xomrgfEqG6hEkK2Wz
         /FsA==
X-Gm-Message-State: APjAAAWacXgQbBPoUQQNJ+cojrPxT+2p8ROh1dgwW1TyJvdoAbva+YfW
        08fQkVBMQHwA7sgQz7Iwg4x9bA==
X-Google-Smtp-Source: APXvYqzNARvSk1LSdQloLfBOFGXDLFTRU7QAXyWtKTnPx1omDlEXCkQ0bQF3o6bztshPU1rHZXHIEQ==
X-Received: by 2002:a65:5347:: with SMTP id w7mr94039pgr.375.1557998611813;
        Thu, 16 May 2019 02:23:31 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id s80sm14002886pfs.117.2019.05.16.02.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 02:23:31 -0700 (PDT)
Date:   Thu, 16 May 2019 14:53:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, fan.chen@mediatek.com
Subject: Re: [PATCH 0/8] Add cpufreq and cci devfreq for mt8183, and SVS
 support
Message-ID: <20190516092328.4n7kuqw7bxokhdjp@vireshk-i7>
References: <1557997725-12178-1-git-send-email-andrew-sh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557997725-12178-1-git-send-email-andrew-sh.cheng@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-05-19, 17:08, Andrew-sh.Cheng wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
> MT8183 supports CPU DVFS and CCI DVFS, and LITTLE cpus and CCI are in the same voltage domain.
> So, this series is to add drivers to handle the voltage coupling between CPU and CCI DVFS.
> 
> For SVS support, add OPP_EVENT_ADJUST_VOLTAGE and corresponding reaction.

No version information here or what has changed. That doesn't help.

I believe this is V3.

Don't resend it but please mention the changes in reply now. Thanks.

> Andrew-sh.Cheng (7):
>   cpufreq: mediatek: change to regulator_get_optional
>   cpufreq: mediatek: add clock enable for intermediate clock
>   cpufreq: mediatek: Add support for mt8183
>   dt-bindings: devfreq: add compatible for mt8183 cci devfreq
>   devfreq: add mediatek cci devfreq
>   cpufreq: mediatek: add opp notification for SVS support
>   devfreq: cci devfreq register opp notification for SVS support
> 
> Stephen Boyd (1):
>   PM / OPP: Support adjusting OPP voltages at runtime
> 
>  .../bindings/devfreq/mt8183-cci-devfreq.txt        |  20 ++
>  drivers/cpufreq/cpufreq-dt-platdev.c               |   1 +
>  drivers/cpufreq/mediatek-cpufreq.c                 |  88 +++++-
>  drivers/devfreq/Kconfig                            |  10 +
>  drivers/devfreq/Makefile                           |   1 +
>  drivers/devfreq/mt8183-cci-devfreq.c               | 310 +++++++++++++++++++++
>  drivers/opp/core.c                                 |  78 ++++++
>  include/linux/pm_opp.h                             |  11 +
>  8 files changed, 517 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt
>  create mode 100644 drivers/devfreq/mt8183-cci-devfreq.c
> 
> -- 
> 2.12.5

-- 
viresh
