Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8BD53B80D
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jun 2022 13:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbiFBLs2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jun 2022 07:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiFBLs1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2022 07:48:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F06429978D
        for <linux-pm@vger.kernel.org>; Thu,  2 Jun 2022 04:48:24 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id me5so8935218ejb.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2022 04:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=shtQh66+bKE1caS4jMSRSwf+vIlH6pzW/iS7K92y5Eg=;
        b=dc99xUHQThcX6ryKAYXNpafER9Kk4IqWJ4hIN06w5R5rjWA84E5p4P72DZDYGBswsI
         kl3C21BvdXefH2LnJlT8rU/+JezOsqjRAd7tVk97vXLFhMeDIOIeP+/Hp1s8R6ceOle7
         uJyWHNIybbL9JlE7dlJkzTO14TjU88UJAYcAbnV1SoMbJUDCi4gpZvk1mcW9ONfryXbq
         ORVmAj8kEwf7k8Tdd5l7Rqpt5iQBFZoY0eQzfumt+hDyJ4nLrjHN3GpDX20gJiG5a5se
         RMEgmqvFaNz8hsnSvQNIVgD2JYnNez5HZ+pn120+o00MrgoJA0GpTygS1KP0PIywXThn
         JVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=shtQh66+bKE1caS4jMSRSwf+vIlH6pzW/iS7K92y5Eg=;
        b=N2g6GH7wCuVd/z45PR6cxQV0OBcW7KQT2a5qbYBE+YJvMkm4TvQLiwwlecuPD6nvry
         Z1pdhDSC4z3wdB58DYu25vS64/gooMkn/c49rkwBWr9eHZb4nBVJZv0WadTOOn0d++gR
         HlwG1YW/URlU5NqvdwPDtdxVdjETyBSfrR66nkmyU1zUssSVxvtxyw7GipXUR9GiYfIQ
         6Sk+PCrfkA4ah2xPRBdzxbzZvVO4/hkOW67SEOljn+4Rn6JkNtMr6SCIN5QvYTGbYNuC
         Suk2i6eGISXB+rOFp4en4WVH3UqDUQ6alQgMpJxNpIkgL/9tiyiFqprRPhTXv8jml/EP
         SgpA==
X-Gm-Message-State: AOAM532nHXJ8DoFJ0oq9TOx+hO9gZcm8HBJWHHHvgvMX/EiyHs/BTQF1
        47AcD1F6JNqi0TXVP+8wuB9I9w==
X-Google-Smtp-Source: ABdhPJxtzQcCHEhLjniV51EOj16IsDhDJgdLjg8JxuGS0HDjPnelZO6FqkSKvw60weMLoHwb6tlJqQ==
X-Received: by 2002:a17:906:12d3:b0:6f5:18a2:176d with SMTP id l19-20020a17090612d300b006f518a2176dmr3728521ejb.474.1654170502863;
        Thu, 02 Jun 2022 04:48:22 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c18-20020a056402101200b0042dc6e250e3sm2329738edu.81.2022.06.02.04.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 04:48:22 -0700 (PDT)
Message-ID: <cb8c7e28-dfef-78e2-c97c-11b9dee02fed@linaro.org>
Date:   Thu, 2 Jun 2022 13:48:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: Update email address
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, bjorn.andersson@linaro.org
Cc:     agross@kernel.org, djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <1654130923-18722-1-git-send-email-quic_sibis@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1654130923-18722-1-git-send-email-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/06/2022 02:48, Sibi Sankar wrote:
> Update email address to the quicinc.com domain.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 2 +-

Thanks for updating the email addresses. All three patches should be
rather squashed to one (and taken by Rob for example), it's quite a
churn. Anyway:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
