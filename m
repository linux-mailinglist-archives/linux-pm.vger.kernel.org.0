Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F9F2924A9
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 11:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgJSJdh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 05:33:37 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7813 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJSJdh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 05:33:37 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8d5d640000>; Mon, 19 Oct 2020 02:33:24 -0700
Received: from [10.26.45.122] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Oct
 2020 09:33:35 +0000
Subject: Re: [PATCH V2] cpufreq: tegra186: Fix initial frequency
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200824145907.331899-1-jonathanh@nvidia.com>
 <20200825055003.qfsuktsv7cyouxei@vireshk-i7>
 <09ac354e-a55b-5300-12ae-3f24c8f8b193@nvidia.com>
 <20201016040700.wzfegk7hmabxgpff@vireshk-i7>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <9c37db70-9406-8005-3478-dc4a5e94c566@nvidia.com>
Date:   Mon, 19 Oct 2020 10:33:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016040700.wzfegk7hmabxgpff@vireshk-i7>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603100004; bh=VHebAihr/c2PZr14hnXiYRQ8vQU8fQUxo/cFXOuEh2Q=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=HeYT97qQVqeWGZlRuvP9OUi2vQMHWmf6sDJpAjzMVlda+bol8jjAc6qoVTlHXyoby
         9VbybSpJYAOCJlRAUghNqlKXJzr9/nznf5NOpjUGX/5B9mpK4opUrdVSoF6JxlwAPI
         UhCZdoUNe7l1ikkYYlPtcz5oh8R8o/tlj2qQGWTJw03rWqtPKhJtRyGFxZpBfzdzz0
         D4B7Q1cbl0x8SRKc93A3fUjHLiTZYkpAbl6G2P0EdK+w8DnPejSMqNCWVsEMd1xKwQ
         x6o3rI+FoybqTVElcjxzFY1lzHCfaGJu/C4cc2sYVgVpxx9W5WWReXPdC1bQ1W2DNM
         6ZZ/KijI1WFWQ==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 16/10/2020 05:07, Viresh Kumar wrote:
> On 15-10-20, 15:03, Jon Hunter wrote:
>> If not too late, would you mind dropping this patch for v5.10?
> 
> It is already part of Linus's master now.

OK, thanks. I will send a revert for this once rc1 is out.

Cheers
Jon

-- 
nvpublic
