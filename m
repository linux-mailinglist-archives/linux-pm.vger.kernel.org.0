Return-Path: <linux-pm+bounces-14283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B4F979133
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 15:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C9A1C21655
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 13:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2BF1CF7B7;
	Sat, 14 Sep 2024 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ODBWaKjU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317A11CF7B0;
	Sat, 14 Sep 2024 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726322222; cv=none; b=QtaJaS1QNhw5MTh5wBEZ4LoKd1zTS5xRaCLBSiGIFFBELgRWMPNsFUb9UKx4lAYllrSQnOAs/zGzNHCq4k3u3YEK1qQ36NzUOmyKX/iZ4iuQWs4IjrwkuQHtZCT1KMFm1Feb1dnaweAYaxbOFZcRtlznH/NPLPim0PaBYxVZQTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726322222; c=relaxed/simple;
	bh=ie70IUC/8eBlUGA1UDVhkaygWl6th5H5LZRStq9HwoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMrzJipeFC6eeBNohC+VRs5ktvuKepOEHU33VE0GzQrHrD2FMskhGqi12IvtQWsA24lQAzR+fIP4VcoD2gXrTADy8ASmxN59fzfUfHfgVSKNBvGGON/BrNDW8GjDlHHvyBk8kYKao0uGRI2rX8wlIOcSW6mIDpl7sk1nrvbKGgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ODBWaKjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30867C4CEC0;
	Sat, 14 Sep 2024 13:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726322221;
	bh=ie70IUC/8eBlUGA1UDVhkaygWl6th5H5LZRStq9HwoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ODBWaKjU3Db/EBUsg9DUZokrCBEPBLWVcBqelZ+OSKTJQ/HnuBXWlp5R6jaINeQr0
	 /DvEaflTkb0KnYEDSc/wkIHjnDNXPTrog8P4E03Qw4SKAq3eDKY0OBgBnBldIZ1w6m
	 zoJJNeojlnuABi0KaNh8ldhg6eZYu1XZa8lLDj24=
Date: Sat, 14 Sep 2024 15:56:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yibin Ding <Yibin.Ding@unisoc.com>
Cc: djakov@kernel.org, rafael@kernel.org, yibin.ding01@gmail.com,
	niuzhiguo84@gmail.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hao_hao.Wang@unisoc.com,
	Ke.Wang@unisoc.com
Subject: Re: [PATCH V2 1/2] interconnect: Add character pointer initialization
Message-ID: <2024091454-shrouded-dynamite-7253@gregkh>
References: <20240914102435.3879355-1-Yibin.Ding@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914102435.3879355-1-Yibin.Ding@unisoc.com>

On Sat, Sep 14, 2024 at 06:24:35PM +0800, Yibin Ding wrote:
> From: Yibin Ding <Yibin.ding@unisoc.com>
> 
> When accessing a node whose data type is a character pointer and has not
> been initialized, a crash will occur due to accessing a null pointer. So
> it is necessary to add the operation of initializing the character pointer.
> Since the debugfs_write_file_str() function performs a kfree() operation
> on the node data, memory is allocated to the node pointer during
> initialization will be released when data is written to the node.

But if no data is ever written this ends up being a memory leak.  Please
do not fix one bug just to introduce another one.

> Signed-off-by: Yibin Ding <Yibin.ding@unisoc.com>

also, your patches are not in a series together for some reason, and
there's no information below the --- line showing what changed from the
previous version where I pointed out this very problem :(

greg k-h

