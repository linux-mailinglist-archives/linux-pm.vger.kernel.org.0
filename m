Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21BD1191E49
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 01:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgCYAzm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 20:55:42 -0400
Received: from cmta20.telus.net ([209.171.16.93]:53900 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727261AbgCYAzm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Mar 2020 20:55:42 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id GuFxjJjQxYkAEGuG1j2TCz; Tue, 24 Mar 2020 18:50:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1585097457; bh=j9RFKTQoSGY61y7r0J6PzzK0nsonqMQrYL7QPAPYdIw=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=q/ndEDck/WxUr9MrP4FqIR3kyVyssRXAm2nbURYkG5D301VGfGgTd4unW5sPOyyvF
         JN2fNuLes5jbqAF530yUNw/u+txLsuMTwjUyoWpabp1PICzZx5XH6i08G3o9b9MxKh
         Valiit2Xllfr303Mze0pHOUZAOiN0huSDqA7sNcxLJdlGRrMW9Dz0GzsLHj1guvKWj
         ehty3nzRvbDRO5bnroeCgrc+wqFIRtCNCZO3d1sAtSvUJqlA5god5MgThLfklTr9AN
         WLxkBVKtYTU3tVtnyJ3cq9HzvlnROyYZ6fnUURrx23U9O4xY/RASmoN2mm6+2kWwl5
         KEew66GQQ9KVA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=caqsUULM c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8 a=8DlHCjrKwYeYp1394FkA:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Len Brown'" <lenb@kernel.org>
Cc:     "'Len Brown'" <len.brown@intel.com>, <linux-pm@vger.kernel.org>
References: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584679387.git.len.brown@intel.com> <fcaa681c03ea82193e60d7f2cdfd94fbbcd4cae9.1584679387.git.len.brown@intel.com>
In-Reply-To: <fcaa681c03ea82193e60d7f2cdfd94fbbcd4cae9.1584679387.git.len.brown@intel.com>
Subject: RE: [PATCH 08/10] tools/power turbostat: Fix 32-bit capabilities warning
Date:   Tue, 24 Mar 2020 17:50:56 -0700
Message-ID: <003201d6023f$71aff340$550fd9c0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdX+d6bI97s341oqQlad2c6zK3sz5wDxymmw
Content-Language: en-ca
X-CMAE-Envelope: MS4wfCxmvds0xSU/OdjXTno06lCx9md0whhd5nLhBiSf/VrFrjnV3wl2rkABtYw69E7CgWa/WZLkPPUZN/djU2fxBFRxzZgbtO4kLPTzo31Rmu6QYBj5eTUe
 YIM5iw8Qz2bSSyU6QMxBPU2Cz8bs5sG2B4FmePWzdRpSXox/EWw3lsBhwx8Ouuyca0xRxBO8Pf4vKy0PbIR2XSaYPGPK1u0q/Nf+nbe6GZWsiFOLbVrtKrKq
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Len,

On 2020.03.24 22:23 Len Brown wrote:

> From: Len Brown <len.brown@intel.com>
>
> warning: `turbostat' uses 32-bit capabilities (legacy support in use)
>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  tools/power/x86/turbostat/Makefile    |  2 +-
>  tools/power/x86/turbostat/turbostat.c | 46 +++++++++++++++++----------
>  2 files changed, 31 insertions(+), 17 deletions(-)

...

> +#include <sys/capability.h>


This seems to require a package, libcap-dev, to be installed.
I never needed it before.
Just F.Y.I.

... Doug


