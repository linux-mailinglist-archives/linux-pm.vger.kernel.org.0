Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FF63A7AEB
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 11:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhFOJkt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 05:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhFOJks (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 05:40:48 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B22C061767
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 02:38:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id b12so8158056plg.11
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 02:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PT5mbjvdx2HxMX/QdjqkC+HPc3LQLFGZl35taHu0Gv0=;
        b=leurNynn2Ym4I8eJRJ8ITDpkro8kCcJq03WoPQ7wedZzmqq/q4Bgtzldh+QJP5+NRs
         IySJ7mKMg0PSRjsWAPfNSItAP5YR+pDswnmNEompGnwnF714Y+6Sq75MTOfIdVJpHnAt
         v5Kiv7OmsAoCwT4S+1ndkR/QCBeiMgjjacp/8VhEDGo2SfqqZ3mXvS641seqnR3P6o9Y
         tTFr48E4PIkYHhukbyIWLSlKx+ftW17V8GljwXA7TsVmE/R72OVk5U1j+1lihpIase9E
         Q+3IVaGFlKv9DxtUtepfcRJKqP0zpvpu7f7Sy3PAySgch7ON25unQGbQEA+6M2eGrJxF
         c8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PT5mbjvdx2HxMX/QdjqkC+HPc3LQLFGZl35taHu0Gv0=;
        b=pez0jnYz0mwzCcH3VyN+tbup/NdeAm70EnO7jGgsbHXCm028rpWI/nq2eiFzhh2Y4u
         q1+816oeSqhc0HCRdI7YppSIg0TA5vnb5Fc6oc+d3EmGtW9/RV5WFRqgD2emU+RZK1dF
         JXoERcZfPMjlVena/2BmxpX3LbfmI7o/mG8krNiPpI2gLuFaPnNL3rPuQpkloMvtb6H7
         3d194dWVvUUkRjp7GUZ3jUTKWcFmib6MBx3FH7mv8OEjzIjafmqSlGMXraSoIoIKStF7
         T8n3aRpN8tzJvqD/T1GqcjpVtyn4KjbN+L5AcQ7XOTd+JjBuIbHnY/8ZMWbLNXTB419e
         D9qw==
X-Gm-Message-State: AOAM532iZQVQbFvVSlQhG1vqsA3vc0+Noa1Sf9XbAyihYerPUmsANuPK
        s90LIkV95Jn5kwDQWV6NgQWe9w==
X-Google-Smtp-Source: ABdhPJxsFlohdS7mjeYLdOkiOwIUqH2UlCDQUGYFvf/ey5fNMpdpRyveDyIrp2+g9YX7cEqRW23lTg==
X-Received: by 2002:a17:90b:803:: with SMTP id bk3mr4019450pjb.224.1623749923181;
        Tue, 15 Jun 2021 02:38:43 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id r135sm15639130pfc.184.2021.06.15.02.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 02:38:42 -0700 (PDT)
Date:   Tue, 15 Jun 2021 15:08:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dirk Brandewie <dirk.j.brandewie@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/5] cpufreq: cppc: Fix suspend/resume specific races
 with FIE code
Message-ID: <20210615093840.a5bca3a6bgmkorwi@vireshk-i7>
References: <cover.1623313323.git.viresh.kumar@linaro.org>
 <eaaaf171-5937-e0f2-8447-c1b20b474c62@quicinc.com>
 <20210615075056.dfkbiftuoihtrfpo@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615075056.dfkbiftuoihtrfpo@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-06-21, 13:20, Viresh Kumar wrote:
> I can see one place where race can happen, i.e. between
> topology_clear_scale_freq_source() and topology_scale_freq_tick(). It
> is possible that sfd->set_freq_scale() may get called for a previously
> set handler as there is no protection there.
> 
> I will see how to fix that. But I am not sure if the issue reported
> above comes from there.

I have tried to fix this race and pushed the relevant patch to my
branch. Please pick the latest branch and hopefully everything will
just work.

-- 
viresh
