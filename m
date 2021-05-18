Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B71C386E75
	for <lists+linux-pm@lfdr.de>; Tue, 18 May 2021 02:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbhERAub (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 20:50:31 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:41664 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbhERAua (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 20:50:30 -0400
Received: by mail-ot1-f52.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so7187726oth.8;
        Mon, 17 May 2021 17:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yrOVOD3qCQLVHCAZtNnKfo5QLzokUdgJlnu6Nj1LShg=;
        b=bksPmQOl1KmLt8+GbI3BysmLt/jNV1DiszPzDa56X6iDZsqaIKjcUI/egYcOoC+y2l
         +HiBLJllVFxSqf1LxrsxX55r+plRL4lS9ucKhA5mvKHUUkq4h5vnZ4V61hkBUeRkQT8J
         3mRgRxzSVfrgw8tVu8IPFJcOCIZQSSYxBRrIn3khfjIYmPaYOHeudb3lEjNvW4eXOYxu
         4ALHJP0IydUq4gefpChVUkDlsF0Y5/FIUj4a3KFH84NUNtZ3OOIj6DkxmXCxekEAl5mO
         r7I2VPGff996OuFn7ZgfHfE5crbwoxVVI59NoLqkhe7AnNT2HBpRVRiAc7K4qzOss7e0
         Fvog==
X-Gm-Message-State: AOAM531feDvPBxaZvpQO/opKfd8Y+hoip4eTW2OogiaabUAxXjM/SF9G
        KyfRC6pWhLLp2llLha8/VowsQu2JgA==
X-Google-Smtp-Source: ABdhPJzZGd6W9pWreOFJczdOUWlEjgy74Wn/YqJdcE9vazY5nq6T8nk1pZFnHebne/IBkKE8s44FHQ==
X-Received: by 2002:a05:6830:1256:: with SMTP id s22mr1861242otp.333.1621298951553;
        Mon, 17 May 2021 17:49:11 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i18sm3411184oot.48.2021.05.17.17.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 17:49:10 -0700 (PDT)
Received: (nullmailer pid 3538545 invoked by uid 1000);
        Tue, 18 May 2021 00:49:09 -0000
Date:   Mon, 17 May 2021 19:49:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kgunda@codeaurora.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH V4 4/5] dt-bindings: input: pm8941-pwrkey: Convert pm8941
 power key binding to yaml
Message-ID: <20210518004909.GA3538493@robh.at.kernel.org>
References: <1620800053-26405-1-git-send-email-skakit@codeaurora.org>
 <1620800053-26405-5-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620800053-26405-5-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 12 May 2021 11:44:12 +0530, satya priya wrote:
> Convert qcom pm8941 power key binding from .txt to .yaml format.
> 
> The example has been removed in favour of full example being
> available in the qcom,pon.yaml binding.
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
> Changes in V4:
>  - Removed the example and added in qcom,pon.yaml
> 
>  .../bindings/input/qcom,pm8941-pwrkey.txt          | 55 ----------------------
>  .../bindings/input/qcom,pm8941-pwrkey.yaml         | 51 ++++++++++++++++++++
>  2 files changed, 51 insertions(+), 55 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
>  create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
