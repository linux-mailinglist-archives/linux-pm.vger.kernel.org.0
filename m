Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A069C9846E
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 21:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbfHUTbI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 15:31:08 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45444 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbfHUTbH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 15:31:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id m24so3135536otp.12;
        Wed, 21 Aug 2019 12:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P+mIfgwF/Dx2fvxKM3KDec35UT4pGef1zpaBcJAd0yE=;
        b=PUXY5/aAwqR7vNQWrircfHZtgN0Y6oxXxEgo6apwP6AGELCwtjJ2GOYbLjGze9cPTD
         BDVp42PRI4aRcw3fFG5+iSPnG7Zb7+2jl8zafYvOg04ZlxtxHPSc7155+L0KaTL1nVgw
         7NAIoynEqnbGKvnikY9PuQD8ikvq/QjrxcrRZ38NbFQ7iqBWWcsuKb7cHRGJMgzJVgBA
         XiQJWSzodoq4wX03JBgyXp8DEZQtg7AeM27q0tVK6b+ZOIq3a+opDjGYZexXpF9+7Pyn
         Zn5xDjS6g1NNhG+zW9O4qBinJRswS+0BYJxmAhFcNjOM0n2Jk5HP05vEik6ZD6dmPC5h
         W1FA==
X-Gm-Message-State: APjAAAUEqZ8f7Q/ibHeOqFIXYwld4MK03ijCg01YR3xyp73jeXHFmtoH
        QdPZwYCvZEXmNHVbcFkxaw==
X-Google-Smtp-Source: APXvYqw6uPnGkUwS9jVi2LxBcn0vQmq1CDVBqNIUieYulJDWQvedafQd3o4SAYeZa+ky0wbndYwwYQ==
X-Received: by 2002:a9d:7e6:: with SMTP id 93mr28714164oto.143.1566415866696;
        Wed, 21 Aug 2019 12:31:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v17sm4961879ote.62.2019.08.21.12.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 12:31:06 -0700 (PDT)
Date:   Wed, 21 Aug 2019 14:31:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     daniel.lezcano@linaro.org, khilman@baylibre.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/6] dt-bindings: thermal: Add DT bindings
 documentation for Amlogic Thermal
Message-ID: <20190821193105.GA25977@bogus>
References: <20190806130506.8753-1-glaroque@baylibre.com>
 <20190806130506.8753-2-glaroque@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806130506.8753-2-glaroque@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 06, 2019 at 03:05:01PM +0200, Guillaume La Roque wrote:
> Adding the devicetree binding documentation for the Amlogic temperature
> sensor found in the Amlogic Meson G12 SoCs.
> the G12A  and G12B SoCs are supported.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  .../bindings/thermal/amlogic,thermal.yaml     | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> new file mode 100644
> index 000000000000..d25e59113398
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/amlogic,thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Thermal
> +
> +maintainers:
> +  - Guillaume La Roque <glaroque@baylibre.com>
> +
> +description: Binding for Amlogic Thermal Driver

Bindings are for h/w blocks, not drivers.

Other than that nit,

Reviewed-by: Rob Herring <robh@kernel.org>
