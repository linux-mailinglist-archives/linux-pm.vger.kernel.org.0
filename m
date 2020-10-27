Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771C829CC10
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 23:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506378AbgJ0WgE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 18:36:04 -0400
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:50366 "EHLO
        gproxy1-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2506363AbgJ0WgE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 18:36:04 -0400
X-Greylist: delayed 688 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2020 18:36:03 EDT
Received: from cmgw11.unifiedlayer.com (unknown [10.9.0.11])
        by gproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id A54E5AE282C06
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2020 16:24:32 -0600 (MDT)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id XXOKkbAu0dCH5XXOKkkXbX; Tue, 27 Oct 2020 16:24:32 -0600
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=YbWTGTZf c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=afefHYAZSVUA:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=j8Cu_9a8AAAA:8
 a=IoZbvd0QVz0GP0qJnMMA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=Qzt0FRFQUfIA:10:nop_sms_unsolicited a=A2jcf3dkIZPIRbEE90CI:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qLNHaShxH+BuYmX86ec/p6Gc60doNdEEhXQaMzUstV4=; b=5hCULJrjtZ5hkLqVniTdyRnP1I
        FqiJDKbAXrV5XvC9qLUPCeNUknjOCV1rr8WEmzKjH2iqztwrn5OIfaoIQT/6OLcsiU0/5aiU9d5k8
        TotIQwa+Ji+/hFrZXlB8xa0pJwCAXpKBFDePVz9BfDGYnm3lK2LwqCxonV7UxqXAxCHbYUVyIqh6R
        mFvMqEwhqYZCZBN+Ce5WSQfASI5wbtFYKgs7yNnyBa0sM2830IInnIHerVovX5T6m/B9papAwJMmj
        C1V6fKxHveV3CyCvkp/obeVYRnncrXi/Qae9KmQlgEIis6B6fb4T5/3pCyK9EEVChujYrjBEa27iD
        jo1Vsw6g==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:50372 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kXXOI-000UYu-FO; Tue, 27 Oct 2020 22:24:30 +0000
Date:   Tue, 27 Oct 2020 15:24:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        nks@flawful.org, georgi.djakov@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 1/2] opp: Allow dev_pm_opp_get_opp_table() to return
 -EPROBE_DEFER
Message-ID: <20201027222428.GA125472@roeck-us.net>
References: <24ff92dd1b0ee1b802b45698520f2937418f8094.1598260050.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24ff92dd1b0ee1b802b45698520f2937418f8094.1598260050.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kXXOI-000UYu-FO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:50372
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 5
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Trying again through different e-mail provider. My previous e-mail
got stuck in spam filters. Apologies if this is received multiple
times.

On Mon, Aug 24, 2020 at 02:39:32PM +0530, Viresh Kumar wrote:
> From: Stephan Gerhold <stephan@gerhold.net>
> 
[ ... ]
>  
>  	opp_table = dev_pm_opp_get_opp_table(dev);
> -	if (!opp_table)
> -		return ERR_PTR(-ENOMEM);
> +	if (!IS_ERR(opp_table))
> +		return opp_table;

This should have been

	if (IS_ERR(opp_table))
		return opp_table;

Guenter
