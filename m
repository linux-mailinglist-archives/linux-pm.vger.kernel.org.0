Return-Path: <linux-pm+bounces-26234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E436A9CE32
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 18:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26DE53BA502
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 16:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE5E19F489;
	Fri, 25 Apr 2025 16:31:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562CF146D6A;
	Fri, 25 Apr 2025 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598669; cv=none; b=sXY/Of+oRV8ugEJzdvGgcqMDWWQ3lhG7PpXLZy5Ktp1MbyujEPMk4TlyKJaEdL0qezV9H1ROG95F8l7glNJVGAHV3Azi9/ssA8E3lycbr/RyduvTs0aSuTX38g+kzS9no9Mv7ApG9sHk3wUTmIudM4HYrmL+Q7wPjGKaCOn8Rqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598669; c=relaxed/simple;
	bh=+r3KDDDcCoZU73+g8zDVRk9bja76Yeq/krqZr93+5Fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8x/IgzNyniTr3pZ+Q9kwyqoOPUCm7XtyHucMbZ/fe05ECr7NbLbO7aEIPGM+UZvpVsqMNdqgsyytkVLN/MNBAVeKo9qfSeNFtnjOyhl0ntL6ZS0u2Thy28Qi5glvlM8E3FtiILA0Sf005JHOj3MUIxLSbqHuF+xEXEM5bB2JRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31E36106F;
	Fri, 25 Apr 2025 09:31:00 -0700 (PDT)
Received: from [10.57.72.192] (unknown [10.57.72.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 943A33F66E;
	Fri, 25 Apr 2025 09:31:03 -0700 (PDT)
Message-ID: <7c583e2e-14b6-40e5-8e12-01584b817e4c@arm.com>
Date: Fri, 25 Apr 2025 17:31:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arch_topology: Relocate cpu_scale to topology.[h|c]
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Ricardo Neri <ricardo.neri@intel.com>
References: <20250419025504.9760-1-ricardo.neri-calderon@linux.intel.com>
 <20250419025504.9760-2-ricardo.neri-calderon@linux.intel.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250419025504.9760-2-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/19/25 03:55, Ricardo Neri wrote:
> arch_topology.c provides functionality to parse and scale CPU capacity. It
> also provides a corresponding sysfs interface. Some architectures parse
> and scale CPU capacity differently as per their own needs. On Intel
> processors, for instance, it is responsibility of the Intel P-state driver.
> 
> Relocate the implementation of that interface to a common location in
> topology.c. Architectures can use the interface and populate it using their
> own mechanisms.
> 
> An alternative approach would be to compile arch_topology.c even if not
> needed only to get this interface. This approach would create duplicated
> and conflicting functionality and data structures.
> 
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Maybe an FYI for the non-x86 folks, this doesn't break anything on the
usual arm64 setup:
Tested-by: Christian Loehle <christian.loehle@arm.com>

