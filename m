Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91773DAE71
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 23:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhG2Vje (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jul 2021 17:39:34 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:42859 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhG2Vje (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jul 2021 17:39:34 -0400
Received: by mail-io1-f53.google.com with SMTP id h1so8935283iol.9;
        Thu, 29 Jul 2021 14:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VlgnUr3PrArxFkf+WyoZ600D3pMrPXeaR+Qq3HneVC8=;
        b=tK7gt9XJ1EWD0N7Gq6eVrfsc/aKZJYkdDSEIHp1of5uCg6sDkqoEx6dX8OTNp16tuf
         mLJQIgm2G2U5o46Z68ryyO4B3iMSmEuu3Tx5WMvTOdbgfiVAAqxeG+0eSMQ43aLe69lS
         XxvdBCvdbTDBR7vQU75ZlhiW7pQ6sdHS2GJIyrtokN/XLpaouW+s67sxPhtoCABQBMtl
         fEmSuS40UmdU2bdVDOzMFrXAOL3LW2aMcUAgTSWhqBeFoYcN3k14vAOlDBEoTiankJdS
         37NkXzlGrIfB5fCE/3Ze4aJBQEcdJU2lln9XuQXr2xAAtoHNg9K68t4hemzolP793ljW
         Fq2w==
X-Gm-Message-State: AOAM531/LbDVskSnpWeFXwSJufRxHGXFFx67N6/OjhTunZRmZZUFAMg8
        vOaixAtA51X7UbTJSQ8hIA==
X-Google-Smtp-Source: ABdhPJxzdIeKKyoVAP3p+VmLsurV5eDWcczAb+WqKOoQXA7vvnJWxtNksCgZGm6TcWu3K74b1i97qQ==
X-Received: by 2002:a5d:89d6:: with SMTP id a22mr5886543iot.178.1627594769372;
        Thu, 29 Jul 2021 14:39:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f5sm2484161ilr.72.2021.07.29.14.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 14:39:28 -0700 (PDT)
Received: (nullmailer pid 942047 invoked by uid 1000);
        Thu, 29 Jul 2021 21:39:27 -0000
Date:   Thu, 29 Jul 2021 15:39:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Georgi Djakov <djakov@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add SC8180x to OSM L3 DT
 binding
Message-ID: <YQMgD40bHfZ6VDYb@robh.at.kernel.org>
References: <20210725025834.3941777-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210725025834.3941777-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 24 Jul 2021 19:58:33 -0700, Bjorn Andersson wrote:
> The Qualcomm SC8180x has an OSM L3, add compatible for this.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
