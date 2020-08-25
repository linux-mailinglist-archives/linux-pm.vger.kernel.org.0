Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233C22515CC
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 11:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgHYJ4k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 05:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbgHYJ4i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 05:56:38 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FDCC061574
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 02:56:38 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id p37so6471705pgl.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3hb7xRsidzWGH04NoxVFZtbiOXINRMxpgebbkQO0YCc=;
        b=U4R63Muouiok7AW+JBenAp8hr6gyhfzcZlB3ww9XweVJjNuvqDQ6GTWQq0FuGb0KkX
         L3NmdyRCryeMVNjau4LI6FDJ0gjwptqP0aZD67ardm3AHWAVT201eWsZwpBGDDSSkdLp
         mMB3mbMU1fdaxqFghxiBb9l7dB4oqdZE1XRq1dTmhLgxNKQ4nxotDb1BmR0va7AeVxV2
         Swzf/fkfciexqX9ZftG1TM7ogadvVaWO3qBD3BsfvFrgO4Cs1bgEKIEFfrL2RbQvvSe/
         M8ldtG4Hn3PIdSQcBKNzRCqQJZkF9/EWMV4z5VUYbzC+sJ+EIJ55nqp8TesTBSnEDMpv
         s6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3hb7xRsidzWGH04NoxVFZtbiOXINRMxpgebbkQO0YCc=;
        b=pg1za4xssGDxrhFlqZOXBKtARQ9mxcX4BuiVdZlCkMHnsujHeEieajM42xqBsHv2ce
         OCFzLnDjZWlPQF/UBMT77qV8uQHOZ29acLOhh3hUxwsE9wo52zUGc2hmSOF6ArxuIqb9
         WH9Du5qhU4JI1hrjcjZEZn50RU6YrErXFvcZnDPMCLHi1XokvSKz0oUpE4/EFOgJPSvN
         TrseaqZkFJB57XdqH20Cj+SF9CvJS+v2U/kSIT+rvg22G54T3EvEHs3BFWGZqsKPb6mw
         B78YT5W048FII7xIvUiNa/xWYvbA9WZNeSRzbVi/PWQkffdybcuQEyVXq2bPZr6sXl5P
         Kdow==
X-Gm-Message-State: AOAM532cL8Q5mStjMBIlIWlQAxGWL2GsZmYucwMZYI1LGDF+zNjMupq1
        cWALMEGjUSxJpynm17i3CHk6jg==
X-Google-Smtp-Source: ABdhPJw4wFDaRSEuOFZLlCRLWe9xn1InlYQDyKa9u02LH9qgWDR8cmIscJ3bsYp85jEuyeyXyT2ilQ==
X-Received: by 2002:a62:18a:: with SMTP id 132mr6208576pfb.46.1598349396080;
        Tue, 25 Aug 2020 02:56:36 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id q5sm11538666pgi.31.2020.08.25.02.56.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2020 02:56:35 -0700 (PDT)
Date:   Tue, 25 Aug 2020 15:26:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: opp: How to use multiple opp-supported-hw versions properly?
Message-ID: <20200825095633.wzlpsxhabkfd27km@vireshk-i7>
References: <20200825074452.GA1322@gerhold.net>
 <20200825081637.opfmtccwczn6jtlo@vireshk-i7>
 <20200825085740.GA855@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825085740.GA855@gerhold.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-08-20, 10:57, Stephan Gerhold wrote:
> but it doesn't mention anything about the problem I described
> ("conflicting" ranges for one of the "sub-versions").
> 
> I have to admit that I keep getting confused with these bit masks...
> I think this is also one option I considered but actually it doesn't
> work:
> 
> Essentially you suggest to encode a version using:
> 
> static int ver(int version1, int version2) {
> 	return BIT(version1) << 16 | BIT(version2);
> }
> 
> Now let's take a look at my example again:
> 
> So for the versions I mentioned we get:
>   - ver(0, 1) = 0x10002
>   - ver(1, 0) = 0x20001
>   - ver(1, 1) = 0x20002
>   - ver(0, 0) = 0x10001 (this one should be excluded)
> 
> So to mark v0.1, v1.0 and v1.1 as supported I'd set:
>      opp-supported-hw = <(ver(0, 1) | ver(1, 0) | ver(1, 1))>;
> i.e. opp-supported-hw = <0x30003>;
> 
> Now let's say I'm running v0.0 = 0x10001. This version should not
> support the OPP. But actually 0x30003 & 0x10001 = 0x10001 != 0,
> so the OPP would consider it as supported.
> 
> I tried many different approaches, but you end up being unable to
> control subversions independently for most of them.

Okay, the binding doesn't really work well with subversions properly (as I
believed earlier), but because the implementation was simple enough and very
basic we can still work around it in your specific case. I am not sure I want to
touch the bindings at this point of time, unless they aren't workable for
someone.

This should work fine for your case I believe, with two 32 bit words.

static int ver(int version1, int version2)
{
	return BIT(version1 * 8 + version2); //Here 8 is size-of version2
}

-- 
viresh
