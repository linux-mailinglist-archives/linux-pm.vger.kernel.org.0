Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE39D2311E
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 12:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfETKNz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 06:13:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46099 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfETKNz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2019 06:13:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id t187so6554597pgb.13
        for <linux-pm@vger.kernel.org>; Mon, 20 May 2019 03:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gSl0hdak9nrx3AjRA/ypcoIYXLtCzaU4jnEbvPcvNt8=;
        b=JRFd3PDnga0E3LWtPoEqEV/39WriE8SzZ1OaF7n/NU7nJdlpwBoLgwLmjKEJpAvjPX
         XZ1SmHbXXZ193KXruJGSbPsK93YJQfC5wXGkZOU3cIdhtTLLZLncciU/VgFYv4ypoWcA
         UiHM6mh2RtiZrTevU5N3B6/lVDmfAWk6wlP9NRY324hi0FxwNsGhi9wdsu0rHb0Vhx/n
         MGClOrhlg89rFShwBGqLaf99mD6KezVo7RAEdSWVDA5RW2t3yQjpL46CSYkkwWwS81n8
         YTa9BrWd0ZSm0L2gZBK3heWtESBBTKDrSRGtSF/T6+IdbseVqzVpkKLX6PPaHhg3PXvH
         S4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gSl0hdak9nrx3AjRA/ypcoIYXLtCzaU4jnEbvPcvNt8=;
        b=ha62jHxUzF0p4EhfqGsylRZ44LrxNvZOYKbKBuVjal+tgQNRtIyYR97SfuVe12ZN6z
         4v9YTfv4NDnpVxSS1+RjOugE3gYWB4XuUjU+XQlx0ur64maKGUEeluywoo+T79xqYUuc
         tNpXt4B1gHoyBYmdwhAxQhSGY89asXmmJjpeya/rZRmIsTLedXLwikP+T//nt3lIsBe2
         bQIYC2QvDLQG4F0chE5DnyaYc/rI8ETWpGP1jv4JFnMqits8Fuj332uYpCtEm188dOdX
         8iOu7AolH+CC2TQTmZft7BBV3j0K3p76BYCURboKEoauNCI7nCUVNVAVZxgDdnljQFNG
         O5kA==
X-Gm-Message-State: APjAAAWD/v2rHJFagsoBtuQDqXb4GlDAZTT5uJiQ9EowtkpZ548+PeYU
        R85sp1V1Dros4AOnlxcaSkV2WA==
X-Google-Smtp-Source: APXvYqyOW0QZtrH8O3rgAfo54rMSqrN3OZdfxdsodXTr+NokNvxXkGxPwDt1wmWe8pWIuVP0SPHygA==
X-Received: by 2002:a62:1ec3:: with SMTP id e186mr33157231pfe.197.1558347234346;
        Mon, 20 May 2019 03:13:54 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id i17sm22287324pfo.103.2019.05.20.03.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 03:13:52 -0700 (PDT)
Date:   Mon, 20 May 2019 15:43:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 0/5] cpufreq: Add imx-cpufreq-dt driver for speed
 grading
Message-ID: <20190520101351.huda4rmpdzaegnj7@vireshk-i7>
References: <cover.1557742902.git.leonard.crestez@nxp.com>
 <20190514071322.avosfk4fzz2hzzx6@vireshk-i7>
 <20190520071417.GU15856@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520071417.GU15856@dragon>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-05-19, 15:14, Shawn Guo wrote:
> On Tue, May 14, 2019 at 12:43:22PM +0530, Viresh Kumar wrote:
> > On 13-05-19, 11:01, Leonard Crestez wrote:
> > > Right now in upstream imx8m cpufreq support just lists a common subset
> > > of OPPs because the higher ones should only be attempted after checking
> > > speed grading in fuses.
> > > 
> > > Driver reads from nvmem and calls dev_pm_opp_set_supported_hw before
> > > registering cpufreq-dt.
> > 
> > Who will apply patches 3-5 ?
> 
> Me.  Will apply them after the first two get applied.

Applied just now.

-- 
viresh
