Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BB725F80D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Sep 2020 12:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgIGK0C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Sep 2020 06:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbgIGK0A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2020 06:26:00 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BD9C061573
        for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2020 03:26:00 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m8so2547566pgi.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2020 03:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oSDBtC5AJCfIOMajLqA8j1SX26YNoE5DFwKupiwQ2NI=;
        b=gnkJu0UcBjhgouUkegI3C32hZTFy1qSXPPXOg7qF/cZYnsXOKDFGWdXVNsuDqQnAIW
         Zun4aUVK/qN/RC6xcVu0q4qg+Dg28n/5UAE4L8JewkG4yi1zH1q1UoWTG5q5dkh6jo1a
         +ISBNIAwT9QwMjHKz4f9cJa2ezCfpCMrhMmFHDn6rSr45OUFpe2hxVdcUlLPI0ED6/E4
         a+eCJZXL/bsn8Elv1VAtE4vY4tNPvdXA70r5GLN/j2FN6PBPYTfBV+OIeyHthlU45eu2
         ofmJSp/aDYVQx54K74W83M1PARxUJolksXiaKJHKI/Gj4mNIU9kLFcWe4QyRtgnmViOu
         VgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oSDBtC5AJCfIOMajLqA8j1SX26YNoE5DFwKupiwQ2NI=;
        b=FN8TWYGtsrlOAgUNIy8bmBLUfaELWtnKvrv3wXq8SkASuzPe7U20LbnNvWOibn9Y/Q
         s20X5CoyR+bFt8NCIttRrinDPHb4IFd2QCvNlFuJ3Rg9oaMvA2GuVMmmmsCS1udsu9P/
         fIfzOKa5l0h81dqd+mqxvYv+S0WJllHor3LD0aV5616cntdKfKywIA8M0aPcCRjP0sLU
         0xqmolGR0KNfK/jTtf33WleO94SJqRjl3cfNKyeEHxP+ACp9cgYZkHrm3BvSZW7m8LXP
         0WUHLZESly5ilX5bVnQlI8ge1NdA6dl/LHMBmWaSK3Xb0giZSNqUHisxpmWfQmhM5TME
         3eqw==
X-Gm-Message-State: AOAM5332gfDO9mzkGd08aAIJTHGQbQ5oVcYZ8G1axgpMZ5I4lexwadsY
        RzndXtL6lzJgasYeR/1veQ0rtA==
X-Google-Smtp-Source: ABdhPJxHQ/nrbmLTBJWGaFKaptxZ0KxHHZ3OMmGwTfyrCmgVoG2obssalbLYCtejCEH510sDIrsJgA==
X-Received: by 2002:a63:d216:: with SMTP id a22mr6640147pgg.339.1599474359206;
        Mon, 07 Sep 2020 03:25:59 -0700 (PDT)
Received: from localhost ([122.181.47.55])
        by smtp.gmail.com with ESMTPSA id g192sm7189734pfb.168.2020.09.07.03.25.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2020 03:25:58 -0700 (PDT)
Date:   Mon, 7 Sep 2020 15:55:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] cpufreq: arm_scmi: Constify scmi_perf_ops pointers
Message-ID: <20200907102551.3f7zwrmd3uqthaxs@vireshk-i7>
References: <20200906230452.33410-1-rikard.falkeborn@gmail.com>
 <20200906230452.33410-2-rikard.falkeborn@gmail.com>
 <20200907102200.GB17330@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907102200.GB17330@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-09-20, 11:22, Sudeep Holla wrote:
> Hi Viresh,
> 
> On Mon, Sep 07, 2020 at 01:04:50AM +0200, Rikard Falkeborn wrote:
> > The perf_ops are not modified through this pointer. Make them const to
> > indicate that. This is in preparation to make the scmi-ops pointers in
> > scmi_handle const.
> >
> 
> Your ack needed to take this as series via {arm-,}soc

Can I just pick the first patch and you do the rest ? Will it result
in any warnings at either end ?

-- 
viresh
