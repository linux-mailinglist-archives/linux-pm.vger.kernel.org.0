Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C1735A60B
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 20:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbhDISq6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 14:46:58 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:38884 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbhDISq5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 14:46:57 -0400
Received: by mail-ot1-f51.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so6628637otk.5;
        Fri, 09 Apr 2021 11:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zIKUUvCQTKc9kZxOX2hfZDYJ/ChiaA0HWL0RSJ3boaw=;
        b=mnPoqA3w0SVPkbAdPJtvdu/DCCK0ylXGBy8sIpBMccdSXhW5VJ1r+nuncHREvELpL2
         KOzuyAEiRp7apE+wyx7nS8NFdBAluYAptAlm3CLGbuHQ7JWnTN7ia3aKY7uiAVrnHAQk
         PzuxCHA0mm1KtkjeINyCG+v6dsRUrH5FY0vDxe/0vPthHcHvzR/QckWUKTJHuhjDhVNL
         eLjp7BvNO0hsxl+QharUwsHoQwqiFFyJORXp0uBxYC8ASQPKA6/N30j5V7oq0soH0IVF
         jsFZYe1Nmx9Enw1L/uX9kWksLeveumfoCG5Tj4O2lMiHNnx+/wf34qofC3bvWzUFDp8+
         U24w==
X-Gm-Message-State: AOAM531NMYP+aZA6YYksQn6mB7jWMCmoUjvvZ+GOYPNnt1eP51EBowvZ
        gxp7BZI31R+NKfdfImHiJA==
X-Google-Smtp-Source: ABdhPJw1vtPQKX2TyzYFXavxrvsJp19iipkYMN+QANMDOK/33HXQOnLjECyJVPRdzn2I/hnNkIO8XQ==
X-Received: by 2002:a9d:39ca:: with SMTP id y68mr13420149otb.84.1617994004110;
        Fri, 09 Apr 2021 11:46:44 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k9sm772670ots.24.2021.04.09.11.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:46:43 -0700 (PDT)
Received: (nullmailer pid 3944329 invoked by uid 1000);
        Fri, 09 Apr 2021 18:46:42 -0000
Date:   Fri, 9 Apr 2021 13:46:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Courtney Cavin <courtney.cavin@sonymobile.com>,
        linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-pm@vger.kernel.org, kgunda@codeaurora.org,
        Andy Gross <agross@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2 2/4] dt-bindings: input: pm8941-pwrkey: add pmk8350
 compatible strings
Message-ID: <20210409184642.GA3944299@robh.at.kernel.org>
References: <1617881469-31965-1-git-send-email-skakit@codeaurora.org>
 <1617881469-31965-3-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617881469-31965-3-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 08 Apr 2021 17:01:07 +0530, satya priya wrote:
> From: David Collins <collinsd@codeaurora.org>
> 
> Add power key and resin compatible strings for the PMK8350 PMIC.
> These are needed to distinguish key PON_HLOS register differences
> between PMK8350 and previous PMIC PON modules.
> 
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
> Chnages in V2:
>  - Moved this patch before the conversion patches.
> 
>  Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
