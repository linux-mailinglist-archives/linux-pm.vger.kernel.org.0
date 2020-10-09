Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E02288B15
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 16:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388917AbgJIObl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 10:31:41 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37527 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388908AbgJIObX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2020 10:31:23 -0400
Received: by mail-oi1-f195.google.com with SMTP id t77so10410677oie.4;
        Fri, 09 Oct 2020 07:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fSY177QCDHA506ltAJfX+pyNUH3460/blci6wiOpURg=;
        b=Dz3C4A04lOAU2/DC7VW/OvzSNx9wH8P11EnW33vywHUiY1EGjN3G6AuwrNOn2DOBgJ
         cgYclT0jTClNTOmCEmNBKWR8A+p1URBZ7Ir/cNpwGutO8FjonOk0oUMtdnS6hg5TV/te
         X0d6G2oPvhp0CBve3bd4LdW0CZOValsvsWjHKBWY7FaDFicqqF+MFMb52Ov6CFEw4G70
         xumNSpUwU/dcVj6Ohpp55kExGjRyEdFWbDSMhm8JIQhB1VOe+TbLVzpVFVf8uBp+f3aF
         JhzqpBb/CxrLSMEyVe2yxe3TzVV+09b33QlAmRLFDDomH1EgwULjHP6fZBNuFReSdfpK
         kKzw==
X-Gm-Message-State: AOAM533bXiYLJC90T4RsQs7RRpvriDhRYi/mGzUsgTHreDoVqM2okjfa
        K/weLJpM4esNPhi9+1ceEoM6G2IlHGL+
X-Google-Smtp-Source: ABdhPJxyqYEZTKZUYGot+5w2hJJtIfWrX5UV1nuE4AmB8RyXv8PbfdnyYX0HugcKNhLpSLyxvRMYCA==
X-Received: by 2002:aca:4188:: with SMTP id o130mr2424926oia.167.1602253880742;
        Fri, 09 Oct 2020 07:31:20 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y23sm8328527ooj.34.2020.10.09.07.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 07:31:20 -0700 (PDT)
Received: (nullmailer pid 4109836 invoked by uid 1000);
        Fri, 09 Oct 2020 14:31:19 -0000
Date:   Fri, 9 Oct 2020 09:31:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     kholk11@gmail.com
Cc:     martin.botka1@gmail.com, linux-pm@vger.kernel.org,
        phone-devel@vger.kernel.org, georgi.djakov@linaro.org,
        konradybcio@gmail.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        marijns95@gmail.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: Add bindings for
 Qualcomm SDM660 NoC
Message-ID: <20201009143119.GA4109583@bogus>
References: <20201008204515.695210-1-kholk11@gmail.com>
 <20201008204515.695210-2-kholk11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008204515.695210-2-kholk11@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 08 Oct 2020 22:45:14 +0200, kholk11@gmail.com wrote:
> From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> 
> Add the bindings for the Qualcomm SDM660-class NoC, valid for
> SDM630, SDM636, SDM660 and SDA variants.
> 
> Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> ---
>  .../bindings/interconnect/qcom,sdm660.yaml    | 147 ++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,sdm660.h    | 116 ++++++++++++++
>  2 files changed, 263 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,sdm660.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
