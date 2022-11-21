Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79972631B71
	for <lists+linux-pm@lfdr.de>; Mon, 21 Nov 2022 09:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiKUIau (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Nov 2022 03:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiKUIaq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2022 03:30:46 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F81DF04
        for <linux-pm@vger.kernel.org>; Mon, 21 Nov 2022 00:30:41 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id g5so1303498pjp.4
        for <linux-pm@vger.kernel.org>; Mon, 21 Nov 2022 00:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=77nlpT1UtT2f7TDmQ1L0AgCLVss9mxayAo02DMUC5Kg=;
        b=K4Zsk9gJfvRPRaFFT0pLQvp03kvx7GRM+mBM//6uAQGpXOtu2xB7eGCJGoQ/7lVF0p
         T5B3dt4waTkqRSPmp5+rriVpIwqMXD2+ndThw9l8XCrgUxfo44sdeSdZShGtaZN8SLz3
         p08gOlv37G4vpLuksqe4s9Z1roS4cD+q3dMtUFQLBer9yD1/GFFfeQZxcqGG1j6GbcUo
         bEtU9lhPtttj+2RB9FWmX03DiItSn0/xC2yBBDRLmj+xMZi2rDeLiApC174IZwNh5ya4
         NLRxfL30VIl1C4DX8RKMP2Kb48qP4yDt9G2VWcLktEd7oAd2tCzi+IGvfS6rxkHP244N
         ZvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77nlpT1UtT2f7TDmQ1L0AgCLVss9mxayAo02DMUC5Kg=;
        b=wK7wWpdtxHfRdQedB54zwxF3HPT8ec0l14O5M++HEdC/Kk8jsU3ugVmlKUkqWaQdcl
         mC3XVp4Is7/J300w1IWzspiRVRD71eoX5SN9QQeQRN/linHrrmwiYMMsUQudh9X6OTUE
         87WPjdN1bYFBgqNjpq52diA2XPHHXXExTAKwGNKDNITRcY57LB5GNnR56eqXyb7an0K7
         YVsBaAbYiiT5mw2s/fLbYJ7HoVE0cCoVii5bjC4dXJAz6qSPSe+zJKz2bO8rVQt2C6ch
         GdMdds9UbdG0JxW+v1/x1L6MQknagjn/dn5mf0qXhTKSBhpB4ypMe7PYMGb+LUkW0uDp
         fu4g==
X-Gm-Message-State: ANoB5plFyT8UaCKvmUNG6gNrEk3uhX4p2VSPTBeoXURfTiOf83NKBY0g
        V2zYDsybPlQwx9aLOumzRe6GDQ==
X-Google-Smtp-Source: AA0mqf5O84zrPfVTz1lHk4N+pi0wSmqGktmOWxC6ECtbtk3vPtBCdrUGPm0LJVTCuKEUja7f8Q0BiA==
X-Received: by 2002:a17:90a:6904:b0:208:4bfa:51e1 with SMTP id r4-20020a17090a690400b002084bfa51e1mr24643533pjj.228.1669019440577;
        Mon, 21 Nov 2022 00:30:40 -0800 (PST)
Received: from localhost ([122.172.85.60])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b00176c0e055f8sm8823141plb.64.2022.11.21.00.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 00:30:39 -0800 (PST)
Date:   Mon, 21 Nov 2022 14:00:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: Disallow "opp-hz" property without a
 corresponding clk
Message-ID: <20221121083036.ppwfprrheuf7xl7c@vireshk-i7>
References: <cover.1669012140.git.viresh.kumar@linaro.org>
 <c03c4f2b9d4dcc3264d1902606c6c5c464b4b043.1669012140.git.viresh.kumar@linaro.org>
 <Y3snGQet8yc7HnJK@hovoldconsulting.com>
 <20221121073817.7ollj7jeixrx5og5@vireshk-i7>
 <Y3sryFh84eK/sWKF@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3sryFh84eK/sWKF@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-11-22, 08:42, Johan Hovold wrote:
> Ok, I was expected the devicetree update to through Bjorn's tree as I
> imagine there may be conflicts otherwise.

Dropped the DT patch now.

Mani, I believe the first patch in this series is still required.
Without that, when the cpufreq driver calls dev_pm_opp_set_opp(), the
OPP core may end up calling clk_set_rate(), which shouldn't be done in
case of Qcom SoCs.

I am not sure though, how it will work with sc8280xp. Can you please
check ?

-- 
viresh
