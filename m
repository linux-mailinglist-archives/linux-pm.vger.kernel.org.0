Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9135251F980
	for <lists+linux-pm@lfdr.de>; Mon,  9 May 2022 12:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiEIKRs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 May 2022 06:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiEIKRc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2022 06:17:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2D227F10F
        for <linux-pm@vger.kernel.org>; Mon,  9 May 2022 03:13:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q23so18712007wra.1
        for <linux-pm@vger.kernel.org>; Mon, 09 May 2022 03:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tq0BEJROzPYrK63kwFdEMPK+mCxXEhZo4bFyFZgxjY4=;
        b=xA3bpaZitxaukblKe7pPHGVxUVL0u17rPwPVCiuNkhT4b1rPheAAFo+r4lmzUuzz7p
         tlxxgvhyDUfVYxZvfreqFGtt9NuKXldgaFHWWniXUuhfdC67PwCfOrlSqdbO7HfYIHUF
         GVZV1QDnf1k8ZuQ+FvUEuD7ez504RvaTPaOUnUxVpvIiN8vN/2+E+OLfzGs9IZ2OFKET
         NVwQEVnFHvkyLFwHPzuaRGPImyO22G4lRWv+yVD4664MD/McUVOYUdRkyikG1OFporFM
         gRbRDeVlcIEl2n2uZks+4O90JKDjdDuDUHASJkgpNN7UNgnWaKPjIDiBvyjEROxsPVUx
         FmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tq0BEJROzPYrK63kwFdEMPK+mCxXEhZo4bFyFZgxjY4=;
        b=0McJl37ZFsfajVbbamJ2bL75IeiptO51Lymf6f3KkRg5L8IYPSItqR1WbwIjUMGwq/
         OEzp3K61RXSk/jgjcqsjloRlWmiISE9CzYIq4A44YMlU9TernG2RAg6f0pAPYG7diwOI
         ogW9CbTzUplhGKNm1wOGDBBhviepu6UxBCBv8vQe9FUDc7Bbmz4d3avSvRj+E1sEFhOi
         jX1Mu0EKcIth2R/9h2FvE0MqEs0JqBJA2fx0ASL3XyriQWx4Gd5McBZleZDc+VviFak3
         fXZ8X/HA6AXX+qN/+kdfc22phBZvncQFPZV0PnZV4A5VdAaVEt3krbMRPE8646YJAgwh
         cRkA==
X-Gm-Message-State: AOAM531LqkY/5FT5R26doxj2rPMrbc89f6KKBVvS3UQQSnrBr8FbGHgY
        tgT5UeVlVQjXpYDgffqNz37UBA==
X-Google-Smtp-Source: ABdhPJyCDtgYQEAwPqDb+f8pxSE067bgs+2qFMmq4lJGnDdiQQRFR0FRGKbv/iNTXhgLVKk3zY1cHg==
X-Received: by 2002:adf:facc:0:b0:20c:7ba6:f3bc with SMTP id a12-20020adffacc000000b0020c7ba6f3bcmr13032538wrs.54.1652091098550;
        Mon, 09 May 2022 03:11:38 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id d6-20020adfa346000000b0020c5253d8d5sm10811791wrb.33.2022.05.09.03.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 03:11:37 -0700 (PDT)
Message-ID: <fbb1f5df-952c-57a3-3480-a6239afde1a3@linaro.org>
Date:   Mon, 9 May 2022 12:11:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] tools/lib/thermal: Remove unneeded semicolon
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1651801694-23311-1-git-send-email-baihaowen@meizu.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1651801694-23311-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/05/2022 03:48, Haowen Bai wrote:
> Fixes coccicheck warning:
> 
> tools/lib/thermal/commands.c:215:2-3: Unneeded semicolon
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
