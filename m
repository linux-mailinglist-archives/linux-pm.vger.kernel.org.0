Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF3250E82F
	for <lists+linux-pm@lfdr.de>; Mon, 25 Apr 2022 20:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244352AbiDYS2y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Apr 2022 14:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239140AbiDYS2v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2022 14:28:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387C3283
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 11:25:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k2so1656348wrd.5
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 11:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QZoBPC8Nkhk5k104wkau4dObrEjdqxzPZb/mWYZPD08=;
        b=wAIjqikbcmTsGb3Jai6rhk+RkX19w89yVPsullHUPhFvojJOeGVZ5RPdo2fpa4cvLo
         dEnJik4nMtb5jPFSr0KDgxm1ffSMex169d1YJ0S5JrCyYu6CIjCM058TlVyExmX/ZV/u
         ealkHg2TwTq4pVf3Xo+YlypEGJybfu+C1JX41+5Jc7qwBAi3j3z5rkafMuB0BmdcrK4Y
         H17EPMVV75WfPiDsZa1u49FcAox6Dd8R0hNPzifJF1fr2/moXsV96Z6Ezo3kaiuLO2kU
         fQ2aFtoV86ilqTJiO6IjC4+C6IFl1qiwLgY9WzcmChQ2FFTK/jxSW1ztpFFMt63SXWqg
         TQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QZoBPC8Nkhk5k104wkau4dObrEjdqxzPZb/mWYZPD08=;
        b=t7otHEZwpOXfC4xX2pYDxy5LDeYHTep0XLIHBt9kWSjic/bNHWUHYL/PkudsldnTba
         SK/2Vi77Iin1++MQZDq+xftgoNF2MGXzsWLKy24MaoqMNrQc3xbcxSKCOBNQuLLF5uNz
         PkhfpPZy3KFARsTQGpatfYXJwztfMheZaa6Qf3VPPO/I+ZNbSnWt5jnuyBWmQOdQMeoG
         0en+2h8vG9OcXRhwk2u4clJKkgKFgz8dQEp/pRtNtG9UsSm6K4skrpYyPguBM4rcbOlp
         1yi8c9D82qNDxNEzWOQ3xd3URqQs4Jt3b92+PP1aBU7ZvegVVRP1KEPHp9s4G8Vgilbn
         tyhg==
X-Gm-Message-State: AOAM530+tX0vvDluSc5bpIlyyTAU+jFZ5V2vAgBr75QvrAfUvKJzcQMe
        d/i1q5DTb3SvTO3pCzB62wK5Vg==
X-Google-Smtp-Source: ABdhPJx1RHb2igDyXFNSmlueXh7psE8Cvjcy5JGDZx5hzrA/yet6g0mYbEs1wL4zseEKQm6y6R1Tsw==
X-Received: by 2002:a05:6000:144c:b0:20a:818d:e3c0 with SMTP id v12-20020a056000144c00b0020a818de3c0mr14907941wrx.584.1650911144763;
        Mon, 25 Apr 2022 11:25:44 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id k65-20020a1ca144000000b003929a64ab63sm12452187wme.38.2022.04.25.11.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 11:25:44 -0700 (PDT)
Message-ID: <9243faf3-69af-eef4-1e48-867f88cab5d6@linaro.org>
Date:   Mon, 25 Apr 2022 20:25:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] thermal: broadcom: Fix potential NULL dereference in
 sr_thermal_probe
Content-Language: en-US
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com
References: <20220425092929.90412-1-zhengyongjun3@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220425092929.90412-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/04/2022 11:29, Zheng Yongjun wrote:
> platform_get_resource() may return NULL, add proper check to
> avoid potential NULL dereferencing.
> 
> Fixes: 250e211057c72 ("thermal: broadcom: Add Stingray thermal driver")
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
