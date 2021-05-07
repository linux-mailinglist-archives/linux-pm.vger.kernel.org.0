Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D819376BE4
	for <lists+linux-pm@lfdr.de>; Fri,  7 May 2021 23:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhEGVpf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 May 2021 17:45:35 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:38676 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhEGVpe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 May 2021 17:45:34 -0400
Received: by mail-ot1-f44.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so9153770oth.5;
        Fri, 07 May 2021 14:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hiITqmR3MkOf1yfwBYllv9mUhx0O2m9hc1IxfJCX5I0=;
        b=fRTFT313Tu1N4FZAfGR7Jp4WyvBmkBA7PeGwW0ZgvXNNA7i2tdxuQ7pKGKTeKjRYGa
         bo1tKW8bEzBrXtK6s8N6/dZ1zBAgaZV/QUSOuYlFwRTNHDzahLJf6Bpu0VGhbyhPCx9c
         HzuX+L8iJdKaClhMxfF7V1y7l+7WG3qE3spv+r8DfHfaxUi8DQXBKY2RWNi2LN1+NnxV
         qKrDLYIYeBiy7Y8wuY2RfsVjGd9xcjmIAYLhCIYZXDaHpnBRZuLjiNrsrfIC5g/dbvTx
         OrqsE4pNRXNHFhPNr1eqLMk3aqoW5M46zZvOLi3Zvw/cpt4qDdj5kPOPCp0mmJC/LHR+
         to3w==
X-Gm-Message-State: AOAM531YVJLe34bv/SJkdA5YW8mbeqNeJoKbxhOrrYmX3FPpdAT/5u5k
        /OPAirAAQL7AGXPlSNskeOe8MRBJpQ==
X-Google-Smtp-Source: ABdhPJwocDZDc+NSwRU7v73INFImOWfRP0IFFfEgqXzZHnfl39v6PHwY49UNRM65+yeqFYJV/U6gBA==
X-Received: by 2002:a05:6830:2117:: with SMTP id i23mr9655209otc.331.1620423873421;
        Fri, 07 May 2021 14:44:33 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i18sm1320233oot.48.2021.05.07.14.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 14:44:32 -0700 (PDT)
Received: (nullmailer pid 2944565 invoked by uid 1000);
        Fri, 07 May 2021 21:44:31 -0000
Date:   Fri, 7 May 2021 16:44:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        kernel@collabora.com, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: thermal: convert rockchip-thermal to
 json-schema
Message-ID: <20210507214431.GA2944513@robh.at.kernel.org>
References: <20210506175514.168365-1-ezequiel@collabora.com>
 <20210506175514.168365-3-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506175514.168365-3-ezequiel@collabora.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 06 May 2021 14:55:12 -0300, Ezequiel Garcia wrote:
> Convert Rockchip Thermal sensor dt-bindings to YAML.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  .../bindings/thermal/rockchip-thermal.txt     | 85 -----------------
>  .../bindings/thermal/rockchip-thermal.yaml    | 95 +++++++++++++++++++
>  2 files changed, 95 insertions(+), 85 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
