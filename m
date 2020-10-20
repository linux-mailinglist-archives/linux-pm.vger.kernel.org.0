Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06311293444
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 07:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391621AbgJTF24 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 01:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391618AbgJTF24 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2020 01:28:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D38C0613CE
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 22:28:55 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 1so417418ple.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 22:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V64RutUaOwaP5aDYnM06DL8iwrCFkhKNHW2ldYIGiQU=;
        b=jwrqTIQg5vEhaej5X1jLnZdiNwefkZBXvjCSPGiJrHkvN8S9lIm701X706lYw9vT8/
         Nd3rU2BUKhdh2iLoX/X9eYH+fpwyHWRsoH+lhxzwtvoD3CJVlusj6B6JIelSrTzUfXNv
         QHi/4pzErElf8bZtdv9SVf9x0Abl0xFB2Lkyn4JScnF4IRWIeEuHUbPV5mL6o9SbMRix
         8VektMERlKZcg6yHnIncGD9yGAvpPUBGHv8Csd8Z94lHnoKKHGfTwWwN+nYws0HsXDaR
         Y3e8mE1rvyur6unfBWPM89LmuaoIT4m8K+jlqAUXNTH0xbpzXZhpkaqY3uKpdXx6Zr76
         G7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V64RutUaOwaP5aDYnM06DL8iwrCFkhKNHW2ldYIGiQU=;
        b=LTNFOpXD6ukpPEAFqGrJqYJRs7UGwEFFkX77NZaVRbkygPfUoNBIPv87nDjt3ugn8Y
         Tjyw3N5A1OBbJ/MVmvcn3RBlOeDFGsJ9gQL9H9i/GnYZAO+UTUrViH+aUmYMesKVJrJt
         GHh9tBaPvtHz21sNqe5V72N6csxr78lAZLCYskBF7xU4OiM2B7+hbQ6L1LF4ZogRpyxv
         pNRKOGaikcI1MRCcn+779XsbfC/231eB76wItetN+eZcDg6p7D7CKbNg1SIBMpxTLJ8w
         4bFvkgmiXWKoYy9rQva8VVS7gbjsMqr6r5NvXvCHnOBxJL/lV8l2UFZ6pS8XaRbWYtnV
         9SRw==
X-Gm-Message-State: AOAM530YYf+nrNGU3VdgEpDfSTxb5X0AFLtZP27Ev5Xb2P6me0K7reDM
        6NvFDHwEIQGc65wov3QyGrxQJw==
X-Google-Smtp-Source: ABdhPJwOBhGWC1kgQAgUC91RYOw+S+vXLwM4y9Gt97e90Ego3+evTcRVb3XquuNwtQgwfox2xLJQnA==
X-Received: by 2002:a17:90a:ae15:: with SMTP id t21mr1310706pjq.91.1603171735306;
        Mon, 19 Oct 2020 22:28:55 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id f15sm701964pfk.21.2020.10.19.22.28.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 22:28:54 -0700 (PDT)
Date:   Tue, 20 Oct 2020 10:58:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] opp: Don't always remove static OPPs in
 _of_add_opp_table_v1()
Message-ID: <20201020052852.bt4jx3hd4dlncwdk@vireshk-i7>
References: <2c73ab54717ef358b118ea0cfb727b1427e7730a.1602648719.git.viresh.kumar@linaro.org>
 <AM6PR04MB496659599D41F6B88036420680020@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201015043103.m6ghom52sqssh24z@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015043103.m6ghom52sqssh24z@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-10-20, 10:01, Viresh Kumar wrote:
> On 15-10-20, 02:35, Aisheng Dong wrote:
> > Hi Viresh
> > 
> > Thanks for the quick fix.
> > 
> > > From: Viresh Kumar <viresh.kumar@linaro.org>
> > > Sent: Wednesday, October 14, 2020 12:26 PM
> > > 
> > > The patch missed returning 0 early in case of success and hence the static OPPs
> > > got removed by mistake. Fix it.
> > > 
> > > Fixes: 90d46d71cce2 ("opp: Handle multiple calls for same OPP table in
> > > _of_add_opp_table_v1()")
> > > Reported-by: Aisheng Dong <aisheng.dong@nxp.com>
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > Tested-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Thanks.
> 
> Rafael: Please apply this one directly for 5.10-rc. Thanks.

Rafael: Ping.

-- 
viresh
