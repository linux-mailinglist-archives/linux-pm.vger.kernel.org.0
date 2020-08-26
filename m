Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503F72534AB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 18:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgHZQTl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 12:19:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:16687 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgHZQTk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Aug 2020 12:19:40 -0400
IronPort-SDR: 3ih83erqta+LZ6aiy7Wg7VRaOE+VURhP0QP5m/hWXLqdIGtwhrHDYnkTyzrrNNmqZijoANHbV5
 2N8A5+nOiN0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="153748697"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="153748697"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 09:19:38 -0700
IronPort-SDR: GHtPkWF/dFgeM56edoykkNBMUlh1+IRjy3B5ToTjEq80wBupCLYE0qwEIUBGicPxkJ4NZTcHbs
 lIWrq8cjhYoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="336876099"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Aug 2020 09:19:38 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.186])
        by linux.intel.com (Postfix) with ESMTP id AB2025805ED;
        Wed, 26 Aug 2020 09:19:36 -0700 (PDT)
Message-ID: <72fab2376722c6169549669016933217d3da34a0.camel@gmail.com>
Subject: Re: [PATCH] intel_idle: Add ICL support
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Guilhem Lettron <guilhem@barpilot.io>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 26 Aug 2020 19:19:35 +0300
In-Reply-To: <CAGX5Wg0=K5AaTut5KH3R3+oasM5MM7PaJ9Z_L56xSNckMbWC9g@mail.gmail.com>
References: <20200826120421.44356-1-guilhem@barpilot.io>
         <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
         <CAGX5Wg2OOgY6d1RH514Kh9D6b+siga+jzH7qubcmE+ukq+6KKA@mail.gmail.com>
         <d0ca671465e6ce72c6c4d5178440ebc1e4814da8.camel@gmail.com>
         <e82c121057c4496238d3de7f7c919b7039d23b7c.camel@gmail.com>
         <CAGX5Wg0LrzPwf=2pGrQHAbFMVkOoYDxOoFa+ZmLBYshPvZQUXg@mail.gmail.com>
         <8fa7622dacc03f2fbd67e810f53389e3ede544e8.camel@intel.com>
         <CAGX5Wg0=K5AaTut5KH3R3+oasM5MM7PaJ9Z_L56xSNckMbWC9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Indeed, when I compare them:

acpi_idle (without the patch):

CPU%c1  CPU%c6  CPU%c7  CoreTmp PkgTmp  GFX%rc6 Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10 PkgWatt
29.48   0.00    60.71   58      58      97.96   16.96   0.00    0.00    0.00    0.00    0.00    0.00    6.08

intel_idle (with the patch):

CPU%c1  CPU%c6  CPU%c7  CoreTmp PkgTmp  GFX%rc6 Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10 PkgWatt
56      56      96.64   300     68.29   48.58   0.00    0.00    0.00    0.00    0.00    0.00    7.38    0.00

With intel_idle we reach PC10, without it we only go as deep as PC2 - huge difference.

I really wonder why the BIOS does not expose deeper C-states... And if
it does not, is this for a reason? And how windows works then?

May be there is a BIOS update that fixes this problem? May be Windows
user get it quickly because stuff like this is often well-integrated in
Windows? Would you please check if there is newer BIOS?

Artem.

