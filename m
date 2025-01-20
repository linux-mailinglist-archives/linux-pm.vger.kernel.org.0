Return-Path: <linux-pm+bounces-20690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B165A16C16
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 13:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60991638BA
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 12:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8500A1DF991;
	Mon, 20 Jan 2025 12:10:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38061B87EE;
	Mon, 20 Jan 2025 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737375040; cv=none; b=k4P7Ua15YKEALHmK1y0lhO6SVGDl4SBMidKUw7Q9/fkt64HaZDYu4w/h1do2w1E1QgTjmJOMDGMdUvTyy0MF7U9nYwqKKhfX+XHfZSnVIuwpFNBoFfg0C2GnfyHql4d4sZIvEPhA3jBHQCx+MGzYjzsBoaZCDY8unSEjgZhaMWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737375040; c=relaxed/simple;
	bh=39uNqRs8B4cI2gS3hzZcetFaW9OmRZhi9VSPagCE3sI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZRru69Q1Lay3Cgg8qbIClHhve4Fqe+BcJdtzATetheap38DBg2KRhU/7prsYtMz4vzDO1GCfMx1fIKS943tQsuEH1NsWZ5L+vCH4eJulMwA4NK9vZAg0IgqY80UcltBqQ+iHht1I8lKysmG66WoLuNbegfQgszMJbaMhmSKDF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B33141063;
	Mon, 20 Jan 2025 04:11:06 -0800 (PST)
Received: from [192.168.3.143] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 104C93F66E;
	Mon, 20 Jan 2025 04:10:36 -0800 (PST)
Message-ID: <b4a607b8-ab85-4935-b48f-b370d37fbf32@arm.com>
Date: Mon, 20 Jan 2025 12:10:35 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 8/9] cpuidle: teo: Simplify handling of total events
 count
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <6116275.lOV4Wx5bFT@rjwysocki.net>
 <9388883.CDJkKcVGEf@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <9388883.CDJkKcVGEf@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/25 18:50, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of computing the total events count from scratch every time,
> decay it and add a PULSE value to it in teo_update().
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

