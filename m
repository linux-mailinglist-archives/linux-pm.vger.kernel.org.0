Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97E73793AD
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 18:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhEJQZy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 12:25:54 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:44748 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhEJQZx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 12:25:53 -0400
Received: by mail-ot1-f43.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so14931055otp.11;
        Mon, 10 May 2021 09:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U2QmA0kT5KGKtEEfgKEA5hMeDW03KIt9H3QxMG9piFw=;
        b=mfI5MIfJitrBkxc2cE9N5WB2KyOsb2BogBytsga57U2I1uCwGihoQBd++pgC2NWQWB
         osX6ANNbeo9cWISIiM3pNyga/HW31PCQFZNW9Pe/qDCprF8tWf3OKz2JQJemwL3iE0jy
         Fw46bHU0zW8mVGnUQtFmhPQ8rPV6Yw+qcgDODIoyi0WL8fPCAf1+HFMzXPz6JCXjjEE7
         hIMjAX3wCnWU6VQqAWxgYG8B+PRAs8oxozeji9jHqOUJAnEuGVdyZKPmAneI15gt4+QT
         XoHBr33cwa5IS5gNdYfbczRZlK1DG4V2AuWpe3DU2u5GIoA2AH8tpKW7LSEQpOFiKp5L
         B9mA==
X-Gm-Message-State: AOAM53205l92AVEXKRVWp+y29+OeW7+/nXd+E5QMB0qBiFq2yGzJi8cw
        6TvPUJjG+RstMzXhW/i8vA==
X-Google-Smtp-Source: ABdhPJxcwWkV87qLFbePQOlAS7VuwdvHmnrsQjgiZIUEHijHWQCrqZrYHZKJAdgrHzjfGbvABhkWwg==
X-Received: by 2002:a9d:2271:: with SMTP id o104mr21591456ota.201.1620663887279;
        Mon, 10 May 2021 09:24:47 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b8sm736481ooo.42.2021.05.10.09.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 09:24:46 -0700 (PDT)
Received: (nullmailer pid 233712 invoked by uid 1000);
        Mon, 10 May 2021 16:24:45 -0000
Date:   Mon, 10 May 2021 11:24:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        kgunda@codeaurora.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Collins <collinsd@codeaurora.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH V3 4/5] dt-bindings: input: pm8941-pwrkey: Convert pm8941
 power key binding to yaml
Message-ID: <20210510162445.GA230005@robh.at.kernel.org>
References: <1620630064-16354-1-git-send-email-skakit@codeaurora.org>
 <1620630064-16354-5-git-send-email-skakit@codeaurora.org>
 <1620655299.793818.41438.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620655299.793818.41438.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 10, 2021 at 09:01:39AM -0500, Rob Herring wrote:
> On Mon, 10 May 2021 12:31:03 +0530, satya priya wrote:
> > Convert qcom pm8941 power key binding from .txt to .yaml format.
> > 
> > Signed-off-by: satya priya <skakit@codeaurora.org>
> > ---
> > Changes in V2:
> >  - Fixed bot errors, took reference from input.yaml for "linux,code"
> >  - Added one complete example for powerkey and resin, and referenced it
> >    in main PON binding.
> >  - Moved this patch to the end of the series.
> > 
> > Changes in V3:
> >  - Moved this patch before PON binding patch.
> >  - As per Rob's comments, added allOf at the beginning of binding.
> >    Added maxItems for interrupts.
> >  - Added 'unevaluatedProperties' instead of 'additionalProperties' as
> >    we are using allOf.
> > 
> >  .../bindings/input/qcom,pm8941-pwrkey.txt          | 55 --------------
> >  .../bindings/input/qcom,pm8941-pwrkey.yaml         | 87 ++++++++++++++++++++++
> >  2 files changed, 87 insertions(+), 55 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
> >  create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.example.dt.yaml:0:0: /example-0/spmi@c440000/pmic@0/pon_hlos@1300: failed to match any schema with compatible: ['qcom,pm8998-pon']

You have the same example in patch 5, so drop the example here. That 
will fix this circular dependency.
