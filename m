Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69BE6191E44
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 01:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgCYAzC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 24 Mar 2020 20:55:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:29144 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbgCYAzC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Mar 2020 20:55:02 -0400
IronPort-SDR: FotC8jj35Dq1hLRr0MtcG6QXSxxwVII6oDiBqzAHxWVHklbVXBaLCHPlLJDIiqYHYdiIjJrW4W
 sKdvA/PPAWmw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 17:54:01 -0700
IronPort-SDR: QLDcRKjdWCfKMwcgnoJprG/6O/K2LOom7eYr7NGKx0MnmQNUxpE4Esd4OXX34AzQI+xilihWfx
 mBtktYiGhb8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,302,1580803200"; 
   d="scan'208";a="235789732"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga007.jf.intel.com with ESMTP; 24 Mar 2020 17:54:01 -0700
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Mar 2020 17:54:00 -0700
Received: from fmsmsx101.amr.corp.intel.com ([169.254.1.121]) by
 fmsmsx117.amr.corp.intel.com ([169.254.3.48]) with mapi id 14.03.0439.000;
 Tue, 24 Mar 2020 17:54:00 -0700
From:   "Brown, Len" <len.brown@intel.com>
To:     Doug Smythies <dsmythies@telus.net>, 'Len Brown' <lenb@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH 08/10] tools/power turbostat: Fix 32-bit capabilities
 warning
Thread-Topic: [PATCH 08/10] tools/power turbostat: Fix 32-bit capabilities
 warning
Thread-Index: AQHV/neoeuXA0oD9IE63vdznEZOzXqhY90sA//+K6sA=
Date:   Wed, 25 Mar 2020 00:54:00 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C94881B9278A@fmsmsx101.amr.corp.intel.com>
References: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584679387.git.len.brown@intel.com>
 <fcaa681c03ea82193e60d7f2cdfd94fbbcd4cae9.1584679387.git.len.brown@intel.com>
 <003201d6023f$71aff340$550fd9c0$@net>
In-Reply-To: <003201d6023f$71aff340$550fd9c0$@net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> +#include <sys/capability.h>

> This seems to require a package, libcap-dev, to be installed.

Yeah, sort of annoying that libcap-dev isn't installed by default.
I've added it to the list of stuff that I install on new machines before they are usable...


