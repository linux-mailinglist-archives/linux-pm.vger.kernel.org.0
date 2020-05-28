Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D711E53D7
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 04:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgE1CZI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 22:25:08 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:40621 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE1CZG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 22:25:06 -0400
Received: by mail-il1-f194.google.com with SMTP id a18so8868463ilp.7;
        Wed, 27 May 2020 19:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TWK/yt8wEPtAEh5uiWmORMzf8N+47TheQbGehNEJTNo=;
        b=WoazSe3cPYQ8opkECLol3Ww/SVmLMfmzcHh7BByCb/MPYtw0uO0s678GQUkSfXui6c
         ko7f2P1mUze3j+18eTZOozCn9XiDZgV+Ihxhsf4xh3uaamaJK2IulWK9/nL9FAAgRdoM
         oUkn4nSJjTFVf3yKSX9CNGC6LkCuFIvy+NfCLhPsRqxV/j5c6aXEIgzUQSMwRidxCv9E
         pqyKq6ntdsl6kVCI4Uqt502RARhWa0avVMqbj8MaeeO+LbM56sx9EBZF4QDaxzKsChmh
         +8a9qK84nOq2JXxwfEzpTg86pQLMv6Z2uka1eH+bMkTLT9NDLYfp949DSiOSDZ9MTKQ0
         uuGw==
X-Gm-Message-State: AOAM532XUbeqMXKA6P0RF5QWNpV632vBGq88LzC+NtCv0PrG+MJvl/Bq
        Py+zMabOq0ddpDJ9etm8KA==
X-Google-Smtp-Source: ABdhPJznBK7J4jfTRRptgmH6VfuihabhXQkH6wzIbabFHPxNfhYIn/vanUVmodLM98GWZsQkpBEuAw==
X-Received: by 2002:a05:6e02:6cd:: with SMTP id p13mr994377ils.188.1590632703884;
        Wed, 27 May 2020 19:25:03 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y15sm2477235ila.13.2020.05.27.19.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:25:03 -0700 (PDT)
Received: (nullmailer pid 3238161 invoked by uid 1000);
        Thu, 28 May 2020 02:25:02 -0000
Date:   Wed, 27 May 2020 20:25:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Sebastian Reichel <sre@kernel.org>, SoC Team <soc@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] dt-bindings: reset: ocelot: Add documentation for
 'microchip,reset-switch-core' property
Message-ID: <20200528022502.GA3234572@bogus>
References: <20200513130842.24847-1-lars.povlsen@microchip.com>
 <20200513130842.24847-4-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513130842.24847-4-lars.povlsen@microchip.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 13, 2020 at 03:08:40PM +0200, Lars Povlsen wrote:
> This documents the 'microchip,reset-switch-core' property in the
> ocelot-reset driver.
> 
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  .../devicetree/bindings/power/reset/ocelot-reset.txt        | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> index 4d530d8154848..20fff03753ad2 100644
> --- a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> +++ b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> @@ -9,9 +9,15 @@ microchip Sparx5 armv8 SoC's.
>  Required Properties:
>   - compatible: "mscc,ocelot-chip-reset" or "microchip,sparx5-chip-reset"
> 
> +Optional properties:
> +- microchip,reset-switch-core : Perform a switch core reset at the
> +  time of driver load. This is may be used to initialize the switch
> +  core to a known state (before other drivers are loaded).

How do you know when other drivers are loaded? This could be a module 
perhaps. Doesn't seem like something that belongs in DT.

Can this behavior be implied with "microchip,sparx5-chip-reset"?

Rob
