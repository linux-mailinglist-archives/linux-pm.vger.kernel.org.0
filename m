Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C726D782351
	for <lists+linux-pm@lfdr.de>; Mon, 21 Aug 2023 07:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjHUFyY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Aug 2023 01:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjHUFyX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Aug 2023 01:54:23 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F27A6
        for <linux-pm@vger.kernel.org>; Sun, 20 Aug 2023 22:54:22 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bbc87ded50so17103675ad.1
        for <linux-pm@vger.kernel.org>; Sun, 20 Aug 2023 22:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692597261; x=1693202061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f0HwvSY0tuionNGSDaMvFxp1nm004xhxlpxQFd/jOCw=;
        b=fvsJUmi4jL/0Mm8VNKyfUbwr9vLyVr3iU3ATpsXs4BOtV/XoCP6KFb0B0OS4Aw9LXj
         /8KB7P58+N0Y/6giyANRmqF5AR8JPvj1a9qKTTb2cuQGEnS+c4y825rdjvbJQ0k17lyh
         JzJd/jnRw1+miUcYYCBivBMgr8uw5YYHH3pet9bmzcWH8LifqQIvX+PcImaq1g36CnBy
         8NO6GFQtHJnRaxwrqpHXPn7VC+rASso+7kDQGMgPeFHieGOV4IDNqNbD2qyYQKrJ1VjS
         8vlFroG1CYGqHGlotwumg/aaPgID5o46x+thueNK0h0EA40B37pb05IeollaFNnchBwK
         ERGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692597261; x=1693202061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0HwvSY0tuionNGSDaMvFxp1nm004xhxlpxQFd/jOCw=;
        b=gEIta8rWWcmqdDNZgapstOjGYHF0YigEjhxAfTN3rFJWHWww4f/ptzMCeJnd7x7uIP
         5GSFZYYME+qeMai30q+S0e9B1+JmsuU50cch6kIFWbQY2GU0fBqwGgF/5pHkAkObw4Et
         XKz9Wy/L/Q3qzJehDaegFfnJ029LuHCcA/iEHI/jE4UUuaFBw+YyOSamqC8DyKm408b4
         FcyrsJRbUrDyzrjr5w9jP7ZQLxubbaoL/9KIvFJVhTZ4frzKiaawOKiH8T9WONA1ZPDo
         3suE3ZrbzAIoJVxpvxVCEZ3FboKg5c6oMB0iIzh9sfSK0nEy8bibPAsF6DRoA5YaWv+h
         HlLQ==
X-Gm-Message-State: AOJu0Yy/nkGrlw8sLZKyQOgEGhxRrtZG3U1DtiYy5/8p8BJMoLK/DVca
        54VteHXjWhz8uub9NDKiPNafRA==
X-Google-Smtp-Source: AGHT+IHVVWc2WZ0qVLuotNRdsW5NXYUef2v8+t2KwEeZet4wSUGCnSuVXV+Dr7+71MiPL/v1dMsDnw==
X-Received: by 2002:a17:902:bb84:b0:1bb:3979:d467 with SMTP id m4-20020a170902bb8400b001bb3979d467mr3426886pls.63.1692597261530;
        Sun, 20 Aug 2023 22:54:21 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id z7-20020a170902834700b001b8ad8382a4sm6024089pln.216.2023.08.20.22.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 22:54:20 -0700 (PDT)
Date:   Mon, 21 Aug 2023 11:24:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH V5 0/2] dt-bindings: opp/cpufreq: Convert ti-cpufreq to
 json schema
Message-ID: <20230821055418.6x436wdanb2tnsle@vireshk-i7>
References: <20230818124504.3718266-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818124504.3718266-1-nm@ti.com>
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

On 18-08-23, 07:45, Nishanth Menon wrote:
> Hi,
> 
> Convert the long pending free-form text bindings of ti-cpufreq and
> omap5-opp-supply bindings to json-schema.
> 
> Changes since V4:
> * Fix up comments from Krzysztof for patch #1
> * Picked up Krzysztof reviewed-by for patch #1
> * Picked up Dhruva's Reviewed-by for patches 1 and 2.
> 
> V4: https://lore.kernel.org/all/20230811031458.957624-1-nm@ti.com/
> V3: https://lore.kernel.org/all/20230809023045.1870410-1-nm@ti.com/
> V2: https://lore.kernel.org/all/20230801233341.1416552-1-nm@ti.com/
> V1: https://lore.kernel.org/all/20230724153911.1376830-1-nm@ti.com/
> 
> Nishanth Menon (2):
>   dt-bindings: opp: Convert ti-omap5-opp-supply to json schema
>   dt-bindings: cpufreq: Convert ti-cpufreq to json schema

Applied. Thanks.

-- 
viresh
