Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8323B131B25
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 23:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgAFWP7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 17:15:59 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46532 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgAFWP7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 17:15:59 -0500
Received: by mail-ot1-f65.google.com with SMTP id r9so246793otp.13
        for <linux-pm@vger.kernel.org>; Mon, 06 Jan 2020 14:15:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q4aqEcEXQdHw3uki8qu3nWuz9k6ghGOYowLINem0O0M=;
        b=PDWP2o9MgLEO5GoPfDTNI8ifh8hLF/vU6utmqIgDX0VFx9tmZpqbzS0GZrWBRD3Uiy
         fEZ4/3Jrohj4AupBAdjNbKp95FbgP+6vvxiEFxqlnbtuXjKKxnKmJzf0xlc8+SGyL6ua
         h6vDMohcNHxQ9bAEcu+JR7pkuuSh7D8IVovtJTZspczB1T3MSIjQ06TvoTbHPZqSQCL5
         x8mGFz++qNRfWLrk6UGpvgFL7Na6epXwsfmLQDDaDqvYBvGx3nK0qQbm9LqChcl8eZ5L
         8O7DUKxZXvhG0yZa0IRM24wDqVZlCnzj+cf7TGolO5HQDPoIx+lqOSVy3dqdsIyGJ/Di
         ouBw==
X-Gm-Message-State: APjAAAXWMzB+xNBx8FP/jpZyp0v2turDlPPK7GIogYnK4H79teDQ+b+1
        ompSSPMgZTGM7VD0ij7uQEyos5Y=
X-Google-Smtp-Source: APXvYqyZoRHf8sW/gVWRdSWC43SItKR8CJUZg1ij7psLzB5usfY8dGH0Okn9U4KwtDOh5h25dOazew==
X-Received: by 2002:a9d:6b12:: with SMTP id g18mr114323674otp.211.1578348958278;
        Mon, 06 Jan 2020 14:15:58 -0800 (PST)
Received: from rob-hp-laptop (ip-70-5-121-225.ftwttx.spcsdns.net. [70.5.121.225])
        by smtp.gmail.com with ESMTPSA id a17sm23620095otp.66.2020.01.06.14.15.56
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:15:57 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22043f
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 06 Jan 2020 16:15:54 -0600
Date:   Mon, 6 Jan 2020 16:15:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org
Subject: Re: [PATCH V2 1/4] dt-bindings: Add Broadcom AVS RO thermal
Message-ID: <20200106221554.GA26925@bogus>
References: <1578072236-31820-1-git-send-email-wahrenst@gmx.net>
 <1578072236-31820-2-git-send-email-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578072236-31820-2-git-send-email-wahrenst@gmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 03, 2020 at 06:23:53PM +0100, Stefan Wahren wrote:
> Since the BCM2711 doesn't have a AVS TMON block, the thermal information
> must be retrieved from the AVS ring oscillator block. This block is part
> of the AVS monitor which contains a bunch of raw sensors.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  .../bindings/thermal/brcm,avs-ro-thermal.yaml      | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
> new file mode 100644
> index 0000000..7dce05e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0+

Dual license new bindings please:

(GPL-2.0-only OR BSD-2-Clause)

With that:

Reviewed-by: Rob Herring <robh@kernel.org>
