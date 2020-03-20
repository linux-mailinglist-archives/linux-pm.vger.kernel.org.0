Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7E3218DB16
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 23:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgCTWW3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 18:22:29 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:45194 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgCTWW3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 18:22:29 -0400
Received: by mail-il1-f196.google.com with SMTP id m9so7106092ilq.12;
        Fri, 20 Mar 2020 15:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MEjj65WLp/ofnpLSUkG6r7NzqQWSzo80Si8/3jZK11k=;
        b=hAs8UXmd7WkpQ6g2M8GcBBtZwdk6EqwecwzoH/SZxMLfEgSZslx7SZH4hriPIj7sfx
         X6ipC4K4tLk9Uj1X/SpqA+IXyl80Uk395N/LOXD0RBx88jp56Yso5ofUsW0D2ETs7oXP
         m2vngmQzvXYvmDgTdgj4L880txbW5G9+b80cAO8vpcTtGbxw6/ae8PObbMKotze2KmlW
         NJ24r1M9e7pGk2uO3PZkV8BUHKyHyDwFGmBVf20s1l3uPBC8miR3TmKbr9IIRVvZmZv6
         QOXbEh342kAADJM0BqTBWeELp9lPr081hJTTi6qOfO6261rWr1mfcH+KY0YleKrjY5fz
         QEkg==
X-Gm-Message-State: ANhLgQ01OQ/udZ79ILQMnTMZrpXYa49iNndPY3l6mA416nV7Hw9ssc6S
        OESGznsD93RWhlMUMVJKaA==
X-Google-Smtp-Source: ADFU+vstN8SVzJtlJbqi3jZzdttOAufBDqkBE49quFSFYIc1VxdGyh4IFVXs33rn0zZHsmC39MrC9g==
X-Received: by 2002:a05:6e02:5a1:: with SMTP id k1mr10973554ils.133.1584742947798;
        Fri, 20 Mar 2020 15:22:27 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id n18sm2419968ilq.38.2020.03.20.15.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 15:22:26 -0700 (PDT)
Received: (nullmailer pid 32466 invoked by uid 1000);
        Fri, 20 Mar 2020 22:22:25 -0000
Date:   Fri, 20 Mar 2020 16:22:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: Document cellwise vendor-prefix
Message-ID: <20200320222225.GA32311@bogus>
References: <20200315191914.118565-1-t.schramm@manjaro.org>
 <20200315191914.118565-2-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315191914.118565-2-t.schramm@manjaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 15 Mar 2020 20:19:12 +0100, Tobias Schramm wrote:
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
