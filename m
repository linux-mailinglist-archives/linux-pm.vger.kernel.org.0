Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C191B723A
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 12:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgDXKn2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 06:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgDXKn1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 06:43:27 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D939C09B048
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 03:43:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v8so9682114wma.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 03:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dnKniRRBm6KLmX43VEEOIzRt6LvZaDlvdGMTuziUADI=;
        b=piLvENvWl4DmoeSXfPxu8cdGgMrHv2thfba7D+KeyKcqRq/kNFVVmKom7MLokxYEuw
         879epAZEr1e2PpWgseR+b75NAsekCVl6NCQoM153pJJCSpIeP+6b3oEHRZLWZiNP58hl
         P9DroLVXk/DWSoF5KHOurjOqNB4LOM7EUPV4Gi6X5heKiiaM55ttbsdUycg2GLZQcxul
         gF90xjqqxT8NIuixcLqed8aWxMKSXoOgeufFHqDlxj/esFD8joBr4w3NLmBGoxdujOlc
         OLzS4B4TB0qg1ReZnFkVVNfYELkuLqzE0zceluUvZmW1Yd7rSGF0/vctUFq9hZkFtRje
         8wZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dnKniRRBm6KLmX43VEEOIzRt6LvZaDlvdGMTuziUADI=;
        b=XDeLPpQMewVyfiqY/o4JKXyXdyHQdgBVLPjyJKjtM7KzXHlzbPpoZiV10FFkiFyUmC
         DbwYwDgm2S8ejv831NR/B+LkvgAnwd/3ucbzk9ZjdHLO039jUy++ynj8Mkqm8UWZGEQJ
         zZQxJsCLdyNXQEKXU2d/Ud7METCv/hqU8YqxqobcBk9RPxhrYk7aF0sss6c26smtojiy
         lIRxR9Xy+9nBgWs6WKORC4lN1m/o4ty0aSY3wCmhz/c6ofd7rc7vURzXSyxFmGgpj2ky
         xkBmXkdQdqhXL8oFLYgJCNOX+5VxjLWCZbgbBTT7aMDDD+CG89G2spC7rtq72O4sHmvX
         In/Q==
X-Gm-Message-State: AGi0PubG9Ei8N7GTH5qBwkUcB32xTdyt4pVrA0TEHgVYhhvwhWZ7j2N5
        xCAbelNzdAIKzUe51X8iMwiT1A==
X-Google-Smtp-Source: APiQypI2Afy4s5XfsjxxMEU/3JcXJfiG2GDyNW0Ogfm/BVtwSxQPPPiy1JiCL97MEDi+IXKQD3oz7Q==
X-Received: by 2002:a1c:5448:: with SMTP id p8mr9189810wmi.173.1587725005656;
        Fri, 24 Apr 2020 03:43:25 -0700 (PDT)
Received: from [192.168.43.23] ([37.166.159.243])
        by smtp.googlemail.com with ESMTPSA id t2sm2341981wmt.15.2020.04.24.03.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 03:43:24 -0700 (PDT)
Subject: Re: [PATCH v6 09/10] thermal: devfreq_cooling: Refactor code and
 switch to use Energy Model
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
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
 <20200410084210.24932-10-lukasz.luba@arm.com>
 <20200423175708.GG65632@linaro.org>
 <b93226ac-a1f1-c1d0-fc25-0bd0f336252a@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <73fb5d45-d8ac-534f-fd38-619739130160@linaro.org>
Date:   Fri, 24 Apr 2020 12:43:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b93226ac-a1f1-c1d0-fc25-0bd0f336252a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/04/2020 12:02, Lukasz Luba wrote:
> Hi Daniel,
> 
> On 4/23/20 6:57 PM, Daniel Lezcano wrote:
>> On Fri, Apr 10, 2020 at 09:42:09AM +0100, Lukasz Luba wrote:
>>> The overhauled Energy Model (EM) framework support also devfreq devices.
>>> The unified API interface of the EM can be used in the thermal
>>> subsystem to
>>> not duplicate code. The power table now is taken from EM structure and
>>> there is no need to maintain calculation for it locally. In case when
>>> the
>>> EM is not provided by the device a simple interface for cooling
>>> device is
>>> used.
>>>
>>> [lkp: Reported the build warning]
>>> Reported-by: kbuild test robot <lkp@intel.com>
>>> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org> # for
>>> tracing code
>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>
>> Is it possible to split this patch into smaller parts? It is hard to
>> understand
>> what is related to the em conversion and other changes which look not
>> related
>> so far.
>>
> 
> No problem, I will do the split (it will be in the v7).

Thanks Lukasz


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
