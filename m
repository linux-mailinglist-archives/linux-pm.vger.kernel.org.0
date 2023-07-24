Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8CC75FB70
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jul 2023 18:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjGXQGY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jul 2023 12:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGXQGX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2023 12:06:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C558E;
        Mon, 24 Jul 2023 09:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CEAA6123C;
        Mon, 24 Jul 2023 16:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B71C433C7;
        Mon, 24 Jul 2023 16:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690214781;
        bh=wzILIiktygSkczKQwKNbT4xkne6f5Z3SbGziCkcoM/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ShgOSX/YcapLsLBr4mgiNNeTxkDsZrey4+inAmYcBZY1Ugf7LaGLNUMNQK6Osc2IE
         ayg++5bmISQm5M/fBfUWQJNKaT2WbpvTPxqvmy1iPbAdXzPAS3VPvvnZiRzJmZTuzC
         WOzPcVcAWeqL49oUem4aPSij+F6HYuYo1EurjouatuePD8QkVp+62YAmJYO3MaXzUa
         XhkjK0AqSpVSHopWja+iyCmUuVIDPZDTl5tGrE2Ya4v9bmOwMcuIc4wUF4zuRpatJk
         xDFlbsxi54Mwq4vWYZruPNS+NKzYVoqbOEwaZAyCeEwOBG4pDb+e5vxRKuI+v6UAUm
         Q8GTMAzk5DsWg==
Received: (nullmailer pid 3630338 invoked by uid 1000);
        Mon, 24 Jul 2023 16:06:19 -0000
Date:   Mon, 24 Jul 2023 10:06:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: thermal: tegra: Convert to json-schema
Message-ID: <169021477856.3630278.10231413984365263357.robh@kernel.org>
References: <20230721130306.2990112-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721130306.2990112-1-thierry.reding@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Fri, 21 Jul 2023 15:03:06 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the Tegra thermal bindings from the free-form text format to
> json-schema.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - add minimum and maximum values for cpu-throt-percent property
> - add missing unevaluatedProperties for throttle event nodes
> - drop unneeded minItems where it equals maxItems
> - add missing items for uint32-matrix
> - document OC1 throttle event
> 
>  .../thermal/nvidia,tegra124-soctherm.txt      | 238 -----------
>  .../thermal/nvidia,tegra124-soctherm.yaml     | 380 ++++++++++++++++++
>  2 files changed, 380 insertions(+), 238 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

