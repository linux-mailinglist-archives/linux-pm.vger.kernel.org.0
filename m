Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D8039806C
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 06:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhFBEjS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 00:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhFBEjR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 00:39:17 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E24CC061574;
        Tue,  1 Jun 2021 21:37:34 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 133so1238017pgf.2;
        Tue, 01 Jun 2021 21:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s61OiZYKOsW6cE8ZfHpspLBA2T60D0x91MluTCnVBZQ=;
        b=T15fJd1v4MPRbbyLv1Haelr/MaxNAhdly0rDRvzUldQYrCpUL3D3S5COwbsUPvyZT0
         bQ18k51URaWmzSYry9/7qjGfHs+wkDNbpyVKeEuKRzOlH5nhgEgCt6XkCIHAVW9yGlOk
         8xsiYLoKtI8Mr/U3ExDiBwogXBlsRw7hqR42/Os7bTk1+FLBjdfDopQcWmgzIX0pbWLo
         vuzdEY0kLZ65t8isloVGiiQ17Q7Zw/bjP5fCt5BJKh3ZB9nJ7Qidb9D8h4IxdwWiWEY0
         uu5U9ZhV+N6HyEHEAH+xy9XlQs2LP1unxFMsHhOS8/c+CBwJeduir2OGhppOmQOUgbps
         bJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s61OiZYKOsW6cE8ZfHpspLBA2T60D0x91MluTCnVBZQ=;
        b=uSBCKYR4vhf5kgpRXFI5+xPnQZSjvboCcz6WPbzR9cAKkFKwyJOWOMS0sHSeoxIke5
         iv9hGTCND/vORnDYTbjOW096qW+Lgtvts2Dq2zk29wO+P4vabVggNvNNUqFj/xtWC9UK
         xkUPr9i4smqdr1CFr7pa67Y/EhfxpYewKHShApsRsOUCj890sFcimRb60MxfVDNoN/AF
         U8BD1xwF/1VpfzAzfi9J5L4+wAvt0OEkFCgvCSScgRQXgct+2O9Q/E0jo9MDXOHZb+my
         zlqgH/bPHcmKTUx10iZJe+UVBiwg2JrfDv/W2uDBeFCJ7cD8m8rSRmnW1ao8HdOmsiwZ
         e4Mw==
X-Gm-Message-State: AOAM531h89nD5z0CCXs8Ddyekub+DpueRpH0dC2BvKlAZFfuM9rl09M3
        MTjIl5luZbUMJcgejWYt6x4=
X-Google-Smtp-Source: ABdhPJziwfj1W0ruMVUYRYigH/z/tGV6kelJMEGVgv5M4xsXm04WArSn1+WMMI6YpGXghv4Pu8B1cw==
X-Received: by 2002:a65:4042:: with SMTP id h2mr31570795pgp.380.1622608653977;
        Tue, 01 Jun 2021 21:37:33 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a596:b3cb:1a6:1ee4])
        by smtp.gmail.com with ESMTPSA id d15sm3365543pjr.47.2021.06.01.21.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 21:37:32 -0700 (PDT)
Date:   Tue, 1 Jun 2021 21:37:30 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     skakit@codeaurora.org
Cc:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        kgunda@codeaurora.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH V3 4/5] dt-bindings: input: pm8941-pwrkey: Convert pm8941
 power key binding to yaml
Message-ID: <YLcLCmxNOYqj0SN3@google.com>
References: <1620630064-16354-1-git-send-email-skakit@codeaurora.org>
 <1620630064-16354-5-git-send-email-skakit@codeaurora.org>
 <1620655299.793818.41438.nullmailer@robh.at.kernel.org>
 <20210510162445.GA230005@robh.at.kernel.org>
 <c4e286ae6bd621a9d84184d5d014d060@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4e286ae6bd621a9d84184d5d014d060@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 12, 2021 at 10:17:43AM +0530, skakit@codeaurora.org wrote:
> On 2021-05-10 21:54, Rob Herring wrote:
> > On Mon, May 10, 2021 at 09:01:39AM -0500, Rob Herring wrote:
> > > On Mon, 10 May 2021 12:31:03 +0530, satya priya wrote:
> > > > Convert qcom pm8941 power key binding from .txt to .yaml format.
> > > >
> > > > Signed-off-by: satya priya <skakit@codeaurora.org>
> > > > ---
> > > > Changes in V2:
> > > >  - Fixed bot errors, took reference from input.yaml for "linux,code"
> > > >  - Added one complete example for powerkey and resin, and referenced it
> > > >    in main PON binding.
> > > >  - Moved this patch to the end of the series.
> > > >
> > > > Changes in V3:
> > > >  - Moved this patch before PON binding patch.
> > > >  - As per Rob's comments, added allOf at the beginning of binding.
> > > >    Added maxItems for interrupts.
> > > >  - Added 'unevaluatedProperties' instead of 'additionalProperties' as
> > > >    we are using allOf.
> > > >
> > > >  .../bindings/input/qcom,pm8941-pwrkey.txt          | 55 --------------
> > > >  .../bindings/input/qcom,pm8941-pwrkey.yaml         | 87 ++++++++++++++++++++++
> > > >  2 files changed, 87 insertions(+), 55 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
> > > >  create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
> > > >
> > > 
> > > My bot found errors running 'make DT_CHECKER_FLAGS=-m
> > > dt_binding_check'
> > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > > 
> > > yamllint warnings/errors:
> > > 
> > > dtschema/dtc warnings/errors:
> > > Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.example.dt.yaml:0:0:
> > > /example-0/spmi@c440000/pmic@0/pon_hlos@1300: failed to match any
> > > schema with compatible: ['qcom,pm8998-pon']
> > 
> > You have the same example in patch 5, so drop the example here. That
> > will fix this circular dependency.
> 
> Earlier I have dropped example from qcom-pon.yaml. Now, I will add the
> example there and drop here.

It sounds to me you want to combine patches 4 and 5 since they depend on
each other.

Thanks.

-- 
Dmitry
