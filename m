Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C318358857
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 17:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhDHP0q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 11:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231791AbhDHP0q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Apr 2021 11:26:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB23D61103;
        Thu,  8 Apr 2021 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617895594;
        bh=RI1xiofESuBoPYR+YavH1V/ABEGPCfLun0uC+7Y/teY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Knd2XdQIwF8kiwz56AKLmRPFQQfmE9dRyVJC4JRFu2DwXaQ0nSF4OWH+Wk401QJUY
         iIRF4/zDHxqyGviyzH+mMvNGhjHfmMgXfunU44BYhauKeH6qh+u09K0/81+gV8GtJk
         QS3rhUMaVi0CP/DxEXe1M+MutzTX+FbmnXzTfkr1RMengMMMDNPv+aDIn63I8V6TLG
         juvfQ7KDxHeNKcZbwkYJiqbr3glqLlWSJHLqceQCRs2tVKqeeh2bEX/twxA+JdoXJo
         h2tNZ8XNIJnnn5m4sfMDnKYDbk9M/oiw79xny77dm2GuG+DsdJKHAb2IB3WpYwMNfk
         HQctSdPRnjTuA==
Date:   Thu, 8 Apr 2021 08:26:33 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Chris von Recklinghausen <crecklin@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, Simo Sorce <simo@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
Message-ID: <YG8gqZoZGutPmROz@sol.localdomain>
References: <20210408131506.17941-1-crecklin@redhat.com>
 <CAJZ5v0ib+jmbsD9taGW0RujY5c9BCK8yLHv065u44mb0AwO9vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ib+jmbsD9taGW0RujY5c9BCK8yLHv065u44mb0AwO9vQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 08, 2021 at 03:32:38PM +0200, Rafael J. Wysocki wrote:
> On Thu, Apr 8, 2021 at 3:15 PM Chris von Recklinghausen
> <crecklin@redhat.com> wrote:
> >
> > Suspend fails on a system in fips mode because md5 is used for the e820
> > integrity check and is not available. Use crc32 instead.
> >
> > This patch changes the integrity check algorithm from md5 to
> > crc32. This integrity check is used only to verify accidental
> > corruption of the hybernation data
> 
> It isn't used for that.
> 
> In fact, it is used to detect differences between the memory map used
> before hibernation and the one made available by the BIOS during the
> subsequent resume.  And the check is there, because it is generally
> unsafe to load the hibernation image into memory if the current memory
> map doesn't match the one used when the image was created.

So what types of "differences" are you trying to detect?  If you need to detect
differences caused by someone who maliciously made changes ("malicious" implies
they may try to avoid detection), then you need to use a cryptographic hash
function (or a cryptographic MAC if the hash value isn't stored separately).  If
you only need to detect non-malicious changes (normally these would be called
"accidental" changes, but sure, it could be changes that are "intentionally"
made provided that the other side can be trusted to not try to avoid
detection...), then a non-cryptographic checksum would be sufficient.

- Eric
