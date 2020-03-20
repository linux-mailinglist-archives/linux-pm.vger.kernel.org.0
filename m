Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 190EF18C86A
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 09:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCTIBY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 04:01:24 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:35979 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgCTIBX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 04:01:23 -0400
Received: by mail-pj1-f54.google.com with SMTP id nu11so2129836pjb.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2020 01:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F4z4DhLVGvbna7aIcuhJEG+lKoXYnQgbcpPqw2ITAKU=;
        b=Ygxm+18KOXZTFbzvkGg+Tf7RqavXc344b9FQ2nlvHUhRyxiLwNSVZZzOH4mFW/b2RH
         LJhABONmxCTa+PLt5Tu7POF1qsT8W4TE/ODvrLFy0CuQPCmjym4SToq6doAWMB11DSxd
         Qar6z2Y3XBEf4v/OJ+QpNzrR9HiEBwUA+wQ+g3GXu4fMFziYPlhtt0njTouf6ExMH0Ro
         pMPfS9RoHlMQ8ijIOcX1HAAWFwoZHgnhc8sEQyaHf1KHLhHiLgBaenncmhJvMPm4r7po
         U2n/elBRNUUOMppW5/2Sw8Ks6whUl9OOigfw8icHCwZXxRsq2PF7H5xZFEGmrVnOo0c0
         Yqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F4z4DhLVGvbna7aIcuhJEG+lKoXYnQgbcpPqw2ITAKU=;
        b=VmvCE0b0pUYOtVCZqvVjIBQlIS3iUIRy8GFI+uOPZH3hPMJTAAy888z5Busrjf51hS
         pbRmZpdARtkNgdSDqyfxQOCalMwBAk7m+bISaC5hYtf5Kh4V7ZASGr7wHC7DWjQZsWbO
         MjwHiclo69nlX2p6DCdfcaPlSaO3/oE5LBdOkibB0rVOobWp+6B8LqhrR/20NXM542F9
         Mw/qq75B5riXPqujnnx0p5ZXxYABLhMNnyoHpSdBRzS0umkiilwPoOnWx3iO2wNP38k+
         tCIHtfzP0esuRpKXbM0cAzyl2MIWDUO0o9Sy9z2tsffaZ7gOqk3tQE3DSoGRyiDeza8R
         HRLw==
X-Gm-Message-State: ANhLgQ1HSPUH3/wdeoXkZ1zhPaYr9rIbUehuubmKg9Q9R6KaXqXjMwoO
        BEzJd/SK7PNP9XhhGfrU8aDWiw==
X-Google-Smtp-Source: ADFU+vuiOBTrlaYtXDptNfRvUosd7l5Aa1+h2LxNOdqrM0CsGlfVE5Q6aFN1jDdM00w5TC2vObqltg==
X-Received: by 2002:a17:902:aa49:: with SMTP id c9mr7501332plr.145.1584691282393;
        Fri, 20 Mar 2020 01:01:22 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id g7sm3825789pjl.17.2020.03.20.01.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2020 01:01:21 -0700 (PDT)
Date:   Fri, 20 Mar 2020 13:31:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org, mka@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [RFC v3 00/10] DDR/L3 Scaling support on SDM845 and SC7180 SoCs
Message-ID: <20200320080119.gztifbmenwpi6rrp@vireshk-i7>
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <19cf027ba87ade1b895ea90ac0fedbe2@codeaurora.org>
 <20200318034243.o2metmggzuah6cqw@vireshk-i7>
 <f6a7930a-4eaa-6982-88c6-b50773bee9d8@codeaurora.org>
 <ea4265f3f4b5a439d70d3c80bcc77b7f@codeaurora.org>
 <20200319102411.oivesngrk7gy7vtw@vireshk-i7>
 <78d92969-0219-d140-d788-d1b14e643e90@codeaurora.org>
 <20200319110805.glmuc2qvgcei3mon@vireshk-i7>
 <53065b03-22d5-fb78-aa6f-e4711b8ffd3b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53065b03-22d5-fb78-aa6f-e4711b8ffd3b@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-03-20, 17:03, Rajendra Nayak wrote:
> sure, I understand there is a dependency, however refusing to review the approach
> (to add multiple OPPS tables per device) that this series is taking because of an outstanding
> question which, if I read it right is "We can not add multiple OPP tables for a single device right now"
> seems odd.
> 
> Its fine if you are not happy with the approach taken here and you can propose something else,
> but it looks inevitable that we would need something like this to be supported (multiple OPP tables per device)
> and hence the request to review the patches.

I understand the frustration you have right now, but honestly most of
the delay is not from my part. I normally try to be very quick in
giving reviews or even accepting material for next cycle. Still, I am
part of the chain which has blocked this series and I am really sorry
for that.

Coming back to reviews. I never liked the idea of keeping separate OPP
tables just for the relation that a peripheral share with the
interconnect, i.e. the b/w tables getting discussed right now.

And I am not at all sure if such tables should be added as device
tables anyway, it was present in cover letter of Saravana for sometime
but not in the real patches and so I missed it until the time Sibi
asked me something on IRC.

To be clear, I don't think we will allow multiple active OPP tables
for a device for now, unless we have a very good reason to do that. It
just doesn't make sense to me to have one table for keeping
frequency/voltage thing, and another set of tables for b/w
requirements from interconnect.

So, the changes proposed by this patchset even doesn't matter as I am
not agreeing on the binding itself. And we need a binding change for
that, which Saravana never sent, i.e. to have multiple active tables
for a device.

Yes, we need a solution for this and a quick one. I am fine to discuss
this all on a hangout session (anyway, everyone is working from home
now anyways) anytime next week with the interested parties. I think
/me and Vincent can join it.

-- 
viresh
