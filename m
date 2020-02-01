Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEB6214F8CA
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2020 17:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgBAQR3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Feb 2020 11:17:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgBAQR3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Feb 2020 11:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3vjyCuUd1rcmzpTApqXqaXmSINLqolKaqvd7qWnbCoE=; b=qKo32vC7xT+ajMvJr90kXxOnr
        P9jW40jsDsk/9gtBmrJ5fouEoeMDxeU9MSQ7wpXQacSBpIiQiqhGSyVYOujAiTaYVpWIs/MqRNML4
        HoHoiZEP+1InsKeqB/ExovSvnze8u7PsUNGjHIdNyio+2NG681NdOBcC4tbkJ9uxFmAODelVeKL7h
        hTvlGA2s1msG2+tHAtpm43q4FsDJ+9Rn30zsmvp9egf/tgnPlJdEhySLAb7H1zvxgY+b/d2hmAAkh
        wLg02nyW8Z2B/oXR0iLnpeOBFvMpTgURrBpW5nbUF2ViGnGKVprdr3JlKnILqrGBpCFkvpQOiPBvX
        ok1r3U9Pg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixvSa-0002Ib-SE; Sat, 01 Feb 2020 16:17:28 +0000
Subject: Re: [PATCH] Documentation: Fix build error for cpu-idle-cooling.rst
 and client.rst
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Vinod Koul <vkoul@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200201062521.7296-1-changbin.du@gmail.com>
 <6d6bfd1d-dd22-8999-fc73-3cf12dbb3a98@infradead.org>
 <20200201125914.lpejzlgxazuu4i6f@mail.google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4ca88e39-7dcd-1709-96cc-4fb324715835@infradead.org>
Date:   Sat, 1 Feb 2020 08:17:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200201125914.lpejzlgxazuu4i6f@mail.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/1/20 4:59 AM, Changbin Du wrote:
> Hi,
> On Fri, Jan 31, 2020 at 10:33:30PM -0800, Randy Dunlap wrote:
>> On 1/31/20 10:25 PM, Changbin Du wrote:
>>> This fixed some errors and warnings in cpu-idle-cooling.rst and client.rst.
>>>
>>> Sphinx parallel build error:
>>> docutils.utils.SystemMessage: ...Documentation/driver-api/thermal/cpu-idle-cooling.rst:96: (SEVERE/4) Unexpected section title.
>>>
>>> Sphinx parallel build error:
>>> docutils.utils.SystemMessage: ...Documentation/driver-api/dmaengine/client.rst:155: (SEVERE/4) Unexpected section title.
>>>
>>> Signed-off-by: Changbin Du <changbin.du@gmail.com>
>>
>> Hi,
>> This commit has been merged:
>> commit fe27f13d677ccd826386094df6977cfbc13ccf5e
>> Author: Randy Dunlap <rdunlap@infradead.org>
>> Date:   Mon Jan 20 14:33:16 2020 -0800
>>
>>     Documentation: cpu-idle-cooling: fix a SEVERE docs build failure
>>
>> Feel free to send patches against current Linus git tree.
>>
> Seems it is not in Linus's tree yet. But is it in Jonathan's tree now? I could
> rebase to the doc tree instead.
> 
>> Thanks.

Hm, now I am confused.  I cannot find it at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/

but in my local clone of that git tree, I can do
$ git show fe27f13d677ccd826386094df6977cfbc13ccf5e
and see it.


-- 
~Randy

