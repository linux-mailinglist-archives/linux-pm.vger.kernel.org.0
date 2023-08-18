Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590E37808D5
	for <lists+linux-pm@lfdr.de>; Fri, 18 Aug 2023 11:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359392AbjHRJlM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Aug 2023 05:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359369AbjHRJkt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Aug 2023 05:40:49 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D2E121
        for <linux-pm@vger.kernel.org>; Fri, 18 Aug 2023 02:40:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe2de785e7so989402e87.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Aug 2023 02:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692351643; x=1692956443;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kr50GcAKm2aJwhKCS62LKftx0ItaoNANdBm3FHGUdv8=;
        b=OkCG2fh5IVrVZlI5WVmkxFkfVT/zTmQUg/N8Hpi5VWnPibTSpXEyHhskzdGVv3dOnA
         sceOYUgkvK1rDrpkWiUFg+l4SslbKLAuwud99ssU7hF5RotT1jHCUMz3ci6gK9ADmdk+
         xUrNl5iWksSm+vVNmlJKtYOjgJa+0l34MN+23xjCShOdVMJswUJMJycEAh8YMt/W1faP
         3L/qYjhiLLLIMFFAD3qx5sr3byUzOhwv8B1MGCeFhkLtBWERrwbaTxXievjVB7xfLZTT
         ZIdrPoayGkAS+zLb2SU57GpGNyN0fIaJzSy+XZYRsaQ8nlFX/pY9I3IcMY85pXwHnQPK
         gufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692351643; x=1692956443;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kr50GcAKm2aJwhKCS62LKftx0ItaoNANdBm3FHGUdv8=;
        b=RRxbruvN2466C77eAHGoQzesAnrIAYtp+UP9k61wtRP7SQ9VHJZx+gn6dKx1WWR0OZ
         H5a9pNLMxRjWapaJH7T3udkRZDKqPKyAcT79AN6bnCsP9JfcqBObOa+yBOGf3p+gmg4M
         gncrA5kT+sDsHVmzT1C4VrzhLywkKipMTzxGFhfi5ffEQPb2KMgO5flUArol/1QSxHBc
         4g6Gw597vsqLmRwhJ1UT9/fhrcWAurPbpwDFXrzV/RjxjDjJm3OAoXa+ZZyivPkp99TX
         aBBYwXlDiZFJBf04KmK16nJfQB0hBoU+xUwH8grGQkPd7g8pQrbWhXkjgzH2ZMOuILES
         VVgA==
X-Gm-Message-State: AOJu0Yz2hC4wUkQz0AbXCSM1NY4y87FuodsJ05d51PUQojAhMn2Re+Ea
        Ed3mE/bQLSd7EctiAqUsu7Q7sg==
X-Google-Smtp-Source: AGHT+IEN+Nr8hsbijZjf0KtwcLHjgvGL7uY++tgh1sm+MN0PUZe+8JQ4CXRLAN6xNxItm7lBZDZONg==
X-Received: by 2002:ac2:5475:0:b0:4fd:cc8c:54e5 with SMTP id e21-20020ac25475000000b004fdcc8c54e5mr1302639lfn.41.1692351642925;
        Fri, 18 Aug 2023 02:40:42 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id k6-20020a1709062a4600b0099bcbaa242asm967546eje.9.2023.08.18.02.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 02:40:42 -0700 (PDT)
Message-ID: <cc428a34-7c06-964c-2cec-123e99c92c4e@linaro.org>
Date:   Fri, 18 Aug 2023 11:40:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/3] dt-bindings: cpufreq: cpufreq-qcom-hw: add SDM670
 compatible
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230816230412.76862-6-mailingradian@gmail.com>
 <20230816230412.76862-8-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230816230412.76862-8-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/08/2023 01:04, Richard Acayan wrote:
> The bindings for Qualcomm CPU frequency have a compatible for each SoC.
> Add the compatible for SDM670.
> 
> Fixes: 0c665213d126 ("arm64: dts: qcom: sdm670: add cpu frequency scaling")
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

