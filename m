Return-Path: <linux-pm+bounces-16875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0699B9388
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 15:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D997B1F25011
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 14:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1591A7274;
	Fri,  1 Nov 2024 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RaPi+jJa"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC23B1AA7B7;
	Fri,  1 Nov 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472246; cv=none; b=CVtW6kOxuGMoJ9wsmn2faHNh4CNuJoAYlyoSXwIRYm3KE48aeqFOTu1tOyP4yrej6mTs8E7uYotjU2VfwIyJWOm6QLwTSN7m+JbZDbv4o4IspLf9J5SAa0qdllpnu85hfMrO9JqA6jvfqNGUqlsX2eB+4vyOUddJBP5w3coHWeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472246; c=relaxed/simple;
	bh=5jmLTb9ENaug2prc9ptsTi47NjUTFLbqUFjz5SHhbL0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaEElMg7b/Q0nbKDzDaovTr9UzJxRT3tm70kiXNXIZDMHUd14OKtvomVnWbP+FS42rTBl97MDH7ex8+6ldmVrlF6hMM+wcMsYyMega8OJYDH21GBiWNmVpZLAhSZNx8D9Y0Mu+9S6DlvJwOznTBwdM7smg3xp0C2jL4iV9ml3GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RaPi+jJa; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A1EhsUA117875;
	Fri, 1 Nov 2024 09:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730472234;
	bh=NN3EbY+BhNgctFk5eHdO+ZGYdUHr5D4XdWKmahmrTGQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=RaPi+jJaTzaO35ZGP48j4vFXctjbVfgGLmybKtZ26CM+iITAF+u3BIwfA6lyrpJvK
	 1olOJdhIHK/RjCTsnb1Yh6TPF3qryN7OtJ37SL2qMTZgpqpKBxfPq9lpiIAID9qCfW
	 H65FeRnFo33rkdpXl9Tr21jGxvX2srunINJeXQho=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A1EhsS1012901
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 1 Nov 2024 09:43:54 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Nov 2024 09:43:53 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Nov 2024 09:43:53 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A1Ehrwq005744;
	Fri, 1 Nov 2024 09:43:53 -0500
Date: Fri, 1 Nov 2024 09:43:53 -0500
From: Nishanth Menon <nm@ti.com>
To: Kevin Hilman <khilman@baylibre.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>,
        Vibhore
 Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        Akashdeep Kaur
	<a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>,
        Markus
 Schneider-Pargmann <msp@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] pmdomain: ti_sci: collect and send low-power mode
 constraints
Message-ID: <20241101144353.zdwrykik37rrzmrt@bagful>
References: <20240906-lpm-v6-10-constraints-pmdomain-v4-0-4055557fafbc@baylibre.com>
 <173029317079.2440963.17313738472826934777.b4-ty@ti.com>
 <CAPDyKFptHq6xkKSAmeHsEuhBoEhzvudcMf2+nG08MFPwnMi+ew@mail.gmail.com>
 <7hv7x9qsvt.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7hv7x9qsvt.fsf@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 12:43-20241030, Kevin Hilman wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
> 
> > On Wed, 30 Oct 2024 at 14:01, Nishanth Menon <nm@ti.com> wrote:
> >>
> >> Hi Kevin Hilman,
> >>
> >> On Fri, 06 Sep 2024 09:14:48 -0700, Kevin Hilman wrote:
> >> > The latest (10.x) version of the firmware for the PM co-processor (aka
> >> > device manager, or DM) adds support for a "managed" mode, where the DM
> >> > firmware will select the specific low power state which is entered
> >> > when Linux requests a system-wide suspend.
> >> >
> >> > In this mode, the DM will always attempt the deepest low-power state
> >> > available for the SoC.
> >> >
> >> > [...]
> >>
> >> I have applied the following to branch ti-drivers-soc-next on [1].
> >> Thank you!
> >>
> >> Ulf, based on your ack[2], I have assumed that you want me to pick
> >> this series up. Let me know if that is not the case and I can drop the
> >> series.
> >
> > Well, that was a while ago. The reason was because there was a
> > dependency to another series [2], when this was posted.
> >
> > If that's not the case anymore, I think it's better to funnel this via
> > my pmdomain tree. Please let me know how to proceed.
> 
> The build-time dependency on [2] still exists, and since that was just
> queued up by Nishanth, I think this series should (still) go along with
> it to keep things simple.

Ulf, are you OK with this? If not, I will drop this series from my tree
(we will have to skip this cycle) and do the regular merge via your tree
once the dependency hits master on rc1.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

