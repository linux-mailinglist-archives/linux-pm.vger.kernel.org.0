Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07F8D12806
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 08:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfECGuc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 02:50:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37520 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfECGub (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2019 02:50:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id z8so2257797pln.4
        for <linux-pm@vger.kernel.org>; Thu, 02 May 2019 23:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZusQRLArOzmqo4smuWdH+L1kBJBE5kLkpXfXVHOX9rM=;
        b=dyMaPAIFugojW/MQ5xQzBnuUPvFWpgJpjzGIYRhRbgp8ViJVXWSp5Pw/YEpjDAwc1F
         qsHcQ0tT1uAnj6XB9QNHEwD8Kjmqpkek25svpvwD6JMexr+LhkfjvJVY09BvnlNa/eOQ
         MyEDkuoNpoxumnuim514KRgzXiyCxXp+9c2RxtGLXYwyYbTe77x6B8fOFpQP7agMcrZj
         qdn82U9oxl1ClwmodiKgJs9t2n6+Bcxr8W9LNKkd9jaJDs9+pqjIG7CFnTI5qKWOZy61
         J62U+Ovb92AJ7fMe2Hc5fpNYvYlfpqM+29FQ0M4yz5zOX4VlRUyBtp5W5l57meWDWi6I
         37vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZusQRLArOzmqo4smuWdH+L1kBJBE5kLkpXfXVHOX9rM=;
        b=hM01cdoeXWuF63mJMqtH6K+ejiQYk+PXujIBbz+RL5C5YCvTl9Mqv9pda1/BKgM3Xa
         1BzXrp1QTjkdMbwVm9gJaySw++fx+tbBW0UWEahEYk9gSTtcFWghxKFcCZg+39e3TlNK
         MwqlLTJoOjAmV78Y9Z1Sx/l4BxRW+XfpDWT2QR58KzqGGCKehh72e/KnTU0Sq4yii6Jc
         b/0gDNFeTOmFJAyb40wOwoIQjf44DPZvk4jPYJnhNsx/JEW0GDNJmfS6DWK/D76DOiju
         jxkLj0p1MjyCvSMiza746Pi4xCk2aHzq68SS52Jj24IH8Lzc5wc+ccT4iKYd12Ky7x3g
         vA7A==
X-Gm-Message-State: APjAAAVzCFttgTp6R7+BJoaQtV9M0YJWk4bmftM2/PyMqP5+alAX9MqA
        FP/RyrlHAJ17GUZJy/bdgDfn6Q==
X-Google-Smtp-Source: APXvYqxhFfCsYglwk894BNIFGSrE92DJ4O80HqScawkzC6+i9SiA0jZsiC9+5lqhAu02+9EHvIxQFQ==
X-Received: by 2002:a17:902:bd88:: with SMTP id q8mr8314189pls.287.1556866230990;
        Thu, 02 May 2019 23:50:30 -0700 (PDT)
Received: from localhost ([171.61.121.242])
        by smtp.gmail.com with ESMTPSA id n67sm1668508pfn.22.2019.05.02.23.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 23:50:29 -0700 (PDT)
Date:   Fri, 3 May 2019 12:20:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/3] cpufreq: Add imx-cpufreq-dt driver
Message-ID: <20190503065026.qwroewhu5lxckqgl@vireshk-i7>
References: <cover.1556836868.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556836868.git.leonard.crestez@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-05-19, 22:44, Leonard Crestez wrote:
> Right now in upstream imx8m cpufreq support just lists a common subset
> of OPPs because the higher ones should only be attempted after checking
> speed grading in fuses.
> 
> Add a small driver which checks speed grading from nvmem cells before
> registering cpufreq-dt.
> 
> ---
> 
> By default kconfig builds it as a module even though it's very small.
> Couldn't find a way for MODULE_DEVICE_TABLE to match on root node compat
> string and there was no other appropriate node so register the
> imx-cpufreq-dt platfrom device directly from imx8 soc driver instead. I
> checked module is probed by default and rmmod/modprobe again works.

I have suggested something in 1/3 for this.

> It seems that cpufreq-dt insists on adding the opp and regulator itself
> so can't actually call dev_pm_opp_of_add_table and then
> dev_pm_opp_disable

Well we can surely implement it someway if that is what you want, like we can
pass postinit() callback in platform data to cpufreq-dt which can get called
after OPP table is added, etc.

But disabling OPPs after they are added isn't a great way of handling it as
well.

> so implementation was switched to opp-supported-hw.

I will say that this is far better than disabling the OPPs after adding them. So
this is a good way of doing it.

> Maybe I'm confused by API quirks?
> 
> The market segment logic was dropped because I couldn't find any good
> references in datasheets for why lower or intermediary OPPs should be
> disabled on certain market segments. Using opp-supported-hw means that
> adding this in the future would require changing flags inside DT instead
> of code, that seems undesirable for DT compat reasons.
> 
> This could also be extended to mach-imx7d speed grading.
> 
> I never noticed anything wrong with going above the fused speed grading
> however it's technically unsafe so the cpufreq parts should go in before
> DT changes.
> 
> Other changes since v1:
>  * Turn into a proper module
>  * Support imx8mq
> Link to v1 (RFC): https://patchwork.kernel.org/patch/10916769/
> 
> Leonard Crestez (3):
>   cpufreq: Add imx-cpufreq-dt driver
>   arm64: dts: imx8mm: Add cpu speed grading and all OPPs
>   arm64: dts: imx8mq: Add cpu speed grading and all OPPs
> 
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 23 +++++-
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 23 +++++-
>  drivers/cpufreq/Kconfig.arm               | 10 +++
>  drivers/cpufreq/Makefile                  |  1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c      |  3 +
>  drivers/cpufreq/imx-cpufreq-dt.c          | 99 +++++++++++++++++++++++
>  drivers/soc/imx/soc-imx8.c                |  3 +
>  7 files changed, 160 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/cpufreq/imx-cpufreq-dt.c
> 
> -- 
> 2.17.1
> 

-- 
viresh
