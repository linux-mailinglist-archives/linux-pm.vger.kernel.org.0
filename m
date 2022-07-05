Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4EE566537
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 10:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiGEIkh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 04:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiGEIkg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 04:40:36 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65A15FCB
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 01:40:35 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id a15so10873311pfv.13
        for <linux-pm@vger.kernel.org>; Tue, 05 Jul 2022 01:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VR95GotZ7Nj3L4cg4OZ6XG6Fy5wQSJaOusIVhdvl2CM=;
        b=FTcCNptdrwJCmACL4XpzaJX4tYJgDHx1gxMAcSkGUhmqYHFWs4MYEqUEyTHRc9X/QM
         Kxq5ZuPMyHzLXUeBjIydg7h4ACgOemDwnXsMbGT7VIdhT75qPlAWoetk8PzS1g5UXPJY
         WWU+1z66Cp2aoOYTRZ1hgb95BgJ+zqz/zsUbUdVBC2h8ehGzYYdTYj5oBb87TSVt+bz/
         +FpEOg3Zc01PzpiIWvZNPbPWkWRQ4PV+k4MN1ItTEITtuLUXdrrAAxiBlwJxnSPftieY
         N3/Ac+7LSRCwzEer+aI6ACL/t/PrnJ5Ww/KHAZQ8iPXDDjQwYW/7G28zHAwc4cGdCF5H
         jjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VR95GotZ7Nj3L4cg4OZ6XG6Fy5wQSJaOusIVhdvl2CM=;
        b=D6gqKPA8DQa2CncryGWqpo9rRUkd2GbQNv9PCRKGr6eVeImf2m50eGi+fjqo+aLgvp
         h7my4B0TZlKhgRffo2TW1mr8uBplfnksxr3qpRoLLq1B0ZZnLAgGXAjeVPBaaqe59hUa
         eDLa6YZ40oK0RCTDPhmOI0tC1EhgMNPt7HUpsLDHdplDZUsIYofzI2m3TPc+pm3R9O6T
         s54/R04iVqHdZUAfVOb81KlduSqGDvQXO6QR4bZlqn1ZyMzqXMThg3ztgK0uUJeAO+ll
         dO6hKZCRs3wHSNbv1eV6fuH/HBiOO+pp5vNheFSVkFvQfhsm0RL7oGzYhJyPhqa4AW7d
         m1Nw==
X-Gm-Message-State: AJIora9iVvOG5cE/ngAp+cebkDSRuejeecAfLspIN/S4xa62eRHXeg65
        HwNA8Qz88AkToBAVydBbOezmbA==
X-Google-Smtp-Source: AGRyM1v5vvUOuDVxuL90GQcs8N2x+l+yK4Ev9FXClziIY8Mg07pToCm7ABiPgejU487hA6hy8F7+Eg==
X-Received: by 2002:a63:6aca:0:b0:408:8af6:a885 with SMTP id f193-20020a636aca000000b004088af6a885mr28922712pgc.477.1657010435472;
        Tue, 05 Jul 2022 01:40:35 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id 125-20020a630483000000b0040d2717473fsm22453993pge.38.2022.07.05.01.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 01:40:34 -0700 (PDT)
Date:   Tue, 5 Jul 2022 14:10:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] OPP: Allow multiple clocks for a device
Message-ID: <20220705084032.stkoixfiotifivgm@vireshk-i7>
References: <cover.1654849214.git.viresh.kumar@linaro.org>
 <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
 <de13cca4-3a33-6482-7b02-f89796f45325@linaro.org>
 <4cac6c79-ea9a-1f48-c6f1-2e04b54590a4@linaro.org>
 <20220705065940.v3n2s7bgr6eai3rf@vireshk-i7>
 <20fdb316-0f7e-0a19-0b1d-70f2f8f7dad9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20fdb316-0f7e-0a19-0b1d-70f2f8f7dad9@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-07-22, 10:18, Krzysztof Kozlowski wrote:
> I would say it is not different than existing opp-level property. To me
> it sounded fine, so at least one DT bindings maintainer would accept it. :)

:)

No one is stopping a user to use "level" here, just that I didn't
wanted to force it for everyone with multiple clocks. From a DT point
of view, we should be able to uniquely identify OPP nodes just based
on all freq values.

-- 
viresh
