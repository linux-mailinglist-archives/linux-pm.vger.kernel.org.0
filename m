Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888AC21F6EB
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 18:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgGNQOe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 12:14:34 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7132 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGNQOd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 12:14:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0dd9af0001>; Tue, 14 Jul 2020 09:13:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 14 Jul 2020 09:14:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 14 Jul 2020 09:14:33 -0700
Received: from [10.24.37.103] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jul
 2020 16:14:25 +0000
Subject: Re: [TEGRA194_CPUFREQ PATCH v5 1/4] dt-bindings: arm: Add t194 ccplex
 compatible and bpmp property
To:     Rob Herring <robh@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        <devicetree@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <bbasu@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <1594649209-29394-1-git-send-email-sumitg@nvidia.com>
 <1594649209-29394-2-git-send-email-sumitg@nvidia.com>
 <20200713164214.GA341271@bogus>
 <70a0a8ee-b79a-2a05-5150-2ee0faaf2730@nvidia.com>
 <CAL_JsqL1CuumdT1CZiofEZw9j+3gsir8JwSrZVfcxFxEB=bavQ@mail.gmail.com>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <ebc98e4b-1f94-e9a5-cad4-0677f4e440f7@nvidia.com>
Date:   Tue, 14 Jul 2020 21:44:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL1CuumdT1CZiofEZw9j+3gsir8JwSrZVfcxFxEB=bavQ@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594743215; bh=/P5rK0jFQFtvkIppoDEAhZsCXMc8C/ph5QwjUSI4HQ0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qnXT67KX8RhTnD9Mtxu7mrWphK73FS5l7mjJnHIsqSG9tbjQb7ko+f0DYypkxpLHm
         rpe5+GOZTFm1wUAS21fajtoShYzYPPwG/CbHvmrZS0pmGZYuq2uW3VVYlnx29Kx+YV
         10a1ykGV9l8+dfkSelN0X8dmhwh7mrC7d2IAqUfBnRvXiVHAbDmktMh3O0zoNA01dr
         LZuZufNgUIODZ2nK9n/u164NghxnC5Cj68CGIVQvPP7g3OwSIq75hWlnCU1mhdBQTs
         U+9F8+6jTUWjphsqvWEk8ThW6qOZejOUfENRPotDupikT+QIb3nuQEorKD8bmCMIza
         9ByB+YNPkASkw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


>>>
>>> The cpus.yaml binding documents what's in 'cpu' nodes, not 'cpus'
>>> node. AIUI, the latter is what you want. You should do your own schema
>>> file here.
>>>
>> Do you mean to change existing file name from 'cpus.yaml' to 'cpu.yaml'
>> and create new 'cpus.yaml' file?
>> I think it's better to incorporate the change in existing 'cpus.yaml'
>> file to keep both cpu@X and cpus node details together. Please suggest.
> 
> No, I'm suggesting you create nvidia,tegra194-ccplex.yaml.
> 
Have posted new version of only this patch with new schema file.
Please review.

Thanks,
Sumit
