Return-Path: <linux-pm+bounces-40174-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 592CCCF1D8C
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 06:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12AEE3006AA2
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 05:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25FD324B3A;
	Mon,  5 Jan 2026 05:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jg5qh00r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B8E3233ED
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 05:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767589900; cv=none; b=GdykXug8CBEUBlUEStjjRKEuRofYHSZWbkSz1mi7LFDhq+udSJK8k5ULQvr3qdcwatJ+rZLo8Dp8B1RWRlrhTdpKhATfqFtnxc2Aa50IGlTJ/XFWD0yZk12OFgq3KOziQntozc8sSzcfboePsNVyTxOpHNPfeKMiXboA7Xt7Kns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767589900; c=relaxed/simple;
	bh=OpwEVBQDNRtISgJEuh7G3k0Ik+Wqk3qgNRyvoq2zcRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmwv/Q5oPbe1CwePu8sdBpBRAnuPmUAuVPGl6yq1RKIPuWGzNszsavNbHezmT5MnzMuxJxnQaaRdRF3A0lAEZ5LvwAmrl6VfO6aotlONr6S9QoxLosYVqu0bbloxKmeJd4XYC0mWXEyXgvdrx/WLyvCLcFd4lsxdKUR7o9ib0oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jg5qh00r; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so11233766b3a.3
        for <linux-pm@vger.kernel.org>; Sun, 04 Jan 2026 21:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767589899; x=1768194699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LWZ/m4u68vyXRJLaLbptiIZ1XzgjhjvnkPHeaxxS0Yg=;
        b=Jg5qh00rbFum0Sllqi6k6shtjeur/D8Of3ivBxD7eLGQU07y+Bi+2nlIL670GOyNaN
         m1zuIG6JOHTvtw623AeE9UNdtzJVRzyRAENtsEsGI1BLtNObl6VZElMv+cyPUGuo30xA
         lqef0jA9sfwhvO8/Ps5oD6xd0pCn+9Nizca5p6AClfXf9EYYxF0PtThb/HaIxpZFTspP
         7b48YDKcQXw9qS5hIh9zC1FwJcBSiZC+a18EYZo6dCPCrH0wGbWMMZQe8tJlm9Kdbt33
         JUvUyARbLTAxboiO4Ocxef4cA8RNflwpBjFU4usrSqmYJRQdjkRuFCuwymHG02F7YwV7
         GkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767589899; x=1768194699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWZ/m4u68vyXRJLaLbptiIZ1XzgjhjvnkPHeaxxS0Yg=;
        b=ujW+x3SRme5oKm2Q2DuuvEebJsOF8HUinpeKaTbIjqymThaKrhWe/GHLlVRPexxwis
         lhFYC14qC40C36G0K4jxXkpTdIYQxNHrKur1A2Wm0wgiiKZuQdx6LXrx5xMWA0xHLREZ
         uIMZOZBgaSjzEN5NovlduW16RZzbGljX22XhCdpZS4gqMkY9lapkwypCuT+up994uEg8
         DAsuQkg0XS37komNW4KXdoykrrPyWstH85YhU6WZ7rMy4dFmUKTMrg1J6X+2MetfVI0g
         z3r7i4KgP0wn7kDogfib93lrKtnLJNYmvulTIo3tVXXCvliIiP5ZsiRU/ecA/i/5k3n6
         Uw6g==
X-Forwarded-Encrypted: i=1; AJvYcCXfguuNlYtOJmXnOmo110cjCfrIjOQxxdhd/7wnQvTxNr6PH6RhFVRa15ekUJmNKRnzA56zBN/KgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZl1BO1aCdce6PamctwX53quArAd+ZUA3qU0DbjZsmbP16AFkC
	LFwtSyCW+rR18RFVt1PJ+ie6D5YKB/DPDjyuWY9kEAUjnL7d/syD5rRzUS/2w0x+ahk=
X-Gm-Gg: AY/fxX4jQLUsLsq9NIUaj5klvZ5jNsfjIWplKmBb3hLL1iKv3sfy0lQ6GdIybShrzCa
	9MB6EVWUJ5aztHKEBmH71WGGGq68DpCr/nVBwf55H/wl/pUPRUGTAb8s/z8zZ5vQ+hyKsgx3Dqq
	2SYnR6ssU+YMv6IVOFUN98SD+JBxg+PNL3xWXZTFRoFD8575G2u6LHXBry2bZgTPB5E2ehCaLtf
	U5ygKpg4ugU7yxL4Ama5wOFD9Fmja510pstRfPo2zKOtKa6+z+Utg+MAZ3F6xw3lu0hZQXCfJVA
	Y9G9CNQtea0FWuE0/5jWNshg8riV5grc1bp9mGA5yRtfo0k+xVrPyjYfi1yb3x9PBHUR+8R8ndS
	HU3wqq4iWqtavf3lNV9N5oiKf7SD0GDrD1Mt+0zG++k1IvuodYvYM5HfLPQu03UbX6qUtWCgkvA
	11Wev06pwvKfE=
X-Google-Smtp-Source: AGHT+IH3EFOXcx5YW0QGZUwERYhhwYwUNENWipE2AjLQ9KRbIiA1XsmbUTltIqJf8c4vPxsgz0Vf5Q==
X-Received: by 2002:a05:6a00:ac08:b0:7e8:4587:e8c7 with SMTP id d2e1a72fcca58-7ff664806cdmr36488169b3a.58.1767589898545;
        Sun, 04 Jan 2026 21:11:38 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e0a2e3esm46227184b3a.37.2026.01.04.21.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 21:11:37 -0800 (PST)
Date: Mon, 5 Jan 2026 10:41:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OPP: of: Simplify with scoped for each OF child loop
Message-ID: <mseepzvfqeyaj6kr566gy64ciggetdt2bcu4seh6nc5jkrkegw@plfzuinpgx3w>
References: <20260102124913.64606-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102124913.64606-2-krzysztof.kozlowski@oss.qualcomm.com>

On 02-01-26, 13:49, Krzysztof Kozlowski wrote:
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/opp/of.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 1e0d0adb18e1..a268c2b250c0 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -956,7 +956,6 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  /* Initializes OPP tables based on new bindings */
>  static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
>  {
> -	struct device_node *np;
>  	int ret, count = 0;
>  	struct dev_pm_opp *opp;
>  
> @@ -971,13 +970,12 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
>  	}
>  
>  	/* We have opp-table node now, iterate over it and add OPPs */
> -	for_each_available_child_of_node(opp_table->np, np) {
> +	for_each_available_child_of_node_scoped(opp_table->np, np) {
>  		opp = _opp_add_static_v2(opp_table, dev, np);
>  		if (IS_ERR(opp)) {
>  			ret = PTR_ERR(opp);
>  			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
>  				ret);
> -			of_node_put(np);
>  			goto remove_static_opp;
>  		} else if (opp) {
>  			count++;

Applied. Thanks.

-- 
viresh

