Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EFC1C75C6
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 18:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbgEFQJR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 12:09:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729418AbgEFQJR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 May 2020 12:09:17 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DABC0208CA;
        Wed,  6 May 2020 16:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588781357;
        bh=1qscupHndZxt4SMBAQf14PJ55mJ931+fBNwnev95onA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FY5WyzwKm79Ppmyf1fwMjiVeOi58oqBohjVvoVykFTW2EMR5n2S/TvVjp/mECfce3
         484/cdtPSZLh+Ob4tIISIbiwGWRBg3wdToi+YSalCM75ptllzwvGiEImDePasfcT9g
         8oJdu4wnxZHk1foE4Uh3t2HpuX+Un+B7XwDYNQfY=
Subject: Re: [PATCH -next] cpupower: Remove unneeded semicolon
To:     Samuel Zou <zou_wei@huawei.com>, trenn@suse.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <1588066995-71840-1-git-send-email-zou_wei@huawei.com>
 <a51e2f2b-3381-bd5d-9599-0f291520b272@kernel.org>
 <1d1333ae-6d7f-a456-567b-34852270000b@huawei.com>
From:   shuah <shuah@kernel.org>
Message-ID: <932d9e24-43d3-4c31-1401-ffa930d96582@kernel.org>
Date:   Wed, 6 May 2020 10:09:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1d1333ae-6d7f-a456-567b-34852270000b@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/5/20 6:52 PM, Samuel Zou wrote:
> Hi Shuah,
> 
> I run with the below command, and get the output report.
> 
> [local-host linux-next]# make coccicheck MODE=report 
> M=tools/power/cpupower/utils
> 

Yes this is the command I am using as well. I don't see the errors
you are seeing. What is the difference?

make coccicheck MODE=report M=tools/power/cpupower/utils

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

coccicheck failed
make: *** [Makefile:1781: coccicheck] Error 2

thanks,
-- Shuah
