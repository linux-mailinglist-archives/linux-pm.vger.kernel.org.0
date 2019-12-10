Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0961A11823F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 09:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfLJIbO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 03:31:14 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:41679 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfLJIbN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 03:31:13 -0500
Received: by mail-pj1-f54.google.com with SMTP id ca19so7107070pjb.8
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 00:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9vzH0WxIEp9QvFMa0d7x0S9qoaAVQghfrQlOKDpDVUc=;
        b=k+EKLIJOkOQ/BJNeayVZavRqMVYqZICre8BtPBOPaWUh6bKliRDM4XUmPL8T+xv8/e
         vkWpSU5doWPsy5Bu8/YKxPU4KU5kql5JSUs2qvxiqyDSrsov7Uye6qCk8O9KGbNmR+hJ
         o9cOGH0AkOzk/97+OJXPMArjgrZ3A5Q0TlskSq8RqLLsDzd4mZ5ajAZoYvrt74aPDi7s
         LNdoWgaswbSQvLFBCNtZci25NzLzI/Fy25SIMgYQqbyQdIl+UCebBRjlv5aOzhJcdHrh
         /x3RnN3xYbQuUBeUK6qM55QKgFyZCSNzbu6CtexLUJNruI3yRwozEB7aOqpZD4sggn5+
         CpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9vzH0WxIEp9QvFMa0d7x0S9qoaAVQghfrQlOKDpDVUc=;
        b=IdfxZmdH2Ly9UaWk5gJ+YjTc2K1y51avX4Bg1ASTJdoo0tI/qIbpc552+ZYKft3tyo
         KUllznOXT9z31IEKOjGaTStPWuI9zGyUc/1Ac0Xzc3UN6/mxtXQBuDIGZDS6NnZHo/J1
         2+dpEqTniBPfvLn345ql7Qi3QCL3ON/tbLXOA5Qpd4VfSJUoHlm5zYyZ3WeELyZRCslF
         YYVN5RYw3FWOC4Lf+vAA0uAf77y4AJSxwsUqOpoIJxRLZpaZOkyq50S78/Qxl14guuBb
         mHTAgJcRjr/NMKGrDI0MYhvzWEjUgDU0cQIBjowqTRMiq5pKKvJCc9IZ/KXM/c71P4yP
         eBPw==
X-Gm-Message-State: APjAAAViaDEoO12We8GUc5xBTtB5LPfCSk8fZvC3hA1IQAiwVCZpSleA
        P2mvXUKzxmL3wZfiEQHpPxFLIQ==
X-Google-Smtp-Source: APXvYqwp1xTN2+Duvw+mwnIYzIElGHKsUFByJc4y/uC5XYsmlddsF61x3NWfV0bt5wnAxK+nbYsZjw==
X-Received: by 2002:a17:902:fe12:: with SMTP id g18mr33979090plj.20.1575966673126;
        Tue, 10 Dec 2019 00:31:13 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id h5sm2355530pfk.30.2019.12.10.00.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 00:31:12 -0800 (PST)
Date:   Tue, 10 Dec 2019 14:01:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
Message-ID: <20191210083110.6zy7vdk5nfcn6cu2@vireshk-i7>
References: <DB3PR0402MB39163BEC18FF81B06D1093BBF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0j_op4vELkEQzJEuXij71p8SGSFSbo0m813W5Gq1ZdYoQ@mail.gmail.com>
 <DB3PR0402MB3916D581AFCA8D05BBED3B68F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916EF749069E53CB1C03475F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0j+L_w7G=Z4K5tuWEp11uk3ggS-1c8RqQ-Px6mk1V98Pw@mail.gmail.com>
 <0EF688DF-FD00-456C-8CE1-C4F825651275@nxp.com>
 <CAJZ5v0iKpJBs71EKL42nL4F0EFaxvbZziwUz73WS45uDYKEpdA@mail.gmail.com>
 <AM0PR04MB4481518A4F89540B3ABA56A1885B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20191210070535.bvfzigolydhyz2ix@vireshk-i7>
 <CAJZ5v0hQeZDOiQC=UT+nEOc27E7Rn0O_7tLbeO1YMinCntDFCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hQeZDOiQC=UT+nEOc27E7Rn0O_7tLbeO1YMinCntDFCQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-12-19, 09:22, Rafael J. Wysocki wrote:
> The problem is that a CPU is running a governor hook which it
> shouldn't be running at all.
> 
> The observation that dvfs_possible_from_any_cpu makes a difference
> only means that the governor hook is running on a CPU that is not
> present in the policy->cpus mask.  On the platform(s) in question this
> cannot happen as long as RCU works as expected.

I was worried about RCUs the day I saw the first email from Anson, but going
there meant more trouble and so I thought it must be something else :)

-- 
viresh
