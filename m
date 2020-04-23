Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636AB1B589B
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 11:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgDWJzV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 05:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726593AbgDWJzV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2020 05:55:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8089EC08E934
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2020 02:55:19 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y24so5859520wma.4
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2020 02:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CNZHIzr/sBiOQMg4o7SLifEDxLKhTFFCAk3xHKq/Wkk=;
        b=DsyXxkNH0btzVamhIFYzv5e350yw7X/w1LKFwogh0iIwGOZ96kVPXuXkDX32LZlwAC
         94fwg0MWeHie4nOwR95Jrn7cRtHYa60rXz9VOiMSFM/iKMyymQip57NZrPEQTg9A9yrb
         sU1IjCQpH+9HLWLKs738y4q6R63guG/pQy4hAMFfXU/FaxMDYHU6DOWGVn+x2CbWEpkx
         Vo5zrIPAcwf72RxKvq889DHMx7Sv/eAARH47GGoJKHa8+8uB7M208Vnt1tgwYaqBlp/v
         5UkeF6iEQSn2bZD9AtRien1PivU6B7DVufUotKDoDbqTxnfNsCAXWKrMdChEeIIErbT7
         0RBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CNZHIzr/sBiOQMg4o7SLifEDxLKhTFFCAk3xHKq/Wkk=;
        b=es4LMv75eHc1bnVMWJH8vpnXWZK+I+HfhLolVvseovU41D90f7k3oZg8/pCac4HkQw
         SeyhEEahjcplzTkDWwuOjSO8AlyG1LgNc4/VP5ksrVJ8h+LYeJs7h1bn7D8CyLMPH/fk
         XA3+tGFoS9KyW5B4LwSM8An5J15QfLl9dtRz2+vXBK7OIqrvg9GogxsxMHMg8tfLeEJp
         K9IU4EmorZiX6A+r5sPV6A7UuVfyv/sFX7dNXd6MeBv1iDN81mwn2jgwM7/RU8i39gBo
         coPqog3CXhl83vv9wpUJvQh84voRy5mEmFI1w/m9O/TeASWoFsAIBgKnrLdJYm/9MTsS
         +19g==
X-Gm-Message-State: AGi0Pub1WEzQPE94LzDDDCpqeDMOccCtD5FAI9XY9dKRDwD1OHQV0M13
        jZztUboMrPgBFCzPF2FixDZLMg==
X-Google-Smtp-Source: APiQypL6ZyvDfFcOWCfVXnw6SXTOR2+Oss71maaUGGL6LrnXJ7de4PKprtb6zu5/4UALDKzAFGgGXw==
X-Received: by 2002:a05:600c:2112:: with SMTP id u18mr3386058wml.112.1587635717910;
        Thu, 23 Apr 2020 02:55:17 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:75d8:694c:3b71:4e43? ([2a01:e34:ed2f:f020:75d8:694c:3b71:4e43])
        by smtp.googlemail.com with ESMTPSA id i17sm2997016wml.23.2020.04.23.02.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 02:55:17 -0700 (PDT)
Subject: Re: [PATCH v6 01/10] PM / EM: change naming convention from
 'capacity' to 'performance'
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com
Cc:     Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        qperret@google.com, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org, mka@chromium.org
References: <20200410084210.24932-1-lukasz.luba@arm.com>
 <20200410084210.24932-2-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3f764593-99fa-bce3-3630-ce16101df536@linaro.org>
Date:   Thu, 23 Apr 2020 11:55:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200410084210.24932-2-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/04/2020 10:42, Lukasz Luba wrote:
> The Energy Model uses concept of performance domain and capacity states in
> order to calculate power used by CPUs. Change naming convention from
> capacity to performance state would enable wider usage in future, e.g.
> upcoming support for other devices other than CPUs.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
