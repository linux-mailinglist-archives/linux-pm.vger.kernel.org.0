Return-Path: <linux-pm+bounces-15083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 437E098E999
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 08:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C291F2641C
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 06:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9111240879;
	Thu,  3 Oct 2024 06:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2E0mPuO8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E16634;
	Thu,  3 Oct 2024 06:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727935328; cv=none; b=CcVx4JvBBiPWlsrH4jIxk6K796UolZEcQ9+LW8s7jHEkuy02sRTZxPys56Te3DX5mytmylnxbLTrnkYxjBshG3t69yDH1q9hVmveMg9uqMOaWAwALlK5Uu70+JlhSCecr1E8ghErGD1esZQG8AcJsZ+hMg2JVtOeqyAzBHPeW0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727935328; c=relaxed/simple;
	bh=+NMipWuK5WPzedo5+60s4RJ5k3Yo3bdT4wUPINMwZtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEkSRmiE30eMmHhj9lFyzU+WHpIxCmJeRI/4LoikAYoSM+cJabaYApOhbvk8IX7HN0GJwiABv59PB1lAw6+Qd4kDMPha35XDaZWOsFbB6/ZqfH+ObRKA1/qdfDYpo/8JnNxEp4tehJvek9L6UXfo6FOuDD5a8d7xTjTTRrsuq4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2E0mPuO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B72AC4CEC7;
	Thu,  3 Oct 2024 06:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727935327;
	bh=+NMipWuK5WPzedo5+60s4RJ5k3Yo3bdT4wUPINMwZtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2E0mPuO8pBvduTK1lNt5lf9nVjnwe/0rPkSHKQZqbmi1vpAlkdMXnLWCv028qKgbg
	 tIQZAlWRThm5kVsHHBg5OPPFIYVHSNxt9rFmF4/CYUQFF7gcOx6etuDp5u5sfe06Kn
	 wQV/EXCBb8xsl2M6fx2APUqFOhFTd3383uABQtvA=
Date: Thu, 3 Oct 2024 08:02:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>, Vishal Mahaveer <vishalm@ti.com>,
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PM: QoS: Export dev_pm_qos_read_value
Message-ID: <2024100333-maternity-equity-c7fa@gregkh>
References: <20241002194446.269775-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002194446.269775-1-msp@baylibre.com>

On Wed, Oct 02, 2024 at 09:44:46PM +0200, Markus Schneider-Pargmann wrote:
> Export the function dev_pm_qos_read_value(). Most other functions
> mentioned in Documentation/power/pm_qos_interface.rst are already
> exported, so export this one as well.
> 
> This function will be used to read the resume latency in a driver that
> can also be compiled as a module.

We don't add exports for no in-kernel users, sorry.  Send this as part
of a series that requires it.

> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> ---
> 
> Notes:
>     Changes in v2:
>      - Rephrase the commit message
>      - Move the patch out of the series
>        'firmware: ti_sci: Introduce system suspend support'

Odd, why did you do that?

thanks,

greg k-h

