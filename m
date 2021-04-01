Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5233351982
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 20:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbhDARx7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 13:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234080AbhDARoC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 13:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617299041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc; bh=PuFHoI6wZ2vqFN8F+7P4hon8RWN2+MjgjmIvpt1EN7A=;
        b=HOc1hJKFzmXCdJU6jeBCcfXNSwbW1LCM9p1C74qk3cIdndcLN1xvVAsSglpicy4xk++cUJ
        SJRJbi+7juHrYieeGBsPW/0aflBLEvjjgqrXCsEic1nvM4ntmf2Vje08/hN8o0snerYiJS
        luG6ZHcnTR9MujAh2jaJDyr3oXl4k64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-lgkESsc8PAKfec_O1C3O2g-1; Thu, 01 Apr 2021 12:42:57 -0400
X-MC-Unique: lgkESsc8PAKfec_O1C3O2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 767721005D61;
        Thu,  1 Apr 2021 16:42:49 +0000 (UTC)
Received: from crecklin.bos.com (unknown [10.22.8.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C88C5D9CC;
        Thu,  1 Apr 2021 16:42:43 +0000 (UTC)
From:   Chris von Recklinghausen <crecklin@redhat.com>
To:     ardb@kernel.org, simo@redhat.com, rafael@kernel.org,
        decui@microsoft.com, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] use crc32 instead of md5 for hibernation e820 integrity check
Date:   Thu,  1 Apr 2021 12:41:44 -0400
Message-Id: <20210401164145.8051-1-crecklin@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, suspend on x86_64 fails when FIPS mode is enabled because it uses md5
to generate a digest of the e820 region. MD5 is not FIPS compliant so an error
is reported and the suspend fails.

MD5 is used only to create a digest to ensure integrity of the region, no actual
encryption is done. This patch set changes the integrity check to use crc32
instead of md5 since crc32 is available in both FIPS and non-FIPS modes.

Chris von Recklinghausen (1):
  use crc32 instead of md5 for hibernation e820 integrity check

 arch/x86/power/hibernate.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

-- 
v1 -> v2
   bump up RESTORE_MAGIC
2.18.1

