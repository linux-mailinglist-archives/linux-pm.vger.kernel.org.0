Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70D41E1581
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 11:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbfJWJOZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 05:14:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38631 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403786AbfJWJOZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 05:14:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3so11774478pgt.5
        for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2019 02:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l84ELQ0Fr0mHj8nmaOnwifn/jrsao3RvAgYSFfKcX7g=;
        b=gVMQLtBQBK7IIrkm0TTOcIQPjkZVDEp7rlqt1n6w+6jCdRLP4YUxUy5GGEY118OMyu
         4FUpu+qTKCvmiAf7TgPGw+lkTO6mo6Byo1M0l+AUHvPfIPybiIiWEqpiz5tBq7GHeuhz
         f52EM0Qq3sHQd7eB0nJXh5vJ0a4/yHmn/MEBYlVrbp4WgBpVi63nMftA6ttB9eMC6WqA
         uBmLPaB1ogUmVQbFfhYjm0ctk9oKEZgps60hBCWZjmfVG55FVorkKXzrTklZ9HjTgP/i
         wn+XYn7jefHOAmQ2Nj43Eajy8aoDxpJbcF5MqpomWkKnQRxW6vj2WyNLvslw4sfzdeu9
         e1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l84ELQ0Fr0mHj8nmaOnwifn/jrsao3RvAgYSFfKcX7g=;
        b=S2cTFKngUO8j4uEL+cMUVXxAWuIMeKgwqFTNprzVwLMu+osm1fg6/QVmmrBbvaXRfa
         PLiHlRwr3Kyxt8fzWGytLjwZmzsz73qXY/uP2zCQebR+UCnpLWvoKg5+GewY836jvtaa
         TMH0jDByaDVcwk6OAwjofI/yryXSktt1FN0Vh57rRzEz8E+2XTiBjHEOuGXPUEG+xqt8
         ID5iaP1LmBEy90OYjdUi3HPJTcxvH8qImdrofAKAqORPN+vdeGIovCOGeEEyUkPq6WuC
         +LTYGwc9OFZbMAy9sEEDiF5BeAotKvANfCKL6PTTnRetGnyKtU8T58ytZ4Bo8e9Im8ZY
         bIWg==
X-Gm-Message-State: APjAAAUoeo+I6y37LbhyZMFj5q1d5oGVt8+uvO1kbr5S94HuTQHyqpxq
        Cww3pndys+ibBHDYHLxc3hg1Ow==
X-Google-Smtp-Source: APXvYqw26VrnRd97k7d2ae9qxgmVMV7loEybaduTFil8oEH5qzT6ucM4ihQw8jZOhUNec1Zaca5A9g==
X-Received: by 2002:a17:90a:fa0d:: with SMTP id cm13mr10421182pjb.114.1571822062926;
        Wed, 23 Oct 2019 02:14:22 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id w2sm24517101pfn.57.2019.10.23.02.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 02:14:22 -0700 (PDT)
Date:   Wed, 23 Oct 2019 14:44:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] cpufreq: mark duplicate frequencies as invalid and
 continue as normal
Message-ID: <20191023091420.t7urr6lxejhtzaww@vireshk-i7>
References: <20191022173215.13350-1-sudeep.holla@arm.com>
 <20191023032608.v7lgqirvpbwgsyz4@vireshk-i7>
 <20191023090647.GA29654@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023090647.GA29654@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-10-19, 10:06, Sudeep Holla wrote:
> I agree, we shouldn't. But this is in IKS which is built in the merged
> table by the driver. We can fix that, but found this easier and simple.
> And since it was allowed when the driver was merged, just thought of
> checking the details with you.

That was 7 years back :)

Yeah, lets fix IKS tables then instead of adding that to the core.

-- 
viresh
