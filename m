Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A50329A718
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 09:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509562AbgJ0Iz5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 04:55:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37755 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509566AbgJ0Izy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 04:55:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id o18so595020edq.4;
        Tue, 27 Oct 2020 01:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8h35Fp3KGPJbdlP2u/VcAhTjbKZxy2MlAj+dFH66N4U=;
        b=TSpZ0Z00gtkghy1O2yiP6rZ3ZObnGsb7OEnnR9YyqECzjPZb7Ggz30Ja3LelLRbFcB
         lYlR/qxu6A63jRdUKSVTiVhJub0238e8ruvkR+xbI0EbfIfOjt4dVjRyaDsLwyOZEjkN
         +tMFFS3v9qrNdH35eB9HSvd1Y0OFqdOMw+5eYWtJ263wTMhfm8SOr34CdZCfYHxniIlf
         I8bWU+9fxaqiEWGAMJ1c37/E1Yuf75zF3zReJvq0KWnQa9ToREypfFCnunLc+YOaWra+
         Zor78c7MJ8IuFrm4L5tZYm/JCuzTW1SpEY+H3LBYeNKf1gYBPI2B0L75oYmnxE/CgE7m
         kDkg==
X-Gm-Message-State: AOAM532YVAvYHAyntYsjhh/sDijd8TgO15dZpMkdeRKkkjjOiMWBBxm3
        glQNkbM5UDK9uXyR6ka7rb0=
X-Google-Smtp-Source: ABdhPJyxkG4tQYebevVwUfr5tpTrVVR5vWiNFfd4BicVUd+tfnGH6GSr02QqZUC9VLRFzIbgcKMDXA==
X-Received: by 2002:aa7:c6d9:: with SMTP id b25mr1071873eds.27.1603788952482;
        Tue, 27 Oct 2020 01:55:52 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id d11sm506794eds.83.2020.10.27.01.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 01:55:51 -0700 (PDT)
Date:   Tue, 27 Oct 2020 09:55:48 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 05/52] dt-bindings: memory: tegra20: mc: Document new
 interconnect property
Message-ID: <20201027085548.GE4244@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-6-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 01:16:48AM +0300, Dmitry Osipenko wrote:
> Memory controller is interconnected with memory clients and with the
> External Memory Controller. Document new interconnect property which
> turns memory controller into interconnect provider.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra20-mc.txt          | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
> index e55328237df4..739b7c6f2e26 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
> @@ -16,6 +16,8 @@ Required properties:
>    IOMMU specifier needed to encode an address. GART supports only a single
>    address space that is shared by all devices, therefore no additional
>    information needed for the address encoding.
> +- #interconnect-cells : Should be 1. This cell represents memory client.
> +  The assignments may be found in header file <dt-bindings/memory/tegra20-mc.h>.

This is a list of required properties so you break the ABI. All existing
DTBs will be affected.

Best regards,
Krzysztof
