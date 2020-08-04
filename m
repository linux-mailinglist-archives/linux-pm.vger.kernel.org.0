Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBAC23B4A2
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 07:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgHDFyB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 01:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgHDFyA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 01:54:00 -0400
Received: from cavan.codon.org.uk (cavan.codon.org.uk [IPv6:2a00:1098:0:80:1000:c:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEE9C06174A;
        Mon,  3 Aug 2020 22:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codon.org.uk; s=63138784; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v+OUD80o2Hw94BU/0tGHUr10niN26MvbyLk9nOFbCJ0=; b=SI4z6yBBbsYqYYwn/UOluqwgT
        7plWwyl/DxJAImKdjicCANk9aWw2PFd0oB5Nb6IR1+ukTGgfgJlP3UkNx6w0hFjRZoPNg8D4SDCvO
        fkRPHvAC180Bl2XYPAJpR2hw2geL4cPywj8RGQMxKEoPVlZMh1+D1rbj+xAyP2Hyt7mHE=;
Received: from mjg59 by cavan.codon.org.uk with local (Exim 4.89)
        (envelope-from <mjg59@cavan.codon.org.uk>)
        id 1k2ptP-0007uI-7c; Tue, 04 Aug 2020 06:53:43 +0100
Date:   Tue, 4 Aug 2020 06:53:43 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     "Yuan, Perry" <Perry.Yuan@dell.com>
Cc:     kernel test robot <lkp@intel.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "andy@infradead.org" <andy@infradead.org>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH] platform/x86:dell-laptop:Add battery charging thresholds
 and charging mode switch.
Message-ID: <20200804055343.mmkypi272sgfx6al@srcf.ucam.org>
References: <20200729065424.12851-1-Perry_Yuan@Dell.com>
 <202008011345.5O4q2hta%lkp@intel.com>
 <SJ0PR19MB45281A4375E622F69642B526844A0@SJ0PR19MB4528.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR19MB45281A4375E622F69642B526844A0@SJ0PR19MB4528.namprd19.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@cavan.codon.org.uk
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 04, 2020 at 05:46:30AM +0000, Yuan, Perry wrote:

> It is not patch issue, the kernel config needs to add  "CONFIG_ACPI_BATTERY=y"

In that case you probably want to add a dependency to ACPI_BATTERY in 
the DELL_LAPTOP Kconfig.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
