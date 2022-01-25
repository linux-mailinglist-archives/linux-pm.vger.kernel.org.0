Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB2D49BAAE
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jan 2022 18:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350304AbiAYRy1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jan 2022 12:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354958AbiAYRxr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jan 2022 12:53:47 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F70C06173D
        for <linux-pm@vger.kernel.org>; Tue, 25 Jan 2022 09:53:47 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f202-20020a1c1fd3000000b0034dd403f4fbso2435765wmf.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Jan 2022 09:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WhuuXHFJMAbuaVPhoPEVC9jC8MwTp/NZVNJewIORlvs=;
        b=s3f1D54qdscWFEa7Uoi1oq7p/IHQBan8WXzRVkwdC8LEd67XsDDVCsaS2odDT/CbrY
         HuWl367BDVbn0OO6TYjeOLvgyX01GmtwLNdcIPKFhb7bYw8vC8/fq0FHqY6QXPxblrd/
         LxdpSW3E8zlTJclOULBkl6pTkBURLvDizTL8FaqIDeicfL3xNNdWecHle8vALKS+FT3p
         f0H48TOa/ZZOW/8Wxch1S6Nnelnp56hxxlfndFU+0zQ8nea4Fcgv8UsuXdMPnfvj64V0
         L2BunarPltl/xo9Sw/FuMhVle3ul7oWh1VZ95t8g5dTenCaMpmuXBjK7nwBfDon4WZzZ
         pPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WhuuXHFJMAbuaVPhoPEVC9jC8MwTp/NZVNJewIORlvs=;
        b=EqwdJR4m4FUzD9S202WkoDml5j4yeuaaBP1U+s63JmFuwCPNA83w7osiZMkIphlHiG
         IZuq6sYCDot6GoLLO0IPAn2/Us3wIrQd2x0l9Ggt4pXGWyzLZ42zUEVvHkESSMiAnCrZ
         Sx3F3RS3nPFraYjGNjn6QHE1zFkrZzMaV7t+ruW7BUuYHtexmICAaOa68HaCKR1tEYNX
         /xSYKSLw4TEl+hBnqSyrKW9JSlaqEU0ek/8L5OHvnJfXhfR5fEt6PkW4Ndchsv7WX5v/
         I6bQGN9DnZBivqQBn7MY9D4HCOfcx/SglZM3fkHv30Tbq5tgMzs33MOahgkP5yBbUjcU
         8vCA==
X-Gm-Message-State: AOAM530ulW0sKM0dEjF4qAcmV5Cqzh/rdo6OrYZpX0RWdtcoBILAhqUW
        pRnO05X+wzrtHdaFwj0xlMFrDA==
X-Google-Smtp-Source: ABdhPJwAqzkVTq3dZH0KhhRlUciAuK1eBUyi+58WhWOwf5b5Hm5NrjMDK3e6xDBrBvAe6Taq9I34Og==
X-Received: by 2002:a05:600c:5028:: with SMTP id n40mr3901446wmr.10.1643133225573;
        Tue, 25 Jan 2022 09:53:45 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:f589:cf7d:b2ee:bb5e? ([2a01:e34:ed2f:f020:f589:cf7d:b2ee:bb5e])
        by smtp.googlemail.com with ESMTPSA id b2sm8476521wri.88.2022.01.25.09.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 09:53:45 -0800 (PST)
Subject: Re: [PATCH v7 2/5] powercap/drivers/dtpm: Add hierarchy creation
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     rjw@rjwysocki.net, robh@kernel.org, lukasz.luba@arm.com,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
References: <20220125171809.1273269-1-daniel.lezcano@linaro.org>
 <20220125171809.1273269-3-daniel.lezcano@linaro.org>
 <CAPDyKFoKCY1sBPA8eDxZPqSmaPBWeJix=A2b_Z7fBsn-CD-4DQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cc6b66f1-c918-041e-9965-07a417a31088@linaro.org>
Date:   Tue, 25 Jan 2022 18:53:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoKCY1sBPA8eDxZPqSmaPBWeJix=A2b_Z7fBsn-CD-4DQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/01/2022 18:36, Ulf Hansson wrote:
> On Tue, 25 Jan 2022 at 18:18, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> The DTPM framework is available but without a way to configure it.
>>
>> This change provides a way to create a hierarchy of DTPM node where
>> the power consumption reflects the sum of the children's power
>> consumption.
>>
>> It is up to the platform to specify an array of dtpm nodes where each
>> element has a pointer to its parent, except the top most one. The type
>> of the node gives the indication of which initialization callback to
>> call. At this time, we can create a virtual node, where its purpose is
>> to be a parent in the hierarchy, and a DT node where the name
>> describes its path.
>>
>> In order to ensure a nice self-encapsulation, the DTPM subsys array
>> contains a couple of initialization functions, one to setup the DTPM
>> backend and one to initialize it up. With this approach, the DTPM
>> framework has a very few material to export.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Yes, this looks good to me now. Thanks for adopting my suggestions.


Thanks for your time to review the code


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
