Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCF7373991
	for <lists+linux-pm@lfdr.de>; Wed,  5 May 2021 13:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhEELi0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 May 2021 07:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbhEELiZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 May 2021 07:38:25 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15114C061574
        for <linux-pm@vger.kernel.org>; Wed,  5 May 2021 04:37:27 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h11so1971696pfn.0
        for <linux-pm@vger.kernel.org>; Wed, 05 May 2021 04:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jwzu12d+QscnqOFQLhy4vh097a70ZnMp+hWw5krWrIk=;
        b=ZxbA1tfyfKPGdWBAOR+Y7RlXNKo0jtDwpuDRVr1usMxGZoBv82lY5nRNfltNjKO1hH
         Q7y7FDb6LgIpvZMvCb7aqc+Xve+lVh9zkUaSTlQzCBPHlpwpwcZtrEnarO5Lc5WDNp0a
         ug8JjqltbYlpsOLL2jMLtIfag5oYlt9qghVOy/7eC6FZhjz5YERIwOAuHHdzqHj7WESp
         GHgXxzeLXt3pIm1ioOJenBBeRsDagR/fc+XiEzSImMUkgoAX1tbV5vPWKN21/w36v4bG
         9WW1ksviqEZBHvq9FUbzJrqKeFQ0eOf9EDv5mYbjpmIryj4TESREdyKnD9I8QGacUcAQ
         iTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jwzu12d+QscnqOFQLhy4vh097a70ZnMp+hWw5krWrIk=;
        b=OXm35ED0D4v6Ap7sAG7xBXm49mVQDylrj0afrdTLMwYjDaWDQQOG6TjosUo1CSyNRi
         I7mXXfn2Vdp92WoNhKJv/NaH01NeTs8q4r0DQYk31xq+iBmWmVk9tA/Rw9mZ34/0szDX
         UgiBVNsY3AUdH3LC8YXEylsZ4+rzAQvBDOarSivpFgxOxOGfRJ/jXJlwmRFTDcxY1Qsa
         IRM6mJkCqh79/roJJw4iDIMfpq9gsk3eQcAkyvEydiWpZxVpEUyWhvJYGVzuBEocWZMR
         1rHEhQKznJwqmv8rqNZTu3jC6fByuCmJ4Z07h58wOPoh9RD8bt7c9I0mwPLlCJiO2ICn
         fMCg==
X-Gm-Message-State: AOAM532UdE5YD47pEU9/6KgiFCfjHb7iWxx1yySg29ReYIVoJXzlRYv0
        DRWeHefoxfjMhZ3+jjdGlOjjBw==
X-Google-Smtp-Source: ABdhPJwCPq/LSEqazkj7mS6+zQB5ApPaTWOLcZzzlV2ZlvhakMrgpY4gelMW0KBKN7Xw7oLx2vKNbw==
X-Received: by 2002:a62:5209:0:b029:278:648f:99b6 with SMTP id g9-20020a6252090000b0290278648f99b6mr28004842pfb.9.1620214646574;
        Wed, 05 May 2021 04:37:26 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id a18sm14989138pfo.64.2021.05.05.04.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 04:37:26 -0700 (PDT)
Date:   Wed, 5 May 2021 17:07:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        swboyd@chromium.org, agross@kernel.org, robh+dt@kernel.org,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org, mka@chromium.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7280: Add cpu OPP tables
Message-ID: <20210505113724.fpzcizgytf55msfa@vireshk-i7>
References: <1619792901-32701-1-git-send-email-sibis@codeaurora.org>
 <1619792901-32701-3-git-send-email-sibis@codeaurora.org>
 <20210504144215.svmrmmsy4jtoixzv@bogus>
 <1fc9fb8d9a94909ff9b7b76d598bd266@codeaurora.org>
 <20210505084908.3lynedmblmqagr72@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505084908.3lynedmblmqagr72@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-05-21, 09:49, Sudeep Holla wrote:
> No my main concern is this platform uses "qcom-cpufreq-hw" driver and the
> fact that the OPPs are retrieved from the hardware lookup table invalidates
> whatever we have in DT.

Not exactly.

It disables them all, and then call dev_pm_opp_adjust_voltage() and
enable them again. This is how it started initially. Though the driver
also works if the DT doesn't have the table, in that case it calls
dev_pm_opp_add() for all the OPPs.

> In short it will be junk and becomes obsolete.
> So what I suggested before is still valid. You simply can't have static
> OPP tables in the DT for this platform. Do get some boot code to fetch the
> same from the h/w LUT and patch to the DT or figure out any other way to
> manage dynamically.
> 
> So NACK still stands for static addition of OPPs to the DT as in this patch.

-- 
viresh
