Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905D5559265
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jun 2022 07:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiFXFi0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jun 2022 01:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXFiZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jun 2022 01:38:25 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA452EA06
        for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2022 22:38:24 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so4723477pjm.4
        for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2022 22:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y/SRxapVYozuhYMhBtEsKZgWVsRXORX77DHgWSqH9Xc=;
        b=D0Rue8sUgpd0Oz2oDwADqo0yETl19CbGgl0NcxTFdcpLIfiidGTvMiEGSbHFZbcinq
         baW0/Q++m/pcm5SiLWeU6l8prNwGUXlHPWd5JSYtBX0getqN+v508vHly1iMtuPTYIXh
         B6xX9I3CXSVoN48uO0snxhaqwLgcVRhSnamxeHC/w7q0mpeGLV71d7ceAi4+WglCM/A2
         bRbm9FlYjmMaZ/yFuL3plszZsIfsa0Q7d8qFjpb0gdvCv13Ulwbw5ZUT8ARVuUx5vTlm
         dlAO/u8xtb/R2YRQydQQ7m8Klz1GWiE0uajAvw6EUH+zfN0U8DyZnXixMEN0LDwU2nNI
         1xpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y/SRxapVYozuhYMhBtEsKZgWVsRXORX77DHgWSqH9Xc=;
        b=uybnbX9iY7Bbcq2SkDMwv1XvqWhk23Kjt5+wXBb2aQ1lWuHB4chb/xF7lCRkrej2iM
         5xcIyq91y2wQA2CprpbhxLyaJhG1zID6rbAYFP+4cvhf0l01goZuuqFnNllYDp/+13bg
         UTLCVeva4TuvURTZcNzCG3r9TmjFCH9l2lyA8KhHLt5DVzcXFEFy+m6PcUQPZrY1xRhj
         NJRF0c+mi7MMwXAy/OZ/PqALAGroTZrXqwmi60dIswFg8fsODJwZ8FhMFWuSYXwndoND
         jhMV9dtVhVRnpwR1nqvivgi3JdRdo0BKvVx5G2MFIcdczx+f0iqbE2myTaXIvvGpmj8q
         Jz/w==
X-Gm-Message-State: AJIora/wSwjqcnqpGstkH/Lctgx9XGg5VzsdHyMTcEZNaKxGQMXI+wDO
        y8MBT88/cPt/W6PIrIcE6tXcFw==
X-Google-Smtp-Source: AGRyM1toya/YrdeGKw+SyYyN5TqtRXMFJanSddtA7xBFHFmaieaTouohS+OBViv/YKTrufCn4l1Evw==
X-Received: by 2002:a17:90a:408f:b0:1e3:23a:2370 with SMTP id l15-20020a17090a408f00b001e3023a2370mr1959764pjg.84.1656049104303;
        Thu, 23 Jun 2022 22:38:24 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id 2-20020a056a00072200b00525217fe273sm641043pfm.187.2022.06.23.22.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 22:38:23 -0700 (PDT)
Date:   Fri, 24 Jun 2022 11:08:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/31] cpufreq: tegra20: Migrate to
 dev_pm_opp_set_config()
Message-ID: <20220624053821.e6emke6gortqn72a@vireshk-i7>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <4b38ceed657bfcf87ff9ab0dd69dd1f2f5658b24.1653564321.git.viresh.kumar@linaro.org>
 <793e49ea-aeb0-a47a-9fe8-742a6397bb35@collabora.com>
 <5c0e697e-abca-bcf0-cf68-d9c240d82527@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c0e697e-abca-bcf0-cf68-d9c240d82527@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-05-22, 19:59, Dmitry Osipenko wrote:
> With that fixed, now there is another error:
> 
> [    1.761945] cpu cpu0: _of_add_opp_table_v2: no supported OPPs
> [    1.761960] cpu cpu0: OPP table can't be empty
> 
> I see this on Tegra30, but not on Tegra20. Apparently OPP table
> refcounting is broken on Tegra30 by this patchset. To make it clear,
> there are no error without these OPP patches applied. I may take a
> closer look if will be needed, just ping me.

Hi Jon,

Dmitry reported this on Tegra30 earlier, do you also see such a
failure ? Would be helpful to get this fixed as well, if it still
exists.

-- 
viresh
