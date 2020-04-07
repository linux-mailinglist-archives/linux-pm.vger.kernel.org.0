Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34EA91A1552
	for <lists+linux-pm@lfdr.de>; Tue,  7 Apr 2020 20:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDGSz5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Apr 2020 14:55:57 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13729 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgDGSz5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2020 14:55:57 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8cccaf0000>; Tue, 07 Apr 2020 11:55:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 07 Apr 2020 11:55:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 07 Apr 2020 11:55:56 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Apr
 2020 18:55:56 +0000
Received: from [10.24.37.103] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Apr 2020
 18:55:52 +0000
From:   sumitg <sumitg@nvidia.com>
Subject: Re: [TEGRA194_CPUFREQ Patch v2 2/3] cpufreq: Add Tegra194 cpufreq
 driver
To:     Dmitry Osipenko <digetx@gmail.com>, <rjw@rjwysocki.net>,
        <viresh.kumar@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <talho@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <mperttunen@nvidia.com>, <sumitg@nvidia.com>
References: <1586028547-14993-1-git-send-email-sumitg@nvidia.com>
 <1586028547-14993-3-git-send-email-sumitg@nvidia.com>
 <ba12496f-ac27-d4f2-dc69-d0a7e2d58679@gmail.com>
Message-ID: <9004e519-61c0-83fd-dc24-07f84c384f8a@nvidia.com>
Date:   Wed, 8 Apr 2020 00:26:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ba12496f-ac27-d4f2-dc69-d0a7e2d58679@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586285743; bh=64QyJ4TUbgO1pBh2CRY7c5Q8fJPeuJLJBdC3Q0tjXdQ=;
        h=X-PGP-Universal:From:Subject:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=n2cusTcLOgy11bAq/RqsEFwFiXE290u6N7UZltFIwxJsmttTW60QQrcP4VH9vwAET
         VPkZ6LW24GfHmyMHXwB1v7sjc46E1yW+lpfs7efhTjAqLV/1bsmj5nJfoDVFpjBQ5x
         +R8snfDT2DFJAJNm/7+GS8Vt2lX6ZZvztbHaA90WI833NlXGgR/cTgSkEy78+Y2Hlk
         PUZcIkkADtZ1lwocfkVFVjooe5LNI/WjNz1Yo9HodpfEJGqNOhzD8g1eV+4YJWqwAN
         swv0UdjlTm6iEUmKQ7IuTpnh792gt14tgEwK5LHIwQNJaDZ7Pofw+6tKpc1aisHNHg
         Fj9HnMM99t0tg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 05/04/20 7:41 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>=20
>=20
> 04.04.2020 22:29, Sumit Gupta =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
>> +static void tegra_read_counters(struct work_struct *work)
>> +{
>> +     struct read_counters_work *read_counters_work;
>> +     struct tegra_cpu_ctr *c;
>> +     u64 val;
>> +
>> +     /*
>> +      * ref_clk_counter(32 bit counter) runs on constant clk,
>> +      * pll_p(408MHz).
>=20
> Is changing PLLP rate really impossible on T194? What makes you say that
> it runs on a fixed 408MHz?
>=20
Pasting below from TRM.
Register "NVFREQ_FEEDBACK_EL1":
....
[31:0] PLLP counter: This counter counts at a fixed frequency (408 MHz).

