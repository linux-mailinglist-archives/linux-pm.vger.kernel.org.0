Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9933EF72F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Aug 2021 03:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbhHRBKM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 21:10:12 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:39592 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbhHRBKG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 21:10:06 -0400
Received: by mail-ot1-f44.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so766992otf.6;
        Tue, 17 Aug 2021 18:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zvw/vAQfPzTTp9MzAeT4kJRGycD2utM7CVLI0E2idN8=;
        b=tRMoTfLRHntcqNjCLlEPplE+8om3v1iUWQNBloXhZVJduvyyJnebbYW/2J6IjDi7gb
         9nhktBhoB4OEGbH/kT2nr+x63jxRJ0KckT+4rI3+pV6Ey9ZfIkG3YDWYG+VOIiZgTrse
         qS0b8iekWgrLRF5Jnsl46+oaqQwBBOEv/sdP8qAuc6yEUDnkkHEL4aqP9gbjPI2X2bXp
         RzQdC1sqskiVFAyksoBpF38JK8kl0jvJz8+J+/R/No8+47MQn7LDgkmn+CzCUlCNByhr
         YUAdgbuKndp0Yq6v42vWQoQjgwJE4VQ2xr+hVM34rq29qxhOP51ODnfUiILk4eqlX2ZR
         88CQ==
X-Gm-Message-State: AOAM5320mGXMlrJpbt/SG0z+Pv/nmwpujlaPr0wEc9qoEi1aq4pZe7Sv
        ey2IW6dyKFCIAHd1ElYF2Q==
X-Google-Smtp-Source: ABdhPJwpcWyEWeNaxhti5cvSd8sQTDRRhruQV2NQzNyEE7UKaJhgpllax41G0mhyoHm0/oAIcQ4uQQ==
X-Received: by 2002:a05:6830:b8b:: with SMTP id a11mr4885093otv.179.1629248972380;
        Tue, 17 Aug 2021 18:09:32 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o24sm870860oie.17.2021.08.17.18.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 18:09:31 -0700 (PDT)
Received: (nullmailer pid 1167246 invoked by uid 1000);
        Wed, 18 Aug 2021 01:09:30 -0000
Date:   Tue, 17 Aug 2021 20:09:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bruno Meneguele <bruno.meneguele@smartgreen.net>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, sre@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: power: supply: bq24735: document the
 watchdog timer delay feature
Message-ID: <YRxdym1lAWyivSkH@robh.at.kernel.org>
References: <20210816165245.40416-1-bruno.meneguele@smartgreen.net>
 <20210816165245.40416-3-bruno.meneguele@smartgreen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816165245.40416-3-bruno.meneguele@smartgreen.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 16 Aug 2021 13:52:45 -0300, Bruno Meneguele wrote:
> The new watchdog timer delay support in BQ24735 allow the user to set four
> different options, ranging from 0 to 3. With that, add this new property and
> its values and description to the BQ24735 DT binding documentation.
> 
> Signed-off-by: Bruno Meneguele <bruno.meneguele@smartgreen.net>
> ---
> Changelog:
>   v3 - create specific patch for dt bindings changes
>      - add minimum and maximum values
> 
>  .../devicetree/bindings/power/supply/bq24735.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
