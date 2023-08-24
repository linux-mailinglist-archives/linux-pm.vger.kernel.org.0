Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE93B787036
	for <lists+linux-pm@lfdr.de>; Thu, 24 Aug 2023 15:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbjHXN2Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 09:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241340AbjHXN2H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 09:28:07 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6895E5E
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 06:28:04 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76da22c090dso345984985a.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 06:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692883684; x=1693488484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9plhSlNaSngoiKUN/pWzQlNqfBvCwMMSYVTz79Dd2w=;
        b=WSFcV96FNbri8lPqRZpcS4S8ihB8m9xYmyDdMqbV47jzXhDt4lICW+x0lZHflumEMC
         HOBgYEvqET0wJjn4qEfHdegceZt21HOBCsvwDgz79p3U2IeNsRveZBpf6vvaGcvb2LEM
         fru1u/D/YSr864u03dA0LtnDlHeSZH2ZHyya+gcfDL3aXJdJ8zTMWn90W6LVf4lYWxP9
         8RmYBdWYykDKCJKZANZk5R4sChwfk8PItjyeaQ0vKPLeco7ckXvsJeo/bOElpH6UL9tT
         zxpIgzUvKx7QnYscvxMPWzxKWWHXYVp/YfUYMbJWjC/FXmd4iGxMFJwAZN1jbLybkza9
         pDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692883684; x=1693488484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9plhSlNaSngoiKUN/pWzQlNqfBvCwMMSYVTz79Dd2w=;
        b=kyVqDJdqlYVj2AynrScv/sEtL8zl3Q9I9nAfZm+ty8i7icf708UdAITd49K5qCBlN6
         20dkKx+si7T1KZAx5mKPbyecaj3hTepW0kUqtWnpULOvSw2cepk57xL0QlgzN3mMZnxr
         V7B/1Bk+kg2aqqgz7Fj36mzmjwF0SUUgZDLIbWgzDSndeBGIgNSCEVxcO5UseAWDqZfm
         VT63M8HnmQ3qW0x+KrXw8x+iwpB+CrQPMtKiq0ihF6YotBpBIbKjuH6eXuIB5DaenkuH
         gir5PUtloQHzTwRY08ZROLhrTtfMp5960mfK52Wjj21KY7PHfBdbXfVFq5gZTUrPTCGe
         wyHA==
X-Gm-Message-State: AOJu0Yz4NM9nex5V9K8buYHn4PNyCESG9eNzNZ5qE2qvVKNhDPPcKM8L
        3JGxG24FLzyJQXkE8cHY3Xgjpw==
X-Google-Smtp-Source: AGHT+IHR/vpQvPhrcTPSsl7t5/L93LvdxtAc3sRkX2+cznhN+2iAnoKPAULi0G9gp7AFBC/sN/6dyw==
X-Received: by 2002:a05:620a:c53:b0:76c:b293:84f with SMTP id u19-20020a05620a0c5300b0076cb293084fmr17579982qki.21.1692883683717;
        Thu, 24 Aug 2023 06:28:03 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id 26-20020a05620a071a00b0076c60b95b87sm1969663qkc.96.2023.08.24.06.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 06:28:03 -0700 (PDT)
Message-ID: <622faf2a-58ec-5ff4-1952-19c15d122642@linaro.org>
Date:   Thu, 24 Aug 2023 15:28:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] power: supply: bq24190: Support bq24193
Content-Language: en-US
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Alexandre Courbot <acourbot@nvidia.com>,
        azkali <a.ffcc7@gmail.com>, CTCaer <ctcaer@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230824112741.201353-1-linkmauve@linkmauve.fr>
 <20230824112741.201353-2-linkmauve@linkmauve.fr>
 <46a562b5-6984-3b41-3c41-c346107b4c96@linaro.org> <ZOdUiFsAjQCvwp1A@desktop>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZOdUiFsAjQCvwp1A@desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/08/2023 15:00, Emmanuel Gil Peyrot wrote:

>>> @@ -2027,6 +2028,7 @@ MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
>>>  static const struct of_device_id bq24190_of_match[] = {
>>>  	{ .compatible = "ti,bq24190", },
>>>  	{ .compatible = "ti,bq24192", },
>>> +	{ .compatible = "ti,bq24193", },
>>>  	{ .compatible = "ti,bq24192i", },
>>>  	{ .compatible = "ti,bq24196", },
>>
>> We should really stop doing this. All of them are compatible, aren't they?
> 
> From what I gather from the different datasheets, the main difference
> between them is the maximum current they are able to provide, 1.5 A for
> the bq24190 and bq24192i, 3 A for bq24192 and 4.5 A for bq24193. The
> default current limit is also detected differently it seems.  But yeah,
> those are otherwise similar enough to not require anything different in
> the driver.
> 
> What would be a good way forward for that?  Adding a new ti,bq2419x
> compatible and switching all devices to this one, as long as they don’t
> require anything specific?

Not a wildcard but any of existing ones, e.g. "ti,bq24196", "ti,bq24190".

Best regards,
Krzysztof

