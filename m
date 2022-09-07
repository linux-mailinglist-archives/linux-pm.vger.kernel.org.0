Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FCB5B0416
	for <lists+linux-pm@lfdr.de>; Wed,  7 Sep 2022 14:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiIGMir (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Sep 2022 08:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIGMiq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Sep 2022 08:38:46 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED43B959E
        for <linux-pm@vger.kernel.org>; Wed,  7 Sep 2022 05:38:45 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id v6so2403840ljj.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Sep 2022 05:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=fTdshIA9MMec3X7VmTjTGU3N0nJnI/vT2jNDEM51ia4=;
        b=ha6lPE8aJRyBobeNew4fXWFWJn2CY/KIYJStuGf1/A6h0imBRBkv0jCKRj/oWruLDg
         SF3VcAjOhpLH331xm6Ph7t8BHIeA7WBAhawMWs0FC1a82pAjs3s6nvRCuW8ye5RFfVid
         PeY7+iNNYXzySvSNWkVNJmb9rEGOvjO8dyuOVEhSC53rs2agbzdXeSne2904GvwgoAJF
         NRMwM9maF2zN4+LuH6dovVpaPxpM62vpjdchW0hdG+klTJrlekBOz+8DBO0IX35kb5Il
         UKemvTtxecDcxLdq2sgCkgfU9g13gE7LbrS0oybQumWW4ri9neovZPRbWyCm1QzcCSYK
         BVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fTdshIA9MMec3X7VmTjTGU3N0nJnI/vT2jNDEM51ia4=;
        b=JsCSUiksbr+oip5t1EFUh/hyzkIRNX3TEHawCMZ1nZijFzaSKMWRapnPPtnr5qMmRi
         eH/V8YH+lFEyhYWXWOcPp5EPeu23dKcaFPe3V3c1CCZnEQ6K7wzG/w/Du/KVDv9jk5EZ
         0wWA55Gh0q9Bwkh4wL1JxHeo9LcDUfxgSXUcK0vbR0zrb/0pf29WGCjGw0tabbUZzEGs
         50pOfJbV8KziqaEC6UFANMFI33bKxUwWv9wH3Vf/gJ4G1WxUwFPbQcqb+FKKB7aR3W+S
         3YfuVv56zBXdKqnY7fTtgNfqItDvxsynbAMg3YQLVmpvnpCjZ3lC8I3NK8Dt83nvz2Tj
         csEQ==
X-Gm-Message-State: ACgBeo1TftY3lDg2OrwqeqFCbYfvrvnhLWpRYqpK8lXmx03MciAHkirX
        QV98QMCTJHgz+qaRm2lKcc8cWg==
X-Google-Smtp-Source: AA6agR5TFphhTKCAVf1SKVI7yMO7YM7140eM6H+ulhYTKCVmuZLA8uBrv8H5ERRV1tJSbWo8sax0DQ==
X-Received: by 2002:a05:651c:1a11:b0:264:1e72:9d30 with SMTP id by17-20020a05651c1a1100b002641e729d30mr1051641ljb.160.1662554323787;
        Wed, 07 Sep 2022 05:38:43 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o2-20020a2e90c2000000b0026ac8c94022sm659772ljg.119.2022.09.07.05.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 05:38:43 -0700 (PDT)
Message-ID: <9a71a2f3-97f6-f3ac-8852-1d3da1a50370@linaro.org>
Date:   Wed, 7 Sep 2022 14:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: syscon-reboot: Add priority
 property
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>
References: <20220820102925.29476-1-pali@kernel.org>
 <20220831081715.14673-1-pali@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831081715.14673-1-pali@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31/08/2022 10:17, Pali Rohár wrote:
> This new optional priority property allows to specify custom priority level
> of reset device. Prior this change priority level was hardcoded to 192 and
> not possible to specify or change. Specifying other value is needed for
> some boards. Default level when not specified stays at 192 as before.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>

Thanks for the changes. Explanation looks good.

I sent a patch adding the common schema with priority. If it gets
ack/review from Rob and Sebastian, please kindly rebase on top of it and
use same way as I did for gpio-restart.yaml

Best regards,
Krzysztof
