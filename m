Return-Path: <linux-pm+bounces-37907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C975C55D83
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 06:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1971C3A7C10
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 05:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B16287246;
	Thu, 13 Nov 2025 05:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X7to76zb"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D7026CE37;
	Thu, 13 Nov 2025 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763012989; cv=none; b=VmhH8V7awW3gJuaHDoBJ7nHIJhM6yLxjApJ4QiuA+5QRPqqSYPCcQrRLMdxLT8VLHvHYwSye++Z/nRUoviyy1zmEKOVf2Hqo1QhKW6Al/EQ0nA89jbT3VFH3wGymqZv2sTTwRqi9BYD8z6BZP9WRtkx3j4vQPxJOvh0q+cF2nHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763012989; c=relaxed/simple;
	bh=7ZiRvHjbMGWBfhk5NwhXC4qpFap2iU87gi7cfePgl5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LyCqU3K0inOM4Q6TnFm9Dnq1MbpJAPhTKEOZPHADTwE3RpTujgth8JFMRgq/CsrlkficVL+EN1/fkMVI/Is5b5/au6S9aW8GLQGKVRnzl5fb0nngzSib1CsRak9/0CyJhMSoGahB9cIimVJX1Cl1z91xnII7c13YNEDERinpuFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X7to76zb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=GCe4Zjz8W1fV5xynYXnvbHYwkLDwMzTsR2SDYFPEHBg=; b=X7to76zbrnFXOs2tT4dGCYmrkX
	TQ5OgHpKxBKb8blY6morV4E4bBGNByo3fUPWXc1MD3AxnhL3HqKrGNxuC/L+AQ2tHXCI6xYh7CMIQ
	8pwP498mA1C2Ghj27pBaTFnLR5HsiRLbGKG7KwwgeU2Pcub+4YA9BWmB4zY7PtgsWQXTTKt6lNkVn
	0yRxK+TgqsuCkgZD6p3XMb72Yd8+PeufzDJSscX1e5e67F1UYhoHuIeGvrg0ok5upnfDvs4mqt7xe
	d9CTtj05Sid99afTp34zyQuM5jkKrLWc4XMNPhLky15a/lqF4mpaQG9Sc1iLVjsLONTUn4a/u9kwj
	KQZy/cKQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJQDI-00000009vyT-22C7;
	Thu, 13 Nov 2025 05:49:44 +0000
Message-ID: <9b1e04c2-03f0-44d0-88f0-757a51a6d79d@infradead.org>
Date: Wed, 12 Nov 2025 21:49:42 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: thermal: Add documentation for thermal
 throttle
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 rafael@kernel.org, daniel.lezcano@linaro.org
Cc: corbet@lwn.net, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251113014116.196638-1-srinivas.pandruvada@linux.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251113014116.196638-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/12/25 5:41 PM, Srinivas Pandruvada wrote:
> Add documentation for Intel thermal throttling reporting events.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/admin-guide/thermal/index.rst   |  1 +
>  .../admin-guide/thermal/thermal_throttle.rst  | 84 +++++++++++++++++++
>  2 files changed, 85 insertions(+)
>  create mode 100644 Documentation/admin-guide/thermal/thermal_throttle.rst
> 

-- 
~Randy

