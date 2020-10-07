Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304A72862AB
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 17:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgJGPyr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 11:54:47 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37608 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgJGPyr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2020 11:54:47 -0400
Received: by mail-oi1-f195.google.com with SMTP id t77so2956851oie.4;
        Wed, 07 Oct 2020 08:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QftSWzeT4fIRyrSr9QwWFstQOe+QpsylxaS1/K6kB0o=;
        b=rCkpLBebFALPSWZpmW93857DnRXDkhheSVpGFeXxQmL6t+Utmfi3tfBZZdzeyFKio3
         x9pwy8syayA1KUguFmoQ7Zi6/ltSfXjR0/tAlCLK86vFVKe3AQufIyJbHg820fp/XeYB
         aBdoP9Vj8Y6fqola2s50EGrfvVQgwW9s+R8Nw4kLrZzTVtjixRy7Pgr7Yz1DJLNMKpvz
         XLw+HHhw/x5iQS+jal6xS9n+CiSBhwz/UrSyyU0otEt95w1IPTgZXNph97NDDSXLj27V
         mjJhND6KSFbuIp5S3qBxNfFhT7IfvTwX2AMWHVCxvX2EPb8BifEeUp90rtq5dmYfankm
         ixyg==
X-Gm-Message-State: AOAM532QoffsfaY4aXzfiBV6Mw4Yjh4nL5WsH+xLMcIgezNownke3xQJ
        OSRD4tIXg5pI2HN+yoQvgA==
X-Google-Smtp-Source: ABdhPJw6jB0Jnw0jFNu8VUlaFNtbg3ekOxu3PYHTfvu0vTtxChrGCPYpDjJ+ABkEQVKZvtXdoMMCdQ==
X-Received: by 2002:a05:6808:8f3:: with SMTP id d19mr2256431oic.36.1602086086748;
        Wed, 07 Oct 2020 08:54:46 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u125sm2267392oif.21.2020.10.07.08.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 08:54:46 -0700 (PDT)
Received: (nullmailer pid 290182 invoked by uid 1000);
        Wed, 07 Oct 2020 15:54:45 -0000
Date:   Wed, 7 Oct 2020 10:54:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: reset: ocelot: Add Sparx5 support
Message-ID: <20201007155445.GA290129@bogus>
References: <20201006200316.2261245-1-lars.povlsen@microchip.com>
 <20201006200316.2261245-2-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006200316.2261245-2-lars.povlsen@microchip.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 06 Oct 2020 22:03:14 +0200, Lars Povlsen wrote:
> This adds the support for the Sparx5 SoC.
> 
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  .../devicetree/bindings/power/reset/ocelot-reset.txt       | 7 +++++--
>  MAINTAINERS                                                | 1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
