Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCD754638C
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jun 2022 12:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbiFJK3N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jun 2022 06:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244609AbiFJK3L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2022 06:29:11 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC12140E0
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2022 03:29:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id o7so19320713eja.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2022 03:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tLO8M+bBtsFeLQBJeKorjii5kkChBo5ctWVAnJ9k72s=;
        b=iWa9dQh1aY0vk7XC0r8UEikGjxDa0uCh5Wc2lvho+xKfJiDj6HkxfBcDbx9gQzhv8X
         7k329I4+2op+Pu02VnxThT1bk9bLwv/jDU9ts6khNIgfmUHsPm0vNn0CVwPmMP/NH0CW
         Y0tfDdFeqzdGpnrBs6SwDOQHHMyzcAPxtt8X13eKJexaya4MpHXRhHeWJVLERwA1O4em
         KcVwzVVu0yiSJMK3WhtxOP6o5c6qiRpPodSPoj1/ewTrTmMB/y+8EBrbV25KnRM8IAbe
         cXUiVQWQUZDMpCctn3rko0yzLSGpVG6XN16cGeqeAq3Klacrt3fgbpV/NXXKnSmX45/8
         8ItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tLO8M+bBtsFeLQBJeKorjii5kkChBo5ctWVAnJ9k72s=;
        b=0b9dQI3hEJohpMpYt+1ew/53Xv+fj6PASq4o226mz0+X2w4616VOev/g5TxrKo2N1K
         RfPXKc6U/L/mSXxKblJVEkNedcm3CqWdOSUgHgqjNsKYPUE+QD7iXCAhnHrBwOgP20EJ
         ow2E2X7hydWn5ar6ikyn9smsb93qDLKAezPd5Ubcvkoxu2b1pmmlbo8ilIMxrwTllmxs
         sAsk1C+f9vdOkjzMLlOAzjd2Lu//F/iNidOVQf8tKFCte6tOKlcRfXi1Y+cL5panB/fL
         DYWTChdaqAnOiPwfy/ciTQfnQHiH4k+ZApN/h7VuL2EiZnKBM9zBKTQ2L7ZVVap0VFhr
         gGhg==
X-Gm-Message-State: AOAM5306c9UbymfxzteodjbV7ofrlMiHUSlNF4tlKece40/hAJKPiUNI
        TanNAaEhQw1JSTflRRVKgIlGVw==
X-Google-Smtp-Source: ABdhPJzo4/uJou01xICnCHlFFG6i9dGDLudvClUxMGfQhm5qoPNHdvDugPnGWxs+wZCCnIrwagewCw==
X-Received: by 2002:a17:907:9495:b0:6ff:14df:d2a with SMTP id dm21-20020a170907949500b006ff14df0d2amr39824681ejc.338.1654856948936;
        Fri, 10 Jun 2022 03:29:08 -0700 (PDT)
Received: from [192.168.0.202] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p21-20020aa7cc95000000b0042fb17da833sm12259010edt.60.2022.06.10.03.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 03:29:08 -0700 (PDT)
Message-ID: <2edb2dbc-0f62-23cc-2f32-3d27d83a194e@linaro.org>
Date:   Fri, 10 Jun 2022 12:29:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 2/2] dt-bindings:thermal: Add Sunplus schema
Content-Language: en-US
To:     =?UTF-8?B?6YOt5Yqb6LGq?= <lhjeff911@gmail.com>, rafael@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "lh.kuo" <lh.kuo@sunplus.com>,
        =?UTF-8?B?5ZGC6Iqz6aiwTHVXZWxscw==?= <wells.lu@sunplus.com>
References: <CAGcXWkzSrEPPT2m=2trWN-BV-ix9TcHCvZYya5i54ei=EWGTZw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAGcXWkzSrEPPT2m=2trWN-BV-ix9TcHCvZYya5i54ei=EWGTZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/06/2022 03:32, 郭力豪 wrote:
> Add bindings for Sunplus thermal driver
> 
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>

Thank you for your patch. There is something to discuss/improve.

> ---
> Changes in v9:
>  - Change the setting of compatible
>  - Mosdify the setting of remove funciton.

Your subject misses space after "dt-bindings:". Look at other patches
how they are named. Please fix it.
Normally I would give conditional review, but I am afraid it you won't
fix it, based on our previous history here. :(

So sorry, but for such small change, I expect v10.

Best regards,
Krzysztof
