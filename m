Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC5034F071
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 20:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhC3SEd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 14:04:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36846 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232490AbhC3SEY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Mar 2021 14:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617127464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aFp8BOcn/uX7lsQfrPEonMDuGiJTATGCAW9A2Sp16cw=;
        b=G3AZisHrhRN9iNgfL+VUHuV6+Hobk9RrzzJ5l5Us6PVk/jBd8KFbf/tQcnlVnqjcRUiR1T
        26TxfEW7PChRnsoz4mHA6swv85WNNlSmpx6/x9Yay2vib1usBZm+K4G12j148lCw5GuVSw
        1RAKNpR+uHX8zyf73NKQVKFktVP9sVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-_LoEW9MbMzy0EHwOfeErFg-1; Tue, 30 Mar 2021 14:04:19 -0400
X-MC-Unique: _LoEW9MbMzy0EHwOfeErFg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7C751017975;
        Tue, 30 Mar 2021 18:04:17 +0000 (UTC)
Received: from ovpn-113-84.phx2.redhat.com (ovpn-113-84.phx2.redhat.com [10.3.113.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B82C5C1D1;
        Tue, 30 Mar 2021 18:04:17 +0000 (UTC)
Message-ID: <4e95307db43e2f7cc8516e645b81db7db0dd8ad4.camel@redhat.com>
Subject: Re: Fix hibernation in FIPS mode?
From:   Simo Sorce <simo@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "crecklin@redhat.com" <crecklin@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 30 Mar 2021 14:04:15 -0400
In-Reply-To: <CAJZ5v0g+=AnRAmAAn8NpHm8bmZ1WkwDpjb5rr_zPOVABW1PYug@mail.gmail.com>
References: <MW2PR2101MB08924CD74C6EB773C4D5FAFDBF7E9@MW2PR2101MB0892.namprd21.prod.outlook.com>
         <CAJZ5v0g+=AnRAmAAn8NpHm8bmZ1WkwDpjb5rr_zPOVABW1PYug@mail.gmail.com>
Organization: Red Hat, Inc.
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2021-03-30 at 16:46 +0200, Rafael J. Wysocki wrote:
> On Tue, Mar 30, 2021 at 12:14 AM Dexuan Cui <decui@microsoft.com> wrote:
> > Hi,
> > MD5 was marked incompliant with FIPS in 2009:
> > a3bef3a31a19 ("crypto: testmgr - Skip algs not flagged fips_allowed in fips mode")
> > a1915d51e8e7 ("crypto: testmgr - Mark algs allowed in fips mode")
> > 
> > But hibernation_e820_save() is still using MD5, and fails in FIPS mode
> > due to the 2018 patch:
> > 749fa17093ff ("PM / hibernate: Check the success of generating md5 digest before hibernation")
> > 
> > As a result, hibernation doesn't work when FIPS is on.
> > 
> > Do you think if hibernation_e820_save() should be changed to use a
> > FIPS-compliant algorithm like SHA-1?
> 
> I would say yes, it should.
> 
> > PS, currently it looks like FIPS mode is broken in the mainline:
> > https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg49414.html


FYI, SHA-1 is not a good choice, it is only permitted in HMAC
constructions and only for specified uses. If you need to change
algorithm you should go straight to SHA-2 or SHA-3 based hashes.

HTH,
Simo.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc




