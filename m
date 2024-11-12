Return-Path: <linux-pm+bounces-17401-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC279C5785
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 13:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B231B2796C
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 11:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD6219E992;
	Tue, 12 Nov 2024 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1NfC4brQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF1C230998;
	Tue, 12 Nov 2024 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731411994; cv=none; b=Nx9BxO2TMS9vtsR2UGXRSYu2OZf6PSvT+LGn6PMgrDkC00eBLPzwcKgnKLxKpUKb+BFB+MxwbVjAXEYOjdKI7taL4r1MmYpWhmpUiNJO2qtaDqRa20G/B+yju3/Ra3z4m38P3VDbfK9e6c9Nr9OzHO3GNB58j3k622y6TGU2Wg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731411994; c=relaxed/simple;
	bh=Xf440lkqcE3zW+jdHUvrHRRbPL78ZE5tuvE0WwDreQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdmZzoHvYRjBf7IjgMqPHvdbUQ0kdSLN8y00C6rw3+VD3+lqx+/DRtHo+DWgCSBa9hGEySypSY8zq6Stu+HYlXTw03KrspDaufwTiy0NThbCWN8eWMP5iuSeFfI817GG7G4eUYp8cMv19I2CJj9MlzbD8w6tqR6c1+ovy6k8JOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1NfC4brQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C74FC4CECD;
	Tue, 12 Nov 2024 11:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731411993;
	bh=Xf440lkqcE3zW+jdHUvrHRRbPL78ZE5tuvE0WwDreQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1NfC4brQQFHMQPpmYOuoGDtR1pDBhetDaEp8glJz8aHhr+aTsLOTOiidD0XoYguMb
	 drlQBogXzm4VN8JmYDtlkWanyN4xEBwsisuiS7lPlzS//TWaqneO6lht2EBgoi2zFV
	 ZjH8zJ9vk8ryQVkJewq+oFwWrRiHYieTsnWJAN3g=
Date: Tue, 12 Nov 2024 12:46:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] PM: domains: Fix return value of API
 dev_pm_get_subsys_data()
Message-ID: <2024111257-collide-finalist-7a0c@gregkh>
References: <20241028-fix_dev_pm_get_subsys_data-v1-1-20385f4b1e17@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028-fix_dev_pm_get_subsys_data-v1-1-20385f4b1e17@quicinc.com>

On Mon, Oct 28, 2024 at 08:31:11PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> dev_pm_get_subsys_data() has below 2 issues under condition
> (@dev->power.subsys_data != NULL):
> 
> - it will do unnecessary kzalloc() and kfree().

But that's ok, everything still works, right?

> - it will return -ENOMEM if the kzalloc() fails, that is wrong
>   since the kzalloc() is not needed.

But it's ok to return the proper error if the system is that broken.

> 
> Fixed by not doing kzalloc() and returning 0 for the condition.
> 
> Fixes: ef27bed1870d ("PM: Reference counting of power.subsys_data")
> Cc: stable@vger.kernel.org

Why is this relevant for stable kernels?

thanks,

greg k-h

