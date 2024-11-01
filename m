Return-Path: <linux-pm+bounces-16876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19CF9B938B
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 15:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DC8DB2108D
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 14:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124CD1A727D;
	Fri,  1 Nov 2024 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kNNTweVN"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526751A7273;
	Fri,  1 Nov 2024 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472295; cv=none; b=Hv6Zrv+l979Yf/RZzzfysXbOXU/IjogovNbg9GL60yc58UGgWlw72LRjqyuk/+Ph1UXFCVMfybMyn7KIgK1SNrpVxVAc1veHa2tsVlT75+fkiFkn/WCDM+KTM++M70JaudwGaAtKPQMns9a20ko9QsJ0dTtpnviAbavkv3MeorA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472295; c=relaxed/simple;
	bh=imtIy6t0rdqWmx22fOAJMcxKAb1MR2H0nT8FL2rjcaE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DG43NM7X+QdKQPzdlJOyKstgrwv5qvt8VblHqMaMRo1KomiEROkuKjMrVdPc322uMlBrz7rt5/2nLwTQ+Nm+xU5pgz92PKykx8sH3BWk0jU411Oj01lUunonYexTCwKVvsWudktzwDsXzG1z+6GP3t+Js0M/aXx2QMn4Cun811o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kNNTweVN; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A1Eikn0118034;
	Fri, 1 Nov 2024 09:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730472286;
	bh=TEvXM9nas2G5E+MLH3nAkA5t7zWzN2EXcd0zrqWDXcw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=kNNTweVNP8vpJobaC3xXB5ifbCdtMeTdk1861uAjXGOiXsQ/AdYTXFMdpNi6Drxc6
	 vUxS5lQWQ39Bp3oTtW8T0JrBkK5CCY7FCrG1/jxQfUQCf/ixu54c4zRPYOkaRVuRUl
	 zjs6H4vHxC5Y4jx4eUtSc19AJisgjiJP8nYkNikU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A1EikI7013217
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 1 Nov 2024 09:44:46 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Nov 2024 09:44:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Nov 2024 09:44:45 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A1Eijgl006619;
	Fri, 1 Nov 2024 09:44:45 -0500
Date: Fri, 1 Nov 2024 09:44:45 -0500
From: Nishanth Menon <nm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Kevin Hilman <khilman@baylibre.com>, <linux-pm@vger.kernel.org>,
        Vibhore
 Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        Akashdeep Kaur
	<a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>,
        Markus
 Schneider-Pargmann <msp@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] pmdomain: ti_sci: collect and send low-power mode
 constraints
Message-ID: <20241101144445.56ejnuoxshqwns37@boots>
References: <20240906-lpm-v6-10-constraints-pmdomain-v4-0-4055557fafbc@baylibre.com>
 <173029317079.2440963.17313738472826934777.b4-ty@ti.com>
 <CAPDyKFptHq6xkKSAmeHsEuhBoEhzvudcMf2+nG08MFPwnMi+ew@mail.gmail.com>
 <7hv7x9qsvt.fsf@baylibre.com>
 <CAPDyKFpdgg+kM_Ot5GPTpMUtjmBF-pUhCeRpVb=j852_7qm=3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPDyKFpdgg+kM_Ot5GPTpMUtjmBF-pUhCeRpVb=j852_7qm=3A@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 11:11-20241031, Ulf Hansson wrote:
> On Wed, 30 Oct 2024 at 20:43, Kevin Hilman <khilman@baylibre.com> wrote:
> >
> > Ulf Hansson <ulf.hansson@linaro.org> writes:
> >
> > > On Wed, 30 Oct 2024 at 14:01, Nishanth Menon <nm@ti.com> wrote:
> > >>
> > >> Hi Kevin Hilman,
> > >>
> > >> On Fri, 06 Sep 2024 09:14:48 -0700, Kevin Hilman wrote:
> > >> > The latest (10.x) version of the firmware for the PM co-processor (aka
> > >> > device manager, or DM) adds support for a "managed" mode, where the DM
> > >> > firmware will select the specific low power state which is entered
> > >> > when Linux requests a system-wide suspend.
> > >> >
> > >> > In this mode, the DM will always attempt the deepest low-power state
> > >> > available for the SoC.
> > >> >
> > >> > [...]
> > >>
> > >> I have applied the following to branch ti-drivers-soc-next on [1].
> > >> Thank you!
> > >>
> > >> Ulf, based on your ack[2], I have assumed that you want me to pick
> > >> this series up. Let me know if that is not the case and I can drop the
> > >> series.
> > >
> > > Well, that was a while ago. The reason was because there was a
> > > dependency to another series [2], when this was posted.
> > >
> > > If that's not the case anymore, I think it's better to funnel this via
> > > my pmdomain tree. Please let me know how to proceed.
> >
> > The build-time dependency on [2] still exists, and since that was just
> > queued up by Nishanth, I think this series should (still) go along with
> > it to keep things simple.
> >
> > Kevin
> 
> Right, that makes perfect sense to me too. If we discover conflicts,
> let's deal with them then.


oops.. I missed this response. OK, I will let things be.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

