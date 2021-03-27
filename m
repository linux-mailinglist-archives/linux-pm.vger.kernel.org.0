Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE5534B8AB
	for <lists+linux-pm@lfdr.de>; Sat, 27 Mar 2021 18:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhC0R66 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 27 Mar 2021 13:58:58 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:45911 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhC0R6e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 27 Mar 2021 13:58:34 -0400
Received: by mail-oi1-f169.google.com with SMTP id d12so9051463oiw.12;
        Sat, 27 Mar 2021 10:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X92yyW4gj/Ixj9WOOMpMQLD7ZBl0h5UrxBeJHhj7Hng=;
        b=sim6VpdR5PqRmh/HzDRJvRSNMzX46wtAk5/JEgTF3EtoujNAm84VFdHOOrIUyNsN4R
         oEkXmJ4VIOYyLtHQdtJlBDY8ZsYXUSio6XiRJ2GSsemdjs0AsGPJiU/OlnneYN8Ty0BV
         CtrdeBzJpMmG66C52yHmpgCSVAdrGJsogj0OzIqsuwQN4ZosFz74XeZpBKF3I5NZOD4F
         zaigctA5LEtvYCAAAvEhbp/Hsi2zwT8bWKLl7xYokL5Rm8HQ0O1xnZRrWjxP5TePNvk/
         ZMIPlMtdfH32kZr6l7iJyNTCoGPOfTDgvMsveSBizNx2azaLPAwNwXtVpK46yEx1ZJ0K
         E18Q==
X-Gm-Message-State: AOAM532+LXg56UibHKT+egJ0P4s5kJft5tZPFKGv+5k7p+s9nrQD2UMP
        SnH4tT83ndZJELnP47++kQ==
X-Google-Smtp-Source: ABdhPJxWsTy7jNrkEpQRK11hrj800jQczR6iF/j+pU4/oE6CruCZ74LdF0ABoat3X4QZHn7sFWK7iw==
X-Received: by 2002:a05:6808:68a:: with SMTP id k10mr11723680oig.120.1616867914087;
        Sat, 27 Mar 2021 10:58:34 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.107.88])
        by smtp.gmail.com with ESMTPSA id q67sm2474459oic.55.2021.03.27.10.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 10:58:33 -0700 (PDT)
Received: (nullmailer pid 321671 invoked by uid 1000);
        Sat, 27 Mar 2021 17:58:30 -0000
Date:   Sat, 27 Mar 2021 11:58:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Seiya Wang <seiya.wang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        srv_heupstream@mediatek.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-mediatek@lists.infradead.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: cpufreq: update cpu type and clock name
 for MT8173 SoC
Message-ID: <20210327175830.GA321641@robh.at.kernel.org>
References: <20210326031227.2357-1-seiya.wang@mediatek.com>
 <20210326031227.2357-2-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326031227.2357-2-seiya.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 26 Mar 2021 11:12:27 +0800, Seiya Wang wrote:
> Update the cpu type of cpu2 and cpu3 since MT8173 used Cortex-a72.
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
