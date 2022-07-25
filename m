Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF00557FEC6
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jul 2022 14:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiGYMJx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jul 2022 08:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiGYMJw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jul 2022 08:09:52 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018C7DF6E
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2022 05:09:51 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d7so10197055plr.9
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2022 05:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/vAlD2Uj4JArMK2xat0u8itYglD8Kk8L5ACdFaAlxqs=;
        b=A2oNuiPlEVJtYLXgw2uTDbD5XoOkhTkRZ+TgJG9T0B0UnRIol8tNmoj+OnwvNTiEZc
         hle3V416mtDl6YnRY54Uz7ZYoma7m8kzIx8/sH8Zt/v1ff/uW63BeM/ei5HFh8fLCpNv
         6C0RZ+0axhJRxw1pbu0Wwk1xEj3iHOxBSS0IUpvGlOJDhX99a4BSryMuaAVVRNaigVCz
         Eezn91YMhIcU+BzP8pmyW2Cpxua8a69l8hJMfGFixyqsWwuCm1AYWNB+kPUmtzHc+fak
         63ETFIbHFLKullcdOwvTPZNIOwkGv8O/GjgK0UZ4M5Gg3dCujVbmnz3mHGPBMdy9JpDu
         nh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/vAlD2Uj4JArMK2xat0u8itYglD8Kk8L5ACdFaAlxqs=;
        b=TaDxHpLEGFAtJufi+MZ3eps3iZnObsp8YddXxiYgCvDkvRdrhqcFeWX+TW0BdKV6ak
         mA1xBVNJEnMDc2l6tqr/EROTJcZL/5iFnaK0e7lSiDUNHbUTP1DuydE+OCVFwd/J/g37
         6FIGVqSNijoruW+GsnhKpy/lAJ1oh6vOCe4VKlfUDBgGJAagIzKzgXF2TuPhv5CwXWk8
         Xa4sTOCgd9+cDrDbxMQS1hK1PvvZM6K/3xexqlMmi9oj4lzpTO06qFEBB+IUhcGfBOeL
         TMP2n3ReTPWyJHikH+8tZ7gOmJk3N9jhwxc4ndK6mNVHnc7S8UQFeusgq0cOeKHmzfPs
         1+Ow==
X-Gm-Message-State: AJIora/NGnygQrs9MgU4qRnwA3EJj3sX4IUbUtO0Gsq+Y6IEHvIXT0B0
        zTB2kG7snw0+PKi3cIii0G/0yw==
X-Google-Smtp-Source: AGRyM1sSBp98T6cTNyv8vujrNsns4paivHQuBGy782p0vi4eo2Asxwnq5ntBEh1AcH0145Y434mvdQ==
X-Received: by 2002:a17:90a:f003:b0:1f2:49f8:19d5 with SMTP id bt3-20020a17090af00300b001f249f819d5mr14573096pjb.28.1658750991448;
        Mon, 25 Jul 2022 05:09:51 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id r13-20020aa7962d000000b0052acb753b8bsm9325800pfg.158.2022.07.25.05.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:09:51 -0700 (PDT)
Date:   Mon, 25 Jul 2022 17:39:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev, Linux PM <linux-pm@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: WARNING: CPU: 4 PID: 326 at drivers/opp/core.c:2471
 dev_pm_opp_set_config+0x344/0x620
Message-ID: <20220725120949.fofc7chlsnrgfpvm@vireshk-i7>
References: <CA+G9fYuGFReF0Z9qj7-80eY0gz-J2C5MVpno_8NjrGSH5_RB0Q@mail.gmail.com>
 <20220725102711.p6eerjjzgeqi4blu@vireshk-i7>
 <f914f5c5-dd61-8495-b362-3043406582da@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f914f5c5-dd61-8495-b362-3043406582da@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-07-22, 14:55, Stanimir Varbanov wrote:
> Hi Viresh,
> 
> I can take a look and provide a patch to fix that.
> 
> But, is this a new warn or it is a consequence of new changes in
> opp/core.c ?

This WARN was missing earlier (by mistake) and is added now after some
redesigning. You can reproduce it on the OPP tree:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

-- 
viresh
