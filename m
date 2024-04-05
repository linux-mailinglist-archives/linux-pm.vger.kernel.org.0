Return-Path: <linux-pm+bounces-5977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F65D89A2C5
	for <lists+linux-pm@lfdr.de>; Fri,  5 Apr 2024 18:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C9D7B25A09
	for <lists+linux-pm@lfdr.de>; Fri,  5 Apr 2024 16:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580DC16F858;
	Fri,  5 Apr 2024 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jPG+QmFa"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B38D16FF5D
	for <linux-pm@vger.kernel.org>; Fri,  5 Apr 2024 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335399; cv=none; b=gWQd1mdrb0saSGlQaTsP+j6i/uk1WcaM3s5mTI6mCkqJou6hey1j/cPuIALwwYL62zuzHXT73MHcWpMCVHhLGWbuX8TsghU7wGFlZo53HowQ1ZMHlEzPMmunKJZzEaq/vCPlNypyTEgaMW7exhdcTrV3Kq5f/EWs/nSwcK8iN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335399; c=relaxed/simple;
	bh=Du9h33ax/WF9K6k1IOLz20BjM3yy/Y4jIXMjT5Ky/G8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7wYkI4RnKqq6P18AMEqCMN0qwCpqARDjtolR+0k6O/xNId6f75n4Pb/cTNNkO1Ao4vixikWojNT1gV2z5HD9I/wpmqH3cJ9KxV+jE9KqZSHufuOplT0sXt+GC4s4Ges1AN/x6EVXNNs9W2WfP+6U3Hdo8icZ0QVHVdlLw2DijA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jPG+QmFa; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 435GhAiY071880;
	Fri, 5 Apr 2024 11:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712335390;
	bh=Ca6cZ0I77356MxQsWJBLVQCi1Uu6E7lx++J/ouSnSn0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jPG+QmFaYbR7EXl1V7AHRJsJHT49b/oGkys/TOLz0Lk1YAtVKhb37z8Dk9XWX28hC
	 KZSTk0TAI1PFLOOZEcbJrMvG9Dkpmr1wMO2Tb306UWxgnyg8kX3dod61TCkvIyGKZf
	 Q9lydKKINvNIxYpsZK4uBUVM9i88tF7ghCkU834Q=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 435GhAhS014240
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Apr 2024 11:43:10 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Apr 2024 11:43:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Apr 2024 11:43:10 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 435Gh9Ll003177;
	Fri, 5 Apr 2024 11:43:10 -0500
Date: Fri, 5 Apr 2024 22:13:08 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM
	<linux-pm@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>,
        Kevin
 Hilman <khilman@baylibre.com>,
        Doug Anderson <dianders@chromium.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <vibhore@ti.com>
Subject: Re: [CfP] LPC 2024 - Power Management and Thermal Control
 Micro-Conference
Message-ID: <20240405164308.qnxllmdbhzkmtcdt@dhruva>
References: <CAJZ5v0i+G7q0jxLGEnoigWf8Aa=zi4esC3EzethsBkxrp=sCLA@mail.gmail.com>
 <CAPDyKFrUKZ+h37YEhkkLj9ffPtV_gn5_8_dqUrSGNsYn7T_ozw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPDyKFrUKZ+h37YEhkkLj9ffPtV_gn5_8_dqUrSGNsYn7T_ozw@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi all,

On Apr 04, 2024 at 13:31:26 +0200, Ulf Hansson wrote:
> + Dhruva, Nikunj, Kevin, Doug (I probably forgot some of the last
> years attendants, please loop them if you know)
> 
> On Mon, 25 Mar 2024 at 12:37, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > Hi Everyone,
> >
> > This year the Linux Plumbers Conference will be held in Vienna,
> > Austria, on Wednesday 18th,  Thursday 19th and Friday 20th of
> > September (http://linuxplumbersconf.org/).
> >
> > As it has been a tradition for the last few years, I'm planning to
> > submit a proposal for a Power Management and Thermal Control
> > Micro-Conference to the LPC and I'm looking for topics that people
> > would like to discuss in that MC.
> 
> Thanks for continuing to drive this! If you need some additional help
> around this, feel free to reach out to me.
> 
> >
> > The LPC is focused on work in progress and future developments, so any
> > work that has been completed already is not a suitable topic for it,
> > but if there's anything you'd like to do or you are planning or
> > considering in the power management and thermal control space in
> > Linux, please let me know.
> 
> We had a BoF last year around "supporting multiple low power states
> for system wide suspend".
> 
> Not so much progress has been made I believe? (Except for some local
> hacks that I am working on).

A small update on TI end, we have been working on how to support
multiple low power modes in heterogeneous SoC architecture.

TI team will present Low Power Modes ARCH and how we have tried to solve
the issue in K3 SoCs..
Please feel free to join the session on on April 10th 8:00AM CST

https://ti.webex.com/ti/j.php?MTID=m433b5e0c9b1b2edc4296a988c320a2a9

> 
> If possible, I think it would be a good opportunity to continue the
> discussions from last year, assuming people are still interested in
> this topic.

We would love to garner inputs and reviews from the community on what
they think about this. Perhaps we can look at scaling this as a standard
or something on similar lines maybe. It is still in it's early stages and hence
looking for alignment with what the community thinks/expects.

Perhaps the community can continue from this talk and discuss further at
LPC at the PM microconference how things can be made more scalable/
improved if there seem to be gaps to be addressd.

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

