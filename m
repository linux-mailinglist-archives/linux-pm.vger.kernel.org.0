Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68CC72BCB6
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2019 03:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfE1BQE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 May 2019 21:16:04 -0400
Received: from ozlabs.org ([203.11.71.1]:41341 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbfE1BQE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 May 2019 21:16:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45CbWg518wz9s3Z;
        Tue, 28 May 2019 11:15:59 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/power: Expose pfn_is_nosave prototype
In-Reply-To: <20190524104418.17194-1-malat@debian.org>
References: <20190523114736.30268-1-malat@debian.org> <20190524104418.17194-1-malat@debian.org>
Date:   Tue, 28 May 2019 11:15:56 +1000
Message-ID: <878surqsz7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Mathieu Malaterre <malat@debian.org> writes:
> The declaration for pfn_is_nosave is only available in
> kernel/power/power.h. Since this function can be override in arch,
> expose it globally. Having a prototype will make sure to avoid warning
> (sometime treated as error with W=1) such as:
>
>   arch/powerpc/kernel/suspend.c:18:5: error: no previous prototype for 'pfn_is_nosave' [-Werror=missing-prototypes]
>
> This moves the declaration into a globally visible header file and add
> missing include to avoid a warning on powerpc. Also remove the
> duplicated prototypes since not required anymore.
>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v2: As suggestion by christophe remove duplicates prototypes
>
>  arch/powerpc/kernel/suspend.c | 1 +
>  arch/s390/kernel/entry.h      | 1 -
>  include/linux/suspend.h       | 1 +
>  kernel/power/power.h          | 2 --
>  4 files changed, 2 insertions(+), 3 deletions(-)

Looks fine to me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
