Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3954434B7
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 18:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhKBRpT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 13:45:19 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:34807 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhKBRpS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Nov 2021 13:45:18 -0400
Received: by mail-oi1-f173.google.com with SMTP id w193so31149780oie.1;
        Tue, 02 Nov 2021 10:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j7SAltEFCFCxWIOQc/N0dj7i5qLB+kB8LHdDq/G0tp4=;
        b=SFHcdjS1UAsORZic0DO2zAZjvKmgPtS2PE8HSShQbwge3e5qQhmS6LudR7ExOn0E0Y
         1QImTARB5etMAdx2Pyt3ORvrVlop1F0LDv5O9bs8xqcjfvcQUh/N7yW99ASvrPYov+bC
         Z0Udr2Jvwk7x2Q6Jyjq66+xIIhpOEChld+USmpK0sqoI4OwD1cI88prseo9Wa8kqATGY
         iz9Btmikql7X8NzvRs2w/p0a273SCmy+laGfDPd+5Itlvr8+Y2rP49DUdN3dB7NvWRHr
         nSvHh9zokslRaTXQDzsv7MJZX+gK0LWrkrIPvEHkRfrNUJ/IfTahgEQd03jr+Ykdof2T
         RSVg==
X-Gm-Message-State: AOAM530LZAkhjGey2fgJ0mCEg7wU7piPIrquFygdvXPo49o4Z+Qg+kGt
        a7d5jvpYsLVtNRGOr+sZU3IM+EzS3A==
X-Google-Smtp-Source: ABdhPJxCHwK3tNXuY/YgeMOJexw/W0yAQWldXe1P4Gu1A/OO+rC6EYp+fOSVGILxfLyI03i0bzyk7g==
X-Received: by 2002:a05:6808:bd6:: with SMTP id o22mr6157254oik.151.1635874963125;
        Tue, 02 Nov 2021 10:42:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h4sm1574693otr.8.2021.11.02.10.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 10:42:42 -0700 (PDT)
Received: (nullmailer pid 3139749 invoked by uid 1000);
        Tue, 02 Nov 2021 17:42:41 -0000
Date:   Tue, 2 Nov 2021 12:42:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        ~okias/devicetree@lists.sr.ht
Subject: Re: [PATCH v3] dt-bindings: power: reset: gpio-poweroff: Convert txt
 bindings to yaml
Message-ID: <YYF4kXX9HWaef33N@robh.at.kernel.org>
References: <20211028165009.76641-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028165009.76641-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 28 Oct 2021 18:50:08 +0200, David Heidelberg wrote:
> Convert power-off action connected to the GPIO documentation to the YAML syntax.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v3:
>  - incorporated Sebastian notes
> v2:
>  - remove driver specific note about WARN_ON
> 
>  .../bindings/power/reset/gpio-poweroff.txt    | 41 -------------
>  .../bindings/power/reset/gpio-poweroff.yaml   | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
