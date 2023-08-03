Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B75476E9EB
	for <lists+linux-pm@lfdr.de>; Thu,  3 Aug 2023 15:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbjHCNTg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Aug 2023 09:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbjHCNTW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Aug 2023 09:19:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29561BFA
        for <linux-pm@vger.kernel.org>; Thu,  3 Aug 2023 06:19:11 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so9921835e9.2
        for <linux-pm@vger.kernel.org>; Thu, 03 Aug 2023 06:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691068750; x=1691673550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mOCS+sHZ9OYDGZ+r3hB6DlHjCqnsHVrb+8LC3PIeLA=;
        b=B9KVtoTdkm4iLoGepeSWfuUFWRa/XcZRb+QMTwQ6Fh4TlGcz3G0K7ca5UOn7wk1G3U
         4i8ZtlnjX3DAgKF4k2meo8tNjSVpPG5hkj5m/p1tM+d/Hr29X1igc1YKsTwV9ajwA2N/
         UMkqwd4iNqpi1bkEQADGZxb3xm58kF3bXRcNI0ULCGpUJrlG/GoeHlpPP9iPtwTgLqeN
         n2M6GpvGP3ERtY/xNc18a6CrdldFRi41PFtkAa4+Y2YR2AeqZvr1NVEE6exZn2JY32c7
         kc+yB5/BP8N7XlLYBaRnMnbSSIZIoX68xupHuwucTLUG7wBMQeyAD/d1TZuX3NGwVJWp
         cTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691068750; x=1691673550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mOCS+sHZ9OYDGZ+r3hB6DlHjCqnsHVrb+8LC3PIeLA=;
        b=C3AbqW+gHVeOOr1Iz64av8CM7JjFpJeaWpNPjhXxeNj8As4ulCUjBQDfCwIE6I7KXp
         WYzodYxVFqqS7V5EeMavQYbZUzmMUxXh4STTmKLoCa8ZWEspvEIJmRGigT5xna8VTeBY
         DF74YxtCkZtwXkuuim8R3o7w5EUtKpkpkCnNYQE1KQGRji1anbCtTXyvqD3TL3rohk+g
         04OK2XzJ6fmP2CmVFl6o7INBY0zOjth1qJvfoRE6CUtCbeb0uN4FOzaI3iAPjdu20B8I
         FgzOEYVYVK29/JBAmRQt4CZVocpx/+lkvf2y5CyRyN3+QYgbqI04qKBjUUUsMOv0OLMv
         vsdQ==
X-Gm-Message-State: ABy/qLbK6Es2NBabJ3LaoOsh/bEcycS+rl2vUGtXRyY2tZqaet9TAxkB
        NXlQ3c9ZqhPge08Dxh2d9RtLo3M/AwQv8p8UmbY=
X-Google-Smtp-Source: APBJJlG80gudR9LU0/3zq7coND676L3IK21c5s2iw2yBqdiqauL+wz/tpF8p/JXxwsJxejMflM9+qg==
X-Received: by 2002:a05:600c:2048:b0:3fe:2bb1:11ba with SMTP id p8-20020a05600c204800b003fe2bb111bamr6423174wmg.27.1691067974611;
        Thu, 03 Aug 2023 06:06:14 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id w11-20020a05600c014b00b003fc16ee2864sm4221824wmm.48.2023.08.03.06.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 06:06:14 -0700 (PDT)
Message-ID: <5c93d78d-835e-c740-280b-9d76456aaeda@linaro.org>
Date:   Thu, 3 Aug 2023 15:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/8] thermal: core: Add mechanism for connecting trips
 with driver data
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher>
 <4501957.LvFx2qVVIh@kreacher>
 <2d0315d4-35b4-84db-4dcb-c9528abad825@linaro.org>
 <CAJZ5v0iQDOsTOqWFvbf5nom-b3-pbHPRzJQC-1DM9eoh=0AKjg@mail.gmail.com>
 <eb279cf1-0605-3b87-5cb6-241a91977455@linaro.org>
 <CAJZ5v0i48=oawDJHoaHhiZRaO_CJokKsOHyNvu2v4PUbS6CH_Q@mail.gmail.com>
 <f8029547-6851-7e0c-00e6-4963ccbc2702@linaro.org>
 <CAJZ5v0gDQMNSeEU1J7ooJk4Ec=Hw_JuZAtL5k215v7Lf67iTgg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gDQMNSeEU1J7ooJk4Ec=Hw_JuZAtL5k215v7Lf67iTgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/08/2023 18:48, Rafael J. Wysocki wrote:

[ ... ]

>> Let me check if I can do something on top of your series to move it in
>> the ACPI driver.
> 
> It doesn't need to be on top of my series, so if you have an idea,
> please just let me know what it is.
> 
> It can't be entirely in the ACPI driver AFAICS, though, because
> trips[i] need to be modified on updates and they belong to the core.
> Hence, the driver needs some help from the core to get to them.  It
> can be something like "this is my trip tag and please give me the
> address of the trip matching it" or similar, but it is needed, because
> the driver has to assume that the trip indices used by it initially
> may change.

May be I'm missing something but driver_ref does not seems to be used 
except when assigning it, no?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

