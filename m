Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2D9E48CF
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 12:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394466AbfJYKsA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Oct 2019 06:48:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:58614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390754AbfJYKsA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Oct 2019 06:48:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65F43B15F;
        Fri, 25 Oct 2019 10:47:58 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.com>
To:     "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        Borislav Petkov <bp@suse.de>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>
Subject: Re: [PATCHv2 0/3] Update cpupower and make it more accurate
Date:   Fri, 25 Oct 2019 12:47:58 +0200
Message-ID: <14300539.3gDY5kWNTU@skinner.arch.suse.de>
In-Reply-To: <ab5d732b-f322-0aeb-3970-99167afc177c@amd.com>
References: <cover.1570819652.git.Janakarajan.Natarajan@amd.com> <ab5d732b-f322-0aeb-3970-99167afc177c@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Removed: Pu Wen <puwen@hygon.com>

On Tuesday, October 22, 2019 6:39:11 PM CEST Natarajan, Janakarajan wrote:
> On 10/11/2019 2:37 PM, Natarajan, Janakarajan wrote:
> 
> > This patchset updates cpupower to make it more accurate by removing
> > the userspace to kernel transitions and read_msr initiated IPI delays.

Acked-by: Thomas Renninger <trenn@suse.de>

Shuan: If you do not object, it would be great if you can schedule these
to be included into Rafael's pm tree.

It's a nice enhancement for these CPUs.
Doing it even nicer and more generic (per cpu measures) needs further
restructuring, but should not delay this any further.


        Thomas



