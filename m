Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3358A7046AF
	for <lists+linux-pm@lfdr.de>; Tue, 16 May 2023 09:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjEPHmH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 May 2023 03:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjEPHmH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 May 2023 03:42:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEF21BC3
        for <linux-pm@vger.kernel.org>; Tue, 16 May 2023 00:42:05 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so4324850a12.1
        for <linux-pm@vger.kernel.org>; Tue, 16 May 2023 00:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684222924; x=1686814924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZXzXb1KfBobQ3/S5Ajx1vdxSIw+IsxbJT3mEJpFQFk=;
        b=SyW/B3o1Cvhb+mnJ/X5yMx1qFyuPznvCd95LH0MsgEjf8ckxW9z/DCxKplt4MsaoRS
         RuVhDobvymXJVu+VrxNAN/FcmW12+a+YA0MKFY/qn4+vw9+WchqnCPaDsW8YgOgPkNnL
         JgH2Pm/HxTZzlAvk6v3Q764WbWHhe/vi4hz4InorUwn/WJBw8jzTkmGnaKjcYAD+71Po
         h4qd1qPJ8WGQgYDGgZkQDFJOH8uAf3nc+VKeGZL8ZIGglpCuS9q+74lOfvwqKQfJ5652
         PUClBj2Qe03YNN3tNae+9rrzgvH0GZdv4+UCxsDPICRYIkCGdmpEAKC700ZobWwaKgJ0
         ZJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684222924; x=1686814924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZXzXb1KfBobQ3/S5Ajx1vdxSIw+IsxbJT3mEJpFQFk=;
        b=dh5hD/qm5IJoa6WuWM1u3jXBQo7pZupmVT+VmtE5v6ObyfybyB8D3WnwpUZqMHBPzp
         jRecqlya5UyM48BMD0z96Ycbh002QY13JPk5L0x1NwWqI1BaS+F6U41FdJjkXsQDjeJA
         vAUOeKozfPQIJcdREhW/bYCUienjwjFKfLCfYeh6sWDVTxP+LkvJWzqSd7xbilJNgntP
         RgDbmgwDRooNTM+uOCLEOU/9J8KjYj3hd+Uff0rxKHdZX1pk3DM8OQdBV2jzEd8lpFdk
         iEQSKdkWk6ORqUX/lS9SEGACgBp5jrksyQY3q8EQ0u8woc1BuZPxEOrxnxxNeuwde3JE
         rjcA==
X-Gm-Message-State: AC+VfDwS40FVSi2iAoLIOg6SUWqPlm/FUcJPKavqTKQeoHFuMTOuilCM
        OcPPYT8FndstQ3PF2bD3FeyfcA==
X-Google-Smtp-Source: ACHHUZ7Y5mGt2pCocBPB4HD9MPrv4mCmUe48c3hHfcI7LUxwItGZ2C1O6srfl8JUqAGzVhA6xZEVzQ==
X-Received: by 2002:aa7:cb11:0:b0:504:a3ec:eacc with SMTP id s17-20020aa7cb11000000b00504a3eceaccmr31502223edt.4.1684222924086;
        Tue, 16 May 2023 00:42:04 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4d4a:9b97:62e:1439? ([2a02:810d:15c0:828:4d4a:9b97:62e:1439])
        by smtp.gmail.com with ESMTPSA id n8-20020a056402514800b0050d8aac0a1esm7940579edd.19.2023.05.16.00.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 00:42:03 -0700 (PDT)
Message-ID: <418cc644-80c9-bf5c-d54b-b2d4dd725450@linaro.org>
Date:   Tue, 16 May 2023 09:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v8 0/8] Tegra234 Memory interconnect support
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org, helgaas@kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
References: <20230511173211.9127-1-sumitg@nvidia.com>
 <a032d9e6-6cb5-1856-9eda-28028bf05633@linaro.org> <ZGJbXg88JOu4aiNe@orome>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZGJbXg88JOu4aiNe@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/05/2023 18:18, Thierry Reding wrote:
> On Sun, May 14, 2023 at 12:41:45PM +0200, Krzysztof Kozlowski wrote:
>> On 11/05/2023 19:32, Sumit Gupta wrote:
>>> Hi All,
>>>
>>> Have incorporated the suggestions in v7. Only changed 'patch 1' in v7
>>> to fix possible race when setting 'mc->bpmp' as pointed by Krzysztof.
>>> Requesting to merge the patch series.
>>>
>>
>> Can I apply it since you request it? I asked you long time ago to
>> clearly state dependencies or merging limitations. It's v8 and cover
>> letter still does not state it. Neither the patches do.
> 
> I thought we had discussed and agreed to merge this through the Tegra
> tree, which is why you had provided Acked-bys on all the patches. I was
> waiting for a final Acked-by on patch 1, since that was the only one
> still being revised.
> 
> If you prefer to merge this, that works for me too. In that case, the
> series:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>

I have short memory and that's why we have cover letter. Solves all the
problems. Let me ack it now.

Best regards,
Krzysztof

