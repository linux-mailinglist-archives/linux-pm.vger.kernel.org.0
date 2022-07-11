Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D5D56D2AB
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jul 2022 03:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiGKBkX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jul 2022 21:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKBkW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jul 2022 21:40:22 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA41644E
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 18:40:21 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so6917310pjm.2
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 18:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XnfQp3ERPcXVr1SfkvpwTPOkDbA2V1JzdVQnqv1Kq0c=;
        b=DfH3oPQL71Fe6KNC7/zUETjNSjvncogdffp2osrlzSYUn60ybVRrEv6r6S03BVS0NK
         qplGNxnRuWr7w2VwTN+ILehM9FwnqbwdjGoi38WZg8yNp1CPlK8LxiLB5ud3bMsBKMZG
         4aqUbeR4TJqrSXopv0HSapGUFELXczIHcmNFWaayNuciAWiVeCJYndJJI08KJDRARiB9
         l5O5YWhqnUREz5pGDEwYfbxbJ09S0Jwq/cVI82ltJ+3BvRHBK1VLLJBTQOX0Xg0CXW3R
         QT5KBsRkQJbJzOnjQ13LVY5MluDP4sROIFWq6MkxNLZxJ0qb0LoHeofn83gJFHQrtoy/
         rYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XnfQp3ERPcXVr1SfkvpwTPOkDbA2V1JzdVQnqv1Kq0c=;
        b=j4M/vh2odTSQBBO4k1hOZFKsX8A/Q9MmD14Wo4UqfuLtlYH7uI+uUweCKU15nVUOqS
         Ys7hHpCriE9ypQ1BD6vtwbNpVU3GhAImvOGdCHbxl8vU5kyG5eyDyBzN2NTb0cdqhR7t
         arFcHD10HyIg1JK704hu6tLF4HWbOY66LzW8OjqBIqAiaU/H9YBD8QkvU2gt6T1iWzvo
         cSCmZl41EHlRrtflwdVJysFCsLyKP/18sXXztz6fnowswLpdZKW0yQkyr9tHvTuLz41/
         bYDbLpUldEbS2fLhHk6VaBfFnipX/hAOtUMJeMZR6W2juEqbLahOdk9bfkMYkR4g33op
         +E+w==
X-Gm-Message-State: AJIora8PtK1hxshxYxwqdEq4PQpJ4lZbPVYhslrTdS4UGpSmRDqdSbat
        0j5pOK9vUJBF4pe+Qtj/CNQ4qA==
X-Google-Smtp-Source: AGRyM1ubFzAa7m3tTwbWVmmRxlJPIgWuw4SnSfi8v61PLkuELiYBaErfL0WEi/gjpsvgeEnQPJuedA==
X-Received: by 2002:a17:902:d48d:b0:16b:f0a8:446c with SMTP id c13-20020a170902d48d00b0016bf0a8446cmr16131168plg.50.1657503621081;
        Sun, 10 Jul 2022 18:40:21 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id n67-20020a632746000000b003fbfe88be17sm3020302pgn.24.2022.07.10.18.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 18:40:20 -0700 (PDT)
Date:   Mon, 11 Jul 2022 07:10:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/14] cpufreq: cpufreq: export cpufreq cpu release
 and acquire
Message-ID: <20220711014018.xgflrf55bpahdvtg@vireshk-i7>
References: <20220709141940.836412-1-Perry.Yuan@amd.com>
 <20220711003934.rn2igfoxtpcsiocm@vireshk-i7>
 <DM4PR12MB5278B192484CF7B728875DD59C879@DM4PR12MB5278.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5278B192484CF7B728875DD59C879@DM4PR12MB5278.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-07-22, 01:39, Yuan, Perry wrote:
> The amd-pstate for EPP mode is under testing, I will push that patchset in a few days for reviewing.
> If this patch makes confusing, maybe I need to move this patch to coming patchset.

Yeah, it should come with users and not like this.

-- 
viresh
