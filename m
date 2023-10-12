Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335067C7876
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 23:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442853AbjJLVRW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 17:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442831AbjJLVRV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 17:17:21 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF413A9
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 14:17:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-405524e6768so15191065e9.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697145438; x=1697750238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IwD1fj8O0qK3NQU4/GGTVbtH/60RxqkX44mSAkHZK4Q=;
        b=a01a0flZmc7b3TlH1PEwh5aSXoASQCn5d8o8wsbxTCmF8aoOwzpVdca1DwD0F4Oxuu
         Qi8iaIRukDX3npZj9PKqj5SsdomYOR4tsYAUBnoYHgqO7UGVZ9/YpMZDVFgBIwafoMRT
         DsnF7m8/guN9+gIDjMd9ykGVOcv5xwuBNp5BH6vAT8XO68CB45wiBe925kG/CzD797jh
         xGUumu0I/JreVye8mnEvAS79eactBOl5OMZDOV1TJB4HrUbdzMMmhQG77+sXQi8qLyqs
         ULkMFophWydf5k2Ao/ZM3R9y42p1GF5uKox1u4Wp6FdTjn+lpDa6ZYRLTIlJ/82usqUe
         dkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697145438; x=1697750238;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwD1fj8O0qK3NQU4/GGTVbtH/60RxqkX44mSAkHZK4Q=;
        b=e4eBFZEUbn47uo5wq8SKYj2JcLoHQDZ7IdIO6rCvRdZ6xWb89bPpo3jqDeEnCFHxeE
         XLqJEwKjexjiLeRKB7bBOIA5nC/rMsuUqahpwvVCImPBZK7p82vhU8Q/Na2SgyfvaBGu
         JH+veu7R2v8lWFFmmDxWI0tH+LV3WNEFqJvYzRoFKulNfECpwAtzli3iUbr1XKmsw5tC
         xBhE6pHhBMVNPaIVpCTHWp9z/StNDhmnM9X1lp3S9b7xa5eQCFQ08M+4XsB2JC3mewt7
         pcse9vUbWYaWDk92r8KG6BxcEGjaFjZae8ozEX6Z1tm2QT1FnjPPpZBqeFHSy8GPz1Aq
         XJbg==
X-Gm-Message-State: AOJu0YxhJN3JTXFH/az6Yo1zVjcOuZEZq3fUOL8EfkST3bTJgVwy2XdO
        y+gYSL8nTAu9jmOZQM/TYavg0g==
X-Google-Smtp-Source: AGHT+IHIdxFXd8IHtJCv/zTrwfAYHaKWXV0EMAXBhlUrBfBA1o9RqCTBZOrIDy3M33QSgkGwGISPqQ==
X-Received: by 2002:a05:6000:1b07:b0:321:6450:62ea with SMTP id f7-20020a0560001b0700b00321645062eamr21598047wrz.36.1697145438366;
        Thu, 12 Oct 2023 14:17:18 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id l25-20020a7bc459000000b004054dcbf92asm779383wmi.20.2023.10.12.14.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 14:17:18 -0700 (PDT)
Message-ID: <02143175-a5ed-4cc2-9034-acd34ca913a0@linaro.org>
Date:   Thu, 12 Oct 2023 23:17:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] thermal: gov_power_allocator: Use trip pointers
 instead of trip indices
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <5734364.DvuYhMxLoT@kreacher> <2921191.e9J7NaK4W3@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2921191.e9J7NaK4W3@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/10/2023 20:31, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Modify the power allocator thermal governor to use trip pointers instead
> of trip indices everywhere except for the power_allocator_throttle()
> second argument that will be changed subsequently along with the
> definition of the .throttle() governor callback.
> 
> The general functionality is not expected to be changed.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

