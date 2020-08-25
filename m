Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A2F2522B9
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 23:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgHYVZ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 17:25:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42928 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgHYVZ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 17:25:27 -0400
Received: by mail-io1-f68.google.com with SMTP id g13so253100ioo.9;
        Tue, 25 Aug 2020 14:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lg+hqZTHAe/BLEKS5GJeE0Rlebpak0rX9eme2hF12Uo=;
        b=pt8OKLrQxekaTUmYFH9DNinNZAFtaaqhRfmB+7WMVgluxvcJBcD/JE9qqiXryxc85T
         u97gXtLOAWKcPHNaIsShJS0iR3VsFR2dSXb7HFAJKer+Ka9KGydIgvCin4QRRs6gKEHr
         /42yNHB/j/EHPXuWBQdYf28rJyMSNWDN8fZpildrM0jSAUmpiEqmr6oZSEjqSoiWhzsY
         zcHZSDqGdndKMhs4CS//R0mYK9xFnIuP93wEnfELFXLB1eoLhIyUZzsxqj5Fwr29yGni
         wQny6JPJ8DaX4g12ogovcLr+m/PFH22suTI6+f5y2YnQgdZ5jpd6PPiY2B9HD1u+0hBQ
         Lpwg==
X-Gm-Message-State: AOAM532BJ6kKPybOSKiV7NrBKG9KrFG+1cJ/hYd0woP/6UQFTYcgyV+g
        wXm7r6BIjBd1VgN3fmtGxA==
X-Google-Smtp-Source: ABdhPJx4FI3lgeilzIN4tG2HvKODEoeqep4y4IVVx4DDUmrw72padF0yehfdQVg1boNW+VeEFuytVA==
X-Received: by 2002:a05:6638:24cf:: with SMTP id y15mr12384197jat.137.1598390725844;
        Tue, 25 Aug 2020 14:25:25 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id p18sm123644ils.82.2020.08.25.14.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 14:25:25 -0700 (PDT)
Received: (nullmailer pid 1359816 invoked by uid 1000);
        Tue, 25 Aug 2020 21:25:21 -0000
Date:   Tue, 25 Aug 2020 15:25:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Elliot Berman <eberman@codeaurora.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Trilok Soni <tsoni@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: Re: [RESEND PATCH v1 2/4] dt-bindings: power: reset: Add alternate
 reboot mode format
Message-ID: <20200825212521.GA1346433@bogus>
References: <1597776856-12014-1-git-send-email-eberman@codeaurora.org>
 <1597776856-12014-3-git-send-email-eberman@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597776856-12014-3-git-send-email-eberman@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 18, 2020 at 11:54:14AM -0700, Elliot Berman wrote:
> Current reboot-mode device tree schema does not support reboot commands
> with spaces in them [1]. Add an optional new node "reboot-mode-names"
> and "reboot-mode-magic" which add an array of strings and u32s,
> respectively which would permit any string in this framework.

Kind of a weak justification. The intent was for the names to be a key, 
not a multi word description which your example seems to be. Is 
"dm-verity device corrupted" something Android has already standardized 
on?

> 
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/md/dm-verity-target.c?h=v5.5#n255
> 
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> ---
>  .../devicetree/bindings/power/reset/reboot-mode.yaml    | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> index a6c9102..4ea6b33 100644
> --- a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> @@ -19,6 +19,9 @@ description: |
>    the bootloader what to do when the system reboots, and should be named
>    as mode-xxx = <magic> (xxx is mode name, magic should be a non-zero value).
>  
> +  reboot-mode-magic and reboot-mode-names may be used in addition/instead of
> +  mode-xxx style.

It should be either/or in my opinion, not both.

> +
>    For example, modes common Android platform are:
>      - normal: Normal reboot mode, system reboot with command "reboot".
>      - recovery: Android Recovery mode, it is a mode to format the device or update a new image.
> @@ -32,6 +35,14 @@ properties:
>        description: |
>          Default value to set on a reboot if no command was provided.
>  
> +  reboot-mode-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description: List of reboot commands, paired with reboot-mode-magic by index
> +
> +  reboot-mode-magic:

'reboot-modes' would align with normal patterns.

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: List of reboot magic, paired with reboot-mode-names by index
> +
>  patternProperties:
>    "^mode-.*$":
>      $ref: /schemas/types.yaml#/definitions/uint32
> @@ -44,4 +55,10 @@ examples:
>        mode-bootloader = <2>;
>        mode-loader = <3>;
>      };
> +
> +  - |
> +    reboot-mode {
> +      reboot-mode-names = "normal", "bootloader", "dm-verity device corrupted";
> +      reboot-mode-magic = <0x0>, <0x1>, <0xf>;
> +    };
>  ...
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
