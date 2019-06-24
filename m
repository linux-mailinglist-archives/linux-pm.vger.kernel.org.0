Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B16950D10
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 15:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfFXN7j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 09:59:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43064 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfFXN7f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 09:59:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so7166324pgv.10
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2019 06:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8p0LSzziaw2XBSl9zJQVojlQHPmOP2r2WIfsm6JGgz8=;
        b=ZYCVh/Bdl9VvD1gu+oUjObwInKu3Lh+Xi5XgI6EB1XPlcp8t8hfCu7V7g6lBJ705sq
         Y2G9Oij3xOE/mTBTXwvKgNBAWuI11PYgXKMapP/3M/7dJGAvfdLf4wH2hRzoI/lnSn59
         cYwptf58L3diOBgvzRW3PwR4mLDt2wWNp/ckb1XLXLvn78G8R7JwzxIQnwBot24sq0c1
         0hkb4HIvcrK39BV821QOD4OJdOJ12BTihvzqNxSInP8Xu7jgTLeRCEXGVCJsEWeHALIA
         VFDASOBjXh67x4U55mSJBYx/8obWgbgrKNDy+2tNDaMMxKGqgaZT44CFGiF/zG9dOO2g
         myZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8p0LSzziaw2XBSl9zJQVojlQHPmOP2r2WIfsm6JGgz8=;
        b=dK8TpqGR13BHj1zO6CXTaFdbxeMwB2goctgMxeKxDyEiggOpgUyr3+P9RSxSc0n67j
         +oa/FCKNR2popeerZHadVomsxI8v4Dd8iBtbLvzOXvyB1yNlTvbmG/O9AKWzY1c8pfOF
         QWLoq33B4KsZZwXbGswc6Wnn2f5SNp5ysUc26zjTP3nAS4SppAw1Gix5BaZinFC5A1MI
         E2fWR3zUyNxppcGwYi1fYvhmTI3Pdf3Y9E8YnG4gIX6vCD0qyH95Pfvg+LfzRFvBreHx
         RAKVDw1aIZxLaWITIX+bkW84BFn2L1BbHPnT6PxnV+98keaEGelvXMEkeq8Oc2UPDqVY
         8aBQ==
X-Gm-Message-State: APjAAAV3PjjMbGDQLS0NiriDTsnKvBwgZZZo0CKDd0ktOGG3RywHnmMX
        EPpKFx5ii7peEq1VO21T/HIT1A==
X-Google-Smtp-Source: APXvYqyvI6daCcYpiddemR6d+Ismu3G0GD/CDepLUwf/xIv5yLxqYK75h5H6EehqtgmVJJxCwejZ2w==
X-Received: by 2002:a17:90a:730b:: with SMTP id m11mr24880498pjk.89.1561384774525;
        Mon, 24 Jun 2019 06:59:34 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id c18sm12646192pfc.180.2019.06.24.06.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:59:32 -0700 (PDT)
Date:   Mon, 24 Jun 2019 19:29:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, edubezval@gmail.com,
        linux-kernel@vger.kernel.org,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] cpufreq: Move the IS_ENABLED(CPU_THERMAL) macro
 in a stub
Message-ID: <20190624135930.vebfuh4ntn32nbrk@vireshk-i7>
References: <20190624131715.1857-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624131715.1857-1-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-06-19, 15:17, Daniel Lezcano wrote:
> The cpufreq_online and the cpufreq_offline [un]register the driver as
> a cooling device. This is done if the driver is flagged as a cooling
> device in addition with a IS_ENABLED macro to compile out the branching
> code.
> 
> Group this test in a stub function added in the cpufreq header instead
> of having the IS_ENABLED in the code path.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 6 ++----
>  include/linux/cpufreq.h   | 5 +++++
>  2 files changed, 7 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
