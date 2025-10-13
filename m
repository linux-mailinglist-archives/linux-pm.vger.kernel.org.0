Return-Path: <linux-pm+bounces-35946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F79BD1D0C
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 09:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E8814EAD7B
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 07:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575522E1F10;
	Mon, 13 Oct 2025 07:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PabJbPSo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2159A145B3E;
	Mon, 13 Oct 2025 07:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340842; cv=none; b=LCAXuxl5nwq2W/IF6PNiB4aVatcyFb7DDmeK4NemfAWUf8CjGkgtPnoPlh8KWbLrKNK7vMfQso59kDSRuULNqvV9hPUbT9yZ7CYqvDMNbq9SgYOaxLYSQN7oPhp00BHUbZkDESoCuDgGXDJt4g9VsWpDqqrJHnxfT+G03hpTwTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340842; c=relaxed/simple;
	bh=7yV78F8cMOSvYni2E1LkAFWuImI1aDXW1ZhVxLtNRMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQ+Xq3xKlQTFkmxXtwPgZX90guJQO8zBViH75x/45jBCCjlYyODYAbFkaZLOlHBRE8v5ffvo7Vc46PxemutjNBQrW+0UAoeoUKU09kn/z1iVv0zLii1cdx8Zgvs9PkX1QDP7Sa5W4ZSUZOIELM1oNPX+w8Tf2P/HQAdS+chWI54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PabJbPSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C1EC4CEFE;
	Mon, 13 Oct 2025 07:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760340839;
	bh=7yV78F8cMOSvYni2E1LkAFWuImI1aDXW1ZhVxLtNRMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PabJbPSonzXaexcpuNWwzV1vROM5krc4piAQSkLQ1CBbSc9mnMwYr3EuKkPtwwQwo
	 X2rITrD1eMK+SwFBIvgUdAyQkXeZ8XJUzsuctyOTSF1sLbypKA5E4ecgGg/N2VLLzG
	 FvznZEPdA+Xq++I2LIN5sjX+CR/VgpPevbk3jK8M=
Date: Mon, 13 Oct 2025 09:33:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	bleung@chromium.org, akuchynski@chromium.org,
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/6] UCSI Power Supply Updates and Bug Fixes
Message-ID: <2025101316-rage-vegan-c380@gregkh>
References: <20251007000007.3724229-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007000007.3724229-1-jthies@google.com>

On Tue, Oct 07, 2025 at 12:00:01AM +0000, Jameson Thies wrote:
> This series includes the following minor changes to power supply
> handling by the UCSI driver.
> 
> 1) Adds the "Status" property to power supplies registered by the UCSI
> driver.
> 2) Reports power supply USB type as "DRP" when the port partner is a
> DRP.
> 3) Updates ucsi.c to report a power supply change all power opmode
> changes. Currently this only gets reported when opmode is PD.
> 4) Updates ucsi.c to report a power supply change when the PPM signals
> a sink path change.
> 5) Set max current to 0 when no device is connected. Currently this
> defaults to 0.1A.
> 6) Updates connector status after initiating a PR swap. Following the
> UCSI spec, there is no reported change following a successful SET_PDR
> command. This results in the stored connector status being outdated.
> 
> Abhishek Pandit-Subedi (1):
>   usb: typec: ucsi: pr_swap should check connector_status
> 
> Jameson Thies (5):
>   usb: typec: ucsi: psy: Add power supply status
>   usb: typec: ucsi: psy: Add support for DRP USB type
>   usb: typec: ucsi: Report power supply changes on power opmode changes
>   usb: typec: ucsi: Report power supply change on sink path change
>   usb: typec: ucsi: psy: Set max current to zero when disconnected

Please do not mix bug fixes and updates to the driver in the same patch
series, as that means the bug fixes will be delayed until the next
release, not the current one, as I can't take them all at once.

thanks,

greg k-h

