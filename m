Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC612AB17C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 07:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgKIG6l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 01:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKIG6l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 01:58:41 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8E5C0613D3
        for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2020 22:58:41 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f18so1839804pgi.8
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2020 22:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2m8+zrjrEqIAdz7ru4iFegmvw0HBGZhyRWa9kU3n9ac=;
        b=j4bgt8ZPiyFYAstlaw2H3AO9CW/Lqa+F4KKiN2s0inqCxfxSJQarTfHBVGlOMAOTEA
         MV1FSBH1cUgIeZL51laSQKpr7EXW32f2p8Fo66uWSi9ErUFd0TV/XQqQFQvBlbusvAdf
         NPtRC2XjcOn3MrcdZhO6NhXpJYkMvcAYifzoLtn3kREK7bSWhgdrRv7sfybzLjP1crER
         /fddalax0aIc5hcBDH47mtUHX2QzYazuzHBScfrAcPAIfoDVoEEW1KR74tQek+PZ3VOt
         JeiigLBjYI67Dr5RAG/rsQZ8bm6e36R5ussthERMlnTrcIdspyn1OwpBrBRv3S3BIBIl
         WITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2m8+zrjrEqIAdz7ru4iFegmvw0HBGZhyRWa9kU3n9ac=;
        b=adm2HitR4wbY/9pP3OQj65IbJqpt5BNbniBvu63NBSI0F4s4mFZ8eSOrsqfRId3UG5
         agI0IL2DGY2RmAtqwW/TeNiBlkMHMgC8eHZ8+/QjtpaRIqnqk6f9dLvXFt1kbyiFU2kz
         klD0A7ndd/f7saGNH9pWclC+34JM97//ZB+krKwe+bDBVu1gl2ZQW1BdpVv/yPPWHn1A
         7d7+Jj30zngmhAYtVbkDasNLyk4lZceQuVIs4p07+F6kJBKCXn2K4nyh9QWgdKwA1uR+
         1t9rqAWKOF7Pq/0/aoqBfKvXgpo+4cC8E9DTiFbwU9IKCqk6kfWenKlZpTdkmpAgnMPN
         3j6w==
X-Gm-Message-State: AOAM5317z+kQYAx1xT8QO+HzMrlog6MB0vZ4hP1J+3XxTwhSJukqqwaD
        WCriS9uHV71SV8Fa1CYia9f6Ew==
X-Google-Smtp-Source: ABdhPJyMlIcB+i2+e0Cq91DtTvjHI7oKbKtjB9O82fkoKSZdp7bADUbNT8k4pkKJg+exgv2q+9/sJQ==
X-Received: by 2002:a63:5146:: with SMTP id r6mr12066092pgl.212.1604905120975;
        Sun, 08 Nov 2020 22:58:40 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id gf17sm10582972pjb.15.2020.11.08.22.58.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 22:58:40 -0800 (PST)
Date:   Mon, 9 Nov 2020 12:28:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, sudeep.holla@arm.com,
        morten.rasmussen@arm.com, jeremy.linton@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] cppc_cpufreq: fix misspelling, code style and
 readability issues
Message-ID: <20201109065838.xja23gzvy7ku2rvl@vireshk-i7>
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
 <20201105125524.4409-2-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105125524.4409-2-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-11-20, 12:55, Ionela Voinescu wrote:
> Fix a few trivial issues in the cppc_cpufreq driver:
> 
>  - indentation of function arguments
>  - consistent use of tabs (vs space) in defines
>  - spelling: s/Offest/Offset, s/trasition/transition
>  - order of local variables, from long pointers to structures to
>    short ret and i (index) variables, to improve readability
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
