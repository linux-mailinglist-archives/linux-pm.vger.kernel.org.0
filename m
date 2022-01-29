Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7F54A31BF
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jan 2022 21:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346299AbiA2UHA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 Jan 2022 15:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243982AbiA2UHA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 Jan 2022 15:07:00 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90296C061714
        for <linux-pm@vger.kernel.org>; Sat, 29 Jan 2022 12:06:59 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k6-20020a05600c1c8600b003524656034cso3483813wms.2
        for <linux-pm@vger.kernel.org>; Sat, 29 Jan 2022 12:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S51O7i9lXG7bN9afK9GQn6FtCRWvzVPVNhY8VS6CT3c=;
        b=LZbqyWLQbndc+d1Z7o5jmL3/kT1nBaFoQ8IL3tsadvkKreBIu2kpcWK/g2AmsEB/Jw
         Zn6BDDapH7Yb3uB8Xcj+/op8xAZ/EeZ3ZANpUh4qlXdd1pdiGykTZvdJWOiwLvA2zfqS
         Wm+o8gB5ylo4qlCuBWBRzouJb0TbX8mxxYv/X7vfMcuA/aPwJQ3DUK3causnOZ8P6KBe
         w7dxaT+0zmZCXQSE/qHiRr3+GLSbAxuewvQRUBi5ez/st0h8X22x4A1XkrWtKibxaWmM
         FdVhYqBQw9TDw9TVfajzMoXub9v4fFUkwctJ7sahaEJy0mPh3cOVqYSVKly2+TQOL5Gd
         qJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S51O7i9lXG7bN9afK9GQn6FtCRWvzVPVNhY8VS6CT3c=;
        b=ihMPo3atztdlYU5uTR2s2nRHJ2iI9YwPcDP4Ayrp9nZIAdBxJJOvPDAIIOktOgoBkk
         OgTMhU9Aas8XemjgjWYxHi8WvfSOlBAOINwlnWMjXKu3by6IohInv/uO5W48AQv9p1t7
         zNfNsj+IWh654eUUFvWEC1x1M7Upo6xlXIahmkgkku6bNsHrht1aZJdhbrnPxf9URSsf
         D1TyhVFVKW7iwFyxz4i3sYVsg1+y/5J4VdgYymEoGzG9tNbzfy0ywzjX1g0sxH3KjNWJ
         8AouBBFaD7R1ELv9cUJbODFyucadF7M1RfcxZEV4gQaLGemzrOz8/mOvDLuEB4pfja06
         x77g==
X-Gm-Message-State: AOAM5333z3+P3wyhvWIevbJde94/E+w6vxWhsaFzoQktaTuFdT4ilfhf
        FpzTq2KPbD2YETDz92Cm/TzM4Q==
X-Google-Smtp-Source: ABdhPJzkjd4N/OmSdj/wA8yEM1j/6676LvYD5iELsVlVvGibDqSEeYYv0jaEwt/VlEy+aYjqlZ2O4A==
X-Received: by 2002:a05:600c:3d0b:: with SMTP id bh11mr12249921wmb.24.1643486817374;
        Sat, 29 Jan 2022 12:06:57 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:88a4:8c58:a63:ad53? ([2a01:e34:ed2f:f020:88a4:8c58:a63:ad53])
        by smtp.googlemail.com with ESMTPSA id m4sm5010873wmc.1.2022.01.29.12.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jan 2022 12:06:56 -0800 (PST)
Message-ID: <0918ba01-6ab0-fba5-fd65-9a027159c2f0@linaro.org>
Date:   Sat, 29 Jan 2022 21:06:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] thermal/drivers/tsens: register thermal zones as hwmon
 sensors
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20220129180750.1882310-1-dmitry.baryshkov@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220129180750.1882310-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/01/2022 19:07, Dmitry Baryshkov wrote:
> Register thermal zones as hwmon sensors to let userspace read
> CPU temperatures using standard hwmon interface.
> 
> Acked-by: Amit Kucheria <amitk@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
