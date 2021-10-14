Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4391942DF5B
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 18:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhJNQpb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 12:45:31 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:46629 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbhJNQpZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 12:45:25 -0400
Received: by mail-oi1-f175.google.com with SMTP id o204so9192164oih.13;
        Thu, 14 Oct 2021 09:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UvxD5+Hw4iJY2Dq6klGID8YYhsUJD7AT0hAWa74FOHY=;
        b=stY8HeW03IClsqWjvk4FuJgH1TQ2Ctb3mW19PrC+6oGJo6T/cTfUUeu2ulW1OdFGO+
         rr6ETkjjQSBbtUgjNK5EOJUGnHkqXZ9STO+/xEoovDab+vqUhcWCdQUuHEf+ozUOuj5s
         BZxNsJbO4fPuWd6z8N+mlSXj1OJRV3brUsZMNnjCj/AiCIJ8Y0xpBSWP+SReQc38GJyf
         CSQf9mikAP4EFb4LLXf6hMrEXbIPS2hDvESYSf0xc+rDJGFJjsEZUxm3EvS7fis83AV3
         cBDbK9X39YI2CMS1I4vQf2F1nqlhZby/RgyPd9yg6cXBqOWBvORwrnP0XX1GYmPHAnmf
         lPcA==
X-Gm-Message-State: AOAM530Fi+jtWfpFqHn7fAuBY1gUVyl85ZvSZqsZCQUlTLNTpnWPhd+S
        qT4zk7yp0VolEpnLt+F6x0hEQry7Rg==
X-Google-Smtp-Source: ABdhPJzooLE6gkdXu6oeNDsVz/pCE/pJZ4gfx0kflWxC617I3qMJfI5QKh7bxzgLx5LaQDGjmC20qQ==
X-Received: by 2002:aca:c1c3:: with SMTP id r186mr13834864oif.79.1634229800106;
        Thu, 14 Oct 2021 09:43:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z8sm514622oof.47.2021.10.14.09.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 09:43:19 -0700 (PDT)
Received: (nullmailer pid 3512729 invoked by uid 1000);
        Thu, 14 Oct 2021 16:43:18 -0000
Date:   Thu, 14 Oct 2021 11:43:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: thermal: qcom: add HC variant of
 adc-thermal monitor bindings
Message-ID: <YWheJr1BfpeJpTUc@robh.at.kernel.org>
References: <20211005032531.2251928-1-bjorn.andersson@linaro.org>
 <20211005032531.2251928-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005032531.2251928-2-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 04 Oct 2021 20:25:28 -0700, Bjorn Andersson wrote:
> The HC generation of the ADC Thermal Monitor is quite similar to the 5th
> generation, but differs in valid values for a few properties. Create a
> new binding for the HC version of the hardware, rather than sprinkle
> conditionals throughout the existing binding.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v2:
> - None
> 
>  .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
