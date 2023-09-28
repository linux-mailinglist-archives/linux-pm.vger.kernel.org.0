Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2BC7B27C1
	for <lists+linux-pm@lfdr.de>; Thu, 28 Sep 2023 23:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjI1V4e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Sep 2023 17:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjI1V4d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2023 17:56:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A434C199
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 14:56:31 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40651a72807so12352595e9.1
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 14:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1695938190; x=1696542990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ+JMo8V6Wz42802JHuPtu0Gp5ARsCgYfg45BA+tI/Y=;
        b=0sB2IGOLjRg1hLzscJBhDhrIr1+NelfvTguJ8ITY4DhxQXiedFxClO0Vy1SvY46VDR
         JU9J7hQyJy9Ar8QMlBOCnFBvpJBGEOuKr9Hecen1PGDly7R5iCZblRmKBnJTzSEiJB2I
         ixOUmdySyQegyv9Hsb9qWSqzegndIyM7Ptc0wXsxT3rooyvUPshvmAvWEMNoKoEPpJgv
         3vwDqR4MNvtRryBVsQ4XcJ3Qyd7qtaF442sB5Tj3HRtTLooQ9vxt94ZPai8RTuPzdFkL
         pJX4l9fmBiJ94WCkXQ4FfgmEN/XccsN5iV0d658lt7pABkL14Tr7+GIs0LyXqgodtXJO
         O8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695938190; x=1696542990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZ+JMo8V6Wz42802JHuPtu0Gp5ARsCgYfg45BA+tI/Y=;
        b=wa+UGoGtQ4sag0k1mYfjucKQawmmDmacWbaJBNcDsprlUOQgE8RttjYc7uIWR/vxty
         IJjt/YP6NsVzKHfOTDrE9zDBLSfWvYsDP1WXhqkGmmTleI6saYa3mQiO8dPgGkiN+Hsv
         JxLQaR7YjzNA+EovBPhei+UdjRN+m8O7mPGREkhzMNMfWQQ8j78sizbsyUFnbqgy0tQG
         MkTvnHJg+WWLW0jryhz/6w6/L+xUwNUa9JCwVGXcJla+lEKUUPrMerpNXkNtp3C/CSZn
         opatMQvIy5XP1mGbuN6dDl9xVo2vb0x2vRXVmDoFtFtan8TZF1FIzxAbTIH1iBucV/rW
         XECg==
X-Gm-Message-State: AOJu0Yz8RiMIn9YXbDEddlI4Xy4TenC5Ch24AXcip8x3OTBEmOl1Q50j
        WcdaDV8XnoO9PXyfZgjDnBJ1rg==
X-Google-Smtp-Source: AGHT+IFGAZs15eAB0nMhOS0SGwjaQr6z+YM1hrsVNfS7p5IbowMrlzFUDnG4zqCEElNL0h0Z752N2g==
X-Received: by 2002:a5d:640d:0:b0:320:16b:167d with SMTP id z13-20020a5d640d000000b00320016b167dmr2398306wru.63.1695938190049;
        Thu, 28 Sep 2023 14:56:30 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id bt14-20020a056000080e00b003200c918c81sm13825072wrb.112.2023.09.28.14.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 14:56:29 -0700 (PDT)
Date:   Thu, 28 Sep 2023 22:56:28 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        wvw@google.com
Subject: Re: [PATCH v4 00/18] Introduce runtime modifiable Energy Model
Message-ID: <20230928215628.u53wmwlr6lm5qzpe@airbuntu>
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230925081139.1305766-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz

On 09/25/23 09:11, Lukasz Luba wrote:
> Hi all,
> 
> This patch set adds a new feature which allows to modify Energy Model (EM)
> power values at runtime. It will allow to better reflect power model of
> a recent SoCs and silicon. Different characteristics of the power usage
> can be leveraged and thus better decisions made during task placement in EAS.
> 
> It's part of feature set know as Dynamic Energy Model. It has been presented
> and discussed recently at OSPM2023 [3]. This patch set implements the 1st
> improvement for the EM.

Thanks for the series! I'm on CC this time :-) Unfortunately I have a planned
holiday starting tomorrow, so won't get a chance to do proper review till I'm
back which would be few weeks from now.

I just want to iterate that this is a real problem being seen in practice where
it's hard to provide a single average EM for all workloads now. So we certainly
need something like this.

Hopefully I'll get a chance to help with review when I'm back from holidays.


Thanks!

--
Qais Yousef
