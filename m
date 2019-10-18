Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD563DBCAE
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 07:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfJRFJ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 01:09:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40810 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfJRFJ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 01:09:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id e13so2663581pga.7
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 22:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BZNeQBeDGAyLMoRdSAbVO0kzqdA4HOw3dFZcIwAbSRY=;
        b=bAJAZ7tswXf0oXbHqjYQDAMHA3fSiDLD+u26iHQS3x7Py/AcVrPNdS1oryA/TMrWe1
         C9PD+y8lawPz88eAyR5kk9Ml2o0a2TFQNKQxu5nv0Wko1NLrNPGhbDP2SiubBiHlhq0v
         1/91vfMvcO6zUodpEcXtTf8sait3hj8kvN3nmEjjbwNbCByc65QH7tQoCwZ/LtTheEIu
         JSQoVll7PmAV+02dufnMm9xRZK1sROHW51Meb3G071rNEmxfzM4+2ywSAAVe158ND1G1
         S0cq0spmyRYEcz+YmtAujZEgme/2JwqP/4M5ouQeOV35ynsE5W8NRjmV3HAGu0kn5htQ
         A4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BZNeQBeDGAyLMoRdSAbVO0kzqdA4HOw3dFZcIwAbSRY=;
        b=WdOAdTlTGr5zLV+ZXAf50PMkdPkoivYJPg/d1l3rpL9bxxN3ykHJjw2A97VBXzH3vJ
         M85SMoqVCrWsE31XCukLFPkjI1D2zUhZWL6RYatPn5tiIJN066WdNvYaG3E/gYd03tDa
         bS++rpPxQmOxUnVj5q8tyNHBvK8l7PlFUvUdBhe4KIIfz/BdTk53SHWmKhcyUOrLh7ya
         0GHiNsEf23HJBUBIPslKgG78a49igNh90Rh32Ic0DvwnNokw91CMZRjpsI9PH6Z6yN5z
         nNednmIdsuZ31dKMVtUzTZQ3NBPT35wvi6eR51/7BpSny+DnOItpbPhaI9ZMiF017mM4
         SF3A==
X-Gm-Message-State: APjAAAWoUG42S5yiwH06bl4MPxfAeHtuIR2pQK4uPAPPfQT5ugGEvRPs
        s4xgd/IQSStt4gna2xlQfRmEDsaimdM=
X-Google-Smtp-Source: APXvYqydfwa25JKZYYeWbwxFsqUZQ8NzYboAYSS65MWiR5DAcXqWJJZyILycxPAp3epGgyJMNw3bqA==
X-Received: by 2002:a63:1b59:: with SMTP id b25mr8029273pgm.267.1571373538882;
        Thu, 17 Oct 2019 21:38:58 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id f185sm5139382pfb.183.2019.10.17.21.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 21:38:57 -0700 (PDT)
Date:   Fri, 18 Oct 2019 10:08:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] cpufreq: powernv: fix stack bloat and NR_CPUS limitation
Message-ID: <20191018043856.srvgft6jhqw62bx3@vireshk-i7>
References: <20191018000431.1675281-1-jhubbard@nvidia.com>
 <20191018042715.f76bawmoyk66isap@vireshk-i7>
 <c3f16019-5724-a181-8068-8dda60fb67fa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3f16019-5724-a181-8068-8dda60fb67fa@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-10-19, 21:34, John Hubbard wrote:
> On 10/17/19 9:27 PM, Viresh Kumar wrote:
> > On 17-10-19, 17:04, John Hubbard wrote:
> >> The following build warning occurred on powerpc 64-bit builds:
> >>
> >> drivers/cpufreq/powernv-cpufreq.c: In function 'init_chip_info':
> >> drivers/cpufreq/powernv-cpufreq.c:1070:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > 
> > How come we are catching this warning after 4 years ?
> > 
> 
> Newer compilers. And btw, I don't spend a lot of time in powerpc
> code, so I just recently ran this, and I guess everyone has been on less
> new compilers so far, it seems.
> 
> I used a gcc 8.1 cross compiler in this case:

Hmm, okay.

I hope you haven't missed my actual review comments on your patch,
just wanted to make sure we don't end up waiting for each other
indefinitely here :)

-- 
viresh
