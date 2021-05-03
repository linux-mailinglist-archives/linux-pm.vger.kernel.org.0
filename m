Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BD2372034
	for <lists+linux-pm@lfdr.de>; Mon,  3 May 2021 21:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhECTQE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 May 2021 15:16:04 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:40579 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhECTQD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 May 2021 15:16:03 -0400
Received: by mail-ot1-f49.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso6087528otp.7;
        Mon, 03 May 2021 12:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=54CF10GaA/2ekWhk20HhufCfa3PvokwhtmrR2x51tq0=;
        b=V/AcFepmOQTayhBtjoyg1e1jHSl5LkH9DDfO8Dpu2Og0XSLsM8NF0XkKXX/5H2Rtb9
         A+P2/aPcslvURG5z+QriWyoF0CFS8bcpSgKx31tk2dbP67rtDILGVtFZ8RffU5KoX5LA
         167eRj0AwfTy/B3x88Ik1P40wysdkXG0+tzkBxEhrSoh3MLcu3BOn0tMjFlcKQ7j5Tn4
         1ObPTHU7SN0BuuDF9ExG53P2UvTGilVmjH5oOpgS0Aai2uH7CcJkHv6tCVrdXj9FoH9o
         GIp9ZQ3s+S4uljleKZIrneQmau+vaLT5fyEQjDyLPq7BFOWmrfb26CZxwYvmpEaoR37v
         G+3Q==
X-Gm-Message-State: AOAM533qzdknPxIbXUEiP5LyYqsKI3WLmrrAlsWoe7BQ08v5AFp+pLKb
        51yWH16KLDjdG6oLtG0mXw==
X-Google-Smtp-Source: ABdhPJykvoihGq0kdg8TK6vlPsHzG/rbIU9AWj6HXj2LIJbpoAZtUL7vEU9SYm2QZFR/vnapVCZNXw==
X-Received: by 2002:a9d:3423:: with SMTP id v32mr16113385otb.168.1620069307752;
        Mon, 03 May 2021 12:15:07 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v19sm165766oic.21.2021.05.03.12.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 12:15:07 -0700 (PDT)
Received: (nullmailer pid 2220409 invoked by uid 1000);
        Mon, 03 May 2021 19:15:05 -0000
Date:   Mon, 3 May 2021 14:15:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Odelu Kukatla <okukatla@codeaurora.org>
Cc:     seansw@qti.qualcomm.com, linux-pm@vger.kernel.org,
        elder@linaro.org, georgi.djakov@linaro.org, evgreen@google.com,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        sibis@codeaurora.org, Andy Gross <agross@kernel.org>,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        Georgi Djakov <djakov@kernel.org>, sboyd@kernel.org,
        ilina@codeaurora.org
Subject: Re: [v2 1/3] dt-bindings: interconnect: Add Qualcomm SC7280 DT
 bindings
Message-ID: <20210503191505.GA2220358@robh.at.kernel.org>
References: <1619517059-12109-1-git-send-email-okukatla@codeaurora.org>
 <1619517059-12109-2-git-send-email-okukatla@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619517059-12109-2-git-send-email-okukatla@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 27 Apr 2021 15:20:56 +0530, Odelu Kukatla wrote:
> The Qualcomm SC7280 platform has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>  .../bindings/interconnect/qcom,rpmh.yaml           |  12 ++
>  include/dt-bindings/interconnect/qcom,sc7280.h     | 165 +++++++++++++++++++++
>  2 files changed, 177 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,sc7280.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
