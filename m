Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C801F8D7E
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 08:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgFOGFp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 02:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbgFOGFo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 02:05:44 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6DBC05BD43
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2020 23:05:44 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ne5so6318317pjb.5
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2020 23:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5bLWZytUDahU9Q9Fv7DQgMv65OXHOnlVrBakZLDuOLU=;
        b=UAuaHkfe0wS768I6KfkDZMQ7Vwm9+9PrDtdzupG41ieIJxdIWi+51K9LbclsplhZWz
         zd1RyRwcg3qpWEDPTDraRvRhEBwBErRC1RL9i5y5htRQt05/MvWD2l81QUY+BA6JnqQY
         QXwc7TrAbrD7gDLztoZQx9UlqtuTvt5Rn9s7WDfeTvvVGjydkJbC9fE/K82vE+X5f0kg
         o0E9VuJH2EPGk3orcVSPLeMzJR5VE/pQ+bg+cEoIJoHfZ6v8Wwug2r6gAgYsKScRILzR
         GPTf/QcgtdVGBxjf/e9/OyPC9IUUIK8R7q7MMJfLWqJ1GdtuhJDs7X617bwyOGPuB00O
         /sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5bLWZytUDahU9Q9Fv7DQgMv65OXHOnlVrBakZLDuOLU=;
        b=R6DvKI5UkgyPN7CVqB3wrfhcq3eTcIFDQIhDiXdwg7dW8jq3Mwbt08CfCVBoYAyfuk
         PXMed555b5x4NRmPO2IHRiG+sEyi6JxrnGnmn8sfjWV+1+P60jUlrcN2CmnZUQXfzL4R
         hBDfmhYlgBPiYcivlEzTUGqT22grYHXp6tEO0xJpXJcMqfgzYPkgtoTc9/MpIL0HJGP0
         qmKpoMNWEIDtdkiEqEPrZ4PMlci7Z1SZoALMRFYCHkfLMaR/D2YPA5DwVVijee4J0AGQ
         HoLonEy9ZWMYlrqlqHD4FjmHAIBwe4WdCGefGq/K86QiCPtIIPFBX8uAH8/ftYkCzIn+
         a8AQ==
X-Gm-Message-State: AOAM533RMppic1z56QpnZggMkT7BwMJlvduTFek9j+1mdAwm4vUvCWB3
        Kct741rvogw4V/iiO072EF5xUA==
X-Google-Smtp-Source: ABdhPJwBvfb/D2z4n4g+jVVzuvYhCqdDXa+Ze1hTZMevweB3Ou2NJS//V04kvss2kpjQzJ2/vZxMTA==
X-Received: by 2002:a17:902:8bc7:: with SMTP id r7mr1198369plo.57.1592201143894;
        Sun, 14 Jun 2020 23:05:43 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id o96sm11712703pjo.13.2020.06.14.23.05.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2020 23:05:43 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:35:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Markus Mayer <markus.mayer@broadcom.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux Power Management List <linux-pm@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] cpufreq: brcmstb-avs-cpufreq: more flexible
 interface for __issue_avs_command()
Message-ID: <20200615060540.tr5bzgeviqajijec@vireshk-i7>
References: <20200528182014.20021-1-mmayer@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528182014.20021-1-mmayer@broadcom.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-05-20, 11:20, Markus Mayer wrote:
> We are changing how parameters are passed to __issue_avs_command(), so we
> can pass input *and* output arguments with the same command, rather than
> just one or the other.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 30 +++++++++++++--------------
>  1 file changed, 14 insertions(+), 16 deletions(-)

Applied, thanks.

-- 
viresh
