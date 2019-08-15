Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCAF58EF1C
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 17:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732522AbfHOPOL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Aug 2019 11:14:11 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52439 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732517AbfHOPOL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Aug 2019 11:14:11 -0400
Received: from callcc.thunk.org (guestnat-104-133-8-96.corp.google.com [104.133.8.96] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7FFCP4x018561
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Aug 2019 11:12:27 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BF39B4218EF; Thu, 15 Aug 2019 11:12:24 -0400 (EDT)
Date:   Thu, 15 Aug 2019 11:12:24 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        nhorman@tuxdriver.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Chen Yu <yu.c.chen@intel.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: Non-random RDRAND Re: [PATCH] x86/CPU/AMD: Clear RDRAND CPUID
 bit on AMD family 15h/16h
Message-ID: <20190815151224.GB18727@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Pavel Machek <pavel@ucw.cz>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, nhorman@tuxdriver.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Chen Yu <yu.c.chen@intel.com>, Jonathan Corbet <corbet@lwn.net>
References: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com>
 <20190814232434.GA31769@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814232434.GA31769@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 15, 2019 at 01:24:35AM +0200, Pavel Machek wrote:
> Burn it with fire!
> 
> I mean... people were afraid RDRAND would be backdoored, and you now
> confirm ... it indeed _is_ backdoored? /., here's news for you!

To be fair to AMD, I wouldn't call it a backdoor.  Hanlon's razor is
applicable here:

	"Never attribute to malice that which can be adequately
	explained by neglect."

(Sometimes other words are used instead of neglect, but i'm trying to
be nice.)

					- Ted

P.S.   Also applicable:

	https://www.youtube.com/watch?v=XZxzJGgox_E
