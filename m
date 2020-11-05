Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF3A2A768B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 05:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgKEEl1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 23:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbgKEElX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 23:41:23 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB2AC0613D1
        for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2020 20:41:22 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id i26so434536pgl.5
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2020 20:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gqvFL/vbADRsFOSmwP9r5bVIotD6ZCq93UTx3nZJmwI=;
        b=qkSgyuSL08dAID7k2/m7sqETUFHJZqzmJk2mvHyQA1xD/6RuT42ON4IKdGFdCh1LVF
         k8wBzb9zeAPFNP7C57W4Ebgpw+j9ugbrN58f2Nl2PQu75QtiLmI84jqmLX9y2VmDjJot
         VSAM6B8HKpmtkpsY724pYhAA9555wE4nK96/IbkKVNLDOPiEFc3bortyIHOV56xujAxd
         hOMyuHm3mzf01BOVjTHq47l7uggBkcSPmN+A8wbImx2AOo7tdLqVORKmKMs+3qIt7Asx
         06Xyzvx3H9ZW9K9zDIEBFL0vLYRH66G9ClyCubV5NRlq5sTTZjjhIffZL9FJR/d3NqcQ
         t8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gqvFL/vbADRsFOSmwP9r5bVIotD6ZCq93UTx3nZJmwI=;
        b=R6q4h9E1xwxnx4vpngRJ8eyMYP8iI8dEdXTFbDhzd/tirz2Mv/DvKXfwv1J02RIMyQ
         BhUeyJgSa80DvjDUvBTsZjeOgq05BoTJNrdWmpsE6pqsOhZOL/xNW9mKMBmH+9ec2P4G
         zkmCtdzzvSp+N5lPqFe/LkdOA4pNOxBeHh4JUfCVUhlAeIUzE0WozCM6RXsCnihua6kp
         DgYcw5c8Qh2zX/nDoNEtuaRP+UufbMN74RYLIeSEiXkUqnkwv8jMKoaZtyaJhJxj0gfq
         iFD0ddKt6FhDX74/I8Yb3iwV3Ku9MtE5GsS7MCndv24H7WaA+RgoNp+kXy7SWAsIp1pd
         6xBw==
X-Gm-Message-State: AOAM5302SMJ4VuXBT2frtDgk49wlbK1PT7P9rXDVG+zEv7NGwrwaE3lF
        MwzIT0LIlgLfG8ZWst2Yg3rqPA==
X-Google-Smtp-Source: ABdhPJzptq0jvKJOQ5q1k3fqtpa6kbr17VFFcsDUi8j5x+ZEwTT4cMxQaGIqho1XVOi11ouaxNTYKg==
X-Received: by 2002:a17:90a:4488:: with SMTP id t8mr561064pjg.37.1604551281686;
        Wed, 04 Nov 2020 20:41:21 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id g4sm488989pgu.81.2020.11.04.20.41.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2020 20:41:20 -0800 (PST)
Date:   Thu, 5 Nov 2020 10:11:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com
Subject: Re: [PATCH v3 2/3] opp/of: Allow empty opp-table with opp-shared
Message-ID: <20201105044118.k75um7gcz3ffkphc@vireshk-i7>
References: <20201102120115.29993-1-nicola.mazzucato@arm.com>
 <20201102120115.29993-3-nicola.mazzucato@arm.com>
 <20201103050141.kiuyotzt4brisch7@vireshk-i7>
 <9f442724-df13-d582-717d-535cc9c9c9f1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f442724-df13-d582-717d-535cc9c9c9f1@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-11-20, 17:54, Nicola Mazzucato wrote:
> Initially I thought to place a comment right there but I ended up with an
> explanation of this case at the top of this function (the corner-case). It
> probably also needs more details..

I read it earlier as well but yeah, that wasn't good enough for me to
understand what you are doing.

> Basically, on this case - empty opp table & opp-shared - we limit the scope of
> opp-shared to *only* tell us about hw description, and not marking the opp
> points as shared, since they are not present in DT.

It doesn't matter where the OPP table entries are coming from. The OPP
table should be marked shared if it is found to be shared.

> It would be the equivalent
> of describing that devices share clock/voltage lines, but we can't tell anything
> about opp points cause they are not there (in DT).

Its okay, even then we should set the right flags here. It is really
confusing that we blindly set it as exclusive, even though it may be
shared.

> OTOH If we don't set shared_opp to OPP_TABLE_ACCESS_EXCLUSIVE for that specific
> case, we won't be able to add opps for the remaining cpus as the opp core
> will find the opps as duplicated. This is a corner case, really.

Hmm, I am not sure where you fail and how but this should be set to
OPP_TABLE_ACCESS_EXCLUSIVE only if the OPP table isn't shared. else it
should be OPP_TABLE_ACCESS_SHARED.

-- 
viresh
