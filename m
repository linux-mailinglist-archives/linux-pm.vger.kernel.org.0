Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE624C108C
	for <lists+linux-pm@lfdr.de>; Wed, 23 Feb 2022 11:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbiBWKoM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Feb 2022 05:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239678AbiBWKoM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Feb 2022 05:44:12 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8837659385
        for <linux-pm@vger.kernel.org>; Wed, 23 Feb 2022 02:43:44 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id z4so19511474pgh.12
        for <linux-pm@vger.kernel.org>; Wed, 23 Feb 2022 02:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IGvEMdAq6uGqNUosozT28Sx13oRnKbJJg2Bmggp0Iuo=;
        b=dV8JCSijwVhoYmZgiZfy7ZhYRdSIfXJgJcGvazWV6mhaFYD3HUb0P2eP5FY1W88rbV
         YwELB4ykBt892tKyw7Haazj+0Fh8B0S7oElI6ltvobH/80TMooJrwPhis0vUPBQQsIK0
         KKXOatqA+iYZDkLc7/uuSfDqLfowpqPxNtvlZDIRM3VpubVbM5FXUXcNAS8l3unDkdua
         Mpuymys0M2ls/cufLrKEzjBQhIay/Cv0zfeYH2YEyHVkklYw3FOx5xcsKRfTDGrJRtJj
         ATIH9PSMd286NR6BMquc5rXW9JyCpUksvbl6xw12j6+XwnNOIF8tj9PRdiY3gfnupd3U
         u/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IGvEMdAq6uGqNUosozT28Sx13oRnKbJJg2Bmggp0Iuo=;
        b=QjUM1buJezUyOl1weOO0rE927F2KKSkCu1VP7GFHo3IwBFaQy0LpGGTK9LncweuWGC
         LXkH7SBEz0AJposS6uoZ4sV8cxpGeR6LML4NqogcxiqjWejERalREURNbGx7iLiHkQv3
         G/yNUQpNRwWlpZ0L9rxX5X8fzrJzoOtm51IFUSLU+Vxm4NJ7QSSkBI1JJRVeUaWcyPtu
         iACL1dpRDiWClp3s0B5TDGTBpefDavNOlt31HHwdJPqWiF11G1f7GrogIQ4sWHZBstDZ
         oycvOQGVO3Nob4P1v8e6M27jieNbewWKmOmK+tzRGlTqqw3IsQHm9Fzd9jB58pf2SO9N
         oKTg==
X-Gm-Message-State: AOAM531xPNoTsGVxJDqSeAjxJAUdS0ukB3ZucJ0Xi/CcYiHF9iB9uLS/
        tzyC8ek2WjTV0mtF5tIdifdjKQ==
X-Google-Smtp-Source: ABdhPJxHHjKXBblGbpfaAfawIIH4wQmKfS6nuv2kwLRgYq2us+KUr8obIecYnIMOORQLllDgIMeEow==
X-Received: by 2002:a63:4665:0:b0:374:7305:dab4 with SMTP id v37-20020a634665000000b003747305dab4mr6615300pgk.256.1645613024120;
        Wed, 23 Feb 2022 02:43:44 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id f16sm21408665pfe.52.2022.02.23.02.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 02:43:43 -0800 (PST)
Date:   Wed, 23 Feb 2022 16:13:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, rafael@kernel.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Introduce 'advanced' Energy Model in DT
Message-ID: <20220223104341.jh5hjcv6ugaexgoa@vireshk-i7>
References: <20220222140746.12293-1-lukasz.luba@arm.com>
 <467a7de4-df84-8e9e-a26a-80449ca55950@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <467a7de4-df84-8e9e-a26a-80449ca55950@linaro.org>
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

On 23-02-22, 10:52, Daniel Lezcano wrote:
> why not extend the energy model to any kind of devices?

FWIW, the OPP core supports a wide range of devices now, not just CPUs.

-- 
viresh
