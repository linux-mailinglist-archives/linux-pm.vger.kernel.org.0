Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB15366B1E6
	for <lists+linux-pm@lfdr.de>; Sun, 15 Jan 2023 16:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjAOPNr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Jan 2023 10:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjAOPNq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Jan 2023 10:13:46 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279E7E3A1
        for <linux-pm@vger.kernel.org>; Sun, 15 Jan 2023 07:13:44 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ss4so55447059ejb.11
        for <linux-pm@vger.kernel.org>; Sun, 15 Jan 2023 07:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aFcwOmEFlKwz+PgBDJg3oPEza0ShiNrJoHvCTAjQ6D0=;
        b=u5MeUGD1SllOGGSGeF0Ev6qqHPNz8QOA87zzGYt0CikM0TX9RbBDUdxzGXGov+KrSz
         /sAWYXqTulK7wz3AHsnsxRrUAtt9Czrg/Uio30iZp3W6q2f9Q/UDxS1n1wWn0nq0efoI
         TVXOiWyEPV4CdpJvDJnaDnqEHWhay/21Fk4TS57l2L7ai2BZACO71+ztpRj5Xrh/SdU5
         fHnOV9N+YJZAGCA3+5I7h/Xrzn4W9IYiG1VvX5lmeLQXILvOFSYq1M0cSvK9NOBDx0U8
         A3+XXIkZpuLFZxlGDs9JxLvHFbU80lA0NxoEGmXIOaKN7yeraJnRcn7YTNVxk3HPKGQX
         wyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFcwOmEFlKwz+PgBDJg3oPEza0ShiNrJoHvCTAjQ6D0=;
        b=btC4gS2rrPMwltrTfezRhXZPDwMq68wpJ8NmB6bI748Gqh1mJHY7/9piScik+Ip1Po
         XQ9nYBjq7OMp+LggCvdXTPlxY850K/JSBku192EScvMnC7oc8OTP4BzyzBSNHCQMwU7j
         RvBFwAomy6/En15gh2XOM7QO26qLJos97AQVQ6Vsf4QOMhRzTHJY58ms8rMeRDjdhYHx
         A0sRkhf85QZpTHsjtnLPj6DC6yOOYlk2ld9j43Gxi/qIv5KMsoTJtF00h4/qPkIfJmMZ
         K/3qfs67Z6ARas4BXvzD/UvGRNsplBvJkNEKl7PHjadQPX94CSE4H9OjSZs6D2REwd9l
         lMKA==
X-Gm-Message-State: AFqh2krNBdhzc5VSFG2E/4vJsKnqViL347+qZDyzuc6a7DMiJkTOXEnn
        yuNP5QH9ZHicMtDypsdAfzhdIg==
X-Google-Smtp-Source: AMrXdXu/F/jtw1O3KaRZM9kWFq1sZIWwFot/ex8kGfpUsTUc8dsdAEHIVbOCwskmw4xisrO7ttRaGQ==
X-Received: by 2002:a17:906:6881:b0:84d:4d6c:a462 with SMTP id n1-20020a170906688100b0084d4d6ca462mr21181417ejr.25.1673795622740;
        Sun, 15 Jan 2023 07:13:42 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e2-20020a170906314200b007c08439161dsm10694392eje.50.2023.01.15.07.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 07:13:42 -0800 (PST)
Message-ID: <dc5487d8-d31e-28c6-07e8-8d1ff54a4ba4@linaro.org>
Date:   Sun, 15 Jan 2023 16:13:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sc7280: Add cpu and llcc BWMON
 (=> interconnect issue)
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
References: <20220902043511.17130-1-quic_rjendra@quicinc.com>
 <20220902043511.17130-5-quic_rjendra@quicinc.com>
 <Y8Ggh6RObbB1cxSS@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y8Ggh6RObbB1cxSS@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/01/2023 19:18, Matthias Kaehlcke wrote:
> Hi,
> 
> On Fri, Sep 02, 2022 at 10:05:11AM +0530, Rajendra Nayak wrote:
>> Add cpu and llcc BWMON nodes and their corresponding
>> OPP tables for sc7280 SoC.
>>
>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> I found that with a v6.1 kernel AOSS on sc7280 doesn't reach it's low
> power state during system. This can be observed on herobrine based
> boards on which the AP_SUSPEND signal should transition to 1 during
> system suspend. If it doesn't the Embedded Controller (EC) notices
> it and wakes the system up again.
> 
> Bisection points to this patch, the issue only occurs when
> CONFIG_QCOM_ICC_BWMON is *not* set. One might think the patch shouldn't
> have any impact at all when the driver is not enabled, but it does.
> 
> Debugging shows that the issue is interconnect related. A bare platform
> device is created for each bwmon devices, which results in the average
> and peak bandwidth of the interconnect link to be set 'initially' to
> INT_MAX. The driver is supposed to call icc_sync_state() during probe,

This is for interconnect providers, not consumers.

> which would set the initially bandwidths to 0 and determine the actually
> needed bandwidth. But since the driver isn't probed the initial
> bandwidths stay at INT_MAX.
> 
> This isn't actually an issue with this patch, but how the interconnect
> framework deals with devices that are registered on the bus, but aren't
> probed (yet). Not sure how this would be best fixed. Georgi, do you have
> any ideas?

Why the device is not probed (yet)? If it is registered, it will come
soon during boot up.

Best regards,
Krzysztof

