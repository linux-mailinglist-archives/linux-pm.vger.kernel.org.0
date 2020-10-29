Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14FA29E488
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 08:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbgJ2HlU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 03:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730697AbgJ2HlB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 03:41:01 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D344C0613CF
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 00:41:01 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r10so1634425pgb.10
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 00:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G/Fj0rzWB+sqlfRj/YBfoEOdRONw0r61Ifv9ljQtwuU=;
        b=vlDZGVKbqL686XmVVpjmMh+nebm9WJ9fY1dYIhJSzr7xCAGUoM2qB4kmbpGIaAmAd9
         1yQZ8liH5h9i3cjBF+ZuNeShNXAmIamu0VwanukMyC+Xv75V6CUhhWxJo6wwj+bxW12L
         eedrVWRWZDjDzNy7RC4XQhfGkVG6hA9bsSPErgGQ4QoAwrebVp1dpWq4h3IY86ER6wb/
         ZKOh0pFCjHy2uoEDc6uV97Xjy2MMyEN6w44B/iOk7b1esn9GcrFsD2WJ6ahr/y0Qnztp
         11uPL3n8azhEyRYbAXwxLhKp+SZ38rrSyOp0J/2jkPGMgW9RhMVleEoeK0vseISyv+Ij
         rG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G/Fj0rzWB+sqlfRj/YBfoEOdRONw0r61Ifv9ljQtwuU=;
        b=hoPdGC+yovJ1i/lqO/88iMWnfHP0g6yb8uBzE9jHdwzqaDBljiCxMT/ILgchIAflge
         bGg5wbu9yToax0JPZLdx/husT9c02Ca2jU4MmgZHAUxMINMypOsDFBDbqH+bpYrY1AO4
         R+fPyvbl0qW9gZffxvG7dlgPFn0L0K01YWipMj4WlvdxpHYuUI5f/pTFu24nnDFzmbOz
         pKMzCNPzoBAUDcHohsbunHQLVvyhIqHidwBJbe+4ylM8Yqm22nhYx5jjOMrlKyTVPkSU
         ZDA84kSiSQAG+Vprm96pSG9D5v3tb6DgXVQqpZEWLgOFoR6/ymPhMFpz33dn4sG4Uvii
         r+bQ==
X-Gm-Message-State: AOAM533nXafi0Y74e6TmGPe0lLlddFXlaNJvOrwXyhpIpL4mvXGzi2Yg
        csOHKc7/snPH7Zap0mPkPCk1SQ==
X-Google-Smtp-Source: ABdhPJxhWdliByW+8xApT8qq0Sxjwc02qK0z8V7QEJ8bXUq2Az8Xn/BV2BSjMwskTfrklclB5fv7VQ==
X-Received: by 2002:a17:90a:4596:: with SMTP id v22mr2957412pjg.73.1603957261006;
        Thu, 29 Oct 2020 00:41:01 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id r17sm1912630pfc.157.2020.10.29.00.40.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 00:41:00 -0700 (PDT)
Date:   Thu, 29 Oct 2020 13:10:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vireshk@kernel.org, robh+dt@kernel.org, sboyd@kernel.org,
        nm@ti.com, rafael@kernel.org, sudeep.holla@arm.com,
        daniel.lezcano@linaro.org, Dietmar.Eggemann@arm.com
Subject: Re: [PATCH 0/4] Add sustainable OPP concept
Message-ID: <20201029074057.6ugmwyzna52x3oli@vireshk-i7>
References: <20201028140847.1018-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028140847.1018-1-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-10-20, 14:08, Lukasz Luba wrote:
> Hi all,
> 
> This patch set introduces a concept of sustainable OPP, which then can be used
> by kernel frameworks or governors for estimating system sustainable system
> state. This kind of estimation is done e.g. in thermal governor Intelligent
> Power Allocation (IPA), which calculates sustainable power of the whole system
> and then derives some coefficients for internal algorithm.
> 
> The patch set introduces a new DT bindings 'opp-sustainable', with parsing
> code. It also adds a function (in patch 3/4) which allows device drivers to set
> directly the sustainable OPP. This is helpful when the device drivers populate
> the OPP table by themself (example in patch 4/4).
> 

Can we please have some more information about this ? What does the
sustainable OPP mean ? How will platform guys know or learn about this
? How we are going to use it finally ? What does it have to do with
temperature of the SoC or the thermal affects, etc.

-- 
viresh
