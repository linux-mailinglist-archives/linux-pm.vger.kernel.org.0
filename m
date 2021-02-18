Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B1731ED19
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 18:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhBRRPR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 12:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbhBRPqq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 10:46:46 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9155C061786
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 07:46:03 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id z6so1570490pfq.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 07:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cn9DcIA9AN/PH1bnsLrw3E0sYTBmikm1mlLSEa4gBbY=;
        b=w4jPWHfJ0axD3jdPfZ9w/vGksv0PG41cYknVMb5Jus1JbW12FWeQDJF2+pcApVebQj
         jyHew4Ef8fcUlkrdj3IVLE5kg6FpM46q/z9aWvU84UJ4Wx+2BBvc/QSpVUoN1iZCBpfm
         xzrQyRp4cJ0n6k1CeV47QfXgzbe4MefUQ+rmuCdVvndjKGlQ189yhZP7JLd22vxdVvn4
         aeue3o/8M9lnnPjCuhQ7EswLzE/ey/HI56ScZ1VKKmFMpt78hr8jWperxv/IH+iu2xNm
         r1sfE9+w5X7ZC8eJfEq40J6SMm+EAiUU5XnwHEtUCnCcyfpMgiXYZE65KDMheWZmcaJj
         ouxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cn9DcIA9AN/PH1bnsLrw3E0sYTBmikm1mlLSEa4gBbY=;
        b=Fkow0QyVQxEEtv9HJwDNWazG4r6ePInoC7tB7Yp6WxX0LqTGWyP7405IrNnjcljT3W
         +yhBefBry4TabfJqe2DXIHT5CurPOFiNX3O+Cqxs11sIrNtaSn3w02ryq0++OtspDVtp
         GI9yZbMGpLTHJaVLPEBxDQY8CZ+2t3py1QkPe+8ss+s9eDa8low2OhoKBMyIEbiHiMdi
         2XYN4pWLMZ+WlVWXtQUcg5jXIkGck5v48M3iKCjVliCvaiXiNhD8C5bKEiVOOAx3R5vs
         BXghJ2YfccUR8lQPD/GnORtKcSgFhcfVqHHtpk8eEaoEc4h2nNsEbV4boJpPpT3aCTSi
         8wQQ==
X-Gm-Message-State: AOAM5327E1e37lqy/Cia1jXiE/nLR7Z8xLPdG9PrS7j4RCt8qjsApe0h
        zDPAVg6vCep4mtcL7w7pVmirvw==
X-Google-Smtp-Source: ABdhPJy/ov6x/wJtjo+ZianbOXvKUJce+395QEvFvkq0/j4Yxe2OmzzygjWihqYA9y/RhdpiovURug==
X-Received: by 2002:a63:2947:: with SMTP id p68mr2677635pgp.113.1613663163320;
        Thu, 18 Feb 2021 07:46:03 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id s22sm6484397pfe.133.2021.02.18.07.46.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2021 07:46:01 -0800 (PST)
Date:   Thu, 18 Feb 2021 21:15:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     rjw@rjwysocki.net, bjorn.andersson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: exclude boost frequencies from valid count if
 not enabled
Message-ID: <20210218154558.zrcymny7y64y3raz@vireshk-i7>
References: <20210217000013.4063289-1-thara.gopinath@linaro.org>
 <20210217055029.a25wjsyoosxageti@vireshk-i7>
 <4c9d9d44-5fa5-3ae1-e9bb-45cf6521b764@linaro.org>
 <20210218084847.743rttqwlmwyx6pz@vireshk-i7>
 <d693d999-7734-3e69-edb9-9e03fd2f0d1a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d693d999-7734-3e69-edb9-9e03fd2f0d1a@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-02-21, 10:03, Thara Gopinath wrote:
> Scheduling a notifier for max frequency change from the qos framework should
> do the work, right?

Not that, but we need to increase/decrease cooling states at run time,
create sysfs files/directories, etc. It isn't worth it.

-- 
viresh
