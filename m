Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B80E23B446
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 06:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgHDEr5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 00:47:57 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:44281 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbgHDEr5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 00:47:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U4iAlcc_1596516457;
Received: from IT-C02ZL2E9LVDL.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0U4iAlcc_1596516457)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Aug 2020 12:47:54 +0800
Subject: Re: [PATCH v3] cpufreq: CPPC: simply the code access 'highest_perf'
 value in cppc_perf_caps struct
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200701042007.13333-1-xhao@linux.alibaba.com>
 <8643d122-c069-192e-8f3a-dc18f84eed9a@linux.alibaba.com>
 <20200804043740.cde3ij2uk4xczemh@vireshk-mac-ubuntu>
From:   Xin Hao <xhao@linux.alibaba.com>
Message-ID: <5f1f469d-4920-2d57-cb7c-0fea45e837c2@linux.alibaba.com>
Date:   Tue, 4 Aug 2020 12:47:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200804043740.cde3ij2uk4xczemh@vireshk-mac-ubuntu>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks

ÔÚ 2020/8/4 ÏÂÎç12:37, Viresh Kumar Ð´µÀ:
> On 04-08-20, 10:37, Xin Hao wrote:
>> Hi everyone:
>>
>> I want to know why my patch didn't merge into upstream ?
> I have sent a pull request earlier today to Rafael and this will get
> merged in the next pull request Rafael will send to Linus.
>
