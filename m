Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F9544DA8F
	for <lists+linux-pm@lfdr.de>; Thu, 11 Nov 2021 17:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhKKQi6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Nov 2021 11:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbhKKQi6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Nov 2021 11:38:58 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCD0C061766
        for <linux-pm@vger.kernel.org>; Thu, 11 Nov 2021 08:36:09 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id b68so6025536pfg.11
        for <linux-pm@vger.kernel.org>; Thu, 11 Nov 2021 08:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LfjMdYTkRtSg9vqoefxU1BZpX0CO1104WkyQpurjrWY=;
        b=WXNvcv8XRto1O+lXQtJsWd0YOaNuqJ/LuV3eNp7Z7t2ZYyqYsvtoxaHh0SGvGISwzP
         9xu/dFAVIEvyVBTYEwgWvt97MKxW0KqNpvOml79QxD/j4pHEHiwggPwZD8dvAPCLAZ7v
         0ma860WdIZOrw531taynzpHpq71Mnq3kBp+Gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LfjMdYTkRtSg9vqoefxU1BZpX0CO1104WkyQpurjrWY=;
        b=Z6BpOEKNDT42t4opHlZK4t9arrvbp5m4ndHTnPiRf6WHvgphzzy++3YijUFnlYg3p0
         eZit5ZqtWLaWml5G8cPWx/pu6PaGWUDRDN6bY1hNhWDpqCAiITU6ddYz91GMdHgZPu9l
         wyE71twEDamamIbuYRWRIeSnWbXNykw9jUgjhjjdba14mJCVXYoYBUnq192TB9KkP/pd
         xXENea/xzG9+MUK82ZyP7lLKPRq7nq2c5HCmwb3yDoreYAsZfPi4gbf0VTKmAqltlrTL
         ZPRMiggqs2oo/FCr1pZDJdk/GUP8CLzy58T/Pip/xdtORzVDSqIB/ftoyUZ1AUZOc/Kj
         cqyg==
X-Gm-Message-State: AOAM5336DgQrrmVYWZ6drBzhVTV4lqCHwUkTZ3Z3+9SynfEHoq7iKvWB
        vlO6VvvaPHGmMq7VwY3E9Cn1Cw==
X-Google-Smtp-Source: ABdhPJyf1ScnuC6QULfERaqTkSjsGJR+nT428EdPFKuVJCeg6JM6CMlZ66KTcnmUC2NJEIiCfnANLg==
X-Received: by 2002:a63:d313:: with SMTP id b19mr5387847pgg.64.1636648568804;
        Thu, 11 Nov 2021 08:36:08 -0800 (PST)
Received: from localhost ([2620:15c:202:201:c0a9:ac53:7829:6af7])
        by smtp.gmail.com with UTF8SMTPSA id v13sm4085560pfu.38.2021.11.11.08.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 08:36:08 -0800 (PST)
Date:   Thu, 11 Nov 2021 08:36:07 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH 1/3][RESEND] cpufreq: qcom-cpufreq-hw: Avoid stack buffer
 for IRQ name
Message-ID: <YY1Gd7qfRRU2UJ6h@google.com>
References: <20211111154808.2024808-1-vladimir.zapolskiy@linaro.org>
 <20211111154808.2024808-2-vladimir.zapolskiy@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211111154808.2024808-2-vladimir.zapolskiy@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 11, 2021 at 05:48:06PM +0200, Vladimir Zapolskiy wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Registering an IRQ requires the string buffer containing the name to
> remain allocated, as the name is not copied into another buffer.
> 
> So let's add a irq_name field to the data struct instead, which is
> guaranteed to have the appropriate lifetime.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
