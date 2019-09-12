Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF16B0C6E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 12:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbfILKQn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Sep 2019 06:16:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:40722 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730454AbfILKQn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Sep 2019 06:16:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB8ABAE53;
        Thu, 12 Sep 2019 10:16:41 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     Abhishek <huntbag@linux.vnet.ibm.com>
Cc:     shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Thomas Renninger <trenn@suse.com>
Subject: Re: [PATCH] cpupower : Handle set and info subcommands for powerpc
Date:   Thu, 12 Sep 2019 12:16:41 +0200
Message-ID: <4161437.KdBApSEpf3@skinner.arch.suse.de>
In-Reply-To: <f43715dd-219b-d3ae-58a9-f343fe745d7d@linux.vnet.ibm.com>
References: <20190911095424.49605-1-huntbag@linux.vnet.ibm.com> <3326dc53-f8a1-dd7b-5ae8-b86ef5ef8b24@kernel.org> <f43715dd-219b-d3ae-58a9-f343fe745d7d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, September 12, 2019 11:43:40 AM CEST Abhishek wrote:
> Hi Shuah,
> 
> Thanks for the review. Few comments below.

...

> Since these two options are not being used by any other architecture
> except x86, I suggest these options should not even be shown for
> other architecture. So we can do something like this in cpupower.c :
> 
> static struct cmd_struct commands[] = {
>           .............
> +#if defined (__x86_64__) || defined (__i386__)
>          { "set",        cmd_set,        1    },
>          { "info",        cmd_info,        0    },
> +#endif
>          ..............
> 
> Is this Okay?

No, I expected you to add something meaningful for Power case...

Just kidding. If this works without any side-effects in not x86 case, this 
approach seem to be the best solution for now.

Thanks.

  Thomas


