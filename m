Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E665FBABA
	for <lists+linux-pm@lfdr.de>; Tue, 11 Oct 2022 20:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJKSs4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Oct 2022 14:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJKSsz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Oct 2022 14:48:55 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA8584E43
        for <linux-pm@vger.kernel.org>; Tue, 11 Oct 2022 11:48:52 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id o2so1896487qkk.10
        for <linux-pm@vger.kernel.org>; Tue, 11 Oct 2022 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mG2zwWYNxIWtSztSKOnvPD7xgArPRkO20SvzB1RsUNA=;
        b=tn3AqHoMOmYRGqInNP1wFi2+uneFjRWwKgRnzxxWnAoLwMoGE+Qc2A4wcVzs5FIAgd
         2BgGs4gWUlQGa+PN8IWz4PKv1vpNSaU5tQIQEA+F/h02K52N3BtaJlZGdCVI0T6816YU
         NYWuXrQmgRAvTnGpbEYJxAJO6/s/4nRIZwDnTNaEoquHHsIfcI/2oqxLMvBQPLSboQKN
         yeCjs+gd6TvLMeQ+kQbNA1v47CCIPXHqKMn8HHzg5aFJ2fEwRxom5C4lgTaJ3KHNGko9
         A723vHMxJAvZk0snb3tsTDKO9a2Y0ncIqgcyZUFdD4txzQEOsh77MAj0gQWN89jm3dU7
         BToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mG2zwWYNxIWtSztSKOnvPD7xgArPRkO20SvzB1RsUNA=;
        b=iOnJNKEVlj+pD0jx72j+6bhlGXJGiEL9YZXxvV5VMwUqykYDJleNoyJA9eVv/34hwj
         RC7U4qPz8cycU9UQArdfF+iKkL39v0dFY1teHIcjVEsGovvVNOGoV0uVMRYFCdXJp8Lh
         otBdFYYxX9PFu9Vzk+wmIaFkHDewjDTRD1zpjIT0kSlwrBWGfY4z4fAF3pcEV6qbIhbm
         WxnDoPjKhc9zrBlYq253HnSK/nrwgLWvrqQh83KXPFCsXEvaiC/6/FYeXvUBGxCy7l5k
         aVhx5S5ZulfWyS61ObUpLTPmaiMed16dAS4asrvhX5LWnfXZ3ZQU4OeFvfQ8QFydQ506
         ELDg==
X-Gm-Message-State: ACrzQf2otznHi/pbJypIkWQKTD5gzfN71SxPZ4KkMgjv9VXTKYMmCQtL
        vvcMkJEUbgiL2NQ/+91tJt7inQ==
X-Google-Smtp-Source: AMsMyM4CGlYrpnjNHBvMf8M1YQruOkuVcEl81tyRMWUVOnRYQmss7kRrR3+p43tvKMpt7CWIviYv2w==
X-Received: by 2002:a05:620a:4008:b0:6ce:8725:cb7 with SMTP id h8-20020a05620a400800b006ce87250cb7mr18157000qko.480.1665514131819;
        Tue, 11 Oct 2022 11:48:51 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id bw5-20020a05622a098500b0039cba52974fsm566090qtb.94.2022.10.11.11.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 11:48:51 -0700 (PDT)
Message-ID: <d94d99e0-195c-4b27-a928-debe3f20e7d4@linaro.org>
Date:   Tue, 11 Oct 2022 14:46:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] dt-bindings: thermal: Convert generic-adc-thermal to DT
 schema
To:     Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221011175235.3191509-1-robh@kernel.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221011175235.3191509-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/10/2022 13:52, Rob Herring wrote:
> Convert the 'generic-adc-thermal' binding to DT schema format.
> 
> The binding said '#thermal-sensor-cells' should be 1, but all in tree
> users are 0 and 1 doesn't make sense for a single channel.
> 
> Drop the example's related providers and consumers of the
> 'generic-adc-thermal' node as the convention is to not have those in
> the examples.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

