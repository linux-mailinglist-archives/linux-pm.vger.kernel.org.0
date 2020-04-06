Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E445019F2A0
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 11:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgDFJ3u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 05:29:50 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40326 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgDFJ3t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2020 05:29:49 -0400
Received: by mail-pj1-f66.google.com with SMTP id kx8so6195175pjb.5
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2020 02:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZCzHwl/tdcpxDCvekc0v2ATl1ivxbmKIM4V06jUFE4o=;
        b=lA2dD1pU3P/Ty4DeO3ShHycc7coGr4rgguYE94pdUYB0rQeBI4R+O+XPILIDswxwUZ
         8/0N/Nf87j7tRNEWERwPiO+a8fKnsi9Y6Ftu3dVR3xICxGhLDWb+KGsFDsQaBOcgI3tr
         jSqz9jjdv+rGEp7nNDmxgLrZQKooGMiHIMJTMjPW9qY6OwddYlWPTFKeb8bg7qZU3AwG
         qBX3zWIimob9XlsraxiQ+pWhNKsyugcy2Q068sezTmHZQY54B4p2jq0lnirIIi91YGmo
         NGF9j8S2DD7riX6aAyxCPnvM0QyW2GEyt48nwV9aXfhYqowCQbI+nfwwy4PbTMDIoY32
         YE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZCzHwl/tdcpxDCvekc0v2ATl1ivxbmKIM4V06jUFE4o=;
        b=sfhQ/izZB9u5Bu8ftn+xyWrstyvKKKNIO97h3CfV7cjq700T3018Cuqj+OQgp8IxNr
         XBe+t5fU0JUYkG8e30cuqeWaoh2BIJbTW2cuDTWzF37exOqpz3Trndz8qgL9HDSAU3ci
         GZmquyRmv+oBg76C7qlMAnmaLEQLv5fc0v32wte7yVk5W2Xi8ltM1IZehN2jKLWjCukX
         Af4nTztZm/3mhByDKhDoO4mq3u53ml7bl6pV99B24fDnRlUBOG/ncX3cfKZtBfN/2b8u
         HIlGdHYUC+pqwKuN7zuVLymK+fNuyIjW2ZDoCt/pIP9l+3H/pcnixvPGVsSQ+0TSRREy
         W+Vw==
X-Gm-Message-State: AGi0PuZiWtJIpXlZKIjhkJ1RWmI9R2TL8jLTlwH9UCvxwK/X5V/Lx7kS
        Y7EvJDWI43RlcVZlQIL6IQ3d1g==
X-Google-Smtp-Source: APiQypJ1tW013VPp2UhXvt/1Bxz5iwbypmAuTEFj+PUd/NiBUPS+9Nx3CgJdVnertByvQXbdXVoStw==
X-Received: by 2002:a17:902:b593:: with SMTP id a19mr19581254pls.92.1586165388661;
        Mon, 06 Apr 2020 02:29:48 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id c128sm11053782pfa.11.2020.04.06.02.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 02:29:47 -0700 (PDT)
Date:   Mon, 6 Apr 2020 14:59:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "andrew-sh.cheng" <andrew-sh.cheng@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fan Chen =?utf-8?B?KOmZs+WHoSk=?= <fan.chen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [v5, PATCH 4/5] cpufreq: mediatek: add opp notification for SVS
 support
Message-ID: <20200406092945.d5thcd2h3bo7mn45@vireshk-i7>
References: <1574769046-28449-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1574769046-28449-5-git-send-email-andrew-sh.cheng@mediatek.com>
 <20191127083619.etocnhpyyut3hzwq@vireshk-i7>
 <1575874588.13494.4.camel@mtksdaap41>
 <20191210064319.f4ksrxozp3gv4xry@vireshk-i7>
 <1583827865.4840.1.camel@mtksdaap41>
 <20200311060616.62nh7sfwtjwvrjfr@vireshk-i7>
 <1584084154.7753.3.camel@mtksdaap41>
 <20200313091038.q7q7exiowoah4nk4@vireshk-i7>
 <1586164366.5015.6.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586164366.5015.6.camel@mtksdaap41>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-04-20, 17:12, andrew-sh.cheng wrote:
> I will use regulator in the locked region.
> And regulator will use mutex_lock.

Yeah, you can't use spinlock here, use a mutex.

-- 
viresh
