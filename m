Return-Path: <linux-pm+bounces-30399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9327AFD865
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 22:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F1E175A38
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 20:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F51B20468E;
	Tue,  8 Jul 2025 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3oYQMAJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E782214A60D;
	Tue,  8 Jul 2025 20:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006776; cv=none; b=mjDIGqYSQRMcsVvuKSnuc3a9mWbmZEqICpQeA/gBE+STE1vU3iI1vJr2YpUMHnTo0DYyPGsJl/Ya/GP+4Y/7v5CUZWEJipgXEE61/1qr3DAe/GnDncs+s+l/A2tRfvTPAOMuGomiumLsNw+18dTL1ofN4/XIimIKa0Z8cpzR+/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006776; c=relaxed/simple;
	bh=v6IjWxZZvdKzFozdZoIQf7kco0spsknEBjNgMIsauWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuTHcXlfaZ8Y0Xh9zIuKvi7H8W9g1qTD69GjN9H3R5g3cXT8V8Nqsh+HSGKfpeBHZ3sMWTzUkRaNmVn73JAfl57+gv9TXrGjn+hgzkm+OzqBLPfE59yS9qFsq/D238FTpPb2+SdyUdfV85UQNy3zIhiMM8sP1FUTutYZmx1xDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3oYQMAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23896C4CEED;
	Tue,  8 Jul 2025 20:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752006775;
	bh=v6IjWxZZvdKzFozdZoIQf7kco0spsknEBjNgMIsauWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n3oYQMAJbbtIRjSqTkO2jJFyn19sEQMBMiez2bhii/DjTk9DNmJ8QEIWDBp5gILUn
	 RIuKSomvRIsESpQ8ktgMTK/Z+y/UsYPBI9jmn5vgGMJrPrmUDHjGnj4jbM1kAJJvEk
	 Uh8R8AamuVT3jmDDovVkwZqDzk1tzmks4kwJDlfOXKubD/mZvneiMOt6FJz/r7E1qf
	 hkEgLj3zWdxdnnYDE1LpKxayPBMLMOaNbV1RqIHEAbN2aXGfT9qMWBo5nJCAWIlhvD
	 PG+ehluhiZ5K9BNdyboVdP2PNr7DKDb8oAaXonAaT1omgpXDxs11DOY10q2WcIl75b
	 9PLKYDNjC7pnQ==
Date: Tue, 8 Jul 2025 16:32:49 -0400
From: Sasha Levin <sashal@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
	linux-pm@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <aG2AcbhWmFwaHT6C@lappy>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87ms9esclp.fsf@email.froward.int.ebiederm.org>

On Tue, Jul 08, 2025 at 02:32:02PM -0500, Eric W. Biederman wrote:
>
>Wow!
>
>Sasha I think an impersonator has gotten into your account, and
>is just making nonsense up.

https://lore.kernel.org/all/aDXQaq-bq5BMMlce@lappy/

>At best all of this appears to be an effort to get someone else to
>do necessary thinking for you.  As my time for kernel work is very
>limited I expect I will auto-nack any such future attempts to outsource
>someone else's thinking on me.

I've gone ahead and added you to the list of people who AUTOSEL will
skip, so no need to worry about wasting your time here.

-- 
Thanks,
Sasha

