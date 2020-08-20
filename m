Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5215F24B5A0
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 12:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgHTK0S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 20 Aug 2020 06:26:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:45314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730535AbgHTK0E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Aug 2020 06:26:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64C2DAE33;
        Thu, 20 Aug 2020 10:26:30 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.com>
To:     shuah@kernel.org, linux-pm@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: Re: [PATCH] cpupower: Replace HTTP links with HTTPS ones
Date:   Thu, 20 Aug 2020 12:26:02 +0200
Message-ID: <7169450.1KdEUtMQry@c100>
In-Reply-To: <20200713110511.33549-1-grandmaster@al2klimov.de>
References: <20200713110511.33549-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Montag, 13. Juli 2020, 13:05:11 CEST schrieb Alexander A. Klimov:
>  .SH REFERENCES
>  "BIOS and Kernel Developer’s Guide (BKDG) for AMD Family 14h Processors"
> -http://support.amd.com/us/Processor_TechDocs/43170.pdf
> +https://support.amd.com/us/Processor_TechDocs/43170.pdf
> 
>  "Intel® Turbo Boost Technology
>  in Intel® Core™ Microarchitecture (Nehalem) Based Processors"
> @@ -178,7 +178,7 @@
> http://download.intel.com/design/processor/applnots/320354.pdf
> 
>  "Intel® 64 and IA-32 Architectures Software Developer's Manual
>  Volume 3B: System Programming Guide"
> -http://www.intel.com/products/processor/manuals
> +https://www.intel.com/products/processor/manuals

The 2 above https:// links are still valid.

No idea it's worth replacing. If this is checked and done through the whole 
kernel, then I agree that it would be nice if Shuah picks it up...

  Thomas


