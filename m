Return-Path: <linux-pm+bounces-4796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CC7876956
	for <lists+linux-pm@lfdr.de>; Fri,  8 Mar 2024 18:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319D11C21944
	for <lists+linux-pm@lfdr.de>; Fri,  8 Mar 2024 17:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E540624B5B;
	Fri,  8 Mar 2024 17:09:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E1B1D54C;
	Fri,  8 Mar 2024 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709917747; cv=none; b=dV+FMWZCAV9HPO9PsG9lVnT7ZIn0SqRF2r8F1h95Dk9w9tDsnqax5Jaxtb33qjEMe1ZPVlxIFzR5jYM0mRZbRWZqbufJ3qamvncf+cl8Fiady7qB3jhBNJSlTXTxvBmogT6PeGtC6iq7trYM09eDtZtEHZbQWcz4lXnP6G+oh/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709917747; c=relaxed/simple;
	bh=MrRey84BnRt8XomMHDSqE3P0tm/wi8nF6bQhaKV/msk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PbJxP+6oqET3c252c3P8S3UisyKN2Vhd+qggi0LiAzkKMaS1R3oRXkZnmaXwg4T0FILujyo5r+3xbQFhVjKJYbO0zjJcPHkCimNz2eOJBo6+0tNnxr5ZNO8JisS0ezS1cDwV1gmQNegBgBzv4BxCboRuOJ7O8z30Ket3ZdG5iQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id A0A2D40A96; Fri,  8 Mar 2024 09:08:59 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 9F50A40A93;
	Fri,  8 Mar 2024 09:08:59 -0800 (PST)
Date: Fri, 8 Mar 2024 09:08:59 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
cc: Catalin Marinas <catalin.marinas@arm.com>, 
    Mark Rutland <mark.rutland@arm.com>, 
    "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <vireshk@kernel.org>, 
    Will Deacon <will@kernel.org>, Jonathan.Cameron@huawei.com, 
    Matteo.Carlini@arm.com, Valentin.Schneider@arm.com, 
    akpm@linux-foundation.org, anshuman.khandual@arm.com, 
    Eric Mackay <eric.mackay@oracle.com>, dave.kleikamp@oracle.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, linux@armlinux.org.uk, robin.murphy@arm.com, 
    vanshikonda@os.amperecomputing.com, yang@os.amperecomputing.com, 
    Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
In-Reply-To: <f160a532-1d31-41a7-b8ae-de8575c395e9@samsung.com>
Message-ID: <e3952dc0-ec28-e7c7-e858-c47f146c93de@linux.com>
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org> <CGME20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f@eucas1p1.samsung.com> <c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com> <ZesmAO1jJfEjTwxd@arm.com>
 <f160a532-1d31-41a7-b8ae-de8575c395e9@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 8 Mar 2024, Marek Szyprowski wrote:

>>>
>>> It looks that cpufreq-dt and/or opp drivers needs some adjustments
>>> related with this change.
>> That's strange. Is this with defconfig? I wonder whether NR_CPUS being
>> larger caused the issue with this specific code. Otherwise
>> CPUMASK_OFFSTACK may not work that well on arm64.

cpumask handling must use the accessor functions provided in 
include/linux/cpumask.h for declaring and accessing cpumasks. It is likely 
related to the driver opencoding one of the accessors.

I.e. you must use alloc_cpumask_var() and not allocate yourself on the 
stack.


