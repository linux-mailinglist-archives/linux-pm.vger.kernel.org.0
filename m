Return-Path: <linux-pm+bounces-7763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 377038C41E4
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 15:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF301F23730
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 13:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D07152502;
	Mon, 13 May 2024 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2boD59UG"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806A615219D;
	Mon, 13 May 2024 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606845; cv=none; b=GeQI/gICTXdwUnDG1XCPf5c77dd+M0Rd9Te1iaNlodCKrxzfmA1ioO2qS3gS4QwwnNmxhemFjdss6mvTJqH1f6KZBhsXoT/99B/7fZNhNVcOijPQe0ARba3GjQEpTbGhTstAbYC6fJES2WZrQ5aw6pZKLuCWnz9kUmpn+BE1QLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606845; c=relaxed/simple;
	bh=NzaUkkwEKk0uvh872xSMbzVwhIw9xTSB4RRHlccdB6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMLtmXmOzaaTzHYANOL/GxnXVxhL9X0LqsmND3j34go0EhEP9GfpjOyf6avh7QT05rXQjfWVkQY/IGAbJoynpSTe2u87h4TEnhcRQOekWPpHTC4377c2GfkGL1h96Joap5LkAcMZd3pr7kg5O47gCB9acJsE5q5L57PRw6RnHmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2boD59UG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715606842;
	bh=NzaUkkwEKk0uvh872xSMbzVwhIw9xTSB4RRHlccdB6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2boD59UGe/8iG54XHk/8VC17Vlmeyzsp3dT9D4WF7oQwad+5xZa7pBiQHEfzBVqRF
	 WxXzbCCN5rX5EhuWYv9topeocU+Xgw0IfcxLb87B+duy1T5bLfNJmAOIfrHa4WCsIY
	 GlHcAcUBOfGUQhzPR+fbtiTNGb4BrVvvol9kSFyXeCFDfgxcZfj6CJ+fZ59iFRjCuy
	 DTrVMHE6VhLunBajekm1a9oJLjSDW9OGiFy3TMp2NQNWatGiv6f3ZApOnADtj3VgvX
	 0PSkwnxf9giLxEyKxVePXCRKkykIH16GdzHJa5sNDtp2xyqfX/MUsZAPONUaFE1t4o
	 FsMLvF8iKfPlw==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0CCB33782017;
	Mon, 13 May 2024 13:27:20 +0000 (UTC)
Date: Mon, 13 May 2024 09:27:18 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Sebastian Reichel <sre@kernel.org>, kernel@collabora.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: Re: [PATCH v3] power: supply: sbs-battery: Handle unsupported
 PROP_TIME_TO_EMPTY_NOW
Message-ID: <1db95251-04bb-4d4f-b77b-3b78a8f497cd@notapiano>
References: <20240418-sbs-time-empty-now-error-v3-1-f286e29e3fca@collabora.com>
 <cf4d8131-4b63-4c7a-9f27-5a0847c656c4@notapiano>
 <CAHc4DNJ0prAQOw89Hvw8n9KhY+8xB3D77pJvoPfU-X7ZFDYu7Q@mail.gmail.com>
 <924db470-8163-4454-8f59-f7372a132186@notapiano>
 <c721f2b9-2b08-45f3-adb5-09b163924fbc@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c721f2b9-2b08-45f3-adb5-09b163924fbc@collabora.com>

On Thu, May 09, 2024 at 05:43:42PM +0200, AngeloGioacchino Del Regno wrote:
> Il 09/05/24 17:25, Nícolas F. R. A. Prado ha scritto:
> > On Mon, Apr 22, 2024 at 04:10:23PM +0800, Hsin-Te Yuan wrote:
> > > On Sat, Apr 20, 2024 at 12:03 AM Nícolas F. R. A. Prado
> > > <nfraprado@collabora.com> wrote:
> > > > 
> > > > On Thu, Apr 18, 2024 at 01:34:23PM -0400, Nícolas F. R. A. Prado wrote:
[..]
> > 
> > Getting back on this, we were finally able to update the EC firmware for both
> > juniper and limozeen and all the issues were fixed. I have added the logs below
> > just for reference. So I guess the only change we could have upstream would be a
> > message suggesting the user to update the EC firmware in case the SBS is behind
> > the CrosEC and it starts throwing errors. I'll prepare a patch for that.
> > 
> 
> ...yes, but then you can't do that in the sbs-battery driver, but rather in the
> CrOS EC - so you'd have to link this and the other driver (beware: I'm not
> proposing to do that!), which wouldn't be the cleanest of options.

I *was* actually thinking of adding the log in the sbs driver by checking the
parent's compatible, since that's already done elsewhere in that driver to
disable PEC:

	if (of_device_is_compatible(client->dev.parent->of_node, "google,cros-ec-i2c-tunnel")

But now that you mention it, indeed if we're only printing a warning, it would
be best to do it in the EC i2c tunnel driver. And that's all that I'm proposing
to do: log a warning telling the user to update their EC firmware, as that
should fix the readouts, and not add any quirk to the driver.

Thanks,
Nícolas

> 
> Perhaps we could check "how many times *in a row, from boot*" the readout is
> failing and dynamically add the quirk with a big pr_warn().
> 
> I guess that could work but, at the same time, that's code to engineer very
> carefully, or we'd risk breaking machines that would get that reading to work,
> for example, only after a suspend-resume cycle (which is bad, yes, but still)
> or other oddities...
> 
> Any other ideas?
> 
> Cheers,
> Angelo

