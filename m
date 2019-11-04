Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDFEEEAE4
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 22:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfKDVPc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 16:15:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:39328 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729660AbfKDVPb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Nov 2019 16:15:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 34D3BAC24;
        Mon,  4 Nov 2019 21:15:30 +0000 (UTC)
Date:   Mon, 4 Nov 2019 22:15:23 +0100
From:   Borislav Petkov <bp@suse.de>
To:     shuah <shuah@kernel.org>
Cc:     Thomas Renninger <trenn@suse.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>
Subject: Re: [PATCHv2 0/3] Update cpupower and make it more accurate
Message-ID: <20191104211523.GL7895@zn.tnic>
References: <cover.1570819652.git.Janakarajan.Natarajan@amd.com>
 <ab5d732b-f322-0aeb-3970-99167afc177c@amd.com>
 <14300539.3gDY5kWNTU@skinner.arch.suse.de>
 <4a095339-82ab-54c7-4957-63d0338d122f@kernel.org>
 <5c6eb321-7462-7458-a069-aa4919b39063@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c6eb321-7462-7458-a069-aa4919b39063@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 04, 2019 at 01:21:11PM -0700, shuah wrote:
> WARNING: Missing Signed-off-by: line by nominal patch author 'Natarajan,
> Janakarajan <Janakarajan.Natarajan@amd.com>'
> 
> There is a mismatch between your From: and Signed-off-by names?

That's checkpatch complaining that From: is of the format "Lastname,
Firstname" while the SOB is the other way around. One could use a script
which massages a mail before turning it into patch and fixes up that,
among other things.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
