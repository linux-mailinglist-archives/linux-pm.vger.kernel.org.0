Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E19B691CAD
	for <lists+linux-pm@lfdr.de>; Fri, 10 Feb 2023 11:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjBJK1X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Feb 2023 05:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjBJK1V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Feb 2023 05:27:21 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6D171647
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2023 02:27:18 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id by3so3262950wrb.10
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2023 02:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bk8vRH3Oa8mZo/j6zI4vBbyvdhhskcmfpsjeQNqjux4=;
        b=MOjEyWqafo6+0ybX5Y6W+X2KBiHB9OaN5HFBcPKe5Cw00e4J1ITSNh6heP1s76e2KM
         EovrvSu6QmoSAZPC7aTdwOqV9fL9G8LqmelCc+jPpM31prCJy2s1ew2i+9FMxeqmRP8/
         NNxhbG/GMIaBxjQGlb9TWsIgu8gvVjMSRPWkKgFOQTuwvoE053CAV0/1/jYzTJIchPDR
         4nXvfzwhnQQ5IfJuZ3XyEGOGY1UcaFPgMu9cmSFSvgA35VeuIg5k2lDkx5erFU4max2m
         Pmh/eT/yIvkOLmHXYG4GbS/lme0g4XB3EDt01XRI9O7xJ6XDINsVN8LAG5WwY/jye5Bh
         5yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bk8vRH3Oa8mZo/j6zI4vBbyvdhhskcmfpsjeQNqjux4=;
        b=t6UR1uleaQgRuLPMPID5O5K0yAiZRaWeXlp2NEayLJoghbDF9duj02rNfnwfMI/HYK
         Mfl23lBUO4MjeEFLNIBlYOmBpILtPz1lAQmjqg3Lr2NkdMmSyNeurybvlf9gqPVGlMsF
         W94MeaUcfDYJFGI+FCS9YjeUZWD2AnrbXs6XQqKyWr1FLDPSwLLrtUQ1MAVim0RU3C6t
         Lj4UsnFZx0FDqzN0BCsw8tPe1IjRzO+kzhJ12YLieDiAQtsrkvElv9zjBYjolteU/mLI
         DYzke6eLSMEwvC9AJwzLjFBPKuyt9N/naABZXe557Q53UomnVuQ9A+A16jV56+k6FKqz
         TNyw==
X-Gm-Message-State: AO0yUKXgLdjke1h8Q4j1+/Mw0XxtmD6soRmYEEzzlQDoz9x3B6KFxLek
        Hsng1KXEfmOBXMtwhesOc4qgkSCJKZFdZKs6
X-Google-Smtp-Source: AK7set8YQ+yKX19V4NsOWWoEdGOK1U5oSwbe2Q5Rwy/1GGtKhUCRIXaj1bjxf2NExhRmdVGguceD2Q==
X-Received: by 2002:adf:eb51:0:b0:2c3:dbe0:58b8 with SMTP id u17-20020adfeb51000000b002c3dbe058b8mr13398729wrn.41.1676024836985;
        Fri, 10 Feb 2023 02:27:16 -0800 (PST)
Received: from linaro.org (wifi-eduroam-trans.univ-tlse3.fr. [195.220.58.237])
        by smtp.gmail.com with ESMTPSA id q12-20020adfdfcc000000b002c3ebbc9248sm3227804wrn.66.2023.02.10.02.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 02:27:16 -0800 (PST)
Date:   Fri, 10 Feb 2023 11:27:14 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drivers/thermal/rcar_gen3_thermal: Fix device
 initialization
Message-ID: <20230210102649.GD175687@linaro.org>
References: <20230208190333.3159879-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230208190333.3159879-1-niklas.soderlund+renesas@ragnatech.se>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 08, 2023 at 08:03:30PM +0100, Niklas Söderlund wrote:
> Hello,
> 
> This small series fixes a window where incorrect values can be read from
> the driver before it is fully initialized. The root cause is that the
> thermal zone is register too early.
> 
> Patch 1/3 is new in v2 and removes a unneeded call to set_trips() when 
> resuming from suspend, This call was in v1 changed as part of addressing 
> the initialization issue, it's nicer to get rid of it before that is 
> needed.
> 
> Patch 2/3 prepares for the change while also fixing a theoretical issue
> where one thermal node described in DT would describe interrupts and
> another would not. Resulting in interrupt support being disabled for
> both of them. I'm not aware of any case where this configuration would
> be used, either the SoC supports interrupts, or it don't.
> 
> While patch 3/3 fixes the real issue by fully initializing the device
> before registering the zone.
> 
> Niklas Söderlund (3):
>   drivers/thermal/rcar_gen3_thermal: Do not call set_trips() when
>     resuming
>   drivers/thermal/rcar_gen3_thermal: Create device local ops struct
>   drivers/thermal/rcar_gen3_thermal: Fix device initialization
> 
>  drivers/thermal/rcar_gen3_thermal.c | 36 ++++++++++++++---------------
>  1 file changed, 18 insertions(+), 18 deletions(-)

Applied, thhanks

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
