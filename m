Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F14C18222E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 20:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbgCKTXh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 15:23:37 -0400
Received: from mx1.riseup.net ([198.252.153.129]:39350 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730858AbgCKTXh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 15:23:37 -0400
Received: from bell.riseup.net (unknown [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48d21h3hQCzFdnY;
        Wed, 11 Mar 2020 12:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1583954616; bh=QXd05nbr+A/UUlgwlqAaT4LILQAOhL1B5LsJvk9LKAA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AH94jiooDn/NiSTRbN1uB0oTx2KG7wfFGVZ4CP1XRZI65HMUjV5B4xrys/qSdlQAe
         UssNP0Q+D7J6Ws+LvdRBnkI8ujF4RHIj6y4occqM9dMFJ8h3tIlN3unnelNAyb/7ih
         C7OeTzBJgCSPsIryF/HOJViRrmIs5yE3QCGBPLR4=
X-Riseup-User-ID: 87DBAAEFDFB0F847197C8535E3CA68FC579FD3A57B30C81AC01BFD8C3275AFB9
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 48d21g6tS1zJrjn;
        Wed, 11 Mar 2020 12:23:35 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>,
        "Vivi\, Rodrigo" <rodrigo.vivi@intel.com>
Subject: Re: [PATCH 01/10] PM: QoS: Add CPU_RESPONSE_FREQUENCY global PM QoS limit.
In-Reply-To: <20200311124221.GO12561@hirez.programming.kicks-ass.net>
References: <20200310214203.26459-1-currojerez@riseup.net> <20200310214203.26459-2-currojerez@riseup.net> <20200311124221.GO12561@hirez.programming.kicks-ass.net>
Date:   Wed, 11 Mar 2020 12:23:36 -0700
Message-ID: <87d09iae6f.fsf@riseup.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Mar 10, 2020 at 02:41:54PM -0700, Francisco Jerez wrote:
>> +static void cpu_response_frequency_qos_apply(struct pm_qos_request *req,
>> +					     enum pm_qos_req_action action,
>> +					     s32 value)
>> +{
>> +	int ret = pm_qos_update_target(req->qos, &req->node, action, value);
>> +
>> +	if (ret > 0)
>> +		wake_up_all_idle_cpus();
>> +}
>
> That's a pretty horrific thing to do; how often do we expect to call
> this?

Dropped.  It sneaked in while copy-pasting cpu_latency_qos_apply(), but
it's not necessary for our use-case.

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXmk6uAAKCRCDmTidfVK/
W/9eAP9R7VJNY6yqiQkosIBN/KzH/sUo1fTUjRBbgtCJ1egddAD9F5gAVSZ4yQf+
9DNRFz4K22O7aZ+rx/avgDej9T4LyAA=
=7cXL
-----END PGP SIGNATURE-----
--==-=-=--
