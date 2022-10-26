Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF58860E3D1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Oct 2022 16:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbiJZOyv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Oct 2022 10:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbiJZOys (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2022 10:54:48 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21D7DF75
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2022 07:54:46 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id cr19so10086377qtb.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2022 07:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=maWypIlUNRQImlFt8IOBRCfQffbBnX1XZA77vfFeGis=;
        b=x0boBOpFEuAAbdJJdBwPBV2y6SFbtFG9IIaMdbFhxC2An9hMa+mfJO/wnc4rJPYge2
         5SyC4VtTZNN9Z8IdkLfFb0bup9LZ+XgfE6XjXPUaAPXgBsxmROJn+N/tG/lsfOq6NKLI
         mF5lEa43cBOw3xXyb8vBALIE+KmPj+Jk7r5qzZ9JpEayYHrck5J3jUTuB+vSPvYyCGUi
         ZbqEddMoi37IfN90kdLeVvBdU+C6j7cAm7OIh9wqW9K8wzRhQi/qxrfhLamRomVnfi5S
         0Z3agm5/qvLHrlDD3ViI9oqu20yBKB3yWCwA+BFLwb4CYChLTiVEAPtM4rXi3SkXJWRd
         TlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=maWypIlUNRQImlFt8IOBRCfQffbBnX1XZA77vfFeGis=;
        b=No+qlfNKmqMLG5KXkWcBHOVbpL050QeV8pOp+A0ceIrSoxCaye7sHyZf/2rj24PlLJ
         FCFrsvNIB7GQExiELRil+iL540qPqdogPI2ZGBVlTUxHOCVY+NpxoxRc7iCkM6bvAzEa
         iCxAyqCnhKvX+2VwnIwULbccpinNeRwBak9qAfpK1l+/IKhwupZWuyIHmO8NbmUu3vMv
         DxFnZ6pPIPuGH1QtOVgKPfAPcfMOlJbY6oaQ4iYTSIZmUHDjyCju6c3oy7r134clGOsj
         bacIoQczuRmouhuBP/i4xwT1fp/h+N8w3D4xgRbasdDgoTlsjc1wh+ydM9lhnpLM+gPm
         OBtA==
X-Gm-Message-State: ACrzQf1Ig38hO0aZeMdxYc79874mU3a8aKEgTu6FOvfKMZypnNDNv7VA
        NrNWD5G3SuSo/37Y/X6YdpnCRg==
X-Google-Smtp-Source: AMsMyM5V/3LE82C/jHm/q6UNMC47f/vDs71jqDRMUHg476+Ylo4FUg/rGSzbf0vqzwmGIfpbKKes4w==
X-Received: by 2002:a05:622a:10b:b0:39c:e3ae:b790 with SMTP id u11-20020a05622a010b00b0039ce3aeb790mr37715488qtw.306.1666796085685;
        Wed, 26 Oct 2022 07:54:45 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id bj7-20020a05620a190700b006bb87c4833asm3903320qkb.109.2022.10.26.07.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 07:54:44 -0700 (PDT)
Message-ID: <8ff8ca86-3e6a-c690-c2ac-49d978ff6669@linaro.org>
Date:   Wed, 26 Oct 2022 10:54:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 05/11] dt-bindings: thermal: k3-j72xx: elaborate on
 binding description
Content-Language: en-US
To:     Bryan Brattlof <bb@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>, Linux PM <linux-pm@vger.kernel.org>,
        Device Trees <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LKML ARM <linux-arm-kernel@lists.infradead.org>
References: <20221025191515.9151-1-bb@ti.com>
 <20221025191515.9151-6-bb@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221025191515.9151-6-bb@ti.com>
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

On 25/10/2022 15:15, Bryan Brattlof wrote:
> Elaborate on the function of this device node as well as some of the
> properties this node uses.
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

