Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD1873351
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 18:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfGXQGH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 12:06:07 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33566 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfGXQGG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 12:06:06 -0400
Received: by mail-io1-f65.google.com with SMTP id z3so90788806iog.0;
        Wed, 24 Jul 2019 09:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6mYUlmsyuuOqv0VXFVZaFOuMVw2R1Ih2jQSACUtXnYw=;
        b=EoHZg9EfHgJg0Uu+41clnr8BnnkswdXWxm0IIGnW2sCzWVeQYiFK5ITXDjgIuaVVgs
         8C/rG4ozVaFaWt4I/GfcD4qaK1wyVYEHsRxx4zZkni7Yo8yyFyeHp1krbCQf+8mKWsfE
         qj07Gfg2wcR/VE/twRRIHysvTwkpQv4ZheukmCTchTpOR1UgLLXSmeP8no9eJxUhhr7O
         gnEE/LR+Zv8EeTd8d4M4roCC/r2CL9OvAAWHu/Bs+wu0R9+NsCcKjSK2irtkkBn1fvV3
         gLUrfAVWBKtxuXf/6PIG3DWFMaZjGwij8pSyo2POIjHaV150MmkWOZkkpkald6QpX+xo
         hR1w==
X-Gm-Message-State: APjAAAW6yYGCS/zPD8t6JanzpBYJiC5dnq9Ie9Xw8xcXqqleb7NkqzK5
        J4XWYG/j9miodWZNsmoR+gxksp0=
X-Google-Smtp-Source: APXvYqxywptg4yzSm855gFaoo5Gs2dfIjhhlmzs41o3JEbPDD+othytru6juGCn44JG4GO6urPm1kw==
X-Received: by 2002:a6b:8b8b:: with SMTP id n133mr3229097iod.183.1563984365639;
        Wed, 24 Jul 2019 09:06:05 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id j14sm39243017ioa.78.2019.07.24.09.06.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 09:06:05 -0700 (PDT)
Date:   Wed, 24 Jul 2019 10:06:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        linux-arm-msm@vger.kernel.org, sboyd@kernel.org,
        vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] dt-bindings: power: avs: Add support for CPR (Core
 Power Reduction)
Message-ID: <20190724160601.GA9333@bogus>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
 <20190705095726.21433-10-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705095726.21433-10-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri,  5 Jul 2019 11:57:20 +0200, Niklas Cassel wrote:
> Add DT bindings to describe the CPR HW found on certain Qualcomm SoCs.
> 
> Changes since RFC:
> -Make compatible string SoC specific.
> -Changed interrupt definition.
> -Use clock binding for reference clock.
> -Clarified qcom,vdd-apc-step-up-limit description.
> -Added missing properties.
> -Updated the example.
> 
> Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  .../bindings/power/avs/qcom,cpr.txt           | 193 ++++++++++++++++++
>  1 file changed, 193 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
