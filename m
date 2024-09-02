Return-Path: <linux-pm+bounces-13314-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5960967F05
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 08:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22CC81C217DD
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 06:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1271F154C1D;
	Mon,  2 Sep 2024 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oIo4Qytb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F9C154C00;
	Mon,  2 Sep 2024 06:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725256812; cv=none; b=S35DaL8hVgzwpCK/F9nzPse9m5C63TbWHVScJ2eQDJC2WqPVllDQ+/K7xRyr+GZneA8/qE/sL9ReZsEFhPBudF/Vp22jDVO8SQ437/xOZiGgKEdZyO4YP2Gx+pXFATfOs5GX2fh5QEl/hvUyczQ1SuapONvqMqPQKVmf7aqOjy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725256812; c=relaxed/simple;
	bh=fkYfWMLlfk5e2VJ1eg33dBxjDkhjDPqpeRo+qkVeL00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdD2xmqwe2ZclRf0TgYYP+dPnks7T5OBhpro+KplewL1tPkRn/Z6lRBIpSIUb+nBVhwF2UzJoPrWqpFi46OUQdD3hkQ+YssBM1r67QaORT3qaK81lOSVO7cCtqiYvEqSCnevEupiON7cNfTvuDcGaFn1oJjFUZCzSiNESpb6Cp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oIo4Qytb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068CFC4CEC2;
	Mon,  2 Sep 2024 06:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725256812;
	bh=fkYfWMLlfk5e2VJ1eg33dBxjDkhjDPqpeRo+qkVeL00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIo4Qytbe/iyRXPwnfYn9skDnjW1uH6B6CMf0AAs8IycOmXcgYAcSUvYiHwbalw1H
	 AUhtuaV/nN+PkUQzRjh7p1MfLP6qgxtg1H3hhF/4euS3MgFgqgOh5EhsqK//ojDhez
	 vIaEejmsQrubCPr32jvW58gTqmg315O23VDc1lPU=
Date: Mon, 2 Sep 2024 08:00:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yenchia Chen <yenchia.chen@mediatek.com>
Cc: stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 5.15 1/1] PM: sleep: Restore asynchronous device resume
 optimization
Message-ID: <2024090250-reliably-ecard-3b58@gregkh>
References: <20240902031047.9865-1-yenchia.chen@mediatek.com>
 <20240902031047.9865-2-yenchia.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902031047.9865-2-yenchia.chen@mediatek.com>

On Mon, Sep 02, 2024 at 11:10:45AM +0800, Yenchia Chen wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Before commit 7839d0078e0d ("PM: sleep: Fix possible deadlocks in core
> system-wide PM code"), the resume of devices that were allowed to resume
> asynchronously was scheduled before starting the resume of the other
> devices, so the former did not have to wait for the latter unless
> functional dependencies were present.
> 
> Commit 7839d0078e0d removed that optimization in order to address a
> correctness issue, but it can be restored with the help of a new device
> power management flag, so do that now.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> Signed-off-by: yenchia.chen <yenchia.chen@mediatek.com>

Please sign off using your name, not your email alias.

Also, what git id is this?

thanks,

greg k-h

