Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65EB5210D7
	for <lists+linux-pm@lfdr.de>; Tue, 10 May 2022 11:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbiEJJcZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 May 2022 05:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiEJJcY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 May 2022 05:32:24 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE12D28C9D8
        for <linux-pm@vger.kernel.org>; Tue, 10 May 2022 02:28:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so1630283pjb.0
        for <linux-pm@vger.kernel.org>; Tue, 10 May 2022 02:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=z3lYLkGJEXnAUi0c+xoObDyUdD6BSjxjjdIs4qDVH9c=;
        b=T4dSTnw/ZVibhtlFufil1OlNvDOmLFga7jJrDf6lwuWfmFfttDkMsEWCS8LI8fVRaa
         GAgX6IGokf40id9lHothsH+/GGYoXq89N4TtpWXrnG4ACpv5PBRVTkRIGhfrgFKDblC8
         h7C/F4qZJRc6MzQhU58jTZ8qI0Uszo080M+TczJngTfERbz9ss6xjD8/a4DqtIYwaUaA
         V1/VhNPvfzVLwMQ/5Gj1zwjN4ZIQ5dEEKUIiobc85rZMp8vRgvlEz+6hS8aJ4Qlhpo3X
         X/7q5e+fEFWUf5kX9bqrXwhWpCxbsc/aEIcBkwjnE30myDbjIE30cEa0jFFaPrkjJ3fi
         UJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z3lYLkGJEXnAUi0c+xoObDyUdD6BSjxjjdIs4qDVH9c=;
        b=5YhBt1hvlXLVrspsaVrO9u4q5rbkytLVm8IAwMyzu3l0nb3vSJri8VevNovKOphl6p
         SYnVsEz6CQ4yGAlh5ameqDtTsPyucfZmNfQhR13BsGIB1Osh+1K6V6XdiKIW9yzDQuoe
         OKTho9VfVifiSs5V0NMUDE+t7+5eSAIzZU5kXhqVrladXZ/brgnNv79m3jYFOcZomccK
         yEEPDGb13YO58aCmIeTefAGOQVV8e106jGMRUFp1d4FoFJc+4r5MeUMw0BZPnOdHq8WC
         92MKnhbOhcH3uaLOphkOLcNQl1VSyrHIm1JnzWRevGsAmzO/5JLvYKIR7HVmSa0AzMSL
         FmyQ==
X-Gm-Message-State: AOAM531BtGDkhSgGiooq4Ev82NMF4GagFG7RX1pxKwfLyCxwFo77iKam
        M8lP4yJr0eom07m4UulUeJDn9Q==
X-Google-Smtp-Source: ABdhPJyJh7XBDpHQBR733lWsZngmSm7+5DfzAPB2gKzKihOiyOd5b9+fjtXzaVEnT5anC0+3Z5v97A==
X-Received: by 2002:a17:902:cec4:b0:15e:cff6:676 with SMTP id d4-20020a170902cec400b0015ecff60676mr19946880plg.2.1652174905212;
        Tue, 10 May 2022 02:28:25 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id 2-20020a621702000000b0050dc76281f6sm10128012pfx.208.2022.05.10.02.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 02:28:24 -0700 (PDT)
Date:   Tue, 10 May 2022 14:58:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jiabing Wan <wanjiabing@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] cpufreq: mediatek: Fix potential deadlock problem in
 mtk_cpufreq_set_target
Message-ID: <20220510092822.j3z6bydurg7x5bu4@vireshk-i7>
References: <20220510090531.12438-1-wanjiabing@vivo.com>
 <20220510091212.olrvvjlx4jtm7zw2@vireshk-i7>
 <49566544-e8f2-ef38-288e-fcd276d87d3b@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49566544-e8f2-ef38-288e-fcd276d87d3b@vivo.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-05-22, 17:23, Jiabing Wan wrote:
> 
> 
> On 2022/5/10 17:12, Viresh Kumar wrote:
> > On 10-05-22, 17:05, Wan Jiabing wrote:
> > > Fix following coccichek error:
> > > ./drivers/cpufreq/mediatek-cpufreq.c:199:2-8: preceding lock on line
> > > ./drivers/cpufreq/mediatek-cpufreq.c:208:2-8: preceding lock on line
> > > 
> > > mutex_lock is acquired but not released before return.
> > > Use 'goto out' to help releasing the mutex_lock.
> > > 
> > > Fixes: c210063b40ac ("cpufreq: mediatek: Add opp notification support")
> > > Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> > You should have added the review tag you received.
> > 
> > Applied. Thanks.
> 
> Oh, yes.  I would add the "Reviewed-by:" tag only if someone sends
> this tag to me.

Didn't you get this ?

https://lore.kernel.org/linux-mediatek/304e7eefbb57e9c938737b64fbb515201c7944b8.camel@mediatek.com/

Rex, are you subscribed to LKML ? You can't send an email there without
subscription. I don't see this email on LKML lore.

-- 
viresh
