Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48D0AE20AB
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 18:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404819AbfJWQet (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 12:34:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35418 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403862AbfJWQet (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 12:34:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so13271039pfw.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2019 09:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=paPdYBXe5hK/GYcbyHZ3o8VhlBG4zpUjueSHGzqxOcw=;
        b=hL7oV31HeaaokV5onhoHXnelV7EXkShP1PTMImFwFcCmZRzw3QzjCJI3sKb2cN1HeW
         t+saI0fIKR/GzRtB/SWqlyyEcPYEe4zUTl2Z0yKY6UUVmMfAkrvCBGu/54VbqXl/njgS
         kyKWidz6I9gjuQz3OwMDOH9tUt0pLCHdkUdVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=paPdYBXe5hK/GYcbyHZ3o8VhlBG4zpUjueSHGzqxOcw=;
        b=VDDdJ0sWUeYUkZ6uzS064x5HIzfdsWDl2NHpY49DpyXZUO7+GJlGKQ5AGlM+yloUyO
         aY/ZQgOOHd/gPXfAMOGRQsLM5ySWXJi9uSDgU5880R+sqxEiO2DBC8yJ9k7hT6ZUkWr7
         0a7pUlW+YByhVIQKXExfPWFiZmoAXSZo2cWdtlaKU+YQnMBV4rqC20iVAjp+EZLSQ3vC
         Fn837N+OcX1IvEXy+jdHzX4W+xW2pJvJVvNr3lAj8+rDhnBdIpbY4pTLRX38X8ZIVI75
         zlmgUPEII4LeEmdZ5A7NaqLA9MqNXhk39hKl1z7fEilG1WWHeieDt+GbI/fynz6Yjgry
         AUZw==
X-Gm-Message-State: APjAAAXe6AeLWnZJ60XQZ56oZXyMy0VvfDZZ21NM//PpJJGjNa08Qpp8
        DP/Iepj5Yw+ZueeAnaPNUgta0g==
X-Google-Smtp-Source: APXvYqwZIgz3OSWqkjl9lNVx6+2HhR+fhss+RDALlGtSQClpt7KyQtClkAnIiRy0al2MmdwbKZ1kXA==
X-Received: by 2002:a63:7c03:: with SMTP id x3mr11274903pgc.382.1571848487957;
        Wed, 23 Oct 2019 09:34:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id c62sm24239590pfa.92.2019.10.23.09.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 09:34:45 -0700 (PDT)
Date:   Wed, 23 Oct 2019 09:34:43 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 0/8] PM / devfreq: Add dev_pm_qos support
Message-ID: <20191023163443.GL20212@google.com>
References: <cover.1570044052.git.leonard.crestez@nxp.com>
 <AM7PR04MB70154D3BA0D6402A9C9BE6A0EE6B0@AM7PR04MB7015.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM7PR04MB70154D3BA0D6402A9C9BE6A0EE6B0@AM7PR04MB7015.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 23, 2019 at 02:06:40PM +0000, Leonard Crestez wrote:
> On 2019-10-02 10:25 PM, Leonard Crestez wrote:
> > Add dev_pm_qos notifiers to devfreq core in order to support frequency
> > limits via dev_pm_qos_add_request.
> > 
> > Unlike the rest of devfreq the dev_pm_qos frequency is measured in Khz,
> > this is consistent with current dev_pm_qos usage for cpufreq and
> > allows frequencies above 2Ghz (pm_qos expresses limits as s32).
> > 
> > Like with cpufreq the handling of min_freq/max_freq is moved to the
> > dev_pm_qos mechanism. Constraints from userspace are no longer clamped on
> > store, instead all values can be written and we only check against OPPs in a
> > new devfreq_get_freq_range function. This is consistent with the design of
> > dev_pm_qos.
> > 
> > Notifiers from pm_qos are executed under a single global dev_pm_qos_mtx and
> > need to take devfreq->lock. Notifier registration takes the same dev_pm_qos_mtx
> > so in order to prevent lockdep warnings it must be done outside devfreq->lock.
> > Current devfreq_add_device does all initialization under devfreq->lock and that
> > needs to be relaxed.
> > 
> > Some of first patches in the series are bugfixes and cleanups, they could be
> > applied separately.
> 
> Hello,
> 
> This series was posted a few ago and all patches have been 
> reviewed/tested-by multiple people. Possible minor hangups:
> 
> 1) Matthias found it confusing that min/max_freq in sysfs changes 
> on-the-fly. This is not a behavior change and I believe a decent 
> workaround would be to implement separate user_min/max_freq files from 
> which userspace will always read back the contraints it has written.

As you said, it isn't a behavioral change, so it shouldn't be an issue
for this series.

Regarding the workaround I think it would be clearer to have new
xyx_min/max_freq files for the aggregate values. min/max_freq are the
interface userspace uses to specify the limits, it would be strange to
use different files to read them out.

In any case the aggregate values seem to be of little practical value,
except perhaps for monitoring, since they could be stale right after
userspace read them out. We could start with not providing them, and add
them if it turns out that they are actually needed.

> 2) There was an objection to removing devm from two allocs in PATCH 4. I 
> believe current solution is acceptable but a possible alternative would 
> be to split device_register into device_initialize and device_add: this 
> should allow devm sooner.
> Link: https://patchwork.kernel.org/patch/11158385/#22902151
> 
> Let me know if you think I should implement the options above and resend.
> 
> The bigger problem is that DEV_PM_QOS_MIN/MAX_FREQUENCY was removed from 
> pm core because only user (cpufreq) was refactored to use a new 
> interface on top of cpufreq_policy. Links to discussion:
>      https://patchwork.kernel.org/cover/11193021/
>  
> https://lore.kernel.org/linux-pm/VI1PR04MB7023DF47D046AEADB4E051EBEE680@VI1PR04MB7023.eurprd04.prod.outlook.com/T/#u
> 
> I believe there is still significant value in supporting min/max 
> frequency requests on a per-target-device basis. This makes much more 
> sense for devfreq that for cpufreq because the whole point of devfreq is 
> scaling arbitrary independent devices.

Agreed.

It seems Rafael would be ok with reverting the patch that removes
DEV_PM_QOS_MIN/MAX_FREQUENCY, IIUC he just doesn't want to keep it around
at this time because with the rest of his series there remain no in-tree
users.
