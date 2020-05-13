Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DC31D0472
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 03:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbgEMBmn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 21:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbgEMBmm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 May 2020 21:42:42 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55F3C206B7;
        Wed, 13 May 2020 01:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589334162;
        bh=UUe8Ow1eaBCAZdT0NORukKFKzcce3xKtVcZKNHDEJfc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=H5DlGW5P9dgx82cPu99375mFApJpuS5528wGS/tB7C+vkQ8+pgq8bPeAPY09/HAIZ
         YTzDr3ALvEdj15f0kAZAkSpioDGRurgHdsJu/ktrQzXkzsZvImPTnAdi3RbAUDYdeA
         VHCtBvid7Bzc8WYg+62O5X1W7f/9kRhpDLF24UZ0=
Subject: Re: [PATCH -next] cpupower: Remove unneeded semicolon
To:     Samuel Zou <zou_wei@huawei.com>, trenn@suse.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <1588066995-71840-1-git-send-email-zou_wei@huawei.com>
 <a51e2f2b-3381-bd5d-9599-0f291520b272@kernel.org>
 <1d1333ae-6d7f-a456-567b-34852270000b@huawei.com>
 <932d9e24-43d3-4c31-1401-ffa930d96582@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <10644e99-9ac4-b7e6-334e-417a8d14c7f9@kernel.org>
Date:   Tue, 12 May 2020 19:42:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <932d9e24-43d3-4c31-1401-ffa930d96582@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/6/20 10:09 AM, shuah wrote:
> On 5/5/20 6:52 PM, Samuel Zou wrote:
>> Hi Shuah,
>>
>> I run with the below command, and get the output report.
>>
>> [local-host linux-next]# make coccicheck MODE=report 
>> M=tools/power/cpupower/utils
>>
> 
> Yes this is the command I am using as well. I don't see the errors
> you are seeing. What is the difference?
> 

I figured out what's going on. The coccinelle package from the distro
was the problem. I ended up installing coccinelle_1.0.8.deb-2_amd64.deb
from https://packages.debian.org/sid/amd64/coccinelle/download

After fixing that problem, it all works now.

I see the same errors you are seeing.

thanks,
-- Shuah
