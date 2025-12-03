Return-Path: <linux-pm+bounces-39168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 506AECA039A
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 17:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9CA93002A4F
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 16:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF214329C61;
	Wed,  3 Dec 2025 16:44:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E386C19258E;
	Wed,  3 Dec 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780276; cv=none; b=XcanDDeWbXcrqEuwAAGLTJqSLQiblNKKDUZUDatSMX09n59QoKQPbBA9cX+ugZwGZVEavTleLJ7hcqYFXhID5CjDUIvvUrO2jEc5aov+jFRScyywp9My+UPA1xFJTgNG0GcsvgrsjqcjtJHs5jlOZn1jDVwoNWaN7GMAaw1dD+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780276; c=relaxed/simple;
	bh=HEuqkLKJeLwonYbhFqrBWQcMiVnNbV38FGG2d9ZwBGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tm9IUvPEbYBojeBxrnukvqgHn12cxD7zk3kNqWy5hmCEYpNToZ4bKLzhgn3hwpETWkK3RGn6V0r0bnFzLl6Y0Hwvi85vc8eYTniSnVNd/T7zGGI2C1kjuZ4R79d10AZSWw0Y0rEi9ME3zHs0M75wm0XdiKKMdAjNQFTWjhsoiRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDB55339;
	Wed,  3 Dec 2025 08:44:26 -0800 (PST)
Received: from [10.1.32.62] (e127648.arm.com [10.1.32.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DC113F66E;
	Wed,  3 Dec 2025 08:44:33 -0800 (PST)
Message-ID: <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com>
Date: Wed, 3 Dec 2025 16:44:31 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/3/25 16:18, Harshvardhan Jha wrote:
> Hi there,
> 
> While running performance benchmarks for the 5.15.196 LTS tags , it was
> observed that several regressions across different benchmarks is being
> introduced when compared to the previous 5.15.193 kernel tag. Running an
> automated bisect on both of them narrowed down the culprit commit to:
> - 5666bcc3c00f7 Revert "cpuidle: menu: Avoid discarding useful
> information" for 5.15
> 
> Regressions on 5.15.196 include:
> -9.3% : Phoronix pts/sqlite using 2 processes on OnPrem X6-2
> -6.3% : Phoronix system/sqlite on OnPrem X6-2
> -18%  : rds-stress -M 1 (readonly rdma-mode) metrics with 1 depth & 1
> thread & 1M buffer size on OnPrem X6-2
> -4 -> -8% : rds-stress -M 2 (writeonly rdma-mode) metrics with 1 depth &
> 1 thread & 1M buffer size on OnPrem X6-2
> Up to -30% : Some Netpipe metrics on OnPrem X5-2
> 
> The culprit commits' messages mention that these reverts were done due
> to performance regressions introduced in Intel Jasper Lake systems but
> this revert is causing issues in other systems unfortunately. I wanted
> to know the maintainers' opinion on how we should proceed in order to
> fix this. If we reapply it'll bring back the previous regressions on
> Jasper Lake systems and if we don't revert it then it's stuck with
> current regressions. If this problem has been reported before and a fix
> is in the works then please let me know I shall follow developments to
> that mail thread.

The discussion regarding this can be found here:
https://lore.kernel.org/lkml/36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7/
we explored an alternative to the full revert here:
https://lore.kernel.org/lkml/4687373.LvFx2qVVIh@rafael.j.wysocki/
unfortunately that didn't lead anywhere useful, so Rafael went with the
full revert you're seeing now.

Ultimately it seems to me that this "aggressiveness" on deep idle tradeoffs
will highly depend on your platform, but also your workload, Jasper Lake
in particular seems to favor deep idle states even when they don't seem
to be a 'good' choice from a purely cpuidle (governor) perspective, so
we're kind of stuck with that.

For teo we've discussed a tunable knob in the past, which comes naturally with
the logic, for menu there's nothing obvious that would be comparable.
But for teo such a knob didn't generate any further interest (so far).

That's the status, unless I missed anything?

