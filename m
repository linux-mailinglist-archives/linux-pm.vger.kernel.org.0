Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBCD2D77A9
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 15:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405939AbgLKOSt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 09:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405940AbgLKOSf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 09:18:35 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136F8C061793;
        Fri, 11 Dec 2020 06:17:55 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id r5so9496054eda.12;
        Fri, 11 Dec 2020 06:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+NgxUEH5uFqT7GDJPbuM1Ogf8MzS8XSgNJtKE+wwyRM=;
        b=eH3w6NcIrC4xR4v4M3keq2M/BL0t2cwI16kEboijRZfq6Z/BTQ+ESL3w5hoKKkEOXT
         SLBYPbGknhUXI16fYN9cYVb8fLhLhfvs6R9mrEutwyx7Leat26hRcjZuKVPppQnZ+vK+
         sN87DmWq2PAz8rYhe2QDmSf8szPzK3boRvTQbTKcHfYziRcji01nlYxnPhd+asjkO9ps
         FSbyVfVTGUtBUm1ijk6YSRiCdEMDJ8O1yx5ATtbTYGAP95CY9uXt4+gh3Oyby42kzViW
         5h9VDu+eDbtUek/2d0uKETiIWxaMDwuy1GT9rLoHSM7/8Uwrm+S4S2lq7GI6M/klKKSc
         duHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+NgxUEH5uFqT7GDJPbuM1Ogf8MzS8XSgNJtKE+wwyRM=;
        b=YRxjb5mXaEvdxRfI/sBZQDRJ5NviS+gbGFmKMank8/GqAl2Y58+mz61mUWy7Sq3M7/
         MvCjQ7VeRxret0kBsH1GezX1mKJR8AnfxY7ewsaCoE2XfYGFE0ZWc814JltyFy0xFbUe
         3tyQbq+Zf65L2HBR8vMUjYecDUF94YAiwkIhMfNI6/IXuASFw5a+T25/ml9rEGinZ2Og
         2C8bPVPZk/25Ptggpix1TjQBGiH35ozgA+ZvC/lErKuSRXnPCqglS5mqAYiXmIwvGy5b
         TMms+dxIGSA/gaxhwaI2IStI6estS0xGvU4qd1K5AIoUQnQzkwO2MYKWN9QmQ3iGUcXc
         jfMQ==
X-Gm-Message-State: AOAM5304AKAeH9ZM2RzSKcNjuk1zrv3rjCeyHOjzel+Q7beow/brN/hy
        LMde0pvT4UOTR8PoyfLXSOI=
X-Google-Smtp-Source: ABdhPJyCV4eEUT00ElKYzI3O1FRpkgysz4KnZm/C8ZHCZfpvl64Ch2HD0rRzWxhHGWhbIETRq831mQ==
X-Received: by 2002:a05:6402:388:: with SMTP id o8mr11821809edv.359.1607696273795;
        Fri, 11 Dec 2020 06:17:53 -0800 (PST)
Received: from ubuntu2004 ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id o11sm6865675ejh.55.2020.12.11.06.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 06:17:53 -0800 (PST)
Date:   Fri, 11 Dec 2020 16:17:51 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-actions@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v3 2/7] dt-bindings: mfd: Add Actions Semi ATC260x PMIC
 binding
Message-ID: <20201211141751.GA360406@ubuntu2004>
References: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
 <fe0ab8ef20813a2623cd1e543b16bb21c5b63367.1607216141.git.cristian.ciocaltea@gmail.com>
 <20201211031743.GA3562977@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211031743.GA3562977@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 10, 2020 at 09:17:43PM -0600, Rob Herring wrote:
> On Sun, 06 Dec 2020 03:27:02 +0200, Cristian Ciocaltea wrote:
> > Add devicetree binding for Actions Semi ATC260x PMICs.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> > Changes in v3 (according to Rob's review):
> >  - Dropped the 'pwrc' and 'onkey' nodes
> >  - Used a common 'reset-time-sec' property
> > 
> >  .../bindings/mfd/actions,atc260x.yaml         | 181 ++++++++++++++++++
> >  1 file changed, 181 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for reviewing,
Cristi
