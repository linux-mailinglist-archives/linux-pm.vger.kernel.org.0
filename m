Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136271D02AB
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 00:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgELW7j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 18:59:39 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43106 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELW7j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 18:59:39 -0400
Received: by mail-oi1-f193.google.com with SMTP id i22so3177502oik.10;
        Tue, 12 May 2020 15:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0UC4NbtLglXj+TePtbIPb7+gcptlXoZoh2pEtHEUCdg=;
        b=ONP4em11G1MnCeufAY1klKQ2GA69hGoP2t5BUaEL0Rr/LV/OXT1zZEnls/IcFWFTc7
         4/4QZUQfX6fOH+TZSjmgRWzLPUEDehJ8L8T73vQZE84QH/NOgSveUdOylrmyjTVZutu9
         WOt07OF2+dD/F7NDstb61H9zaIIsCyq4hvBMeWhfim1BQWjGp1a00ypwQmObB03yRopf
         yL0MMTfhfil6lPFe3XCF9fh+J/jZY1hAPPGYjguLdhXmh3yuvYjy1AzeshnWFoZ0dpog
         RXmbxmAoe2sxDW7gEEBV8RWaE7zxZgjPSK9/dq+o2d/xU5q81qX7YgCDPSVfQag3aO3S
         YcRQ==
X-Gm-Message-State: AGi0Puai7zfETdhQ1rtMFygVvv6yV85d3HrjdfNEsW2lqO0Zz+cEXiFE
        HZ/cc6WbqMYTKA9OjNDmlYKeXb2r9A==
X-Google-Smtp-Source: APiQypJNCS339xpAgtFKhpCcyzza/wCoFmF0mONWvXrTllgReQwOwZqhcFngIPk8xyiw+d5K8DlIwQ==
X-Received: by 2002:aca:5a04:: with SMTP id o4mr25251710oib.137.1589324378254;
        Tue, 12 May 2020 15:59:38 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f9sm3806492ote.30.2020.05.12.15.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:59:37 -0700 (PDT)
Received: (nullmailer pid 2033 invoked by uid 1000);
        Tue, 12 May 2020 22:59:36 -0000
Date:   Tue, 12 May 2020 17:59:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Sebastian Reichel <sre@kernel.org>, Angus Ainslie <angus@akkea.ca>,
        Yauhen Kharuzhy <jekhor@gmail.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/8] power: bq25890: document IBAT compensation DT
 properties
Message-ID: <20200512225936.GA312@bogus>
References: <cover.1588621247.git.mirq-linux@rere.qmqm.pl>
 <7bf8bb5654bf67e14b59c5f94d024ac6ef5ff0ce.1588621247.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bf8bb5654bf67e14b59c5f94d024ac6ef5ff0ce.1588621247.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 04, 2020 at 09:47:48PM +0200, Michał Mirosław wrote:
> Document newly introduced IBAT compensation settings.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
> v2: initial version
> ---
>  Documentation/devicetree/bindings/power/supply/bq25890.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.txt b/Documentation/devicetree/bindings/power/supply/bq25890.txt
> index dc9c8f76e06c..bd214945d9dc 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq25890.txt
> +++ b/Documentation/devicetree/bindings/power/supply/bq25890.txt
> @@ -32,6 +32,10 @@ Optional properties:
>  - ti,thermal-regulation-threshold: integer, temperature above which the charge
>      current is lowered, to avoid overheating (in degrees Celsius). If omitted,
>      the default setting will be used (120 degrees);
> +- ti,ibatcomp-resistance: integer, value of a resistor in series with
> +    the battery (in uOhm);
> +- ti,ibatcomp-clamp-voltage: integer, maximum charging voltage adjustment due
> +    to expected voltage drop on in-series resistor (in uV);

Need a unit suffix as defined in property-units.txt

Rob
