Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6F343CF3E
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 18:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243149AbhJ0RB4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 13:01:56 -0400
Received: from mail-oo1-f52.google.com ([209.85.161.52]:40572 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243158AbhJ0RBi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Oct 2021 13:01:38 -0400
Received: by mail-oo1-f52.google.com with SMTP id m37-20020a4a9528000000b002b83955f771so1132466ooi.7;
        Wed, 27 Oct 2021 09:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3xNLUk6B6HG3KUZQunYiPk6GxwNlFHDYS2KiJ7xOzd0=;
        b=ghxwW0MTLBPmuJuHTCjyds2HUQbFd0UQbHVCA69CgeXp2DPYC+yh71uw0CkbzSn6hz
         6qmHMFZYi1QrWrqt7fYIDll6P515rWZNKPgZmnqPVb6QvzejYBbcGXSYlhdOvs5YP8az
         /hHOmdF2LeSZxe32aWLJk67IowzU7ICnWF+oPPPITns48FVhcSsQaKG79ls0EpbpVXEG
         D19UWigGEtsG/eWoupPwgwV07tddN/ONRr6L/bxMLq3HEF6eSbEU/hh56KabexD7tzTe
         3+t9AcoLWvhH7iXMTBRapPv1/+x/UFPGvjMXIWwkh1fF/iDKqPxseLcLKibbI6GViPlm
         Aw3A==
X-Gm-Message-State: AOAM533PVVZniVdRj+oR4SV821/gLdioFA6tae7gNiqopbmYLlcYyv1M
        F2U/WK1yVVHrg9BHN4bBqg==
X-Google-Smtp-Source: ABdhPJz2mU9EVbEpZu1D4mjpd0zA7Lfg4qao8M88Gqdf0Vnqbz2FDr6xTj3Smo7ox6FLH3iDEajiIw==
X-Received: by 2002:a4a:eacc:: with SMTP id s12mr8853355ooh.14.1635353952123;
        Wed, 27 Oct 2021 09:59:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d4sm238597otu.57.2021.10.27.09.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 09:59:11 -0700 (PDT)
Received: (nullmailer pid 1698392 invoked by uid 1000);
        Wed, 27 Oct 2021 16:59:10 -0000
Date:   Wed, 27 Oct 2021 11:59:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Odelu Kukatla <okukatla@codeaurora.org>
Cc:     sboyd@kernel.org, Georgi Djakov <djakov@kernel.org>,
        mdtipton@codeaurora.org, Andy Gross <agross@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        evgreen@google.com, bjorn.andersson@linaro.org,
        Rob Herring <robh+dt@kernel.org>, seansw@qti.qualcomm.com,
        georgi.djakov@linaro.org, saravanak@google.com, elder@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [v8 1/3] dt-bindings: interconnect: Add EPSS L3 DT binding on
 SC7280
Message-ID: <YXmFXoKLmDsigVqt@robh.at.kernel.org>
References: <1634812857-10676-1-git-send-email-okukatla@codeaurora.org>
 <1634812857-10676-2-git-send-email-okukatla@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634812857-10676-2-git-send-email-okukatla@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 21 Oct 2021 16:10:55 +0530, Odelu Kukatla wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on SC7280
> SoCs.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
