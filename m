Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABCF1689B
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 19:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfEGRAH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 13:00:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36223 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfEGRAG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 13:00:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id c3so919363otr.3;
        Tue, 07 May 2019 10:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GtZhOwZ/bTtESrjeuelzyEI5ZhYzjiOYMfEhvQ1jVFs=;
        b=DUjkIaM3wmbxTnt6u9nucqBl1b07ElYdmJMFphXMUdQYFPpkPOeweFRk0ligv8T0Pv
         g/9LMS5ca2G3ECcG1WJnzqu1pGBEw9U/iu0WbNVx6yDBWgb0iu+1a7SNFr7aO/vBKctN
         A+TiLwFf2LsL15jjFn9vVfAapcC1e5yyWHj3lmliNsXc6iqvIOgeV7Kn3A0eQ6rFa1qw
         JP8cYRTnZRhtkjO7y2X8lEx1RfFdn0RU7GeAeHeXmmYMgKSboI5DphBcOFAlAdX7GPV+
         yBF6+A2Ufka/ClOtaJyY0fAUGLaIRTRlh7+jEZ3HbBBJejPyEu0njjYEd5p7QHxjvuBZ
         U1ig==
X-Gm-Message-State: APjAAAX7lkH4u7P6ekmYn2rg4+hqljYwcGsZ4ioYmbO2Yb3JhJp2oFx+
        dIL0pgkkbj9lamRdm7Nv1w==
X-Google-Smtp-Source: APXvYqz/aCcuINLUmkWXCNw2OAaozlzISu7TfYQC7Jlz7p8jBklm0uEoR6ZqwETgY6+Bcb/SRAnm1Q==
X-Received: by 2002:a9d:7e93:: with SMTP id m19mr14226614otp.359.1557248405906;
        Tue, 07 May 2019 10:00:05 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m206sm5934303oif.50.2019.05.07.10.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 10:00:05 -0700 (PDT)
Date:   Tue, 7 May 2019 12:00:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v7 05/13] dt-bindings: ddr: add LPDDR3 memories
Message-ID: <20190507170004.GA20489@bogus>
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190506151214eucas1p17114a7dce506c77ae0bb96b93fd2d838@eucas1p1.samsung.com>
 <1557155521-30949-6-git-send-email-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557155521-30949-6-git-send-email-l.luba@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 06, 2019 at 05:11:53PM +0200, Lukasz Luba wrote:
> Specifies the AC timing parameters of the LPDDR3 memory device.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../devicetree/bindings/ddr/lpddr3-timings.txt     | 58 +++++++++++++
>  Documentation/devicetree/bindings/ddr/lpddr3.txt   | 97 ++++++++++++++++++++++
>  2 files changed, 155 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
>  create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3.txt
> 
> diff --git a/Documentation/devicetree/bindings/ddr/lpddr3-timings.txt b/Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
> new file mode 100644
> index 0000000..3a2ef3a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
> @@ -0,0 +1,58 @@
> +* AC timing parameters of LPDDR3 memories for a given speed-bin.
> +
> +The structures are based on LPDDR2 and extended where needed.
> +
> +Required properties:
> +- compatible : Should be "jedec,lpddr3-timings"
> +- min-freq : minimum DDR clock frequency for the speed-bin. Type is <u32>
> +- reg : maximum DDR clock frequency for the speed-bin. Type is <u32>
> +
> +Optional properties:
> +
> +The following properties represent AC timing parameters from the memory
> +data-sheet of the device for a given speed-bin. All these properties are
> +of type <u32> and the default unit is ps (pico seconds).
> +- tRFC
> +- tRRD
> +- tRPab
> +- tRPpb
> +- tRCD
> +- tRC
> +- tRAS
> +- tWTR
> +- tWR
> +- tRTP
> +- tW2W-C2C
> +- tR2R-C2C
> +- tFAW
> +- tXSR
> +- tXP
> +- tCKE
> +- tCKESR
> +- tMRD
> +
> +Example:
> +
> +timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@0 {

Now the unit-address should be @800000000

With that and the other example fixed,

Reviewed-by: Rob Herring <robh@kernel.org>

> +	compatible	= "jedec,lpddr3-timings";
> +	reg		= <800000000>; /* workaround: it shows max-freq */
> +	min-freq	= <100000000>;
