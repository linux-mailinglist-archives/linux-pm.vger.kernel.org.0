Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB01E434E35
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 16:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhJTOtN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Oct 2021 10:49:13 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40619 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhJTOtM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Oct 2021 10:49:12 -0400
Received: by mail-ot1-f54.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so8512088otr.7;
        Wed, 20 Oct 2021 07:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pasGqTuRZhubCpUnUf/TWc8G25S9HUibTcAJimgPxXA=;
        b=dWHPhRapHMqjmn+L74FC/UA83ALdjbauDpVvCtHyhaG0rL5eOcWtkrz5Qwb6quGsnK
         BO6DVomHH/+norClmAV7/Y1cKx+bCT+yAYcphSqaguxyFt0788E3orIeuWtUcqaQ+oMA
         +dwJwhufJ/bod00hvZl+5gsoxWkfuJea2W9zkAvmboaIV2Zlpb7ArPlbCgJCj+MDINqj
         FV3RrCapP2ySsfIUXlK41zaJrBR3oZoGbkQeiJaGv1sPsNeiPvZhiGdOsBo8S7l8y6xr
         XEdcJNgLte898WczIoCS7s9ReJAJ9if/QbeGgiYgVZz304uDihPJnaoMQA91tZwkVBDN
         Cp4A==
X-Gm-Message-State: AOAM531EhvHpcz2/KN9IVGPq1FnuUmrjvxxhbsLtYZzIPhIfRVi03KbO
        f/HHWTIERFWUuidkLEvM7Q==
X-Google-Smtp-Source: ABdhPJzp6IUxvWJLdKtEe/ko4g5HhBARBdoKSrrQRhy4qCIw26mSvLZ75JSXyO0uu9OGEOozEEzsEg==
X-Received: by 2002:a9d:6c4b:: with SMTP id g11mr281341otq.122.1634741217678;
        Wed, 20 Oct 2021 07:46:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q2sm434228ooe.12.2021.10.20.07.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 07:46:57 -0700 (PDT)
Received: (nullmailer pid 2336346 invoked by uid 1000);
        Wed, 20 Oct 2021 14:46:56 -0000
Date:   Wed, 20 Oct 2021 09:46:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nishanth Menon <nm@ti.com>, David Heidelberg <david@ixit.cz>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: opp: Allow multi-worded node names
Message-ID: <YXAr4OlhucAibMlH@robh.at.kernel.org>
References: <20211019231905.2974-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019231905.2974-1-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 20, 2021 at 02:19:05AM +0300, Dmitry Osipenko wrote:
> Not all OPP table names and OPP entries consist of a single word. In
> particular NVIDIA Tegra OPP tables use multi-word names. Allow OPP node
> and OPP entry name to have multi-worded names to silence DT checker
> warnings about the multi-word names separated by hyphen.
> 
> Reviewed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> index ae3ae4d39843..298cf24af270 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> @@ -22,7 +22,7 @@ select: false
>  
>  properties:
>    $nodename:
> -    pattern: '^opp-table(-[a-z0-9]+)?$'
> +    pattern: '^opp-table(-[a-z0-9]+)*$'

I don't see how this helps you. What I see needed upstream is a prefix:

'-?opp-table(-[0-9]+)?$'

Though really what I'd like to see is the OPP nodes moved into the 
device nodes they belong to when appropriate (i.e. when not shared 
between multiple devices).

>  
>    opp-shared:
>      description:
> @@ -33,7 +33,7 @@ properties:
>      type: boolean
>  
>  patternProperties:
> -  '^opp-?[0-9]+$':
> +  '^opp(-[0-9]+)*$':
>      type: object
>      description:
>        One or more OPP nodes describing voltage-current-frequency combinations.
> -- 
> 2.32.0
> 
> 
