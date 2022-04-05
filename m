Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EF84F48A4
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 02:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381988AbiDEVpA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Apr 2022 17:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573266AbiDESjU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2022 14:39:20 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD85167E3;
        Tue,  5 Apr 2022 11:37:21 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso130087otj.5;
        Tue, 05 Apr 2022 11:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+KbWd7V0K71eJ7YcPU2pSOmsRiOHZCWb39tTThHrGDU=;
        b=Ek7jB5nSnvX8nkKurboNskrrBPBblu+4jqRUXkbMh3ca8FuApH6Rb6FgVhfqE9grkW
         NjJ5Md7xQ7RlZDLu9Gze+AeK09cSBJ664PdQCRLHC6gF+t9qW9aOLSX78FegGO3k7jVk
         rFUZQ7MqGeybfSVIZNDENxpzlYmk5eIBf9Dr1b8ZAP7tLQJWyyxhgJQ5qj5aQFl6oPXr
         xDA1zcBqdJd/2Me1mtUAtEAO87UryhKJkjIbIjtLhHLbDmJdeL4BbAp6qVf5StQ/XioJ
         NLPoNwaRwM0O2LZWv+WuuTdFIK9+HwlEYAIiosdi0Ei0P23jrhVrqHwM7+UINS9faAdR
         mRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+KbWd7V0K71eJ7YcPU2pSOmsRiOHZCWb39tTThHrGDU=;
        b=a6Wkpytl/4MFrIgOiZcv0hafFPp1IBmePlR4zrnGbeEXCRw6fvO6d/I3PLTy6VOKYL
         I0NQNg/4aR15lozQ71D9oGRqNgu8J00Ib6u2ybKNmvFVJJ+M716rS1iLxNGSw5iErPIL
         ndfEKIbNM9c8+8aFjMyv5QngOCjP9oSI7ujotbP+Jec1OZ3YQqPdEF7SxGV5IW7IPJVW
         kON/TxJ3hIqF8BbUF2itx98OuA3i3SzUA/vuNqEGGB7auzVRf/LgqjccJaVKyVENj5n5
         se0Thd2+d2jW09ym+0py4nz1kgCZS5TbqtZDCb7IkFDIW7IGs4d+ge0ZrJpjjuhAbpjV
         XLWw==
X-Gm-Message-State: AOAM531foGtwQz983yZ/PC14QDxzq48wVaVr/Sf8lnJalKwGj585GuH1
        /N1LY1/zJg0+AjBcud7nWsk=
X-Google-Smtp-Source: ABdhPJwzgIOB0kzAyeyofI6976mKnX78Ud7ePRgE6hN60K0Iq7zqsIgAXR9NtfXTu0KgHLJfGGpn4g==
X-Received: by 2002:a9d:6047:0:b0:5b2:4003:cfcb with SMTP id v7-20020a9d6047000000b005b24003cfcbmr1723411otj.59.1649183840894;
        Tue, 05 Apr 2022 11:37:20 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id n35-20020a05687055a300b000e1e2ab91e4sm3780056oao.39.2022.04.05.11.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 11:37:20 -0700 (PDT)
Date:   Tue, 5 Apr 2022 13:37:18 -0500
From:   Chris Morgan <macroalpha82@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, zhangqing@rock-chips.com,
        zyw@rock-chips.com, jon.lin@rock-chips.com,
        maccraft123mc@gmail.com, sre@kernel.org, heiko@sntech.de,
        krzk+dt@kernel.org, lee.jones@linaro.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 1/4 v5] dt-bindings: Add Rockchip rk817 battery charger
 support
Message-ID: <20220405183718.GA5929@wintermute.localdomain>
References: <20220404215754.30126-1-macroalpha82@gmail.com>
 <20220404215754.30126-2-macroalpha82@gmail.com>
 <YkyJPKuG1s5pLR+t@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkyJPKuG1s5pLR+t@robh.at.kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 05, 2022 at 01:23:56PM -0500, Rob Herring wrote:
> On Mon, Apr 04, 2022 at 04:57:51PM -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Create dt-binding documentation to document rk817 battery and charger
> > usage. New device-tree properties have been added.
> > 
> > - rockchip,resistor-sense-micro-ohms: The value in microohms of the
> >                                       sample resistor.
> > - rockchip,sleep-enter-current-microamp: The value in microamps of the
> >                                          sleep enter current.
> > - rockchip,sleep-filter-current: The value in microamps of the sleep
> >                                  filter current.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> > ---
> >  .../bindings/mfd/rockchip,rk817.yaml          | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> 
> Doesn't apply for me. What tree is this based on?

Sorry, it relies on the following being applied (all the prerequisites
are now in master, but this one is still absent):

https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220303203958.4904-5-macroalpha82@gmail.com/

> 
> Rob
