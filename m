Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56FC436662
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 17:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhJUPiI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 11:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbhJUPiI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 11:38:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A8CC061764
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 08:35:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s19so181961wra.2
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 08:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cRpGK/g49wxUwOFNFNgC1ZpXjc7zVeRaaLHFmakaj88=;
        b=W94qybwxYPxtDxHiuP9gh7wyoSMVyCjlahEoNHUkbqsWm2tMOZgeGwngLOp+QrI+NF
         kGqBklujx44Q4mkzUzqy7/II27WAmY+zch/dx+cAqUVuIf0olBqJNlo3JG9dduuUlb3n
         6RksA6tfJycp2jz1M1h54iSy3llxdieAkyHuqKx4I2sV48Dh9TXjcIeYmUxEKw/co/Il
         O4G8pYn/zArV1KAB13DWa93Asy/75VRxn5EXqheKJ+6LZOqCEfSX3SuMGekH+dGljVXe
         XziB9Jv736gtq+0zpqENqkKbrz/nnAzoH6h5LstpjKb7o2ayEAefOmeUnpJtER5/pV8l
         mcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cRpGK/g49wxUwOFNFNgC1ZpXjc7zVeRaaLHFmakaj88=;
        b=S4NQocV7I7fHRL+6ximObL7zXQIt+tgz/Obyfyp0INta97mhGUgoX1pmhu7KN8Kwum
         0cO8bMVbQ3ET6u+oHkbWWOHh30VL2hp2wwy907cncF1aW90u/Q3ENJdBM0uyqm4e/T0j
         D79lzqDO8FPUwMOLnvsPKiiY+lUedy5cpAlRayE/w+VaFF19TsEfNakI6PaXdPCU17vI
         v8MYJ7o6PeEJ+NO4mgK/pf8Thna1xSQsoxljkLY4stpxJwnCT6J1HaGux4VLbj3UMBb3
         lMN0hH84KoETio9ZXz6nkjMhBC24E7Z4PaV8XRF6zKDiZzsbk2zJRTT9VQ58342Oh/+b
         Y8Wg==
X-Gm-Message-State: AOAM530U0NXiQNgMeWi1a0Kt4dJdhAmtf7Z/e8C4DbzOpDoB2a8qf5dF
        fdJne0uGZATSY3pGIhgkRx5YmQ==
X-Google-Smtp-Source: ABdhPJy3AUkdmWTo1rqIT3WvF9MkIasrd9aA5kpDPlr48ELb0jtDtWR2JY9fEa7BhBOJx7MUhUVO6A==
X-Received: by 2002:adf:bb88:: with SMTP id q8mr8178064wrg.390.1634830550013;
        Thu, 21 Oct 2021 08:35:50 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:4116:c86c:e3ac:c3c0? ([2a01:e34:ed2f:f020:4116:c86c:e3ac:c3c0])
        by smtp.googlemail.com with ESMTPSA id k17sm9376830wmj.0.2021.10.21.08.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 08:35:49 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] thermal/core: Make the userspace governor
 deprecated
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
References: <20211019163506.2831454-1-daniel.lezcano@linaro.org>
 <6372f16d-7d2d-cb1e-be86-23b21b41816b@linaro.org>
 <942b9998-9858-7776-97b7-b5ac1c637a2e@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <85afffa8-ec50-1278-74ed-9baf5aa642d6@linaro.org>
Date:   Thu, 21 Oct 2021 17:35:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <942b9998-9858-7776-97b7-b5ac1c637a2e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/10/2021 17:30, Lukasz Luba wrote:


[ ... ]

>>
> 
> 
> You can add:
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> 

Thanks Lukasz


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
