Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89F4DCA076
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2019 16:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfJCOiz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Oct 2019 10:38:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbfJCOiz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Oct 2019 10:38:55 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 216F320865;
        Thu,  3 Oct 2019 14:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570113534;
        bh=8iDJP4OSCGobLMg+w/PIyt2SvnXlydJll5PC5aK6pUk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dAnqZUeojGD1ygRt+/5H/4Fp1IPvujZCZGWeW/f1du7O+gw9aHkP7IYvj4Q773k8r
         wfrnlkKkT9OK26gYsOMyRF6b3PBak4izJHsHWeCDvZhnLztusmCPrHp47LCwj1B0Wq
         ekNL/6a9kZKkXTY9A4yFVDnFN2nZLOEAMVY2xYac=
Subject: Re: [PATCH v2] cpupower : Handle set and info subcommands correctly
To:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trenn@suse.com, ego@linux.vnet.ibm.com, shuah <shuah@kernel.org>
References: <20190913080712.26383-1-huntbag@linux.vnet.ibm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <2614b112-5e19-96dc-179b-8d4e3b8c8858@kernel.org>
Date:   Thu, 3 Oct 2019 08:38:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913080712.26383-1-huntbag@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/13/19 2:07 AM, Abhishek Goel wrote:
> Cpupower tool has set and info options which are being used only by
> x86 machines. This patch removes support for these two subcommands
> from generic cpupower utility. Thus, these two subcommands will now be
> available only for intel.
> This removes the ambiguous error message while using set option in case
> of using non-intel systems.
> 
> Without this patch on a non-intel box:
> 
> root@ubuntu:~# cpupower info
> System does not support Intel's performance bias setting
> 
> root@ubuntu:~# cpupower set -b 10
> Error setting perf-bias value on CPU
> 
> With this patch on a non-intel box:
> 
> root@ubuntu:~# cpupower info
> Supported commands are:
>          frequency-info
>          frequency-set
>          idle-info
>          idle-set
>          monitor
>          help
> 
> Same result for set subcommand.
> 
> This patch does not affect results on a intel box.
> 
> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> Acked-by: Thomas Renninger <trenn@suse.de>
> ---
> 
> changes from v1:
> 	Instead of bailing out early in set and info commands, in V2, we
> 	are cutting out support for these two commands for non-intel
> 	systems.

thanks. I will get this in for 5.4-rc3 veru likely. Definitely in 5.4

-- Shuah
