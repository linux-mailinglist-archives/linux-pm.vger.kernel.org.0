Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3467A4B57AB
	for <lists+linux-pm@lfdr.de>; Mon, 14 Feb 2022 18:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356820AbiBNRBc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Feb 2022 12:01:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356816AbiBNRB2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Feb 2022 12:01:28 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF482E4
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 09:01:21 -0800 (PST)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9B871407C4
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 17:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644858079;
        bh=csfx64Qqw6UchF9clKkcilP8fSBNm/3id8/cZCe0yMk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ooTgs4HaPtbY04FuUl7/gu62Q23JLDkg2A4LX+HLPx/L3oVl8qdmUUFtimeAf7qpd
         mEwUB2T0QdhBnGucxHrtKKE2qNC8Yi7qEQmjR+1Z9H+ou9yCVCpDKQEYXGEarG/9B4
         fNiIiQGoTuQ6N8lDYc2qV0kbOlR1CSZ4ncp9G9gRoxFgmKz9EVfDz9ONbKtzknUyos
         l5d3SyWTRIbaRLDhI+64VFRPY8wXefQtNFGTt1yLGRV4NeKW6hXDGeJRYEdsD7E9nt
         SrJYF7LIVIjULYR8vnWmJgbYrtKMgo8SKd8Xt1uRhJl62k/p1nVEcW9rVJMvmN3XL5
         p6RsuM275AnQg==
Received: by mail-wr1-f70.google.com with SMTP id r2-20020adfa142000000b001e176ac1ec3so7178597wrr.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 09:01:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=csfx64Qqw6UchF9clKkcilP8fSBNm/3id8/cZCe0yMk=;
        b=sJuXOaNSPGpcM52nvCEz3f02Vzy9nZb58axbXcMEjXbyzDq5XpX5QUXyJHbjLh0bps
         ELFC2HLKjbYV0qUsPnnmFYqe3ZV2KtJQmI5o734fzMGLFbJTuw7HGyOgfqOSS7XN9njI
         kBnU7QIqUqtGrddexJxTs7hHWCVoZO0IPs7bg3SQQns+njGAlOMqRDryW2RN7qaZC/xo
         g/kNES3LKb8yFvt3VvJSwwp4JUieng8noGVhyzVAKwbl1mjK3KITy/Idjgd1KcVbJsC3
         5TU7TRjlNVT6qBPKW2iyZ+KncqUbjghAqk++IMX6LWDeVgYcAJzp/Uri7wBMc+//Jn3r
         MQ/Q==
X-Gm-Message-State: AOAM530iA5Eoe1FBje0dhuq2x0+8IKDl/u8++ry2bbU8orlmAYLYHLqF
        lbXrTCCxk2q7f6gJUhMRayUjKKRVT24ONzoRrRy1qIvyRFrIIrvnM4HbDN9UPjSL/6+Fwd2qY/T
        vjPiLhojoa5n0tX3f65ytxESwkl2IPOk1I+mH
X-Received: by 2002:a05:600c:1e25:: with SMTP id ay37mr216955wmb.119.1644858079125;
        Mon, 14 Feb 2022 09:01:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1tDzqmWo3bLmsZd4IuvNcUrjHtrME9cVZR+YsIMVb1iFKxX9Pssch7JAKMQrj7QEdady89A==
X-Received: by 2002:a05:600c:1e25:: with SMTP id ay37mr216936wmb.119.1644858078944;
        Mon, 14 Feb 2022 09:01:18 -0800 (PST)
Received: from [192.168.0.106] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id x18sm29861759wrw.17.2022.02.14.09.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 09:01:18 -0800 (PST)
Message-ID: <b0aaf1e6-c626-e68c-a0d2-4a7ff372b395@canonical.com>
Date:   Mon, 14 Feb 2022 18:01:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/4] regulator: dt-bindings: maxim,max77693: convert to
 dtschema
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
 <20220111175017.223966-4-krzysztof.kozlowski@canonical.com>
 <YgqGT999nsjUGp9Z@sirena.org.uk>
 <12c66ced-c4a4-3a4e-f84b-83edb9e3fc58@canonical.com>
 <YgqIiv8fZeqFFUHX@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YgqIiv8fZeqFFUHX@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/02/2022 17:51, Mark Brown wrote:
> On Mon, Feb 14, 2022 at 05:45:40PM +0100, Krzysztof Kozlowski wrote:
>> On 14/02/2022 17:41, Mark Brown wrote:
>>>> +    properties:
>>>> +      regulator-name: true
>>>> +      regulator-always-on: true
>>>> +      regulator-boot-on: true
> 
>>> Why are these specific generic regulator properties enumerated?  
> 
>> additionalProperties=false is used, so all properties, also ones from
>> regulator.yaml, have to be mentioned.
> 
>> Why this approach was used? Because the hardware here is very limited,
>> so no other properties are expected. No other features are supported.
> 
> That's not going to scale well if we add any new features in the core,
> and doesn't include things like coupling which could be applied to any
> regulator.

Relaxing constraints - removing required nodes and using
uneavluatedProperties=false - is still possible. Unlike the other way if
we ever wanted to restrict too flexible bindings.

You mantioned new features - this approach does not change that. If you
add new properties to common schema, you already alter bindings. Just
because we use common part, it does not change the fact that it is a
bindings change. Adding new features in common schema is the same
binding change as adding new feature in the specific binding, except
more work.

I guess you though that work in scaling, so yes, this scales worse. The
benefit is that this really restricts usage of regulator to what is
supported, so allows to detect wrongly configured DTS.

Once coupling (or any other feature) is supported, each of such
restricted regulator bindings should be independently revised, instead
of adding this new feature to everything.

Best regards,
Krzysztof
