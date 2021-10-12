Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B4A42A127
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 11:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbhJLJe4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 05:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbhJLJe4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Oct 2021 05:34:56 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0803C061745
        for <linux-pm@vger.kernel.org>; Tue, 12 Oct 2021 02:32:54 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso1437054pjb.4
        for <linux-pm@vger.kernel.org>; Tue, 12 Oct 2021 02:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OjzfOb2gtN1u8obAgrzFiLQ684Vop1WYpdfozFIYNbM=;
        b=aUN79haGLdilQZbwQ2763BN39KvkoPsE3h3yb2F3g02IhvUbd7+UHpmgDRsPwdvqhg
         qq86Y7m3+RnD8SsrhKuJzfveNRvA/JMub5MMabigbZcHAd3lQTt+YqD2WCkiac3sGIg8
         ivybUQxgrQ1NSYey8R0pYNdpFe/O11GXl2iR87zlJs5Bjw3HPD+5rcn/1u4q5p39WYEq
         6pa8YxzzKCfPlUmjHEiqbLaF+mY+hpZHgNCXf+2QAIC1xaDoKQohWb9eNSlKpJUrNwkN
         0YpOPypoEJJpeVteY/FStkieAKSrKGeKix9ijK5oRzo3pfBNjsy0aOLP8ZKvzMiIqFDE
         eZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OjzfOb2gtN1u8obAgrzFiLQ684Vop1WYpdfozFIYNbM=;
        b=inDrYxFSUJPqBRjWwF1xUMxADO1iaqRT2tCHh2HY7Tjym4n2R7B6JEbaXagxpw2rzm
         Qdv14cRMKfUhEhguPpgAksrGC0ewolmqOndO1uW7lI6W2MJ4zWZ6hnYtqgPIusLvNFcB
         SUY3TEocNlSSm5s+2LXQ9qeVK33av50cIC3wC6sCWNQI84pVUxgyNJBETqrXXv38D57Y
         HRke7lSY75i7KAV+vl8qvTmTxLVxtwUZbd7KeWlV4LDr2Bxu/2CUq5b+vvU2Z/Zvn+dM
         YYq+G7L1KdAKH06aylg0H41Wa3Q2shz4XJNTxKxH5IWiPIPpJPrgt2jfr+wZP/x2RYn0
         Ui6A==
X-Gm-Message-State: AOAM530brP1V3VOUSy9uMkqqz49PcAEGWuuwjqMMz1eAx63SBFQV7aLF
        8nb7Z1QVlu5n6S/dEyI9LbiFKQ==
X-Google-Smtp-Source: ABdhPJxEZXuRSwmLWd10BJsQLAh/3HgVQI8IjFeMRwsWoABKdg5QGkMx8QfnuDas3MxWQHqNt9oYMA==
X-Received: by 2002:a17:90b:4d87:: with SMTP id oj7mr4748844pjb.107.1634031174331;
        Tue, 12 Oct 2021 02:32:54 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id x13sm10611652pge.37.2021.10.12.02.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 02:32:53 -0700 (PDT)
Date:   Tue, 12 Oct 2021 15:02:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Hector Martin \"marcan\"" <marcan@marcan.st>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/9] opp: core: Don't warn if required OPP device
 does not exist
Message-ID: <20211012093252.hb6rlcpxv5bmk7n3@vireshk-i7>
References: <20211011165707.138157-1-marcan@marcan.st>
 <20211011165707.138157-5-marcan@marcan.st>
 <20211012032144.2ltlpat7orrsyr6k@vireshk-i7>
 <b7cd51ec-38e5-11d8-5193-1170c9d60ac9@marcan.st>
 <20211012055143.xmkbvhbnolspgjin@vireshk-i7>
 <caf16a6c-f127-7f27-ed17-0522d9f1fb9e@marcan.st>
 <20211012092603.lkmhhjoo5v67wh44@vireshk-i7>
 <049FC437-EC38-4FE5-891E-5E25960892CF@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <049FC437-EC38-4FE5-891E-5E25960892CF@marcan.st>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-10-21, 18:31, Hector Martin "marcan" wrote:
> That doesn't work, though, because the CPUs aren't normal devices
> with runtime-pm. That was the first thing I tried :).

What's the exact problem with runtime PM here ?

> If you think this *should* be made to work instead then I can try that.

-- 
viresh
