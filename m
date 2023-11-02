Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E8A7DF41E
	for <lists+linux-pm@lfdr.de>; Thu,  2 Nov 2023 14:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376642AbjKBNm4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Nov 2023 09:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376644AbjKBNmy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Nov 2023 09:42:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAB283
        for <linux-pm@vger.kernel.org>; Thu,  2 Nov 2023 06:42:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5406c099cebso1497906a12.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Nov 2023 06:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698932565; x=1699537365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJQ2jo+b5Qkq3Y2Odwegmv33MoxIrem3qGRlD2iLbtw=;
        b=Ce9hs8W5DSYifNslmuMMVmrcGY7cV/myUctHz7IrMMMgUjRmiKNjG738CnbfUSySz7
         VOXdzGDFZzH+WnfzMU7vVNPOLfSWOnzVASQiIMIBEZFo13t+4SXFXBynHQTTq1vFRxSd
         w08TifiSdI4Q+sL5C9smKqj01rmX5uqtXmeVc1zZKCT2hnGA2Sie+wh3NVuo3XUMsC5I
         TDZn2nSaDV4AqvweRcKdsGyJhUpdQuRgZR/BxGsT2Ddo+o/TFUZo/uHQpouqhUgm+Wkz
         h7ZnZk8b5+f7+kaP6HRdU79a4QDlXxR5C4yEQ8QP9XfPsEwd+sEq6wVsU6mTBNuA7Iex
         RgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698932565; x=1699537365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iJQ2jo+b5Qkq3Y2Odwegmv33MoxIrem3qGRlD2iLbtw=;
        b=Lc2ETuxlpjiCY+T1/3HaGJ/mjyNsBmdv9g+DNY7HPicKMuGMOCl04oEToP0eq5d3li
         VWMceC5HtR5KyLGuGWxf3Z4rYcXzUFG33ZU/D4bC9VpDr/1dN8HtebfRYyXUJpA8Iu6Z
         9Bt5GdkQ0exsTiOJjjwfkYygjE3I1kg9gTMap8ZatY8ylrUpaf1gEXaFGW+WOHhmjFID
         AIG4NAQhcCByMIKXgAP8DJYxS+Jmf0GN5huldGT0kI1qh0dvvF97bfvKKljXvEzLbHv9
         yssv76BLmPowdkmVBGCL92CzHImBtWkxQNHuUDjZ2EaHAK1NqpLjq1dAra3/mAMvyptR
         +VhQ==
X-Gm-Message-State: AOJu0Ywr1UzWlBwv2rpH2q9/U/Ojvf9aV1z9rqE74lH3dqsxJvFd4PvG
        Tnwh/HB3d+vGKMSvGT6YLSd22A==
X-Google-Smtp-Source: AGHT+IFB81CxcdzPfZmMQ4mqrKjuc+lV3+TUt6zJu2uTS9EGvGvTM7v+feVJ//Z6zFzUeAIfOr+stA==
X-Received: by 2002:a17:907:3601:b0:9c6:c987:4434 with SMTP id bk1-20020a170907360100b009c6c9874434mr3996848ejc.45.1698932565099;
        Thu, 02 Nov 2023 06:42:45 -0700 (PDT)
Received: from [192.168.1.118] (abyj199.neoplus.adsl.tpnet.pl. [83.9.29.199])
        by smtp.gmail.com with ESMTPSA id kq2-20020a170906abc200b009b95787eb6dsm1149466ejb.48.2023.11.02.06.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 06:42:44 -0700 (PDT)
Message-ID: <b00d10a9-136a-20a6-f9da-767f249a838a@linaro.org>
Date:   Thu, 2 Nov 2023 14:42:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 1/9] interconnect: qcom: Make qnoc_remove return void
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
References: <20231031222851.3126434-11-u.kleine-koenig@pengutronix.de>
 <20231031222851.3126434-12-u.kleine-koenig@pengutronix.de>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231031222851.3126434-12-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
> Several interconnect/qcom drivers use qnoc_remove() as remove callback.
> Make this function return void (instead of unconditionally zero) and
> adapt the drivers using this function accordingly.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
