Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE26D526A4F
	for <lists+linux-pm@lfdr.de>; Fri, 13 May 2022 21:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383844AbiEMTT6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 May 2022 15:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383775AbiEMTTk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2022 15:19:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64013D1FC
        for <linux-pm@vger.kernel.org>; Fri, 13 May 2022 12:18:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id q20so5302115wmq.1
        for <linux-pm@vger.kernel.org>; Fri, 13 May 2022 12:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gDujOzbIDeCaHsVZNAKffxZtCR5xL7ygcQKh+h4OF7Y=;
        b=LnNijsB0QknDitKRfGuaaErmINUc9B567ig6K+O18yY6i6YrGDhJzfzug7Z4SkAUiK
         JeDMiowjklNPdPEIfvCgYpLNOH4fJYbvTsRiHPBc5jrEmHE7Vp3fgLRC8c5LMn3TVzPH
         R5xhdIag1K7CXLsDbyhb20B6arVu4amM8aLqVRzj13iyj9NExFIFTvvPizk1bfQi9Pbh
         5LHrsPlXwb0k2b/KxR8AxKnaOUn+IRaJSqxUNGWAPXagkH1lRH5A22VcT4l/FD4+m2MW
         5BWtzTp/ObmKY5I+Ol/eAj5AL3vmaFAN3KGAiGKPfQBcID7yoPOwvlrl3dwEO0dYrndO
         Bd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gDujOzbIDeCaHsVZNAKffxZtCR5xL7ygcQKh+h4OF7Y=;
        b=EWKZvHV5adt/TlfFdJvkgLVBRhglzXzSQ28nyWFx00FZxiBqZGZBjmt3di2Q+kDLS8
         KJCepdIlQTfzbqrLGH6pY/JQbgljswW7zDPq/LeiY9wbqCKliNcG2HtcJWWGVYJyLmlK
         jXR6qubkap7kHKDwK7q2FYgyFCPm6qRYTpOHB8v1CwEDoppP9bqxpgbAbZoxGgWmEV+7
         Ma6mLoMoheZ225MWq5Wsd9zrAEmuSN554WGvo0MYBedDSeiPd5zJRzEFMBzMPjzMzi23
         S1DLcDzFj7RUAgIarmi4Mzw6Mwl7xPYubTuYp9Qqm4k7gfRgQznVI3YxnVjMPq7ZRDUn
         DvnQ==
X-Gm-Message-State: AOAM533ZwE7WmiNovHC9fJbe1y7Bf/qYHf70Q/X/3qtuTf/Ky6nPddLB
        l4Bxfce5TWSVr33gzgfWTxXvzA==
X-Google-Smtp-Source: ABdhPJx8EtMTRzAKRWkmvlzRJN2AsC1X6f1cXM1fJ4Z0v8MXlZ/qQI9b3zQcelUlxVnScx4mvAuhtA==
X-Received: by 2002:a1c:4e08:0:b0:393:fd06:c2ce with SMTP id g8-20020a1c4e08000000b00393fd06c2cemr6005052wmh.91.1652469507813;
        Fri, 13 May 2022 12:18:27 -0700 (PDT)
Received: from [192.168.1.41] (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id r64-20020a1c2b43000000b003942a244edbsm4387480wmr.32.2022.05.13.12.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 12:18:27 -0700 (PDT)
Message-ID: <295ce9fc-4fdb-7d77-fc75-0f85a408bb09@linaro.org>
Date:   Fri, 13 May 2022 21:18:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 00/14] thermal OF rework
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
 <63f1c4a0-d2c6-8157-5da0-198c2d8d1013@linaro.org>
 <CAJZ5v0iexz36LL52rZ0BTtSXCf63UnU0kMJR7w6Qfe7P5ZmHTA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iexz36LL52rZ0BTtSXCf63UnU0kMJR7w6Qfe7P5ZmHTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/05/2022 19:56, Rafael J. Wysocki wrote:
> On Fri, May 13, 2022 at 7:23 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Rafael,
>>
>> if you are ok with this series, I'll pick it up.
>>
>> Is that ok ?
> 
> Give me some more time to look at it, please.
> 
> I'll respond in the first half of next week.
> 

Sure, no problem


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
