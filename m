Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFC4727D21
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jun 2023 12:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjFHKpq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jun 2023 06:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbjFHKpp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2023 06:45:45 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54412710
        for <linux-pm@vger.kernel.org>; Thu,  8 Jun 2023 03:45:43 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-655fce0f354so223461b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jun 2023 03:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686221143; x=1688813143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rUyy/GrqGNRxuHb6z4wBkLlQC/O2oYYKUkcrhwukrc4=;
        b=eRlfkc2n7TFxfGl8Z0Fzj64L0T4w2SUykEQ1FAf1HkZq0XDyjS3rwpby2CkqakBvtX
         iXYwMO7yS8eDQjdiEHTh8zHSD5i8oyw/6fL5vAe2IcYshU1MCcjHNTLso/9OTy87hjTU
         pOSOgGwD62rUDXB+ohYNazwHQ5DuIyHhrnXD43x6Glpq218XglL5Lt2XCndOW5akS2Db
         gE0tAGseqDNmz05Hsve/ueQumW+pq7jLDYg31IBRtEZZovl+wrS10uHWqAHV6m77G3M2
         7R1DeoCm5Qv2V349Vm6W6fm8xlPdyn5axcdPgAU6MXCY43JI7nwLNMe917X3WOm0Xrru
         Yw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686221143; x=1688813143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUyy/GrqGNRxuHb6z4wBkLlQC/O2oYYKUkcrhwukrc4=;
        b=M/w/HeRfYGERJTR8lzyEHds1zwonj/HNmf7wHsZyINxcWZoYg56AmQtlJkA+6PrS5K
         kB+4MH6byeAiVbppTLVnzFxj85S1Rf6NhkCwLxy5UQL5lHb++eViAVEbdMiVNAqQ7Dmc
         7Ec4ZGrPCFsJoyAjOLZlZaxzY9MRFDqIdvvJROTUV/o93iqF+4tY6uXfr4+piPK58nsI
         d4zgahWUa+QQDwBb1a90ERnlVBBBg4t8JqpLrJG0KuIN9YHIWjmIhXzUtwHDkTJHeydX
         OjM/Bm6Ik26Sdr4DkndSfGDfxaGnBB0ycRsINa+XYHEhnb5h9zgmdSRv1ZA52lKqWB3Q
         AImw==
X-Gm-Message-State: AC+VfDyxh+NxQXEeWw6eurGptFAGoCww6IMFkU4d/g8/Ld3UTPpNgV5C
        NaZGdCrKpo4NCQgG4Z8Re6TtPw==
X-Google-Smtp-Source: ACHHUZ4+g9lBm0jyZ+3Jf2CFgzBqBNWh8+iBo/nATUyparPSQqNxu9ZH4hyWpHoj9rAQSr4CC8Kz1Q==
X-Received: by 2002:a05:6a00:3988:b0:662:c4ca:65c2 with SMTP id fi8-20020a056a00398800b00662c4ca65c2mr2793489pfb.0.1686221143266;
        Thu, 08 Jun 2023 03:45:43 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id j1-20020aa78001000000b0064d6f4c8b05sm876301pfi.93.2023.06.08.03.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 03:45:42 -0700 (PDT)
Date:   Thu, 8 Jun 2023 16:15:40 +0530
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
Subject: Re: [PATCH 13/16] OPP: Extend dev_pm_opp_data with OPP provider
 support
Message-ID: <20230608104540.tykxtvwhoyogthw5@vireshk-i7>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
 <20230607124628.157465-14-ulf.hansson@linaro.org>
 <20230608053446.ngoxh7zo7drnr32z@vireshk-i7>
 <CAPDyKFqUWhdmctKRpQoqwZ2nsx_P2FiWvLzfm_d39QdECWoytA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqUWhdmctKRpQoqwZ2nsx_P2FiWvLzfm_d39QdECWoytA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-06-23, 11:37, Ulf Hansson wrote:
> The required opps are also different, as it's getting parsed from DT
> both for the genpd provider and the consumer. The point is, there are
> more code involved but just _set_required_opps().
> 
> For example, _set_performance_state() (which is the one that calls
> dev_pm_genpd_set_performance_state()) is designed to be used for
> required opps. Does it really make sense to rework
> _set_performance_state() so it can be used for this case too, just to
> avoid another call to dev_pm_genpd_set_performance_state() somewhere
> in the code?

What we need here, in you case, is really the required-opp thing, without the
DT parsing. The genpd will have an OPP table here, and devices (you are adding
OPP table dynamically for) shall have the genpd's OPPs as their required OPPs,
since for setting OPPs of the device, it is *required* to have OPP of the genpd
set too. Just like how it happens with DT. No special handling will be required
in dev_pm_opp_set_opp() path in this case and existing code will just work. You
just need to set the required-opp tables properly.

-- 
viresh
