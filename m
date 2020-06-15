Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9307C1F9ED5
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 19:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbgFORts (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 13:49:48 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:34235 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgFORts (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 13:49:48 -0400
Received: by mail-io1-f44.google.com with SMTP id m81so18869339ioa.1;
        Mon, 15 Jun 2020 10:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E69M+/HHxmjJy3WjxOHBrpSNM901zCVG7eSXC9OYuK0=;
        b=iyL4iBcrw43O5O7+88TQxSRAdyiZp3ctlo+APjEjwZklXte6xRu0yk4jzqONzevAhq
         yGZc09Oc2POqozMC2PK8Yj0KC/B3m9YkSDpCljUUbI8PGmldbupWWcciN2kT8LEZMhke
         Dpn34g3sc4Yf5kpd7hOde/Fax55ZzeOGKPPXek2Mv/yP2miho0jwsA9nyXdnpt2+3AA6
         QKMBlZ8OpqMumtNtU/YqJEi/G+QGHf7WS83xKrrE2dgUF8UqBHjXz/k2vEvAbHj9+fxz
         e5umvNH07dGC3iFQxuOoDvxEhuov/uZX2tQC0fZscmvG0ib544jTUkoC2I/5uGpy8U76
         rqSg==
X-Gm-Message-State: AOAM532aqL4TVplBPrfx+yIBCxKNPS5cQo4EBgQMu3T6+rJYkj4sYOE6
        /j4LSh6liR2mD2oMEGKVUQ==
X-Google-Smtp-Source: ABdhPJxSbp+Dx4S42WakM7ahqNnP4zH6CRsjYOaTpPLDM89io2xDIJzBRgBMzaq+AEa//YCCSaYWMg==
X-Received: by 2002:a6b:8b12:: with SMTP id n18mr28410717iod.160.1592243387326;
        Mon, 15 Jun 2020 10:49:47 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id h13sm2334102ile.18.2020.06.15.10.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 10:49:46 -0700 (PDT)
Received: (nullmailer pid 2030488 invoked by uid 1000);
        Mon, 15 Jun 2020 17:49:45 -0000
Date:   Mon, 15 Jun 2020 11:49:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Emil Velikov <emil.velikov@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com
Subject: Re: [PATCHv2 1/6] dt-bindings: power: supply: gpio-charger: convert
 to yaml
Message-ID: <20200615174945.GA2030383@bogus>
References: <20200605224403.181015-1-sebastian.reichel@collabora.com>
 <20200605224403.181015-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605224403.181015-2-sebastian.reichel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 06 Jun 2020 00:43:58 +0200, Sebastian Reichel wrote:
> Convert the gpio-charger bindings from text format to
> new YAML based representation.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/power/supply/gpio-charger.txt    | 31 ----------
>  .../bindings/power/supply/gpio-charger.yaml   | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/gpio-charger.txt
>  create mode 100644 Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
