Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF49298FD0
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 15:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781927AbgJZOtN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 10:49:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41558 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781912AbgJZOtM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 10:49:12 -0400
Received: by mail-oi1-f195.google.com with SMTP id k65so10168937oih.8;
        Mon, 26 Oct 2020 07:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s+NfVc4x3xLzw7Zn7dJWrSR2PBWNHUkCvBLVaRL098Q=;
        b=omv5mE2yntYrky8kthMnkVDYTXw9qu0DC6Xi/MqTUsyM0Zxqv4shSA/PgybZRyfyAL
         dspbVJmE4XUjX2PFADtgJULxwbZj/uwAy5RYCso78AjEBHjmUlgzyI6vtkCZ7/UsSAk7
         eRHYPd1n4HhXdVA0cFrnm4QrK4B2NRpIRcZNgxe3om93IC3DbDSEQyQ33BliqmXxsreb
         V3LgfxHy2TKYYzTgrmPokc5C9HjLtK2dhDGhkY0FmcKl3xF1uSmComT1F/sb/g8nY/1t
         xsOQoR+JWYVve2zIFZoDFJDqT15VcAktNMlrlS2CmaWCRmx29TaTYLGQWzbTISeGPV4C
         5OhQ==
X-Gm-Message-State: AOAM530wokFLKZkYq/AiawdeOHTAfzugbLO2ILBXGi/wy2ttHXGYIBX9
        fGTliJHJotCpHh7ih21kUSdFftvQjQ==
X-Google-Smtp-Source: ABdhPJxKK4fATZtny24CZPPg4Vw0oKX9Rpv6avltgTIyqzxCcII9w+9KmnT1CZ4tBPj5owmyhB/E3w==
X-Received: by 2002:aca:ab0d:: with SMTP id u13mr3417806oie.178.1603723752073;
        Mon, 26 Oct 2020 07:49:12 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o8sm4051605oog.47.2020.10.26.07.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:49:11 -0700 (PDT)
Received: (nullmailer pid 138088 invoked by uid 1000);
        Mon, 26 Oct 2020 14:49:10 -0000
Date:   Mon, 26 Oct 2020 09:49:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, robh+dt@kernel.org,
        amitk@kernel.org, linux-pm@vger.kernel.org, rui.zhang@intel.com
Subject: Re: [PATCH 1/3] dt-bindings: thermal: mediatek: make resets property
 optional
Message-ID: <20201026144910.GA138041@bogus>
References: <20201021164231.3029956-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021164231.3029956-1-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 21 Oct 2020 18:42:29 +0200, Fabien Parent wrote:
> MT8516 Thermal IP does not support reset. Make the resets property
> optional in order to be able to support MT8516 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
