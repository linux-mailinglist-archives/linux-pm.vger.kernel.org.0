Return-Path: <linux-pm+bounces-27519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F7EAC10F8
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 18:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D561BC5BB7
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 16:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5E123959D;
	Thu, 22 May 2025 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UhmPRr5y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B245A45C14;
	Thu, 22 May 2025 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931232; cv=none; b=i1WqdrdLGcLOh4AkadEIDdAExw0CQyCvt00MxBpC05a+4YM0uHfmODXt+91OaNQ6sT1QpyeD8MqN4LX7HowxcQibsxSzFUbhrnJsUDLvcrdnqwclgXJxrxEu40RMaec7H0gWA1k2I9Oe2mAQZK/ZOR+Jh8EXRXj6wD/nyAoZIRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931232; c=relaxed/simple;
	bh=oqHXaE7Qd0kijQCVXKTXRe6csmfxNAjNVGFmSTMpOEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sS/1Kv8eZa0Qpbco1z3n8XR6VPAHblWVazwmDhsMaw880Ubv5UsYgNX58SOS+NA/dsszSFqEw8ZzprroQ7QQF8ITttcJNlHMoP81Ye+wijRRBs8+8QEJ7wSjN+/qN0QwL7wv8iMgH+wvCuoq5826HKeGMRi97+K64HPy00eXnbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UhmPRr5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC816C4CEE4;
	Thu, 22 May 2025 16:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747931232;
	bh=oqHXaE7Qd0kijQCVXKTXRe6csmfxNAjNVGFmSTMpOEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhmPRr5yU7gvXHwmywUjRlfxeT47Gp7UtimQC5HCD8Rh9zhLJMNd5/DVA/UihRwAU
	 x39tPxq7g+hHQ0OiskSuUsiWu2Dxzq2j52lEnIE9P3QVdc8ZZ/AHk8Zw6Jgf2mWAHu
	 Bch19agoCjcc9cb9RZQrp2cTyBupJ8nhb/IXAzck=
Date: Thu, 22 May 2025 18:26:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 6.16
Message-ID: <2025052234-fragment-these-d90c@gregkh>
References: <20250522160331.2666873-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522160331.2666873-1-djakov@kernel.org>

On Thu, May 22, 2025 at 07:03:31PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the v6.16-rc1 merge
> window. It contains core and driver changes. As always, the summary is in
> the signed tag.
> 
> All patches have been in linux-next for a while. There are currently no
> reported issues. Please pull into char-misc-next when possible.

Pulled and pushed out, thanks.

greg k-h

