Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602DB2832D2
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 11:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgJEJMv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 05:12:51 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7436 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgJEJMv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 05:12:51 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7ae35c0000>; Mon, 05 Oct 2020 02:11:56 -0700
Received: from [10.26.45.122] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 5 Oct
 2020 09:12:46 +0000
Subject: Re: [Patch 1/2] cpufreq: tegra194: get consistent cpuinfo_cur_freq
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Sumit Gupta <sumitg@nvidia.com>, <rjw@rjwysocki.net>,
        <thierry.reding@gmail.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ksitaraman@nvidia.com>,
        <bbasu@nvidia.com>
References: <1600276277-7290-1-git-send-email-sumitg@nvidia.com>
 <1600276277-7290-2-git-send-email-sumitg@nvidia.com>
 <81d2517d-6581-b491-c509-832fd1c0321e@nvidia.com>
 <20201005043433.hvyjmzafazg46kvv@vireshk-i7>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <207633bf-492b-02e6-b6df-55958ba53d0e@nvidia.com>
Date:   Mon, 5 Oct 2020 10:12:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201005043433.hvyjmzafazg46kvv@vireshk-i7>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601889116; bh=MveBJCi0RfdnSMnFnZgS4ThVsWVBIHvXAj9diy4ezLQ=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=rHKK1rARjLzZYz0S0hyqJOYImD3ttsp4Eror7pFSGOS+w9MNqVXF8BY70Al8wszMr
         Z0QSeKK/+covJCCRKHz5xzz6kM1obsRPO+Cukt/eXsz4Wn2rAXU3kFXqvKbli97Ugo
         y2x4FSCa6/gNm+lreWEI/FEqQNp5Bd+PSKGajKNXfplnTu18etpOmqfCg06KYCLmD1
         0MqyAn8qTglAhkSDPaZDaA1neKIBjzBfCoO1Sar+11j8c4jhXKUWtpmy4ztbdf4dFH
         rfthXmzDMsoX4CWR+7tLrBesjf0qIjk1WF5QmqLpPBqn9Zas1n4xhKQljVZmEiMwbZ
         brWijM2nwD3kA==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 05/10/2020 05:34, Viresh Kumar wrote:
> On 17-09-20, 09:36, Jon Hunter wrote:
>> Viresh, ideally we need to include this fix for v5.9. Do you need Sumit
>> to resend with the Fixes tag or are you happy to add?
> 
> I understand that this fixes a patch which got merged recently, but I am not
> sure if anything is broken badly right now, i.e. will make the hardware work
> incorrectly.
> 
> Do we really need to get these in 5.9 ? As these are significant changes and may
> cause more bugs. Won't getting them in 5.9-stable and 5.10-rc1 be enough ?


Yes we want these in v5.9 ideally but yes we could merge to 5.9-stable
once accepted into the mainline. 		

Jon

-- 
nvpublic
