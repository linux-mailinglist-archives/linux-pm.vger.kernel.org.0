Return-Path: <linux-pm+bounces-29946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3686DAF07A9
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 03:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34899423D06
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 01:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD3620311;
	Wed,  2 Jul 2025 01:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DVIaCSBY"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71093184;
	Wed,  2 Jul 2025 01:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751418200; cv=none; b=j1sWwNg6sii8Syv2wUDsIG88GIT4mPLN+jWcmrAM6RpOWIVpdFK1+AJRFk7pT4Ov+kNjoZLKb1TX0C5fyUWBnW1K3swAVeWmRCGqC6goob72AXiWtMjkmb26NyjjnY5wApIOUc7TW43AOyaGoAEGoSPb8AvlQYwec/3J5Vvpjfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751418200; c=relaxed/simple;
	bh=OapyYVIXFArJPdskPNLwsfjyXA5aLXBF8cUgnBHEV0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dt+PnDQqAuR1OFVnxpzCci9jIVYzk0rHXjcnIw5hTzke2M9lv5M4yBmNR1C99VblXjbFz93oQpuUK/dyADp6w5OdWjDy140YQkDNy/386yJb6iksFaP0iZmnb7KI6TjQEnxRBzBB3i4YtQTUwGPZlollXtN62P4/4UqWnyDpKBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DVIaCSBY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wGaxGr5Oz7lGQNzDoTUm1ZufeP9AUB1h74OwAJtnv1U=; b=DVIaCSBYJBFLhbSFqjRJiTu/rx
	Eu6QZwqPUZEFtyBhRRm8G0gIjlkwrWpXGdLtIYIsDkT41o0P4Kak/kPxoxTvYDqD/D7bYbAhIIZqF
	bljQZI6Bj5itlauAvSjBAQiCahOe08VBCIS0LbZyfyHBssJDf+SZxzMs8nhfI1pkvYPHS1rhghT3B
	J3eEo+6FrZ5NVtIqW1kL7Yh7x54guvfrItv8F8Ze71o6TDJicQRWKSap+jL0TZTOEmbl1X6rApRky
	yk348sLBexQLR9LNrO6sRNQrtHloVgBtfS0ohv6eOSOeFbqr0wx1vQcqZy5CZMAGzWCqe0RXpkwYc
	XjfIhcPg==;
Received: from [59.10.240.225] (helo=[172.28.113.206])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uWlsK-00BFEb-Kt; Wed, 02 Jul 2025 03:03:01 +0200
Message-ID: <99c6cb28-3ab9-45a7-8bac-2598c0e2a59f@igalia.com>
Date: Wed, 2 Jul 2025 10:02:51 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] PM: EM: Add netlink support for the energy
 model.
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>
References: <20250613094428.267791-1-changwoo@igalia.com>
 <b74f6484-dd16-430a-bad9-4dca6384d1dc@igalia.com>
 <5afe2400-659d-40d8-ab4f-33a1b250ac85@arm.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <5afe2400-659d-40d8-ab4f-33a1b250ac85@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lukasz,

On 6/30/25 19:07, Lukasz Luba wrote:
>> @Lukasz, @Rafael -- I have a question related to the energy model
>> in general. As far as I understand, the energy model describes
>> the performance-energy consumption tradeoff when a single CPU in
>> a performance domain is running. However, in reality, SoCs may
>> have thermal constraints, which would result in additional
>> constraints. For example, running all CPUs with the highest
>> frequency may not be possible. My question is this: does kernel
>> maintain and use such (thermal?) constraints?
> 
> That's true in real scenarios on mobile SoCs, running with max freq
> on all CPUs is possible likely only for short period...
> 
> The Energy Model itself doesn't handle such situation. The code in
> thermal framework and in Energy Aware Scheduler has feature to handle
> it and know which top OPPs are not possible to be used.
> 
> Although, the EM in such situation is likely to be adjusted, because the
> SoC temperature reaches high values. Especially if that heat was
> generated by the GPU not CPUs themselves, then it's extra leakage will
> be accounted and EM data modified in runtime.
> 
> Another scenario when the EM might be updated is when Middleware
> will recognize a known 'scenario' e.g. long video conference
> with camera in use (thus Image Signal Processor, which also can
> heat the SoC, like GPU). Or a 'preferred profile' for light-weight
> application using some HW decoding, e.g. video playback and
> thus some CPUs are more preferred by EAS to be used in it (EM might
> change the energy efficiency gently for such CPUs).

Thank you for the explanation! Besides this, do you see anything that
needs to be addressed in the code? Of course, I expect there are. For
the one reported by the kernel test report, that is the obvious one, so
I will address it together with your and others' feedback

Regards,
Changwoo Min

