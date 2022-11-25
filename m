Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51852639073
	for <lists+linux-pm@lfdr.de>; Fri, 25 Nov 2022 21:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiKYUAg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Nov 2022 15:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiKYUAf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Nov 2022 15:00:35 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2122EF02
        for <linux-pm@vger.kernel.org>; Fri, 25 Nov 2022 12:00:33 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id b29so4956671pfp.13
        for <linux-pm@vger.kernel.org>; Fri, 25 Nov 2022 12:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5OTzkH3CdtgMvkxSL/SyGfXxDbvuq+njYGlJM/u4onY=;
        b=WjZPrJ3lgchjf9mb8TbsCGA1p6hY2q8P2C9C9cUZpHEoh+x/eklawszc1NLq4d5cB/
         UgxQnrSu7U74Yb5HsnjZbdiJVNSgZFGsR0nXbys3Ejh+r+7dkAN6/l/QsEPTaTq+mKbV
         dwTTdUuMf4OXHcYtNFSAfvJ1Ddq/cv4JmeXAzwLah2n+m48iGfvjeKq50hDNo21UMqxA
         DaQ7c6vQHGnbuT+4uT8BlT97zWU9p0TPxjLgUS5QFXTY+fn59uO1Yarsu4l596GILP+i
         cO2At/Y3mZnuQjBLJdNbye2OiF3TLbISYV21lF+13FAFVES2zMx+KElzq88K0TKDRGxG
         QFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5OTzkH3CdtgMvkxSL/SyGfXxDbvuq+njYGlJM/u4onY=;
        b=aOktF0o8NQh7K/GjQUStGn/lyCVDKZZijDirS620rWOGUlobUWyCXefWJzFCOlS3EB
         ixw8g6InDPFxCUwB6MLg3o2g90qypBgBFv/lupdQDGVUFAeJAxQnMGLsyoKIw04qxMTM
         klaWZM+L8t5LyinxvkVDVTxm3lKZwhxkV5rH8RG77LOB0V6bmvVs202OhCjdKUh5ZXCT
         hYYvI9I8m+o66fX5tGQNlaAmGaC10zEa1wa8gVS824CBgpl4Kqnv11DwJTuFb0TsB0EA
         3/DrvLCPVBBYLCWftivfZXT9bmfA84rRY5B6+yD0z2Yf0/0umUZVt2NCtDcnvLplOs9U
         cdQw==
X-Gm-Message-State: ANoB5pkPT6Ekag/kX1zsQK7Upc5pzhDWMI5a0usrbk34xaqDr5jJQ7Fg
        OGKwmm5q/HqKr+x3L/7AYIsb6H0hnSWVhg==
X-Google-Smtp-Source: AA0mqf5U35aZ0d9BkDlXhYRv/DVhcOtmFKDIgoKi+wypTLliGt/ZKwosItB72t/SFh3oPNMKZjL7AQ==
X-Received: by 2002:a63:134e:0:b0:46e:f011:9563 with SMTP id 14-20020a63134e000000b0046ef0119563mr36694720pgt.451.1669406433184;
        Fri, 25 Nov 2022 12:00:33 -0800 (PST)
Received: from DougS18 (s173-180-45-4.bc.hsia.telus.net. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902a38e00b0018912c37c8fsm640064pla.129.2022.11.25.12.00.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Nov 2022 12:00:32 -0800 (PST)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Kajetan Puchalski'" <kajetan.puchalski@arm.com>
Cc:     <daniel.lezcano@linaro.org>, <lukasz.luba@arm.com>,
        <Dietmar.Eggemann@arm.com>, <yu.chen.surf@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <20221031121314.1381472-1-kajetan.puchalski@arm.com> <20221031121314.1381472-3-kajetan.puchalski@arm.com> <CAJZ5v0hHvf-033Oa-nW7UEZq=9cTFzn6e_znccPXBUeNa=YY+Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0hHvf-033Oa-nW7UEZq=9cTFzn6e_znccPXBUeNa=YY+Q@mail.gmail.com>
Subject: RE: [RFC PATCH v3 2/2] cpuidle: teo: Introduce util-awareness
Date:   Fri, 25 Nov 2022 12:00:32 -0800
Message-ID: <002401d90108$93a831e0$baf895a0$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJ3niu74TkyFjUbsRqSa0N7+FgHagJieOsRAbWVYo2s8hAF8A==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2022.11.25 10:27 Rafael wrote:
> On Mon, Oct 31, 2022 at 1:14 PM Kajetan wrote:

... [delete some] ...

>> +}
>> +
>> /**
>>   * teo_update - Update CPU metrics after wakeup.
>>   * @drv: cpuidle driver containing state data.
>> @@ -303,7 +359,9 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>         int i;
>>
>>         if (dev->last_state_idx >= 0) {
>> -               teo_update(drv, dev);
>> +               /* don't update metrics if the cpu was utilized during the last sleep */
>
> Why?
>
> The metrics are related to idle duration and cpu_data->utilized
> indicates whether or not latency should be reduced.  These are
> different things.
>
> Moreover, this is just one data point and there may not be any direct
> connection between it and the decision made in this particular cycle.

Hi Rafael,

Yes, agreed. And version 4 of this patch set deleted this stuff.
See also my similar feedback, with accompanying test data
that verified the issue in [1].

[1] https://lore.kernel.org/linux-pm/CAAYoRsUgm6KyJCDowGKFVuMwJepnVN8NFEenjd3O-FN7+BETSw@mail.gmail.com/

... Doug


