Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA36131FE2
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 07:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgAGGlc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 01:41:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35677 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgAGGlc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 01:41:32 -0500
Received: by mail-pf1-f194.google.com with SMTP id i23so22684974pfo.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Jan 2020 22:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XstUhmY/YkSGwKvN4vcBunQP4Q1xbCGHu5HvS0GQt7M=;
        b=efXqnL53H3PkXbS1e1wybpPxBF6yN8o6MuSnaNRd1bmiokFeNCZjVN/EeIYnWpJ5AP
         oaIlRMN+K8ee5tDPeOEJX+Ddx0Rv8QOh+qZDOFp4cxcWDjm9Ju6qMrdi5KyCnRiNy2f5
         q/OjwwYhyvGZpWidiEk8t0mMUIGchRjpEGqLeBvbp4JviixSfpsS30mT0tBytVCpTUFK
         AVhBbAZVglzC0/v0KzdfeXPqDmASCzJNSp4lQBHWeLzAdkmG1Z9ZWeJyQQdQrtQHRIi1
         3+sZN/I04mvPAMEWptKZB2d+EBc93vFQNkhs4EVoRBeet2NPo89XTRJeEwjbj+Yqi4uG
         r0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XstUhmY/YkSGwKvN4vcBunQP4Q1xbCGHu5HvS0GQt7M=;
        b=OjwQIPpIwAfp8jkxpKtz0Ygm2whRbmaEE2jQS654KD6LkzwbAbsB3Me8fA0a1LCjS5
         Z/Fhs120BUZxe9GdsL3uhmSJF6hSQQj3UmJnjXzR7Bv3nMcnA7Af8QSK3yk+yAhoWrhG
         0Cxc7idVmnCvABgAVS4d2QJ9A59Rwe5o7Ho+9wk05bp7ARGiVwwr/EmDM5PfbB8I8Zms
         QVlSA4fBosP3uXKn4aaJhSaBHg9plFxSm10w6E2vWPZcWNEntDnLljFVZkuWTlJ8Y5lt
         wAfegK4fSEaUrAvu3imeAA9eosL+dKEWeR9Eh4qYJ1hIW3jVycqhzHaadgc7PVZL4id5
         Pmkg==
X-Gm-Message-State: APjAAAVym3KU0e/U5CTssIpEwERk4L13sE5arTyi5pO66YMqsEIwRLeG
        VXue+WZ+slMsyN+0pVDTjFsErKm9quU=
X-Google-Smtp-Source: APXvYqy+6YwckmrUe/l4OGtN1B7r1kkzFWLgWuImOvJI/fI7MvMdDKhTFGUOIE/R67rUjlk+YLmW5A==
X-Received: by 2002:a63:6ac1:: with SMTP id f184mr2154205pgc.133.1578379291561;
        Mon, 06 Jan 2020 22:41:31 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id l186sm75585493pge.31.2020.01.06.22.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 22:41:30 -0800 (PST)
Date:   Tue, 7 Jan 2020 12:11:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] opp: quiet down WARN when no valid OPPs remain
Message-ID: <20200107064128.gkeq2ejtvx4bmyhj@vireshk-i7>
References: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
 <5c2d6548aef35c690535fd8c985b980316745e91.1578077228.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c2d6548aef35c690535fd8c985b980316745e91.1578077228.git.mirq-linux@rere.qmqm.pl>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-01-20, 20:36, Michał Mirosław wrote:
> Per CPU screenful of backtraces is not really that useful. Replace
> WARN with a diagnostic discriminating common causes of empty OPP table.

But why should a platform have an OPP table in DT where none of them works for
it ? I added the warn intentionally here just for that case.

-- 
viresh
