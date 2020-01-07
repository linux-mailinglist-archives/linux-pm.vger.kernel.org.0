Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D64E3131FD3
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 07:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgAGGbv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 01:31:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43408 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgAGGbv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 01:31:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id p27so22784427pli.10
        for <linux-pm@vger.kernel.org>; Mon, 06 Jan 2020 22:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rIt7/qOuxCe+bTr1Wnd2LRcC3pVPsjTSIxV83hfUP1Y=;
        b=HTLGfKa3fcTvK5gwY2o/RhPYWBbfO/ht2LBc/0A5ZDV6Jl8DQmMireZs4lpyFet+1s
         bWrgKbUuN6rQ6bVsRI4UERCWy8WFDJcvggmt6lz8Xsj3daREfzHifvcpWTO9vr01l0Qu
         VpZBxP7hbYdDqbPmJft6S67k8jF43dSwLDAmEM3+yHLRoHwBMVIxNKeIgIjIYXPjxfh9
         viMDW1JHQEfDu+A5CPOdvKfVJQbuTIDUw7imlnnb4X+DdrH6MWPMTOb9qs3UguN/ZMZA
         yyiovwMX+DLfQmF6P9Up/D/AKAgLTW97bionDPYA2+Lo3akC6dhfV3n1tdkM5kKON18H
         WaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rIt7/qOuxCe+bTr1Wnd2LRcC3pVPsjTSIxV83hfUP1Y=;
        b=Qe2vhtd4M7ITTHWPCSt0tzjJV6m4Qmo9Kohe12V61zKxkZr/DxVS9ySliWk4rzpCEb
         EW42jQs+CJMb/WuKx23G+9x1chnRBi48Yy9TnMPP0GMqfC9dc/Byw1u3DZU/68rCm8iV
         KMF65H3zGx9go4s4Rb2+jeBeVp9Tr5IswOEma3VgkhyCTEYn6C5Fn7r8cP/d/3QHmCHo
         zNKPlaTN8bsL9DfAWazD6/bt9IQcAEYdrP0ZRUFvdnNgWkuPmChBM1sDqCbJ0Ja0qapT
         Yx2uGb0NZZV2BqCUKHc0E7rP/0xHag0NjD/fDJDGEvbunsM086Legf1mCb4hc1PxlKt/
         zDUg==
X-Gm-Message-State: APjAAAViotk1NUXre6uEMQ735/srmP33mqSKhWtJ+CRVXPcZ+7ILnD46
        gnLQ6+zNdPkXdPwpt1aDRtaKCg==
X-Google-Smtp-Source: APXvYqwyymqg/dX8KMgo+H2hSC9clUay904mRdykr8CUp58TUkBswxSnHXPz+dMPSgZpbGd/FzVFiQ==
X-Received: by 2002:a17:90b:3004:: with SMTP id hg4mr47499847pjb.52.1578378711131;
        Mon, 06 Jan 2020 22:31:51 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id y197sm81887026pfc.79.2020.01.06.22.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 22:31:50 -0800 (PST)
Date:   Tue, 7 Jan 2020 12:01:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] opp: fix of_node leak for unsupported entries
Message-ID: <20200107063148.lr2s65igfncbkpxx@vireshk-i7>
References: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-01-20, 20:36, Michał Mirosław wrote:
> When parsing OPP v2 table, unsupported entries return NULL from
> _opp_add_static_v2().

Please fix that and return something sensible from there.

> In this case node reference is leaked.
> Make _opp_add_static_v2() always assume ownership of the reference
> to fix this.

The ownership lies with the routine which took the reference in the first place.

-- 
viresh
