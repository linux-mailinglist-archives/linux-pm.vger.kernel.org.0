Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E00D4D418A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Mar 2022 08:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240011AbiCJHIC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Mar 2022 02:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240005AbiCJHHy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Mar 2022 02:07:54 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067A413019F
        for <linux-pm@vger.kernel.org>; Wed,  9 Mar 2022 23:06:51 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 253673F60D
        for <linux-pm@vger.kernel.org>; Thu, 10 Mar 2022 07:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646896004;
        bh=pjDcjqvWwdimhut7heTvSMtYMfEdm4Tu45ZKmgOV7iM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=iMhjFe2qiLDbkHYJU3GHsHriUfr7H8PSbgwOqidJHSdA+JKfsDVYT58fFLdjyTzPL
         MbXVC5r90/nw/NoGt0DiA5EAZroIJkAxiX7Kt2G6+1pvGoCxsAIdUWCHSFfKFBZl7e
         sP+VqYEP+3F+QPv8PcpC79r+haq1t88A2ypoaJEwvh0q5s/39DkWBqIpD8fPtDz1I/
         jSLfvVYuI0p80d8ema+JBMe/j3wZKRUbIVNGP7RznUxMNzB5oD6nC5cp9Lk6BECkMU
         2udLr7rA1tG8XpEY8FYyLmnrHDJSSqL8H3XxeEUqHAlXgNciXBfDFUeMh5Mckh8gGP
         JCG9MAtCadD0Q==
Received: by mail-ed1-f69.google.com with SMTP id b9-20020aa7d489000000b0041669cd2cbfso2573437edr.16
        for <linux-pm@vger.kernel.org>; Wed, 09 Mar 2022 23:06:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pjDcjqvWwdimhut7heTvSMtYMfEdm4Tu45ZKmgOV7iM=;
        b=Bs1o7QWidEUyvBCuHAZPip59MXNr+GnCRrLnbDvs1WO37x3pxo23yr6zVLdD/xxWJ5
         9BW0sC73QUjTWf2f8nOqkVJUWIz6XJUdHIDusGotuaV3+pz/T8vE8CBkB4MPOp8+adlH
         tbdN+yMkHbcZAk74531QnTcmIuo7DvDFX0C2602s8W2KGAOeTOOWzUHFRaM7JyCJaEwY
         OLT/R0HbTtaEedRZKn8afQug534Njj7oeNxbk/Q1E34Ngb1dQuc3jBTTsgYqiAs5zVc8
         LTKAeRfWxHjPlpHAgbAWsKqnN5VDswl4XKCEAI6FNLrfG1kOFprtGlAtD/Uy8/3qJvi5
         mAfA==
X-Gm-Message-State: AOAM532P1CpZaTKWLwc11in5LU2yEYmv+yqMhSBm6tmgWSQvEFJxUtFF
        2MOkG3KhgbOtLqImVIuwAsjJkIB7WEhM7wrcv3+bviXoGANJjCQrSQjNVHeBVO91x2sq3vG4crK
        3mrcQBVekvTFq2O8dAHmKGM5YqrU5I5yRzC0h
X-Received: by 2002:aa7:c789:0:b0:413:605d:8d17 with SMTP id n9-20020aa7c789000000b00413605d8d17mr2975162eds.100.1646896003289;
        Wed, 09 Mar 2022 23:06:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYlrNfPdQVnGvzey4MCLdIxRsL5wg+KaBPH40tvaqpWz00KbkDX2/VWP4tuc0tLXFyHzkXtA==
X-Received: by 2002:aa7:c789:0:b0:413:605d:8d17 with SMTP id n9-20020aa7c789000000b00413605d8d17mr2975146eds.100.1646896003137;
        Wed, 09 Mar 2022 23:06:43 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709066d4900b006da888c3ef0sm1482181ejt.108.2022.03.09.23.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 23:06:42 -0800 (PST)
Message-ID: <4cd1b54c-f51a-b013-2683-533e4ea31f76@canonical.com>
Date:   Thu, 10 Mar 2022 08:06:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/3] Add support for artpec8 to samsung tmu
Content-Language: en-US
To:     hypmean.kim@samsung.com, "bzolnier@gmail.com" <bzolnier@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220310013140.127026-1-hypmean.kim@samsung.com>
 <CGME20220310013127epcas3p3f1b7ab9549b1d6d9da65c73adda5c514@epcms2p6>
 <20220310015302epcms2p6ba3fd122f7ebfb9121924109a85801d2@epcms2p6>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220310015302epcms2p6ba3fd122f7ebfb9121924109a85801d2@epcms2p6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/03/2022 02:53, Sang Min Kim wrote:
> These patches are to add thermal management uint to artpec8 SoC.
> 
> The tmu of artpec8 is derived from the tmu of exynos, but it includes settings
> 
> specialized for artpec8 SoC, such as supporting multiple remote sensors.
> 

Do not send emails in HTML. The patchset was partially rejected by
mailing list, so you need to resend.


Best regards,
Krzysztof
