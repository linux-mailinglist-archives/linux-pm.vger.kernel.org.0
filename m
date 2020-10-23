Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418CB296B4D
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 10:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460681AbgJWIh5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 04:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460677AbgJWIh4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 04:37:56 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F237C0613D2
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 01:37:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x13so664372pgp.7
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 01:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Va8ts6a4Am407gshGkf677mIZGRewAIXYF9e6UNiPl8=;
        b=qZh++PakWDfWQaCPx4PHufb8MscJWFMsERaUAmsnmx5/i0aQAt6Ax9EpCQgK72uNJI
         bOYCzGhW6fWDIHmEYxxjTPGsUk4lypFdANrpHVO28k3V+m/zxTWAsro6g1gBlfFbi7+B
         QmWfgHkBMTXbQcs16d8Mn7jZIdYL1ZuGi1s+4PdYr/Ufxn73fw44wdPAMA9ZSM+7dF18
         cKHUKW6UomOwHzJOFUEBgHwe+UqfJe9ImDQGYW20rflFNFZMoSn+dEk8x1PF13wN0h38
         1skEBLQU7Xx7YIXW4sAOw8bOfHLQQFUS9OJyplUGM5vW6rSJCaKb4d3TASSD6m+qtzJ+
         PWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Va8ts6a4Am407gshGkf677mIZGRewAIXYF9e6UNiPl8=;
        b=lWE0w+d8Ub8KKjz9XKwJVnnqBdQ76DNbh7Au6BoKWpORM1onC6RYbIJyaNXHPPrDkK
         UUzgk8+8NEQc9+TTurgIQ/tA+Igw9F02PkHlRjmX3peVZH50S8XSGA58FwNhFMW+TZVI
         u24zk6Y+TDw5wHW/G9ccjle0B07yUiCDbfiZfyvhxYtwXg6hOmATB9hrmb36U4s3m0T2
         VL/AVt+uj1JsaD3RD5iAeWqIualvN56k1ioav/A/kYg8zsiAz2IWg8N5eQz+UxE0uh1M
         NtsHh2QLamBpT09V+jz4oy3txS9RkMwgweybPOnLBA1y/NUUYYM7jp5W4usv1042JdDC
         m6RQ==
X-Gm-Message-State: AOAM533ZrKH0M3xyQy45VqODquVZxWiKxUlBzcMHA/M82D3y7Yr4yuCv
        pFUYn6Yg12LyVoJ1KCpWoIRtMA==
X-Google-Smtp-Source: ABdhPJzvwM7agBM8o5iD2nhR22zj6lxjJQ41h59XnY+6Mh7VdeZdilMlX2MulKBFEniL7EkdoXa8pg==
X-Received: by 2002:a17:90a:6ba7:: with SMTP id w36mr1300199pjj.12.1603442275873;
        Fri, 23 Oct 2020 01:37:55 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id w17sm1302824pjq.42.2020.10.23.01.37.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 01:37:54 -0700 (PDT)
Date:   Fri, 23 Oct 2020 14:07:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v1 5/6] cpufreq: mediatek-hw: Add SVS CPU initialization
Message-ID: <20201023083752.bvs4oabbsdzlnnip@vireshk-i7>
References: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
 <1603441493-18554-6-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603441493-18554-6-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-10-20, 16:24, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Use pm_qos to block cpu-idle state for SVS initializing.
> CPUs must be in power on state when doing SVS.
> Add polling ack while coufreq hw is ready.(SVS init done)

Why is this required ?

And when you send the next version, please send a single patch for the
cpufreq-driver by merging all of these together.
