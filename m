Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D969B112FF1
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 17:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfLDQZF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 11:25:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57194 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbfLDQZF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 11:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=79WN1t0LbZ5TQbPR9oZNKLb9p7e4pnnNvD8x14AleRQ=; b=OzgNVi7XFqg0NhhgPkOw69LQJ
        XfifQMK/sqoBadzbTnQe4bu633VxkhfZt3+oN2AEipuRD1wuXGsinv8v6l4YMQpx7c3BC/m+rr5v8
        W8LwBTbzSdsQ8jq5cNbAJFu3QvOYNw3BWLoETwJBEfE6VOYip1jSepdXejMeQr47/3oJtnyoOcIyT
        JxgPFx9fpz/zWq1zNdjHTVKqoQz+4748ojforLm8jrejHD2sHO4p5pi9TsnnLawNbk/oUOWEPVfGq
        CwnlCQSaBo9IyAY0NAlFioS25qcrBCeupEJ4L3bP70kv8jxdJlMa6j8DzB9cxOqe/4sq9+KuC6op3
        dU6Iu0ugA==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icXSZ-0000fR-AM; Wed, 04 Dec 2019 16:25:03 +0000
Subject: Re: linux-next: Tree for Nov 15 (thermal:
 THERMAL_GOV_POWER_ALLOCATOR)
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
References: <20191115190525.77efdf6c@canb.auug.org.au>
 <247cd41e-a07b-adf0-4ec2-6467f0257837@infradead.org>
Message-ID: <9436e207-8a65-f01b-c348-32a8a00f03d4@infradead.org>
Date:   Wed, 4 Dec 2019 08:25:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <247cd41e-a07b-adf0-4ec2-6467f0257837@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/15/19 3:44 PM, Randy Dunlap wrote:
> On 11/15/19 12:05 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20191114:
>>
> 
> on i386:
> 
> WARNING: unmet direct dependencies detected for THERMAL_GOV_POWER_ALLOCATOR
>   Depends on [n]: THERMAL [=y] && ENERGY_MODEL [=n]
>   Selected by [y]:
>   - THERMAL_DEFAULT_GOV_POWER_ALLOCATOR [=y] && <choice>
> 
> 
> THERMAL_GOV_POWER_ALLOCATOR is selected by THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
> even though ENERGY_MODEL is not set/enabled.
> 
> 

This Kconfig warning is still happening in linux-next of 20191204.

-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
