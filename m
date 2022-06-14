Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E63C54BA66
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jun 2022 21:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiFNTRh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jun 2022 15:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiFNTRf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2022 15:17:35 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC58262B
        for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2022 12:17:34 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x4so9390361pfj.10
        for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2022 12:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=lhMxTQMnN137Vr3Q0ziGclyB7kCt3vT1THj9ycpmP0s=;
        b=LWphgGFaYcwVO/fFu1KEC+ZLpADp2ELKQ/7uuS+rXW9SxCDTAImT7Jjdx80Z4HoIca
         aKdt+QMqhEipMYdfu1/jbCoxbQwqt3tcINIQ32CWOFSEElTfPpCdr64xjq885K4sdUi4
         nC3hg0HJ77bmwhGQhmEHlUUz//yeoxpWGJlmpJ3NTrBz0kbO9Pa7ojRgVsTtFo02HONo
         sfiF5eg7YTMgeRRf2sKI9YDP33gO6JaDs424WhhOe11sCC28GSlGiXbp9Oh3A+U585ng
         dq/+T682bjkBEel/gOBiAgKgcTH9uq3Dis487kQCVqQ6Q5icRS7kNap0FF5UHJxcuPdd
         kX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lhMxTQMnN137Vr3Q0ziGclyB7kCt3vT1THj9ycpmP0s=;
        b=sUs0Ysl/WusoazKbIkR2uniqX/R+ezgXytVomZqFa42Mb5MT2kDStQHZT7KUJ7xxRH
         ufvl+ImtCLaP5CCF7sBwcLruu8kBA8BMGn02+rnrNAlyeXs+fBazzRkCzU+BwdaOgbyn
         TIJ9IkuZLK/odvnZAEFzsEFtqD+L0r1Qp48e9eKUFL7dOstFj2eNPq+HpAG40QAft8ax
         wXpoFJXho814r/pcOo9hHBu8YdZaspdFOtten7AizAcX0ULI8wy42z/CftI56/EoXv2I
         LwSsKB/iJF8jvwYP8BI9liOn4A/mwerBaqzk1bxEusTzcSIm7ftEphQ7QgHn/QSJVMsE
         PwsA==
X-Gm-Message-State: AJIora/PZ5BjS2EcPMg8Z6UxUIJZFzDaI4yYynFDRs2LoP1OEuWwQmWo
        IyAa2QmLwUHVwp/gvcvGLjI9qA==
X-Google-Smtp-Source: AGRyM1vBGLLo8xuwfhG9CyAc8WHfk9haKqAIM0YO9jCpCi6/n7shNJxARh2oq3WdoAc/c6CjpzuN3Q==
X-Received: by 2002:a63:194c:0:b0:408:a9d1:400c with SMTP id 12-20020a63194c000000b00408a9d1400cmr3519825pgz.559.1655234253902;
        Tue, 14 Jun 2022 12:17:33 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id bi9-20020a170902bf0900b00163bfaf0b17sm7574855plb.233.2022.06.14.12.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 12:17:33 -0700 (PDT)
Message-ID: <c317ba82-e77f-147f-6c4e-c975d1d313ea@linaro.org>
Date:   Tue, 14 Jun 2022 12:17:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] dt-bindings: thermal: qcom,spmi-temp-alarm: convert
 to dtschema
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Kumar Gala <galak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220608112702.80873-1-krzysztof.kozlowski@linaro.org>
 <2c778212-1ff6-6afb-aa13-917bbffcfebc@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2c778212-1ff6-6afb-aa13-917bbffcfebc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/06/2022 12:01, Daniel Lezcano wrote:
> On 08/06/2022 13:27, Krzysztof Kozlowski wrote:
>> Convert the Qualcomm QPNP PMIC Temperature Alarm to DT Schema.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   .../thermal/qcom,spmi-temp-alarm.yaml         | 85 +++++++++++++++++++
>>   .../bindings/thermal/qcom-spmi-temp-alarm.txt | 51 -----------
>>   2 files changed, 85 insertions(+), 51 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> 
> Applied this patch.
> 
> I can pick patch 2/2 if needed, just let me know

Thanks Daniel. I guess Bjorn will pick up the DTS patch.

Best regards,
Krzysztof
