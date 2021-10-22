Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920D4437102
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 06:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhJVEp5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Oct 2021 00:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhJVEp4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Oct 2021 00:45:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DA2C061764
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 21:43:39 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t11so1866872plq.11
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 21:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2b8hUCDhenD3A68S7sjLVwnkOcO6p6v7nwBh27Bf6xE=;
        b=SoM3r/7j/3Px8BWms9I+P9JYjaRtqXm0tpjhcipvjRZ6SDr7GmcfIw8faxA7aHWInJ
         D+GUlO7Muw+p0A8hbbzBJ97/zYXFIYiI4KyhCh8kB5667qwWQKUDKYAZQxr2Bbid89f/
         bU1l85s8lG6phRErDbbHbBKytvnNjG2MBaNo9UsaW9m2HBOnj0OvRhTMQvf92gJHti7T
         6KVmr6qZqQP+xUSJKpoFPj1Qw2QZXCDRXcJn4Rd15U0kdzUPDMg//4C0+LPpor7VFlrh
         58zWxGMVwhrvP+nTL+0+3ezBtiDTMLZHSO/+Du5sszjtAc+sqyo7i3Gtqc5yeeJ6nmwy
         cNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2b8hUCDhenD3A68S7sjLVwnkOcO6p6v7nwBh27Bf6xE=;
        b=kpGuVEN+kwp8XluHBbEkuszm/2nZk8tHD+XZzL4tQunsDgSMqf+xgXQtckrsceIdkE
         XQhob1iAAImbqCerI7Hd6ojBkPCdSljFEXhiAR6fFlUU5KPQqtc11gwFi68O0gc98Yfe
         U5pJpYfx8oqLB1dJzFnaQzXVSvR7GUbSD18/xzrdLHi1fN6PJDroRSoqB1pWFaXy6Ygw
         c/d0SpGKHaCqj/iLORAgrKpCg0d6NAWlpllr275+UAxW48ZINjX50x3NiunFNL5sQT3/
         JogLbBeNjs7HxcKlQ/OipZmatFohqEoIV8Ri8XyMTR21UWZxDIBRCyn1Qvc8ZcWjdgtw
         acgA==
X-Gm-Message-State: AOAM5339rzzSDQMqr+gKfCvgN6UOYw4dciRaThV89CIWHcjgke/gX1GG
        16z8CQfqzKi4UaaUCY+KeCyJew==
X-Google-Smtp-Source: ABdhPJwsYr7yGuAcdThYvhCb2+nCzIQTaKVAXmFBDnjK3FbIGqmHVsUpgVI6s30sjV81YcvwXZyyGQ==
X-Received: by 2002:a17:90b:1645:: with SMTP id il5mr11540510pjb.158.1634877819289;
        Thu, 21 Oct 2021 21:43:39 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id e9sm8693186pfv.189.2021.10.21.21.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 21:43:38 -0700 (PDT)
Date:   Fri, 22 Oct 2021 10:13:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        David Heidelberg <david@ixit.cz>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: opp: Allow multi-worded node names
Message-ID: <20211022044334.4yn3i4kwinbrjicd@vireshk-i7>
References: <20211019231905.2974-1-digetx@gmail.com>
 <YXAr4OlhucAibMlH@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXAr4OlhucAibMlH@robh.at.kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-10-21, 09:46, Rob Herring wrote:
> On Wed, Oct 20, 2021 at 02:19:05AM +0300, Dmitry Osipenko wrote:
> > Not all OPP table names and OPP entries consist of a single word. In
> > particular NVIDIA Tegra OPP tables use multi-word names. Allow OPP node
> > and OPP entry name to have multi-worded names to silence DT checker
> > warnings about the multi-word names separated by hyphen.
> > 
> > Reviewed-by: David Heidelberg <david@ixit.cz>
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> > index ae3ae4d39843..298cf24af270 100644
> > --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> > +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> > @@ -22,7 +22,7 @@ select: false
> >  
> >  properties:
> >    $nodename:
> > -    pattern: '^opp-table(-[a-z0-9]+)?$'
> > +    pattern: '^opp-table(-[a-z0-9]+)*$'
> 
> I don't see how this helps you. What I see needed upstream is a prefix:
> 
> '-?opp-table(-[0-9]+)?$'

I wonder if we should disallow that to keep naming more consistent.

> Though really what I'd like to see is the OPP nodes moved into the 
> device nodes they belong to when appropriate (i.e. when not shared 
> between multiple devices).

+1

The only reason for keeping it outside was because CPUs were sharing them.

-- 
viresh
