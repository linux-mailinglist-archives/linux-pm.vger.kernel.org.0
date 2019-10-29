Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC93E8B8E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 16:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389904AbfJ2POh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 11:14:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389855AbfJ2POh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 11:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7Rjr4pHXM+BVJrcbAfxpIG5e/IL2+7ZuJT+0KbtlpEo=; b=q7CVnA3+mlAz2NGa2MLY13437
        9+5fWdJGJMEkEN+r9lez797+9scz+v2vv1ZqhSM2SpdN/yAYwMdV9Q35T23vVDkqbj70x1pmn8Y8z
        xYwnGMr6OFSUuX50v5fVxNdYpDomTsqCkrb/yncWMoKvWEpqa1+p9JvB2KeweUpUb8g4f24CmDa/b
        gz4owjOBpgE6Ti6X8OHNzuzCQG0wH7nDB5ehBSTxfkRccL8t/mrnuhhEGvenC5LBaw+BRbkatR/Hc
        bzNoin8xljIMBiKPgLWILRiy+6yqK6urBofytN4ubCuuekFhS2eSEMMV3RE0CaVF6zf7U9W+HwD46
        B7RPt43wA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPTCe-0004mx-Mv; Tue, 29 Oct 2019 15:14:36 +0000
Subject: Re: linux-next: Tree for Oct 29 (thermal/qcom/)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
References: <20191029180731.2153b90c@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1970de9b-e8cc-423a-c4a0-37a6d0357c6e@infradead.org>
Date:   Tue, 29 Oct 2019 08:14:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191029180731.2153b90c@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/29/19 12:07 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20191028:
> 

on i386:

ld: drivers/thermal/qcom/tsens-common.o: in function `tsens_mC_to_hw':
tsens-common.c:(.text+0x17d): undefined reference to `__udivdi3'

Reported-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

