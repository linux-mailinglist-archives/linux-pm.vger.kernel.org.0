Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EB23E3129
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 23:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243523AbhHFVex (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 17:34:53 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:44746 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241353AbhHFVew (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Aug 2021 17:34:52 -0400
Received: by mail-io1-f48.google.com with SMTP id d22so14163705ioy.11;
        Fri, 06 Aug 2021 14:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NG1EvzhxK2IFtwPmuLqscAo9Y1Y9BvzPpEQPGw44YJQ=;
        b=lEzoCxXIdijdPDdZQsbwNtpvG3xfyEA2Oh0V8XLkE7AsEQWFAoo2zWoaC+++fr9LqS
         Rsfddd9A1m2lwDWK6+zzG0vzLgdvbNgHfejPqZcvN17gQQch4y90xIt5rZDmDvuIlwBx
         YFisFjcNhQoeq2otoG4XWOUfP9N7cKHn038s5DBCBx/LcNQ2XCEjx283Q8oPLTTSZy4/
         C4xLOFUbDZ4UMoDN2wQYlbBc7lknXcwpkvYE455sSNVNObguk6lv6y3fIC/DAMwtksJ1
         qmTqkix29sBslP7ZtML1UpaBmhlvwAMQQqSC1mxyrOHxWtiofv9ZdX/uSh39nsQdO0Jz
         FsBg==
X-Gm-Message-State: AOAM533RQWv25yhVj27JFxzJXz6yBW1Ug0i9KVyq/4ULxOWG4VG5fCj8
        I1pYrcQSn+oOe+p1rDM/sA==
X-Google-Smtp-Source: ABdhPJwgqBBlqTHJ9XEXcwpVSKBXLOyWARewwd1sBoKNpClwAREQfGffWnndQXu2y+LOTEe0arPV+w==
X-Received: by 2002:a92:bf12:: with SMTP id z18mr452390ilh.274.1628285675403;
        Fri, 06 Aug 2021 14:34:35 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z18sm5044005ilp.68.2021.08.06.14.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:34:34 -0700 (PDT)
Received: (nullmailer pid 1841077 invoked by uid 1000);
        Fri, 06 Aug 2021 21:34:33 -0000
Date:   Fri, 6 Aug 2021 15:34:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 3/6] dt-bindings: interconnect: Move SDM660 to a new
 RPM-QoS file
Message-ID: <YQ2q6VmE+C9HLiYs@robh.at.kernel.org>
References: <20210801152427.475547-1-y.oudjana@protonmail.com>
 <20210801152427.475547-4-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801152427.475547-4-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 01 Aug 2021 15:25:20 +0000, Yassine Oudjana wrote:
> Move SDM660 to a new shared file to allow for adding other similar SoCs.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../interconnect/{qcom,sdm660.yaml => qcom,rpm-qos.yaml} | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>  rename Documentation/devicetree/bindings/interconnect/{qcom,sdm660.yaml => qcom,rpm-qos.yaml} (91%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
