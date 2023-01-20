Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E2267509A
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jan 2023 10:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjATJUH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Jan 2023 04:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjATJUG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Jan 2023 04:20:06 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F43AD1C
        for <linux-pm@vger.kernel.org>; Fri, 20 Jan 2023 01:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674206403; x=1705742403;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=mgBVF8vlmMH39gQQ20CUHzrXMIOeXJUewES7Scoo1YM=;
  b=D0oAfgKBh+eBGFDU6umsgPvItauysxnLDsGbAU451qdzkKGofLm1RmmW
   MAWocuDigW1JjAGgWSpnvof3hCTcWs6Bjf36w8/1KE0TrSiynplwiNsqn
   RodIy85v/zMTFr5Zw8pxDsSefmF6Ca/f1qS6Qqug/6TzC6b9esj2g58OO
   m6WC9mC/aSbGZLq21UtrzaCa6HbZVAE4m08A/Qk3NOVADU7WlcCyJA7yU
   D6OhMkefuHIEn8jrsdctLPJ+HX2NkCBC1QnEqjm2amYEEHO5lAGnVaSVY
   QEp96Rt+tahuFCsGh0UZIoQ3ytta6RUrjQr8XATetEvVPdazQBC9fpaaH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="387905471"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="387905471"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 01:20:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="638099624"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="638099624"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 20 Jan 2023 01:20:03 -0800
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
        by linux.intel.com (Postfix) with ESMTP id 21BE3580BE4;
        Fri, 20 Jan 2023 01:20:01 -0800 (PST)
Message-ID: <b41d06bcfcfef27c28c0638c4050036226f01416.camel@linux.intel.com>
Subject: Re: [PATCH] tools/power turbostat: Introduce support for EMR
From:   Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, len.brown@intel.com
Date:   Fri, 20 Jan 2023 11:20:01 +0200
In-Reply-To: <0b1d39d1ad323ef815f5db133753a990375eb45d.camel@linux.intel.com>
References: <20230104142353.22871-1-rui.zhang@intel.com>
         <0b1d39d1ad323ef815f5db133753a990375eb45d.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Wed, 2023-01-11 at 18:29 +0200, Artem Bityutskiy wrote:
> Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

And today, also

Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
