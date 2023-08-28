Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC38678AED9
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 13:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjH1L27 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 07:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjH1L2j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 07:28:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361B3B3;
        Mon, 28 Aug 2023 04:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693222117; x=1724758117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ALLFNC5QZgS5B04y67Q24R+Sg/T/d/X4TJvWok4tkn8=;
  b=MJgs/QuaG4DRZ6HS2FMRNUUzYVvSFc0Q6xD4b2XJ4Gbu5442O7YN3QRf
   X5IVXbt8s+JrPxhlZxySsmW/PcPL1ly5sa5gBBB+pH08iWboSjEvA1zGl
   x51EXnRXC0DspaO/ntalGcb9CcVaZm/KqP6t1guzStZMsfl8tY3QK7dq2
   TR1J7tMQd43he9KSEaNKASBb0QfeNJejcRJ+b8aNZE5GgELG5xIaeLuwJ
   eHLCnO92xIjA0I36ED/RS5kPpX1DxXK9u1v973eJL7zdlsyJLGV2oa/qi
   gA6VLLX//68a/RmBvWLCNQe+ogHyE8iewAXEuiRH2QNU3fyEe+TGg0cJR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="378854775"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="378854775"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 04:28:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="688072303"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="688072303"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 28 Aug 2023 04:28:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qaaQ3-00GB37-13;
        Mon, 28 Aug 2023 14:28:31 +0300
Date:   Mon, 28 Aug 2023 14:28:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: sbs-battery: Make similar OF and ID
 table
Message-ID: <ZOyE3/Y7RINxOgjy@smile.fi.intel.com>
References: <20230824162344.385151-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824162344.385151-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 24, 2023 at 05:23:44PM +0100, Biju Das wrote:
> Make similar OF and ID table to extend support for ID match
> using i2c_match_data(). Currently it works only for OF match
> tables as the field is wrong for ID match.

...

> -	chip->flags = (u32)(uintptr_t)device_get_match_data(&client->dev);
> +	chip->flags = (u32)(uintptr_t)i2c_get_match_data(client);

Why is (u32)casting still needed?
Why it was there beforehand?.. Do we have a compiler warning?

-- 
With Best Regards,
Andy Shevchenko


