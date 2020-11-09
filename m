Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EE52AC0D4
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 17:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgKIQZ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 11:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729969AbgKIQZ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 11:25:27 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C20C0613CF;
        Mon,  9 Nov 2020 08:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=wzRgTcUvS7Xb39Yh1ZY2J/F8xWwcnJRnrJngL/VyuZ0=; b=GD0T5AVu66DNgy7teJekwC/c2/
        kCIR8jK7R00uX/Sb5TFwYdvR5LHuiCAypSNMfUVsOZArHjKxJXLBcvH9Vx6SR86Nsp48rWT8PqdEF
        Wp9NXn770CJoL7bA63mXcueErG7Z9TSjdz9L8yFta2mPgWFLlZ2mT/j/2etzwJdsF4zgMKUCebtFN
        O7kjDQtkzdKT/Syky9qBqIZ7MswZ4+Bnum5lpwWK7a/WeCRgKqYJqqdbljVM2Xb9uvmaEpbSTUcG1
        g/D8s9lA60heW1QZQ+me2eXfgAucHRb5CPPIrk28kKK4lCDNVH3GGT56XtwjLumC7QfNlHw8vE/ET
        F5+CSn4A==;
Received: from [2601:1c0:6280:3f0::662d]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc9ym-000234-7V; Mon, 09 Nov 2020 16:25:17 +0000
Subject: Re: linux-next: Tree for Nov 9 (intel_pch_thermal.o)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>
References: <20201109181725.37498b25@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5201026d-79e0-54fd-8394-db0b4e5ad69f@infradead.org>
Date:   Mon, 9 Nov 2020 08:25:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201109181725.37498b25@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/8/20 11:17 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20201106:
> 

on i386 or x86_64:

# CONFIG_ACPI is not set

../drivers/thermal/intel/intel_pch_thermal.c: In function ‘pch_wpt_suspend’:
../drivers/thermal/intel/intel_pch_thermal.c:216:8: error: ‘acpi_gbl_FADT’ undeclared (first use in this function); did you mean ‘acpi_get_type’?
  if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
        ^~~~~~~~~~~~~


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
