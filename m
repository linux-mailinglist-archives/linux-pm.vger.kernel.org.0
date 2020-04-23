Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6DC1B5984
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 12:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgDWKqy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 06:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727077AbgDWKqx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2020 06:46:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFFDC08E859
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2020 03:46:53 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x18so6282694wrq.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2020 03:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B1TBwFKRribKH6U+f2YHZKct8m6eaNTnkPh6s+3we4I=;
        b=LZH+oOofFZ6HTrIFYsXaoNlGuvZDH5TfmDKrwIVEwXATLJ/gyO7J7sHyrTD+/agh8O
         wWiBCM0FAZhVUMCrQXO7MVYC4rLCk7VA2qyt9dIa3ZKfWghqzp+RuJgis10Fj5K0M5sO
         pglrlJg6UBZe/QVph5+sbzAlxLr83iDJkP8jfFart0ffS4ED2ONJgo/X5zGpe2mTItrI
         D2/MiHPJ0/UjxCcnfxINq0p8TeK/xKrdedYUGtckd19yz7WTCbDj+abPTK1xTbstCekz
         /PV4W/s0wv/F/z6wBMYDWjuOGUjW1Zj5Ma6SnFE3rWo5uuxGnWI5vpdvebrxZVskGRg4
         Iiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B1TBwFKRribKH6U+f2YHZKct8m6eaNTnkPh6s+3we4I=;
        b=TFeB14NvSDqKiS6Guo+3oOGipI2UL0IAVlQmuWFS2a9EQ/C8r1iDioXA54jLWQH8N6
         YdittgBdCZXLJFwZCqRFIS030in5pdqSa9q2q/uYF79oHKHsI4nu+nA3wEpWxawtX2ek
         F69EoXso7WAFtTC83HfymEzlXOxeHUyGAxPvbMI5q6DEObyYMt+KqBeAUYZmbYY9y2Ca
         aCPsZ3sYYhbNa1My07b3ltxiobxYF9NkENrAukWr68Bxv68M/P9T11pXN5GE5Y6E0tG+
         Ri1YUipQOIWjMvBfe7IdxEPwY1PTrt4HlRL/Tl9gFRJ9gRPQw1xwFZMIw6rmQ2Sxp3EO
         46CQ==
X-Gm-Message-State: AGi0PuZxrRw3oL15GSdfML7+7HxWFhhdlYEwo+VK8QjSUDDrkcS0RK3L
        QTwaB36WmULL/nw2PtJ0m5UDgQ==
X-Google-Smtp-Source: APiQypKk6XUIzuutA3wLhgUEchycCeMPsBVS0IXvX9Ni7yK3fu/lKAGauoLlCdpwWe5IfJMCbOUR+w==
X-Received: by 2002:a5d:5652:: with SMTP id j18mr4521872wrw.40.1587638812041;
        Thu, 23 Apr 2020 03:46:52 -0700 (PDT)
Received: from [192.168.43.23] ([37.167.216.250])
        by smtp.googlemail.com with ESMTPSA id 17sm3087293wmo.2.2020.04.23.03.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 03:46:51 -0700 (PDT)
Subject: Re: [PATCH v6 02/10] PM / EM: introduce em_dev_register_perf_domain
 function
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
 <20200410084210.24932-3-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4a1d8d5b-84f2-46b7-00ce-03178d7df72f@linaro.org>
Date:   Thu, 23 Apr 2020 12:46:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200410084210.24932-3-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/04/2020 10:42, Lukasz Luba wrote:
> Add now function in the Energy Model framework which is going to support
> new devices. This function will help in transition and make it smoother.
> For now it still checks if the cpumask is a valid pointer, which will be
> removed later when the new structures and infrastructure will be ready.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
