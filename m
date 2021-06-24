Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681873B24E1
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 04:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFXCZP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 22:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFXCZP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 22:25:15 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A860C06175F
        for <linux-pm@vger.kernel.org>; Wed, 23 Jun 2021 19:22:56 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id d12so3415564pgd.9
        for <linux-pm@vger.kernel.org>; Wed, 23 Jun 2021 19:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8E0w6EUy5FYV/ZXtFIifZuvspQzbp8qJ/1Ru+U5hWb0=;
        b=rhcqG5bXRF+/qQu+0PcRAAaZjK7SrDV3G9a1cbYR8BT5Mz2pFl+hUUdvZN0NYn6yVE
         GGfr2K1IpqQGqoiqk1Wedr2+J4pei2krzolrPowwvr55Vw869by7D5gG/ARMdd0b/qmY
         AJwdORvXSghESA+PSbE6ve6KEfC7HZ1HG6OLjYqEAg1HE0LXiKWw1J05kuIkSbXYnF//
         9ekQ5f7BhLj9LqEKdI/OnqMm4WZGXQorynfiOvZMZRnIkn+xWCvNzgs7Ge55Klc6Dr4y
         M2t6VjCl/BKGoYFThOFYFy/EE4IAfDAjvk5s3Yq7HiOpylTAu45ceA5qquUy5lbxMdHg
         xBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8E0w6EUy5FYV/ZXtFIifZuvspQzbp8qJ/1Ru+U5hWb0=;
        b=W3VWY/Ue4YcfVtGRszP5h56btP/Or23aPKAsg12LDRkbDQSnQjarAwFKGin43sjGZs
         ezTHUlyABZE+RiBUyz4CFd0qC1wnPHYJ9FuYVF7F6tx2+Cab4PTEjgcOzXZMV2cN6fqs
         pBbg4lY2FFKHvgI6rQnv6BbcZhj/4W2hSXqeVnSWWtMjR01snhz+easpqzdnMUwlSJ56
         VldBmJxd6AsHv5VMre7VsCUVwmEVSa8IEz96gmvHW2awv3Lt8MaK/IVgxu53SUkmDQ/S
         Q4p0+ig/IZ+LdqXglvmtKEHedfBJ3hGZptdEI+SPRJ12FQhOCOFoJ9ZgYfQ8JlbrN9sK
         tTzA==
X-Gm-Message-State: AOAM532ezKk1eDpP5OyLUwpSzYFZQ0n4kPmKUOJ5LmNrwP6TJbWqCFh3
        bTfWHqrp3Oj3QJFO1hfSNDv+1g==
X-Google-Smtp-Source: ABdhPJwWW49GPW2MjWU5iNXoK9O0NEZ3kG9SNphywPzGZivZ7VLJeEnm5bhuchn9VRe6TGS/NDA3CQ==
X-Received: by 2002:a63:1143:: with SMTP id 3mr2553834pgr.166.1624501375726;
        Wed, 23 Jun 2021 19:22:55 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id j2sm1022237pfb.53.2021.06.23.19.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 19:22:54 -0700 (PDT)
Date:   Thu, 24 Jun 2021 07:52:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/4] cpufreq: cppc: Pass structure instance by
 reference
Message-ID: <20210624022252.zrxsftrvcd43eqra@vireshk-i7>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <b910f89cf11f6916319f9a2fb48d9146005318b1.1624266901.git.viresh.kumar@linaro.org>
 <20210623134533.GB12411@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623134533.GB12411@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-06-21, 14:45, Ionela Voinescu wrote:
> On Monday 21 Jun 2021 at 14:49:35 (+0530), Viresh Kumar wrote:
> > Don't pass structure instance by value, pass it by reference instead.
> >
> 
> Might be best to justify the change a bit :)

I had it and removed later as I thought it would be obvious :)

> For me this is a judgement call, and I don't really see the reasons for
> changing it: we don't care if the structure is modified or not, as we're
> not reusing the data after the call to cppc_get_rate_from_fbctrs().
> More so, in this scenario we might not even want for the called function
> to modify the counter values. Also there is no further call to a function
> in cppc_get_rate_from_fbctrs(), that might require references to the
> fb_ctrs.
> 
> So what is the reason behind this change?

How about this commit log then:

Theoretically speaking, call by reference is cheaper/faster than call by value
for structures as the later requires the compiler to make a new copy of the
whole structure (which has four u64 values here), to be used by the called
function, while with call by reference we just need to pass a single pointer
(u64 on 64-bit architectures) to the existing structure.

Yes, on modern architectures, the compilers will likely end up using the
processor registers for passing this structure as it isn't doesn't have lot of
fields and it shouldn't be bad eventually, but nevertheless the code should do
the right thing without assuming about the compiler's or architecture's
optimizations.

Don't pass structure instance by value, pass it by reference instead.

-- 
viresh
