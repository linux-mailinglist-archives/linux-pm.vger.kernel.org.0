Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD96631397
	for <lists+linux-pm@lfdr.de>; Sun, 20 Nov 2022 12:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiKTLNk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Nov 2022 06:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiKTLNe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Nov 2022 06:13:34 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FCA15FE5
        for <linux-pm@vger.kernel.org>; Sun, 20 Nov 2022 03:13:30 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id u2so11739082ljl.3
        for <linux-pm@vger.kernel.org>; Sun, 20 Nov 2022 03:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfbStBxanXNxkhy7xdJiqPZKJHP3hmr6NUjVL9mVGnE=;
        b=mJ/ju7Oer5Qqu7iM4Ke3VwsgMsCvFBzIWDH/+TwRmrzc6+8kg6ZvswY+U26SOlWTlf
         7wQOOPSD0ocye5DoWba3/PUcAZiXtZlPbNkPpoYDTROIA+ZvxUSO690Ed7YVv0zIuNqy
         KVgdHgol4eSSqJcDjKAmTPNUo/ZvolwofuGYSWOgadVvDojgZ/gcrgyBIDic8dAWJtd8
         AQkHKY1+1o/xjEMiVUtCmPnqR3H+pm+PHIqHeh0qGb9pBsiARHRigx11asEjfoBy2F0q
         tiFC6yFoesco5Jfzlgj4HW4ZosweNHKwUMJCwBLZaMBbObiwpAyWP4K2UUuB8oULFim0
         oeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfbStBxanXNxkhy7xdJiqPZKJHP3hmr6NUjVL9mVGnE=;
        b=38CdBd4ySHEWn5ATo5UWDmsxUCrwiE/1z+vqVLZ4QoDPwb0uYHcNOIttpog1B95LF8
         PKnjsjMCl80lUNamsyNQxfiwqN1ca66dNkXmBGoRbWTXbAyUUhie9z20YEf8GXlCq2gj
         c/QKsMmVvkPhfqp+oTHv6VA7p0dzAgM2p0JkQMnk5/JOC8tTQvOPyTs6tobleE7YZU8A
         imcmTgL/aMmBNl0MzRCwVj7xjo1vlTOTlzPkRnpKhT/UpNz+EOXXMsJVzugCl+seSCM9
         GynnmkxtUajWItgZS0bNJiW7sb4PJ4PKTTlYQta2J/wytfiI592Qd1wKg9jbOWO7D3FC
         gVeQ==
X-Gm-Message-State: ANoB5pkQ/VBDBNnZLsxxt6TF01NFBIvJKmLfmZgQwECk8z4NYGNMD3sU
        jMsZ6hgn/WbwYUi13PWFfTY1Fh+zaXW4u1o3
X-Google-Smtp-Source: AA0mqf6f66PCRQgqtNdT976hGTlPlmoi+WfjEE9hQQQ4Rtk4J7wGIw4HqxLxd7BnurCTthHC74CXyw==
X-Received: by 2002:a05:651c:1105:b0:277:3dd:e32e with SMTP id e5-20020a05651c110500b0027703dde32emr4126189ljo.467.1668942808658;
        Sun, 20 Nov 2022 03:13:28 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bf8-20020a056512258800b00492b0d23d24sm1515423lfb.247.2022.11.20.03.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 03:13:28 -0800 (PST)
Message-ID: <303ecda8-5b02-27c6-ac2c-52fed0923de5@linaro.org>
Date:   Sun, 20 Nov 2022 12:13:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 2/3] dt-bindings: interconnect: Add QDU1000/QRU1000
 devices
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221118182245.31035-1-quic_molvera@quicinc.com>
 <20221118182245.31035-3-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118182245.31035-3-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/11/2022 19:22, Melody Olvera wrote:
> Add interconnect IDs for Qualcomm QDU1000 and QRU1000 platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

