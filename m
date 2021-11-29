Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A74460BEF
	for <lists+linux-pm@lfdr.de>; Mon, 29 Nov 2021 02:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbhK2BDd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Nov 2021 20:03:33 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:46980 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376600AbhK2BBd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Nov 2021 20:01:33 -0500
Received: by mail-oi1-f177.google.com with SMTP id s139so31370709oie.13;
        Sun, 28 Nov 2021 16:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HYW4xDlqeBOWeogQDjXMlHY9jcAQHj9Za+BSHS7q8UU=;
        b=sB8Qqfz1UYP9nq1QfqVMaduYLHVpqCpHaqBN95VXVhNOyC7GombKRrpe5IqHiwDFYX
         81o/sDwVozJv8VIOq8TN1/qXRxlcdn+iV6VhODmp6DzJcJyx2wbGt7YUsElC+07sfWlC
         n2fMoyAlIEIvirFm9Ew1BwrfNeZ6fhlXbILX06QQpZSHObiMGreYZSu6lRyXDoSoI7Vh
         ajaridtV830IfsMax++SR3Ng8zTOStKi2t+Frsb4Ggh3+qGbVm9uwaFSiECEaA5rJRfa
         leisughhrUmik6+D2PCZG+S8Fv5nv9+hJeWGjoiYiFTD3CrIN4GWrjBKJsZJQECdOCU7
         xCtw==
X-Gm-Message-State: AOAM533y7gXksxVFJ02nt/NIWfE9uQowopJII/UkNkc4NoShr+O3qLcW
        tyjKtPTi7pAVnW1RFzsJ5A==
X-Google-Smtp-Source: ABdhPJx51FA7lcMeqLgmAuiGuzXPh1dIDuSJvMpRQ94FFG+kP7SO/lIOv8cjCD9k659qjGFhNp5qBw==
X-Received: by 2002:aca:280d:: with SMTP id 13mr38738176oix.61.1638147495940;
        Sun, 28 Nov 2021 16:58:15 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.99.229])
        by smtp.gmail.com with ESMTPSA id t12sm2106780ood.22.2021.11.28.16.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 16:58:15 -0800 (PST)
Received: (nullmailer pid 2930665 invoked by uid 1000);
        Mon, 29 Nov 2021 00:58:12 -0000
Date:   Sun, 28 Nov 2021 18:58:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 04/11] dt-bindings: pinctrl: apple,pinctrl: Add
 power-domains property
Message-ID: <YaQlpImSWeN1bzvj@robh.at.kernel.org>
References: <20211124073419.181799-1-marcan@marcan.st>
 <20211124073419.181799-5-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124073419.181799-5-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 24 Nov 2021 16:34:14 +0900, Hector Martin wrote:
> This will bind to the PMGR pwrstate nodes that control power/clock
> gating to SoC blocks. The pinctrl driver doesn't do runtime-pm yet, so
> initially this will just keep the domain on permanently.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
