Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD7A2E0123
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 20:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgLUTiV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 14:38:21 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:33389 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgLUTiV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 14:38:21 -0500
Received: by mail-oi1-f178.google.com with SMTP id d203so12437125oia.0;
        Mon, 21 Dec 2020 11:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=816zv/4hxECWSLhw11qVK07He44ovt2wKRAFt6k7uto=;
        b=qhahAW8dkF20fNPDppQOUWG1Ugp0tuivBXdxV5HRd4AAcwYKwu9KwnKvpj+STC08xO
         rPMqQiRsMwFffgpM1ipNkalFoAVUoYdZwJ2gQyQZ3QU5hSDPXaT/qUBY3TFYDYBvmd2o
         sMjWbw6bzrOpOy7UOSHYf5gdR+CM5ADgPNdpprqEFfhlzOSz4b1WvhCtY71zvx1rEP+A
         hGTwf81RRyM04yItBXysZLw5G01KDA8yjRMkG7Sbn/8vSzAwK0DsTJu7u6bgVDmMJiIr
         zBNv04szDmblAFNQNy3HVYe9C3bNiEf1CHZX5h9TI05HOCuS1iDby50eCYUigvW4ZYkY
         QGog==
X-Gm-Message-State: AOAM5329FKEcEo1d+amfzYPBc1RkId8BoEARS0BpeyfrtTSQT0NOtZr8
        RN3hOW+Bk882RqL4l+iByw==
X-Google-Smtp-Source: ABdhPJzw9HnKMehYTwnQpzwy7dfMCcSYt/eu+OQrbRMlkXHoHZnOTcZrsC4JWc9poN0O7pieVbUWLQ==
X-Received: by 2002:aca:ba86:: with SMTP id k128mr12089770oif.9.1608579460387;
        Mon, 21 Dec 2020 11:37:40 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id t25sm1983138oic.15.2020.12.21.11.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 11:37:39 -0800 (PST)
Received: (nullmailer pid 422903 invoked by uid 1000);
        Mon, 21 Dec 2020 19:37:37 -0000
Date:   Mon, 21 Dec 2020 12:37:37 -0700
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com,
        sre@kernel.org, nicolas.ferre@microchip.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: atmel-sysreg: add
 microchip,sama7g5-shdwc
Message-ID: <20201221193737.GA422848@robh.at.kernel.org>
References: <1608123453-1423-1-git-send-email-claudiu.beznea@microchip.com>
 <1608123453-1423-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608123453-1423-3-git-send-email-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 16 Dec 2020 14:57:32 +0200, Claudiu Beznea wrote:
> Add compatible for Microchip SAMA7G5's shutdown controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
