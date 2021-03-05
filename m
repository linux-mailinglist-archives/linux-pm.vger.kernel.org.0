Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5691B32E4DE
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 10:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhCEJce (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 04:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhCEJc1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Mar 2021 04:32:27 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B47C061756
        for <linux-pm@vger.kernel.org>; Fri,  5 Mar 2021 01:32:27 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id kx1so1509545pjb.3
        for <linux-pm@vger.kernel.org>; Fri, 05 Mar 2021 01:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sRn3+ObPWQ3XHzCtNgjJ8LM3MKdEUsxY3s2mSMEAkJU=;
        b=RhgILeOmKshzKZL6xwNVmNjn1MpgVg4J/UFT930UFUIDLb+43QHI/fC8eKb6l+ANYi
         X7ZzIQxWpO5c35SUGOkn9Zu2QAycaw9NDi9j7sOORhlXVkIF9L6UyuyEX3YG2u1bfEji
         GTYlaHlP6DdZIIpj5zgT/7oB+1vnrU3Xy9v5nPyGdXsmj+FSrUTW6hvvqKL+jyIF4xrq
         5zbGH14tLWb/loSKbf0g/M5+FEg2C5t4B4/6IPz8PVa3EL/P3Jwcu7CTzZeMDXHUedXO
         Ci4EQPPNjrcJ/JkU4oFUzu2kpPitXLjCOxKZrSF5Trz0LFxkKkx5hqurql6D8QPZJytn
         CgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sRn3+ObPWQ3XHzCtNgjJ8LM3MKdEUsxY3s2mSMEAkJU=;
        b=gZJzmQFJONQYDZN/+9okZBdGSRjs651YLBgZwhCR/GjiGVoMgCijvH9vWfVF5Adk0z
         5UlZX6FYQ1qs0gZt4rJPykTY+quTJezuN/sQ5PrCwD3YeqPeeZDRj/dW3bStYwYZMNye
         u5ydq1kpKT+GrbP2W856Rh7tKv5vtI2Z4DRuqdS02SAy1Lr2oki1byO8IAGXtq3NSenc
         mW717bJdQNxdx7FAQs5sJsaGD5EqSlOBjWJBALYP3MV5M5i6f1hybV1WIGHBv/XfNz++
         6m0/5yg8C+oKkO8TP1BL9yAd5cpgWmsRSEE/d0ZeekWGmfca+UDTcO5gzZYvOW/CxcJS
         yHAw==
X-Gm-Message-State: AOAM53132KwvxzG1YsQBDMOM0V8XDFxf577dHIoXAF29rS8Ibk+iF3vE
        Z+F0TuVsrC52LfOCnBYqnyu1jA==
X-Google-Smtp-Source: ABdhPJyh4dbRFq47HOzJoSaVBh1JlCrEIB3ikSx3vl1RRjsQjPJa6s3qonpiQ7ediOp31RJpcfITmA==
X-Received: by 2002:a17:902:e20c:b029:e4:7a08:8452 with SMTP id u12-20020a170902e20cb02900e47a088452mr8167977plb.74.1614936747144;
        Fri, 05 Mar 2021 01:32:27 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id f6sm2013235pfk.11.2021.03.05.01.32.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Mar 2021 01:32:26 -0800 (PST)
Date:   Fri, 5 Mar 2021 15:02:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     'Wei Yongjun <weiyongjun1@huawei.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pm@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] cpufreq: qcom-hw: Fix return value check in
 qcom_cpufreq_hw_cpu_init()
Message-ID: <20210305093223.xiws4crr6iswi4t3@vireshk-i7>
References: <20210304100423.3856265-1-weiyongjun1@huawei.com>
 <CAAQ0ZWToj9Fq5bRce-f+JUnO6iPPdJEU=P9n5k+-zmyUfKPE_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAQ0ZWToj9Fq5bRce-f+JUnO6iPPdJEU=P9n5k+-zmyUfKPE_w@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-03-21, 18:42, Shawn Guo wrote:
> On Thu, Mar 4, 2021 at 5:55 PM 'Wei Yongjun <weiyongjun1@huawei.com> wrote:
> >
> > From: Wei Yongjun <weiyongjun1@huawei.com>
> >
> > In case of error, the function ioremap() returns NULL pointer
> > not ERR_PTR(). The IS_ERR() test in the return value check
> > should be replaced with NULL test.
> >
> > Fixes: 67fc209b527d ("cpufreq: qcom-hw: drop devm_xxx() calls from init/exit hooks")
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Applied. Thanks.

-- 
viresh
