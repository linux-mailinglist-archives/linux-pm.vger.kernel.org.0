Return-Path: <linux-pm+bounces-9426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FE190C9E3
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 13:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF6C1C23105
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 11:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AB81849F4;
	Tue, 18 Jun 2024 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hzQfOA+4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E05B157E79;
	Tue, 18 Jun 2024 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708400; cv=none; b=A1mWvbSN8kh5jd2QfrjEUPXH3Ix09VTh3aaWpMXs2FiDLbJsLSoWGyj7bQQ8oByjJQtbK1d5ssvdBYy8ptk6BddMB7J7wE6HWBi8g59soF8cS8UwS372fpsBHhcGc5dIpYR1x5Kcxsp9e5m8ONp8d6CTPJksyGkMklwv1FsJjZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708400; c=relaxed/simple;
	bh=toh1i/z64bBSVjhg3KK3zm6CE9xrDZtw0KHzRXVnu+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cp85dMAtWKcVwnhTOWK7bHcgYru6o/fZyvozXAcbf+Qs2kScmah/v7qFnPaJ6V1C3PRzjUr3mqWSiBgMnI5nEAVePGAiDtbDqf/mxVZ8RmcnAWu6c+PX6GZT2ziD1+hkkYsw9tTbuaFVp9NTob75eGPJBNVUkPkJEWzExySx4bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hzQfOA+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C29C3277B;
	Tue, 18 Jun 2024 10:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718708400;
	bh=toh1i/z64bBSVjhg3KK3zm6CE9xrDZtw0KHzRXVnu+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzQfOA+4rMuxKkCZfM0/+We9rCMnk8e9Iwnmo+khhdKBCyme1fVUi+E0TNhVpBtKV
	 81CaLajY/5xj+NhtMX5SiBBebA8e/7rhIc09O74elDJScHlmipdDnRFvVrIX6BCfiE
	 VULlmu3XCsVCJfjI5BGHf6sCw4fT10ekxIvCDGm0=
Date: Tue, 18 Jun 2024 12:59:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kaiyen Chang <kaiyen.chang@intel.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] PM: Start asynchronous suspend threads upfront
Message-ID: <2024061847-anytime-passable-1ec4@gregkh>
References: <20240618093507.2143-1-kaiyen.chang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618093507.2143-1-kaiyen.chang@intel.com>

On Tue, Jun 18, 2024 at 05:35:06PM +0800, Kaiyen Chang wrote:
> *** BLURB HERE ***

No blurb?  :(

