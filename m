Return-Path: <linux-pm+bounces-30403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CA4AFD8AB
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 22:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3271BC64A8
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 20:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB101DB127;
	Tue,  8 Jul 2025 20:46:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB9C3C01;
	Tue,  8 Jul 2025 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007603; cv=none; b=s6PwwvBWF5RSaiGV7aRo45NxpqMnqO2nEopdaap9RPyk8zJVjH+0raF1aON3Z9fWFHD22md8k94vb3npEVNnlcUpt8xMK71o77XgC8e9JIGB1yGPiVyI0lJ+i4C74y01pJmDVC+5k+kRxYfiTxMpU84LqcLAAZP8jgu0OTs7ujQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007603; c=relaxed/simple;
	bh=OmBmPp7dnyJhHvmfusM1u8JnCW7ZfYNHJ8zqzo/YFdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGFFGDLBOISWR1I2b3pTIRTe3Gp64PFLdXnTQzS+JZa6EohIPlsingdiinYO6xtqrsBgV7+XMDJ+NagOS2g5/fa2BsYaVcEc3+hq/1SpOpI0cg2PhPmAjHriteYFB0DLCIjVNVNuUeZOkeg5/AU1tB0/ZOvYA8haoo1hUllJW1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 568Kk7On005652;
	Tue, 8 Jul 2025 22:46:07 +0200
Date: Tue, 8 Jul 2025 22:46:07 +0200
From: Willy Tarreau <w@1wt.eu>
To: Pavel Machek <pavel@ucw.cz>
Cc: Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, patches@lists.linux.dev,
        stable@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
        Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, rafael@kernel.org,
        len.brown@intel.com, linux-pm@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <20250708204607.GA5648@1wt.eu>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
 <aG2AcbhWmFwaHT6C@lappy>
 <aG2BjYoCUYUaLGsJ@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG2BjYoCUYUaLGsJ@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jul 08, 2025 at 10:37:33PM +0200, Pavel Machek wrote:
> On Tue 2025-07-08 16:32:49, Sasha Levin wrote:
> > I've gone ahead and added you to the list of people who AUTOSEL will
> > skip, so no need to worry about wasting your time here.
> 
> Can you read?
> 
> Your stupid robot is sending junk to the list. And you simply
> blacklist people who complain? Resulting in more junk in autosel?

No, he said autosel will now skip patches from you, not ignore your
complaint. So eventually only those who are fine with autosel's job
will have their patches selected and the other ones not. This will
result in less patches there.

Willy

