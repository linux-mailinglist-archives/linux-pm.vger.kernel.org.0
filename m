Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BBB3588E2
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 17:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhDHPwu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 11:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57701 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232021AbhDHPws (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 11:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617897156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9B/sUEO2VShQhd7eWwiUIrKIfr8RV9G7LyCRIKLZBbE=;
        b=XtHQmo+aH7kSKTJt/a8lVWUfaimON/VFEZ6GgejTB5d64H/Rz6k+AdZkjMbhd1Wc80lXCo
        L/vbIg0/+TZ8lEbVlFXMjWVlsCrwcmNLJhq+CW2wkliPrh+4dEHHEf3S0PzH+kV+NwUefA
        KRWjO3mDCdwq0pc+rYMNyhL9KgmDAhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-X4izMfM0PQeWXMyFdM51gw-1; Thu, 08 Apr 2021 11:52:35 -0400
X-MC-Unique: X4izMfM0PQeWXMyFdM51gw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34065189C440;
        Thu,  8 Apr 2021 15:52:33 +0000 (UTC)
Received: from ovpn-113-96.phx2.redhat.com (ovpn-113-96.phx2.redhat.com [10.3.113.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6748C60864;
        Thu,  8 Apr 2021 15:52:32 +0000 (UTC)
Message-ID: <2a4303680e20e8eac115880c1ac86f39076f0fd7.camel@redhat.com>
Subject: Re: [PATCH v5 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
From:   Simo Sorce <simo@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Chris von Recklinghausen <crecklin@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 08 Apr 2021 11:52:31 -0400
In-Reply-To: <YG8gqZoZGutPmROz@sol.localdomain>
References: <20210408131506.17941-1-crecklin@redhat.com>
         <CAJZ5v0ib+jmbsD9taGW0RujY5c9BCK8yLHv065u44mb0AwO9vQ@mail.gmail.com>
         <YG8gqZoZGutPmROz@sol.localdomain>
Organization: Red Hat, Inc.
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2021-04-08 at 08:26 -0700, Eric Biggers wrote:
> On Thu, Apr 08, 2021 at 03:32:38PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Apr 8, 2021 at 3:15 PM Chris von Recklinghausen
> > <crecklin@redhat.com> wrote:
> > > Suspend fails on a system in fips mode because md5 is used for the e820
> > > integrity check and is not available. Use crc32 instead.
> > > 
> > > This patch changes the integrity check algorithm from md5 to
> > > crc32. This integrity check is used only to verify accidental
> > > corruption of the hybernation data
> > 
> > It isn't used for that.
> > 
> > In fact, it is used to detect differences between the memory map used
> > before hibernation and the one made available by the BIOS during the
> > subsequent resume.  And the check is there, because it is generally
> > unsafe to load the hibernation image into memory if the current memory
> > map doesn't match the one used when the image was created.
> 
> So what types of "differences" are you trying to detect?  If you need to detect
> differences caused by someone who maliciously made changes ("malicious" implies
> they may try to avoid detection), then you need to use a cryptographic hash
> function (or a cryptographic MAC if the hash value isn't stored separately).  If
> you only need to detect non-malicious changes (normally these would be called
> "accidental" changes, but sure, it could be changes that are "intentionally"
> made provided that the other side can be trusted to not try to avoid
> detection...), then a non-cryptographic checksum would be sufficient.

Wouldn't you also need a signature with a TPM key in that case?
An attacker that can change memory maps can also change the hash on
disk ? Unless the hash is in an encrypted partition I guess...

Simo.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc




