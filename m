Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E8C1E36BE
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 05:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgE0Dx6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 23:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387487AbgE0Dxz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 23:53:55 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071A2C03E97C
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2020 20:53:54 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t8so870891pju.3
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2020 20:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IYMd1AnUAPkMGM+mZJ4SXD6TMuAQaYu5keXEtUSwigU=;
        b=OYBybCvA4Wk60gJ0QRkPpb+8kKDOtMgLg5Msuhx1IAMH/EuJPHEk2+5QswUX2XkbTA
         uIpNhFkyGJYuBSY+mdFa7w4sPg95usp/ddDeC/CnTYEaGXfwJxVvbNMfWmKCxsKQ9vBc
         1hA0YB7FkWB+E9fKuxbpHcnilnJ9Nxu4RF9fiINeKd35PwKPeOG0Z3+ZB+ytOaSX5MfI
         88jDa/DMvYvA+X8ibB8/Szk5bJCCRBs0vqECD6/c9BaQfXmZdUkGbXVBWtcX0vmKaZrX
         8vPO+yp3unIffWr4l0TtD82PTyoZO+HZSA0bCgLxchBRcspuibBMv1bpSgjor49AL4sv
         cF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IYMd1AnUAPkMGM+mZJ4SXD6TMuAQaYu5keXEtUSwigU=;
        b=jxeJs5VVe+DhvsjbZrYeKoUvq2RgSkgCCPdNR02fEGT0Q1BV5z3+SRsj+MhREu/byH
         bjZvhxpH/gjuXBvQTTEltG7Ib0kIu1m/5/Z74w5Oq6bPTQsOQhE4mZ3CiCn4xMLUNt3s
         4nP31YLHAsBNzUxCP3QfLB2tqQn6KRaeKOCumiHcuvYNx9eE/UDPdbej6+LGvJ8Dg8Fc
         dcpZsvBeHh0Un8V+d2aoTZxNk3Oo9epjaLO5/Jta2xaqvzRzFcNr4oitrIvtbdv2tBCy
         bTMapYlsTbJi5X5v+39CYodGsoUJgE/VmjNmfnhBnYFJBaMmhAAyIa8xH2SwTW5aL1w5
         YT6g==
X-Gm-Message-State: AOAM531apldRIGe5JzEUUx58pNT/z4JJFnQE61waEtJG4MS+7r/FnaYP
        Fe6++oMQU1xxt/PEYMgM4aB5Ag==
X-Google-Smtp-Source: ABdhPJzneh3TIZ4iWzcoexcyoNh9amW0JOGqNov81CSCdr8FsV5jm5LYXnkl+oudXPsIFda/4RQstQ==
X-Received: by 2002:a17:90a:e38f:: with SMTP id b15mr2842638pjz.206.1590551633445;
        Tue, 26 May 2020 20:53:53 -0700 (PDT)
Received: from localhost ([122.172.60.59])
        by smtp.gmail.com with ESMTPSA id w186sm819760pff.83.2020.05.26.20.53.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 20:53:51 -0700 (PDT)
Date:   Wed, 27 May 2020 09:23:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, saravanak@google.com, mka@chromium.org,
        nm@ti.com, agross@kernel.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, vincent.guittot@linaro.org,
        amit.kucheria@linaro.org, ulf.hansson@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com
Subject: Re: [PATCH v4 06/12] cpufreq: qcom: Update the bandwidth levels on
 frequency change
Message-ID: <20200527035349.mrvvxeg3lqv53jm2@vireshk-i7>
References: <20200504202243.5476-1-sibis@codeaurora.org>
 <20200504202243.5476-7-sibis@codeaurora.org>
 <20200505045012.zfx2e6chqo5f3e4n@vireshk-i7>
 <8fc5b72c9af6fd6a707a280cfc678677@codeaurora.org>
 <b7e184b2da5b780a4e7e6ee47963f9b4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7e184b2da5b780a4e7e6ee47963f9b4@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-05-20, 23:18, Sibi Sankar wrote:
> https://patchwork.kernel.org/cover/11548479/
> GPU driver uses Georgi's series
> for scaling and will need a way to
> remove the icc votes in the suspend
> path, (this looks like a pattern
> that might be used by other clients
> as well) I could probably update
> opp_set_bw to support removing bw
> when NULL opp is specified. Similarly
> opp_set_rate will need to support
> set bw to 0 when set_rate is passed
> 0 as target freq for the same use case.

Sure, please send a patch for that.

-- 
viresh
