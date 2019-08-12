Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E65E98AB75
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 01:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfHLXuf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 19:50:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45814 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfHLXuf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 19:50:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id m24so12762253otp.12;
        Mon, 12 Aug 2019 16:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wu+Yll/a4SFv+CqAeDhttcKl/XjxKpsIr9S2nfoZc4M=;
        b=lHB30SRIzvFYGAsID4zuLtSUGM2t2/5xKA4ljm7KsygAkJmnE10YQ55Mh3YQfgXxK5
         Nc+MO2e5QglZXqC1TsajZoZlVCkh2B6yF/8Zn/7YNmGPBAV/ci9vVC/Wd7tSmF6UqfAb
         3Eb3Tv/ug88K5u1X+wfIfOtIMm80/sVonzb1eRnvTmeMaSFJ6vgiBh6S8q/kTFaBMc2X
         ur89c7MT78FJyDyyWPIo3qVgKTrSWjYkBn7Kw6uklPEpFhmvfn5mG7LXDSv9KKD3WchM
         /+52RLuvJ/G0AX9hWNbGGlV/5hprQUJnHvgdYieYi4HP230klo5xBD1JKJ9JofXZdB0L
         DX7g==
X-Gm-Message-State: APjAAAXtExRToNvnVD+MlgECm2g31MjiZTAN4AMZMDfKKAgJPwnCOIVu
        4rTj9CbjBb1CCCLDb412SA==
X-Google-Smtp-Source: APXvYqx5Pv9z7njFaTAOthJEXcWpHg1NmhbYE+TwIbn7UqsGcIDNzFfJG9k3aLDX0IZoXAaHdvDBEg==
X-Received: by 2002:a6b:6f06:: with SMTP id k6mr13023011ioc.232.1565653834113;
        Mon, 12 Aug 2019 16:50:34 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id t133sm153140480iof.21.2019.08.12.16.50.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 16:50:33 -0700 (PDT)
Date:   Mon, 12 Aug 2019 17:50:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Evgeny Kolesnikov <evgenyz@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] power: reset: Add UART-based MCU poweroff DT bindings
Message-ID: <20190812235032.GA8575@bogus>
References: <cover.1563822216.git.evgenyz@gmail.com>
 <cda16032dc5679a557230cbdb63702b105782b3b.1563822216.git.evgenyz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda16032dc5679a557230cbdb63702b105782b3b.1563822216.git.evgenyz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 22, 2019 at 09:53:01PM +0200, Evgeny Kolesnikov wrote:
> This adds device tree bindings of the poweroff driver
> for power managing micro controller units that are connected
> to a board via the UART interface.
> 
> Signed-off-by: Evgeny Kolesnikov <evgenyz@gmail.com>
> ---
>  .../bindings/power/reset/uart-poweroff.txt    | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/uart-poweroff.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/uart-poweroff.txt b/Documentation/devicetree/bindings/power/reset/uart-poweroff.txt
> new file mode 100644
> index 000000000000..86d036271b51
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/uart-poweroff.txt
> @@ -0,0 +1,38 @@
> +* UART-based PM MCU power off driver
> +
> +Some devices have a microcontroller controlling the main power
> +supply. This microcontroller is connected to UART of the SoC.
> +Sending a sequence of characters tells the MCU to turn
> +the power off.

IMO, you should have a node representing the specific microcontroller. 
Generic binding attempts like this generally don't work well because you 
need a never ending addition of properties to deal with h/w (and f/w in 
this case) differences. The properties you already have are evidence of 
this.

Now, if you want a common driver, then that is a separate issue. You can 
have multiple, specific bindings map to a common driver (or not, it's up 
to the OS).

Rob
