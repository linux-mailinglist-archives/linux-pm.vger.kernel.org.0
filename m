Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82A5CB6024
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2019 11:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfIRJ3a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 05:29:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34995 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfIRJ33 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2019 05:29:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so4012069pfw.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2019 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XGfSZf6zpqugWLz9E/ECTaAWk5AflbcZNfQrHqcfJiI=;
        b=tMIKcF3VViDMpKj4XKmRBULjrjqaQ3bDWghhbjeJPdxAI1tGEJH+Dd1yUsdxorGzCU
         vX1pls9dszPLX9gZQtzLNbplTyPa9bkOieccxfMinLHCoQwgzD71ejncb9sDa3oZ/cOg
         yS2/hctP+HmUBJZvrUFp0MWC7o6Kb8PwlsW55EiUB++a0T4VExjmE6VRDWTlFa+L0pz0
         OHYUXbMiWJMAUC8zKjTMZIpRA7rkoKzf1jKCf3K9VIb+sqK9BzQses2ZbQatt0gUt2Zh
         rDGwvgQiyId1Lzm0DtBjV3JiXPSpb2Ymjn903sOwMOiOwPL3pp4hgwNNuSqtyazFLr9q
         pS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XGfSZf6zpqugWLz9E/ECTaAWk5AflbcZNfQrHqcfJiI=;
        b=d29QXnLM22YTHEPHELUrqrOvRac9ZuZ2ywc2p7g6493PbCzzP/5wesPATudp2QRbgx
         2CP+/orzKWSBU5TgDl1ho/g+ZQE477gLhPl2Dv26hH+TYAjQqaR5MEP8e4MSLQsfqqO/
         c2NbWtBhi1p4vR6LRNQq8HV1hiUgNzYuIcuTEE+ZmVZohFMQhL9DHZc9vjgdU3NEKjaa
         DVvm91pcvpVNna9aI+xHfE4yZ+4TeK9/nBGum8N9QTkyk8V39k79HACfIPgwIMuBim0B
         DOp9UbCsUZ44avum/raUASQnR4bY9a+BcZ+S1SgGTTBuehP/rox9YW/WYnQtEZqe5vtR
         0h2A==
X-Gm-Message-State: APjAAAVKIVfnf8/ScRXo0au9YxsReJFoldYR2CIBjWFWsf2jXVsN9xcq
        NpmfRW/1TzX9xNTknJMbF267wg==
X-Google-Smtp-Source: APXvYqyYA7P3uo4EMeZ0CyHqcdj3f3idzeWXRKKFvYXjT1q3TSTfQLukJan+2vTt2Z1VXThtAF4SmQ==
X-Received: by 2002:aa7:955d:: with SMTP id w29mr3107878pfq.60.1568798967721;
        Wed, 18 Sep 2019 02:29:27 -0700 (PDT)
Received: from localhost ([122.172.73.172])
        by smtp.gmail.com with ESMTPSA id c11sm10674911pfj.114.2019.09.18.02.29.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Sep 2019 02:29:26 -0700 (PDT)
Date:   Wed, 18 Sep 2019 14:59:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        tdas@codeaurora.org, swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/5] cpufreq: qcom-hw: Move driver initialisation earlier
Message-ID: <20190918092925.5hrvbcdorm2qw2j4@vireshk-mac-ubuntu>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
 <b731b713d8738239c26361ece7f5cadea035b353.1568240476.git.amit.kucheria@linaro.org>
 <20190917093412.GA24757@bogus>
 <20190918090938.b2fj5uk3h6t56t2p@vireshk-mac-ubuntu>
 <20190918091747.GA18121@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918091747.GA18121@bogus>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-09-19, 10:17, Sudeep Holla wrote:
> Ah no, I am not referring to building as module. As you mention, that may
> work just fine. I was referring to timing dependency during boot. The idea
> is minimize the number of such initcall dependency. They should all work
> fine even as modules and should have least dependency on initcall sequence.

Yeah, so things work fine for them right now but that can be improved by
changing the sequence of boot here. And that's what Amit is trying to do here.

Even if android builds this as a module later, things will continue to work but
that may not be the best performance/boot-time wise.

When I had a discussion about this with Amit earlier, I asked him to send
patches even if he doesn't have any performance numbers for it as this is a
platform driver and I find it okay for them to decide the boot sequence that
they think is the best :)

-- 
viresh
