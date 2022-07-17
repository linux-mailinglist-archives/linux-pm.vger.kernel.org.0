Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05D55774DC
	for <lists+linux-pm@lfdr.de>; Sun, 17 Jul 2022 09:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiGQHGP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jul 2022 03:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiGQHGP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jul 2022 03:06:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CEE10FC4
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 00:06:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j1so8185600wrs.4
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 00:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DpXvb+159lHHY+DSPGureqUWpwkD7K36EBaSI7Y/StY=;
        b=CAZi4fYzdEpbAfBvFdSM5vTE//uBenSfFAkP7lDLsNxOhSQb9l+XqzJtxBUkdVBjYy
         juZ579GH2WsP/qtEa67jSOR5E5hdYOXiszbdP9v0pfSy6CTgbX2Dd5jVSbQZAxnhaUMj
         kh438yUhx1gGEdl6DRreIvRS/pwukV4mW+yTam5ZFo5wu8kuzKNRW5uEJMpxO/OF8/JV
         t0DpISR3VM0k3Am+3SntbgXrfz58TiEADsVey+EoWd6SRZ0VU/cwqccN+fgPYDjzFRoq
         dheJgNOgcVTvKFHIAEFRNkysPPduo5JNv9G4ZFJI1ypIzi5wEf6J+d36j20v7VlujnAk
         qulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DpXvb+159lHHY+DSPGureqUWpwkD7K36EBaSI7Y/StY=;
        b=XhbGCHMiCbzS2V7wwi/4Wal78FqnPF5ohlLJMVIjVbv8UFaattaa1vqYycLnsh90E0
         aaY3NqKzSARaEalWQcdzIR9rERIbJPAKcpAisAaIXh0MBPQzNiPiJmpXMtwB3vwxWXOe
         Mowd+NcyKYHkggYVMqHOWSGC/5R5v+PtbT473MksSXNoIE/x6HsP9sWemNajJHAVxB8H
         FyJvUmFp9SsCzZPHnL5nw7upY4kqIPrBTHgu2KmwMhSphP9+pMPMUGAlo+cT5qPwNQCg
         Ni8ylfjsTBYEbjGFPr4Px/e7mUzSB1GAvn69abxE/AKOlADoxMAxMiVCUjRHqiJ+NVRO
         065Q==
X-Gm-Message-State: AJIora81ECHmfp7VjQyjdFciciJVsF2gqVxsaU2jhKa6Qxq8bC1ZDDJu
        Erx+sYmNhbPWk7gslCjwGNGK8olEKTFPmA==
X-Google-Smtp-Source: AGRyM1s/fmAk7a9lUun+xsUg0xaF+6mVSfcv67EYEoEQaVSEModqrDt5FOM5a19BAjGJB/qr20mlTQ==
X-Received: by 2002:a5d:4806:0:b0:21d:66a2:5a52 with SMTP id l6-20020a5d4806000000b0021d66a25a52mr18315530wrq.632.1658041572041;
        Sun, 17 Jul 2022 00:06:12 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6a38:5652:1b0c:da5e? ([2a05:6e02:1041:c10:6a38:5652:1b0c:da5e])
        by smtp.googlemail.com with ESMTPSA id i4-20020a05600c354400b003a2c7bf0497sm9146800wmq.16.2022.07.17.00.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 00:06:11 -0700 (PDT)
Message-ID: <7e6a5e80-6864-d1d4-4ac9-d90bec8dcf31@linaro.org>
Date:   Sun, 17 Jul 2022 09:06:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] thermal/core: Fix refcount bugs in
 __thermal_cooling_device_register()
Content-Language: en-US
To:     Liang He <windhl@126.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20220707062112.308239-1-windhl@126.com>
 <CAJZ5v0iOF3n98byY5C4zAjM=AbxDiUHF9vqEp78i6_jg8M5MqQ@mail.gmail.com>
 <f9e72fdf-ec3e-d2bf-691e-70b51123566c@linaro.org>
 <1cf907bc.6f2.1820a1695f9.Coremail.windhl@126.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1cf907bc.6f2.1820a1695f9.Coremail.windhl@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/07/2022 04:57, Liang He wrote:

[ ... ]

>> Yes, the of_node_put() is often missing when there is the for_each_xxx
>> OF API. But here the cdev->np is only used to compare pointers so used
>> as an identifier, not de-referenced just comparing the addresses.
> 
>>
> 
> Thanks, this is a good lesson that explains when there is no need
> to refcount new reference.
> So I think there is also no need to patch anything, right?


Right, no need a change for this.

Thanks anyway for tracking down the refcount in the code


[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
