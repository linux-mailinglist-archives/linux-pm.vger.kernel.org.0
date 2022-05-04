Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D872519CA0
	for <lists+linux-pm@lfdr.de>; Wed,  4 May 2022 12:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343866AbiEDKP5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 May 2022 06:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347785AbiEDKPz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2022 06:15:55 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F11213F95
        for <linux-pm@vger.kernel.org>; Wed,  4 May 2022 03:12:20 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id a191so804967pge.2
        for <linux-pm@vger.kernel.org>; Wed, 04 May 2022 03:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Utg9P/l13ghb3Kr2id/A03YFjDuKpcUkBt8PNztUfmo=;
        b=wkv18/rt3CGfJ3gvggff5jhpunhjJ7iaJch64zhoHVeTJ/B3S19rn7+HCzxRSjbsiD
         uRXPvo59flO0RyfvAetSAMjZhLR3Isj91z1+pB8dOMLepdI1o0Oozy9hMVlY/eCE2A7K
         wZwwAAz12voMJOCNjPHr+fE/yzkMgipetil2XrYEw+jcQMY0VfEu/f6F4He0b1fqhkNU
         2aPixvRIFUcPxt4M+i+9vUGtJJ87Ahd5BQDx6jiREwmmW0/kHkyfAym5T2r29LE+mol0
         71UX4RSeJ+0Rz4+fL9BJcOzq4n0j4eHSjk1gOwnbm5JPFXAnMBaVSwf9CgME8fJ78CUi
         FNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Utg9P/l13ghb3Kr2id/A03YFjDuKpcUkBt8PNztUfmo=;
        b=OReO0ulq8I50nZ2v7A/C01wtItFWcWSNN1XEmT9gEntnEiaqoO2J7GwcysPP1FC7K1
         ppAhv+shRHG1iIgtUGsR8ZQis6tu0qP0uSVh80n8mkHCQspCjOhySuh7qkkX9JLFl5Vm
         wrTgSwJMeWjZnRaVrdlaqhLTP/ygMPSz1jTzg7v0G5oCXGtVXsXIGYxtxnBWb+hxfDBF
         vNSZwNEjl9SKaK5nOUdzYwPjgXVTxXlvEjgeziP8LNkFRkG9hjhWvMctBnbVwOxecHZB
         kFtMB47VEjLaRxdxrqpen/1CLAYKkDpl5lQkFbwMp3DFABiz5hW+ECHK4ScOZMlXLo27
         r+jQ==
X-Gm-Message-State: AOAM531ujfSHfrP/QHrPx7fpemvi0kqQiDL7rgum9gJG1j6jwIel84dU
        MzXSdVaDe+E+BIg9u+L9pzRiMA==
X-Google-Smtp-Source: ABdhPJz/mP96JsoLgKREu9JmuLt+1TVTRs8xIEeibornbgHkMIa2PZaKW599flYMhPBqaEQys3IUAw==
X-Received: by 2002:a63:5752:0:b0:3c2:1669:fdf with SMTP id h18-20020a635752000000b003c216690fdfmr11733888pgm.151.1651659140025;
        Wed, 04 May 2022 03:12:20 -0700 (PDT)
Received: from localhost ([122.162.207.161])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902c2c200b0015e8d4eb2d9sm7890364pla.291.2022.05.04.03.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 03:12:19 -0700 (PDT)
Date:   Wed, 4 May 2022 15:42:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH v2 2/5] opp: Add apis to retrieve opps with interconnect
 bandwidth
Message-ID: <20220504101217.t537dfnnjd2rhzkf@vireshk-i7>
References: <20220504081735.26906-1-krzysztof.kozlowski@linaro.org>
 <20220504081735.26906-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504081735.26906-3-krzysztof.kozlowski@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-05-22, 10:17, Krzysztof Kozlowski wrote:
> Add dev_pm_opp_find_bw_ceil and dev_pm_opp_find_bw_floor to retrieve opps
> based on interconnect associated with the opp and bandwidth. The index
> variable is the index of the interconnect as specified in the opp table
> in Devicetree.
> 
> Co-developed-by: Thara Gopinath <thara.gopinath@linaro.org>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/opp/core.c     | 120 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  19 +++++++
>  2 files changed, 139 insertions(+)

Applied. Thanks.

-- 
viresh
