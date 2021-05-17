Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC80E386C53
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 23:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239666AbhEQVfq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 17:35:46 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:33352 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbhEQVfp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 17:35:45 -0400
Received: by mail-ot1-f53.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so6890445oto.0;
        Mon, 17 May 2021 14:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UQEU3oksI06Oxq3YmQYcH0MD6VzSoP8Bc+mwEWnCwZA=;
        b=orc7bDOhiOCmqksEZ58axvHTedbqAUa5zDHAFttl3zw8k595Bsy/K71emzQYBEx5Gc
         tyG7ESavB0OxyYzh+NA6nyEEefpQIRF3HcnDsLE/cx/ohWRXUYA1li9G3lHCmD/+Aavf
         VwG+TBSuso+ZVkjvBZtCYP6mQvhfP6oma0JQxd7dNJ1lbg0uKfUgn4cnD+w1LVri1A/I
         vE205YNGEPZx4ogi290vNqAMfcSyBk1B+uV6cnuM0ToORgrP7SE8Q2PihwblOjYPVjct
         V7mQ2wdEvSWMg1n0vOCitUSUkTYEx24ShRjYT3ImD3aYkU4nBkH2RA+70/QNTz4uqdbV
         zvyA==
X-Gm-Message-State: AOAM531WzhDXNQxyw1gqJ1KtrN0vDgneUA9KuJU4RRCYPv5olmj0KMlP
        J+tmG4YTfsoydHET+YYxOpM6p2voZA==
X-Google-Smtp-Source: ABdhPJyCcqjVqwPcDIpGYU0DPwQ92ieohIf3eUPzzyO1HTU98nMPz1vwy8vD73yAznvEYWMAxqewCg==
X-Received: by 2002:a9d:7f83:: with SMTP id t3mr1398443otp.32.1621287268548;
        Mon, 17 May 2021 14:34:28 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u14sm3009619oif.41.2021.05.17.14.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 14:34:28 -0700 (PDT)
Received: (nullmailer pid 3240019 invoked by uid 1000);
        Mon, 17 May 2021 21:34:27 -0000
Date:   Mon, 17 May 2021 16:34:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v1 4/7] dt-bindings: devfreq: tegra30-actmon: Add
 cooling-cells
Message-ID: <20210517213427.GA3239990@robh.at.kernel.org>
References: <20210510211008.30300-1-digetx@gmail.com>
 <20210510211008.30300-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510211008.30300-5-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 11 May 2021 00:10:05 +0300, Dmitry Osipenko wrote:
> The ACTMON watches activity of memory clients. Decisions about a minimum
> required frequency are made based on the info from ACTMON. We can use
> ACTMON as a thermal cooling device by limiting the required frequency.
> Document new cooling-cells property of NVIDIA Tegra ACTMON hardware unit.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml   | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
