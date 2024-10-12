Return-Path: <linux-pm+bounces-15570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183B899B4DF
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 14:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 064E6B22431
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 12:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632D617B418;
	Sat, 12 Oct 2024 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I27g+n7h"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F6F38DF9;
	Sat, 12 Oct 2024 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728736806; cv=none; b=g7jVLVaKyBYiJ8JA3XcBc3+uvo5Ol+4tBGU+0yCRQVrtGchmGuH6a+bqcVFeVJsyqNc50pAwu+roqiDGCXS3y5QrpWkYnllpUnVIczZnaikICYkZGJS31vm+K38L1z/BdaiGgtkcEGFhCFaBmRneI3EU+dMwU2+WCfH56VOW2GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728736806; c=relaxed/simple;
	bh=0WDG6YAxGZ8cekVgxwBz/bSxZHI/433ImEpuBBO4IxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSj7wkMKfxvuJI4zOoKtTs3Sfzpzjr398PFfB4qScff/tnRDljph09hblzGk5oTkHsawLNeRJYxiGzPAIctYwheZm/k/1YYiYU1i+UCLl1s+fBopsQkEUhuFZKkwhzEIzcJoawxtuzvsSSQUBpg7Q5NHutHvp9VmqqNrDvj1i14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I27g+n7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7A8C4CEC6;
	Sat, 12 Oct 2024 12:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728736806;
	bh=0WDG6YAxGZ8cekVgxwBz/bSxZHI/433ImEpuBBO4IxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I27g+n7h21hto2z1vyZa6ZTX+T+olpSKZw7fOfwWpZLDKRLoMytOSnAumtegrd8YI
	 gWmBwk3L9LDu+LJgeJE/Z9+Vqm4jJ7FpInZCQzxPMQ58B8m9qyA2rv4xyazFifo783
	 mK95O6QStyFCuoKOExcJkumzGfF4H3FLtevTZsqg=
Date: Sat, 12 Oct 2024 14:40:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Duan Chenghao <duanchenghao@kylinos.cn>
Cc: stern@rowland.harvard.edu, rafael@kernel.org, pavel@ucw.cz,
	len.brown@intel.com, linux-usb@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	niko.mauno@vaisala.com, stanley_chang@realtek.com, tj@kernel.org,
	xiehongyu1@kylinos.cn, xy521521@gmail.com
Subject: Re: [PATCH v3] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
Message-ID: <2024101239-deprive-upstate-3275@gregkh>
References: <b8eb28f3-504d-4d26-8b02-ca1ae7309a70@rowland.harvard.edu>
 <20241012094633.126736-1-duanchenghao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012094633.126736-1-duanchenghao@kylinos.cn>

On Sat, Oct 12, 2024 at 05:46:33PM +0800, Duan Chenghao wrote:
> Co-authored-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Duan Chenghao <duanchenghao@kylinos.cn>

That's not how to use a co-authored-by tag, please read the
documentation for how to do so properly.

thanks,

greg k-h

