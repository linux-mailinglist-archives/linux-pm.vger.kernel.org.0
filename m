Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9D995ADC
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 11:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfHTJWJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 05:22:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42012 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbfHTJWJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 05:22:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id i30so3013785pfk.9
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2019 02:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iPlBVrnBoNUI/lNJes9Rh6gz9e773+63kiUFo85IYu4=;
        b=ngk5FiUxYbq7boC8HuKsYngYF5ac2i48K4t2XZy2ohxfMaDROoBdvhQKsjlUXz/FNU
         9Gdc2UrbJ7TaxPjjp9RemvUTlKbDR+yMnZ9iqAWD9z6hm7dACYA1wWaqjQcgx189AiKJ
         lm+J71TY4BTIjJdQ6cIyqK/GQdZcorcCL2E2C8A88UVzUsqtvQ5f9ZtjvwWfl7qpYW8d
         9Bligpy+WLy7zEoM0Dt2hILaZJsRrIiVIekMBQk6NlzfpNb2n+Zv8ETqVo2Tce8pZ2Uw
         2FK5e1GYGGL3MTWas+Se+mEDtAzlcRZ3Eb71cxNKsPfh2O9V2wYds2b3A1a79XKSI6Mq
         D11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iPlBVrnBoNUI/lNJes9Rh6gz9e773+63kiUFo85IYu4=;
        b=iP5AdWOp/4Q5JQosmkLbBv6Sp+9w65mzbIZDw/7h0wwCdtyCz7SE6vfrlTDDNIa2UY
         B/L042LIKkOWIckDFimr/iFvYNmOPWpMyHKcx1dWmTvM0ZOY5wAhrfdGV/xvvaRCDAYe
         gmDGaCKvn8/vI9oj36ltoxXSAUNlzuH/Ba5MRaF29typrnrJuMkyMWm0u8n6gogrXJbe
         rEI4xWoNgAp1fwAQk5Fm53iJxhH3ASqWEgGCfcw49S1rtrmgb8XKHSr2FMsYaJM1JLDq
         LGWRzYZHiIvRJdVIc4PMvDAo+Nsyiao6HoYvWw7xeCsyav5LsT0XdQC4aA6z8fxyrKDW
         BUOg==
X-Gm-Message-State: APjAAAWsus5mSpe4DRz0MGfqWxtiWeNTgVAneSwfT8OgLtf8FHI80zYI
        7+PuW5vw+orXDNq37+iGBqr2ZA==
X-Google-Smtp-Source: APXvYqxdu8VNeaIG50VDKWEIqve5lhxTr8bT8d7reGV3dsk8iAVwEx/xrsNDR54YHosby3ZsIcyegQ==
X-Received: by 2002:a63:31cc:: with SMTP id x195mr23552845pgx.147.1566292929042;
        Tue, 20 Aug 2019 02:22:09 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id p1sm19215650pfn.83.2019.08.20.02.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 02:22:08 -0700 (PDT)
Date:   Tue, 20 Aug 2019 14:52:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [RFC 0/4] opp: Parse required-opp as dev_pm_qos_request
Message-ID: <20190820092206.7cv3hfvitil2oyg3@vireshk-i7>
References: <cover.1565089196.git.leonard.crestez@nxp.com>
 <20190820065202.fet4ctxk4jku7ul2@vireshk-i7>
 <VI1PR04MB70237DE1719FB78C0427A436EEAB0@VI1PR04MB7023.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB70237DE1719FB78C0427A436EEAB0@VI1PR04MB7023.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-08-19, 09:02, Leonard Crestez wrote:
> On 20.08.2019 09:52, Viresh Kumar wrote:
> > On 06-08-19, 14:12, Leonard Crestez wrote:
> >> The "required-opps" property can be placed on any device and point to
> >> any OPP table according to bindings doc but this is not fully
> >> implemented. In practice it can only point from the opp table of a
> >> device to the opp table of a power domain.
> >>
> >> As part of my investingating QOS mechanisms I implemented support for
> >> parsing "required-opps" into a DEV_PM_QOS_MIN_FREQUENCY
> >> dev_pm_qos_request. Since OPPs can be shared between devices this only
> >> works when OPP tables are unshared.
> >>
> >> This would need to be called from a device probe function and any
> >> suspend/resume handling (which likely means disabling the QOS requests)
> >> would also be handled manually by each driver.
> >>
> >> This is RFC mostly because I plan to use the "interconnect" framework
> >> for device requests instead. In theory this could be used if you don't
> >> care about implementing smart aggregation and just want to "set bus freq
> >> to high".
> >>
> >> Devfreq support for dev_pm_qos is here: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fpatch%2F11078475%2F&amp;data=02%7C01%7Cleonard.crestez%40nxp.com%7C09dabcdb17434862317508d7253aeac8%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637018807295295723&amp;sdata=vXvTIowhuqDkTxVZMHq%2BQxrKuqYv7n%2FU01ZDA7fdB0c%3D&amp;reserved=0
> > 
> > Some work is going on in related field. Please have a look at this as well.
> 
> I noticed that series but other than touching "required-opp" there is 
> little in common. It seems to be mostly an expansion of the passive 
> governor.
> 
> My series doesn't even depend on devfreq; in theory you could even use 
> required-opp = <&opp_1200mhz> on a cpu device.

What is the exact use case you are targeting here or the problem you are trying
to solve ?

-- 
viresh
