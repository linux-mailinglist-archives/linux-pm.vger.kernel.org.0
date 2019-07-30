Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50CC479EE3
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 04:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbfG3Cqo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 22:46:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41245 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731465AbfG3Cqo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 22:46:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so28155452pls.8
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2019 19:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TIMkP6Sbv3HhH7Pg62xgc50SN2hQat3s6fyOGmFVet4=;
        b=L8GR5DfMRyep5ArrsWvl2jbLj0dmva+GRlpTMBEy28z/3U4kCIKeBfzq/cFSiBzTUq
         WhFNVymIRwcWDQ1d+MP+L6pG65a1cGoWsZQPFjvo6ct+L43Bji6mvXlBS1bQneYXg7cx
         fy+1Mt8/3wqfOeX7J2TAKnyQ35VlrhKD8JpFAba6lteniuBVkgF4ubCMEGl0DZ/8hxjE
         AcnOxEssWV3etZKwaV/WP3qCQ2uzrfUxPFssPd4SdLqohFGIpSgD7oSRd5+RzJ7P/oUp
         9eGmRtDwiQDJsUdu9E6hAg0U25uQ22eAq+YqsUekO+88XtqsfJH7eqal1w1uOJS6LDPz
         A67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TIMkP6Sbv3HhH7Pg62xgc50SN2hQat3s6fyOGmFVet4=;
        b=AlvMJ67crAlCHuo0Pw5M9IJnh+iH93fr/hi2SlhlJSXngKILlJxxR/VFu1y8Lz7rGW
         ATWeMvEQnwDkXCTU/eX+VS1cttMXPSzmM6ds1qq+0jnGtohwY2neata5Fy/c97F8FOOv
         xzCaj1q2AxJvj98b8OgJg1bu3IS98/C0sBdYkggfn3QgBPyRsOo+oAK0t7EYB1KLeXjM
         ES7iHXvHn3Bdc/DJcov+2pvHCvCD18jJdIV6raKcL3XBf4ORP4yQ2407YZyW67kQr6f3
         aTBMxNp/RDrSwyfkiMuoDvT2TUMTfZ3CaeMqZ8X372BIccfjCK5TvqeEuwwcxp+OCbJg
         i2Yg==
X-Gm-Message-State: APjAAAWz1mIzLkv3B0VypfRkaLcGL0tvth35F8glUowwRF+vQ8rdSHtq
        2pLFiUGDAvL8Zhydq16niDr1sQ==
X-Google-Smtp-Source: APXvYqzeA9LVcJv5kbvk0OnqoT6oBgmnCofJDcZtwfBTMsDgwL3UumIql4DmQbc9jwe2WS2gmfH5ow==
X-Received: by 2002:a17:902:aa41:: with SMTP id c1mr112285898plr.201.1564454803345;
        Mon, 29 Jul 2019 19:46:43 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id x14sm79932677pfq.158.2019.07.29.19.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 19:46:42 -0700 (PDT)
Date:   Tue, 30 Jul 2019 08:16:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] Introduce Bandwidth OPPs for interconnects
Message-ID: <20190730024640.xk27jgdfl2j6ucx7@vireshk-i7>
References: <20190726231558.175130-1-saravanak@google.com>
 <20190729093545.kvnqxjkyx4nogddk@vireshk-i7>
 <CAGETcx8OBFGgP1-hj717Sk-_N95-kacVsz0yb288n3pej12n1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8OBFGgP1-hj717Sk-_N95-kacVsz0yb288n3pej12n1Q@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-07-19, 13:16, Saravana Kannan wrote:
> Sibi might be working on doing that for the SDM845 CPUfreq driver.
> Georgi could also change his GPU driver use case to use this BW OPP
> table and required-opps.
> 
> The problem is that people don't want to start using this until we
> decide on the DT representation. So it's like a chicken and egg
> situation.

Yeah, I agree to that.

@Georgi and @Sibi: This is your chance to speak up about the proposal
from Saravana and if you find anything wrong with them. And specially
that it is mostly about interconnects here, I would like to have an
explicit Ack from Georgi on this.

And if you guys are all okay about this then please at least commit
that you will convert your stuff based on this in coming days.

-- 
viresh
