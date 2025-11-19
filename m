Return-Path: <linux-pm+bounces-38197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD70C6C267
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 01:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 935704E7437
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 00:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0258120B80B;
	Wed, 19 Nov 2025 00:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yW/1h2Za"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030A819F115;
	Wed, 19 Nov 2025 00:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763513077; cv=none; b=ObfbjBTZFmZ3Cnb51sTCX70Go6SE5/KwG9Rux+rLgaFihGQ9EosXRdvQiQVt+PRN2W4hi4q6UudpVxFLPAeqlEPU+z7T00Z5sj2ElIX+APCieJhojvupuH987MfyBzH+oZBoKtyt5PRir2jQPjnFVquisiNRJceAm28DNiJFjjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763513077; c=relaxed/simple;
	bh=mOwEHmAKP1mkTS/Bg0jdHtOm15Ou8T+2SWnxEDG1Tb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyt3fmzXds3eebdBIaYUuqHANOFvY3M0Ft9XHDXGjUIoHQSCm6evLwMDb94yxrX9esW7nlaiMObfdrxhJBqfn8NfOLl59C9J03IKIQ9742tw0OJ3rFLC5HjokJitnskzauqJFpYX0SDhkZZ+mkUSq6oNDov32ssg3D8Zb7t+gmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yW/1h2Za; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=2uQCw+Pez+FHNFJ9jUrKN++GY03DxLsS6mPbsPa2Hss=; b=yW/1h2ZaNMBw0GeuoCtz22SwaJ
	AZ2pQOkNspdsB5/ZdEvAwXDgXM0Y5mKgrrU6HopwyrLz7cC15hqEKtLC4p8afOkBhdGO3ctZqjqCt
	ySO+tBSyP+3/KnJRQrowhc621dBp7OGx9tYEHsT/8xciIuKNdfbLuOvfpH6r/wwv4eudhr8YqH9LQ
	7Xhwo+BtIlTBlzjalyjU/creBSJqQRsFLRgtVtvwxaKfnstPUiwpaR5sMA6+mTRDZ1iqUMGzEcCiL
	dcAVaV54iX0vghsMFHOZqzHsLjoKCiDY973Kn6ceC05nnc6geDo7di3qIVuFCZt8ChAfPz/0itrEU
	f/hLTqbQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLWJE-00000001J1C-0KUo;
	Wed, 19 Nov 2025 00:44:32 +0000
Message-ID: <d31c0601-318f-4f85-9982-96bcb5de973d@infradead.org>
Date: Tue, 18 Nov 2025 16:44:31 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: driver-api/thermal/intel_dptf: Add new workload
 type hint
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 rafael@kernel.org, daniel.lezcano@linaro.org
Cc: corbet@lwn.net, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251118223620.554798-1-srinivas.pandruvada@linux.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251118223620.554798-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/25 2:36 PM, Srinivas Pandruvada wrote:
> Add documentation for longer term classification of workload type for
> power or performance.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  .../driver-api/thermal/intel_dptf.rst         | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)


-- 
~Randy

