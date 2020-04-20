Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C554B1B15B2
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 21:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgDTTP0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 15:15:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34944 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgDTTPZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 15:15:25 -0400
Received: by mail-ot1-f65.google.com with SMTP id e20so9169742otl.2;
        Mon, 20 Apr 2020 12:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/E8gPmAs5q5j5c6IF7Y5E5C7JdeQS0MYhxEcRGnaPxs=;
        b=q72gFrhHlIVrA5mY0Sy2UWVrJoZt9je4tDLA8GnkG6PNoXOoOy0CWgbypp08yB9ETR
         jTbRjjBjk4VobUNc68ZlJ4t40d8bBSDJB/tCjBvLnWY50JJxjDUlzvAtXUtlDOnUnjuF
         GxAZW1XgTBgdtlY/y0Qn+AyQqJDjga1d5loMa3ZJkLVs2VbsO62oIHPCXN2Sh/AgP9QL
         sq7ZHckVMEsOSFkpCKJppaJoYpe324NBCOs1zQqwV+f15r/yTzcLSDa8Sf6k//LL2L+n
         kT/yaZVx5jBIaB0g7Etf7zYBWsBaZ7YlneflRpVwwxbwvw+K9qL6Gx/1+8/nxYG9jgEm
         IqxA==
X-Gm-Message-State: AGi0Puas7HAA1L4zKfb8fXXswkM3GFgMoxeyvzEeUBNJjiQ3ySD0CcOc
        xi2ah5SvAA8weeZVKTbtjQ==
X-Google-Smtp-Source: APiQypK4KWrrROkD5Z7eemFuC8Y5bdOwXzixxByT6sDywR+zGy0AuTzZVDCA0mXYc0mjjBP9d9R3jA==
X-Received: by 2002:a9d:6a98:: with SMTP id l24mr10442730otq.133.1587410124253;
        Mon, 20 Apr 2020 12:15:24 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s13sm71633oic.27.2020.04.20.12.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:15:23 -0700 (PDT)
Received: (nullmailer pid 3203 invoked by uid 1000);
        Mon, 20 Apr 2020 19:15:22 -0000
Date:   Mon, 20 Apr 2020 14:15:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     robh+dt@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Qiang Yu <yuq825@gmail.com>
Subject: Re: [PATCH v5] dt-bindings: gpu: mali-utgard: Add the #cooling-cells
 property
Message-ID: <20200420191522.GA3122@bogus>
References: <20200411165700.1576314-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200411165700.1576314-1-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 11 Apr 2020 18:57:00 +0200, Martin Blumenstingl wrote:
> The GPU can be one of the big heat sources on a SoC. Allow the
> "#cooling-cells" property to be specified for ARM Mali Utgard GPUs so
> the GPU clock speeds (and voltages) can be reduced to prevent a SoC from
> overheating.
> 
> Reviewed-by: Qiang Yu <yuq825@gmail.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> Changes since v4 at [0]:
> - Added Qiang's Reviewed-by (many thanks)
> - re-send because I missed the devicetree mailing list in v4
> 
> 
> [0] https://patchwork.kernel.org/patch/11448013/
> 
> 
>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Applied, thanks.

Rob
