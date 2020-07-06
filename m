Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DC9215C47
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jul 2020 18:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgGFQxU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 12:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbgGFQxU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2020 12:53:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF51C061755;
        Mon,  6 Jul 2020 09:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Oo71Ly+xuAZimh7lavMoiBxeE/3yERplO91ByCP9Y+8=; b=M9RmIbNRApzmeng0YWqK0FUbR/
        tzKkdk71m142i5pbP1X8Q92Et9fSd4MpzaGolinGSNbceMeTgQ1yYPgMF+DfsWGE1zqUx491sXBip
        fTeiw0Qt7EIXOQBjaKpX6CMLCyr3XLDjQZ0/sY6jWPWolFfe2Cp44yIy6hMsqY3anZ6GESieMGspE
        2IQH7QQoNLG2C19FbFO9z8QeyMbTQlKchH6nI1M8N5y5Q8CT3MshtoH8XmlAax+UevjceOqqYTU9l
        GcFtQkrU9BMDc8BDQx/ZW91SWtrgR1Ze6QJhuCJZ8I15sC8roKhrAQvUcOrK1/d37zmYuWz6l/tFI
        VHjx8KwQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsUMm-00037m-CT; Mon, 06 Jul 2020 16:53:16 +0000
Subject: Re: linux-next: Tree for Jul 6 (thermal/thermal_netlink.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
References: <20200706174001.2d316826@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b0348556-065d-f8fa-fc1d-0f084147deb5@infradead.org>
Date:   Mon, 6 Jul 2020 09:53:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200706174001.2d316826@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/6/20 12:40 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20200703:
> 

on i386 or x86_64:

when CONFIG_NET is not set/enabled:

thermal_netlink.c:(.text+0x34): undefined reference to `nla_put'
thermal_netlink.c:(.text+0x76): undefined reference to `nla_put'
thermal_netlink.c:(.text+0x87f): undefined reference to `init_net'
ld: thermal_netlink.c:(.text+0x89d): undefined reference to `netlink_broadcast'
thermal_netlink.c:(.text+0xa19): undefined reference to `__alloc_skb'
ld: thermal_netlink.c:(.text+0xa59): undefined reference to `genlmsg_put'
ld: thermal_netlink.c:(.text+0xad9): undefined reference to `init_net'
ld: thermal_netlink.c:(.text+0xade): undefined reference to `netlink_unicast'
ld: thermal_netlink.c:(.text+0xb02): undefined reference to `kfree_skb'
thermal_netlink.c:(.text+0xb7d): undefined reference to `genlmsg_put'
thermal_netlink.c:(.text+0xc29): undefined reference to `__alloc_skb'
ld: thermal_netlink.c:(.text+0xc66): undefined reference to `genlmsg_put'
ld: thermal_netlink.c:(.text+0xce1): undefined reference to `kfree_skb'
thermal_netlink.c:(.text+0xd0e): undefined reference to `__alloc_skb'
ld: thermal_netlink.c:(.text+0xd47): undefined reference to `genlmsg_put'
ld: thermal_netlink.c:(.text+0xde4): undefined reference to `kfree_skb'
thermal_netlink.c:(.text+0x1d): undefined reference to `nla_put'
thermal_netlink.c:(.text+0x494): undefined reference to `skb_trim'
thermal_netlink.c:(.init.text+0xd): undefined reference to `genl_register_family'



-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
