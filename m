Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CED735840C
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 15:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhDHNCI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 09:02:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229964AbhDHNCH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 09:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617886915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SC4hNMbbB4hm2+rL5qMmQKUw2dEFlVpMyX9e9hUazm0=;
        b=i+tqxyV1cBD7G9ZwQYFrYyUt6DVuMjfmS5LzIWni8WNggGrVTlkPyIypCacZduOwcKiROY
        EoknCSHBLktguJJzCf6pLF2ZEAbE8FkDlCjl7REoRY4ceCf5bqlxdjrKm6/4onsTOBhghQ
        Mq1xTuA8Wv+T6PyAU7Wer6kayYI1crE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-eei0jnrKMlCu2J2fgu6mzA-1; Thu, 08 Apr 2021 09:01:53 -0400
X-MC-Unique: eei0jnrKMlCu2J2fgu6mzA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD4A2DF8A3;
        Thu,  8 Apr 2021 13:01:52 +0000 (UTC)
Received: from ovpn-113-96.phx2.redhat.com (ovpn-113-96.phx2.redhat.com [10.3.113.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1186119CBF;
        Thu,  8 Apr 2021 13:01:51 +0000 (UTC)
Message-ID: <e22b105449b6970177d5907d9cbb9e7f55bc72bb.camel@redhat.com>
Subject: Re: [PATCH v4 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
From:   Simo Sorce <simo@redhat.com>
To:     Chris von Recklinghausen <crecklin@redhat.com>, ardb@kernel.org,
        rafael@kernel.org, decui@microsoft.com, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Apr 2021 09:01:51 -0400
In-Reply-To: <20210408104629.31357-1-crecklin@redhat.com>
References: <20210408104629.31357-1-crecklin@redhat.com>
Organization: Red Hat, Inc.
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2021-04-08 at 06:46 -0400, Chris von Recklinghausen wrote:
> Suspend fails on a system in fips mode because md5 is used for the e820
> integrity check and is not available. Use crc32 instead.
> 
> Prior to this patch, MD5 is used only to create a digest to ensure integrity of
> the region, no actual encryption is done. This patch set changes the integrity
> check to use crc32 instead of md5 since crc32 is available in both FIPS and
> non-FIPS modes.
> 
> Note that the digest is only used as an integrity check. No actual encryption
> is done.
> 
> Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map
>        by md5 digest")
> 
> Tested-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>

Hi Chris,
I would reword it this way:
----------
This patch(set) changes the integrity check algorithm from md5 to
crc32. This integrity check is used only to verify accidental
corruption of the hybernation data and is not intended as a
cryptographic integrity check.
Md5 is overkill in this case and also disabled in FIPS mode because it
is known to be broken for cryptographic purposes.
----------

HTH,
Simo.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc




