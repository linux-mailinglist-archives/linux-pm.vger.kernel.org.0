Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8A8EFE8C7
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2019 00:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfKOXoP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 18:44:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfKOXoP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 18:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FEky5kd3UxgQGOzkEXIPDTXEoTONlGizTLsmqA8bwWA=; b=JwLPwh/InU2pJOkVs5TtJ6ZsH
        idRgPyOqtFMmoibc0jLx+IFH72OW/aXO2IWt4E+QnNJbnJSGdA6JzWFEDd1A6rfwQca9Bp5gYbhaM
        oTxbJocQVcU9hK3XyFRtSlk5jUvyFBoGoR60Ii8Y0tdneY/touCOKtFDT9HvFt1jmz88wI/xWJ5hW
        ReoXLKYLbGwMwa2yrHSE0NlU8eXBkAz4CRRWgNCHd3d2gG7h7ohv/S8O4EWkc0+HnE7Jx9IDBrbRQ
        DnfEpsa8VQ2a+6f06zF0vSu32XEIswGCnE+hmmwcZb70FoNa2PIC1lWH7thwD0PUHX/w/IRsv4j2T
        m0+Njbz2A==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVlGA-0005PX-Re; Fri, 15 Nov 2019 23:44:14 +0000
Subject: Re: linux-next: Tree for Nov 15 (thermal:
 THERMAL_GOV_POWER_ALLOCATOR)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
References: <20191115190525.77efdf6c@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <247cd41e-a07b-adf0-4ec2-6467f0257837@infradead.org>
Date:   Fri, 15 Nov 2019 15:44:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191115190525.77efdf6c@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/15/19 12:05 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20191114:
> 

on i386:

WARNING: unmet direct dependencies detected for THERMAL_GOV_POWER_ALLOCATOR
  Depends on [n]: THERMAL [=y] && ENERGY_MODEL [=n]
  Selected by [y]:
  - THERMAL_DEFAULT_GOV_POWER_ALLOCATOR [=y] && <choice>


THERMAL_GOV_POWER_ALLOCATOR is selected by THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
even though ENERGY_MODEL is not set/enabled.


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
