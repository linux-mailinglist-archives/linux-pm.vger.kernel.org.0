Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E675E11824D
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 09:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLJIgH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 03:36:07 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:36625 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfLJIgG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 03:36:06 -0500
Received: by mail-pl1-f174.google.com with SMTP id d15so303737pll.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 00:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kdwTU3d72WfM0EV58TBfbmQwJYtAa09Umc6wkD0RZSI=;
        b=pOw3j+4QBI7ZaPzU1AjCdExb7XoysPws1A3v5RHMixN4X1KcqGJL2BQISxqpem3vxm
         ruBaiiWo1NIPsmKq3DuHg8yNlGCLPTPD4hjRCuHWb5nuMfGHv0DIaOL1soSnknwb7jmN
         CzqcZg2RQvujWNYOc312ltyTVBIbIrN8EvT1DqlVCV0SXb3zlAcveAorGoOoM6rgqssf
         CSlAHsSSqi/hhcra80f2HkLakFjMBNbM5HyxMuxvu9jB5lXFGyc7vQsfElt7FeQVdi4m
         kSA6WLO96SuUlfTak3yKin1d8gJHak7hGDFpW15tdqU70Xd20OiqD++DsACVyDBUjbRF
         LvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kdwTU3d72WfM0EV58TBfbmQwJYtAa09Umc6wkD0RZSI=;
        b=MetE5YKQpBF2IsYNK2wOdYGAb756dpBNTCSdPIl1ZDdLEomUZjHJGbhx1wCJmv9Qxz
         TWU+LQdT0j746yYrZyZtK9RLom+FL77PSD/WlyWceQK4Oejowcadq8KPLD6pdhBCzSqe
         rmwxDowmuUM9wJMCQkOe/r4HeeC18PM1nhDWf3t80BXmMwDGCFTDQ5C7b7GYnfWhNCn9
         90PSWKmw6dpe9rxo6JZAOKPa94vUcLHASNzJLxMa4ZmQppaqWaOE0ZSJ2fdhdvEt8+Fd
         7dvV3+hM3NSJaJUNpCfePUORQGTJZmaXHv10hsg1ztMZTDssjH8KZZBg7rpvhD5orbSi
         AdOA==
X-Gm-Message-State: APjAAAUd6wDaxS5N4xp/7mwDPgbmvtG5Jg1TLi1oXzjzDgDQ8JQSfp1q
        II8AZDx0glMmhnwgSJu5m9qYlA==
X-Google-Smtp-Source: APXvYqxaziUOrJkk1xL2UNNxoe7AD5JeppRrTYW1k5groyJWY4ajNhrNkj20a10d+O49AJKOsH47mA==
X-Received: by 2002:a17:90a:7bc3:: with SMTP id d3mr4251789pjl.86.1575966964652;
        Tue, 10 Dec 2019 00:36:04 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id e10sm2422468pfm.3.2019.12.10.00.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 00:36:03 -0800 (PST)
Date:   Tue, 10 Dec 2019 14:06:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
Message-ID: <20191210083601.e4rrj6kyndku5u2z@vireshk-i7>
References: <CAJZ5v0j_op4vELkEQzJEuXij71p8SGSFSbo0m813W5Gq1ZdYoQ@mail.gmail.com>
 <DB3PR0402MB3916D581AFCA8D05BBED3B68F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916EF749069E53CB1C03475F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0j+L_w7G=Z4K5tuWEp11uk3ggS-1c8RqQ-Px6mk1V98Pw@mail.gmail.com>
 <0EF688DF-FD00-456C-8CE1-C4F825651275@nxp.com>
 <CAJZ5v0iKpJBs71EKL42nL4F0EFaxvbZziwUz73WS45uDYKEpdA@mail.gmail.com>
 <AM0PR04MB4481518A4F89540B3ABA56A1885B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20191210070535.bvfzigolydhyz2ix@vireshk-i7>
 <CAJZ5v0hQeZDOiQC=UT+nEOc27E7Rn0O_7tLbeO1YMinCntDFCQ@mail.gmail.com>
 <DB3PR0402MB39164E6ACFEAE98961EB70E4F55B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39164E6ACFEAE98961EB70E4F55B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-12-19, 08:29, Anson Huang wrote:
> If I understand correctly, the governor hook ONLY be clear on the CPU being offline and
> after governor stopped, but the CPU being offline could still run into below function to help
> other CPU update the util, and it ONLY checks the cpu_of(rq)'s governor hook which is valid
> as that CPU is online.

An offline CPU should never be running this helper as its hook is cleared
followed by rcu-sync.

-- 
viresh
