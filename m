Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2640B5DE1F
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 08:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfGCGgf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 02:36:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44137 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfGCGgf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jul 2019 02:36:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id t7so642674plr.11
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2019 23:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2mLMfQ4nvAKGOVEbA2uhHQT7JEZMjE5/snh70yqtuzY=;
        b=Bvu8UZRFuBAAR4SgwLLN2JKKgPvnC9BWAueAeKYJVn6aGQZ8u7BOAgd81xdeRHUo+F
         htQmElWKQHk0jGUA3Op5+r1V7U/d76LuZgUJn7nl878FPvbt9mNc6yd/QoNDV+qkew3H
         H07uBJoEfdcf8T6XUoPC9wov/lnQdAZBS4tfJIWIcRN51KZPxWP4VfSRtDl97e1ObDVl
         fjOSWJCoyuunHJlK2EqLJcI/NrsIFSz/4zYGB3b4VAomuwA5WWRMOFZdaqN/Uv8iINlj
         T9H2Sm6u2lQMPIyFiIezClthfneLAvigb0HFApzTdDSqpvKb4nH8yhM1mgQ4dwxBJDwz
         I5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2mLMfQ4nvAKGOVEbA2uhHQT7JEZMjE5/snh70yqtuzY=;
        b=rHRJYDfNBpWwcYPy10TyZyZFxXKQ5MC+nG/ZbMk9UunikTqEUZKibAN+I23eZw+sqV
         X2qCf+g+NE4oqyQU8XzM5AA0ywJCIYzj+AEcMy5jX2XbJmkJs40iEXCbSOZ/XX96LHyq
         +oMaK6nKSM48C+P77hJ+3L0GmalVEaW1LAKBK0Rn1jIb/x1BJqH+u/2bj425YlsqoUlj
         J6+UAhW1RkHgJsqnnOFMH6tHQDA1qHBDcPMHkSU3dEdySNRr8tR+Zv1V1oJ3uxsdiHVp
         vIOWXtBQ8h5IT3I/aj3s95Mkam1okIfzZOCL1qK6xexn4p7Q+noID93PFdeni9gdwn+/
         XwLw==
X-Gm-Message-State: APjAAAUUIikUcteGKif/EEuXa06RfroT538qvFu8YkFW7J8/SXq6VJtQ
        mBKKNmQgwZk3mcqRKLcYiRDvQg==
X-Google-Smtp-Source: APXvYqwpA64nFtKGwqnu2eFe0F3WBDW99irwxsCQNcCbw7Vli1g91dpgBBCSJqTtLsaS2ZkP/a14NQ==
X-Received: by 2002:a17:902:7793:: with SMTP id o19mr40000598pll.110.1562135794873;
        Tue, 02 Jul 2019 23:36:34 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id 137sm2105787pfz.112.2019.07.02.23.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 23:36:34 -0700 (PDT)
Date:   Wed, 3 Jul 2019 12:06:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        sibis@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Introduce Bandwidth OPPs for interconnect paths
Message-ID: <20190703063632.hl2lipcoeehplyxq@vireshk-i7>
References: <20190703011020.151615-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703011020.151615-1-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-07-19, 18:10, Saravana Kannan wrote:
> Interconnects and interconnect paths quantify their performance levels in
> terms of bandwidth and not in terms of frequency. So similar to how we have
> frequency based OPP tables in DT and in the OPP framework, we need
> bandwidth OPP table support in the OPP framework and in DT. Since there can
> be more than one interconnect path used by a device, we also need a way to
> assign a bandwidth OPP table to an interconnect path.
> 
> This patch series:
> - Adds opp-peak-KBps and opp-avg-KBps properties to OPP DT bindings
> - Adds interconnect-opp-table property to interconnect DT bindings
> - Adds OPP helper functions for bandwidth OPP tables
> - Adds icc_get_opp_table() to get the OPP table for an interconnect path
> 
> So with the DT bindings added in this patch series, the DT for a GPU
> that does bandwidth voting from GPU to Cache and GPU to DDR would look
> something like this:

And what changed since V2 ?

-- 
viresh
