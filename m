Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B05C1304D6
	for <lists+linux-pm@lfdr.de>; Sat,  4 Jan 2020 23:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgADWBq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Jan 2020 17:01:46 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39321 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgADWBp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Jan 2020 17:01:45 -0500
Received: by mail-io1-f67.google.com with SMTP id c16so14942627ioh.6
        for <linux-pm@vger.kernel.org>; Sat, 04 Jan 2020 14:01:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fnzuX2UXDHqVoWZIcnjy9706qM97ViaNzviNWp3fBBw=;
        b=k52WhigsG/qIex18oR53fYO9dJo1mITCGgdD5aSqv3e09mlysA+XA4luDJvjT/Wjga
         ANxxr6Hywya1Z/RxNC20J/cGxm8U0XpzhbZ6TgOt07a+y27+O78b3mtiFnLkd+1aekef
         GkEwrfTWB3+T/VpLiiUifRB+6s+3jnnivae68yfNI3U08xwypJ2njXs/cdigv7KiI+Aw
         KO9UKgIFlAKn20h4l4WFlSxRGbKxJn9cfQHos91AgSxL15K4Xt+5eKKg3/qapslotk0h
         Qq+Ih1xf2WOF3nwL44FOXOxwEl2v/gSHfXcW3WtPFg6udYnNpBUJjx/8cfgZEFrA33ug
         0IwA==
X-Gm-Message-State: APjAAAUIRpY2UZWisVRi/r7LzmUlnSpO5GwYvOuP402eDr4w5ZBgeZAu
        qM9c7zz2GbGOiMO8iNOrRSuzrd0=
X-Google-Smtp-Source: APXvYqyJ7zGhdY4cFT8RR1apcn5f3nkp2CYxuJaIl2/82mfHAlS31H1n9FAqSE+yeLgN53+sPMkSCA==
X-Received: by 2002:a6b:d20c:: with SMTP id q12mr62061375iob.143.1578175304645;
        Sat, 04 Jan 2020 14:01:44 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id k78sm22281070ila.80.2020.01.04.14.01.43
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 14:01:44 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219b7
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Sat, 04 Jan 2020 15:01:42 -0700
Date:   Sat, 4 Jan 2020 15:01:42 -0700
From:   Rob Herring <robh@kernel.org>
To:     Odelu Kukatla <okukatla@codeaurora.org>
Cc:     georgi.djakov@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [V2, 1/3] dt-bindings: interconnect: Add Qualcomm SC7180 DT
 bindings
Message-ID: <20200104220142.GA28701@bogus>
References: <1577782737-32068-1-git-send-email-okukatla@codeaurora.org>
 <1577782737-32068-2-git-send-email-okukatla@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577782737-32068-2-git-send-email-okukatla@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 31, 2019 at 02:28:55PM +0530, Odelu Kukatla wrote:
> The Qualcomm SC7180 platform has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>  .../bindings/interconnect/qcom,bcm-voter.yaml      |   1 +
>  .../bindings/interconnect/qcom,sc7180.yaml         | 155 ++++++++++++++++++++
>  include/dt-bindings/interconnect/qcom,sc7180.h     | 161 +++++++++++++++++++++
>  3 files changed, 317 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,sc7180.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
> index 74f0715..55c9f34 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
> @@ -19,6 +19,7 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - qcom,sc7180-bcm-voter
>        - qcom,sdm845-bcm-voter
>  
>  required:
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
> new file mode 100644
> index 0000000..487da5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
> @@ -0,0 +1,155 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
