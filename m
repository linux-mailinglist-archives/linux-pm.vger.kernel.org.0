Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA9FEE9242
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 22:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfJ2VnB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 17:43:01 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36179 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbfJ2VnB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 17:43:01 -0400
Received: by mail-oi1-f195.google.com with SMTP id j7so194284oib.3;
        Tue, 29 Oct 2019 14:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UOz2jnU2NvuGE+cTHFffFFLe2zlC54aXD8we4ZSsAAs=;
        b=c2sA/rPfXLSsZDYwCfe2AhNDdPK0WFwJrwI9xFmgS2JINVTTFgyPLDk1Mm7T0jOS0k
         QEqjOIJ+yoaAP016uEwRwHG/8FIVdpAV8yRVY7bwFgtnQBrdKWkESxS2DC2IrK1EJxbc
         CAyGTYItlKdzrpzJ8shs38aEdrW2h6J9C0TYDdKkUub2IuunQaANmZ/BrrpXzLS7LHUU
         6iM/C/14pczjk/fy2PWYfr6DUOh1Zue48kNDGLOmfsTiUn4hairSZH09iStM4NvCfR+4
         r8i7uapkS1tynWqigZ8yd70nJyMdxwNW8DbwEd8Ss0agj5EOuAkzhaVKEy8NpDXjCrtQ
         b4fg==
X-Gm-Message-State: APjAAAVubExfWVeJP6TgAUPzDeZRltfoCftMtxnm8Z86DDVaJm83oES5
        0P5mtv8scCTIcARSnMb14Q==
X-Google-Smtp-Source: APXvYqwsMsBNTiZmW+ZkqE+oq5oUJPEMfBdYaW4zQbwv7qbMVuBJGTKLiIKce1gwB0sh9qEJnwUcvw==
X-Received: by 2002:aca:bf54:: with SMTP id p81mr3946023oif.81.1572385380085;
        Tue, 29 Oct 2019 14:43:00 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h79sm14247oib.3.2019.10.29.14.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:42:58 -0700 (PDT)
Date:   Tue, 29 Oct 2019 16:42:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/17] dt-bindings: cpufreq: Add binding for NVIDIA
 Tegra20/30
Message-ID: <20191029214258.GA18586@bogus>
References: <20191024221416.14197-1-digetx@gmail.com>
 <20191024221416.14197-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024221416.14197-7-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 25 Oct 2019 01:14:05 +0300, Dmitry Osipenko wrote:
> Add device-tree binding that describes CPU frequency-scaling hardware
> found on NVIDIA Tegra20/30 SoCs.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../cpufreq/nvidia,tegra20-cpufreq.txt        | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
