Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC573B24BB
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 04:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhFXCK7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 22:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhFXCK7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 22:10:59 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A756C061574
        for <linux-pm@vger.kernel.org>; Wed, 23 Jun 2021 19:08:40 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id y14so3381032pgs.12
        for <linux-pm@vger.kernel.org>; Wed, 23 Jun 2021 19:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2cMdAltjt8237lRexJ5FSrh4rxXUL9y/uutAQz9oNQo=;
        b=oc3jwDaUR8OhRRm/5VrB81wYO/Yuzlhs0ohO3gZt4zmemcT/9Nuze8wp6EwFEbrDpg
         IwSiD6FZijSitFVFy7DCRTo7uod8JwhX3Qx6skbMTs6Y14ZgWbV9dHjoZXTdt3hptVfr
         tkw0yZei1nDce00JezVeQVSLC2PzsS+/sa9EUkDKe85E/U2AHyvzps3mUOVIOrzs9wVR
         O2Ya0y5Ur+1oICo7V8U11a4/nJWFpQD0grxrn9b5bzddjI9Me7i5lHSPfketl5g2MpND
         DyX7+9eC9idsThQvEQoEgv+IxpaHgBLOr93PtaQiJeVims0QPI1Gv7ZziROFCyeYvACq
         Q6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2cMdAltjt8237lRexJ5FSrh4rxXUL9y/uutAQz9oNQo=;
        b=PZ82HJzWbop2jtG0O1djgmjnGXLIxq7zSrzVNU2pWfUy4DuK99aSKrlQI/RjhnsI+k
         JOO0CqSkI6MtncjzgFlqFaMzZvWedVI3appop5y48WNPT2yibwZrGiC2ShPcfe26UFIK
         Ot4iOa7MqoZD4BB+rKOFqrz4ie/cyAxbHFQV6pIuyZ9nASTSG+4iNDuLnjR2uZ8ih3Vi
         CijKEcAqDI7dWTfctz6M/9TxgDJ8aJldDzNKy6kpvOgy+obcLVGW++K8//8EveL7GBXI
         N2nZVafEN5ZnJ2Yb2PESgdyutfax2q1kXnIpS5GepO5yY5A4FS0kTSMELgnC23Tg0b16
         eZCw==
X-Gm-Message-State: AOAM5335GqQcGShG6wfDlN/HjvspT61GpNZ5uI/IUPM1+qNO/Dm8vNAW
        SLzru0q28zU3IRk8fQo4OOS/mg==
X-Google-Smtp-Source: ABdhPJzB/jdSverBHVD7Sk/fl/2VLqMdRPJJI5RGZDg+s7/vOczlRyyJ3klA4trj58YKmmu3NHeWPQ==
X-Received: by 2002:a62:2601:0:b029:300:bd5a:9268 with SMTP id m1-20020a6226010000b0290300bd5a9268mr2654888pfm.1.1624500519706;
        Wed, 23 Jun 2021 19:08:39 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id g11sm402451pgj.3.2021.06.23.19.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 19:08:39 -0700 (PDT)
Date:   Thu, 24 Jun 2021 07:38:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/4] cpufreq: cppc: Fix potential memleak in
 cppc_cpufreq_cpu_init
Message-ID: <20210624020837.orz7a6e4hypasim7@vireshk-i7>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <579689469ed8a7dfd68dcbb41e9191472799a326.1624266901.git.viresh.kumar@linaro.org>
 <20210623134446.GA12411@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623134446.GA12411@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-06-21, 14:44, Ionela Voinescu wrote:
> Might be better for this to be separate from the series, but I suppose
> all will be going in 5.14 anyway.

Right, it is easier to keep this all together for reviews.

> Nit: I would have preferred the more traditional:
> 
> if (ret) {
> 	pr_debug();
> 	goto out;
> }
> 
> return 0;
> 
> It's always easier to read.

Sure.

-- 
viresh
