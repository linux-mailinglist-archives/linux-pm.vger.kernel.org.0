Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30F735E77B
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 22:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbhDMUQN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Apr 2021 16:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhDMUQL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Apr 2021 16:16:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2921661206;
        Tue, 13 Apr 2021 20:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618344951;
        bh=7k0AMOZwiZ1cm8Txz5rxv/cB0NXxA/r/+Svrk6c3PTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VpfeGaFxLS60vw0qzf/2jzWhd29D+8AHd3+zO6OedGr2bXPVIkL3EjXlS45Xlvhuk
         EBWDg82IbOh4hl05phzhISnql3Th5JkkDS4gTOujHAze8sBUarvgHVEIQ28HbTl5bL
         8+ykT+pUL56sxg9EOjbELkqwtjmaJS/qyQ+8jqHDZKAb3PUf8gTM2eT5e3o5aRStXe
         ulFNXx040tOK40Pw/V/5iZkg1AvOZk9zoPaG+z2nbIxlejIWXNvvjQRPkApUZ1jsoX
         J56calxDj8/wWxbDADkxK0u/RlCqhnY9YvpTNVFMHoi6QSkScwk8xU3I7ppe9S3ihY
         9hOlvWjTVNGbQ==
Date:   Tue, 13 Apr 2021 13:15:49 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chris von Recklinghausen <crecklin@redhat.com>
Cc:     ardb@kernel.org, simo@redhat.com, rafael@kernel.org,
        decui@microsoft.com, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
Message-ID: <YHX79XWnwaAGFtxq@sol.localdomain>
References: <20210413161330.20024-1-crecklin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413161330.20024-1-crecklin@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 13, 2021 at 12:13:30PM -0400, Chris von Recklinghausen wrote:
> +static inline void get_e820_crc32(struct e820_table *table, void *buf)
>  {

This should just return the CRC-32 value as a u32.  There's no need for the
'void *buf' argument.

Also like I said, compute_e820_crc32() would be a more logical name.

> @@ -179,7 +133,8 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
>  	 */
>  	rdr->cr3 = restore_cr3 & ~CR3_PCID_MASK;
>  
> -	return hibernation_e820_save(rdr->e820_digest);
> +	hibernation_e820_save(&rdr->e820_digest);
> +	return 0;

Like I said, hibernation_e820_save() should just be inlined into here:

	rdr->e820_digest = compute_e820_crc32(e820_table_firmware)

Having the helper function doesn't add anything.

>  /**
> @@ -200,7 +155,7 @@ int arch_hibernation_header_restore(void *addr)
>  	jump_address_phys = rdr->jump_address_phys;
>  	restore_cr3 = rdr->cr3;
>  
> -	if (hibernation_e820_mismatch(rdr->e820_digest)) {
> +	if (hibernation_e820_mismatch(&rdr->e820_digest)) {

Likewise, this should be just

	if (rdr->e820_digest != compute_e820_crc32(e820_table_firmware)) {

- Eric
