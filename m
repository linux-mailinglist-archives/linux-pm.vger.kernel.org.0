Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F9857B471
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jul 2022 12:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiGTKZB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jul 2022 06:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbiGTKZA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jul 2022 06:25:00 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A0C655A4
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2022 03:24:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a5so25439385wrx.12
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2022 03:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9T8+kdIQXxmPiX39517lARW6zkwqa89pynqnDRsRmf0=;
        b=N+0gIgwEQd4FcjqQ1uoXMZEbHrIZMiXI+6DBvNo+docJlzysY83l6riZ1Kmxx3ZXQD
         ADXh2vPciR7o8b7/JmjrsmEXT8h+rhOqXcYcqnZMJROvTa6XEYDKUD0xTkH9amaOt0cV
         v6saU+IU2ZOKuC+T0dNI3tIGIvzrGR9FpzNuZIHq5tCG+CRFh0JrxFvFre24ZKsRIyQ+
         hR2d7fqmIOCSEr+gSd930LOm14SHlayAyUucEWZ9Ep+iwO09uVmv5GGSi/q4k+4YQ5WV
         uNYqMdi9dDqtFgFXasYM6qNhiPZ9l326p5WRfiRV6RRFpqZT7ba+yKNHru/c8O0M25H+
         JBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9T8+kdIQXxmPiX39517lARW6zkwqa89pynqnDRsRmf0=;
        b=Bb6XobJV9Mxarsnlci3Wo61Y5Pkl9VTmEPOkB4Z7G6eYJaHiaUSFYjxbN6qIB2K07z
         Ml2FaoTayNPfzY2MIBfws75vOtLDezKUICm9WQUePfbs/89jwGv3FC934Yu6527sG9nD
         iCXC6ABcmzz2ApUwhpC+zdBtnZah4CQwWs/5yq6yJ94xT0DDUBHqvQq8unDHNgU7RP1D
         6WJcMHUvTkIvmWRYWc2nkgAwvwCg/LVBOLS4DhIf3bHkG1XwnxSilx3Wl/ORuen5jSAa
         qeUaOcsMsG41VcEiqXhoJ2OxS1wRXtA0YTYBU8PQZZZMcyC87+n9Se7SxXt2nT3rGwku
         aL1A==
X-Gm-Message-State: AJIora96eq3fN7jzV/6qlZdf5Q/CZLNWwD3J5Ifm4KkLCILqHZa34D60
        D47UHMBzKFnHJriqAByXM09PTA==
X-Google-Smtp-Source: AGRyM1v+e9KUYvA0k9l1OlNkGQmrVJVfrCM1qy3sWjo+5Gk5jRM48+pE9mMJB7oeG5kGPKvEEuj8CQ==
X-Received: by 2002:a05:6000:783:b0:21d:a4b1:e1f7 with SMTP id bu3-20020a056000078300b0021da4b1e1f7mr30291213wrb.157.1658312697823;
        Wed, 20 Jul 2022 03:24:57 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b579:e7b5:219d:267c? ([2a05:6e02:1041:c10:b579:e7b5:219d:267c])
        by smtp.googlemail.com with ESMTPSA id l7-20020a05600c4f0700b003a310fe1d75sm2201501wmq.38.2022.07.20.03.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 03:24:57 -0700 (PDT)
Message-ID: <2c34a4e7-1c33-1a02-f956-7478629ebdb5@linaro.org>
Date:   Wed, 20 Jul 2022 12:24:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] thermal/drivers/qcom/temp-alarm: register thermal
 zones as hwmon sensors
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220719054940.755907-1-dmitry.baryshkov@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220719054940.755907-1-dmitry.baryshkov@linaro.org>
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

On 19/07/2022 07:49, Dmitry Baryshkov wrote:
> Register thermal zones as hwmon sensors to let userspace read
> temperatures using standard hwmon interface.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Both applied, thx

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
