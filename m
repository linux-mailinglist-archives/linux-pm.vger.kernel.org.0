Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 011CB10296
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 00:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfD3Wre (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 18:47:34 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43381 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfD3Wre (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 18:47:34 -0400
Received: by mail-oi1-f193.google.com with SMTP id t81so12647826oig.10;
        Tue, 30 Apr 2019 15:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zc49vgyaf9Osgfs8bngxx3hqZVIwFkS67qrO5tobMu8=;
        b=Kh2EjRvWganiGjsA99znT7hqTil54qLx7Wlxqd5TGOyHhWVdL32qMI0R+dYt3UNQjB
         t3oRqMWcFB0P1SXvg5VZBk1PK4Jpqs685+OT88A4W546F7d+8AXEEqeffOYfDyCjlok8
         Tf+pFuC6PiB+Crta6Y7YUAPRrqipm/v7eIXXYicWCyTuvbeEqjWHkCX5yIuCrXeXB1oA
         g2/QXwkjQaQr8nz56yvFaGeiUtml49B0aEOL4UBmuwL/aU+0C9aJCaBpt/sNHube6aR0
         Oi9aDEwC9B1bf/d8bkx9EQZesrfGIM/Bfs3EGa2mE+Zmy4QsJ8DYdUouX84L+ZaARkuQ
         /PAA==
X-Gm-Message-State: APjAAAVASC+c6kKGVGPgqWaNyMzbTXm4sxFXXMZmsnVMQr85ugxJcYsQ
        +HzpfMG78jKCInJl6Z79GzX38EY=
X-Google-Smtp-Source: APXvYqxRBfZe+g/1V1bsotp53DMeISnhsnzhoDAMbomw9KTHuXHnSxTIZlWNWwVV6xiZl/kLflPebQ==
X-Received: by 2002:aca:378a:: with SMTP id e132mr4349653oia.171.1556664453373;
        Tue, 30 Apr 2019 15:47:33 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u11sm15635046otb.66.2019.04.30.15.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 15:47:32 -0700 (PDT)
Date:   Tue, 30 Apr 2019 17:47:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Han Nandor <nandor.han@vaisala.com>
Cc:     "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: power: reset: add document for NVMEM
 based reboot-mode
Message-ID: <20190430224731.GA31760@bogus>
References: <fc60b885f1b447ce55950184c7921cfc1c96ade6>
 <20190421190913.1478-3-nandor.han@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421190913.1478-3-nandor.han@vaisala.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 21, 2019 at 07:09:30PM +0000, Han Nandor wrote:
> Add the device tree bindings document for the NVMEM based reboot-mode
> driver.
> 
> Signed-off-by: Nandor Han <nandor.han@vaisala.com>
> ---
>  .../power/reset/nvmem-reboot-mode.txt         | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.txt
> new file mode 100644
> index 000000000000..2e1b86c31cb3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.txt
> @@ -0,0 +1,32 @@
> +NVMEM reboot mode driver
> +
> +This driver gets reboot mode magic value from reboot-mode driver
> +and stores it in a NVMEM cell named "reboot-mode". Then the bootloader
> +can read it and take different action according to the magic
> +value stored.

This is also assuming the nvmem is writeable which is more often not the 
case.

Is your usecase a platform that supports pstore? Adding on to that 
binding might be a better fit.

> +
> +This DT node should be represented as a sub-node of a "simple-mfd"
> +node.
> +
> +Required properties:
> +- compatible: should be "nvmem-reboot-mode".
> +- nvmem-cells: A phandle to the reboot mode provided by a nvmem device.
> +- nvmem-cell-names: Should be "reboot-mode".
> +
> +The rest of the properties should follow the generic reboot-mode description
> +found in reboot-mode.txt
> +
> +Example:
> +	reboot-mode-nvmem@0 {

What's this node for?

> +		compatible = "simple-mfd";

I only see 1 function.

> +		reboot-mode {
> +			compatible = "nvmem-reboot-mode";
> +			nvmem-cells = <&reboot_mode>;
> +			nvmem-cell-names = "reboot-mode";
> +
> +			mode-normal     = <0xAAAA5501>;
> +			mode-bootloader = <0xBBBB5500>;
> +			mode-recovery   = <0xCCCC5502>;
> +			mode-test       = <0xDDDD5503>;
> +		};
> +	};
> -- 
> 2.17.2
> 
