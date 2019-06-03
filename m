Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07D5732925
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 09:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfFCHLM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jun 2019 03:11:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42195 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfFCHLM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2019 03:11:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so6480591pgd.9
        for <linux-pm@vger.kernel.org>; Mon, 03 Jun 2019 00:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qm18g2EWN56tn+30WXhvjhc6Deqa0sfwyr6OO2dMMGc=;
        b=EVkE7KvhSAwj6CijMdMBTze/Y3Ta1Ydzm7tQIDqJY3uO1UUehTqRfjLhag2P0TOyu4
         X8J5kctBrCbCH10ff3m1LM693Ylt6Rk4qFfJ6HqRQN6hgqCnvKmXOJ23JvBRljl+8aGy
         Mvt4Hh1OiOlXrDD5afZ0y3IMVxGiTrElV/54EenbtcpdNwFnIhBOYgiluF41GR70istx
         3JcK4VAD5GlxYBCEYMfjqrrF9yoL7k13d4vv5GxOzM6rVM/EsgQ0VwG/kFwjV+XxOPTg
         HjfVu0+KNrZscWWdph/AzQGxVPHszKPTejeBG/EkLjz20uwUFT1neQGiwf1l5A1ZosZd
         N6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qm18g2EWN56tn+30WXhvjhc6Deqa0sfwyr6OO2dMMGc=;
        b=iZfT26H2boGgfqAriYM1SFJnPnyEEczC1vCXegrLEfBHUM5B4oXbVFJQLjxpwRdLu7
         3D4YUkjmH4jKT4gHGPyLiEMpcaSugmR0uIO/r9YaYvWt5yb7HMdcknUwwV5WKvOPuubl
         0tsr5mk6pmNpUR+nAJi+cdCfmUoSaplPlzXlyJ818ipas8nRzQZt9J2wEAUodOLKqwon
         qlceXA0e+DP+U60NIgkrESrXMvE9PxW7ldaxIRRDJHe8zgDhzZc2Dr9wGKF3iRnWEcTV
         ghZxm/1ONUaXUpR0vKbFz/gURiOoNeU94SpK8FS1tXkp0P+4Od6zeJxQxG9BUzV0uri2
         HEcQ==
X-Gm-Message-State: APjAAAWz+iYmxVvqr6DY8z8/4yGNLG3Hb9iW+3r6yvhEzACR9ir8aOuB
        xSZ8H00pmlatqXxGSIsdetaNHw==
X-Google-Smtp-Source: APXvYqzzgxYFOssxgDncS+tgpwltYQPncZLlvPo5Vj1BvECm+EaZeUf2qkpwOqD/qtwtgaGrzOHlmA==
X-Received: by 2002:a63:5ca:: with SMTP id 193mr2657457pgf.232.1559545871531;
        Mon, 03 Jun 2019 00:11:11 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id m7sm21245374pff.44.2019.06.03.00.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 00:11:10 -0700 (PDT)
Date:   Mon, 3 Jun 2019 12:41:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] cpufreq: Switch imx7d to imx-cpufreq-dt for speed
 grading
Message-ID: <20190603071108.toainiom76pth4qs@vireshk-i7>
References: <b6a9b9f80534af5c12db30a0bb699ec850f85be7.1559131365.git.leonard.crestez@nxp.com>
 <8787934ff35e7e55837f2caabc0d5bf65828d971.1559131365.git.leonard.crestez@nxp.com>
 <20190603053850.tkskdzcloir4k3kw@vireshk-i7>
 <VI1PR04MB50551BDB2D0AA64D7192D98CEE140@VI1PR04MB5055.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB50551BDB2D0AA64D7192D98CEE140@VI1PR04MB5055.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-06-19, 07:01, Leonard Crestez wrote:
> On 6/3/2019 8:39 AM, Viresh Kumar wrote:
> > On 29-05-19, 12:03, Leonard Crestez wrote:
> >> This driver can handle speed grading bits on imx7d just like on imx8mq
> >> and imx8mm.
> >>
> >> diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
> >> index 5061503cb0a1..ce26ffc18ce6 100644
> >> --- a/drivers/cpufreq/imx-cpufreq-dt.c
> >> +++ b/drivers/cpufreq/imx-cpufreq-dt.c
> >> @@ -18,10 +18,11 @@
> >>   #define OCOTP_CFG3_SPEED_GRADE_MASK	(0x3 << 8)
> >>   #define OCOTP_CFG3_MKT_SEGMENT_SHIFT    6
> >>   #define OCOTP_CFG3_MKT_SEGMENT_MASK     (0x3 << 6)
> >>   
> >>   static const struct of_device_id imx_cpufreq_dt_match_list[] = {
> >> +	{ .compatible = "fsl,imx7d" },
> >>   	{ .compatible = "fsl,imx8mm" },
> >>   	{ .compatible = "fsl,imx8mq" }, >>   	{}
> >>   };
> > 
> > What is the purpose of this array and can we get rid of it instead ? I am asking
> > as this driver gets probed only if the platform code has created the
> > imx-cpufreq-dt device and it shouldn't get created for other machines than what
> > is supported.
> 
> Maybe it will be useful in the future to add .data here if a chip starts 
> using 3 speed grading bits?
> 
> It can be removed for now.

Yep, please remove it then for now. And it would be better to break the current
patch into arch and cpufreq part, so I can apply only the cpufreq parts easily.

-- 
viresh
