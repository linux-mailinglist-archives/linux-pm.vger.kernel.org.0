Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB914C49BF
	for <lists+linux-pm@lfdr.de>; Fri, 25 Feb 2022 16:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241785AbiBYPzL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Feb 2022 10:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242461AbiBYPzG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Feb 2022 10:55:06 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8B91D8A87
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 07:54:33 -0800 (PST)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 433C63F1C6
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 15:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645804472;
        bh=ouYw861PBb4TrQfZvscDmF7VmBdgdNmfagROVWpjg6Q=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=eb10NVJYId60LXHeXZ029yamG5C+m+e6HR8DDfm8IAZnkWW5F46b+I899ggt8kUFK
         jAwAsTR+6pOCDObrXdpTflIcHemnOs6OC+XQfhK9edKLdCcurk2ocS/ybqEtCkpawV
         Q182Z7jPMLW9565CjdLBK0D9JNgzdJU16GkP3OefSzw8a9+U0QORDJEUjlhI4ozXZ5
         BSXei2lBfc7ra7hfia3xmmvWk8pIc8PbWeQlvh+Z+g0pX9GaJUy6GNgS4iN9bgLSyd
         movZCR1+JI/5sM30Gpm252tUOgbNT+ZOFjRF1rXNbCNUUignXxOZJas/ssMpzSQ5Wu
         gGZZxO7taa/5g==
Received: by mail-wr1-f72.google.com with SMTP id m2-20020adff382000000b001edbdae0527so1046132wro.2
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 07:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ouYw861PBb4TrQfZvscDmF7VmBdgdNmfagROVWpjg6Q=;
        b=M+84ho1BmeN0JRf49uZuQWvdqUPo0VPzSpTN1qHZm+mGwb4ZTSjANbZMZ9SgcqpSOJ
         fvJPlY7AY9xjBqZCe8H9rUnTQMiZ4FHk+EnQtGQ2she1nna/ptzPKsxhS/YuMEhPrrXv
         cTBdhxGKEl+FEJhLHPrVmbXo/Al0oB3xAN4m5ltGamtSy3rlgfSyPUpYYYMObsV+Q4pO
         EmiU37+KnlpaDb3SJ+l0TP2MCbrwKRGvQ8XEC8ErOoYQR1yZ1kDWU8tDJmf9eqCkgtr2
         3NiGUPfhukIDVaYRST4KZUN7srJlSlNmuWs5pEcKC053ret3anAQzgm6f/TzAzcdVTBD
         7n+w==
X-Gm-Message-State: AOAM533cv8dvbur7gg4yiLx0zvPscZBDMeYtNFIqwiL8xifNm4IPz3B3
        n1QUY3omNQVk1Jed4mV5i/10DrJIC3mBetfLrTfGu5h6c/B8ltBwkQKFpEBKvcw8imieX7MMKNx
        OHNhmF/7MDBX3B8QvLPVLl53fCUr8KoaRCOBz
X-Received: by 2002:a5d:584c:0:b0:1e8:88b8:419c with SMTP id i12-20020a5d584c000000b001e888b8419cmr6975726wrf.96.1645804472041;
        Fri, 25 Feb 2022 07:54:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSy6zmHkvN0jOvBdaFqnPofjL1tVeT2Ad/dBAi2F04eFTRfUM9AEDrUny0g3KKLPCrwn+JVg==
X-Received: by 2002:a5d:584c:0:b0:1e8:88b8:419c with SMTP id i12-20020a5d584c000000b001e888b8419cmr6975716wrf.96.1645804471886;
        Fri, 25 Feb 2022 07:54:31 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id q7-20020adfc507000000b001ed9f31afdcsm2593072wrf.3.2022.02.25.07.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 07:54:31 -0800 (PST)
Message-ID: <ec083f3c-b4b8-c3d0-fab3-2af5c4195d90@canonical.com>
Date:   Fri, 25 Feb 2022 16:54:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: qcom: Add sc8280xp binding
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220225042710.2317732-1-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220225042710.2317732-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/02/2022 05:27, Bjorn Andersson wrote:
> The Qualcomm SC8280XP platform has the usual set of busses, add a
> binding for these interconnect providers and port definitions to allow
> interconnect paths to be expressed in the sc8280xp DeviceTree.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../bindings/interconnect/qcom,rpmh.yaml      |  12 +
>  .../dt-bindings/interconnect/qcom,sc8280xp.h  | 232 ++++++++++++++++++
>  2 files changed, 244 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,sc8280xp.h
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
