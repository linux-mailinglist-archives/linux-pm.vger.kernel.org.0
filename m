Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85059109915
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 07:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfKZGSO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 01:18:14 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:38715 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfKZGSN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 01:18:13 -0500
Received: by mail-pf1-f176.google.com with SMTP id c13so8630340pfp.5
        for <linux-pm@vger.kernel.org>; Mon, 25 Nov 2019 22:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jYKbf8t5MJmFcFLJj0YBMp2i4jSC3lqUJ+HXzAnqTRg=;
        b=BrjksMYgLIbf28KworKYAbpgmWeicMHkwEVcJWaNIuApQ8Nh6E+P2ozrZTg8q/gQRo
         H4GlHRBjD8aR7dlQb0k7lj/kOHu577eoIn7uFrGzOeUU4w/hMCvEcSVgZOAGDRCPhIUz
         tSMlMI8lMIdWv3izvDeTzHidCgH1dG8S3aBKjyI3MPPqy7fbir6anlX/pJ/IIeT+gLv1
         dit3oTqWs7HvV3NBETXXjdWe4poeXxJ5vDPQDfxiOlqIS2Csrw9cciT5Uh0lE3mNtNYV
         h+u3Mb/KpXPT6OR9D8zxEreLlfugcYr9vEuUvh/w2b7dldXl6Ltv9/JdIa4X5vx81CBh
         xkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jYKbf8t5MJmFcFLJj0YBMp2i4jSC3lqUJ+HXzAnqTRg=;
        b=rA6/mC/+fx3YKxtKRucg7GuEzHKjueFlwUxpQvkVim9wIOYe2ORaTtLQWrAAe331lc
         +Ikc77H/6sy4zNvdZ53QpregBk3Q2HFqqdUQIp8/GEBwhPuoDl/UjVGSv96gRBJhDXFs
         dUClJLRw7Lj8s0Y6SWW9LJc0oAUCgYkbIf4ujLr4TirIEBbb6EfwYbGjbeMQ+carpS1k
         CyA8NVYdJLpNG2kyLox4pm+hwt8kDJG5d7rNam9mOuFBYIXH5x49CFCx7SS30c295wzh
         Bpl75wGxEUPO9aIUfSJiSKC+YuJmatF9AxSGgZXvSnzdnDkbdLtnZvLVkB6KiZPW1UmE
         +xuQ==
X-Gm-Message-State: APjAAAVaxK5YObNRfG0/Y25AIDKWoq+hyS3vkO9rusjL6yG3VzHCqQd5
        ULLzlVBmO7MH58aV/N43WBH9JA==
X-Google-Smtp-Source: APXvYqwvCTL3s14OouWzkghX/Mp7rVzEvkTzurldGfmlL9tYuzKRd4F4YLU96mSUBWq8mS5i2iTigg==
X-Received: by 2002:aa7:920b:: with SMTP id 11mr39802393pfo.61.1574749092891;
        Mon, 25 Nov 2019 22:18:12 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id o20sm10990931pfp.16.2019.11.25.22.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 22:18:12 -0800 (PST)
Date:   Tue, 26 Nov 2019 11:48:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
Message-ID: <20191126061810.okkw3wkjmi2uvqjj@vireshk-i7>
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20191121093557.bycvdo4xyinbc5cb@vireshk-i7>
 <DB3PR0402MB39165544EDD0317095A1B72DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0geykeebX-67+h4twj+t7oTVBf7X7_UsXw0LAc+0Ap75Q@mail.gmail.com>
 <CAJZ5v0j4z9tEDCGKRc7dHqTiJ1Fq3So=ELfvR6H25UkRmKeBvg@mail.gmail.com>
 <DB3PR0402MB3916BDC24BDA1053B7ADBDCFF5490@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0g5EGWVAm4A8ynoWAPc1wJRpR6wgZqwhvbmeT4eT49EUA@mail.gmail.com>
 <DB3PR0402MB39165E40800E42C2E5635C7CF54A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB391638C66C7EB93B5156A2D2F54A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB391638C66C7EB93B5156A2D2F54A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-11-19, 09:43, Anson Huang wrote:
> Hi, Rafael
> 	I tried to print the necessary info into DRAM instead of calling pr_info
> 	directly, then issue can be reproduced easily again, when issue
> 	happened, the LOG shows the last irq_work_sync() is NOT correctly
> 	finished. Below are the log and patch I added, the test case is simply
> 	to repeat removing CPU1/CPU2/CPU3 then adding back CPU1/CPU2/CPU3.
> 	When issue happens, below log shows last round of removing CPUs,
> 	CPU1/CPU2/CPU3 irq_work_sync() all worked as expected, the work->cpu is
> 	-1, then when CPU1 was added back, the irq_work flag is pending/busy on
> 	CPU1, and issue happened:

FWIW, I tried to reproduce it on my hikey board and I couldn't even after hours
of testing :(

-- 
viresh
