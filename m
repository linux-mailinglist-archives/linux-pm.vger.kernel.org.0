Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1A6576A1E
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jul 2022 00:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiGOWqR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 18:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiGOWqQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 18:46:16 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2831F8
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 15:46:14 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id ay25so3611230wmb.1
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 15:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O6YPhUIsYt5zf8i0l2JyQAe9jcHRbVM0oIcZOZ33z6U=;
        b=ckw2HGIS6manAr2IHB8ErYSVb5zaE8+bpeNaLyKODzDo9GmmxSUpDLRrymGYbYNKbl
         OpMJ+27oHDi4aPJ5k7gEDZoLT0MePyO/MoTujSfFMwYi5qtnXFGM02uvqXh1e04Cxb6z
         Af1cCNsHQ0DuywDxMYWt+8o4CDelDbDDbJ9uYHHSBg0KNZm6HxWxTBVqb2+9I5VfhEsd
         BF1LNughZVNeIoyip/bEdesQ3l6bxX8VA5VlDzhq2eFPfzuXnb4bGduElwWULwSXNRt5
         FFtptbKAANMtVOb31/0CtaXNY7SaRAg1F7Lm5kO4xKss7eoKibZrSN8f6gINI0OlM1yi
         0eNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O6YPhUIsYt5zf8i0l2JyQAe9jcHRbVM0oIcZOZ33z6U=;
        b=nLL9HWKEjWxDwevevX87TSmjXArWCbmfjduHmNuuauAstmDB9osBWO8gWYcUpfQEwO
         gdPfSQRDDWWriUnSRoBX1poZJqMBRZciXNDoMmWqV0eTJfxB/fiRb3jPl3DBjVOT2CJw
         ITU9CMNJdj8Zz1Rxlzj3E1eUFPsiJ31mO6GDYzGDTToD/g5E1i2lxu7Ka9FflEL/ZFdi
         JJbZVrvAfaaxEMEilOw9gha9rkUbqLmuPQwuUEhy5NhrAU129nyLM8szNMDA0trvHgOV
         z8l7d0hVdZH0LYf9t6O05mSRqafs0TiB0YnlUea8vpU4O3ykR012G8FIuugWms1kNUcS
         eP/A==
X-Gm-Message-State: AJIora/55k1j176x+xlxQ2nb+2x0iNvK6wrvJLdP5k0tMqGm/mGLqdNa
        5OU4ee+9PBJFLocdrkRUgGfWaQ==
X-Google-Smtp-Source: AGRyM1vG1ddo3/gBI/TFeHyXh4sWLdA+O8E0G9ff6jmxVXmcwUUk9h30Grs/AMIZy96GvueRtpM0tg==
X-Received: by 2002:a05:600c:600b:b0:3a3:1176:222d with SMTP id az11-20020a05600c600b00b003a31176222dmr1324990wmb.42.1657925173426;
        Fri, 15 Jul 2022 15:46:13 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a223:f4b3:40c9:43fa? ([2a05:6e02:1041:c10:a223:f4b3:40c9:43fa])
        by smtp.googlemail.com with ESMTPSA id j27-20020a05600c1c1b00b0039c4ba160absm17815546wms.2.2022.07.15.15.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 15:46:12 -0700 (PDT)
Message-ID: <ff463957-e85b-27d3-7e10-1cae55404fc8@linaro.org>
Date:   Sat, 16 Jul 2022 00:46:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] thermal: rcar_gen3_thermal: Add r8a779f0 support
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220705195520.2581-1-wsa+renesas@sang-engineering.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220705195520.2581-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/07/2022 21:55, Wolfram Sang wrote:
> Add support for R-Car S4.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
