Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325154C9CC3
	for <lists+linux-pm@lfdr.de>; Wed,  2 Mar 2022 05:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiCBExv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Mar 2022 23:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbiCBExt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2022 23:53:49 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0562D49CAD
        for <linux-pm@vger.kernel.org>; Tue,  1 Mar 2022 20:53:05 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so619311pjb.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2022 20:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R9ewq8IKyII02hpWaWH/lhlLsChnLN+g08ELQd2cLms=;
        b=jLwsIKRZQ3dzZRSk3NsjHqE2fINfKJmqaC/Kldfn6PXM8Is3wF9nZ+yS09RNAcVA8c
         IOYqpy3AOzWIGgoeARfHCZXE/xVYUL25CanBoi+ars1ASqj9NzJJbs29FpLTipzqqoaE
         fPJt4VKO3BrdZr6BdaCA0oYtnKmpO/E6rRHqu8Ocjd8Vbvze2xISnWsCYUueArfb0Yuk
         JQN1X2yjxjtp1lj4Lp2JyD8Pho8LZZnrF0Uk7qvKww4v0Y8Q+Y2D38o33EjFfpDTy/NC
         isFilFs8RdfxB/58iW5vcL77a5ZV0ixjxTRCct7ez+YvdkhWZtTBCTWnbNtn6DHDpMAJ
         O1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R9ewq8IKyII02hpWaWH/lhlLsChnLN+g08ELQd2cLms=;
        b=sbwJWSmbVb2gtU2/tw9Iz6Drj02FaZIb72ijeJ31BJ3+5s7I1OW/VpRNjI1sgbcPmD
         Y+S864fPkWy32xYsT2XvKNT2ckF22H7GcXRkNP0yJbowpPujdz6W/BjhpDq5D8652n3+
         2imuaHa16LhQ+nDbeBEgWa4Sl9fkKh+xYNiSfSE7C+5tdgOW/WUYVF9FmYt7qjG3tmcP
         5jZXJbyBoHhRdCJy+YLa1W60epGE2jacfBxqBSka91c0O/qfQqoOyH7/gJ6VKfSEuRmm
         tm0mfSr3igoujkeH6xGLxQCkxyso7hx1MV4dK1kSnAwFywBDxQZgyHAQM/fa0q3EUl1w
         WsIQ==
X-Gm-Message-State: AOAM533t0JTybPe5RNjUBrtkb36KRukHramfRMj0qD15wAebyJm5m+EE
        OAoAwp1cKHt2OiKnL4TVVi3sf4w52L0g0w==
X-Google-Smtp-Source: ABdhPJxJ1RwhIoAz0SQKaLPZQViq70gdhaqIbQCWIugJ4u1o2z9iIDQ0avf6a/E8q2g55qxnaq6/Sw==
X-Received: by 2002:a17:902:8ec7:b0:14a:c442:8ca2 with SMTP id x7-20020a1709028ec700b0014ac4428ca2mr29106038plo.12.1646196784471;
        Tue, 01 Mar 2022 20:53:04 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id e14-20020a056a001a8e00b004e136d54a15sm19675601pfv.105.2022.03.01.20.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 20:53:03 -0800 (PST)
Date:   Wed, 2 Mar 2022 10:23:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 3/4] OPP: Add support of "opp-microwatt" for advanced
 EM registration
Message-ID: <20220302045301.fq6nolscdfd5wvyo@vireshk-i7>
References: <20220301093524.8870-1-lukasz.luba@arm.com>
 <20220301093524.8870-4-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301093524.8870-4-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-03-22, 09:35, Lukasz Luba wrote:
> The Energy Model (EM) can be created based on DT entry:
> 'dynamic-power-coefficient'. It's a 'simple' EM which is limited to the
> dynamic power. It has to fit into the math formula which requires also
> information about voltage. Some of the platforms don't expose voltage
> information, thus it's not possible to use EM registration using DT.
> 
> This patch aims to fix it. It introduces new implementation of the EM
> registration callback. The new mechanism relies on the new OPP feature
> allowing to get power (which is coming from "opp-microwatt" DT property)
> expressed in micro-Watts.
> 
> The patch also opens new opportunity to better support platforms, which
> have a decent static power. It allows to register 'advanced' EM (based
> on real power measurements) which models total power (static + dynamic),
> so better reflects real HW.

Advanced :(

-- 
viresh
