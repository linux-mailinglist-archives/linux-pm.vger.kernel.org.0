Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44407727B21
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jun 2023 11:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbjFHJXA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jun 2023 05:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbjFHJW7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2023 05:22:59 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0286E268E
        for <linux-pm@vger.kernel.org>; Thu,  8 Jun 2023 02:22:57 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-75d4b85b3ccso33912485a.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jun 2023 02:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686216176; x=1688808176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8b/gDQIXaNM5IiqWISzfBNlaVliL6eQ4AIhMEo3dIDY=;
        b=YjeQGOzbCH5qau22ZC0F2gMDzwvlxXi0tiirBhhpalzQvqUDgNAyRfRwrCfUXt8Nm8
         7Kg0GqUEYqrjWcS9jQddVyEKNtc5P50TTuMfVfTh1Be8rfw14CFUsQxTTbxeJzXXf06R
         C/LpOR9qBbjS+abaiCMg7dxe+87PZDuqNyjoOe5TB3D//bugZEI7zqrVEvdTXUqFNfKb
         4uj2FQ1L05ZobFErPZefp/Lb/QIyCrXTIg0BFevcPR2kHr95dqCrGXeu+CoUNrK/Poyw
         /Pj/Xdmsc76GsBB0MDk30wtfPJAfZLS7+RTp974PqcT5IdQ7JVTrB1CUi1CVR027PbPz
         ojSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686216176; x=1688808176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8b/gDQIXaNM5IiqWISzfBNlaVliL6eQ4AIhMEo3dIDY=;
        b=QXYWlTogdKicmcpUMhV1SXZIpmDmMdfCo2CjdcY3nFCdZrZaXej8n0MwM6mgzw48iD
         1vVtl2HoZSWPJMWUEJqWAtX1US2anFed0jTMbMlZrNrijPv4QhWBdPmi1lOHnd9pqjdt
         mpHth+pc2odCe1sxY3rNquMTvpx9Ntylk57ynadq7OsNDanjIsojeAhflEkgpecXBq/n
         SU4H6/KsN34DADNDb4ipzktiywSJiaLR1SZutqXhSHptnHa4CRIjs0gTLLeBRPtNOe0V
         TlKif0YcVeLCIfQEQycTxaIELGXkZ6AT+5hjOAnm4crunImJp4lM05OfOxyhWIUIzb/7
         Rkug==
X-Gm-Message-State: AC+VfDxIpy5IpLGJkF9tsRnUzffLdfZvQNdDcLEiUm0YLa+vcVoAPr9U
        MGPE+Q2IP1hTiR1EJCzDQDhZkA==
X-Google-Smtp-Source: ACHHUZ4KD11Xdm9UvxthlbmqDsuW5Z50Xfc1jh+dzZ0XYsPZoV57r4t/qCllEDTyGxbK98jXak1GsA==
X-Received: by 2002:a05:620a:a02:b0:75e:ba6e:be65 with SMTP id i2-20020a05620a0a0200b0075eba6ebe65mr4345752qka.55.1686216176101;
        Thu, 08 Jun 2023 02:22:56 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a19d600b0024c1ac09394sm929652pjj.19.2023.06.08.02.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 02:22:55 -0700 (PDT)
Date:   Thu, 8 Jun 2023 14:52:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/16] OPP: Add dev_pm_opp_add_dynamic() to allow more
 flexibility
Message-ID: <20230608092253.yeuzlz5bn2iqihuk@vireshk-i7>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
 <20230607124628.157465-12-ulf.hansson@linaro.org>
 <20230608052953.l44dwb6n62kx4umk@vireshk-i7>
 <CAPDyKFodvtRE5DHeMSSG5o4iJw07TjFHSeAoTuugH9OAmE8bMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFodvtRE5DHeMSSG5o4iJw07TjFHSeAoTuugH9OAmE8bMQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-06-23, 10:59, Ulf Hansson wrote:
> Certainly, what do you suggest?

`data` :)

-- 
viresh
