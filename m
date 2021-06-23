Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260123B129A
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 06:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFWESf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 00:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhFWESe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 00:18:34 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C177FC061574
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 21:16:16 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e33so670748pgm.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 21:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GM/KfkvNyYfCV4WlRZzF0c8FG8z4yOZdcLnqrydTOJA=;
        b=hUOg6lAq82C03eqNi/vyOwjZkWZuutjeTFb1It6ihSVgoGU/iaMzRBFoaX0iI3PsyE
         uoILsXU98tHexmBNrNY6kDyhEfKO44slJMO4ZU2Nr5f2eRrIuHdcFwAAOqmmfNJkLJcr
         /HE6YCN8zgAufwybqWCg4I2Pg+J166vId5x4a8J1lNKOCvM8gZcz+tJwWBajy+hms9M7
         +D5+ZiGNBlFV0dWcjb3xhqNwA9R4YRt82s5QW6RsZxhKwC6/BoRmMkcDMYTVQ3/F2Vyg
         CgwUXfMkUM3Q7WpH+jxmvVE5j2qpEAeKeqXjwE85NORwM8uhpkg0QItlPImu1sks6roF
         JWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GM/KfkvNyYfCV4WlRZzF0c8FG8z4yOZdcLnqrydTOJA=;
        b=WED7B6+r6uhHdejz2Aj9+X7Anotsz/0P5/GFo5hYBuP7+oK87iU3dQSg4CjZA9icVX
         MAqPnbjViozS47LWG8E4pxjXTKt7EtvNj0zZcYnz+UffGeZxGV01uuNNKbbJjm0dWI01
         pFHIxxqdzMlGLzBarcpZkVxlRcvXXZa5BAFktp2lieJcMgx4+rUBM8u0cx+Go2WwsDRW
         2sF05Rgjvv1gvyhfaumB8wzLLdtpJ/koAJt42jEWvN4PsHg0GxmV9kSO0g+L1sVXiXx6
         JYOGr44Jq/ozuG88LU75A/iYCbCvl/0kzP/pfxxiH7a1bkghtLqUkP1S/m8YYaPPvL0J
         ODVA==
X-Gm-Message-State: AOAM533AsqTnRwhuM/TKo6z9zjxonUbCf5fNEp3WFoXYQyROLo65+eM5
        1wMX4u6jS9XeZU+Q9R4KJyQw5w==
X-Google-Smtp-Source: ABdhPJylDHdym8LIvJOiroKGSEQ/OHsrjmNj1kb8o+oVjkE3RFAy6yQR+kFJv9FARzOtbYTUpgmljA==
X-Received: by 2002:a63:4b52:: with SMTP id k18mr1967901pgl.190.1624421775966;
        Tue, 22 Jun 2021 21:16:15 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id d127sm733385pfc.50.2021.06.22.21.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 21:16:15 -0700 (PDT)
Date:   Wed, 23 Jun 2021 09:46:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency
 invariance
Message-ID: <20210623041613.v2lo3nidpgw37abl@vireshk-i7>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <09a39f5c-b47b-a931-bf23-dc43229fb2dd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09a39f5c-b47b-a931-bf23-dc43229fb2dd@quicinc.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-06-21, 16:48, Qian Cai wrote:
> 
> 
> On 6/21/2021 5:19 AM, Viresh Kumar wrote:
> > CPPC cpufreq driver is used for ARM servers and this patch series tries to
> > provide counter-based frequency invariance support for them in the absence for
> > architecture specific counters (like AMUs).
> 
> Viresh, this series works fine on my quick tests so far.

Do you want me to add your Tested-by for the series ?

-- 
viresh
