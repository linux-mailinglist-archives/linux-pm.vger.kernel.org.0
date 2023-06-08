Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658F6727B9E
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jun 2023 11:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbjFHJku (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jun 2023 05:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjFHJkt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2023 05:40:49 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C572210B
        for <linux-pm@vger.kernel.org>; Thu,  8 Jun 2023 02:40:45 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-565c9109167so3455757b3.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jun 2023 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686217244; x=1688809244;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kT/4ERLhvhoaB2/3pcmd2QrnNqXZyt9hB0faS7bbTAE=;
        b=JQWwvt4SW0ZHoc1UTQ/dMF3PvHa7Dt6eir0xAu8c0vS081G2qf9Jws1/lY9qbiTJX2
         +gWjMQJs56riC/BRdtictohM2wJ9OLu6FgloOIQzwed62coe2jwySn/gJ8wBwnlsw106
         ZUq4Dy1gJGCJGxkkTgNtdc+JzbCRwKCtFENp9CJQDmwBB4EY6eKqoEVhMti1xqwaG3xc
         Gu76Ghco31hYIpNU0lpM5DL+hBgSua3N60APuXes4eMGg9ESPuO+pJpih0ahKgA0ERBs
         7mJAnCzPyee6l+xMlfDGgfxiOuROO3/8Vwat/iEb9PBtYGI8LxiluEowXYW9rVJdSbL4
         nvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686217244; x=1688809244;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kT/4ERLhvhoaB2/3pcmd2QrnNqXZyt9hB0faS7bbTAE=;
        b=LoJps6+EfD31WxY4haRQ7t7XbRwtPQVin9NiFxrHKg43ERhmCg+BrxVEy2hVPwuGlP
         QO0rVEfOhm4G+sj+h5Elp13ZuuPRJJM7QebXiAjEJ2e37xmI9OZhMj15sF8xVn7Wmhss
         pOpjKLPCm0pdM/Ja+xaGAImWCaucTqr2ztnypKJ3OH5nm3IwXT2bHG0zwy/R+8lTFqLv
         bAhSv7/f69x7qC8E7iiP+0+ko4m/27wlIPfHZTC2bueFfACZhJsK4dS67F5r7wrz1FEr
         gTX10/4hgsIOqXQfTB+KTsu8CyrpgFDJ2fUhJbN7y4bdhOu0CehmSleswEQ1s3pc/wYt
         BEyw==
X-Gm-Message-State: AC+VfDztG1tU3SoJLABQYtMhORiP3NxsPDdn2a9OUh84y89bp+Hm83oO
        QGOPbu61ch2T0pTOWMOd4WanGJ09pkh+Vtpg4wwmsQ==
X-Google-Smtp-Source: ACHHUZ4KvRi/dHX0SUu44hlf/6b3eJqA97g2u+OP4mTyY+DaM/novQI/e+r7uKvE/9LaO2LJ5i5YWSE9L936C+LApdA=
X-Received: by 2002:a81:750b:0:b0:568:a55a:47eb with SMTP id
 q11-20020a81750b000000b00568a55a47ebmr7861504ywc.7.1686217244551; Thu, 08 Jun
 2023 02:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
 <20230607124628.157465-12-ulf.hansson@linaro.org> <20230608052953.l44dwb6n62kx4umk@vireshk-i7>
 <CAPDyKFodvtRE5DHeMSSG5o4iJw07TjFHSeAoTuugH9OAmE8bMQ@mail.gmail.com> <20230608092253.yeuzlz5bn2iqihuk@vireshk-i7>
In-Reply-To: <20230608092253.yeuzlz5bn2iqihuk@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Jun 2023 11:40:08 +0200
Message-ID: <CAPDyKFrWCOinNPC_F1+D566j_a=-7d+DAcvO5qH3Sq_TX4dx0A@mail.gmail.com>
Subject: Re: [PATCH 11/16] OPP: Add dev_pm_opp_add_dynamic() to allow more flexibility
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 8 Jun 2023 at 11:22, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 08-06-23, 10:59, Ulf Hansson wrote:
> > Certainly, what do you suggest?
>
> `data` :)

I thought you meant renaming the struct. :-)

Yes, I move to data instead!

Uffe
