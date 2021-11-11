Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCABD44CEC2
	for <lists+linux-pm@lfdr.de>; Thu, 11 Nov 2021 02:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhKKB14 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 20:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhKKB14 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 20:27:56 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC03C061767
        for <linux-pm@vger.kernel.org>; Wed, 10 Nov 2021 17:25:07 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso3377507pjb.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Nov 2021 17:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nWbslJ60ZPCanj2HYtzA6ZLWxe4Hhp7nGp3LzxZFt38=;
        b=IXFXRaZfJ4nCndxstxP8bxiKUWIm4Wt4A6H5xsMg4TiWsNfFAA+vZ5KkIO9UACPT63
         ifosOGyAyEBSysgvuM4SmXBxYsfqeQUzEychsoFuIR2FsiYsbyq6rCMgHwIMlwoycKS2
         M5BiNXgtnhe+0A23d6bpVAFiW18+D6ftwvk84dJYq3CgLAPuNe5WOJ0/Y2x9VFEoZa/6
         NEiBvIRIwlAcTIpoZFROZA7jaiPkgaxXAYzJtdpwWbixo/3cHR56jL08ho8Ut6dub+pe
         bUf/FUPgYZvpmFRi3+Mir8XOENzazvNgN0xGnCJOkgOE4khmoYR5wEFdreIJCG/sx0e0
         NzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nWbslJ60ZPCanj2HYtzA6ZLWxe4Hhp7nGp3LzxZFt38=;
        b=A1cxUA5eTqrRzZl9zt1Wqd+cBD6Vf0EYi9McL0XXxZxQBsfComlWXL7CixUt54G8TU
         jISm+cKfUcclRjKoH5/PRsdBNozEc4Elgmp6rq8prEOmW4hCrZBL8M6u8zx2nXKx3+Lq
         alcFGvBUPZPIe5Kw7nitG5xw5EYTkI7X1/NH2E4G9hvbIEhd4UgdczjwUDtf9VyxzkVa
         Uzh78TAmZ/3Iz5lVJP5njiOu1MgYMFYb3f4sRiCzmRd/v6D2NWihNzvNaJInDKVMQ5gT
         UWOo7WqC7WgXM6C871i+H6mY5Ykb4IcJ3PpoZrIcw65ztMZUIZrlJ64es+qeOSj2pUtB
         7cHQ==
X-Gm-Message-State: AOAM532pzjDmE16wVc+L3v3LvJADIHCKMWluuqu/wKrLMzmO93+5xmk3
        79ohuJcPewEItgJoekKcSO8QhQ==
X-Google-Smtp-Source: ABdhPJyr75OcvjSZSdThMZRuLnUhVC6TaRHanJoEKMxWRqcV4KBA3sK7U08wDtERoltIKWx03tuShA==
X-Received: by 2002:a17:90a:5b:: with SMTP id 27mr4084014pjb.148.1636593907401;
        Wed, 10 Nov 2021 17:25:07 -0800 (PST)
Received: from localhost ([223.226.77.81])
        by smtp.gmail.com with ESMTPSA id h134sm823053pfe.67.2021.11.10.17.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 17:25:06 -0800 (PST)
Date:   Thu, 11 Nov 2021 06:55:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: Fix exposed stack contents
Message-ID: <20211111012503.rmz2kvcdzmht5rnw@vireshk-i7>
References: <20211110152745.1868099-1-vladimir.zapolskiy@linaro.org>
 <YYvn1CJBrWprEKCD@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYvn1CJBrWprEKCD@ripper>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-11-21, 07:40, Bjorn Andersson wrote:
> On Wed 10 Nov 07:27 PST 2021, Vladimir Zapolskiy wrote:
> 
> > On irq request it is improper to pass its designated name, which is
> > allocated on stack, because the irq name string is not copied, thus
> > there is a risk of leaking partial stack contents to userspace.
> > 
> > Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
> > Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> 
> This was already proposed and reviewed at:
> 
> https://lore.kernel.org/all/20210901084732.943248-1-ardb@kernel.org/
> 
> Could Ard's patch please be picked up by the maintainers, preferably
> with above Fixes added, so we get this backported onto v5.15 stable...

It never reached any of the PM guys unfortunately.

Ard, can you please repost it again ?

-- 
viresh
