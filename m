Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50FE43D4AC
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 23:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240001AbhJ0VXp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 17:23:45 -0400
Received: from mail-oo1-f44.google.com ([209.85.161.44]:35688 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbhJ0VVv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Oct 2021 17:21:51 -0400
Received: by mail-oo1-f44.google.com with SMTP id 64-20020a4a0d43000000b002b866fa13eeso1408719oob.2;
        Wed, 27 Oct 2021 14:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FyelOIZ97OsIbI5HBi7o/appj9ec6FKJkiVDLu2gRJA=;
        b=bej/YQ/F0MJBnlOM/+8mBUIHRTXxKvB9MeybgjsApPd/ytwWClSsB1EzeY9WfD5LnX
         FiGSbf3uUpBw2jv791COCcOvGMa7CzPMzvcoCaTym6uHmkTMscm9TEEqorTaqH/Rgeyc
         FByOhJnLOiEAPG+oY1oBfjjjZnnVLeH8BN2gG5XGLRgPSi4nDwpA79psDkVOemko/tD+
         DpcDiOLFqYyabvvDJuYm3g/a1U15gF32IJaSFZDTwLskqlP60tc6qf6d5BR/CZOqnXLD
         j88l9wQywF0vSaVthydAFyFLO8N+AEwVKMT9VfaKh1SzX5itf+w8JkKhbOu6EfqtlGt5
         tnUA==
X-Gm-Message-State: AOAM531TPCHufxW378SiBG/BxVGZEtk0OFLKb3QWAJ8vV5MXt+gCIOZo
        CpJfgYZN11Z0DBG/r99mTg==
X-Google-Smtp-Source: ABdhPJyz8qbGMscp1wt9cyF+o674ZtRUtlxyhur7dLM8bkeJYMZTonnu3UxlXbMxfyrsIoOI8LoNhg==
X-Received: by 2002:a4a:430c:: with SMTP id k12mr85400ooj.43.1635369565454;
        Wed, 27 Oct 2021 14:19:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n17sm401101oic.21.2021.10.27.14.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:19:24 -0700 (PDT)
Received: (nullmailer pid 2181423 invoked by uid 1000);
        Wed, 27 Oct 2021 21:19:23 -0000
Date:   Wed, 27 Oct 2021 16:19:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nishanth Menon <nm@ti.com>, David Heidelberg <david@ixit.cz>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: opp: Allow multi-worded OPP entry names
Message-ID: <YXnCW1KSg2RBIdDy@robh.at.kernel.org>
References: <20211024215718.28969-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211024215718.28969-1-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 25, 2021 at 12:57:18AM +0300, Dmitry Osipenko wrote:
> Not all OPP entries fit into a single word. In particular NVIDIA Tegra OPP
> tables use multi-word names where first part is freq and second voltage
> because different hardware versions use different voltages for the same
> freqs. Allow OPP entry to have multi-worded name separated by hyphen.
> This silences DT checker warnings about wrong naming scheme.
> 
> Reviewed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v3: - Viresh Kumar suggested that we shouldn't support postfix variant.
>       I dropped variant with postfix naming scheme and multi-wording
>       support of table names.
> 
> v2: - In addition to a multi-wording support, support of the postfix
>       *-opp-table naming scheme is added to the updated pattern.
> 
>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> index ae3ae4d39843..f79343960539 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> @@ -33,7 +33,7 @@ properties:
>      type: boolean
>  
>  patternProperties:
> -  '^opp-?[0-9]+$':
> +  '^opp(-[0-9]+)*$':

This drops support for cases like 'opp1' which there are a ton of. It 
should be '^opp(-?[0-9]+)*$' if we want to keep that support.

I'd love to be stricter, but trying to find a balance.

Rob
