Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CA6274537
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 17:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgIVP1R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 11:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgIVP1R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 11:27:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2312EC0613CF
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2020 08:27:17 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id o5so17520893wrn.13
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2020 08:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=daWCo1RFCRJHeJIJbYudV3s6gpJF4K5dmJezag8Qxqc=;
        b=PQ0Av58MFvLr8hCz6Yr/XxwJJ7Rgqi5vRs6SigDx5kZJM55s9csvPupwqeaTQWbb5z
         TRGOieLlELVhujXUHDOon7IzLBsGs3ni5pwKbtN4mB5zBPYampC9UdWB+vt9L+9B+kA3
         R5vvd2tolQMyPqDvZ3F8UN102erJ643KTs9FuimjTL9q7XVs6EIOZuAzaz6Nhm5enw7s
         9jMD1N9hAov6lVgtCVQx4WoWiHmWIAtsOIkf8+5Z6ycPjYAZHMv10udgKsbxF+JwHDxd
         msuvSW9jl3394JT8quDkK7Mx9/08S7nGKzMTHlj5eIue6YMna08FEjFemZ4KefCcu3Z3
         4Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=daWCo1RFCRJHeJIJbYudV3s6gpJF4K5dmJezag8Qxqc=;
        b=k3j6AeS4S6wc+bKbl13GgLhO/qtVrVAPCFxIdww2Hjb9mP5uD0dZNAJ9OaMJCNvSwQ
         hv+OoxbqPE3TQtsiqPWd99UHTtOgAY0vJ6krvsEQcMnZJwrlZtFO15h/AFTzg1S9i1X9
         Ic9qWGeHHpLdlKLDdU6feUFILb3e3GAgLBUTjJGpIkvhvtad6z/s+S9ZiM+YztMHWjd4
         kjzu0uMfYYVJtMe9hEsoF78qreSxBoaXn1/ENiQ2/olKcUVcdEKGJDwmRM8+eyVsTqW7
         9muzJjrQOIBSrmqOIxJq2d82LKduaFuouUS2vphDEUY5IDrjimG7QmMPrDu6PyqF2KiN
         v96g==
X-Gm-Message-State: AOAM530quHVWDxn0CpHi6WsG7iMnxzKX4R9rKpqum3EWug0IBKNN8PdF
        ZZbP0dceYSHynI+oPcLpgoCvQQ==
X-Google-Smtp-Source: ABdhPJxIF3wfnvfDxTeIOMmGPLFmN7hQs1E4eU47akeBeJuybRbsqN+aPPzVy9tpPtD1sT/n/nNwzQ==
X-Received: by 2002:a5d:4a0c:: with SMTP id m12mr6017594wrq.83.1600788434458;
        Tue, 22 Sep 2020 08:27:14 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:2047:2ab9:c10c:f4f? ([2a01:e34:ed2f:f020:2047:2ab9:c10c:f4f])
        by smtp.googlemail.com with ESMTPSA id f6sm27290103wro.5.2020.09.22.08.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 08:27:13 -0700 (PDT)
Subject: Re: [PATCH -next] thermal: core: remove unnecessary mutex_init()
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200916062139.191233-1-miaoqinglang@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6c4c2d70-e901-74e4-185a-8f8bb105f03b@linaro.org>
Date:   Tue, 22 Sep 2020 17:27:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200916062139.191233-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/09/2020 08:21, Qinglang Miao wrote:
> The mutex poweroff_lock is initialized statically. It is
> unnecessary to initialize by mutex_init().
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
