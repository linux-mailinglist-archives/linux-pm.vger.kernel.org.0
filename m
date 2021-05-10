Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5063793B3
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 18:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhEJQ0O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 12:26:14 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38845 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhEJQ0N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 12:26:13 -0400
Received: by mail-ot1-f49.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so14952614oth.5;
        Mon, 10 May 2021 09:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2F9o9CXmQjIHf3vmeIvzaTvlAH8nG5XppEHKJCixyLg=;
        b=NOpFePfHVsxwEyqSUOw6nch56+nImWARBEnJFhWx+JPcvyaAUpPaiefXo6BVrYTG+8
         vzhGwRco3nvUZp0rc9j/bM2OUrCvYHqggaNWzbz1gtKXNL96ulFcw1WaBRr46auGL/f7
         TEu+ZJ+tQg0FZvD2UDkNsGveycOhA6cEGAuv6hF3tbOIaqfPQKAmj0a8UJGGLU3W5Svd
         Z+ZanzI23OTipUFmt+LWOR6iJNhq6CdhU+w0+VIAwP7iNgJolcSFTFxLKZmm8FjDGzua
         66iMbphtBGX8XxJYJNI9ewwTA6dG9Sr+xaMqZ1a51023bOGf6sBVzJ+x4KG5meWKhVF5
         QP8w==
X-Gm-Message-State: AOAM531FgpwxX750TJ2xD7U2OxZhULfaSByI5b42PD3lFV/plj3FxlDO
        ifrpohT7GnbDCKRN3VsnIQ==
X-Google-Smtp-Source: ABdhPJw+aQ/EcFoJoRzYs5MDjvD6++YcmtpIF6H+/TjqKW7iUQD0lS6ROaMWhUoIF5dvFPIY/MGy1A==
X-Received: by 2002:a9d:5f82:: with SMTP id g2mr21841675oti.4.1620663908320;
        Mon, 10 May 2021 09:25:08 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u207sm2682382oie.56.2021.05.10.09.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 09:25:07 -0700 (PDT)
Received: (nullmailer pid 234223 invoked by uid 1000);
        Mon, 10 May 2021 16:25:06 -0000
Date:   Mon, 10 May 2021 11:25:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        kgunda@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, Andy Yan <andy.yan@rock-chips.com>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V3 5/5] dt-bindings: power: reset: qcom-pon: Convert qcom
 PON binding to yaml
Message-ID: <20210510162506.GA234174@robh.at.kernel.org>
References: <1620630064-16354-1-git-send-email-skakit@codeaurora.org>
 <1620630064-16354-6-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620630064-16354-6-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 10 May 2021 12:31:04 +0530, satya priya wrote:
> Convert qcom PON binding from .txt to .yaml format.
> 
> The example has been removed in favour of full example being
> available in the qcom,pm8941-pwrkey binding.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
> Changes in V2:
>  - As per Rob's comments, converted the main PON binding and added in V2.
> 
> Changes in V3:
>  - As per Sebastian's comments, added allOf to refer reboot-mode.yaml and
>    used unevaluatedProperties = false. Added maxItems for reg.
> 
>  .../devicetree/bindings/power/reset/qcom,pon.txt   | 49 ----------------------
>  .../devicetree/bindings/power/reset/qcom,pon.yaml  | 44 +++++++++++++++++++
>  2 files changed, 44 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/qcom,pon.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
