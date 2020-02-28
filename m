Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E58C17332A
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 09:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgB1IpO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 03:45:14 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:38614 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgB1IpO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2020 03:45:14 -0500
Received: by mail-wr1-f48.google.com with SMTP id e8so1998907wrm.5
        for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2020 00:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7c0V49nxq31QWpSDD2qj+bopPB57VY53jiKZIRAdTJU=;
        b=ghHHuqnnMkyG9mGaWqKyEmmHT4LTKahAQRqtuBa4JZqyxoq2beJcIePW+RR8YgNEg0
         XGUW/50bIbs2htL3pIJ/fH9eWCPI5p7FQnKCFbGOfZsObRjawtzkiuh3P1X+colLE4yn
         3fUvMz61Cuhtle97k45qDticKJfd3kMn7QkOY3G2Ii9+a8RptUdFJCh0UZSTmRuUBcU5
         ZigTFMt7n3RRXURgNWasQV7LUgK8ADdhxWFBv7OKFlJkNdRMyeF/6nNppHIfm4KvFLhw
         +JmhoWpDsEPPe+y1+MfSSFyxrzEXGtmrpc5mM/zQ8om+3XUqOxh7FcptNOEAdo2v4Iq1
         xi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7c0V49nxq31QWpSDD2qj+bopPB57VY53jiKZIRAdTJU=;
        b=MKGlkfcaRsg6hEcwbJTSF54kOXGU3pIvw+lIWZLEZ9NgRywFUtO6fN3LWPUQrhoVaA
         mtGzmsv4NfNhHUOd5sWUMOyUJKXrgb8ttztDH7qXTdeAC4wiDyg16iznYrb6T4cRTVJY
         6aIzLcDmgkkbuVRlwHukD+2hyadWb+/ZV9vLlKzmWXyfUUYrBNcb7WXJLkbsv7ik5HWr
         lkrr4VY1zOYQalhiCZmd0nqxkzDWIfJwRhycpsjO8NX01kid4W6NM/HDEPDB0HymTXie
         gqtqHHTL+RvxLSjUllFhqXqpQeDepVeeZxYhzZ/vMdeImPUwlBtRctcnPxchdoc0dxS/
         czyg==
X-Gm-Message-State: APjAAAV0yR93Pl7Rg3OknvVLfFh1TA7QtdH5XDFAya27IWN9GjSELUsi
        6mnSCchGAcD0GWIh2Y0sjs0EDQ==
X-Google-Smtp-Source: APXvYqwGU4+WVO39fvJHE+QydH0jCFM8adott15SJfcWfhhqAWLWjRsKKtyx03W0hXsZxjkMzfu5+A==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr3877726wrx.288.1582879511985;
        Fri, 28 Feb 2020 00:45:11 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id z19sm1138078wmi.35.2020.02.28.00.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 00:45:11 -0800 (PST)
Subject: Re: [V4, 1/3] dt-bindings: interconnect: Add Qualcomm SC7180 DT
 bindings
To:     Odelu Kukatla <okukatla@codeaurora.org>, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-arm-msm-owner@vger.kernel.org
References: <1582646384-1458-1-git-send-email-okukatla@codeaurora.org>
 <1582646384-1458-2-git-send-email-okukatla@codeaurora.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <4eb48a57-508c-02fd-fca7-d2fd8d959eef@linaro.org>
Date:   Fri, 28 Feb 2020 10:45:09 +0200
MIME-Version: 1.0
In-Reply-To: <1582646384-1458-2-git-send-email-okukatla@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Odelu,

On 2/25/20 17:59, Odelu Kukatla wrote:
> The Qualcomm SC7180 platform has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/interconnect/qcom,sc7180.yaml         |  85 +++++++++++
>  include/dt-bindings/interconnect/qcom,sc7180.h     | 161 +++++++++++++++++++++
>  2 files changed, 246 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,sc7180.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
> new file mode 100644
> index 0000000..2cb7d4e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,sc7180.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title:  Qualcomm SC7180 Network-On-Chip Interconnect
> +
> +maintainers:
> +  - Georgi Djakov <georgi.djakov@linaro.org>

Hey, this should be you, not me.

Thanks,
Georgi
