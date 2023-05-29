Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541F1714731
	for <lists+linux-pm@lfdr.de>; Mon, 29 May 2023 11:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjE2JlA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 May 2023 05:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjE2Jkx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 May 2023 05:40:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFBB106
        for <linux-pm@vger.kernel.org>; Mon, 29 May 2023 02:40:45 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b04706c85fso5341965ad.0
        for <linux-pm@vger.kernel.org>; Mon, 29 May 2023 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685353244; x=1687945244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D1scMJbm+J8SOCLBtYHV08jK5p9nUqNWylfex8fdHi4=;
        b=iV9h0aO/Fsuqo4rNWd7XwSC0Ryvt+KSIV3T9UC7f+r35Hv3NBFsA/fI65BfscuvJ+e
         qUnGeKXaZ2tUMnY0bmJPJomOGKNVN74BeDbZYIkUjszgsjA0VofdaCL9XvTJfVUesWPN
         ajvvOusig+h2yfedFa93k3ceeLTKWwZNI1sXivPr9wrCa8dY38nFqg3XBGBB2R7VBnM+
         Bm8DB9rJUxeNtGPio0GG3caDOjFbYlrZHgrXOmHv/lZ3edxSPXR5/SA66NeL5+KGw9Ga
         z4NXnXUpHVjjNjk9EvOEE49LVO084k9+nDdaCxjSX21nqzIgt8WjlCyiriQqV+csRtqd
         LssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685353244; x=1687945244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1scMJbm+J8SOCLBtYHV08jK5p9nUqNWylfex8fdHi4=;
        b=KWJdEB47NoDztWoN1HXic599ld1bIPg1byFeOKktlOTrO+apCJk587YI6Zof0fsoUC
         YNahVV/dremd2Xj8WFzDMXFHmw0UDSZsAczAz28p2ezThbwd1PuHqXC96MY9tzrbAjal
         UcnsxDYBFoCVbQmqFCKoOFzYGJ12EqpkG9PHOZCgucRwvUFwzoS4/YM7gB7+iEq5FQJg
         VpidThdXOvcxBV32G3u9VxZ+VWCJHu85ZwrpbGPl5bUpikodNL9DfYbp3JbnvxlET+gF
         OpSLjStpyMu7wHfPjBFPew1wjFlWq+5I1uES7+aVx+Cf+fWjTxiAT4CAkNDFJuM+w7Xr
         QfyQ==
X-Gm-Message-State: AC+VfDxIfLoQ7qKKn0CkIp7iwKj/rYLLr3/n93LZUDa1NetIIFUy+FFJ
        o0bpLwL8B2hZNlQHtcNhr5sDCQ==
X-Google-Smtp-Source: ACHHUZ7aCOig1EImIzb6dqvjE5ijTS1gNJGa3lDR5166QVQjaa8OalmKRFP/AV7SlRYdfe7t1oI1zA==
X-Received: by 2002:a17:903:4095:b0:1aa:ee36:40a5 with SMTP id z21-20020a170903409500b001aaee3640a5mr7957734plc.34.1685353244630;
        Mon, 29 May 2023 02:40:44 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902db1100b001a65fa33e62sm7758023plx.154.2023.05.29.02.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 02:40:44 -0700 (PDT)
Date:   Mon, 29 May 2023 15:10:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Provide a function for just setting bandwidth
Message-ID: <20230529094041.s4fj6gjliivugk3r@vireshk-i7>
References: <20230526-topic-opp_bw-v1-1-e881091363af@linaro.org>
 <20230526105320.pfnu3oxl2cm37ot7@vireshk-i7>
 <f8731d93-b335-6d9a-183c-34a652f45455@linaro.org>
 <20230529045854.gh36k5my4i35jspc@vireshk-i7>
 <cbea8bc5-5dd2-b097-964d-3494935d4f68@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbea8bc5-5dd2-b097-964d-3494935d4f68@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-05-23, 11:35, Konrad Dybcio wrote:
> I think I didn't state my intentions correctly..
> 
> The proposed function would set *just* the bandwidth through OPP,
> so it'd be essentially equal to
> 
> loop over num_paths {
> 	icc_get(...)
> 
> 	icc_set(...)
> 
> 	icc_put(...)
> }

Right, but why do you need to do it ? Why isn't this done as part of
dev_pm_opp_set_{freq|opp}() ?

> but since OPP already picked up these interconnect paths, it makes
> little sense to mess with them through raw APIs.

I am not sure if I would want to expose an API to just configure part of the
entire OPP switching mechanism. I would rather let you do that via ICC APIs,
instead of going through the OPP core. Since there is a possibility of
accidental misuse of the same here.

-- 
viresh
