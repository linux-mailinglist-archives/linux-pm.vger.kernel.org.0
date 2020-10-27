Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACF329A532
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 08:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507282AbgJ0HFp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 03:05:45 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17141 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507281AbgJ0HFo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 03:05:44 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f97c6cc0001>; Tue, 27 Oct 2020 00:05:48 -0700
Received: from [10.41.23.128] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Oct
 2020 07:05:38 +0000
Subject: Re: [PATCH v3] cpufreq: tegra194: get consistent cpuinfo_cur_freq
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rjw@rjwysocki.net>, <sudeep.holla@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bbasu@nvidia.com>,
        <ksitaraman@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <1602668171-30104-1-git-send-email-sumitg@nvidia.com>
 <c56983dc-dc45-3e8c-a67c-14d7d09464ae@nvidia.com>
 <20201027065855.ghekpybjwtaufwgy@vireshk-i7>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <e3dc2ac5-2561-dd48-5110-918a47b3a473@nvidia.com>
Date:   Tue, 27 Oct 2020 12:35:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201027065855.ghekpybjwtaufwgy@vireshk-i7>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603782348; bh=WtJy4r7svb4J2IZUnV3t+9wxR1WW37gNHcX6Awa3jIM=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=cl6cysfhaz4s59yJxqetLooytzBoR9HqHpSZuVGyPoiQOuUDeZN2w5QQQOvgs0VIQ
         9zVZ6QGS/KW9wiM7GaLx1v45VAZeEpXJKZJIJ+WUoxNhD+x6dyK3jTEhnwyPjfXKmk
         pqcw8uo5Zkuj13wAP632pxrVqPfsIIEKRUe59TdegqHjtuURz39iq12+e9KgUMk1KW
         GcNhuFtQT7t3GO7oZAgBi9+PlC7kQb7Nt2xiBkMT3aTEtmYBMI3Kzwk3yRSkAvc9o2
         MviyljpnMCjpzUugH/WuPt8Jrqr4lf630wV5EG4ho/a9nV34CFn3/ny0JzVccNhsBl
         Q16BR+95YNx4w==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thank you.

On 27/10/20 12:28 PM, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 27-10-20, 11:46, Sumit Gupta wrote:
>> Ping.
> 
> I was waiting for 5.10-rc1 to be released before I can start applying stuff for
> 5.11. Now that it is released, I will apply this.
> 
> --
> viresh
> 
