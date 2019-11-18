Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1E5100A55
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 18:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfKRRfZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 12:35:25 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34466 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfKRRfY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 12:35:24 -0500
Received: by mail-oi1-f193.google.com with SMTP id l202so16103124oig.1;
        Mon, 18 Nov 2019 09:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jcjl+xEyXDK406FvNEw7KIB7W8gDcLzQthDaCbnKJGk=;
        b=PfP8rW8KmIsK1t9sFuGv1qvRkRDCjxK1mJYcHvaJ9HVpLxSpK79jm6JGOowdgbdw36
         odI0ErPdhyyT17EMjRsgsrto69kpvNMBc+jFPdIAf+iGy+RoVX3xOVMFmfMybyaWVzYC
         OrGc4tAZCFMFrDXxWjTsuhHXIb6qG1WDNaeb34LnASB6GyYRwM2ziR5anhd4HB3uHg6p
         X8jui/dvQdKFAUU+2WAg//OKnsJCUOgM6tVtyPg9bVt5oZoOfEowtiFQ9BNUjbqM886E
         ytQuL5e/gAYb2yEk0XLsKyKjsoYGus/h3MreYkwzm1V396D0WNHzqosycDo8DlBHpsUx
         j2oQ==
X-Gm-Message-State: APjAAAX7c1c3JqxMOR0YSMgTYL/pQJGyxKi2/1vUqJ5heOEUN+SBUoLg
        lUfv7XL/5Pb4Ua0F21btgQ==
X-Google-Smtp-Source: APXvYqwfUzBQrNJcOeJA5zqpj+/wS2ZIsgG7m9QKMazBEknnz6EFpoefnzgkRP4MpUSzowTNdWON0g==
X-Received: by 2002:aca:d4c6:: with SMTP id l189mr108313oig.68.1574098522296;
        Mon, 18 Nov 2019 09:35:22 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d3sm6409543otq.25.2019.11.18.09.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 09:35:21 -0800 (PST)
Date:   Mon, 18 Nov 2019 11:35:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rajan Vaja <rajan.vaja@xilinx.com>
Cc:     sre@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        jollys@xilinx.com, tejas.patel@xilinx.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: reset: xilinx: Add bindings for
 ipi mailbox
Message-ID: <20191118173520.GA23767@bogus>
References: <1573564851-9275-1-git-send-email-rajan.vaja@xilinx.com>
 <1573564851-9275-2-git-send-email-rajan.vaja@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573564851-9275-2-git-send-email-rajan.vaja@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 12, 2019 at 05:20:50AM -0800, Rajan Vaja wrote:
> Add IPI mailbox property and its example in xilinx zynqmp-power
> documentation.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---
>  .../bindings/power/reset/xlnx,zynqmp-power.txt     | 41 ++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
> index d366f1e..450f3a4 100644
> --- a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
> +++ b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
> @@ -8,9 +8,27 @@ Required properties:
>   - compatible:		Must contain:	"xlnx,zynqmp-power"
>   - interrupts:		Interrupt specifier
>  
> --------
> -Example
> --------
> +Optional properties:
> + - mbox-names	: Name given to channels seen in the 'mboxes' property.
> +		  "rx" - Mailbox corresponding to receive path
> +		  "tx" - Mailbox corresponding to transmit path

The order here doesn't match the example. The order should be defined.

> + - mboxes	: Standard property to specify a Mailbox. Each value of
> +		  the mboxes property should contain a phandle to the
> +		  mailbox controller device node and an args specifier
> +		  that will be the phandle to the intended sub-mailbox
> +		  child node to be used for communication. See
> +		  Documentation/devicetree/bindings/mailbox/mailbox.txt
> +		  for more details about the generic mailbox controller
> +		  and client driver bindings. Also see
> +		  Documentation/devicetree/bindings/mailbox/ \
> +		  xlnx,zynqmp-ipi-mailbox.txt for typical controller that
> +		  is used to communicate with this System controllers.
> +
> +--------
> +Examples
> +--------
> +
> +Example with interrupt method:
>  
>  firmware {
>  	zynqmp_firmware: zynqmp-firmware {
> @@ -23,3 +41,20 @@ firmware {
>  		};
>  	};
>  };
> +
> +Example with IPI mailbox method:
> +
> +firmware {
> +
> +	zynqmp_firmware: zynqmp-firmware {
> +		compatible = "xlnx,zynqmp-firmware";
> +		method = "smc";
> +
> +		zynqmp_power: zynqmp-power {
> +			compatible = "xlnx,zynqmp-power";
> +			mboxes = <&ipi_mailbox_pmu0 0>,
> +				 <&ipi_mailbox_pmu0 1>;
> +			mbox-names = "tx", "rx";

interrupts is required.

> +		};
> +	};
> +};
> -- 
> 2.7.4
> 
