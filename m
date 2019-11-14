Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59343FBD35
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 01:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfKNAyT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 19:54:19 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42590 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfKNAyT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 19:54:19 -0500
Received: by mail-oi1-f194.google.com with SMTP id i185so3666489oif.9;
        Wed, 13 Nov 2019 16:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3FaGwli40UTgV2GVAUXDQz2iTNRIRzfQdNF3AkhAOiE=;
        b=XlBfsSzBaeMc4He1kBm6trtgRzGhcn3oFpH5NUftHx+66ZTQ7NW4aejMXn6tvtyqD8
         Ejgkc1Ji68j9TtKGjJV70nm9Yoh121mN1GQ6az9ZpmygbBCfeJeSnVF+Eaj4p4BFKsGJ
         gkjZH4zrmduNiIq9arjxJeohUU0Vi6yALKOret4siZpQ0iyxdiWEKZ+nYISXJbQBM/wA
         kHZ8leBuf4aqt7pmTSs99AdkbGLSyGWhcRTL4d3Sa1puTmMhNLs8sgQKl2KhhWgEBDfa
         xBYDElgF6GDH5YBFrhUV7STTryW4dTocgxqEQs+SOHR0+YA/tGbCxL2FxkNucUTumzCQ
         0dlQ==
X-Gm-Message-State: APjAAAUow3u0fmaRJnFbrQZF/kc4ctdE22EiHNAOcY9S9qc3NYf7HwGW
        zH2HDW13pXF1UV/7Uc4XWgAZY0Y=
X-Google-Smtp-Source: APXvYqxDU5n/Ao3dAUsAWGuXFl28eOb/j1llN+R19aMZU436dy6PUeHoNc2xSgdUvqJfbG70quT2MQ==
X-Received: by 2002:aca:b602:: with SMTP id g2mr1179523oif.7.1573692856864;
        Wed, 13 Nov 2019 16:54:16 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g1sm1323717otb.68.2019.11.13.16.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 16:54:16 -0800 (PST)
Date:   Wed, 13 Nov 2019 18:54:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: Re: [PATCH v6 3/5] devicetree: mfd: max14577: Add reference to
 max14040_battery.txt descriptions
Message-ID: <20191114005415.GA24858@bogus>
References: <20191105095905.GA31721@pi3>
 <20191107031710.5672-1-matheus@castello.eng.br>
 <20191107031710.5672-4-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107031710.5672-4-matheus@castello.eng.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu,  7 Nov 2019 00:17:08 -0300, Matheus Castello wrote:
> max77836 MFD has a fuel gauge that has a low SOC alert feature that is
> described in Documentation/devicetree/bindings/power/supply/max17040_battery.txt.
> Adding the reference to de documentation here.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  Documentation/devicetree/bindings/mfd/max14577.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
