Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBD01632F3
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 21:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgBRUVZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 15:21:25 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34783 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgBRUVY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 15:21:24 -0500
Received: by mail-oi1-f195.google.com with SMTP id l136so21477793oig.1;
        Tue, 18 Feb 2020 12:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F9jkh+/fNp4Y5wEGWU8rzllhc5qsbjBGTVE5ft08a3c=;
        b=rUoyXPeOmhhwAVuYlSaL/4ojlaEegRrlW9LKSDNJU12qH0K8o+Fsd4wxAmMAaZ8D0K
         7RVCiY+Pvj/AExKUJRTtalsxIbsSRL7uXNXwopRM2NyC2l9istVy8mIdZAkwg/he2qM0
         +xbChy3MQA6JKhmeJld4E9+9uxzR+fcl0cF4uetNl1esvES6nUjOXE6q/SIT9REQr+0C
         dm1fTeDf8MCUZAxriJsxXXLCDPkvfv72ypSVUM8/BFBXAHhxDmqYXorlsvQ7mbp412ZO
         tPJFJ5INhBVg0VYMdOR95sCyKKbNIXxB5iCKEB+pCrUevw14/Fi1pGcuvLJcxWYmmcxn
         fFaw==
X-Gm-Message-State: APjAAAU21Ind7ccg6q613RY+fY83eV9H10uKemYSLk7XIEKszKp7YlOx
        QPFQqKcJdqVWPj4dGTtzng==
X-Google-Smtp-Source: APXvYqxxI5/yvfE6TWxGfCzlPsVVyL00VpQhaRXuGLGad07TbLFlr20GdHieWRmm3gmVmxUz4deJdQ==
X-Received: by 2002:a54:4f14:: with SMTP id e20mr2347031oiy.84.1582057283844;
        Tue, 18 Feb 2020 12:21:23 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w20sm1689415otj.21.2020.02.18.12.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 12:21:23 -0800 (PST)
Received: (nullmailer pid 1393 invoked by uid 1000);
        Tue, 18 Feb 2020 20:21:22 -0000
Date:   Tue, 18 Feb 2020 14:21:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com,
        mikko.mutanen@fi.rohmeurope.com, markus.laine@fi.rohmeurope.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/5] dt_bindings: ROHM BD99954 Charger
Message-ID: <20200218202122.GA599@bogus>
References: <cover.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
 <104b5ef63c2ad4771503d9e6618bf427721042c3.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <104b5ef63c2ad4771503d9e6618bf427721042c3.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 14 Feb 2020 09:36:47 +0200, Matti Vaittinen wrote:
> The ROHM BD99954 is a Battery Management LSI for 1-4 cell Lithium-Ion
> secondary battery. Intended to be used in space-constraint equipment such
> as Low profile Notebook PC, Tablets and other applications. BD99954
> provides a Dual-source Battery Charger, two port BC1.2 detection and a
> Battery Monitor.
> 
> Document the DT bindings for BD99954
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> It would probably be nice if the charger DT binding yaml could somehow
> be listing and evaluating properties that it can use from static battery
> nodes - and perhaps some warning could be emitted if unsupported
> properties are given from battery nodes(?) Just some thinking here.
> What if the charger ignores for example the current limits from battery
> node (I am not sure but I think a few may ignore) - I guess it would be
> nice to give a nudge to a person who added those properties in his DT
> if they won't have any impact? Any thoughts?
> 
>  .../bindings/power/supply/rohm,bd9995x.yaml   | 167 ++++++++++++++++++
>  1 file changed, 167 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

warning: no schema found in file: Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml: ignoring, error parsing file
Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml:  while scanning a simple key
  in "<unicode string>", line 29, column 3
could not find expected ':'
  in "<unicode string>", line 30, column 1
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/power/supply/rohm,bd9995x.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/power/supply/rohm,bd9995x.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1237902
Please check and re-submit.
