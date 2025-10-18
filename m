Return-Path: <linux-pm+bounces-36378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCB6BEC94E
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 09:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F5B74E34AC
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 07:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD0D285CA9;
	Sat, 18 Oct 2025 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2RlZkBuG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25051DDC1B;
	Sat, 18 Oct 2025 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760772514; cv=none; b=K7jUu5FJOEt2d9MGBfHzkfx4oiTygwdmxEzaPyEYcNPC/PcEz3c1986FJBc6jaALe6EEOjA6oEgP7s9clk9yfsokBaxZz8tGFKDf32Dy2dNkDkZ5K3bo9+STKT+oDfDkkW/AHm7LKTBf1PzHdEewd2HW2O45Yu/JUjUJLFMeGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760772514; c=relaxed/simple;
	bh=GpS9zGqd7lcQg/F5/TWJMpxLxBq4OCOjore8c7iRkTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltrJqbQTdX0WZF67dqekEXyQ/aPFt6/6llt1dCZBwzdB7HB+Cpi1XZh/1xRu6tL0FJpoU0BiujsEduqUqdLrgtrArz9PmPOoq3voqvW91G6spVxIWaWy3vne4QgPIqCrONYAXTDs4a/7w5+SwDQ0OODGI0Y8PO6RK0foEZJiy2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2RlZkBuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6507C4CEF8;
	Sat, 18 Oct 2025 07:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760772514;
	bh=GpS9zGqd7lcQg/F5/TWJMpxLxBq4OCOjore8c7iRkTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2RlZkBuGK2EsXr8GnsodI2nIke7X6wG8/ai8k1paHJ9QlpbMqQJfEc64W6jQMMwS3
	 /+LwbGTMBZrfIrkMmggac5r3hRBATHE7HIGCTxekWdqJbiCu6d4UwMB/RsKY+qGEli
	 z6y8kOIFCH3ytikEVr9xW8wEAlLtZ6o/OFFU4KyA=
Date: Sat, 18 Oct 2025 09:28:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	bleung@chromium.org, akuchynski@chromium.org,
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com,
	kenny@panix.com, linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: psy: Set max current to zero when
 disconnected
Message-ID: <2025101812-jaybird-radiantly-ec27@gregkh>
References: <20251017223053.2415243-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017223053.2415243-1-jthies@google.com>

On Fri, Oct 17, 2025 at 10:30:53PM +0000, Jameson Thies wrote:
> The ucsi_psy_get_current_max function defaults to 0.1A when it is not
> clear how much current the partner device can support. But this does
> not check the port is connected, and will report 0.1A max current when
> nothing is connected. Update ucsi_psy_get_current_max to report 0A when
> there is no connection.
> 
> v2 changes:
> - added cc stable tag to commit message

Note, as per the documentation, this needs to go below the --- line.

thanks,

greg k-h

