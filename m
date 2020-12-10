Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DC22D5178
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 04:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgLJDhw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 22:37:52 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45248 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbgLJDhv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 22:37:51 -0500
Received: by mail-ot1-f66.google.com with SMTP id h18so3615650otq.12;
        Wed, 09 Dec 2020 19:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mzmL/cqocrUbPTVhVRwNLiqSMNifMnYmWyvL/HJKlvc=;
        b=ajNOCR9nrqmYcZDo6AjKroQTKfa9f/B503j3sTlMk9jAoI3j7+9iyIEaBP8z3MgNdn
         KBOvob3dfDtXKlqR5ZTs3s0IbxBcPsZ9vJWo23JxEQ+vNTZt74Q0XZNIVg/PnBAXcn6c
         uYWNzevvkm0Boc4YuWvjOeQOMI/G+UCHDXyVdjchODkLbRT1ERUH/mUwOmKvrJ9rjjdb
         83i7NqzqPnLpFUjdhdX2HQ7FKpwhxqSCUWwVVdv0kdZLW1u2P1wmirAoVwE1vSMIGnuS
         m6O+MNTkOWWsITR2I/zjZbZid+mR2B54cEuTGnOrKIyOzMiixwBIrI0IuZSBEJQ5sN46
         qEWA==
X-Gm-Message-State: AOAM531Ki0obAtwcCWy34Z+KcWIsX3RLYQT2bir8APGNdCroaHn3Vhsi
        JOWAfb4XEioOjDiG1oP6nA==
X-Google-Smtp-Source: ABdhPJzEtvBU2o6Y5zBUf3Ax84L/wTQXpYXXCxobtgX7cv8FEOpg+xzasRQAncboRxY5AuPBKhbUgg==
X-Received: by 2002:a9d:4795:: with SMTP id b21mr4419285otf.65.1607571430533;
        Wed, 09 Dec 2020 19:37:10 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i82sm740215oif.33.2020.12.09.19.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 19:37:09 -0800 (PST)
Received: (nullmailer pid 1607732 invoked by uid 1000);
        Thu, 10 Dec 2020 03:37:08 -0000
Date:   Wed, 9 Dec 2020 21:37:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: input: Add reset-time-sec common
 property
Message-ID: <20201210033708.GA1606132@robh.at.kernel.org>
References: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
 <c08349db08db67e71cf428fe7fd53624aaa0acf8.1607216141.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c08349db08db67e71cf428fe7fd53624aaa0acf8.1607216141.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Dec 06, 2020 at 03:27:01AM +0200, Cristian Ciocaltea wrote:
> Add a new common property 'reset-time-sec' to be used in conjunction
> with the devices supporting the key pressed reset feature.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
> Changes in v3:
>  - This patch was not present in v2
> 
>  Documentation/devicetree/bindings/input/input.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
> index ab407f266bef..caba93209ae7 100644
> --- a/Documentation/devicetree/bindings/input/input.yaml
> +++ b/Documentation/devicetree/bindings/input/input.yaml
> @@ -34,4 +34,11 @@ properties:
>        specify this property.
>      $ref: /schemas/types.yaml#/definitions/uint32
>  
> +  reset-time-sec:

Humm, I'm pretty sure we already have something for this. Or maybe just 
power off.

> +    description:
> +      Duration in seconds which the key should be kept pressed for device to
> +      reset automatically. Device with key pressed reset feature can specify
> +      this property.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
>  additionalProperties: true
> -- 
> 2.29.2
> 
