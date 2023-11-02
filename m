Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF69C7DF422
	for <lists+linux-pm@lfdr.de>; Thu,  2 Nov 2023 14:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376617AbjKBNnK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Nov 2023 09:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjKBNnI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Nov 2023 09:43:08 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1334018C
        for <linux-pm@vger.kernel.org>; Thu,  2 Nov 2023 06:43:01 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54366784377so1500059a12.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Nov 2023 06:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698932579; x=1699537379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3WVZP4by4Qof8E3th3hpCkIkMDZJffpQTY4IDXBxVo=;
        b=PZI5cEI1fb8NtOBBWWMxbfYvWLPLfaGoBGly56W8+RBMsKNrFzmUsGQWw/0GmYb7E6
         lYLtLLXmrcBEOw/9H9gdwrq+TtdV1q4SIVzk/rGvlDD+//DXBYYJKjTg7TYjjRO0jD/p
         4y2lYgXDoHLcKu6PUgebhwp63SdcLK4HlMJZkkCaIYGM57ICjMOxVkOYVSQzs9kw8g6V
         hzh6F+wAiTmA12+bc/FJE5wLASdM2tfTDsz0zNkjbClGOOTbiYGwwCXrEqu4y7ZZw6Vq
         lKXESeq8B13yUQU8mcbkxe1E6bfmi6QSzirJ4yQi8fM3m+yXzko9CkDb3zn0Y8ILiVT+
         EqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698932579; x=1699537379;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o3WVZP4by4Qof8E3th3hpCkIkMDZJffpQTY4IDXBxVo=;
        b=oadCaG7cYtU/bBYKGgdz45cIVF4vhhyeNzHGdREirokT3E9XviZwBo8TmJPR5Qimt4
         +Mse1Pv4F+3rW/QpL/4XXRDT4fFoQSs9lbL/TE71ZT8UXhWEIMOn7b4ebDihtqORbL09
         H+MSI59r88EizEdeIXS2p1/dIFPszVhhQkaiDUrQ/TTCJ1DH9JYH6lz44JrwKhWuwyWj
         vHxCspyGWxVHqcUoA7ptFBtq9ECjm1FFQJqiWGbhNFE4Bs9lhOs5cUBByiDIxyjldy0j
         OEH7jvzbFcS6aJ/L2b2lTlWGZjDz1ETwhVw6T2B96PTKtnp2gl0CyWq781ACWnPwkQeO
         ClWg==
X-Gm-Message-State: AOJu0YwimHPPOHIXTVnoe2F9rtHtBaTnQQeqjP8YvmuGczrf7stL3WJe
        ZieR6TR6dP3D7cA4QuInMK7aKA==
X-Google-Smtp-Source: AGHT+IE1R9m7wA2ospdHgbxWQC7M2Y2sxdt/wSAtXUq8laMoocu2RO8DZW5ZE6uynE/ivVE42k+ylQ==
X-Received: by 2002:a17:907:94d3:b0:9d4:2080:61d2 with SMTP id dn19-20020a17090794d300b009d4208061d2mr4630208ejc.2.1698932579402;
        Thu, 02 Nov 2023 06:42:59 -0700 (PDT)
Received: from [192.168.1.118] (abyj199.neoplus.adsl.tpnet.pl. [83.9.29.199])
        by smtp.gmail.com with ESMTPSA id e7-20020a1709062c0700b009b654751c14sm1145776ejh.47.2023.11.02.06.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 06:42:59 -0700 (PDT)
Message-ID: <af65633f-bc7e-0054-230b-cb0ec3d85064@linaro.org>
Date:   Thu, 2 Nov 2023 14:42:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 6/9] interconnect: qcom/msm8974: Convert to platform
 remove callback returning void
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
References: <20231031222851.3126434-11-u.kleine-koenig@pengutronix.de>
 <20231031222851.3126434-17-u.kleine-koenig@pengutronix.de>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231031222851.3126434-17-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 31/10/2023 23:28, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
