Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2434264ED12
	for <lists+linux-pm@lfdr.de>; Fri, 16 Dec 2022 15:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiLPOmj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Dec 2022 09:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLPOmi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Dec 2022 09:42:38 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C03062E9
        for <linux-pm@vger.kernel.org>; Fri, 16 Dec 2022 06:42:35 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b13so3787514lfo.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Dec 2022 06:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKET8qSCU/kooErGkLjKkAuZxwmPKDJA+s7NSMosmIQ=;
        b=tqdVUD9nV8k7X4TMgWmqAN8YNJvOfP1pYLLTieRzzWjp6a6ypLcDJkoZcM+TwQHiFl
         uIZb+Thj6pRWSgH/+OBHc523GILmKu9dKRP0ul4DdU0ln0grfHQf84TMXHFkfsi9mWnx
         zpjk7mPbcy4iSXP2ll/mYzO1PYaZ6qjA5kI718ri29vYmUQpItIhTVYJOaBYNjcpzSVk
         9vg1fZGE4OJhvOUIypxVBAZ99G+XjZ/OEjj3SlAnKqYmB3+IK9uzcKY0+oIkZA6ejtqo
         TIS1fl9QZNEu8HfHUAa4nSjuo0yBtI+Fmrqn3/VGhpdr/nG/cSnkNN4Eapntd7QXvuM6
         M6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKET8qSCU/kooErGkLjKkAuZxwmPKDJA+s7NSMosmIQ=;
        b=k8FM16FNbBoKSL5U3FJ41OC6YpCav49QcWjqTcbY2T5y8UOeZGC8ne76bykYg1RkSg
         LSBL+xkF6B1tE5kpBdu4H7UZFKmZj8rjkCMKAF+mgXagoh78Rdg8Ze0sfbLvJYOzYiee
         Hz6YwkJvXltcSFNdn8O4vkAMEgdSMfi78+nwrT9p2PrP5kqvorn2Hg2R/lktVV2EbLT0
         U+wrzgKyzN4nBK3x2uWChP2QDA4Ic8YWChwHOmN86yk7TLr/sDPPR+QqucppjhQx7HvI
         gmvWTR5pHLJARlk9T+yD23UnAd192o47VR0GuzxaSj8rRcZSDSMS2sIINj79yiIGhUr0
         3Q2A==
X-Gm-Message-State: ANoB5pkhwTH4Kxos4B3QFOgosIzI00ji9rYSAXABNQnJwxvM4mnlfk/U
        PKD2hibhAZVpwSt/N/shjwhzyVTZWHjgX/1F
X-Google-Smtp-Source: AA0mqf7XPrlzGq9Do6FkmILBfJGoJhZjLA4FgBYnCkKP6CHzLp5oNCqg0cCn+f0iyTHo/ADnrF43pA==
X-Received: by 2002:a05:6512:308a:b0:4b6:f51e:b8b6 with SMTP id z10-20020a056512308a00b004b6f51eb8b6mr5809984lfd.56.1671201753456;
        Fri, 16 Dec 2022 06:42:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p13-20020a056512328d00b00497a61453a9sm230389lfe.243.2022.12.16.06.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 06:42:32 -0800 (PST)
Message-ID: <7a6de63d-759b-8d8f-144a-f93f36376d0f@linaro.org>
Date:   Fri, 16 Dec 2022 15:42:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH RFC] base: power: replace generic_pm_domain spinlock by
 raw spinlock
Content-Language: en-US
To:     Adrien Thierry <athierry@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>,
        Brian Masney <bmasney@redhat.com>, linux-pm@vger.kernel.org,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
References: <20220615203605.1068453-1-athierry@redhat.com>
 <cefad5f6-8aa4-acb8-231c-91170ec10bcf@linaro.org> <Y5x9DEIsnLG7HoaQ@fedora>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y5x9DEIsnLG7HoaQ@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/12/2022 15:13, Adrien Thierry wrote:
> Hi Krzysztof,
> 
>> I also hit it now on v6.1 RT kernel. I see no more discussions happened
>> here. Do you have any progress on your side for this issue?
> 
> Unfortunately I haven't investigated more since June. I was hoping RT
> people could chime in.
> 

OK. I have a fix (change) for this which might be acceptable by Ulf and
others, so let me send a patch soon.

As Ulf said, even after fixing this, we have PSCI
psci_enter_domain_idle_state problem....

Best regards,
Krzysztof

