Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0167DF426
	for <lists+linux-pm@lfdr.de>; Thu,  2 Nov 2023 14:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376593AbjKBNnU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Nov 2023 09:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjKBNnT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Nov 2023 09:43:19 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B4583
        for <linux-pm@vger.kernel.org>; Thu,  2 Nov 2023 06:43:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso1617842a12.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Nov 2023 06:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698932592; x=1699537392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3WVZP4by4Qof8E3th3hpCkIkMDZJffpQTY4IDXBxVo=;
        b=l5pt2thb9Q6O1GXvGo2kS9z/O/oIa5807gKSXGD7mjqLdeGhc/axNk7pXh9a7Y5djT
         +QdLD13OTpeJ1a2T3xttpTwPrnXld+kCEB2Fs7f0rKJcbHgMNLYKBJoS5KZsA23fA1rO
         goy2xEbzLIWeznh0UTZp5BN1TEgZ/vcjI+0sM7sII+qtgTi7itas8m8xpuqFZyTAm9fH
         0beNoeZfduCkCtwfgUiA69m6UyEclU2yX2oU3CUukqf7GlOP4wYnrE+Q2IAg9lrQFfS3
         o5YqIUYxc6tPEzJOQWZU8DxNcmQv2ziIa69ZZnuaY9Pe2RlWqvoeDGuMJT5wge8/59CD
         P4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698932592; x=1699537392;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o3WVZP4by4Qof8E3th3hpCkIkMDZJffpQTY4IDXBxVo=;
        b=T3UtBTzbI+K1MsOmMQScAib1ngqHQw5qcC3gOFe81FnQpd3+Mw22Es+RDsik98lowU
         TkGmZp1f7cL2vXyJnPFC6bFBYtLqq/VRV02ndbiDy6tPQexXhvTQO2bP880AvpUQVm8E
         DepR6JFSmYv7/1eF2SHJG1NtgmDe8gTizoi+qOyqYt/wDiWmSIL9S5kwQzP+kYoww4L1
         zNlPJdccTL+uBGwRCPjmfOn1KfD7OqNR5sl4yXyLoz1gducthFmhp+B6fuJO6mIGCAw7
         Eokr1S3Kk0mkurGkZFREON8Cpx7+CScIufIfO6MrbtplPaZq2IcdHTxxQL8BYF3m2LW0
         5cGw==
X-Gm-Message-State: AOJu0YyIPMIUPCl24LcqLvTIORoAd4mqLFz9xTTgfnymRFWbimS9wS/7
        G8vDlwTeSx/hGTZaAMEyOqMjNY+g4bBY+3rh6dk=
X-Google-Smtp-Source: AGHT+IF7KhBczRIzp0f32xHgwLkeONwg7LBSVajQvEvC03e9+L2ABo7jWY1fHvonvehXqaHaaTQa+Q==
X-Received: by 2002:a50:ab12:0:b0:543:5db5:2fb7 with SMTP id s18-20020a50ab12000000b005435db52fb7mr6756111edc.6.1698932592310;
        Thu, 02 Nov 2023 06:43:12 -0700 (PDT)
Received: from [192.168.1.118] (abyj199.neoplus.adsl.tpnet.pl. [83.9.29.199])
        by smtp.gmail.com with ESMTPSA id v10-20020aa7dbca000000b0052ffc2e82f1sm2331699edt.4.2023.11.02.06.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 06:43:12 -0700 (PDT)
Message-ID: <be52912a-f9b5-c998-f972-6658252ac837@linaro.org>
Date:   Thu, 2 Nov 2023 14:43:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 7/9] interconnect: qcom/osm-l3: Convert to platform remove
 callback returning void
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
References: <20231031222851.3126434-11-u.kleine-koenig@pengutronix.de>
 <20231031222851.3126434-18-u.kleine-koenig@pengutronix.de>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231031222851.3126434-18-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
