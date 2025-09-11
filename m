Return-Path: <linux-pm+bounces-34462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD28DB5320D
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 14:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870B75867FE
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 12:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D273320CDD;
	Thu, 11 Sep 2025 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j0OsoiFs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640372D238F;
	Thu, 11 Sep 2025 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593698; cv=none; b=OOkocSK/x+i4WevttSZzov+4hhEXxdRZ2cNLsXOfgwiXHpABgvZcyIO3TsPY0QoXyvCUs5L0zk2WkXSaJZhgxxpIoR+noYnloM5O4voWP0suqjp/BuUHeWIt8aLYH4hK8refnRSdYoA1JEM0J14hbDRtSMe6Ewx/u2s6moiVXrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593698; c=relaxed/simple;
	bh=yMm15wm7p6yVRRHMtojewEs35ZvuYj2fnBFo76gA58c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qq/fLD9IARhy/X/aulLc+CCWLiyg3C2tKvVcwViRjA8D5MxcJz9CJ2U8CF9Oip6s4ibExGQ0wPgECdI5CI2sGm1Swdk3AbG8vS3V2zOVuU9cmUrXriEYA9RYFgtgVgnaXeWBsOiMiyy1byXKfnoMm77CT0mXfEATpwPQSxSXXS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j0OsoiFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6DAC4CEF0;
	Thu, 11 Sep 2025 12:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757593698;
	bh=yMm15wm7p6yVRRHMtojewEs35ZvuYj2fnBFo76gA58c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j0OsoiFs4yi/hN07JhGsEabSS1Rfga8QjhFg9Ke98bZ+/xQq44QL1R/7mlGLhuZD9
	 0beK5Sn4H48gkBetSowIsis3enXM2rhZ5Yc5LihPMu3x61TT3Pi16EjxSK3MYVuELs
	 pf8tSbh3zqrwgXfP+QT502buCklQ2E3jNRnL2isg=
Date: Thu, 11 Sep 2025 14:28:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pin-yen Lin <treapking@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>, linux-pm@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] driver core: Export
 device_link_flag_is_sync_state_only()
Message-ID: <2025091137-breeding-cannon-1384@gregkh>
References: <20250911112058.3610201-1-treapking@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911112058.3610201-1-treapking@chromium.org>

On Thu, Sep 11, 2025 at 07:16:02PM +0800, Pin-yen Lin wrote:
> Export device_link_flag_is_sync_state_only() for future patches.

That says what, but not why.  This feels like an odd thing to export,
what should care about this type of thing?  What should a driver do
based on that information?  We need more information here.

thanks,

greg k-h

