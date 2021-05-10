Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52290379028
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 16:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbhEJOIg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 10:08:36 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:43769 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238363AbhEJOCw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 10:02:52 -0400
Received: by mail-ot1-f53.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso13708549ots.10;
        Mon, 10 May 2021 07:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=aMyd74V2xPR9HsHsdnpVhEpDDf6pkpJ1H3LsUAn7sbI=;
        b=d/4ZY7ISqohEwb2d1Bdh83OedwbHW94d1A6Dfgq1IcCP1Q18XZQA0ulSJ19AKAbmHa
         2Lzsdw9uRigyAzFlQ2T6GIAJfs3jcH2Y+PeGfJvwbjbwH49hup22tvWi9W7n2mhxrKF1
         47+oLcTkImAA7sz/HrrDHZWPmng0YZ+dMDTmmjrg+Z+w4AcrP+ZmB5m0PI/QI6nestHG
         J/dw+UisWRRwDOpFBCLtAylxoA/ONIw3VDHa5FQEIpWgUssJxwpF+vIKdNhwZ+mnxyma
         oUKA3Sfcw3MVD8Fm0sA+m/sIqRj5ohBLcd8ay0YXTV+AU0Y5gBoOjW67eT7uArMzoPPA
         jMPg==
X-Gm-Message-State: AOAM533qusKFrwaEfH7YQdCxq+H6+1Ji/VMrtuWPUcTQUJv9ppWIVT4a
        fjThkDNli3FrirnhzojlMpOYUnpsWw==
X-Google-Smtp-Source: ABdhPJzSILUisRkF9ZkgKtKLtWcN1AIVtat4Sjmyowu6KWN3kbXqHOkZeDA9q9iEo8Fblx+U2ozBDw==
X-Received: by 2002:a9d:70c1:: with SMTP id w1mr2290991otj.276.1620655306804;
        Mon, 10 May 2021 07:01:46 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s6sm1167461otk.71.2021.05.10.07.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:01:45 -0700 (PDT)
Received: (nullmailer pid 41439 invoked by uid 1000);
        Mon, 10 May 2021 14:01:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        kgunda@codeaurora.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Collins <collinsd@codeaurora.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>
In-Reply-To: <1620630064-16354-5-git-send-email-skakit@codeaurora.org>
References: <1620630064-16354-1-git-send-email-skakit@codeaurora.org> <1620630064-16354-5-git-send-email-skakit@codeaurora.org>
Subject: Re: [PATCH V3 4/5] dt-bindings: input: pm8941-pwrkey: Convert pm8941 power key binding to yaml
Date:   Mon, 10 May 2021 09:01:39 -0500
Message-Id: <1620655299.793818.41438.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 10 May 2021 12:31:03 +0530, satya priya wrote:
> Convert qcom pm8941 power key binding from .txt to .yaml format.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
> Changes in V2:
>  - Fixed bot errors, took reference from input.yaml for "linux,code"
>  - Added one complete example for powerkey and resin, and referenced it
>    in main PON binding.
>  - Moved this patch to the end of the series.
> 
> Changes in V3:
>  - Moved this patch before PON binding patch.
>  - As per Rob's comments, added allOf at the beginning of binding.
>    Added maxItems for interrupts.
>  - Added 'unevaluatedProperties' instead of 'additionalProperties' as
>    we are using allOf.
> 
>  .../bindings/input/qcom,pm8941-pwrkey.txt          | 55 --------------
>  .../bindings/input/qcom,pm8941-pwrkey.yaml         | 87 ++++++++++++++++++++++
>  2 files changed, 87 insertions(+), 55 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
>  create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.example.dt.yaml:0:0: /example-0/spmi@c440000/pmic@0/pon_hlos@1300: failed to match any schema with compatible: ['qcom,pm8998-pon']

See https://patchwork.ozlabs.org/patch/1476186

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

