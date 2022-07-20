Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B542857B414
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jul 2022 11:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiGTJpK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jul 2022 05:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiGTJpJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jul 2022 05:45:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3742FA
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2022 02:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658310306; x=1689846306;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jQOvsjd42lbv4OTsnYXpryOWxWCegP4Hp2WVQhVhPuQ=;
  b=H3JmBj7jEo+F+ayxt8e/qEwDLVLKlh0N/Q8zwqSZVD+jKpryPN9hj0Xe
   Pzrj7+DieNpO3A3U+CQDIhGeojCmtcpw22z9re2Pi92KwiFNsV1DyxrlG
   P+MPUhXPGzVSMmUIkXvqfGwYLizwJLA267rbOhlyMSODYcZadu0aHZlrz
   5uMINEj3+gXvqOZPd9ZPD3zVQp/om1NdarGv4v6UfOxHciK0dBztVCaig
   rFfQ+7SvkFV0BkuXzmFYEitD24pNKCEU5DLCHzKHXEmzJRhSOpEbYak2p
   0JRfhqUyd6qR+alsG/dKZBEpKO0aeCVkVvNelPQNpYnstKiYcJufwqJ85
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="269758384"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="269758384"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 02:45:06 -0700
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="656193568"
Received: from mmohdtaj-mobl.gar.corp.intel.com ([10.213.149.231])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 02:45:04 -0700
Message-ID: <62c11a15028d27d3c4f50c2d34f47be02b15c965.camel@intel.com>
Subject: Re: [PATCH 0/2] Introduce powercap userspace frontend
From:   Zhang Rui <rui.zhang@intel.com>
To:     Thomas Renninger <trenn@suse.com>, linux-pm@vger.kernel.org
Cc:     skhan@linuxfoundation.org
Date:   Wed, 20 Jul 2022 17:45:08 +0800
In-Reply-To: <4954139.fJS9391jLT@c100>
References: <4954139.fJS9391jLT@c100>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Thomas,

I want to give the patches a try but it seems that the patch format is
corrupted, and I can not find them in patchwork neither.

thanks,
rui

On Sat, 2022-07-09 at 10:13 +0200, Thomas Renninger wrote:
> cpupower powercap-info
> cpupower monitor -m RAPL
>=20
> further development could provide:
> cpupower powercap-set
> to enable/disable RAPL domains, etc.
>=20
> Thomas Renninger (2):
> =C2=A0 cpupower: Introduce powercap intel-rapl library helpers and
> =C2=A0=C2=A0=C2=A0 powercap-info command
> =C2=A0 cpupower: rapl monitor - shows the used power consumption in uj fo=
r
> =C2=A0=C2=A0=C2=A0 each rapl domain
>=20
> =C2=A0tools/power/cpupower/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +-
> =C2=A0tools/power/cpupower/lib/powercap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 290
> ++++++++++++++++++
> =C2=A0tools/power/cpupower/lib/powercap.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 54 ++++
> =C2=A0.../cpupower/man/cpupower-powercap-info.1=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 25 ++
> =C2=A0tools/power/cpupower/utils/builtin.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0tools/power/cpupower/utils/cpupower.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0.../utils/idle_monitor/cpupower-monitor.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 7 +-
> =C2=A0.../utils/idle_monitor/idle_monitors.def=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
> =C2=A0.../utils/idle_monitor/rapl_monitor.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 141 +++++++++
> =C2=A0tools/power/cpupower/utils/powercap-info.c=C2=A0=C2=A0=C2=A0 | 113 =
+++++++
> =C2=A010 files changed, 639 insertions(+), 7 deletions(-)
> =C2=A0create mode 100644 tools/power/cpupower/lib/powercap.c
> =C2=A0create mode 100644 tools/power/cpupower/lib/powercap.h
> =C2=A0create mode 100644 tools/power/cpupower/man/cpupower-powercap-info.=
1
> =C2=A0create mode 100644
> tools/power/cpupower/utils/idle_monitor/rapl_monitor.c
> =C2=A0create mode 100644 tools/power/cpupower/utils/powercap-info.c
>=20

