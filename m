Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E305D68CE10
	for <lists+linux-pm@lfdr.de>; Tue,  7 Feb 2023 05:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjBGEPX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Feb 2023 23:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjBGEPS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2023 23:15:18 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0AF3525D
        for <linux-pm@vger.kernel.org>; Mon,  6 Feb 2023 20:15:16 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso711566pju.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2023 20:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OuzFX3QClT0cgHFkVJpN63xKVFqWgVKjkLO80TI1u6E=;
        b=T1I34N7FeZezC00Co2Ev65+CBbGAL//mqs5yrTfsIgGkm94BSqAyCLiF6kxYZbHmSv
         8wnrtuVoMAR89Du8ShqKPjtvzQL03mTqbvW/rP75KsUxfzhTuaQu7jSAyJyThMxn9UwZ
         /PGyGFV9Yuf8lHNXDwKMIP++3OVQj4dWkUEjGZ28WPC2ygXsFGoCEnHtNw6CwAdogIJj
         jFMTd/mY/FiqWBbjicnORQk5vzr0/zzVtK/eUVZJ8OGr+KZQy9fuDjPxQxIGxSs7UWkO
         RLV2Bn3tGVuYbq3LjL3Bs/5fC0zUkcrAL6E41aDBgpOhfvuaULBCJOgoFJj/EIG7Fvvb
         SPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuzFX3QClT0cgHFkVJpN63xKVFqWgVKjkLO80TI1u6E=;
        b=55LP1zWu21ORda9xe8RTqud+1ryqr6/HxsEMbPjZzyXKOcSaJq5+zoXsQ48x6tr2n1
         EJLZZiOsLVvOrUIknJtiV+rduMCgkqJwH5oa9QQOR3+BLI20WKKRvDUeeTtsCT24heG1
         wBNMlKmtP5HlylvoQnGb9+LeVwle2u4H7s56WF9+ETrAQ8xoeNbr9xPvBo3ALoOijhjM
         b4fpYX2/HnEz+6lsyq63aRfVHD+tmW2Pig/C1rycRIUOD3mW5EHhzhodkz0DB1EEl1wo
         5TjMp2ZyP1VPmiyb3cwTErB6kcu+4EVk7+tC3c5yiPJGcY1FgXpVc4Hzo1RBLtrpkqcX
         KzJQ==
X-Gm-Message-State: AO0yUKWyt4xXKZ8QT8pvOr9Oh3d7jr9iR2S5T7TQH4aMFa5vfg7q6JZR
        Y5Th7ZbpALilssJ0ZNnKcsloOw==
X-Google-Smtp-Source: AK7set9ciXhDCMZkykgPEO4CCITs6Emh/6AddwMq1SkdRa5BbV92+7D5Og7Wi/h5YGkVorM5U+y0Fw==
X-Received: by 2002:a17:903:189:b0:196:3bbb:e9e3 with SMTP id z9-20020a170903018900b001963bbbe9e3mr1664498plg.28.1675743315652;
        Mon, 06 Feb 2023 20:15:15 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id jc5-20020a17090325c500b00194afb5a3ebsm3956615plb.21.2023.02.06.20.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 20:15:14 -0800 (PST)
Date:   Tue, 7 Feb 2023 09:45:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/4] cpufreq: qcom-nvmem: reuse socinfo SMEM item struct
Message-ID: <20230207041512.rxeeg52wduxsfgk7@vireshk-i7>
References: <20230121112947.53433-1-robimarko@gmail.com>
 <20230121112947.53433-2-robimarko@gmail.com>
 <20230206203816.afexndkiqhpk6e7b@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206203816.afexndkiqhpk6e7b@ripper>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-02-23, 12:38, Bjorn Andersson wrote:
> On Sat, Jan 21, 2023 at 12:29:45PM +0100, Robert Marko wrote:
> > Now that socinfo SMEM item struct and defines have been moved to a header
> > so we can utilize that instead.
> > 
> > Now the SMEM value can be accesed directly, there is no need for defining
> > the ID for the SMEM request as well.
> > 
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> @Rafael, @Viresh, would you mind providing an Ack for me to take these 3
> patches, together with patch 1, through the Qualcomm tree? I have staged
> changes for 6.3, so we'll otherwise end up with conflicts on the move of
> the struct.

For all cpufreq patches.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
