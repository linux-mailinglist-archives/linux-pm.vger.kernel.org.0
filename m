Return-Path: <linux-pm+bounces-10861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5237492B9C9
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 14:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3A42860F1
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 12:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9BD158DB7;
	Tue,  9 Jul 2024 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P66Lbqbq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0742B9D4;
	Tue,  9 Jul 2024 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529124; cv=none; b=nK44GwGl+wor8e39rOdi5VSSr5X26ROOfbU47bmr6VRoo8B/AS73rXKkFU2liYLpzCLSLLp47P+LfOFk5YQYJT+8itMl6KDiQiFTS/P7+e0F82omrrjlyXhXXIid+GAfrZMJd9zwIg6RFSv6VvxZnbP2v52lZAvZ97BsmtdkN6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529124; c=relaxed/simple;
	bh=I/KbFd03uWaw5ObvrAXe2JPZpsVSvwX/K6x2h7xFdiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNdLPY7irzCX/iKPP1kZsSxEidEP/zRcKXiw0BCbOEXIipVeootcdCRivmUzuqtqYBoXekEprZ6FwxOuwlrktUDhCgVFE1h8cicAHMD+TVmyUPqsU6xt4ioV7uUBAtr17zG2VPe0vOooV9lbHYgvj3jGVfJmtnQSayrAgtuKxgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P66Lbqbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C44EC3277B;
	Tue,  9 Jul 2024 12:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720529123;
	bh=I/KbFd03uWaw5ObvrAXe2JPZpsVSvwX/K6x2h7xFdiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P66LbqbqP3lk352KpnhBvU7cl8H6A2zgncurYrmeRDHUeEAFfH72O7zVBk1faAPDI
	 AJ1K7TqnbufIYbMwnpbR22i4JD2SOU0BtsBu4c/KahLn19FRfJSbYwKpOAVCoqmmo6
	 vg4N4DJau/w50AAhDXimEG7QWuLESrbRbBBZ08KI=
Date: Tue, 9 Jul 2024 14:44:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 6.11
Message-ID: <2024070943-overcook-impaired-5415@gregkh>
References: <20240709112134.782462-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709112134.782462-1-djakov@kernel.org>

On Tue, Jul 09, 2024 at 02:21:34PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the v6.11-rc1 merge
> window. It contains some new drivers and bugfixes. As always, the summary
> is in the signed tag.
> 
> The patches have been in linux-next for a while. There are no reported issues
> currently. Please pull into char-misc-next when possible.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:
> 
>   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.11-rc1

Pulled and pushed out, thanks.

greg k-h

