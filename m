Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB19219C3DA
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 16:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbgDBOVM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:21:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39538 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgDBOVM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2020 10:21:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id i20so3409064ljn.6;
        Thu, 02 Apr 2020 07:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VQXgeD/Fj9psnmcgguEWkC+cBjH2/vLiDiQ1qYPTAGI=;
        b=hPyIYQfiRsrmPV9rPKIGAV4YsdqOFOEqLcbdSme2TuFWLZS4p6Xoj99RGvWr5BAdlT
         F0lVRrOMgVuoF7A/uqsqaJ+d5PbUOyYFMErW2HQZd5KD64g1Fl/p00c6D6zo/r8M3XhO
         KswhqDneN99MakR/axYUiN5kLtr5COx65uHbuzljkRgTz4xgsiUTrYMRDNAK4itu4PDY
         XAR8qZFaoxO+HJlzzENwN+O//d1dMty9aOtetHs5+cRFhFjhhjslFZPUXGd4k+c7ftlY
         kb7yYuac5W1k9PddYUmdkXgXcpoy4XwizfPa8JdSXkTle+RnJ32x1ogzaWIZKAD4VMnc
         8hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VQXgeD/Fj9psnmcgguEWkC+cBjH2/vLiDiQ1qYPTAGI=;
        b=ECGUGhg4iiHgLaIePcTdHfzFIMWpphcIKzq45TecSfB5Ao2cMxFPgQbkksV8/YnwHm
         n4cyPnAMLCGQ9fh/zz5rnMRIJPBvdSwLoNoWY09YVFHZhVqbz6hxQD3Acxer8cmdZ/qX
         8VEbm9Y79CfH7lPofss47cLMCT/30C80gPTaKSYFK3baVy4NphIknP2tIGF1387OHE2O
         I9VNUjpL8DGnNu8WeTZsuuNo5Fwxa1ak/6bU5k+f4wYzaFFtRGtKCmSmau5PxhM63Ou+
         OXyG4lHjO59q6z6jq5MJ6rxL7gTlvELBCjQZVaIopRKu0XyDbMr1QVa1Ta0Fw6SoJEqg
         5jBQ==
X-Gm-Message-State: AGi0Pub7PfB1yrjgt2ibaRZIQZbfWcsHV174cR6ZyJBMEVPmNiKg2O1N
        LvkVZVM92YYKXzuj83RB5UsGVaTy
X-Google-Smtp-Source: APiQypKXOSU5/jz4Msk6qfRO0FgDCVFZsFIeLtqKlqonQR1ZMcCLEASpFyhnAy+g1hTGl5rue++I2g==
X-Received: by 2002:a05:651c:28a:: with SMTP id b10mr2188178ljo.223.1585837268046;
        Thu, 02 Apr 2020 07:21:08 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id n9sm3336826ljo.89.2020.04.02.07.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 07:21:07 -0700 (PDT)
Subject: Re: [PATCH v1 2/5] clk: Introduce clk_round_rate_unboundly()
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200330231617.17079-1-digetx@gmail.com>
 <20200330231617.17079-3-digetx@gmail.com>
 <20200402003339.GA11124@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <58c3e230-8361-6710-7946-6d2dd98b2482@gmail.com>
Date:   Thu, 2 Apr 2020 17:21:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200402003339.GA11124@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.04.2020 03:33, Michał Mirosław пишет:
> On Tue, Mar 31, 2020 at 02:16:14AM +0300, Dmitry Osipenko wrote:
> [...]
>> +/**
>> + * clk_round_rate_unboundly - unboundly round the given rate for a clk
> 
> Just grammar nits:
> 
> clk_round_rate_unbounded - round the given rate for a clk, ignoring users' min/max constraints
> 
>> + * @clk: the clk for which we are rounding a rate
>> + * @rate: the rate which is to be rounded
>> + *
>> + * Takes in a rate as input and rounds it to a rate that the clk can use
>> + * which is then returned.  The given rate isn't bounded by clk users min-max
> 
> s/bounded/limited/ ?
> 
>> + * rates, unlike in a case of clk_round_rate().  If clk doesn't support
> 
> "... unlike in clk_round_rate()."
> 
>> + * round_rate operation then the parent rate is returned.
>> + */
> [...]

Hello Michał,

Thank you very much for the suggestion, I'll take it into account in the
next version.
