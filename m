Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4653F6BA916
	for <lists+linux-pm@lfdr.de>; Wed, 15 Mar 2023 08:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjCOH2u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Mar 2023 03:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjCOH2d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2023 03:28:33 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4775E2597E
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2023 00:28:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eg48so12510674edb.13
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2023 00:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678865282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HoMNqIZg63BCmS5MP4kOVeZdeqcwuh/YDGzstKQSmrQ=;
        b=ePgYHOtnTEHnGfwjrj6NORHXidC8GK5ODz45EUH5AmG5REmD0wqt7YisytZidQ8RIM
         uvIeBRkbNEeNwP4tXiFB1lOtU+AavIxEsm0vJZMw2TvIjEET4g/DCKedFfJJh5e0O/j7
         k8IKxnX5c8C3PyeEsfa5yIY03+ulh21CDiaaQVtdImNiXpFIoIFJ+jQlo6vrf4Q6j2it
         TuLThUVzg3idClZojJtt5R5yNS02b7NQRPcwYMDBBIrJYvZVYNDL1k5H4pL5aXA+vD0d
         UkvioR4Q6/h2UdlTsFlaTS9ob15dCEij/nQ3MzAJTRAksoqiT5nC0MMH/9ijqP68bdg7
         Y6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678865282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HoMNqIZg63BCmS5MP4kOVeZdeqcwuh/YDGzstKQSmrQ=;
        b=Y/hWKrD2LCzgrMnTGgN/9Aizv4ELfOo+tzTRzIUZYE7bphyRN4lUIKnSMOWjQerde3
         mgCtPlaH5YDoB+6GqAbKXrufRha+XWrdNOlZGmYCF30A1A/cOEh2rNSYfsv6POs2Dn7H
         eGxxHC30E7ncBjE2Xd8EwobEGnljA80r/Mda6lGYhHidFHuk0RmIagIr3wcHVQxAMEqg
         YvsXe6zM0jaZNfbbMrKEIeZqedSJt4GgM1jos5G3qeISo8WoaDOTmq+KnemHHypdBkrn
         OOfsF2Q/yARFzQhJYZkn8tkf0ivIpqvSDmlAgQ02w1OCxLEy+k9Mwx8Q/67jlqJQYhmL
         ARJw==
X-Gm-Message-State: AO0yUKV1GCCzRushpUl79VBfjM35zeEUsEISvD8aM+DbRBDoouAGBJPg
        lfk6K4Gz6F6m/NPhdJEZqMi7aw==
X-Google-Smtp-Source: AK7set9fbaglU2nLyCU1L3N6T+ltQzjPMvv9M78oDy98TIJif/mD/y0/j17wSWbshmrC0Bb/xOYwuQ==
X-Received: by 2002:a05:6402:114d:b0:4fb:e9b8:ca5a with SMTP id g13-20020a056402114d00b004fbe9b8ca5amr1677069edw.40.1678865281726;
        Wed, 15 Mar 2023 00:28:01 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id n30-20020a50935e000000b005002daeb27asm45172eda.37.2023.03.15.00.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:28:01 -0700 (PDT)
Message-ID: <c4843925-e592-61ec-6a23-0e6cc407e331@linaro.org>
Date:   Wed, 15 Mar 2023 08:28:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 5/7] arm64: dts: qcom: sc8280xp: Use the correct BWMON
 fallback compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230304-topic-ddr_bwmon-v2-0-04db989db059@linaro.org>
 <20230304-topic-ddr_bwmon-v2-5-04db989db059@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230304-topic-ddr_bwmon-v2-5-04db989db059@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/03/2023 12:41, Konrad Dybcio wrote:
> Use the correct fallback compatible for the BWMONv4 with merged global and
> monitor register spaces.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

