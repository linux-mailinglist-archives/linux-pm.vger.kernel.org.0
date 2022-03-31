Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F26A4ED60B
	for <lists+linux-pm@lfdr.de>; Thu, 31 Mar 2022 10:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiCaIqo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Mar 2022 04:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbiCaIqn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2022 04:46:43 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E302B1EA5E4
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2022 01:44:56 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p17so22775162plo.9
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2022 01:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FhzVk64/NIKLiS6pp8Z+fT0Y8xwvGEYa4togIdcxYYk=;
        b=ICBYDrTFxqntrrzWD538RHzkmhMUsTzyv8yva1vHpjOl+YFBDVbFwBje833t9zn6P8
         3j7TUXzWqkE5OqOEDv+Ro7X6yWpWauix2c6xy+27ct0rU5OGE4NDrtIR6tCLFRYD7MsS
         Yl0sB0YFPzFjbS1sKuGTu3rM3FmHrSR8Wlj6IbV9KhArk049TgxIG+C45ipjmk+pI4xe
         RV085hborc+M1cMQsuS6kDLJ/NotgzoQ/d7m/lPWdvJiCdKPenouT6TjtEzT8j7iANp3
         rfcglmQqodsjwDcIhX14MvBi9Xvjym8BFG4eLTMJvgjQrYDeUT8h7hYCYP9YKA3Hucq0
         w78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FhzVk64/NIKLiS6pp8Z+fT0Y8xwvGEYa4togIdcxYYk=;
        b=Th5pQdpm8GQgl8GwzhY4X/2kBdP236sngd/kZNQpURVvHIp6EYYIDX+ORmCCC6l5v0
         An9zhSHVUePZLngwEihjeWh6H65xY1D5/2PcZNC6scS2uEz5UIM1PU7ipSDAuHgNw8K9
         ungksOU406/uH77bPF/gH/RYr5mm413YuKCR9xVisWjov1tl93XhUIw/XJHBF1rcMjZK
         v8+IA+04+6HbLoynWMs8o3FWFGxou3k6RL6VmVPGvOUEaj8D90nOHUcv8BRKqnc5zamK
         YjMr4qOV7yxtr7LVvzlhffGSD1zXuylOEckUwGZObrnObBX7RaF8pmR4Likq6qvMYZfg
         QuCg==
X-Gm-Message-State: AOAM531BL8PooscIQpjm24SASqYE4busUchcwPyK7i4rMJ+OTtRgXMLH
        9FIrq95og23V0bkJClefoIgn/Q==
X-Google-Smtp-Source: ABdhPJxEgHNxbaBHgr6g0EY3covUtA2BOdBzQiZbu1mOXIgyyHZcL0mejNKkNTKFFiawEVFB6rciJw==
X-Received: by 2002:a17:902:b692:b0:151:5474:d3ee with SMTP id c18-20020a170902b69200b001515474d3eemr40081273pls.139.1648716296426;
        Thu, 31 Mar 2022 01:44:56 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id l2-20020a056a0016c200b004f7e3181a41sm27899760pfc.98.2022.03.31.01.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 01:44:55 -0700 (PDT)
Date:   Thu, 31 Mar 2022 14:14:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] opp: use list iterator only inside the loop
Message-ID: <20220331084453.jlmuilvg3n3ve27t@vireshk-i7>
References: <20220331083018.31995-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331083018.31995-1-xiam0nd.tong@gmail.com>
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

This is V3 and not V2. You need to be careful to update them for every
single version of patch you send.

On 31-03-22, 16:30, Xiaomeng Tong wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate dedicated pointer variable [1].
> 
> In this case, use a new variable 'iter' as the list iterator, while
> use the old variable 'new_dev' as a dedicated pointer to point to the
> found entry. And BUG_ON(!new_dev);.
> 
> [1]: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> 
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
> 
> changes since v1:
>  - use BUG_ON(!new_dev); instead of return; (Viresh Kumar)
> 
> v1: https://lore.kernel.org/lkml/20220331015818.28045-1-xiam0nd.tong@gmail.com/
> 
> ---
>  drivers/opp/debugfs.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Looks good now. I will apply it in few days.

-- 
viresh
