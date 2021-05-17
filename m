Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEDB386C4F
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 23:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbhEQVf1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 17:35:27 -0400
Received: from mail-oo1-f52.google.com ([209.85.161.52]:42717 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbhEQVf1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 17:35:27 -0400
Received: by mail-oo1-f52.google.com with SMTP id v13-20020a4ac00d0000b029020b43b918eeso1779730oop.9;
        Mon, 17 May 2021 14:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TKp+muVvsBkqS/qhnBayv/73fVMC26k+zPLDWmz7RV8=;
        b=EBlgOn7fBeJDJxn7X5rx5rUG+lZ7TBN04TtY9Mjaa8ctWLvrQzhR+AnfOjzkVvNr4d
         KfnNuKGYRp+rPAy+wab9yoTY/xC5KrBWwJsjZYEWXVCFinha1HuxgGeixX0hjroMFpXP
         Nzeslp7xW2FdvOvUKf3NRRE+swi2kXFa+Kxg/79b+x4B+iHrImXEMm/HK9RIlDUTa1JA
         0Br53TxlQkEIaxz50iamVjnQo4j6cjZDkuUoAj5sW+sheQTyVmvrUJkS1NiAGOWfa4bs
         tsvIe/g5oCeJbwF2y7DIsTbflYBv2VyUYB3Ra4C9zN+/nnFD8NLczM0B4GEvb9TXvc6O
         Qzdw==
X-Gm-Message-State: AOAM532rD/ujmABaUCKEgmR4eackPDAy0FPC1WIoCSS8BoqNu8lniCBQ
        yj+RiC91yT4/YLUQJNmNHw==
X-Google-Smtp-Source: ABdhPJxA8YJ7lKQY1vATWDpJUgI+ViSERFasviwQiA8BYwLUzdekBWVYpVLjIuwD6PwR3V0/Zot7kQ==
X-Received: by 2002:a4a:a58f:: with SMTP id d15mr1514128oom.32.1621287250015;
        Mon, 17 May 2021 14:34:10 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x141sm2986306oif.13.2021.05.17.14.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 14:34:09 -0700 (PDT)
Received: (nullmailer pid 3239403 invoked by uid 1000);
        Mon, 17 May 2021 21:34:08 -0000
Date:   Mon, 17 May 2021 16:34:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 3/7] dt-bindings: devfreq: tegra30-actmon: Convert to
 schema
Message-ID: <20210517213408.GA3239373@robh.at.kernel.org>
References: <20210510211008.30300-1-digetx@gmail.com>
 <20210510211008.30300-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510211008.30300-4-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 11 May 2021 00:10:04 +0300, Dmitry Osipenko wrote:
> Convert NVIDIA Tegra ACTMON binding to schema.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../arm/tegra/nvidia,tegra30-actmon.txt       |  57 ---------
>  .../devfreq/nvidia,tegra30-actmon.yaml        | 121 ++++++++++++++++++
>  2 files changed, 121 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
>  create mode 100644 Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
