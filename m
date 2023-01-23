Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBF7677C1C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jan 2023 14:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjAWNDp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Jan 2023 08:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjAWNDo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Jan 2023 08:03:44 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C4814E83
        for <linux-pm@vger.kernel.org>; Mon, 23 Jan 2023 05:03:43 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso9054036wmn.5
        for <linux-pm@vger.kernel.org>; Mon, 23 Jan 2023 05:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zaX0gI0/ZktxsTJ1ltyBOzUuyo84ob21wz6E7O6B+2w=;
        b=gtduIFeibsORW/y3pwoBVh8NSDUcIWKrmMxVqFKZyjD0Xxfo9YQs3zSVKkFZ2bUc+8
         I1uO6Ml/Xg6Vm8NBwKANOrgqeTCl34mEYAoPDVnb0CEI6SDhJL5WvZIwNLXHqZ9dKYkc
         cEd2qbMw93J34xD1Wtm9Ascz+2RBsJRZkmYpBMSKnnyt3xYmlP8cSEG1g30xHstBv95Y
         ikbonLRDw2Y5bBt6zNK9l0/Q+d+zrW+4FjcfcNco3vHJaAZQIbDea2rRlbfApkgvaG0r
         wjRuUFdZrfPhnl7BGFhDeR083B/payaCrPb93B1ooM88Kgwi5qVRL7hzUp4SbOVRgCZN
         bw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zaX0gI0/ZktxsTJ1ltyBOzUuyo84ob21wz6E7O6B+2w=;
        b=8GWKkrPC8yu3S9E/O7U2UEK+VJ3z95qaAWWyMjsfadu3uF+/zsExhLd8rY1MopycgD
         sjugOj1TA/mdFUdMtCOjXBD4in7hFqH8TYmOgEphjJrl+8Pu83MTACg7ss8S8Bo2nUbl
         UHAYEJCQVB7mLiVEcyKaI/HVZJYyslJ51Y/vWr3qqTihtZ7O+6QGTIWUS35V8ZxlWzbw
         3rrSHNOQs3zFZG2JO9aMWWQNHjcG0wC/gDLruEJXrTdQ68W/yuXNjvCoBXX+hfjMF2ew
         KZifHElF8FO5LZFHtbOglwgWMfBoIUvLL+A0lp6AF8HfV+dQReVCleve9jtldE6//Xgu
         T3ZQ==
X-Gm-Message-State: AFqh2kqvz4EO4yRHlocEq0dOlWk2zOaVfHOL2BLiKb1Sdk19z4LqVa+f
        Mf1Q2uCSgRU0m423p4Kr4WeX3w==
X-Google-Smtp-Source: AMrXdXvClwHfXDW+e6ScZ+irhQ83QlbY+vHsw/aMa+9Cj9j4Bg4nTDUFZOkEOfgX/zAxE2UCTUxFSg==
X-Received: by 2002:a05:600c:3d16:b0:3d0:6a57:66a5 with SMTP id bh22-20020a05600c3d1600b003d06a5766a5mr24048487wmb.0.1674479021800;
        Mon, 23 Jan 2023 05:03:41 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003da105437besm11443558wmq.29.2023.01.23.05.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 05:03:41 -0800 (PST)
Message-ID: <f36c7095-592b-a4e2-4d76-09632efcc63d@linaro.org>
Date:   Mon, 23 Jan 2023 13:03:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 0/6] Add MSM8939 SoC support with two devices
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
 <42baa874-c926-9111-b0b3-2df2562d8de6@linaro.org>
 <Y86CPmgvAi+kChQI@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <Y86CPmgvAi+kChQI@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23/01/2023 12:49, Stephan Gerhold wrote:
> Also: The undocumented "register-mem" interconnect is still there. 😄

Ah indeed. 2:30 am email rule
