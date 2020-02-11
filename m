Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D92731589C8
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2020 06:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgBKFxT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 00:53:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36707 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgBKFxT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 00:53:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id a6so3813610plm.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2020 21:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zgKT2olnfZf2ebLiTLOhynt67K9ldVhv1eUXT8GsyXA=;
        b=NEgqCcw4bV9ZGGYq11+fLme0M3mT2iBR1THZQUywnXO+vO9YKSbj6JLddXJ+eJPyIj
         +xI5VCHSC+4zLTNvlILyE41cfAwH4yXPXeIT99VwnXITTz6xwDZHrw2Y/sccNwTwoOUF
         5DYd+VFfcMgOfAF8QeCN0oPa8RzZdDW13OowTDSfFaGb25B5Po9SlpOVj9meh8ZhCJC7
         wAVhuuG4UePIqZ7sVdOblVkauJ6EJ4/5BlqNFkWvBBs0WB4R5JWq6kULgzNlmffR47Bu
         K/aoVt26+nnF4P42wLPtMmKp9o74ETVZdhbO1CHTNKYLk3ENL2djZuq4Qc+HLSwYOmew
         hnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zgKT2olnfZf2ebLiTLOhynt67K9ldVhv1eUXT8GsyXA=;
        b=IBOYSMw5fyHTsUAaFzGc62xrw9edl3kr6fMVgyP7FfW0mPjNIAo/hg5Cvp2nZgvTaX
         Lalz1zlqQ0poKRHBNmopUx8aDUltsJVLzhKuZ7n0xhyq15SyuwCTTn9szEWkXw45mj6H
         1BFW5mz/DwvFDMGdwrgb8kGnXsvheG7YtXfMXvUPZ3VIdxjzRjpH5CfnY0Vb+V25mlX7
         JvSkQGoWisUKdEYK6Rn5Z6ZRk7L2B0DTXaON9L6JoKIXYff1aiiRH4zNWlXMSd6UQv0r
         T+gaP9KPJwl6pA5SV/vYVrp+xaL8ky23rfre3myp2DIBE7370AfeB65YFyK+IqFtVGCk
         Cr7A==
X-Gm-Message-State: APjAAAXaNOTJryZ7sky0VOGiuVIRigT5xodLDcLR9iIORZq1vIBYHwl2
        PQ7lwH24VP2Ngshvq7IDRHr080v/UXo=
X-Google-Smtp-Source: APXvYqwQ7M6BRB27p34X2LI2nVU1vbxnu9jH0D2awGtRvH4RrjHkQiMSLdLmqhKiL2XUEAh4aSsraw==
X-Received: by 2002:a17:90a:be06:: with SMTP id a6mr1745919pjs.73.1581400398454;
        Mon, 10 Feb 2020 21:53:18 -0800 (PST)
Received: from localhost ([122.167.210.63])
        by smtp.gmail.com with ESMTPSA id s14sm1972885pgv.74.2020.02.10.21.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 21:53:17 -0800 (PST)
Date:   Tue, 11 Feb 2020 11:23:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Tang <andy.tang@nxp.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [EXT] Re: Ask for help about cpufreq issue
Message-ID: <20200211055315.qlqrxiqf72u36ijl@vireshk-i7>
References: <VI1PR04MB4333D45D033CB8E33CB9070FF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207052321.povhuxrlm25ueoak@vireshk-i7>
 <VI1PR04MB43334D5868037FCAE4D7631BF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207070544.geurecsy4i22xpzl@vireshk-i7>
 <VI1PR04MB4333E6B3340BADBC737E9CFFF3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4333E6B3340BADBC737E9CFFF3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-02-20, 04:20, Andy Tang wrote:
> Hi Viresh,
> 
> I checked the clk part, no issue was found.
> I did found a odd thing in cpufreq directory.
> 
> # cat scaling_available_frequencies
> 1600000 1000000 800000 500000
> # cat scaling_max_freq
> 500000

Ahh, sorry about that as I must have noticed it earlier.

> Why there is a 1600Mhz frequency available, but the max freq is only 500M?
> How the max freq is set?

Hmm, I am not sure why this happened. Can you try to write 1600000 to
scaling_max_freq? This will fix it if the userspace is responsible for
this limitation and you need to find which part of your userspace is
causing it.

Else this is coming from within kernel and you need to track calls to
dev_pm_qos_add_request() and check all calls related to freq qos
constraints.

-- 
viresh
