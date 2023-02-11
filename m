Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248A9693140
	for <lists+linux-pm@lfdr.de>; Sat, 11 Feb 2023 14:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBKNa6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Feb 2023 08:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBKNa5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Feb 2023 08:30:57 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0AE29E20
        for <linux-pm@vger.kernel.org>; Sat, 11 Feb 2023 05:30:55 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y1so7836499wru.2
        for <linux-pm@vger.kernel.org>; Sat, 11 Feb 2023 05:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rNl2Kd1xQruZWeNwQkjy47mqA/czch1BygI7D1oDIGk=;
        b=NypymiZ55VkZtxkoH5z/U4OGmKZ77cRJCJ2ARcdXUJKWbFxkFwylG8nqccGwz66Ldy
         QaybUIN3PItTTTc9NaWDcIT38O+s1HMOqNofIm9eIEKXHqDiTTeLD35LnwuEK27n1SFR
         votELwEjqB6upTfl2OLtl7biccV1V6PZfJENzQxPX0q2C1vqlLFu4DavAeY6MKcaiEeI
         9V/N+N9pNMD/l0R3PTH4DCffY9GQ19CjGxLtDi2zTr4Hg5CMW6mi7CCH569pEbIsBNk4
         c8lIqKZCmCSpDlDUikJPHBsupK+RqBiOnL7W7iI8jVqSO+TZqnXSW8nPifHAmn5HQjGl
         r/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNl2Kd1xQruZWeNwQkjy47mqA/czch1BygI7D1oDIGk=;
        b=7pRj3l/ARnTwMik+dmS0A7kwEqeRNJV9d5v7ePr6ddNuUd2u3yHtvq86uCcHSOB+xe
         avY/mIAilDeqBwuzhlb1VC2/9NUKsV1CfTwPRQOp+tU8PIFs4M5MESSq7/Bdm9NILQsE
         J5RRFrFD3lQzyh3y2OMZH6ztVnG6jYmYe4SGBwc0NgjtXlAxgeCs4PIb6GYDcpZNunbC
         1V7wdbLtQK2kwsgayeUfFjCq260LGl5XvZ3PBiRyKQnmvlH0kSClQRxqb455AJpgExBJ
         lXCIfWYAAjNjGVGSGkLZzcvSjOK44jwnzEsQS0X0HVyOMhLqBVCQ+TPNLGheWxxB4aMn
         qlVA==
X-Gm-Message-State: AO0yUKW6X1+epbeCKEgHKBD2Jp3B5cSV06co/GLtcWhBpM2zberP0i6A
        Ku7Z33HNemjuLGCvAFszadFF0Q==
X-Google-Smtp-Source: AK7set/EDcByCs1uVWSz5m9jpWdpI2meYZnoN7/eY1avQr4Ngzd1UY5TyU84+RvEAJp/o+j0yJSBAA==
X-Received: by 2002:a05:6000:1811:b0:2c5:4b17:166 with SMTP id m17-20020a056000181100b002c54b170166mr4066156wrh.48.1676122254511;
        Sat, 11 Feb 2023 05:30:54 -0800 (PST)
Received: from localhost (p54ac5802.dip0.t-ipconnect.de. [84.172.88.2])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b003dff870ce0esm12335853wmq.2.2023.02.11.05.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 05:30:53 -0800 (PST)
Date:   Sat, 11 Feb 2023 14:30:52 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH RFT 0/3] drivers/thermal/rcar_gen3_thermal: add Gen4 fuse
 support
Message-ID: <Y+eYjJIITr2rgz7e@sleipner.dyn.berto.se>
References: <20230211084728.27832-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230211084728.27832-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Wolfram,

Thanks for your work.

On 2023-02-11 09:47:24 +0100, Wolfram Sang wrote:
> R-Car Gen4 has the fuse registers at different locations and with
> different names, but with the same purpose. So, first refactor IP core
> differences into a 'info' struct, then add the fuse_read callback to it.
> 
> Patches are based on top of:
> 
> [PATCH v2 0/3] drivers/thermal/rcar_gen3_thermal: Fix device initialization
> [PATCH 0/2] thermal: Add support for R-Car V4H
> 
> They have been tested on R-Car H3 ES2.0 and M3-N against regressions.
> Actual testing of the new fuses on S4-8 still needs to be done because I
> don't have access to such HW.
> 
> @Shimoda-san: maybe the BSP team or Test team can test these patches?
> 
> Looking forward to other review comments, too, of course.

For the whole series,

Reviewed-by: Niklas S�derlund <niklas.soderlund+renesas@ragnatech.se>

I boot tested this on V4H, but on that board the fuses where not set so 
the driver fall-back to the default values. We had a similar situation 
when we enabled fuses for Gen3. IIRC the BSP team helped out testing 
that on a board that had the fuses set.

> 
> Happy hacking,
> 
>    Wolfram
> 
> 
> Wolfram Sang (3):
>   drivers/thermal/rcar_gen3_thermal: introduce 'info' structure
>   drivers/thermal/rcar_gen3_thermal: refactor reading fuses into
>     seprarate function
>   drivers/thermal/rcar_gen3_thermal: add reading fuses for Gen4
> 
>  drivers/thermal/rcar_gen3_thermal.c | 141 ++++++++++++++++++++--------
>  1 file changed, 102 insertions(+), 39 deletions(-)
> 
> -- 
> 2.30.2
> 

-- 
Kind Regards,
Niklas S�derlund
