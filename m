Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775C029315A
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 00:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388229AbgJSWkC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 18:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgJSWkB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 18:40:01 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C62EC0613CE;
        Mon, 19 Oct 2020 15:40:00 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b1so1920412lfp.11;
        Mon, 19 Oct 2020 15:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rZp4itAJz8aEdqmJauni1XP9ot/pmBFocBopP+DQNbI=;
        b=PmrjE89voAP6Q7skyHT7DnQ3/Q0kESjOJXSXQYXLOjLcouxJhA9CZrdJmJe+AvKant
         5UjDEk4/OW9F5aoaahlU7UO6PVjz7MWCV07+Ap20Qb2er2IEd9VARCo5JLolbj71JqDZ
         BhfCFcNscITIYKeqFh5r5M2qe5iZFIRwm3Yuw7Tm9zkUD9rnPkU8af/a0nfCz0qfd8IJ
         RUsWxUfLe5pdE2YsNkL2XgNPgyPcvOQXIOnKB0yuQK+SnNJSDHS8K+96dADiFxdpQ8PX
         liDTqF0xzUmnTioXR7iiZQPMSkZmfnXLO/ZEzk4XY8MofSXDKfK+jNu9Ad2Bpy4BiWBt
         5aWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rZp4itAJz8aEdqmJauni1XP9ot/pmBFocBopP+DQNbI=;
        b=DylXiRVfzAu/oG+KoMQhb4vxXCsUgOV27FFsaX0l/TAGCB57p4UusYcTO0NYXH3Kbn
         R1D4Rf9u6rO3kzxAaS7WfrimgYxphBA2kuM5VzO4Z5itDEMuzc+5fZpjkhJcwTLOGPKI
         fUAuL5GXMVMRtE2TBhueFfeV8QHQF7PlmUiRnHtCfS/e+w53Z2A4hMl1yY2rZuKYHxwd
         CelILTUxL3Qw9wK37fWVBEti1jqWemAJbnVlAXQEbGr4IMbKam/p9uUxW+kPmVm2aQNT
         AZwNXJSmLq852cqg/BNnVp8PgSIjZpGQTUUEOAzmBfKdR/+KbreiBVLNSOzjscuQmCJo
         GoMw==
X-Gm-Message-State: AOAM530Q4UkSEB8cRTyWeLlQkC77uufV6cPpE+gQ3BbllEJ4vuuOAGvf
        7HGxRjwZ5o1NkyLcYYJHNOg=
X-Google-Smtp-Source: ABdhPJwOdn6hxkyk5CuoGoi1IrNy/FXi/wBwkWM3vILY7vzYJ9dHYIFrL45tykSeqkfW4kdDHUnk7g==
X-Received: by 2002:a19:2355:: with SMTP id j82mr557878lfj.36.1603147198583;
        Mon, 19 Oct 2020 15:39:58 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id o17sm192940lfb.55.2020.10.19.15.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 15:39:57 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] PM / devfreq: Add governor feature flag
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
References: <20201007050703.20759-1-cw00.choi@samsung.com>
 <CGME20201007045340epcas1p4e63955385b1841f44e7a07e2d5d962c4@epcas1p4.samsung.com>
 <20201007050703.20759-2-cw00.choi@samsung.com>
 <83b952ab-a25e-8984-8804-1dd990eec835@gmail.com>
 <9267f046-1adc-b43d-51ef-2e0ad41dc322@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0d3d20f1-6a23-27c2-1a9d-1c7ac60ce1e7@gmail.com>
Date:   Tue, 20 Oct 2020 01:39:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9267f046-1adc-b43d-51ef-2e0ad41dc322@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

19.10.2020 06:53, Chanwoo Choi пишет:
...
>>> +	const u64 flag;
>> A plural form of flag(s) is more common, IMO.
> 
> When need to add more feature flag, I prefer to add
> the definition instead of changing the structure.
> I think it is better.

I meant to rename the new member "flag" to "flags".
