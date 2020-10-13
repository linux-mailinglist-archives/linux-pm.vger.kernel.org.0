Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BED28CAFB
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 11:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403932AbgJMJ1v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 05:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403925AbgJMJ1u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 05:27:50 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63D8C0613D0
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 02:27:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u3so1807903pjr.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 02:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rd/697ANntAbinCBE+XFTBh3Yb4vDeQfxtM0akzIR/k=;
        b=m/5UXD4lcRpLEMfUiG9KSNlj5dV0G8BbiCfB8gGqjoB9v2S67WvaZzJgzcSdPAppRF
         fE9r10zz4wZQLGp/XCHodUrqidgm0GTT8ovTeDhqnWJGUyEgxjxWCFe2mqhYZeVl/cuw
         YyJ751pUZUmLTWsJgWkRnDkKJEa1zRw0V29vyfjWt5CtnCVO5Mf5lJjTPMyYW6KmcZQC
         8XIZG80n95NNtt9u2GuaXPF5GYb51WL14oE6sBIcv37kRVUQq9UyOWNOd1I89GvQUyXy
         F5bE8/7ECr6Su68MjRKxewSB3jAs7RkbKpvU9pb8JKwpR36taaRseewADxM7wX+g5EBN
         CJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rd/697ANntAbinCBE+XFTBh3Yb4vDeQfxtM0akzIR/k=;
        b=sNqg4lh5fF+BF1MeEq5ljGi7tqxoBzDAqZqTPojp9l/xfnSurKubUgWnk7xGhI37da
         ekr3nV14ivpcPn9VEzTXTABbUJ9PIPz0iSI0HRzrppogpK0mk74TcbcGS0pTaZpOe5dV
         wXVi++1oq4Gln+nePZYcde/yu3+/wYkoIqLefLhBBJcPpdKz0RX6Pm6qx7oExDrGUiSF
         ANJVMhznhYkKl0GcyvQ9Ck9Hac/r20CW3MesuTUCNqizXTeVhkOUt5JwN3fb704erhEb
         aNeMJfCEfFb7vo7K+tlwPmRGcgM4Ei+kLnMZkpowADn3agkgiU8goJMUVj1fyr7geQpM
         aTEg==
X-Gm-Message-State: AOAM531aP+CBR0dnai8V3lhiewFCRyBhSLJXsvK9n5aSAYUagePyeZr8
        qCI5DIDkyJ16MrZqWbonQYhyew==
X-Google-Smtp-Source: ABdhPJwnxZM1p2VpzvrmjOkCFf5R8ok7xAtyUX7o346iHgqouXKhxsEbzRCbFVK1tfiGHXKJ+oaFOA==
X-Received: by 2002:a17:902:a5c1:b029:d3:d5f6:f993 with SMTP id t1-20020a170902a5c1b02900d3d5f6f993mr27830371plq.31.1602581269817;
        Tue, 13 Oct 2020 02:27:49 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id n125sm22556109pfn.185.2020.10.13.02.27.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2020 02:27:49 -0700 (PDT)
Date:   Tue, 13 Oct 2020 14:57:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Anson Huang <anson.huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: cpufreq regression on imx6q sabresd
Message-ID: <20201013092746.ancm24mp7tu4wjve@vireshk-i7>
References: <AM6PR04MB4966C65D8439BD0B0459B6AC80040@AM6PR04MB4966.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB4966C65D8439BD0B0459B6AC80040@AM6PR04MB4966.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-10-20, 09:00, Aisheng Dong wrote:
> Hi
> 
> Cpufreq on MX6Q SDB becomes unwork since next-20200902 and this issue also exist with latest
> linux-next next-20201012.
> 
> Error log as follows:
> [    6.782395] cpu cpu0: failed to disable 852MHz OPP
> [    6.787246] cpu cpu0: failed to disable 1.2GHz OPP
> [    6.792189] cpu cpu0: failed to init cpufreq table: -61
> [    6.800234] imx6q-cpufreq: probe of imx6q-cpufreq failed with error -61
> 
> Simply back to next-20200828 version for drivers/opp can avoid this issue.
> e.g. git checkout next-20200828 drivers/opp/
> So the issue seems to be related to OPP changes.
> 
> $ git log --oneline --no-merges next-20200828..next-20201012 drivers/opp/

diff with 20200902 would have been more interesting as you said it
didn't work there either ? I had a look at it and am not sure why
would it fail this way.

I tried to look into this but I am afraid you need to dig in a bit
further to see where it is going bad.

Hint, from the error message and the return error (ENOENT), it looks
like there are no entires in the OPP table that are valid and so a
count of 0 is returned, which made OPP core return ENOENT. You need to
look into why the count is zero, while you were able to add the OPP
table.

-- 
viresh
