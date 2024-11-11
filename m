Return-Path: <linux-pm+bounces-17330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EBE9C410E
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 15:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2AE1F23AE7
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 14:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4D919D060;
	Mon, 11 Nov 2024 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YGuuhp2e"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE4B155A34;
	Mon, 11 Nov 2024 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335747; cv=none; b=Oh/DOZDehXzY5DGaIYG0DLSuvfTmU8wd3wvZvhFQvnBk/6e3UGgcafrcWi6lK7uH0EwXtt6NRNATbfjTCi/RjR/m4qRTsHOs7/wNmz9RnKBg/+bc3laDrIdhjxlvI6qo1ZbxHiLZpBND0v7W0t2B0h9v1nAriEbcXRSfrSYPS5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335747; c=relaxed/simple;
	bh=FbpQDgrATLQrby7+vyaOzgg3QuyaUVc+zF0xtLbYzvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZw0kG4rFQNQU6gSfikFrcsJ6bw0lwXDk3HE5m8qLzdBGqmYyeh/mMVFt6es525I0n2KbU2N/KvmYo6oPeUED/PqRIrkPoy5jgnj18Af5hgd0E+rho8uMSLAYOiSvDzPhP97sqDs1kBpKUbaP00wG2oh/gkeuFh2yNVYRkNtbWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YGuuhp2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23374C4CECF;
	Mon, 11 Nov 2024 14:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731335746;
	bh=FbpQDgrATLQrby7+vyaOzgg3QuyaUVc+zF0xtLbYzvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YGuuhp2eKe5RhGikIH11KvGiSWpo7Zwn64x/EbyDwDGcBJSIs/Xl6qOQCSUDGx7ba
	 sHn16LZSB9dlPKtPrYGXEuvumvUi5BBRQkTy0YRHaNePyZ7XmXObyjh0DoUbaf5kYj
	 +K/Kp3jOPTsIePXJnRHBa278dQsQlI+IncpEvWso=
Date: Mon, 11 Nov 2024 15:35:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 6.13
Message-ID: <2024111100-lustiness-managing-f937@gregkh>
References: <20241111134304.1019885-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111134304.1019885-1-djakov@kernel.org>

On Mon, Nov 11, 2024 at 03:43:04PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the v6.13-rc1 merge
> window. It contains new drivers and clean-ups. As always, the summary is
> in the signed tag.
> 
> All patches have been in linux-next for at least a week. There are no
> reported issues. Please pull into char-misc-next when possible.
> 
> Thanks,
> Georgi
> 
> 
> The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:
> 
>   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.13-rc1

Pulled and pushed out, thanks.

greg k-h

