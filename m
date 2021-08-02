Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B563DE03D
	for <lists+linux-pm@lfdr.de>; Mon,  2 Aug 2021 21:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhHBToI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Aug 2021 15:44:08 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:46027 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhHBToH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Aug 2021 15:44:07 -0400
Received: by mail-io1-f44.google.com with SMTP id a1so6968540ioa.12;
        Mon, 02 Aug 2021 12:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UIx0ZqKKCt1QeNsKj9VP+KBngtWiqMVZrBHp0giLU/Y=;
        b=Aso35+qOccU8QBN5PayO0ZiACLzX7pBvJKGdkyKhInRy2xXVFcCK0rUTJlNyzTNxIp
         GLrvgeWeL7pgjXpadNryzDRQs23Bym5G1hgxNJaAIv/JUdGpApM5Sr0BUZaOGxeMuhAC
         iscVAnUTBKdgaQ82qOqrKfffggNWlre4DzZvQI0ABjkdBJNbyDW7T04GE1vA1EjORUD7
         7uB2Y0+pxh7v9SUBDxwLZZjR1orDSLNT7cpRHDjOBQI+Pg3tvRjapkWMA7o3lIhZ24HO
         K82LAfR5z9dUAVcHTvw/GXPYFzfKw8KwWv/UL9C8uofJuENHfMEm4OQaFmbFnX2YqgTb
         b3hg==
X-Gm-Message-State: AOAM5313h6GhhS5pBilxOp5PcELNRZKrjB6wvXzQHdgZIDpm1S79SDt2
        yyr6ls2bpzgpxGzdTsTwYw==
X-Google-Smtp-Source: ABdhPJzC0CfojHvi25wZzGSPc1WMkNQyDFsJXAM4BGMqB6UE6irlNbA21tzE8L58mJWNMcFvWI5fJA==
X-Received: by 2002:a02:a115:: with SMTP id f21mr15968055jag.3.1627933436977;
        Mon, 02 Aug 2021 12:43:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v14sm7673103ioh.11.2021.08.02.12.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 12:43:56 -0700 (PDT)
Received: (nullmailer pid 1481103 invoked by uid 1000);
        Mon, 02 Aug 2021 19:43:55 -0000
Date:   Mon, 2 Aug 2021 13:43:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: convert tps65086.txt to YAML
Message-ID: <YQhK+5i6YZpRIz+o@robh.at.kernel.org>
References: <20210727092554.1059305-1-kernel@esmil.dk>
 <20210727092554.1059305-2-kernel@esmil.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727092554.1059305-2-kernel@esmil.dk>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 27 Jul 2021 11:25:51 +0200, Emil Renner Berthing wrote:
> This converts the tps65086.txt binding description to YAML schema so
> dts files can be verified automatically.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
>  .../devicetree/bindings/mfd/ti,tps65086.yaml  | 127 ++++++++++++++++++
>  .../devicetree/bindings/mfd/tps65086.txt      |  54 --------
>  2 files changed, 127 insertions(+), 54 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/tps65086.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
