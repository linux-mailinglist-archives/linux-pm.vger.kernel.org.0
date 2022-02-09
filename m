Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0614AEB78
	for <lists+linux-pm@lfdr.de>; Wed,  9 Feb 2022 08:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbiBIHuh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Feb 2022 02:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbiBIHug (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Feb 2022 02:50:36 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFABC05CB89
        for <linux-pm@vger.kernel.org>; Tue,  8 Feb 2022 23:50:39 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id on2so1418556pjb.4
        for <linux-pm@vger.kernel.org>; Tue, 08 Feb 2022 23:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QqKVxwbotUmQ2gv29/Ifw62O6CKJJcLZd1ZfJrEloTs=;
        b=YrWjB/wG3IOXIY6Z8JgawTYjBigvmgVdhNxoOC6JtZGS5wUpjHQMgB8hEh4plHCPcv
         jXcTLiXf2wgz3aDWwUYjVnjMQcuvAMTQiQJNRfbXibWcRZ9Kv++RjTlx5YFTSOnHIYCI
         oNJ1TZTXbkrwPGJGBbV4w6V+55Xk5lr0LnZkfb9Eg4H5E2oWF+4BOGo+CBdd9i9Erhtw
         aTqSz8gPPgG/JPNCDBtztu0KB3Q3Lxckl1pEL0SxI8RlzGXh6Q9eqQr1MIPZ8mq7WTGj
         WLnb9xw0aaeTmQfF3tiQ7PuwYsAYMasTK/AnTWXxnNkryOLnOecnydN+r4mazZFP9SmW
         N0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QqKVxwbotUmQ2gv29/Ifw62O6CKJJcLZd1ZfJrEloTs=;
        b=MPxXxqYsYjh9M7Cc0VucyvlQh6hy05kyFTiNK+c5F/uBRKhi/m7MmW033AX7YurryR
         gbxCkcdYH7Ng+6/sHezsQPF01OoEhGXLPSED6rVaL3O2t33KVEdMG19jreBqjN7xGJM8
         RZgjAjvuhqJgjDKnnh0kAtnEPlHQjt0Vf3eW8MAtqwOvC3Ov2gvMoqv24a/A4Rmw3LvI
         xeBVdjMI8NmsjDBXsc0RsSK/9qPmNpbluY35eoyfkMmq+UwNUg280MNWtsxWRJuvXDSb
         MmW9VDDln8I0D8CXEqWIaPw0h9eR0OoAZcHJRqd4X6LjWyPLwoMY16hOhbMRqyKAJ0Pe
         cJhg==
X-Gm-Message-State: AOAM531lqp6aWY6PwFTlgTuINbl3azVXbgvdm80DI/KA2AI3MJzY6R3N
        8vFJKMeM3vRyi+Q18EQQbpfwcw==
X-Google-Smtp-Source: ABdhPJxHZmmgiaaNf2b9aVXUBOyF81jNaxOQCqlMvp4GxTrwPFzrUzWX5hCSHHRS8CqFK6TypgkHHg==
X-Received: by 2002:a17:902:9694:: with SMTP id n20mr992799plp.125.1644393038849;
        Tue, 08 Feb 2022 23:50:38 -0800 (PST)
Received: from localhost ([136.185.132.167])
        by smtp.gmail.com with ESMTPSA id p1sm19731256pfh.98.2022.02.08.23.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 23:50:38 -0800 (PST)
Date:   Wed, 9 Feb 2022 13:20:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cpufreq: Reintroduce ready() callback
Message-ID: <20220209075036.rpgzynwyjnfkbsbz@vireshk-i7>
References: <20220128032554.155132-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128032554.155132-1-bjorn.andersson@linaro.org>
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

On 27-01-22, 19:25, Bjorn Andersson wrote:
> This effectively revert '4bf8e582119e ("cpufreq: Remove ready()
> callback")' (except the Chinese translation), in order to reintroduce
> the ready callback.

I have added the Chinese translation back and applied both patches. Thanks.

-- 
viresh
