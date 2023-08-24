Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBF178703C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Aug 2023 15:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbjHXN2r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 09:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241198AbjHXN2S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 09:28:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8993919A5
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 06:28:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso894138966b.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 06:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692883694; x=1693488494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ImqDglmsX4gE1rDreji0Q3e+eQbu+XRHLE9I8QA79cw=;
        b=mB3eAuFUc3gfns5iLxgrvJNpK8WpWiXOwHPNaWwHKWEAsP5CFakTp3MMt6SPSDiFKc
         BWdQ9Sepw5gCpmNRbls3cS9er71eC3HRxv2JbohEWyGeaC35bTFkwHvUL7NbyvIOmPkJ
         upOXUBN89LMA9XnQ1B8sD39Q0l9Gh+xscAoKTiOiqyzC296kH2ouSb73YOhFNCkhupI+
         zG2EutZg1VQiZPEP39rsqLwbtbvwxJzU6xngERxhj+AR+DnqyHQ0h8veSaKoHLzIXpI9
         hE62zOswe54QzhWkjWIgYtkVxkYvo+kHAzeizAXqojynkfEWLTn8VTtTRW0eQcxbFsWL
         tPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692883694; x=1693488494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImqDglmsX4gE1rDreji0Q3e+eQbu+XRHLE9I8QA79cw=;
        b=WbEH761j/GTh3Rix7PoezPmT/uUrk0boByOo+yqt+gusPGchId5aMuasoO0S5RqihS
         +ffmwZzPv7J7aHa1DZferXLMNq+dZ/LzdeMRw5uRmWRBKWhAYirNOe7tgNEkMi0vy07W
         bB/vOQ+AJ1S5olp1gN9CdK/lWLwY+FmCGBKFirKq4DL7QCyo3XNaN96etOPF/6WSGHIP
         vQ1IpyOhxXCop6tB2ZD61O0MEMC5W3wxPGdJDeIsU1c5NRpE7S9ZVufUXHFz/qU2CXLP
         O+8yRPiNaNBwHi0vxp5PzCH2RBJsPiFbL0mkTO6GyP6ahMfqhhEx/Kqqkiaa+QK5HvxG
         TdhQ==
X-Gm-Message-State: AOJu0YwsXUJc8sjyrSzDzufZZhHi/zXJNCiB24b6ielwKDhwWMBiRsIW
        mqN+e3rkOuq3nTD23lER7BJSSw==
X-Google-Smtp-Source: AGHT+IF16QqOoKGpP5WTK94I2qdMdh3RlXH/q4UKovGuoNtRZiY8220OFQc1NuQ95U0YzsbN7URgQQ==
X-Received: by 2002:a17:906:3113:b0:9a1:ea01:35b1 with SMTP id 19-20020a170906311300b009a1ea0135b1mr3252321ejx.62.1692883694028;
        Thu, 24 Aug 2023 06:28:14 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id t23-20020a170906269700b00992b50fbbe9sm11045915ejc.90.2023.08.24.06.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 06:28:13 -0700 (PDT)
Message-ID: <6fea2e1d-426c-b3dd-389f-761312abfb2a@linaro.org>
Date:   Thu, 24 Aug 2023 15:28:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] power: supply: bq24190_charger: Export current
 regulator
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
 <20230824112741.201353-3-linkmauve@linkmauve.fr>
 <f2f033a6-f552-b86f-250b-08fb298c9bb1@linaro.org> <ZOdU1RO0AxKmz0PY@desktop>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZOdU1RO0AxKmz0PY@desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/08/2023 15:02, Emmanuel Gil Peyrot wrote:
> On Thu, Aug 24, 2023 at 02:41:41PM +0200, Krzysztof Kozlowski wrote:
> […]
>>>
>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>
>> Missing SoB.
> 
> Do I need to add myself even if I didn’t change anything over what the
> original author wrote?

Yes.

Best regards,
Krzysztof

