Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E422925F0
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 12:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgJSKft (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 06:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbgJSKfk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 06:35:40 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0630C0613D0
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 03:35:38 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x13so5771680pgp.7
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 03:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YhPaPNCIO5FSJZBriQKSF+IuxfPwCsm7VFokt0CnL+E=;
        b=VNaztXtC8Y03B0IU8S829gdBY44ZchWuTeRdB1LhcWMuUoKYJ4sv730+fjOYo7HigF
         PVMsP3oYxJTivU/iFvXxm16VBF1W5/paFTZu23Ic/tL0PAc/jQXPi1FIh/aZLIQaqu/G
         D+rNzsUzLG2avDdDdWB+/lsZQNThb+LCAj0IBCYAAM0FolrzfHnhy8FArRvY4r5n7R34
         TDDUwyGbaRIyz0V0naM43Mc1nUDryK3YB8kRBJ6wVIhYcgYMyUe0Y0x8wEtEgrI0rJsa
         dBR1lzxjl2j1fXmiro3CjgTCLawp+07f37iC/wbGPrB6NLHocbKq8LF5xVxWMm0h8/MS
         sAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YhPaPNCIO5FSJZBriQKSF+IuxfPwCsm7VFokt0CnL+E=;
        b=Nbk6i0+Xiz1bmk+V7UQhNttAjycjd+aqZPwX2grrJ3THuFsNjq7yl6XWKGqXjWdesA
         wvb1wyi9nPhH8gmi3h/ZNBWcg+uYL5iKd+if+aklpG/KuLqmmw/sQ/m+uVJpTo5TEF5q
         VTjzFLqvawANZVeMG4Dox8ZZiZgJsFml/xlwXtUFZu6DnvdtmVSdoPMRFKHSbK6pimIE
         Jzq5Pha82mYZ0T1uUd7kz7na9uwgKUg17tFydoxa1hdN1XZ+0fVnnE4KyoeVL7eK3/fS
         cKqo9PzUss+QDsoYb0Zd1iXXZh+kiJNPVpUV0Cj1WCcgfFpEWPAgp9DCBAKLFc7ijarv
         E1aQ==
X-Gm-Message-State: AOAM530eoiMkcO6kAW09ON2MWBGL510OO8KGLOc4Gn0EUPn0pIQasx1G
        OcAmFg7aj++Sz68pUhyP484quA==
X-Google-Smtp-Source: ABdhPJy25FpvGdDGJLAa04A1rzAmyy2jzFb9NLLVt54RcvPtbPCk47gNCJTkkwRsu6zUjlFHQAsP2Q==
X-Received: by 2002:a62:7609:0:b029:152:b31e:6aed with SMTP id r9-20020a6276090000b0290152b31e6aedmr16787726pfc.10.1603103738248;
        Mon, 19 Oct 2020 03:35:38 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id a184sm5551617pfa.86.2020.10.19.03.35.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 03:35:37 -0700 (PDT)
Date:   Mon, 19 Oct 2020 16:05:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, nks@flawful.org,
        georgi.djakov@linaro.org, Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH V2 1/2] opp: Allow dev_pm_opp_get_opp_table() to return
 -EPROBE_DEFER
Message-ID: <20201019103535.ksp5ackoihamam4g@vireshk-i7>
References: <24ff92dd1b0ee1b802b45698520f2937418f8094.1598260050.git.viresh.kumar@linaro.org>
 <20201015180555.gacdzkofpibkdn2e@bogus>
 <20201016042434.org6ibdqsqbzcdww@vireshk-i7>
 <20201016060021.sotk72u4hioctg7o@bogus>
 <20201016111222.lvakbmjhlrocpogt@bogus>
 <20201019045827.kl6qnx6gidhzjkrs@vireshk-i7>
 <20201019091723.GA12087@bogus>
 <20201019092411.b3znjxebay3puq2j@vireshk-i7>
 <20201019101241.GB12908@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019101241.GB12908@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-10-20, 11:12, Sudeep Holla wrote:
> Yes it has clocks property but used by SCMI(for CPUFreq/DevFreq) and not
> by any clock provider driver. E.g. the issue you will see if "clocks"
> property is used instead of "qcom,freq-domain" on Qcom parts.

Okay, I understand. But what I still don't understand is why it fails
for you. You have a clocks property in DT for the CPU, the OPP core
tries to get it and will get deferred-probed, which will try probing
at a later point of time and it shall work then. Isn't it ?

-- 
viresh
