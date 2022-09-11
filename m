Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4965B4C95
	for <lists+linux-pm@lfdr.de>; Sun, 11 Sep 2022 10:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiIKIPO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Sep 2022 04:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiIKIPN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Sep 2022 04:15:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197E11902A
        for <linux-pm@vger.kernel.org>; Sun, 11 Sep 2022 01:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662884112; x=1694420112;
  h=message-id:subject:from:to:date:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Zbv0jlucEbxajaB+DcUHeAN2D0pgDBbPtK4CTjqh6IM=;
  b=D0aCrUzVwQiBjMo41MtT2oPdTNAYxxeSsfyE3oEOvkrkngiSci2fPntZ
   DNmfIi/n5H09FUbsjMTJlHob5hbb6X3CU39Zb9WnbPHyMU/iO9/JxUxLu
   Xnhr97SP+1RF2eVlou9VntJxXXJuSovXxmsbGzkE5/H62CtpUSANAAlSs
   7m7T19RVjEhlIk9yBaSBtHGHjzQXJCGuMiJubMQOc040kvM5NoR3PTRhc
   xZZDIR8xUmjwhsjCUvXIWyQDznFkOz/RcH8wAYp7yIB2BWbT6tQYSHyeJ
   09/qvm/zwWMYmcQzTO9FTTjMKkSangQa212DzAu5OIlm8EWpDPvz5hTE4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="323929360"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="323929360"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 01:15:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="646073738"
Received: from mohdrosm-mobl.gar.corp.intel.com ([10.214.175.112])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 01:15:08 -0700
Message-ID: <87b82371d2a209dda3d63f57a3cc259783577616.camel@intel.com>
Subject: Re: Is Tigerlake Missing From intel_idle?
From:   Zhang Rui <rui.zhang@intel.com>
To:     Xhivat Hoxhiq <xhivo97@gmail.com>, linux-pm@vger.kernel.org
Date:   Sun, 11 Sep 2022 16:15:03 +0800
In-Reply-To: <CAGtpHi=f1+HCL+4kbfYGCC+qrLZasrpdT4peMF6t8-h-5h8KWA@mail.gmail.com>
References: <CAGtpHi=f1+HCL+4kbfYGCC+qrLZasrpdT4peMF6t8-h-5h8KWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 2022-09-11 at 09:57 +0200, Xhivat Hoxhiq wrote:
> Hi!
> 
> I noticed that there is no mention of Tigerlake in the intel_idle
> driver.
> Is that by design or is it actually missing?

intel_idle driver works with the cstate provided via _CST ACPI control
method on any platform by default.

I recalled that I did some measurement for TGL, but didn't find any
power/performance improvement using the measured latency numbers.

May I know why you need a customized table?

thanks,
rui


