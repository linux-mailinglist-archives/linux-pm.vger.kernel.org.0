Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11063569FC8
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jul 2022 12:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiGGK0q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jul 2022 06:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiGGK0n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2022 06:26:43 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E06050717
        for <linux-pm@vger.kernel.org>; Thu,  7 Jul 2022 03:26:42 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u14so21692364ljh.2
        for <linux-pm@vger.kernel.org>; Thu, 07 Jul 2022 03:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sxYKdjuuJfWkKg6gn2cOyQPrvRyBOSj9iNHpzQMkc8k=;
        b=5izSL4NqriSQe8gSvdTdr0gafrwUbYBO47Iz/mNgUnGPgiWpcmPdR+TQ6aMeG+XIsm
         sIu+56lvK3fY3yur2tjIIxTMVW3o90r4KDLinhb5OZnDLRrXyK2dbUqx1NghB9HHYwkH
         zsaXGnvPbMzqtJt+P7MabGOHqfUX5goe74kMNY0NjaYOwwetz3JoIfXQa5mC+xLsgZwT
         1mG3JvpFWiaQNvH6zEnFlJSBEoshde3I35ZX0YR+isolrIUBEs1P5kGhnxn04iqjgQC2
         2c8WsqvYoUpqCfrw5veJrtBksqpahlz3AHl/Nso5/EZv4EfRsmb2Rqc98Vljqnkmpaz4
         Td6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sxYKdjuuJfWkKg6gn2cOyQPrvRyBOSj9iNHpzQMkc8k=;
        b=v5DpEb1suZGG8z5IwHdEkg7c4YpJRZ9X57Iyw2avtUFSvnBVEudtSx8Z/oEmiCyct1
         JSB5WdxPAev42qHLgTuLKi+8NZKg8ko423nkKxnyqx0owtXllXE+nt6Xb1xISCWj2zkq
         uMHbSvX9qj0G567DmfoLHPFchOPt7zwKe1pczfp8B3+Zucs/MxZCRTVGAZpe7zayuk62
         oSVJpEqRfG1sz1edf1V3ZwpdYdqCrYe5VbCtd3Y0KcZnzC36f9xbxMCQoBjrUwFOKRuI
         jw9sbpjPMo8VVEgntNqSEJRh2vk9SGDcI7WGjjsyUQRnLSX8iqsrduhufSgJ5xuKnfpU
         cTLQ==
X-Gm-Message-State: AJIora94SDCOzaooBmRKkHkaNBTWu6mwa66RhjNyYULox3VMnxbnb6dJ
        ZNUCE7eRaxbSFL8H9JLRem8dlw==
X-Google-Smtp-Source: AGRyM1vI5QtVdBgnERqDxsSE47RlgYECbgJxb3cFPyrA5RvBc3U8hUKiHuqShan/ZOfIzc667Lg9WQ==
X-Received: by 2002:a2e:bd89:0:b0:25a:86c8:93ca with SMTP id o9-20020a2ebd89000000b0025a86c893camr24990848ljq.419.1657189600793;
        Thu, 07 Jul 2022 03:26:40 -0700 (PDT)
Received: from localhost (h-46-59-88-103.A463.priv.bahnhof.se. [46.59.88.103])
        by smtp.gmail.com with ESMTPSA id c17-20020a056512075100b004795d64f37dsm6764924lfs.105.2022.07.07.03.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 03:26:40 -0700 (PDT)
Date:   Thu, 7 Jul 2022 12:26:39 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] thermal: rcar_gen3_thermal: Add support for
 hardware trip points
Message-ID: <Ysa033e3BnH+wVBM@oden.dyn.berto.se>
References: <20210804091818.2196806-1-niklas.soderlund+renesas@ragnatech.se>
 <20210804091818.2196806-2-niklas.soderlund+renesas@ragnatech.se>
 <40b2b8d1-f86c-4788-767c-22e60283e458@linaro.org>
 <YsasmbJotSd/aIu/@oden.dyn.berto.se>
 <2605a591-abf9-01ca-015c-efc3978803b8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2605a591-abf9-01ca-015c-efc3978803b8@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 2022-07-07 11:55:55 +0200, Daniel Lezcano wrote:

> Thanks for double checking and confirming. I've a patch removing this code,
> no need to send one. I'll submit it along with other changes around this.
> Perhaps, I'll try a revert before, it would make more sense.

Thanks.

To be clear I don't think we should revert commit 47cf09e0f4fc5120 
("thermal/drivers/rcar_gen3_thermal: Add support for hardware trip 
points"). Only remove the 4 lines it adds to rcar_gen3_thermal_resume() 
as they are redundant. Does this match your view of the revert?

> 
> Do you think the 'revert' should be backported ?

I have no strong opinion, I think it's a matter of risk :-)

There is no real harm in writing the trip points to hardware twice 
during resume. On the other hand if we *know* the thermal core in the 
backported kernel will always call set_trips() after the device is 
resumed, then there is no harm in removing it.

-- 
Kind Regards,
Niklas Söderlund
