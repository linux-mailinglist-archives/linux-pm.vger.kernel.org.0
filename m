Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72704402287
	for <lists+linux-pm@lfdr.de>; Tue,  7 Sep 2021 05:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbhIGDls (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 23:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhIGDlr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 23:41:47 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C77BC061575
        for <linux-pm@vger.kernel.org>; Mon,  6 Sep 2021 20:40:42 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 8so8551452pga.7
        for <linux-pm@vger.kernel.org>; Mon, 06 Sep 2021 20:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FLF8sSQwhUS0+086sW1fmjexR33ZrApxSNSkWts8YRM=;
        b=nzh+u2Y81255wZnH+V4MUL8B8sO+5Od0TvnyoGtBXBxvY3GWkCS05hqcZ1FiPp66Y+
         H/aLuFSamvMQxn4nX3sCYvr1vDDohLl/5eNT3FtPx/KARSpyx2ftPvZz45NpEUAFAaN3
         nuqAcYDkZ/HcRrm6WqcyMuKl29Fr4l0lLirCtuq68ivwpbzUOj+5jaU/S74iEUJoxRqV
         Z/OLrLKs0O9bgfqMMgAsFQe8eBvb5Apzznl+Q3EF6QquxxEgfL1NhqCeEOD/tzrOfVQc
         j9FiRz3DOiSqILowuXrF1KILiP0Y/bHQvTid/J3SQIpAupZty6vyz4/uTkMkih+VObuO
         /YRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FLF8sSQwhUS0+086sW1fmjexR33ZrApxSNSkWts8YRM=;
        b=QK9yOmyXx8zxUZSANDdbKMCke53gf9yRFM5DD/w8nCy2NWhCRWu87X1mP+wd0GbQ5w
         GGSMLi66qO1oPEKJcjyAJc7m8vP/0GQtU6UmjRtez1cls3257yJA/0FOdda4capXUlGG
         J5mhyEWYbz0iIdh5yipzUeCf1hJEcwWHehTtvV6kedqKjLOHaAFAMEOyo1lRp1cjqWC9
         TYPPNt93AbiYB+i8txSGoJ35cXn2woCvOZeZLS4QxMxZm9yFMMgZiSAmtfDdBL6WVSiy
         +Qhpher57FjsK//xerWnOHZvbHjsLJIESZIT+osPEINzPCMdi63mBXE4SEK9k6iPlCX0
         sJ0A==
X-Gm-Message-State: AOAM5305+KKiZHKH8+FdCa6Uz1tHGUM9uKVw2JAKPkIsc6rhs5PlpVrK
        yb5PTj2667CEJUSY1EA3MhcQhw==
X-Google-Smtp-Source: ABdhPJzsv/eia/hjQn1pbmQ2OENxmUodBBxcmYX5Fn6l3uMclKCItBuOiSE4NrFHNe0VdaUoPx8Y0A==
X-Received: by 2002:a63:3c4d:: with SMTP id i13mr15152019pgn.54.1630986041664;
        Mon, 06 Sep 2021 20:40:41 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id b16sm8897166pfr.138.2021.09.06.20.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 20:40:40 -0700 (PDT)
Date:   Tue, 7 Sep 2021 09:10:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] PM: domains: Add a ->dev_get_performance_state()
 callback to genpd
Message-ID: <20210907034038.ncx5nas6mhrk4u3r@vireshk-i7>
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-4-ulf.hansson@linaro.org>
 <4e36e732-6ca3-1d00-e6dd-38bb8877577b@gmail.com>
 <CAPDyKFr2oQnKOhKhWt_9VyBoe=HQ7Y0uZUMKTcZ05a7G9RaBYA@mail.gmail.com>
 <1124dae5-478f-f0ca-ea91-b6945f7c9254@gmail.com>
 <CAPDyKFqE+thX0pLTg9d-ds7Tj3hsB78EmDB1Cryh26tN3kvQDA@mail.gmail.com>
 <3d92711f-ce30-2c19-c6a4-bb77d32df2dd@gmail.com>
 <CAPDyKFpJU3g2OzJeR9KUdtN-8wJsDckqVAMQMHBV=enu=DfURg@mail.gmail.com>
 <fbca049a-e673-1598-658f-a7bb5de52f18@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbca049a-e673-1598-658f-a7bb5de52f18@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-09-21, 17:35, Dmitry Osipenko wrote:
> Viresh, are you okay with going back to the variant with the
> dev_pm_opp_sync() helper?

I have missed a lot of stuff in between and wasn't following this
carefully as I thought my half was resolved :)

Can you describe what to propose to do again ? From what I remember,
doing this one time from probe() is okay, doing it from
suspend/resume, not so much.

-- 
viresh
