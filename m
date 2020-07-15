Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A0A220569
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 08:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgGOGu2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 02:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgGOGu2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 02:50:28 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E718AC061755
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 23:50:27 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so1190835wru.6
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 23:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QXxsUHXZZVvciOYyph5eTHTPiBdhp1mxQINCgx07QDQ=;
        b=ewtG6vxm01w1JIzwzDhJdWMLY/+0V92Fc+vPbVOWwVLQVkslmUoLcL1Q8LeomG+CtR
         lOjTr8zoJfC9wW+HSs2BUP+ScSBz/0tOMxYmpWrbBv+p30nzUHA2ouD1poHBzLD81qS7
         9k63lSwHfwqri3RB/ciA/vA6RgoqsiHFx1eLccJERN+dKZGkovOaqeDli5iEXdPUIXaF
         Woql8b1SpBHKHEhDUERvRnfzKOriQMmrLbPgjF2eXFYfU4LUylJ07vBNUh7NC82RZOV/
         9t6O9ObqTCJYqjiqDWoApz0crtbiiPo8c0jLFnODN5He91Iftt0YwxHDwvl9RPlEU5k0
         I54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QXxsUHXZZVvciOYyph5eTHTPiBdhp1mxQINCgx07QDQ=;
        b=dE9MzAt5YpKyUWy1K4L9CUsp/cHnf/2xMYGEqcvG+Lrcy9Tm3Qa05jNYD/ghjdfusD
         +g1YzPKByW8acFBLWseSPhoTif0L2GT4fbHdfjoH6UFnyhuqC+3ZioFsXFWqqOFvMb/x
         6G+NW0oCfIkef1piKNS+g5Zb8LTDIsmfIt5hp3t1WCWJaXAwY26XbRKaGoV3kINDv9Uh
         9Gcu0BO2/FKqazbPBkohQcRvx8DSy66QiPjazayUZE6ntn4BSe/koBk/c6Er7HYzGpT7
         2S7u38Zrd9nazJFO8bzeDYKvd88z+VcThvfOZ+DW2y7S+mBP5AigHaazjBiMzNw5+dg+
         /B0g==
X-Gm-Message-State: AOAM531ap1vU6rQ1EVkuDYReV/Al7IGYCTFPPmsg/utVw/org/5NTHBf
        tnmKh/jW4RrUKv3niEjcGT64nA==
X-Google-Smtp-Source: ABdhPJxVnyrCBXXko1nLLezo1Q5D+MxGRXdY9bVywIB6NcrXeSsJKk6xydd+B2XaLMoM15IQEvYvRw==
X-Received: by 2002:adf:ea4f:: with SMTP id j15mr9681935wrn.253.1594795826684;
        Tue, 14 Jul 2020 23:50:26 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm2010537wrq.13.2020.07.14.23.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 23:50:25 -0700 (PDT)
Date:   Wed, 15 Jul 2020 07:50:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH -next] cpufreq: powernv: Make some symbols static
Message-ID: <20200715065024.GV1398296@dell>
References: <20200714142355.29819-1-weiyongjun1@huawei.com>
 <20200715034125.6x37w3csqmnia2jg@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715034125.6x37w3csqmnia2jg@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Jul 2020, Viresh Kumar wrote:

> On 14-07-20, 22:23, Wei Yongjun wrote:
> > The sparse tool complains as follows:
> > 
> > drivers/cpufreq/powernv-cpufreq.c:88:1: warning:
> >  symbol 'pstate_revmap' was not declared. Should it be static?
> > drivers/cpufreq/powernv-cpufreq.c:383:18: warning:
> >  symbol 'cpufreq_freq_attr_cpuinfo_nominal_freq' was not declared. Should it be static?
> > drivers/cpufreq/powernv-cpufreq.c:669:6: warning:
> >  symbol 'gpstate_timer_handler' was not declared. Should it be static?
> > drivers/cpufreq/powernv-cpufreq.c:902:6: warning:
> >  symbol 'powernv_cpufreq_work_fn' was not declared. Should it be static?
> > 
> > Those symbols are not used outside of this file, so mark
> > them static.
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >  drivers/cpufreq/powernv-cpufreq.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Lee also sent a fix for this, but yours look complete :)
> 
> https://lore.kernel.org/lkml/20200714145049.2496163-7-lee.jones@linaro.org/
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Yes, looks good to me.

Reviewed-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
