Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4F61E5405
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 04:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgE1CgP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 22:36:15 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:42962 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1CgP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 22:36:15 -0400
Received: by mail-il1-f194.google.com with SMTP id 18so26184543iln.9;
        Wed, 27 May 2020 19:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cfF5ModUsW5GewbfxK9GxhBwZ2W/pqCfiivqf9BZ1sk=;
        b=Y2WVKRNpHhc/XZbRKsJRhdKY3N5ytCCPwWggFJ/G9CK8O5TWfO1Dwfpdp48leZS3o1
         qUgV0uBRyQ1Kj4WewivwshlnNL297n0G7LB0/895YChYNBOr5t/kipCSH59V4OY3MXP7
         fxVsmhaBT1yx0IUS4QKVzeI1XwbLAR5TTYWTmbJ6b4IgUhjZHbwPiE/KwMsja8KldSVY
         ZFfvlwAetQz2ycPyI6iU77hWEmLmwCYTYYJTtujPt/MO+CArbY8IEZFHVHIIJimYPWr+
         4/E8Jqb7onhbeFqycw7SiAilBKzeWp3ZK88oc+s0GWM1Vmbc7KCqGT0psBj++UbXjAhH
         YDlg==
X-Gm-Message-State: AOAM530lr2YdmOpVhtDCvAoLQrcSm1lY4yReoiYxptzEpYBd9oZKHf8N
        /xfuJfOZeTGY7BYs/H2+Pogytdo=
X-Google-Smtp-Source: ABdhPJwB7K+cKDEtAU45Y/v8mgS6JexHSFOP39UYC/lJSWkv0WAitwS2bu+kl1okpo6Wymv3WZiWEg==
X-Received: by 2002:a92:1b86:: with SMTP id f6mr1103938ill.9.1590633373147;
        Wed, 27 May 2020 19:36:13 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l7sm2799356ilh.54.2020.05.27.19.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:36:12 -0700 (PDT)
Received: (nullmailer pid 3253074 invoked by uid 1000);
        Thu, 28 May 2020 02:36:11 -0000
Date:   Wed, 27 May 2020 20:36:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: thermal: rcar-gen3-thermal: Convert
 bindings to json-schema
Message-ID: <20200528023611.GA3253026@bogus>
References: <20200513151201.1258162-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200513151201.1258162-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 13 May 2020 17:12:01 +0200, Niklas Söderlund wrote:
> Convert Renesas R-Car Gen3 Thermal bindings documentation to
> json-schema.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> * Changes since v2
> - Use reg = <0xe6198000 0x100> instead of reg = <0 0xe6198000 0 0x100>
>   in examples due to #{address,size}-cells = <1>.
> 
> * Changes since v1
> - Improved on reg and interrupt descriptions with the use of 'items:'
> - Improved the examples inside the yaml file
> - Added compatibility value renesas,r8a77961-thermal for R-Car M3-W+
>   which was merged in the text binding description.
> ---
>  .../bindings/thermal/rcar-gen3-thermal.txt    | 60 -----------
>  .../bindings/thermal/rcar-gen3-thermal.yaml   | 99 +++++++++++++++++++
>  2 files changed, 99 insertions(+), 60 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> 

Applied, thanks!
