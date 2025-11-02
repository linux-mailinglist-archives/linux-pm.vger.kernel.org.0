Return-Path: <linux-pm+bounces-37249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 612A5C289B6
	for <lists+linux-pm@lfdr.de>; Sun, 02 Nov 2025 05:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 051A94E039F
	for <lists+linux-pm@lfdr.de>; Sun,  2 Nov 2025 04:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A420D15E5BB;
	Sun,  2 Nov 2025 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UxSRBHlh"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9552A1C7;
	Sun,  2 Nov 2025 04:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762059373; cv=none; b=IQpCRFdyfSJWtOWYoAVDT0q9/Cu5Nqp93W5kK1Y+vjdf0piQM9bx4rkrz5aRTBHve2yDGWsc/TAHzlvdqzGoSf3cGRyJGx2fkPxQbFCVJQIH/JLqtks2tgKKZfGTbbBXEcdklzV2ag+I+2tCV0Em1KUlOnpJcD54PISddf3RQRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762059373; c=relaxed/simple;
	bh=UKwMVO2jsy2bTC3jNyXPK8/hJrNqCl+KM/9kHX5Htmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bb1i7feDrE8iwztSX5539yfLWKgyXySloXzKoOGoRdFZvS1nQMakRntDv/aUh3m/yXw0ZKA8hXwdnqYCTL/OTDTZ7gKkvzwuFjBRjtk9iqxViYJeP+cgTBFXoWbeWJ26+Yw3iokfBSStW1KkxPVEH+AdWUluChzEOP74fNhvyRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UxSRBHlh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Vb+txYW6y/jeP+lYT4EqkhxrKccykT/2pDwBZC5uhYM=; b=UxSRBHlh2I7n33THM6g0bha6f2
	03l6hGtc+mGJHFWikUg6dOkMcbnx/e8Fe9ssNvOvn5ViinI0qgz6av5yDNoJqfmldN62nLU4DyPi6
	14lkHsKOJW7LDhwVqgWg6GG4A9/buvy7lJlY2xIFa6vlCShFEjXbTj6SxXAqvbFSJZ0+btAsWwgGN
	3rEaZev/Nvz3xSbS9ucvK4ngsvr3MqpKYATpVp3EzkftFxWzlNt5OsnxZ6tOa73JXMnnjEbrbo6Q5
	yAirW/Qz+NsFl9POO2iRONeXWIxGLzpqIWct1sFu9mH66raZ/Ra6Svh/2WKsTVmdWvWCwTvxbGTVc
	d4otM+pw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFQ8M-00000008Ioo-2o3C;
	Sun, 02 Nov 2025 04:56:06 +0000
Message-ID: <d5584bfb-d138-451b-96e8-02347886349f@infradead.org>
Date: Sat, 1 Nov 2025 21:56:05 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: intel-pstate: Use :ref: directive for
 internal linking
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Power Management <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>
References: <20251101055614.32270-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251101055614.32270-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/31/25 10:56 PM, Bagas Sanjaya wrote:
> pstate docs uses standard reST construct (`Section title`_) for
> cross-referencing sections (internal linking), rather than for external
> links. Incorrect cross-references are not caught when these are written
> in that syntax, however (fortunately docutils 0.22 raise duplicate
> target warnings that get fixed in cb908f8b0acc7e ("Documentation:
> intel_pstate: fix duplicate hyperlink target errors")).
> 
> Convert the cross-references to use :ref: directive, which doesn't
> exhibit this problem.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

LGTM. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/admin-guide/pm/intel_pstate.rst | 133 +++++++++---------
>  1 file changed, 70 insertions(+), 63 deletions(-)
> 

-- 
~Randy

