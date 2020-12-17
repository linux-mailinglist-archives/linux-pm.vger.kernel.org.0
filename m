Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6D82DD927
	for <lists+linux-pm@lfdr.de>; Thu, 17 Dec 2020 20:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbgLQTKn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Dec 2020 14:10:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:46228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728161AbgLQTKn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Dec 2020 14:10:43 -0500
Date:   Thu, 17 Dec 2020 11:10:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608232202;
        bh=YUvpFWcPAGGgdfSqX1mqRgL8WpSCzilBINwBrPrMPVE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=k7KpcdS8Z3SvJB88KtiAnJkXGD2qGQgfNslr35Vnowi2oMvN0USM9+H9y7MTozW2F
         zrx2FoZf96J1txcD1/yZOKyyAqeQmmUwlF53bZQktSvMVIHO0mCdPT7fEZ8voVlE9E
         xICy8HmGGqT4KiqLb9QtJ/JRu8Ad8v9NtP9EmNZqWeQqo8J2AvQTl6dT+mDIPamiuH
         oC03x5eEZhfhmtt9drFLzeWjXlGzLItAidleWpCT2z3GqZ+4pWD0fcXdaOZwDyE3fS
         7IP3kjP3J93RRIi+5iCn1XXTAbUr3FBqPenqIliZdr5OF99UPuyql82JzhWunB9jV6
         4kKXOF10MgmOA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org, herbert@gondor.apana.org.au,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        ravi.v.shankar@intel.com, ning.sun@intel.com,
        kumar.n.dwarakanath@intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 4/8] x86/power: Restore Key Locker internal key from
 the ACPI S3/4 sleep states
Message-ID: <X9utCNc8p61tRXU4@sol.localdomain>
References: <20201216174146.10446-1-chang.seok.bae@intel.com>
 <20201216174146.10446-5-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216174146.10446-5-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 16, 2020 at 09:41:42AM -0800, Chang S. Bae wrote:
> When the system state switches to these sleep states, the internal key gets
> reset. Since this system transition is transparent to userspace, the
> internal key needs to be restored properly.
> 
> Key Locker provides a mechanism to back up the internal key in non-volatile
> memory. The kernel requests a backup right after the key loaded at
> boot-time and copies it later when the system wakes up.
> 
> The backup during the S5 sleep state is not trusted. It is overwritten by a
> new key at the next boot.
> 
> On a system with the S3/4 states, enable the feature only when the backup
> mechanism is supported.
> 
> Disable the feature when the copy fails (or the backup corrupts). The
> shutdown is considered too noisy. A new key is considerable only when
> threads can be synchronously suspended.

Can this backup key be used to decrypt the encoded AES keys without executing
the keylocker instructions on the same CPU?

- Eric
