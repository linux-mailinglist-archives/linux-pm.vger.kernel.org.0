Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B94637173
	for <lists+linux-pm@lfdr.de>; Thu, 24 Nov 2022 05:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiKXEXP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Nov 2022 23:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiKXEXN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2022 23:23:13 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F2E201AD
        for <linux-pm@vger.kernel.org>; Wed, 23 Nov 2022 20:23:13 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id g5so424705pjd.4
        for <linux-pm@vger.kernel.org>; Wed, 23 Nov 2022 20:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3JoSH1YCDgaMP/F1mGIVSDR6qPw72yLVkDIgQi9SMiw=;
        b=BjSUqBqCUbkyE8hAPxj+tQKSD6INDJqeD1S0GDRfr/H8GTcUbl/P8zvmAx6l7sT9+J
         cQiotQ3m2mojF2jclMczDbceWVoPbAt8nVS2M/IN8GrHhgsASPNy9VPMRydfyouk0q/d
         +Hvtun+kcWfnJ3fvWW11JwjQ1hO29UMctH+QO75BjoD3nwGleQjPggoLoXqa0G+eNhnH
         mE/9s+v4KXIURzUp2Td45HpGtXaMm30W0FC6O/8bApsUsJ7KbGMmrHYqsur/pq+Ij3w9
         BTll6si+4RhX8NCjT7MYyLwecsWlNIUYMfPeZFDfmwfxS5KWjhZbOc4IAdiGd0b3kk37
         Tkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JoSH1YCDgaMP/F1mGIVSDR6qPw72yLVkDIgQi9SMiw=;
        b=qYqtU4FXag0E0KBbpywJNAkmGPID8McrIXTyry7nEMx78XA111rPxc/nAi6jJ9wJ9J
         Ej4f29Nay4jcwWlQ8butUmZyqvPXHhjjTU/oS6NSh+q7wlPMLukYM5oxsNzq9Sjgre7b
         nW1fJVfJEgsCpGkV9q9P4x3o9dSzrWFwuayD3HRf/2e7Vqd3fBaFTKq/0HmzXpeA9yaW
         Onso+cxqOA6NOSOqtN/ZHIFs0oNISwZWWNenkw8IFhgLIIP7hIGQSIwpIols3occikuj
         dAEo/9SOsr170XqvWEOB05r8ndGm2Yke0lGAvjuxFLMEwCzlSSMt64Bcb3SYh4CD/MYK
         ZSgA==
X-Gm-Message-State: ANoB5plJF73eJTENwvMJnvCuvGRx8/byxR758DsVjmtepw+eoU7MuJ9n
        ou+nRJVL+RGcZIYSoy1SWjiOuQ==
X-Google-Smtp-Source: AA0mqf7I/dro5mQ6qdCFJlQb9B1Ycskt8D81ljs+8UpZnbhsYmfeoMWRWWr++eLjmamRk/37DP86KA==
X-Received: by 2002:a17:902:aa88:b0:188:5c0c:758a with SMTP id d8-20020a170902aa8800b001885c0c758amr12256881plr.134.1669263792490;
        Wed, 23 Nov 2022 20:23:12 -0800 (PST)
Received: from localhost ([122.172.85.60])
        by smtp.gmail.com with ESMTPSA id q23-20020aa78437000000b0057280487af1sm42247pfn.206.2022.11.23.20.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 20:23:11 -0800 (PST)
Date:   Thu, 24 Nov 2022 09:53:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: Disallow "opp-hz" property without a
 corresponding clk
Message-ID: <20221124042304.pk3rh7nfkanhlgsm@vireshk-i7>
References: <cover.1669012140.git.viresh.kumar@linaro.org>
 <c03c4f2b9d4dcc3264d1902606c6c5c464b4b043.1669012140.git.viresh.kumar@linaro.org>
 <Y3snGQet8yc7HnJK@hovoldconsulting.com>
 <20221121073817.7ollj7jeixrx5og5@vireshk-i7>
 <Y3sryFh84eK/sWKF@hovoldconsulting.com>
 <20221121083036.ppwfprrheuf7xl7c@vireshk-i7>
 <20221122132633.GB157542@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122132633.GB157542@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-11-22, 18:56, Manivannan Sadhasivam wrote:
> If there is no .set_rate() callback implemented by the clock provider, it won't
> hurt, right?

It shouldn't, I guess. Well, in that case, is the first patch even
required ? Maybe we should keep it, this makes clear that we won't
even call set_rate(), irrespective of the face that it is implemented
or not.

Also, the clk provider may not be part of this file later on, for
other SoC versions, and it is better in that case too.

-- 
viresh
