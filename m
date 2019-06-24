Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52E035052D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 11:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfFXJIs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 05:08:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41753 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbfFXJIs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 05:08:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id m7so6500207pls.8
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2019 02:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W6ElPzoRkMG2TinGXMwV20PxkL1nbsID5tYeegoksow=;
        b=v8kicrhdNQzTJtKXz8JndxUg22PalL6KuNoWKtRWwuMR0+8xKgT1CPoBOauIH/nTgg
         1cyMtBAwypfjW6RsGeAava5D6Oc2VPRoMJLUSgyx6QnO2tkys5aHrNVt7sJ0Egz+SuIK
         MRKFQ3c0pvrqjgoFg44H07HsKnVkgiKtcyZpVg2WSFpIeJLJfsBK6UdPyl7pi80nhNM1
         iTDYaEXp3GgvXBXHmvrkEgyvNQMP51bLQlF7qYLKeXLB7Tw5oiLRPXqaMhz7Ijb3cjgJ
         IQLi/BcSMhtE6WD4PdKTubmalgyt6S7qBlK9AoWR2mrkvGddJOfN54fQHwfv2FnQfejb
         fP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W6ElPzoRkMG2TinGXMwV20PxkL1nbsID5tYeegoksow=;
        b=OHKigUvy4i0QxnsaNdxfiluVf30QuOUL0ysOV6HOHxft17Ecjs1iJK3Fb40PU3lcUw
         u8YJihC17Wp59ZpiNKZbvaUNzL+0Zird/362PuVZ1+kHiW2t36PlvTR0af9mmYzBBlgT
         Dihae2HQAfJ4Wp4lwi4f0sF0WHVJqf8HS7Lv5tQxx7qlanzDIc/OpgHM4cvSDFatZ5u1
         rwmRrWtkfkZVE2XwyMnhsscn9EBoXpfw2ASBDc/btqVz8k6gRSsfgmPik8rkOydHJDmE
         Y45VwBRQ/EyANuX/QTfvGggqaw6B9zPevBZuy5iHHEH06A7v2bxcYxw1e9O666/b8CBO
         1Ddg==
X-Gm-Message-State: APjAAAU6DCRV+5UoAknkSCaTlFvuuC7nrBw78k1qlTOPtJqX5+8/SeJW
        30ZRCoQ4dcJygv3Iz/QE44UplA==
X-Google-Smtp-Source: APXvYqywfo3cR2LLbjfwMjPXw9Ib+7wdfT2pRJKVQlmglRp4Kg8SdTQJXSlsk3dTIXqDMlAGL7USbg==
X-Received: by 2002:a17:902:a516:: with SMTP id s22mr105908033plq.178.1561367327776;
        Mon, 24 Jun 2019 02:08:47 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id g8sm10563674pgd.29.2019.06.24.02.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 02:08:47 -0700 (PDT)
Date:   Mon, 24 Jun 2019 14:38:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/6] cpufreq: Use existing stub functions instead of
 IS_ENABLED macro
Message-ID: <20190624090845.tstzw6cruzsz5www@vireshk-i7>
References: <20190621132302.30414-1-daniel.lezcano@linaro.org>
 <0ce0d1ca-154d-fca3-f739-573ecbd2b0db@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ce0d1ca-154d-fca3-f739-573ecbd2b0db@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-06-19, 10:53, Daniel Lezcano wrote:
> 
> Hi Viresh,
> 
> On 21/06/2019 15:22, Daniel Lezcano wrote:
> > The functions stub already exist for the condition the IS_ENABLED
> > is trying to avoid.
> > 
> > Remove the IS_ENABLED macros as they are pointless.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> what about this one?

I didn't say something because Rafael already pointed out something
which he wanted. Actually he was the one who suggested it to Amit
initially.

http://lore.kernel.org/lkml/CAJZ5v0huESFqOADqyym-ci-XcWpL4tbcd9a-jxe_KArXKpHFyw@mail.gmail.com

-- 
viresh
