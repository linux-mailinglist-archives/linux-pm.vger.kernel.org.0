Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3559C524537
	for <lists+linux-pm@lfdr.de>; Thu, 12 May 2022 07:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350042AbiELF40 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 May 2022 01:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350037AbiELF4Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2022 01:56:25 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73342A732
        for <linux-pm@vger.kernel.org>; Wed, 11 May 2022 22:56:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q4so3905053plr.11
        for <linux-pm@vger.kernel.org>; Wed, 11 May 2022 22:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8TbQksVmr+G57PzsVH0rEsoQee+oO6pphiDzQS4fKNs=;
        b=Et5ZDVA2OBQqvGBc26GW2o3G/jN91D/132Y6NnWdk8dWE49K3ujpuH5jRaU0u5mx+W
         04aKYqJpkDQA9jCiXfHn/3/bIM8TN4e/9wpFq+Wgm/UKolotfEpNjaFKHOO8vNxVR8si
         R3lqHPEZAdz9DCjey8RqcXcqhssps418pWJ5xDVM5HZju42DLnXKtIFZzJjVuBYzP2Tw
         3h5FkFXV6XzHjVSy8bkoWGTakLHhjrEOHLtTO8te4hrXOrp2cYIA/dFealOr2cuW8J1a
         ZyMIan2/u9it2JNnOO1xnRsApoMoJiT4FC3Xe2b3uO3H+fDyR31p/z9OE1m8+xcgQ6DK
         PEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8TbQksVmr+G57PzsVH0rEsoQee+oO6pphiDzQS4fKNs=;
        b=HXK2a3YjCGh03GVAdtfAL/G61bNBIjbMS2DDZwszKdTpQ5FbbJGK1/K6Fiwt5HFM/u
         8zYWXO2wkTYC2Zj/V18n7uNL+8DeVYSLn52WNtlyZ3LoNG93+n8yCh+0yPUI+Y/pHM9+
         iVFcKHFcurPc5WhcBOmru6r3pG7BzMy/9QMBU/amzXHaA0eNV778wMy9vRH1lodyF0Pm
         gG2AALb9fwZwaPZgauOm6Cq6YygwIVUm6gRIlSyFKHCQksNB3xcE1P+kWxGv72rdX0Yz
         hSiKWM7HB8n7LcZTYPc6We+nadGmloL3n5mNmh7mZwM2KFAAHB0HKHvhihkAsexf4Kk9
         qZ3Q==
X-Gm-Message-State: AOAM530Et75gMvZVrh4txQiPQlrv+JMRyNhJdGYEFkhANFyUdLrG6Es0
        +Y8RGUbgx7Lz/J6p8xVhfRDH5w==
X-Google-Smtp-Source: ABdhPJyHTXfVyS3w1S/Ix8jtQ3sF34x3k+yC2gLaKFvIqIdaE13Ralcdg8jea3shyTEsg4gYaNWh+Q==
X-Received: by 2002:a17:902:f144:b0:15e:cd78:e36e with SMTP id d4-20020a170902f14400b0015ecd78e36emr29218181plb.144.1652334983453;
        Wed, 11 May 2022 22:56:23 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902db0400b0015e8d4eb278sm3073426plx.194.2022.05.11.22.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 22:56:22 -0700 (PDT)
Date:   Thu, 12 May 2022 11:26:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Schspa Shi <schspa@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3] cpufreq: fix race on cpufreq online
Message-ID: <20220512055620.mvl2punbdmniyrxk@vireshk-i7>
References: <20220510035259.5ep52sgahd2a6rie@vireshk-i7>
 <20220510154236.88753-1-schspa@gmail.com>
 <20220511043515.fn2gz6q3kcpdai5p@vireshk-i7>
 <CAMA88TpefB=rnqea2u1zEvNUJNE_kdj4mYito7SGCuMj-o071Q@mail.gmail.com>
 <20220511122114.wccgyur6g3qs6fps@vireshk-i7>
 <CAJZ5v0gN_yDFpvCXRXv8rN-i3TugCi-HKpBKK2z4eWU0Zm1GUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gN_yDFpvCXRXv8rN-i3TugCi-HKpBKK2z4eWU0Zm1GUg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-05-22, 14:59, Rafael J. Wysocki wrote:
> There are two things.
> 
> One is the possible race with respect to the sysfs access occurring
> during failing initialization and the other is that ->offline() or
> ->exit() can be called with or without holding the policy rwsem
> depending on the code path.
> 
> Namely, cpufreq_offline() calls them under the policy rwsem, but
> cpufreq_remove_dev() calls ->exit() outside the rwsem.  Also they are
> called outside the rwsem in cpufreq_online().

Right.

> Moreover, ->offline() and ->exit() cannot expect policy->cpus to be
> populated, because they are called when it is empty from
> cpufreq_offline().

Correct.

> So the $subject patch is correct AFAICS even though it doesn't address
> all of the above.

-- 
viresh
