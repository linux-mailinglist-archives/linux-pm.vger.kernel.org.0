Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F7075BE10
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jul 2023 07:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjGUFzD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jul 2023 01:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGUFzC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2023 01:55:02 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1620E62
        for <linux-pm@vger.kernel.org>; Thu, 20 Jul 2023 22:54:59 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b933bbd3eeso23406781fa.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Jul 2023 22:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689918898; x=1690523698;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tx9jl7D+lvBMqXnZpoQLi2KuMPWDp5XwCqZnDLqYhH4=;
        b=P+5zACJptGbFTgXVDRkqTPIryzqqm6xnTBqa144mWW3vJUlBHW3fug8z5qezx3wt1U
         dt5bYw3bEVeG/4je9TPGsRbpQ8Mhov1V8II6azJbJDnbdJDDqbSqV1XiYHWemaz56QtB
         JVxsgy0prKVQ/44GZLMv1ewSH9q1wFE0fZ+yQD0xhoM3W8VbFXUVXS1cbp68V1ss/3ii
         Sa4xYlacIbLNYCdhIwtJ4he+UdTZduqbUVMZjOI8jaSQpLdQjtVdn04uCp+mtdrAqS1e
         I+60ZNkJXtWLTaibJ9N03V4nBruOd/t2a9jvc/pRermLahFbfvPr1RLnkNeIRtKUEHrH
         tbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689918898; x=1690523698;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tx9jl7D+lvBMqXnZpoQLi2KuMPWDp5XwCqZnDLqYhH4=;
        b=AImZHQumoY9zF9iQ5SZHva/M74cbbW1nzM4xrws2lgKStO+ukoNj+4kG7ft0yD+59D
         4AVs00uSwGMK5sOpNiAkyae+La+PpBydoMIIm6MlXQpBn3ArUeQuR3d6h4XO35ogpk8f
         mRjgju3jvNuCYwc5mXnQRT5zT2w2RmFfy9eP3Yf3/kqFUVpWg+5ZWMDyfWohuFMK1X0o
         rPZma/TkDapuVEi3Xsx/ypZJLxTKpAajXStS/HdtbOU38NJRQD3ne8OA9ZMOc4fL8Znc
         dEstK1YtTRoapGcnURwl1tE38o1D5Acs2YCgIg0SiEOs/oOLIq5T2vcSuxrhVL+a53KX
         YTtQ==
X-Gm-Message-State: ABy/qLbVcl8ojFjoLWKKrEgPmPTd8ksnQsEwyutIJAf3SmXeP3Fi5n9F
        OnZ/stSo0jG6pH2Gy1X8vmCmDw==
X-Google-Smtp-Source: APBJJlEa4kryPI3nUrwB9m9RmaeAPUjTod8HmpUxn0EKJgY2ZRTgF8NnuoRZdgKFcVWrJlzcH2Xv/w==
X-Received: by 2002:a2e:9bd9:0:b0:2b7:3656:c594 with SMTP id w25-20020a2e9bd9000000b002b73656c594mr846381ljj.3.1689918898068;
        Thu, 20 Jul 2023 22:54:58 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o20-20020a5d58d4000000b0031433443265sm3170654wrf.53.2023.07.20.22.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 22:54:56 -0700 (PDT)
Date:   Fri, 21 Jul 2023 08:54:53 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v2 08/15] OPP: Introduce dev_pm_opp_get_freq_indexed() API
Message-ID: <95878fdc-6b98-4be8-84e7-6bfdbf902a9f@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720054100.9940-9-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Manivannan,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam/dt-bindings-ufs-common-add-OPP-table/20230720-134720
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230720054100.9940-9-manivannan.sadhasivam%40linaro.org
patch subject: [PATCH v2 08/15] OPP: Introduce dev_pm_opp_get_freq_indexed() API
config: i386-randconfig-m041-20230720 (https://download.01.org/0day-ci/archive/20230721/202307210431.3S4SeXVw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230721/202307210431.3S4SeXVw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202307210431.3S4SeXVw-lkp@intel.com/

New smatch warnings:
drivers/opp/core.c:213 dev_pm_opp_get_freq_indexed() warn: variable dereferenced before IS_ERR check 'opp' (see line 211)

Old smatch warnings:
drivers/opp/core.c:254 dev_pm_opp_get_required_pstate() warn: variable dereferenced before IS_ERR check 'opp' (see line 252)
drivers/opp/core.c:2458 _opp_attach_genpd() warn: passing zero to 'PTR_ERR'

vim +/opp +213 drivers/opp/core.c

a772c36cb3fb41 drivers/opp/core.c       Manivannan Sadhasivam 2023-07-20  209  unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp, u32 index)
a772c36cb3fb41 drivers/opp/core.c       Manivannan Sadhasivam 2023-07-20  210  {
a772c36cb3fb41 drivers/opp/core.c       Manivannan Sadhasivam 2023-07-20 @211  	struct opp_table *opp_table = opp->opp_table;
                                                                                                              ^^^^^^^^^^^^^^^
Dereference

a772c36cb3fb41 drivers/opp/core.c       Manivannan Sadhasivam 2023-07-20  212  
a772c36cb3fb41 drivers/opp/core.c       Manivannan Sadhasivam 2023-07-20 @213  	if (IS_ERR_OR_NULL(opp) || index >= opp_table->clk_count) {
                                                                                                   ^^^
Checked too late

a772c36cb3fb41 drivers/opp/core.c       Manivannan Sadhasivam 2023-07-20  214  		pr_err("%s: Invalid parameters\n", __func__);

This should be a dev_err(), btw.

a772c36cb3fb41 drivers/opp/core.c       Manivannan Sadhasivam 2023-07-20  215  		return 0;
a772c36cb3fb41 drivers/opp/core.c       Manivannan Sadhasivam 2023-07-20  216  	}
a772c36cb3fb41 drivers/opp/core.c       Manivannan Sadhasivam 2023-07-20  217  
a772c36cb3fb41 drivers/opp/core.c       Manivannan Sadhasivam 2023-07-20  218  	return opp->rates[index];
a772c36cb3fb41 drivers/opp/core.c       Manivannan Sadhasivam 2023-07-20  219  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

