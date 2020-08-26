Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCFF252F5C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 15:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgHZNJI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 09:09:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:29512 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729324AbgHZNJF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Aug 2020 09:09:05 -0400
IronPort-SDR: fc6cxJhinkYUE5uiCQx7DPhk4tscW1z8grFp0NlBqqZVgYFOGLY7SxIcGmu67IMRJjOzQgpY1n
 1N7yWIfBsa5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="220545448"
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="220545448"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 06:09:04 -0700
IronPort-SDR: eVRqeD7SzJm0BvDs6PX+bkOvlprh4PlU7IV2Ttf0xB3W7icl8mzguvYhuoAYovMKtB1jwfIAfj
 e0p2P2q52ojw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="403059832"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 26 Aug 2020 06:09:04 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.186])
        by linux.intel.com (Postfix) with ESMTP id 512F75806C4;
        Wed, 26 Aug 2020 06:09:02 -0700 (PDT)
Message-ID: <a7c8ee4b54b5f205548c055b7b8d599c1bd7ddeb.camel@gmail.com>
Subject: Re: [PATCH] intel_idle: Add ICL support
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Guilhem Lettron <guilhem@barpilot.io>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 26 Aug 2020 16:09:01 +0300
In-Reply-To: <CAGX5Wg2OOgY6d1RH514Kh9D6b+siga+jzH7qubcmE+ukq+6KKA@mail.gmail.com>
References: <20200826120421.44356-1-guilhem@barpilot.io>
         <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
         <CAGX5Wg2OOgY6d1RH514Kh9D6b+siga+jzH7qubcmE+ukq+6KKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-08-26 at 15:03 +0200, Guilhem Lettron wrote:
> On Wed, 26 Aug 2020 at 14:43, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Wed, Aug 26, 2020 at 2:05 PM Guilhem Lettron <guilhem@barpilot.io> wrote:
> > > Use the same C-states as SKL
> > 
> > Why is this change needed?
> 
> On my laptop, a Dell XPS 13 7390 2-in-1 with i7-1065G7, ACPI only
> report "C1_ACPI", "C2_ACPI" and "C3_ACPI".

Did you try to dig into the BIOS menus and check if you can enable
more/deeper C-states?

Artem.

